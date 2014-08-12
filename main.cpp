#include "skse/PluginAPI.h"
#include "skse/skse_version.h"
#include <shlobj.h>


#include "EA_EffectLib.h"
#include "EA_Serialization.h"
#include "EA_Papyrus.h"
#include "EA_Internal.h"
#include "EA_Events.h"


IDebugLog					gLog;
const char*					kLogPath = "\\My Games\\Skyrim\\Logs\\EnchantedArsenal.log";
PluginHandle				g_pluginHandle = kPluginHandle_Invalid;
SKSEPapyrusInterface*		g_papyrus = NULL;
SKSEMessagingInterface*		g_messageInterface = NULL;
SKSESerializationInterface*	g_serialization = NULL;


//VMArray templates for using Get/Set (can't seem to create a single working template)
template <> void UnpackValue(VMArray<TESEffectShader*> * dst, VMValue * src)
	{ UnpackArray(dst, src, GetTypeIDFromFormTypeID(TESEffectShader::kTypeID, (*g_skyrimVM)->GetClassRegistry()) | VMValue::kType_Identifier); }

template <> void UnpackValue(VMArray<BGSArtObject*> * dst, VMValue * src)
	{ UnpackArray(dst, src, GetTypeIDFromFormTypeID(BGSArtObject::kTypeID, (*g_skyrimVM)->GetClassRegistry()) | VMValue::kType_Identifier); }

template <> void UnpackValue(VMArray<BGSProjectile*> * dst, VMValue * src)
	{ UnpackArray(dst, src, GetTypeIDFromFormTypeID(BGSProjectile::kTypeID, (*g_skyrimVM)->GetClassRegistry()) | VMValue::kType_Identifier); }

template <> void UnpackValue(VMArray<BGSImpactDataSet*> * dst, VMValue * src)
	{ UnpackArray(dst, src, GetTypeIDFromFormTypeID(BGSImpactDataSet::kTypeID, (*g_skyrimVM)->GetClassRegistry()) | VMValue::kType_Identifier); }




void InitialLoadSetup()
{
	_MESSAGE("Building Event Sinks...");

	//Retrieve the SKSEActionEvent dispatcher
	void * dispatchPtr = g_messageInterface->GetEventDispatcher(SKSEMessagingInterface::kDispatcher_ActionEvent);
	g_skseActionEventDispatcher = (EventDispatcher<SKSEActionEvent>*)dispatchPtr;

	//Add event sinks
	g_equipEventDispatcher->AddEventSink(&g_equipEventHandler);
	g_skseActionEventDispatcher->AddEventSink(&g_skseActionEventHandler);

	//Distinguish custom library from main library (version 2.0 addition)
	customMGEFInfoLibrary.CUSTOMLIB = true;
}



void SKSEMessageReceptor(SKSEMessagingInterface::Message* msg)
{
	//kMessage_InputLoaded only sent once, on initial Main Menu load
	if (msg->type != SKSEMessagingInterface::kMessage_InputLoaded)
		return;

	InitialLoadSetup();
}



extern "C"
{
	bool SKSEPlugin_Query(const SKSEInterface * skse, PluginInfo * info)
	{
		gLog.OpenRelative(CSIDL_MYDOCUMENTS, kLogPath);

		_MESSAGE("Enchanted Arsenal\nby egocarib\n\nThanks Be To: PurpleLunchBox, snakster & the SKSE team\n\n");
		_MESSAGE("Initializing...");

		//Populate info structure
		info->infoVersion	= PluginInfo::kInfoVersion;
		info->name			= "Enchanted Arsenal (by egocarib)";
		info->version		= 1;

		//Store plugin handle so we can identify ourselves later
		g_pluginHandle = skse->GetPluginHandle();

		//Runtime error checks
		if(skse->isEditor)
			{ _MESSAGE("Loaded In Editor, Marking As Incompatible"); return false; }
		else if(skse->runtimeVersion != RUNTIME_VERSION_1_9_32_0)
			{ _MESSAGE("Unsupported Runtime Version %08X", skse->runtimeVersion); return false; }

		//Get the papyrus interface and query its version
		g_papyrus = (SKSEPapyrusInterface *)skse->QueryInterface(kInterface_Papyrus);
		if(!g_papyrus)
			{ _MESSAGE("Couldn't Get Papyrus Interface"); return false; }
		if(g_papyrus->interfaceVersion < SKSEPapyrusInterface::kInterfaceVersion)
			{ _MESSAGE("Papyrus Interface Too Old (%d Expected %d)", g_papyrus->interfaceVersion, SKSEPapyrusInterface::kInterfaceVersion); return false; }

		//Get the messaging interface and query its version
		g_messageInterface = (SKSEMessagingInterface *)skse->QueryInterface(kInterface_Messaging);
		if(!g_messageInterface)
			{ _MESSAGE("Couldn't Get Messaging Interface"); return false; }
		if(g_messageInterface->interfaceVersion < SKSEMessagingInterface::kInterfaceVersion)
			{ _MESSAGE("Messaging Interface Too Old (%d Expected %d)", g_messageInterface->interfaceVersion, SKSEMessagingInterface::kInterfaceVersion); return false; }

		//Get the serialization interface and query its version
		g_serialization = (SKSESerializationInterface *)skse->QueryInterface(kInterface_Serialization);
		if(!g_serialization)
			{ _MESSAGE("Couldn't Get Serialization Interface"); return false; }
		if(g_serialization->version < SKSESerializationInterface::kVersion)
			{ _MESSAGE("Serialization Interface Too Old (%d Expected %d)", g_serialization->version, SKSESerializationInterface::kVersion); return false; }

		// all is well
		return true;
	}

	bool SKSEPlugin_Load(const SKSEInterface * skse)
	{
		_MESSAGE("Establishing interfaces...");

		//Register custom papyrus functions
		g_papyrus->Register(papyrusEnchArsenal::RegisterFuncs);

		//Register callback for SKSE messaging interface
		g_messageInterface->RegisterListener(g_pluginHandle, "SKSE", SKSEMessageReceptor);

		//Register callbacks and unique ID for serialization
		g_serialization->SetUniqueID(g_pluginHandle, 'EARS');
		g_serialization->SetRevertCallback(g_pluginHandle, Serialization_Revert);
		g_serialization->SetSaveCallback(g_pluginHandle, Serialization_Save);
		g_serialization->SetLoadCallback(g_pluginHandle, Serialization_Load);

		_MESSAGE("Plugin Initialization complete.");
		return true;
	}
};