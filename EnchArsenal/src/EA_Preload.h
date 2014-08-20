namespace EAPreload
{

	struct EAPreloadInterface
	{
		static EAPreloadInterface* GetInterface();
		void EstablishCosavePath(void* saveNameData);
		void PreloadPlugin();
		bool GetNextRecordInfo(UInt32 * type, UInt32 * version, UInt32 * length);
		UInt32 ReadRecordData(void * buf, UInt32 length);
	};

}