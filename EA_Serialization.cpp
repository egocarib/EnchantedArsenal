#include "skse/GameRTTI.h"
#include "EA_Preload.h"
#include "EA_Serialization.h"
#include "EA_EffectLib.h"
#include "EA_Internal.h"
#include "EA_Papyrus.h"
#include <vector>
#include <map>


std::vector<UInt32> RemovedCustomEnchantmentsRecord;
std::vector<Actor*> ActorsToActivateOnLoad;
struct SKSESerializationInterface;
void Serialization_Revert(SKSESerializationInterface * intfc) {/* Reserved */}


void VerifyEspIsLoaded()
{
	const char* EArName = "EnchantedArsenal.esp";
	DataHandler* pData = DataHandler::GetSingleton();
	UInt32 EArModIndex = (pData) ? pData->GetModIndex(EArName) : 0;
	if (EArModIndex >= 255)
	{
		_MESSAGE("ERROR: EnchantedArsenal.esp is not active!");
		EArDeactivated = true;
		return;
	}
}


//______________________________________________________________________________________________________________________
//==================  SAVE DATA  =======================================================================================

void WriteSaveForm(UInt32 fullFormID, SKSESerializationInterface* intfc)
{
	SaveFormData entry(fullFormID);
	intfc->WriteRecordData(&entry, sizeof(entry));
}

void Serialization_Save(SKSESerializationInterface * intfc)
{
	if (EArDeactivated)
		return;

	_MESSAGE("Saving...");

	if (!MGEFInfoLibrary.HasData())
		{ _MESSAGE("Error during save. Internal library not fully established. Mod reinstall is recommended."); return; }

	if (intfc->OpenRecord('eSha', kSerializationDataVersion))
		for (ShaderVec::iterator it = MGEFInfoLibrary._eShaders.begin(); it != MGEFInfoLibrary._eShaders.end(); ++it)
			WriteSaveForm((*it) ? (*it)->formID : 0, intfc);

	if (intfc->OpenRecord('eArt', kSerializationDataVersion))
		for (ArtVec::iterator it = MGEFInfoLibrary._eArt.begin(); it != MGEFInfoLibrary._eArt.end(); ++it)
			WriteSaveForm((*it) ? (*it)->formID : 0, intfc);

	if (intfc->OpenRecord('hSha', kSerializationDataVersion))
		for (ShaderVec::iterator it = MGEFInfoLibrary._hShaders.begin(); it != MGEFInfoLibrary._hShaders.end(); ++it)
			WriteSaveForm((*it) ? (*it)->formID : 0, intfc);

	if (intfc->OpenRecord('hArt', kSerializationDataVersion))
		for (ArtVec::iterator it = MGEFInfoLibrary._hArt.begin(); it != MGEFInfoLibrary._hArt.end(); ++it)
			WriteSaveForm((*it) ? (*it)->formID : 0, intfc);

	if (intfc->OpenRecord('proj', kSerializationDataVersion))
		for (ProjectileVec::iterator it = MGEFInfoLibrary._projectiles.begin(); it != MGEFInfoLibrary._projectiles.end(); ++it)
			WriteSaveForm((*it) ? (*it)->formID : 0, intfc);

	if (intfc->OpenRecord('impD', kSerializationDataVersion))
		for (ImpactDataVec::iterator it = MGEFInfoLibrary._impactData.begin(); it != MGEFInfoLibrary._impactData.end(); ++it)
			WriteSaveForm((*it) ? (*it)->formID : 0, intfc);

	if (intfc->OpenRecord('perF', kSerializationDataVersion))
		for (IntVec::iterator it = MGEFInfoLibrary._persistFlags.begin(); it != MGEFInfoLibrary._persistFlags.end(); ++it)
			intfc->WriteRecordData(&(*it), sizeof(*it));

	if (intfc->OpenRecord('tWei', kSerializationDataVersion))
		for (FloatVec::iterator it = MGEFInfoLibrary._tWeights.begin(); it != MGEFInfoLibrary._tWeights.end(); ++it)
			intfc->WriteRecordData(&(*it), sizeof(*it));

	if (intfc->OpenRecord('tCur', kSerializationDataVersion))
		for (FloatVec::iterator it = MGEFInfoLibrary._tCurves.begin(); it != MGEFInfoLibrary._tCurves.end(); ++it)
			intfc->WriteRecordData(&(*it), sizeof(*it));

	if (intfc->OpenRecord('tDur', kSerializationDataVersion))
		for (FloatVec::iterator it = MGEFInfoLibrary._tDurations.begin(); it != MGEFInfoLibrary._tDurations.end(); ++it)
			intfc->WriteRecordData(&(*it), sizeof(*it));

	//================= VERSION 2.0 CUSTOM ENCHANTMENTS ======================================================================
	if (customMGEFInfoLibrary._mgefForms.size() != 0)
	{
		if (intfc->OpenRecord('cMGF', kSerializationDataVersion))
			for (IntVec::iterator it = customMGEFInfoLibrary._mgefForms.begin(); it != customMGEFInfoLibrary._mgefForms.end(); ++it)
				WriteSaveForm((*it), intfc);

		if (intfc->OpenRecord('cESH', kSerializationDataVersion)) 
			for (ShaderVec::iterator it = customMGEFInfoLibrary._eShaders.begin(); it != customMGEFInfoLibrary._eShaders.end(); ++it)
				WriteSaveForm((*it) ? (*it)->formID : 0, intfc);

		if (intfc->OpenRecord('cEAR', kSerializationDataVersion))
			for (ArtVec::iterator it = customMGEFInfoLibrary._eArt.begin(); it != customMGEFInfoLibrary._eArt.end(); ++it)
				WriteSaveForm((*it) ? (*it)->formID : 0, intfc);

		if (intfc->OpenRecord('cHSH', kSerializationDataVersion))
			for (ShaderVec::iterator it = customMGEFInfoLibrary._hShaders.begin(); it != customMGEFInfoLibrary._hShaders.end(); ++it)
				WriteSaveForm((*it) ? (*it)->formID : 0, intfc);

		if (intfc->OpenRecord('cHAR', kSerializationDataVersion))
			for (ArtVec::iterator it = customMGEFInfoLibrary._hArt.begin(); it != customMGEFInfoLibrary._hArt.end(); ++it)
				WriteSaveForm((*it) ? (*it)->formID : 0, intfc);

		if (intfc->OpenRecord('cPRJ', kSerializationDataVersion))
			for (ProjectileVec::iterator it = customMGEFInfoLibrary._projectiles.begin(); it != customMGEFInfoLibrary._projectiles.end(); ++it)
				WriteSaveForm((*it) ? (*it)->formID : 0, intfc);

		if (intfc->OpenRecord('cIDS', kSerializationDataVersion))
			for (ImpactDataVec::iterator it = customMGEFInfoLibrary._impactData.begin(); it != customMGEFInfoLibrary._impactData.end(); ++it)
				WriteSaveForm((*it) ? (*it)->formID : 0, intfc);

		if (intfc->OpenRecord('cPFL', kSerializationDataVersion))
			for (IntVec::iterator it = customMGEFInfoLibrary._persistFlags.begin(); it != customMGEFInfoLibrary._persistFlags.end(); ++it)
				intfc->WriteRecordData(&(*it), sizeof(*it));

		if (intfc->OpenRecord('cTWE', kSerializationDataVersion))
			for (FloatVec::iterator it = customMGEFInfoLibrary._tWeights.begin(); it != customMGEFInfoLibrary._tWeights.end(); ++it)
				intfc->WriteRecordData(&(*it), sizeof(*it));

		if (intfc->OpenRecord('cTCU', kSerializationDataVersion))
			for (FloatVec::iterator it = customMGEFInfoLibrary._tCurves.begin(); it != customMGEFInfoLibrary._tCurves.end(); ++it)
				intfc->WriteRecordData(&(*it), sizeof(*it));

		if (intfc->OpenRecord('cTDR', kSerializationDataVersion))
			for (FloatVec::iterator it = customMGEFInfoLibrary._tDurations.begin(); it != customMGEFInfoLibrary._tDurations.end(); ++it)
				intfc->WriteRecordData(&(*it), sizeof(*it));
	}

	//Saving Current Equip Info ------->
	//Current equipped magic effect info, so that visual effects can be preloaded when this save is re-loaded in order
	//to show up correctly. Regular serialization load is too late, and preload is too early to actually retrieve this
	//equip info from the actors, so the data needs to be saved. Player info gets added last in case of enchant art
	//conflicts, it's not going to be possible to preload multiple types of art if other actors are wielding same effect.

	//Begin by gathering current actor equip info from enchantedWeapon_map
	std::vector<Actor*> activeActors;
	std::map<EffectSetting*, UInt32> activeMGEFs;
	EffectSetting* thisMGEF = NULL;
	ActorEnchantedWeaponInfo::iterator playerIt = enchantedWeapon_map.find((Actor*)(*g_thePlayer));

	for (ActorEnchantedWeaponInfo::iterator it = enchantedWeapon_map.begin(); it != enchantedWeapon_map.end(); ++it)
	{
		bool actorHasData = false;
		if (it != playerIt)
		{
			thisMGEF = it->second.leftHand.mgef;
			if (thisMGEF)
			{
				activeMGEFs[thisMGEF] = it->second.leftHand.weaponType;
				actorHasData = true;
			}
			thisMGEF = it->second.rightHand.mgef;
			if (thisMGEF)
			{
				activeMGEFs[thisMGEF] = it->second.rightHand.weaponType;
				actorHasData = true;
			}
		}
		if (actorHasData)
			activeActors.push_back(it->first);
	}

	if (playerIt != enchantedWeapon_map.end())
	{
		thisMGEF = playerIt->second.leftHand.mgef;
		if (thisMGEF)
			activeMGEFs[thisMGEF] = playerIt->second.leftHand.weaponType;
		thisMGEF = playerIt->second.rightHand.mgef;
		if (thisMGEF)
			activeMGEFs[thisMGEF] = playerIt->second.rightHand.weaponType;
		activeActors.push_back(playerIt->first);
	}

	if (activeMGEFs.size() > 0)
	{
		//Write current equipped active effect info
		if (intfc->OpenRecord('EQUP', kSerializationDataVersion))
			for (std::map<EffectSetting*, UInt32>::iterator it = activeMGEFs.begin(); it != activeMGEFs.end(); ++it)
			{
				WriteSaveForm(it->first->formID, intfc);
				intfc->WriteRecordData(&(it->second), sizeof(it->second));
			}
		//Write current actors wielding active effects
		if (intfc->OpenRecord('ACTO', kSerializationDataVersion))
			for (std::vector<Actor*>::iterator it = activeActors.begin(); it != activeActors.end(); ++it)
				WriteSaveForm((*it)->formID, intfc);
	}
}


//______________________________________________________________________________________________________________________
//==================  LOAD DATA  =======================================================================================

template <typename LoadIntfc_T>
UInt32 ProcessLoadForm(LoadIntfc_T* intfc)
{
	static char loadEntryModName[0x104] = "NULL";

	SaveFormData entry;
	UInt32 sizeRead = intfc->ReadRecordData(&entry, sizeof(SaveFormData));
	if (sizeRead == sizeof(SaveFormData))
	{
		if (!entry.formID)
			return 0;
		
		DataHandler* pData = DataHandler::GetSingleton();
		UInt32 fullFormID = (pData) ? pData->GetModIndex(entry.modName) : 0xFFFFFFFF;
		if (fullFormID >= 255)
		{
			if (strcmp(loadEntryModName, entry.modName) != 0) //If not equal (prevents log spam from missing plugin)
			{
				_MESSAGE("Error during load: expected to find mod %s, but mod is not present. %s", entry.modName, (pData) ? "" : "(DataHandler Error!)");
				strcpy_s(loadEntryModName, entry.modName);
			}
			return 0;
		}

		fullFormID = (fullFormID << 24) | entry.formID;

		return fullFormID;
	}
	else
		{ _MESSAGE("Error Reading Form From Cosave: INVALID CHUNK SIZE (%u Expected %u)", sizeRead, sizeof(SaveFormData)); return 0; }
}

template <typename LoadIntfc_T>
UInt32 ProcessLoadInt(LoadIntfc_T* intfc)
{
	UInt32 entry;
	UInt32 sizeRead = intfc->ReadRecordData(&entry, sizeof(UInt32));
	if (sizeRead == sizeof(UInt32))
		return entry;
	else
		{ _MESSAGE("Error Reading Int From Cosave: INVALID CHUNK SIZE (%u Expected %u)", sizeRead, sizeof(UInt32)); return 0; }
}

template <typename LoadIntfc_T>
float ProcessLoadFloat(LoadIntfc_T* intfc)
{
	float entry;
	UInt32 sizeRead = intfc->ReadRecordData(&entry, sizeof(float));
	if (sizeRead == sizeof(float))
		return entry;
	else
		{ _MESSAGE("Error Reading Float From Cosave: INVALID CHUNK SIZE (%u Expected %u)", sizeRead, sizeof(float)); return 0; }
}

template <typename LoadIntfc_T>
void Serialization_Preload(LoadIntfc_T* intfc)
{
	//verify EnchantedArsenal.esp is loaded
	VerifyEspIsLoaded();

	if (EArDeactivated)
		return;

	UInt32	type;
	UInt32	version;
	UInt32	lengthU;
	SInt32  length;
	bool	error = false;

	bool missingFormError = false;
	RemovedCustomEnchantmentsRecord.clear();
	ActorsToActivateOnLoad.clear();

	std::map<EffectSetting*, UInt32> preloadableMGEFs;

	bool dataLoaded = false;

	while(!error && intfc->GetNextRecordInfo(&type, &version, &lengthU))
	{
		length = (SInt32)lengthU;

		if (!dataLoaded)
		{
			dataLoaded = true;
			_MESSAGE("Loading...");
			MGEFInfoLibrary.Reset();
		}

		if (version != kSerializationDataVersion)
			{ _MESSAGE("Error Reading From Cosave: UNKNOWN DATA VERSION %u, Aborting...\n", version); error = true; }

		else if (type == 'eSha')
			for (;length > 0; length -= sizeof(SaveFormData))
			{
				TESEffectShader* thisShader = DYNAMIC_CAST(LookupFormByID(ProcessLoadForm(intfc)), TESForm, TESEffectShader);
				MGEFInfoLibrary._eShaders.push_back(thisShader);
			}

		else if (type == 'eArt')
			for (;length > 0; length -= sizeof(SaveFormData))
			{
				BGSArtObject* thisArt = DYNAMIC_CAST(LookupFormByID(ProcessLoadForm(intfc)), TESForm, BGSArtObject);
				MGEFInfoLibrary._eArt.push_back(thisArt);
			}

		else if (type == 'hSha')
			for (;length > 0; length -= sizeof(SaveFormData))
			{
				TESEffectShader* thisShader = DYNAMIC_CAST(LookupFormByID(ProcessLoadForm(intfc)), TESForm, TESEffectShader);
				MGEFInfoLibrary._hShaders.push_back(thisShader);
			}

		else if (type == 'hArt')
			for (;length > 0; length -= sizeof(SaveFormData))
			{
				BGSArtObject* thisArt = DYNAMIC_CAST(LookupFormByID(ProcessLoadForm(intfc)), TESForm, BGSArtObject);
				MGEFInfoLibrary._hArt.push_back(thisArt);
			}

		else if (type == 'proj')
			for (;length > 0; length -= sizeof(SaveFormData))
			{
				BGSProjectile* thisProj = DYNAMIC_CAST(LookupFormByID(ProcessLoadForm(intfc)), TESForm, BGSProjectile);
				MGEFInfoLibrary._projectiles.push_back(thisProj);
			}

		else if (type == 'impD')
			for (;length > 0; length -= sizeof(SaveFormData))
			{
				BGSImpactDataSet* thisImpD = DYNAMIC_CAST(LookupFormByID(ProcessLoadForm(intfc)), TESForm, BGSImpactDataSet);
				MGEFInfoLibrary._impactData.push_back(thisImpD);
			}

		else if (type == 'perF')
			for (;length > 0; length -= sizeof(UInt32))
			{
				UInt32 pf = ProcessLoadInt(intfc);
				MGEFInfoLibrary._persistFlags.push_back(pf);
				//MGEFInfoLibrary._persistFlags.push_back(ProcessLoadInt(intfc));
			}

		else if (type == 'tWei')
			for (;length > 0; length -= sizeof(float))
			{
				float tw = ProcessLoadFloat(intfc);
				MGEFInfoLibrary._tWeights.push_back(tw);
				//MGEFInfoLibrary._tWeights.push_back(ProcessLoadFloat(intfc));
			}

		else if (type == 'tCur')
			for (;length > 0; length -= sizeof(float))
				MGEFInfoLibrary._tCurves.push_back(ProcessLoadFloat(intfc));

		else if (type == 'tDur')
			for (;length > 0; length -= sizeof(float))
				MGEFInfoLibrary._tDurations.push_back(ProcessLoadFloat(intfc));

		else if (type == 'mgef')
			for (;length > 0; length -= sizeof(SaveFormData))
				UInt32 discardForm = ProcessLoadForm(intfc);
				//Here only for backwards compatibility with earliest version. Info no longer used.

	//================= VERSION 2.0 CUSTOM ENCHANTMENTS ======================================================================

		else if (type == 'cMGF')
			for (;length > 0; length -= sizeof(SaveFormData))
			{
				UInt32 mgefForm = ProcessLoadForm(intfc);
				if (!mgefForm)
					missingFormError = true;
				customMGEFInfoLibrary._mgefForms.push_back(mgefForm);
			}

		else if (type == 'cESH')
			for (;length > 0; length -= sizeof(SaveFormData))
			{
				TESEffectShader* thisShader = DYNAMIC_CAST(LookupFormByID(ProcessLoadForm(intfc)), TESForm, TESEffectShader);
				customMGEFInfoLibrary._eShaders.push_back(thisShader);
			}

		else if (type == 'cEAR')
			for (;length > 0; length -= sizeof(SaveFormData))
			{
				BGSArtObject* thisArt = DYNAMIC_CAST(LookupFormByID(ProcessLoadForm(intfc)), TESForm, BGSArtObject);
				customMGEFInfoLibrary._eArt.push_back(thisArt);
			}

		else if (type == 'cHSH')
			for (;length > 0; length -= sizeof(SaveFormData))
			{
				TESEffectShader* thisShader = DYNAMIC_CAST(LookupFormByID(ProcessLoadForm(intfc)), TESForm, TESEffectShader);
				customMGEFInfoLibrary._hShaders.push_back(thisShader);
			}

		else if (type == 'cHAR')
			for (;length > 0; length -= sizeof(SaveFormData))
			{
				BGSArtObject* thisArt = DYNAMIC_CAST(LookupFormByID(ProcessLoadForm(intfc)), TESForm, BGSArtObject);
				customMGEFInfoLibrary._hArt.push_back(thisArt);
			}

		else if (type == 'cPRJ')
			for (;length > 0; length -= sizeof(SaveFormData))
			{
				BGSProjectile* thisProj = DYNAMIC_CAST(LookupFormByID(ProcessLoadForm(intfc)), TESForm, BGSProjectile);
				customMGEFInfoLibrary._projectiles.push_back(thisProj);
			}

		else if (type == 'cIDS')
			for (;length > 0; length -= sizeof(SaveFormData))
			{
				BGSImpactDataSet* thisImpD = DYNAMIC_CAST(LookupFormByID(ProcessLoadForm(intfc)), TESForm, BGSImpactDataSet);
				customMGEFInfoLibrary._impactData.push_back(thisImpD);
			}

		else if (type == 'cPFL')
			for (;length > 0; length -= sizeof(UInt32))
			{
				UInt32 pf = ProcessLoadInt(intfc);
				customMGEFInfoLibrary._persistFlags.push_back(pf);
				//customMGEFInfoLibrary._persistFlags.push_back(ProcessLoadInt(intfc));
			}

		else if (type == 'cTWE')
			for (;length > 0; length -= sizeof(float))
			{
				float tw = ProcessLoadFloat(intfc);
				customMGEFInfoLibrary._tWeights.push_back(tw);
				//customMGEFInfoLibrary._tWeights.push_back(ProcessLoadFloat(intfc));
			}

		else if (type == 'cTCU')
			for (;length > 0; length -= sizeof(float))
				customMGEFInfoLibrary._tCurves.push_back(ProcessLoadFloat(intfc));

		else if (type == 'cTDR')
			for (;length > 0; length -= sizeof(float))
				customMGEFInfoLibrary._tDurations.push_back(ProcessLoadFloat(intfc));

		else if (type == 'EQUP')
			for (;length > 0; length -= (sizeof(SaveFormData) + sizeof(UInt32)))
			{
				EffectSetting* mgef = DYNAMIC_CAST(LookupFormByID(ProcessLoadForm(intfc)), TESForm, EffectSetting);
				UInt32 weaponType = ProcessLoadInt(intfc);
				preloadableMGEFs[mgef] = weaponType;
			}

		else if (type == 'ACTO')
			for (;length > 0; length -= sizeof(SaveFormData))
			{
				Actor* actor = DYNAMIC_CAST(LookupFormByID(ProcessLoadForm(intfc)), TESForm, Actor);
				if (actor)
					ActorsToActivateOnLoad.push_back(actor);
			}

		else
			{ _MESSAGE("Error Reading From Cosave: UNHANDLED TYPE %08X, Aborting...\n", type); error = true; }
	}


	if (!error)
		_MESSAGE("Enchantment Visual Effect Library Loaded Successfully.\n");
	else
		_MESSAGE("LOAD ERROR: There was an unexpected error during the load process.");

	if (missingFormError)
	{
		for (UInt32 i = 0; i < customMGEFInfoLibrary._mgefForms.size(); i++)
			if (customMGEFInfoLibrary._mgefForms[i] == 0)
			{
				papyrusEnchArsenal::RemoveCustomEnchantment(NULL, i);
				RemovedCustomEnchantmentsRecord.push_back(i); //Accessed from papyrus after load
				i--;
			}
	}

	if (dataLoaded)
	{
		MGEFInfoLibrary.CompleteInternalSetup();
		customMGEFInfoLibrary.CompleteInternalSetup();

		//preload any magic effects that were active during the last save
		for(std::map<EffectSetting*, UInt32>::iterator it = preloadableMGEFs.begin(); it != preloadableMGEFs.end(); ++it)
		{
			UInt32 mgefIdx = MGEFInfoLibrary.LookupMGEF(it->first);
			if (mgefIdx <= 13)
				MGEFInfoLibrary.ApplyEffects(mgefIdx, it->second);
			else
			{
				mgefIdx = customMGEFInfoLibrary.LookupMGEF(it->first);
				if (mgefIdx <= 13)
					customMGEFInfoLibrary.ApplyEffects(mgefIdx, it->second);
			}
		}
	}
}


void Serialization_Load(SKSESerializationInterface* intfc)
{
	//All I am doing during main load now is updating actor equip information for actors that had enchanted weapons
	for (std::vector<Actor*>::iterator it = ActorsToActivateOnLoad.begin(); it != ActorsToActivateOnLoad.end(); ++it)
		EArInternal::UpdateCurrentEquipInfo(*it);
}


//explicit template instantiations (allows defining templated functions outside of the header)
template UInt32	ProcessLoadForm<SKSESerializationInterface>(SKSESerializationInterface* intfc);
template UInt32	ProcessLoadForm<EAPreload::EAPreloadInterface>(EAPreload::EAPreloadInterface* intfc);
template UInt32	ProcessLoadInt<SKSESerializationInterface>(SKSESerializationInterface* intfc);
template UInt32	ProcessLoadInt<EAPreload::EAPreloadInterface>(EAPreload::EAPreloadInterface* intfc);
template float	ProcessLoadFloat<SKSESerializationInterface>(SKSESerializationInterface* intfc);
template float	ProcessLoadFloat<EAPreload::EAPreloadInterface>(EAPreload::EAPreloadInterface* intfc);
template void	Serialization_Preload<SKSESerializationInterface>(SKSESerializationInterface* intfc);
template void	Serialization_Preload<EAPreload::EAPreloadInterface>(EAPreload::EAPreloadInterface* intfc);