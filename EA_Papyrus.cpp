#include "skse/PapyrusVM.h"
#include "skse/PapyrusArgs.h"
#include "skse/PapyrusNativeFunctions.h"
#include "EA_Papyrus.h"
#include "EA_Serialization.h"
#include "EA_EffectLib.h"
#include "EA_Internal.h"



class VMClassRegistry;
struct StaticFunctionTag;


bool papyrusEnchArsenal::SetupMGEFInfoLibrary(StaticFunctionTag* base,
	VMArray<TESEffectShader*>	eShaders,
	VMArray<BGSArtObject*>		eArt,
	VMArray<TESEffectShader*>	hShaders,
	VMArray<BGSArtObject*>		hArt,
	VMArray<BGSProjectile*>		projectiles,
	VMArray<BGSImpactDataSet*>	impactData,
	VMArray<UInt32>				persistFlags,
	VMArray<float>				tWeights,
	VMArray<float>				tCurves,
	VMArray<float>				tDurations )
{
	if (MGEFInfoLibrary.HasData())
		MGEFInfoLibrary.Reset(); //reset on subsequent save loads

	return MGEFInfoLibrary.SetMainArrays(eShaders, eArt, hShaders, hArt, projectiles, impactData, persistFlags, tWeights, tCurves, tDurations);
}


bool papyrusEnchArsenal::SetupDefaultMGEFList(StaticFunctionTag* base, VMArray<EffectSetting*> mgefs) { return true; } //Depricated

//Papyrus MGEF Library Interface:
TESEffectShader*  papyrusEnchArsenal::GetLibraryEnchantShader(StaticFunctionTag* base, UInt32 idx)	{ return (idx < 126) ?  MGEFInfoLibrary.GetEnchantShader(idx) : NULL; }
BGSArtObject*     papyrusEnchArsenal::GetLibraryEnchantArt(StaticFunctionTag* base, UInt32 idx)		{ return (idx < 126) ?  MGEFInfoLibrary.GetEnchantArt(idx)    : NULL; }
TESEffectShader*  papyrusEnchArsenal::GetLibraryHitShader(StaticFunctionTag* base, UInt32 idx)		{ return (idx < 126) ?  MGEFInfoLibrary.GetHitShader(idx)     : NULL; }
BGSArtObject*     papyrusEnchArsenal::GetLibraryHitArt(StaticFunctionTag* base, UInt32 idx)			{ return (idx < 126) ?  MGEFInfoLibrary.GetHitArt(idx)        : NULL; }
BGSProjectile*    papyrusEnchArsenal::GetLibraryProjectile(StaticFunctionTag* base, UInt32 idx)		{ return (idx < 126) ?  MGEFInfoLibrary.GetProjectile(idx)    : NULL; }
BGSImpactDataSet* papyrusEnchArsenal::GetLibraryImpactData(StaticFunctionTag* base, UInt32 idx)		{ return (idx < 126) ?  MGEFInfoLibrary.GetImpactData(idx)    : NULL; }
UInt32            papyrusEnchArsenal::GetLibraryPersistFlag(StaticFunctionTag* base, UInt32 idx)	{ return (idx < 126) ?  MGEFInfoLibrary.GetPersistFlag(idx)   : 0;    }
float             papyrusEnchArsenal::GetLibraryTaperWeight(StaticFunctionTag* base, UInt32 idx)	{ return (idx < 126) ?  MGEFInfoLibrary.GetTaperWeight(idx)   : 0.0;  }
float             papyrusEnchArsenal::GetLibraryTaperCurve(StaticFunctionTag* base, UInt32 idx)		{ return (idx < 126) ?  MGEFInfoLibrary.GetTaperCurve(idx)    : 0.0;  }
float             papyrusEnchArsenal::GetLibraryTaperDuration(StaticFunctionTag* base, UInt32 idx)	{ return (idx < 126) ?  MGEFInfoLibrary.GetTaperDuration(idx) : 0.0;  }
void  papyrusEnchArsenal::SetLibraryEnchantShader(StaticFunctionTag* base, TESEffectShader* arg, UInt32 idx, UInt32 range)	{ if (idx + range <= 126)  MGEFInfoLibrary.SetEnchantShader(arg, idx, range); }
void  papyrusEnchArsenal::SetLibraryEnchantArt(StaticFunctionTag* base, BGSArtObject* arg, UInt32 idx, UInt32 range)		{ if (idx + range <= 126)  MGEFInfoLibrary.SetEnchantArt(arg, idx, range);    }
void  papyrusEnchArsenal::SetLibraryHitShader(StaticFunctionTag* base, TESEffectShader* arg, UInt32 idx, UInt32 range)		{ if (idx + range <= 126)  MGEFInfoLibrary.SetHitShader(arg, idx, range);     }
void  papyrusEnchArsenal::SetLibraryHitArt(StaticFunctionTag* base, BGSArtObject* arg, UInt32 idx, UInt32 range)			{ if (idx + range <= 126)  MGEFInfoLibrary.SetHitArt(arg, idx, range);        }
void  papyrusEnchArsenal::SetLibraryProjectile(StaticFunctionTag* base, BGSProjectile* arg, UInt32 idx, UInt32 range)		{ if (idx + range <= 126)  MGEFInfoLibrary.SetProjectile(arg, idx, range);    }
void  papyrusEnchArsenal::SetLibraryImpactData(StaticFunctionTag* base, BGSImpactDataSet* arg, UInt32 idx, UInt32 range)	{ if (idx + range <= 126)  MGEFInfoLibrary.SetImpactData(arg, idx, range);    }
void  papyrusEnchArsenal::SetLibraryPersistFlag(StaticFunctionTag* base, UInt32 arg, UInt32 idx, UInt32 range)				{ if (idx + range <= 126)  MGEFInfoLibrary.SetPersistFlag(arg, idx, range);   }
void  papyrusEnchArsenal::SetLibraryTaperWeight(StaticFunctionTag* base, float arg, UInt32 idx, UInt32 range)				{ if (idx + range <= 126)  MGEFInfoLibrary.SetTaperWeight(arg, idx, range);   }
void  papyrusEnchArsenal::SetLibraryTaperCurve(StaticFunctionTag* base, float arg, UInt32 idx, UInt32 range)				{ if (idx + range <= 126)  MGEFInfoLibrary.SetTaperCurve(arg, idx, range);    }
void  papyrusEnchArsenal::SetLibraryTaperDuration(StaticFunctionTag* base, float arg, UInt32 idx, UInt32 range)				{ if (idx + range <= 126)  MGEFInfoLibrary.SetTaperDuration(arg, idx, range); }

//Papyrus Custom MGEF Library Interface:
TESEffectShader* papyrusEnchArsenal::GetLibraryCustomEnchantShader(StaticFunctionTag* base, UInt32 idx)	{  return (idx < 126)  ?  customMGEFInfoLibrary.GetEnchantShader(idx) :  NULL;  }
void  papyrusEnchArsenal::SetLibraryCustomEnchantShader(StaticFunctionTag* base, TESEffectShader* arg, UInt32 idx, UInt32 range)	{ if (idx + range <= 126)  customMGEFInfoLibrary.SetEnchantShader(arg, idx, range); }
void  papyrusEnchArsenal::SetLibraryCustomEnchantArt(StaticFunctionTag* base, BGSArtObject* arg, UInt32 idx, UInt32 range)			{ if (idx + range <= 126)  customMGEFInfoLibrary.SetEnchantArt(arg, idx, range);    }
void  papyrusEnchArsenal::SetLibraryCustomHitShader(StaticFunctionTag* base, TESEffectShader* arg, UInt32 idx, UInt32 range)		{ if (idx + range <= 126)  customMGEFInfoLibrary.SetHitShader(arg, idx, range);     }
void  papyrusEnchArsenal::SetLibraryCustomHitArt(StaticFunctionTag* base, BGSArtObject* arg, UInt32 idx, UInt32 range)				{ if (idx + range <= 126)  customMGEFInfoLibrary.SetHitArt(arg, idx, range);        }
void  papyrusEnchArsenal::SetLibraryCustomProjectile(StaticFunctionTag* base, BGSProjectile* arg, UInt32 idx, UInt32 range)			{ if (idx + range <= 126)  customMGEFInfoLibrary.SetProjectile(arg, idx, range);    }
void  papyrusEnchArsenal::SetLibraryCustomImpactData(StaticFunctionTag* base, BGSImpactDataSet* arg, UInt32 idx, UInt32 range)		{ if (idx + range <= 126)  customMGEFInfoLibrary.SetImpactData(arg, idx, range);    }
void  papyrusEnchArsenal::SetLibraryCustomPersistFlag(StaticFunctionTag* base, UInt32 arg, UInt32 idx, UInt32 range)				{ if (idx + range <= 126)  customMGEFInfoLibrary.SetPersistFlag(arg, idx, range);   }
void  papyrusEnchArsenal::SetLibraryCustomTaperWeight(StaticFunctionTag* base, float arg, UInt32 idx, UInt32 range)					{ if (idx + range <= 126)  customMGEFInfoLibrary.SetTaperWeight(arg, idx, range);   }
void  papyrusEnchArsenal::SetLibraryCustomTaperCurve(StaticFunctionTag* base, float arg, UInt32 idx, UInt32 range)					{ if (idx + range <= 126)  customMGEFInfoLibrary.SetTaperCurve(arg, idx, range);    }
void  papyrusEnchArsenal::SetLibraryCustomTaperDuration(StaticFunctionTag* base, float arg, UInt32 idx, UInt32 range)				{ if (idx + range <= 126)  customMGEFInfoLibrary.SetTaperDuration(arg, idx, range); }


void papyrusEnchArsenal::SaveTranslateShaders(StaticFunctionTag* base, VMArray<TESEffectShader*> shaders, VMArray<UInt32> localFormID, VMArray<UInt32> bInSkyrimEsm)
{
	for (UInt32 i = 0; i < 126; i++)
	{
		TESEffectShader* esh = NULL;
		shaders.Get(&esh, i);
		UInt32 fID = (esh) ? (esh->formID) & 0x00FFFFFF : 0;
		localFormID.Set(&fID, i);
		UInt32 bVanilla = (esh && ((esh->formID & 0xFF000000) > 0)) ? 0 : 1; //  0 = from EnchantedArsenal.esp  //  1 = from Skyrim.esm
		bInSkyrimEsm.Set(&bVanilla, i);
	}
}
void papyrusEnchArsenal::SaveTranslateArt(StaticFunctionTag* base, VMArray<BGSArtObject*> artObjs, VMArray<UInt32> localFormID, VMArray<UInt32> bInSkyrimEsm)
{
	for (UInt32 i = 0; i < 126; i++)
	{
		BGSArtObject* art = NULL;
		artObjs.Get(&art, i);
		UInt32 fID = (art) ? (art->formID) & 0x00FFFFFF : 0;
		localFormID.Set(&fID, i);
		UInt32 bVanilla = (art && ((art->formID & 0xFF000000) > 0)) ? 0 : 1;
		bInSkyrimEsm.Set(&bVanilla, i);
	}
}
void papyrusEnchArsenal::SaveTranslateImpactData(StaticFunctionTag* base, VMArray<BGSImpactDataSet*> impData, VMArray<UInt32> localFormID, VMArray<UInt32> bInSkyrimEsm)
{
	for (UInt32 i = 0; i < 126; i++)
	{
		BGSImpactDataSet* ids = NULL;
		impData.Get(&ids, i);
		UInt32 fID = (ids) ? (ids->formID) & 0x00FFFFFF : 0;
		localFormID.Set(&fID, i);
		UInt32 bVanilla = (ids && ((ids->formID & 0xFF000000) > 0)) ? 0 : 1;
		bInSkyrimEsm.Set(&bVanilla, i);
	}
}
void papyrusEnchArsenal::SaveTranslateProjectiles(StaticFunctionTag* base, VMArray<BGSProjectile*> projectiles, VMArray<UInt32> localFormID, VMArray<UInt32> bInSkyrimEsm)
{
	for (UInt32 i = 0; i < 126; i++)
	{
		BGSProjectile* proj = NULL;
		projectiles.Get(&proj, i);
		UInt32 fID = (proj) ? (proj->formID) & 0x00FFFFFF : 0;
		localFormID.Set(&fID, i);
		UInt32 bVanilla = (proj && ((proj->formID & 0xFF000000) > 0)) ? 0 : 1;
		bInSkyrimEsm.Set(&bVanilla, i);
	}
}


CustomizationErrorStrings& papyrusEnchArsenal::customErrorStrs = CustomizationErrorStrings::Instance();

BSFixedString papyrusEnchArsenal::AddCustomEnchantment(StaticFunctionTag* base, VMArray<EffectSetting*> returnMGEF, VMArray<bool> returnPersistData)
{
	PlayerCharacter* pPC = *g_thePlayer;

	EquipData rightHandEquipped = EArInternal::ResolveEquippedObject(pPC, 1, 0);
	if (rightHandEquipped.pForm)
	{
		TESObjectWEAP* rightHandWeapon = DYNAMIC_CAST(rightHandEquipped.pForm, TESForm, TESObjectWEAP);
		if (rightHandWeapon)
		{
			EnchantmentItem* rightHandEnchant = rightHandWeapon->enchantable.enchantment; //Pre-enchanted?
			if (!rightHandEnchant)
				rightHandEnchant = EArInternal::ResolveEquippedEnchantment(rightHandEquipped.pExtraData); //Player-enchanted?

			if (rightHandEnchant)
			{
				EffectSetting* thisMGEF = EArInternal::LookupCostliestEnchantmentMGEF(rightHandEnchant);
				if (!thisMGEF)
					return customErrorStrs.cantprocess;

				returnMGEF.Set(&thisMGEF, 0);

				if ((MGEFInfoLibrary.LookupMGEF(thisMGEF) < 14) || customMGEFInfoLibrary.LookupMGEF(thisMGEF) < 14)
					return customErrorStrs.duplicate;

				//okay, do it! ------------------------------------------------------------------------------

				TESFullName* nameData = DYNAMIC_CAST(rightHandEnchant, EnchantmentItem, TESFullName);

				//Get Persist Info
				bool isDurational = false;
				bool isPersistent = false;
				if (EArInternal::LookupCostliestEnchantmentMGEFDuration(rightHandEnchant) > 0)
					isDurational = true;
				if ((thisMGEF->properties.flags & thisMGEF->properties.kEffectType_FXPersist) > 0)
					isPersistent = true;
				returnPersistData.Set(&isDurational, 0);
				returnPersistData.Set(&isPersistent, 1);

				//Fill In the Library with new Effect Info
				customMGEFInfoLibrary._mgefForms.push_back(thisMGEF->formID);
				for (UInt32 i = 0; i < 9; i++)
				{
					customMGEFInfoLibrary._eShaders.push_back(thisMGEF->properties.enchantShader);
					customMGEFInfoLibrary._eArt.push_back(thisMGEF->properties.enchantArt);
					customMGEFInfoLibrary._hShaders.push_back(thisMGEF->properties.hitShader);
					customMGEFInfoLibrary._hArt.push_back(thisMGEF->properties.hitEffectArt);
					customMGEFInfoLibrary._projectiles.push_back(thisMGEF->properties.projectile);
					customMGEFInfoLibrary._impactData.push_back(thisMGEF->properties.impactDataSet);
					customMGEFInfoLibrary._persistFlags.push_back((UInt32)isPersistent);
					customMGEFInfoLibrary._tWeights.push_back(thisMGEF->properties.taperWeight);
					customMGEFInfoLibrary._tCurves.push_back(thisMGEF->properties.taperCurve);
					customMGEFInfoLibrary._tDurations.push_back(thisMGEF->properties.taperDuration);
				}

				customMGEFInfoLibrary.CompleteInternalSetup();

				EArInternal::UpdateCurrentEquipInfo(*g_thePlayer);

				return (nameData) ? nameData->name : customErrorStrs.nullStr;
			}
		}
	}
	return customErrorStrs.invalid;
}

void papyrusEnchArsenal::RemoveCustomEnchantment(StaticFunctionTag* base, UInt32 index)
{
	if (index >= customMGEFInfoLibrary._mgefForms.size())
	{
		_MESSAGE("ERROR: tried to erase a custom preset from non-existent index (%u)", index);
		return;
	}

	customMGEFInfoLibrary._mgefForms.erase(customMGEFInfoLibrary._mgefForms.begin() + index);
	customMGEFInfoLibrary._eShaders.erase(customMGEFInfoLibrary._eShaders.begin() + (index * 9), customMGEFInfoLibrary._eShaders.begin() + ((index + 1) * 9));
	customMGEFInfoLibrary._eArt.erase(customMGEFInfoLibrary._eArt.begin() + (index * 9), customMGEFInfoLibrary._eArt.begin() + ((index + 1) * 9));
	customMGEFInfoLibrary._hShaders.erase(customMGEFInfoLibrary._hShaders.begin() + (index * 9), customMGEFInfoLibrary._hShaders.begin() + ((index + 1) * 9));
	customMGEFInfoLibrary._hArt.erase(customMGEFInfoLibrary._hArt.begin() + (index * 9), customMGEFInfoLibrary._hArt.begin() + ((index + 1) * 9));
	customMGEFInfoLibrary._projectiles.erase(customMGEFInfoLibrary._projectiles.begin() + (index * 9), customMGEFInfoLibrary._projectiles.begin() + ((index + 1) * 9));
	customMGEFInfoLibrary._impactData.erase(customMGEFInfoLibrary._impactData.begin() + (index * 9), customMGEFInfoLibrary._impactData.begin() + ((index + 1) * 9));
	customMGEFInfoLibrary._persistFlags.erase(customMGEFInfoLibrary._persistFlags.begin() + (index * 9), customMGEFInfoLibrary._persistFlags.begin() + ((index + 1) * 9));
	customMGEFInfoLibrary._tWeights.erase(customMGEFInfoLibrary._tWeights.begin() + (index * 9), customMGEFInfoLibrary._tWeights.begin() + ((index + 1) * 9));
	customMGEFInfoLibrary._tCurves.erase(customMGEFInfoLibrary._tCurves.begin() + (index * 9), customMGEFInfoLibrary._tCurves.begin() + ((index + 1) * 9));
	customMGEFInfoLibrary._tDurations.erase(customMGEFInfoLibrary._tDurations.begin() + (index * 9), customMGEFInfoLibrary._tDurations.begin() + ((index + 1) * 9));

	if (customMGEFInfoLibrary._mgefForms.size() == 0)
		customMGEFInfoLibrary.READY = false;
}

//Called from papyrus each game load, to update papyrus data if any ESP data was missing during load
void papyrusEnchArsenal::CheckForMissingCustomEnchantments(StaticFunctionTag* base, VMArray<UInt32> indexesToCheck)
{
	UInt32 i = 0;
	for (; i < RemovedCustomEnchantmentsRecord.size(); i++)
		indexesToCheck.Set(&RemovedCustomEnchantmentsRecord[i], i);
	UInt32 end = 0xFFFFFFFF;
	indexesToCheck.Set(&end, i);
}


void papyrusEnchArsenal::UninstallEnchArsenalPlugin(StaticFunctionTag* base, bool shouldUninstall)
{
	EArDeactivated = shouldUninstall;
}


bool papyrusEnchArsenal::RegisterFuncs(VMClassRegistry* registry)
{
	registry->RegisterFunction(
		new NativeFunction10<StaticFunctionTag, bool, VMArray<TESEffectShader*>, VMArray<BGSArtObject*>, VMArray<TESEffectShader*>, VMArray<BGSArtObject*>, VMArray<BGSProjectile*>, VMArray<BGSImpactDataSet*>, VMArray<UInt32>, VMArray<float>, VMArray<float>, VMArray<float>>("SetupMGEFInfoLibrary", "EnchArsenal", papyrusEnchArsenal::SetupMGEFInfoLibrary, registry));	
	registry->RegisterFunction(
		new NativeFunction1<StaticFunctionTag, bool, VMArray<EffectSetting*>>("SetupDefaultMGEFList", "EnchArsenal", papyrusEnchArsenal::SetupDefaultMGEFList, registry));
	registry->RegisterFunction(
		new NativeFunction1<StaticFunctionTag, void, bool>("UninstallEnchArsenalPlugin", "EnchArsenal", papyrusEnchArsenal::UninstallEnchArsenalPlugin, registry));

	registry->RegisterFunction(
		new NativeFunction1<StaticFunctionTag, TESEffectShader*, UInt32>("GetLibraryEnchantShader", "EnchArsenal", papyrusEnchArsenal::GetLibraryEnchantShader, registry));
	registry->RegisterFunction(
		new NativeFunction1<StaticFunctionTag, BGSArtObject*, UInt32>("GetLibraryEnchantArt", "EnchArsenal", papyrusEnchArsenal::GetLibraryEnchantArt, registry));
	registry->RegisterFunction(
		new NativeFunction1<StaticFunctionTag, TESEffectShader*, UInt32>("GetLibraryHitShader", "EnchArsenal", papyrusEnchArsenal::GetLibraryHitShader, registry));
	registry->RegisterFunction(
		new NativeFunction1<StaticFunctionTag, BGSArtObject*, UInt32>("GetLibraryHitArt", "EnchArsenal", papyrusEnchArsenal::GetLibraryHitArt, registry));
	registry->RegisterFunction(
		new NativeFunction1<StaticFunctionTag, BGSProjectile*, UInt32>("GetLibraryProjectile", "EnchArsenal", papyrusEnchArsenal::GetLibraryProjectile, registry));
	registry->RegisterFunction(
		new NativeFunction1<StaticFunctionTag, BGSImpactDataSet*, UInt32>("GetLibraryImpactData", "EnchArsenal", papyrusEnchArsenal::GetLibraryImpactData, registry));
	registry->RegisterFunction(
		new NativeFunction1<StaticFunctionTag, UInt32, UInt32>("GetLibraryPersistFlag", "EnchArsenal", papyrusEnchArsenal::GetLibraryPersistFlag, registry));
	registry->RegisterFunction(
		new NativeFunction1<StaticFunctionTag, float, UInt32>("GetLibraryTaperWeight", "EnchArsenal", papyrusEnchArsenal::GetLibraryTaperWeight, registry));
	registry->RegisterFunction(
		new NativeFunction1<StaticFunctionTag, float, UInt32>("GetLibraryTaperCurve", "EnchArsenal", papyrusEnchArsenal::GetLibraryTaperCurve, registry));
	registry->RegisterFunction(
		new NativeFunction1<StaticFunctionTag, float, UInt32>("GetLibraryTaperDuration", "EnchArsenal", papyrusEnchArsenal::GetLibraryTaperDuration, registry));

	registry->RegisterFunction(
		new NativeFunction1<StaticFunctionTag, TESEffectShader*, UInt32>("GetLibraryCustomEnchantShader", "EnchArsenal", papyrusEnchArsenal::GetLibraryCustomEnchantShader, registry));
	
	registry->RegisterFunction(
		new NativeFunction3<StaticFunctionTag, void, TESEffectShader*, UInt32, UInt32>("SetLibraryEnchantShader", "EnchArsenal", papyrusEnchArsenal::SetLibraryEnchantShader, registry));
	registry->RegisterFunction(
		new NativeFunction3<StaticFunctionTag, void, BGSArtObject*, UInt32, UInt32>("SetLibraryEnchantArt", "EnchArsenal", papyrusEnchArsenal::SetLibraryEnchantArt, registry));
	registry->RegisterFunction(
		new NativeFunction3<StaticFunctionTag, void, TESEffectShader*, UInt32, UInt32>("SetLibraryHitShader", "EnchArsenal", papyrusEnchArsenal::SetLibraryHitShader, registry));
	registry->RegisterFunction(
		new NativeFunction3<StaticFunctionTag, void, BGSArtObject*, UInt32, UInt32>("SetLibraryHitArt", "EnchArsenal", papyrusEnchArsenal::SetLibraryHitArt, registry));
	registry->RegisterFunction(
		new NativeFunction3<StaticFunctionTag, void, BGSProjectile*, UInt32, UInt32>("SetLibraryProjectile", "EnchArsenal", papyrusEnchArsenal::SetLibraryProjectile, registry));
	registry->RegisterFunction(
		new NativeFunction3<StaticFunctionTag, void, BGSImpactDataSet*, UInt32, UInt32>("SetLibraryImpactData", "EnchArsenal", papyrusEnchArsenal::SetLibraryImpactData, registry));
	registry->RegisterFunction(
		new NativeFunction3<StaticFunctionTag, void, UInt32, UInt32, UInt32>("SetLibraryPersistFlag", "EnchArsenal", papyrusEnchArsenal::SetLibraryPersistFlag, registry));
	registry->RegisterFunction(
		new NativeFunction3<StaticFunctionTag, void, float, UInt32, UInt32>("SetLibraryTaperWeight", "EnchArsenal", papyrusEnchArsenal::SetLibraryTaperWeight, registry));
	registry->RegisterFunction(
		new NativeFunction3<StaticFunctionTag, void, float, UInt32, UInt32>("SetLibraryTaperCurve", "EnchArsenal", papyrusEnchArsenal::SetLibraryTaperCurve, registry));
	registry->RegisterFunction(
		new NativeFunction3<StaticFunctionTag, void, float, UInt32, UInt32>("SetLibraryTaperDuration", "EnchArsenal", papyrusEnchArsenal::SetLibraryTaperDuration, registry));

	registry->RegisterFunction(
		new NativeFunction3<StaticFunctionTag, void, TESEffectShader*, UInt32, UInt32>("SetLibraryCustomEnchantShader", "EnchArsenal", papyrusEnchArsenal::SetLibraryCustomEnchantShader, registry));
	registry->RegisterFunction(
		new NativeFunction3<StaticFunctionTag, void, BGSArtObject*, UInt32, UInt32>("SetLibraryCustomEnchantArt", "EnchArsenal", papyrusEnchArsenal::SetLibraryCustomEnchantArt, registry));
	registry->RegisterFunction(
		new NativeFunction3<StaticFunctionTag, void, TESEffectShader*, UInt32, UInt32>("SetLibraryCustomHitShader", "EnchArsenal", papyrusEnchArsenal::SetLibraryCustomHitShader, registry));
	registry->RegisterFunction(
		new NativeFunction3<StaticFunctionTag, void, BGSArtObject*, UInt32, UInt32>("SetLibraryCustomHitArt", "EnchArsenal", papyrusEnchArsenal::SetLibraryCustomHitArt, registry));
	registry->RegisterFunction(
		new NativeFunction3<StaticFunctionTag, void, BGSProjectile*, UInt32, UInt32>("SetLibraryCustomProjectile", "EnchArsenal", papyrusEnchArsenal::SetLibraryCustomProjectile, registry));
	registry->RegisterFunction(
		new NativeFunction3<StaticFunctionTag, void, BGSImpactDataSet*, UInt32, UInt32>("SetLibraryCustomImpactData", "EnchArsenal", papyrusEnchArsenal::SetLibraryCustomImpactData, registry));
	registry->RegisterFunction(
		new NativeFunction3<StaticFunctionTag, void, UInt32, UInt32, UInt32>("SetLibraryCustomPersistFlag", "EnchArsenal", papyrusEnchArsenal::SetLibraryCustomPersistFlag, registry));
	registry->RegisterFunction(
		new NativeFunction3<StaticFunctionTag, void, float, UInt32, UInt32>("SetLibraryCustomTaperWeight", "EnchArsenal", papyrusEnchArsenal::SetLibraryCustomTaperWeight, registry));
	registry->RegisterFunction(
		new NativeFunction3<StaticFunctionTag, void, float, UInt32, UInt32>("SetLibraryCustomTaperCurve", "EnchArsenal", papyrusEnchArsenal::SetLibraryCustomTaperCurve, registry));
	registry->RegisterFunction(
		new NativeFunction3<StaticFunctionTag, void, float, UInt32, UInt32>("SetLibraryCustomTaperDuration", "EnchArsenal", papyrusEnchArsenal::SetLibraryCustomTaperDuration, registry));

	registry->RegisterFunction(
		new NativeFunction3<StaticFunctionTag, void, VMArray<TESEffectShader*>, VMArray<UInt32>, VMArray<UInt32>>("SaveTranslateShaders", "EnchArsenal", papyrusEnchArsenal::SaveTranslateShaders, registry));
	registry->RegisterFunction(
		new NativeFunction3<StaticFunctionTag, void, VMArray<BGSArtObject*>, VMArray<UInt32>, VMArray<UInt32>>("SaveTranslateArt", "EnchArsenal", papyrusEnchArsenal::SaveTranslateArt, registry));
	registry->RegisterFunction(
		new NativeFunction3<StaticFunctionTag, void, VMArray<BGSImpactDataSet*>, VMArray<UInt32>, VMArray<UInt32>>("SaveTranslateImpactData", "EnchArsenal", papyrusEnchArsenal::SaveTranslateImpactData, registry));
	registry->RegisterFunction(
		new NativeFunction3<StaticFunctionTag, void, VMArray<BGSProjectile*>, VMArray<UInt32>, VMArray<UInt32>>("SaveTranslateProjectiles", "EnchArsenal", papyrusEnchArsenal::SaveTranslateProjectiles, registry));

	registry->RegisterFunction(
		new NativeFunction2<StaticFunctionTag, BSFixedString, VMArray<EffectSetting*>, VMArray<bool>>("AddCustomEnchantment", "EnchArsenal", papyrusEnchArsenal::AddCustomEnchantment, registry));
	registry->RegisterFunction(
		new NativeFunction1<StaticFunctionTag, void, UInt32>("RemoveCustomEnchantment", "EnchArsenal", papyrusEnchArsenal::RemoveCustomEnchantment, registry));
	registry->RegisterFunction(
		new NativeFunction1<StaticFunctionTag, void, VMArray<UInt32>>("CheckForMissingCustomEnchantments", "EnchArsenal", papyrusEnchArsenal::CheckForMissingCustomEnchantments, registry));


	registry->SetFunctionFlags("EnchArsenal", "SetupMGEFInfoLibrary", VMClassRegistry::kFunctionFlag_NoWait);
	registry->SetFunctionFlags("EnchArsenal", "SetupDefaultMGEFList", VMClassRegistry::kFunctionFlag_NoWait);
	registry->SetFunctionFlags("EnchArsenal", "UninstallEnchArsenalPlugin", VMClassRegistry::kFunctionFlag_NoWait);

	registry->SetFunctionFlags("EnchArsenal", "GetLibraryEnchantShader", VMClassRegistry::kFunctionFlag_NoWait);
	registry->SetFunctionFlags("EnchArsenal", "GetLibraryEnchantArt", VMClassRegistry::kFunctionFlag_NoWait);
	registry->SetFunctionFlags("EnchArsenal", "GetLibraryHitShader", VMClassRegistry::kFunctionFlag_NoWait);
	registry->SetFunctionFlags("EnchArsenal", "GetLibraryHitArt", VMClassRegistry::kFunctionFlag_NoWait);
	registry->SetFunctionFlags("EnchArsenal", "GetLibraryProjectile", VMClassRegistry::kFunctionFlag_NoWait);
	registry->SetFunctionFlags("EnchArsenal", "GetLibraryImpactData", VMClassRegistry::kFunctionFlag_NoWait);
	registry->SetFunctionFlags("EnchArsenal", "GetLibraryPersistFlag", VMClassRegistry::kFunctionFlag_NoWait);
	registry->SetFunctionFlags("EnchArsenal", "GetLibraryTaperWeight", VMClassRegistry::kFunctionFlag_NoWait);
	registry->SetFunctionFlags("EnchArsenal", "GetLibraryTaperCurve", VMClassRegistry::kFunctionFlag_NoWait);
	registry->SetFunctionFlags("EnchArsenal", "GetLibraryTaperDuration", VMClassRegistry::kFunctionFlag_NoWait);

	registry->SetFunctionFlags("EnchArsenal", "GetLibraryCustomEnchantShader", VMClassRegistry::kFunctionFlag_NoWait);

	registry->SetFunctionFlags("EnchArsenal", "SetLibraryEnchantShader", VMClassRegistry::kFunctionFlag_NoWait);
	registry->SetFunctionFlags("EnchArsenal", "SetLibraryEnchantArt", VMClassRegistry::kFunctionFlag_NoWait);
	registry->SetFunctionFlags("EnchArsenal", "SetLibraryHitShader", VMClassRegistry::kFunctionFlag_NoWait);
	registry->SetFunctionFlags("EnchArsenal", "SetLibraryHitArt", VMClassRegistry::kFunctionFlag_NoWait);
	registry->SetFunctionFlags("EnchArsenal", "SetLibraryProjectile", VMClassRegistry::kFunctionFlag_NoWait);
	registry->SetFunctionFlags("EnchArsenal", "SetLibraryImpactData", VMClassRegistry::kFunctionFlag_NoWait);
	registry->SetFunctionFlags("EnchArsenal", "SetLibraryPersistFlag", VMClassRegistry::kFunctionFlag_NoWait);
	registry->SetFunctionFlags("EnchArsenal", "SetLibraryTaperWeight", VMClassRegistry::kFunctionFlag_NoWait);
	registry->SetFunctionFlags("EnchArsenal", "SetLibraryTaperCurve", VMClassRegistry::kFunctionFlag_NoWait);
	registry->SetFunctionFlags("EnchArsenal", "SetLibraryTaperDuration", VMClassRegistry::kFunctionFlag_NoWait);

	registry->SetFunctionFlags("EnchArsenal", "SetLibraryCustomEnchantShader", VMClassRegistry::kFunctionFlag_NoWait);
	registry->SetFunctionFlags("EnchArsenal", "SetLibraryCustomEnchantArt", VMClassRegistry::kFunctionFlag_NoWait);
	registry->SetFunctionFlags("EnchArsenal", "SetLibraryCustomHitShader", VMClassRegistry::kFunctionFlag_NoWait);
	registry->SetFunctionFlags("EnchArsenal", "SetLibraryCustomHitArt", VMClassRegistry::kFunctionFlag_NoWait);
	registry->SetFunctionFlags("EnchArsenal", "SetLibraryCustomProjectile", VMClassRegistry::kFunctionFlag_NoWait);
	registry->SetFunctionFlags("EnchArsenal", "SetLibraryCustomImpactData", VMClassRegistry::kFunctionFlag_NoWait);
	registry->SetFunctionFlags("EnchArsenal", "SetLibraryCustomPersistFlag", VMClassRegistry::kFunctionFlag_NoWait);
	registry->SetFunctionFlags("EnchArsenal", "SetLibraryCustomTaperWeight", VMClassRegistry::kFunctionFlag_NoWait);
	registry->SetFunctionFlags("EnchArsenal", "SetLibraryCustomTaperCurve", VMClassRegistry::kFunctionFlag_NoWait);
	registry->SetFunctionFlags("EnchArsenal", "SetLibraryCustomTaperDuration", VMClassRegistry::kFunctionFlag_NoWait);

	registry->SetFunctionFlags("EnchArsenal", "SaveTranslateShaders", VMClassRegistry::kFunctionFlag_NoWait);
	registry->SetFunctionFlags("EnchArsenal", "SaveTranslateArt", VMClassRegistry::kFunctionFlag_NoWait);
	registry->SetFunctionFlags("EnchArsenal", "SaveTranslateImpactData", VMClassRegistry::kFunctionFlag_NoWait);
	registry->SetFunctionFlags("EnchArsenal", "SaveTranslateProjectiles", VMClassRegistry::kFunctionFlag_NoWait);

	registry->SetFunctionFlags("EnchArsenal", "AddCustomEnchantment", VMClassRegistry::kFunctionFlag_NoWait);
	registry->SetFunctionFlags("EnchArsenal", "RemoveCustomEnchantment", VMClassRegistry::kFunctionFlag_NoWait);
	registry->SetFunctionFlags("EnchArsenal", "CheckForMissingCustomEnchantments", VMClassRegistry::kFunctionFlag_NoWait);

	return true;
}