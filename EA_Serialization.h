#pragma once

#include "skse/GameData.h"
#include "skse/PluginAPI.h"
#include <vector>



//Vector used to mark invalid records during Serialization Load - this record
//list is then retrieved each game load and deleted on the papyrus side as well.
extern	std::vector<UInt32>	RemovedCustomEnchantmentsRecord;
const	UInt32				kSerializationDataVersion = 1;

struct SaveFormData
{
	char			modName[0x104];
	UInt32			formID;

	SaveFormData(UInt32 fullFormID)
	{
		formID = fullFormID & 0x00FFFFFF;

		if (formID)
		{
			UInt32 formIndex = (fullFormID & 0xFF000000) >> 24;

			DataHandler* pData = DataHandler::GetSingleton();
			ModInfo* mInfo = (pData) ? pData->modList.modInfoList.GetNthItem(formIndex) : NULL;
			strcpy_s(modName, (mInfo) ? mInfo->name : "");
		}
	}
	
	SaveFormData() { formID = 0; }
};

void WriteSaveForm(UInt32 fullFormID, SKSESerializationInterface* intfc);
void Serialization_Save(SKSESerializationInterface * intfc);
UInt32 ProcessLoadForm(SKSESerializationInterface* intfc);
UInt32 ProcessLoadInt(SKSESerializationInterface* intfc);
float ProcessLoadFloat(SKSESerializationInterface* intfc);
void Serialization_Load(SKSESerializationInterface* intfc);
void Serialization_Revert(SKSESerializationInterface * intfc);