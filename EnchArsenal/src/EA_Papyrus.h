#pragma once

#include "EA_EffectLib.h"



class CustomizationErrorStrings
{
public:
	BSFixedString invalid;
	BSFixedString duplicate;
	BSFixedString cantprocess;
	BSFixedString nullStr;

	static CustomizationErrorStrings& Instance()
	{
		static CustomizationErrorStrings instance;
		return instance;
	}

private:
	CustomizationErrorStrings() : invalid("_INVALID_"), duplicate("_DUPLICATE_"), cantprocess("_CANT_PROCESS_"), nullStr("") {}
};


namespace papyrusEnchArsenal
{
	//Papyrus Installation Interface
	bool SetupMGEFInfoLibrary(StaticFunctionTag* base,
		VMArray<TESEffectShader*>	eShaders,
		VMArray<BGSArtObject*>		eArt,
		VMArray<TESEffectShader*>	hShaders,
		VMArray<BGSArtObject*>		hArt,
		VMArray<BGSProjectile*>		projectiles,
		VMArray<BGSImpactDataSet*>	impactData,
		VMArray<UInt32>				persistFlags,
		VMArray<float>				tWeights,
		VMArray<float>				tCurves,
		VMArray<float>				tDurations);
	bool SetupDefaultMGEFList(StaticFunctionTag* base, VMArray<EffectSetting*> mgefs); //Depricated

	//Papyrus MGEF Library Interface:
	TESEffectShader*  GetLibraryEnchantShader(StaticFunctionTag* base, UInt32 idx);
	BGSArtObject*     GetLibraryEnchantArt(StaticFunctionTag* base, UInt32 idx);
	TESEffectShader*  GetLibraryHitShader(StaticFunctionTag* base, UInt32 idx);
	BGSArtObject*     GetLibraryHitArt(StaticFunctionTag* base, UInt32 idx);
	BGSProjectile*    GetLibraryProjectile(StaticFunctionTag* base, UInt32 idx);
	BGSImpactDataSet* GetLibraryImpactData(StaticFunctionTag* base, UInt32 idx);
	UInt32            GetLibraryPersistFlag(StaticFunctionTag* base, UInt32 idx);
	float             GetLibraryTaperWeight(StaticFunctionTag* base, UInt32 idx);
	float             GetLibraryTaperCurve(StaticFunctionTag* base, UInt32 idx);
	float             GetLibraryTaperDuration(StaticFunctionTag* base, UInt32 idx);
	void  SetLibraryEnchantShader(StaticFunctionTag* base, TESEffectShader* arg, UInt32 idx, UInt32 range);
	void  SetLibraryEnchantArt(StaticFunctionTag* base, BGSArtObject* arg, UInt32 idx, UInt32 range);
	void  SetLibraryHitShader(StaticFunctionTag* base, TESEffectShader* arg, UInt32 idx, UInt32 range);
	void  SetLibraryHitArt(StaticFunctionTag* base, BGSArtObject* arg, UInt32 idx, UInt32 range);
	void  SetLibraryProjectile(StaticFunctionTag* base, BGSProjectile* arg, UInt32 idx, UInt32 range);
	void  SetLibraryImpactData(StaticFunctionTag* base, BGSImpactDataSet* arg, UInt32 idx, UInt32 range);
	void  SetLibraryPersistFlag(StaticFunctionTag* base, UInt32 arg, UInt32 idx, UInt32 range);
	void  SetLibraryTaperWeight(StaticFunctionTag* base, float arg, UInt32 idx, UInt32 range);
	void  SetLibraryTaperCurve(StaticFunctionTag* base, float arg, UInt32 idx, UInt32 range);
	void  SetLibraryTaperDuration(StaticFunctionTag* base, float arg, UInt32 idx, UInt32 range);

	//Papyrus Custom MGEF Library Interface:
	TESEffectShader* GetLibraryCustomEnchantShader(StaticFunctionTag* base, UInt32 idx);
	void  SetLibraryCustomEnchantShader(StaticFunctionTag* base, TESEffectShader* arg, UInt32 idx, UInt32 range);
	void  SetLibraryCustomEnchantArt(StaticFunctionTag* base, BGSArtObject* arg, UInt32 idx, UInt32 range);
	void  SetLibraryCustomHitShader(StaticFunctionTag* base, TESEffectShader* arg, UInt32 idx, UInt32 range);
	void  SetLibraryCustomHitArt(StaticFunctionTag* base, BGSArtObject* arg, UInt32 idx, UInt32 range);
	void  SetLibraryCustomProjectile(StaticFunctionTag* base, BGSProjectile* arg, UInt32 idx, UInt32 range);
	void  SetLibraryCustomImpactData(StaticFunctionTag* base, BGSImpactDataSet* arg, UInt32 idx, UInt32 range);
	void  SetLibraryCustomPersistFlag(StaticFunctionTag* base, UInt32 arg, UInt32 idx, UInt32 range);
	void  SetLibraryCustomTaperWeight(StaticFunctionTag* base, float arg, UInt32 idx, UInt32 range);
	void  SetLibraryCustomTaperCurve(StaticFunctionTag* base, float arg, UInt32 idx, UInt32 range);
	void  SetLibraryCustomTaperDuration(StaticFunctionTag* base, float arg, UInt32 idx, UInt32 range);

	//Papyrus FISS Save Interface
	void SaveTranslateShaders(StaticFunctionTag* base, VMArray<TESEffectShader*> shaders, VMArray<UInt32> localFormID, VMArray<UInt32> bInSkyrimEsm);
	void SaveTranslateArt(StaticFunctionTag* base, VMArray<BGSArtObject*> artObjs, VMArray<UInt32> localFormID, VMArray<UInt32> bInSkyrimEsm);
	void SaveTranslateImpactData(StaticFunctionTag* base, VMArray<BGSImpactDataSet*> impData, VMArray<UInt32> localFormID, VMArray<UInt32> bInSkyrimEsm);
	void SaveTranslateProjectiles(StaticFunctionTag* base, VMArray<BGSProjectile*> projectiles, VMArray<UInt32> localFormID, VMArray<UInt32> bInSkyrimEsm);

	//Papyrus Customization Interface
	extern			CustomizationErrorStrings& customErrorStrs;
	BSFixedString	AddCustomEnchantment(StaticFunctionTag* base, VMArray<EffectSetting*> returnMGEF, VMArray<bool> returnPersistData);
	void			RemoveCustomEnchantment(StaticFunctionTag* base, UInt32 index);
	void			CheckForMissingCustomEnchantments(StaticFunctionTag* base, VMArray<UInt32> indexesToCheck);
	void			AssertCurrentCustomData(StaticFunctionTag* base, VMArray<EffectSetting*> currentMGEFs);

	//Papyrus Uninstallation Interface
	void UninstallEnchArsenalPlugin(StaticFunctionTag* base, bool shouldUninstall);

	//Papyrus Internal Registration
	bool RegisterFuncs(VMClassRegistry* registry);
}