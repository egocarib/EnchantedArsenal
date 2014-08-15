#include "common/IFileStream.h"
#include "skse/PluginAPI.h"
#include "skse/GameAPI.h"
#include "skse/GameData.h"
#include "skse/GameSettings.h"
#include "EA_Preload.h"
#include "EA_Serialization.h"
#include <shlobj.h>



//Much of this file is adapted from skse/Serialization.cpp (thanks SKSE team!)
namespace EAPreload
{

	EAPreloadInterface s_EAPreloadInterface;


	struct Header
	{
		enum
		{
			kSignature =		MACRO_SWAP32('SKSE'),	// endian-swapping so the order matches
			kVersion =			1,
			kVersion_Invalid =	0
		};

		UInt32	signature;
		UInt32	formatVersion;
		UInt32	skseVersion;
		UInt32	runtimeVersion;
		UInt32	numPlugins;
	};

	struct PluginHeader
	{
		UInt32	signature;
		UInt32	numChunks;
		UInt32	length;		// length of following plugin data including ChunkHeader(s)
	};

	struct ChunkHeader
	{
		UInt32	type;
		UInt32	version;
		UInt32	length;
	};


	std::string		s_cosavePath;
	IFileStream		s_currentFile;
	PluginHeader	s_pluginHeader = {0};
	bool			s_chunkOpen = false;
	ChunkHeader		s_chunkHeader = {0};


	EAPreloadInterface* EAPreloadInterface::GetInterface()
	{
		return &s_EAPreloadInterface;
	}

	void EAPreloadInterface::EstablishCosavePath(void* saveNameData)
	{
		//Get current save path
		char path[MAX_PATH];
		ASSERT(SUCCEEDED(SHGetFolderPath(NULL, CSIDL_MYDOCUMENTS, NULL, SHGFP_TYPE_CURRENT, path)));

		//Construct save name string
		const char*	charData = (const char*)(saveNameData);
		std::string cosaveName(charData);
		cosaveName += ".skse";

		//Construct full filepath
		std::string	fullSavePath = path;
		fullSavePath += "\\My Games\\Skyrim\\";
		Setting* localSavePath = GetINISetting("sLocalSavePath:General");
		if(localSavePath && (localSavePath->GetType() == Setting::kType_String))
			fullSavePath += localSavePath->data.s;
		else
			fullSavePath += "Saves\\";
		fullSavePath += "\\";
		fullSavePath += cosaveName;

		s_cosavePath = fullSavePath;
	}


	static void FlushReadRecord(void)
	{
		if(s_chunkOpen)
		{
			if(s_chunkHeader.length)
			{
				_MESSAGE("WARNING: preload didn't finish reading cosave chunk");
				s_currentFile.Skip(s_chunkHeader.length);
			}
			s_chunkOpen = false;
		}
	}

	bool EAPreloadInterface::GetNextRecordInfo(UInt32 * type, UInt32 * version, UInt32 * length)
	{
		FlushReadRecord();

		if(!s_pluginHeader.numChunks)
			return false;

		s_pluginHeader.numChunks--;

		s_currentFile.ReadBuf(&s_chunkHeader, sizeof(s_chunkHeader));

		*type =		s_chunkHeader.type;
		*version =	s_chunkHeader.version;
		*length =	s_chunkHeader.length;

		s_chunkOpen = true;

		return true;
	}

	UInt32 EAPreloadInterface::ReadRecordData(void * buf, UInt32 length)
	{
		ASSERT(s_chunkOpen);

		if(length > s_chunkHeader.length)
			length = s_chunkHeader.length;

		s_currentFile.ReadBuf(buf, length);

		s_chunkHeader.length -= length;

		return length;
	}


	void ProcessPlugin()
	{
		UInt64 pluginChunkStart = s_currentFile.GetOffset();

		Serialization_Preload(&s_EAPreloadInterface);

		UInt64 expectedOffset = pluginChunkStart + s_pluginHeader.length;
		if(s_currentFile.GetOffset() != expectedOffset)
			_MESSAGE("WARNING: Preload did not read all cosave data (at %016I64X expected %016I64X)", s_currentFile.GetOffset(), expectedOffset);

		s_currentFile.Close();
	}

	void EAPreloadInterface::PreloadPlugin()
	{
		if(!s_currentFile.Open(s_cosavePath.c_str()))
		{
			_MESSAGE("ERROR: Failed to access cosave during preload.");
			return;
		}

		try
		{
			Header header;
			s_currentFile.ReadBuf(&header, sizeof(header));

			if(header.signature != Header::kSignature || header.formatVersion <= Header::kVersion_Invalid || header.formatVersion > Header::kVersion)
			{
				_ERROR("ERROR: Invalid header encountered during preload (signature %08X expected %08X, version %08X expected %08X)", header.signature, Header::kSignature, header.formatVersion, Header::kVersion);
				s_currentFile.Close();
				return;
			}

			while (s_currentFile.GetRemain() >= sizeof(PluginHeader))
			{
				s_currentFile.ReadBuf(&s_pluginHeader, sizeof(s_pluginHeader));

				//Enchanted Arsenal uID
				if (s_pluginHeader.signature == 'EARS')
				{
					s_chunkOpen = false;
					ProcessPlugin();
					return;
				}

				s_currentFile.Skip(s_pluginHeader.length);
			}
			_MESSAGE("No previously saved data found.");
		}
		catch(...)
		{
			_ERROR("ERROR: exception encountered during preload.");
		}

		s_currentFile.Close();
	}

}