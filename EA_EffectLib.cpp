#include "EA_EffectLib.h"
#include "skse/GameRTTI.h"



EAr_MGEFInfoLib MGEFInfoLibrary;
EAr_MGEFInfoLib customMGEFInfoLibrary;
bool EArDeactivated = false;

bool EAr_MGEFInfoLib::SetMainArrays(
	VMArray<TESEffectShader*>	eShaders,
	VMArray<BGSArtObject*>		eArt,
	VMArray<TESEffectShader*>	hShaders,
	VMArray<BGSArtObject*>		hArt,
	VMArray<BGSProjectile*>		projectiles,
	VMArray<BGSImpactDataSet*>	impactData,
	VMArray<UInt32>				persistFlags,
	VMArray<float>				tWeights,
	VMArray<float>				tCurves,
	VMArray<float>				tDurations)
{
	if ((eShaders.Length() < 126) ||
		(eArt.Length() < 126) ||
		(hShaders.Length() < 126) ||
		(hArt.Length() < 126) ||
		(projectiles.Length() < 126) ||
		(impactData.Length() < 126) ||
		(persistFlags.Length() < 126) ||
		(tWeights.Length() < 126) ||
		(tCurves.Length() < 126) ||
		(tDurations.Length() < 126))
		return false;

	for (UInt32 i = 0; i < 126; i++)
	{
		TESEffectShader*  pESh = NULL;
		BGSArtObject*     pEAr = NULL;
		TESEffectShader*  pHSh = NULL;
		BGSArtObject*     pHAr = NULL;
		BGSProjectile*    pPro = NULL;
		BGSImpactDataSet* pIDS = NULL;
		UInt32            flag;
		float             tWei;
		float             tCur;
		float             tDur;

		eShaders.Get		(&pESh, i);
		eArt.Get			(&pEAr, i);
		hShaders.Get		(&pHSh, i);
		hArt.Get			(&pHAr, i);
		projectiles.Get		(&pPro, i);
		impactData.Get		(&pIDS, i);
		persistFlags.Get	(&flag, i);
		tWeights.Get		(&tWei, i);
		tCurves.Get			(&tCur, i);
		tDurations.Get		(&tDur, i);

		_eShaders.push_back		(pESh);
		_eArt.push_back			(pEAr);
		_hShaders.push_back		(pHSh);
		_hArt.push_back			(pHAr);
		_projectiles.push_back	(pPro);
		_impactData.push_back	(pIDS);
		_persistFlags.push_back	(flag);
		_tWeights.push_back		(tWei);
		_tCurves.push_back		(tCur);
		_tDurations.push_back	(tDur);
	}

	battleaxeKeyword = papyrusKeyword::GetKeyword(NULL, "WeapTypeBattleaxe");
	READY = true;
	_MESSAGE("Internal effect library loaded successfully.");
	return true;
}


void EAr_MGEFInfoLib::CompleteInternalSetup()
{
	battleaxeKeyword = papyrusKeyword::GetKeyword(NULL, "WeapTypeBattleaxe");
	READY = true;
	if (CUSTOMLIB)
		_MESSAGE("User-Defined Custom Effect(s) Loaded Successfully.");
	else
		_MESSAGE("Internal effect library loaded successfully.");
}

bool EAr_MGEFInfoLib::SetDefaultMGEFs(VMArray<EffectSetting*> effects) { return true; } //Depricated

UInt32 EAr_MGEFInfoLib::LookupMGEF(EffectSetting* mgef)
{
	if (!mgef)
		return 0xFFFFFFFF;

	if (CUSTOMLIB) //version 2.0 addition
	{
		for (UInt32 i = 0; i < _mgefForms.size(); i++)
			if (_mgefForms[i] == mgef->formID)
				return i;
		return 0xFFFFFFFF;
	}

	switch(mgef->formID)
	{
		case 0x0004605A:
			return 0;
		case 0x0004605B:
			return 1;
		case 0x0004605C:
			return 2;
		case 0x0005B452:
			return 3;
		case 0x000AA155:
			return 4;
		case 0x000AA157:
			return 5;
		case 0x000AA156:
			return 6;
		case 0x0005B450:
			return 7;
		case 0x0005B44F:
			return 8;
		case 0x0005B46B:
			return 9;
		case 0x000ACBB6:
			return 10;
		case 0x000ACBB5:
			return 11;
		case 0x0005B451:
			return 12;
		case 0x0003B0B1:
			return 13;
		default:
			return 0xFFFFFFFF;
	}
}

EffectSetting* EAr_MGEFInfoLib::GetMGEFbyIndex(UInt32 mgefIdx)
{

	if (CUSTOMLIB) //version 2.0 addition
	{
		if (_mgefForms.size() <= mgefIdx)
			return NULL;

		return DYNAMIC_CAST(LookupFormByID(_mgefForms[mgefIdx]), TESForm, EffectSetting);
	}

	switch (mgefIdx)
	{
		//This isn't ideal, but I simply could not figure out the problem with the _mgefs vector,
		//it somehow was getting corrupted under certain circumstances (like after loading another
		//preset), and I can't figure out how to fix it after quite a few hours of debugging...
		case 0:
			return DYNAMIC_CAST(LookupFormByID(0x0004605A), TESForm, EffectSetting);
		case 1:
			return DYNAMIC_CAST(LookupFormByID(0x0004605B), TESForm, EffectSetting);
		case 2:
			return DYNAMIC_CAST(LookupFormByID(0x0004605C), TESForm, EffectSetting);
		case 3:
			return DYNAMIC_CAST(LookupFormByID(0x0005B452), TESForm, EffectSetting);
		case 4:
			return DYNAMIC_CAST(LookupFormByID(0x000AA155), TESForm, EffectSetting);
		case 5:
			return DYNAMIC_CAST(LookupFormByID(0x000AA157), TESForm, EffectSetting);
		case 6:
			return DYNAMIC_CAST(LookupFormByID(0x000AA156), TESForm, EffectSetting);
		case 7:
			return DYNAMIC_CAST(LookupFormByID(0x0005B450), TESForm, EffectSetting);
		case 8:
			return DYNAMIC_CAST(LookupFormByID(0x0005B44F), TESForm, EffectSetting);
		case 9:
			return DYNAMIC_CAST(LookupFormByID(0x0005B46B), TESForm, EffectSetting);
		case 10:
			return DYNAMIC_CAST(LookupFormByID(0x000ACBB6), TESForm, EffectSetting);
		case 11:
			return DYNAMIC_CAST(LookupFormByID(0x000ACBB5), TESForm, EffectSetting);
		case 12:
			return DYNAMIC_CAST(LookupFormByID(0x0005B451), TESForm, EffectSetting);
		case 13:
			return DYNAMIC_CAST(LookupFormByID(0x0003B0B1), TESForm, EffectSetting);
		default:
			return NULL;
	}
}

void EAr_MGEFInfoLib::ApplyEffects(UInt32 mgefIdx, UInt32 weapCode)
{
	if (!READY)
		return;

	_MESSAGE("debug -- ApplyEffects called. Custom == %s", CUSTOMLIB ? "TRUE" : "FALSE");

	UInt32 FXIdx = mgefIdx * 9 + weapCode;
	EffectSetting* thisMGEF = GetMGEFbyIndex(mgefIdx);

	if (!thisMGEF)
	{
		_MESSAGE("ERROR: ApplyEffects mgefIdx out of bounds.");
		return;
	}

	thisMGEF->properties.enchantShader = _eShaders[FXIdx];
	thisMGEF->properties.enchantArt    = _eArt[FXIdx];
	thisMGEF->properties.hitShader     = _hShaders[FXIdx];
	thisMGEF->properties.hitEffectArt  = _hArt[FXIdx];
	thisMGEF->properties.projectile    = _projectiles[FXIdx];
	thisMGEF->properties.impactDataSet = _impactData[FXIdx];
	if (_persistFlags[FXIdx] > 0)
		thisMGEF->properties.flags    |= thisMGEF->properties.kEffectType_FXPersist; //FXPersistFlag
	else
		thisMGEF->properties.flags    &= ~(thisMGEF->properties.kEffectType_FXPersist);
	thisMGEF->properties.taperWeight   = _tWeights[FXIdx];
	thisMGEF->properties.taperCurve    = _tCurves[FXIdx];
	thisMGEF->properties.taperDuration = _tDurations[FXIdx];
}


void EAr_MGEFInfoLib::SetEnchantShader(TESEffectShader* arg, UInt32 idx, UInt32 range)
{
	UInt32 mgefIdx = idx / 9;
	if (READY && (mgefIdx == (idx + range - 1) / 9)) //ensure we're only editing one effect across this range
	{
		EffectSetting* thisMGEF = GetMGEFbyIndex(mgefIdx);
		if (!thisMGEF)
		{
			_MESSAGE("ERROR: Attempted to set Enchant Shader on NULL effect [mgefIdx %u, idx %u, range %u, arg %08X]", mgefIdx, idx, range, (arg) ? arg->formID : 0);
			return;
		}

		thisMGEF->properties.enchantShader = arg;
		for (UInt32 i = idx; i < (idx + range); i++)
			_eShaders[i] = arg;
	}
}

void EAr_MGEFInfoLib::SetEnchantArt(BGSArtObject* arg, UInt32 idx, UInt32 range)
{
	if (READY)    for (UInt32 i = idx; i < (idx + range); i++)    _eArt[i] = arg;
	//enchant art must wait to be set during equip event (it's weapon-specific).
	//Could set it here but not really worth it. In fact, none of these effect
	//details actually need to be set on the MGEFs here, but I already wrote the
	//code so... if it ain't broke, I ain't gonna fix it.
}

void EAr_MGEFInfoLib::SetHitShader(TESEffectShader* arg, UInt32 idx, UInt32 range)
{
	UInt32 mgefIdx = idx / 9;
	if (READY && (mgefIdx == (idx + range - 1) / 9))
	{
		EffectSetting* thisMGEF = GetMGEFbyIndex(mgefIdx);
		if (!thisMGEF)
		{
			_MESSAGE("ERROR: Attempted to set Hit Shader on NULL effect [mgefIdx %u, idx %u, range %u, arg %08X]", mgefIdx, idx, range, (arg) ? arg->formID : 0);
			return;
		}

		thisMGEF->properties.hitShader = arg;
		for (UInt32 i = idx; i < (idx + range); i++)
			_hShaders[i] = arg;
	}
}

void EAr_MGEFInfoLib::SetHitArt(BGSArtObject* arg, UInt32 idx, UInt32 range)
{
	UInt32 mgefIdx = idx / 9;
	if (READY && (mgefIdx == (idx + range - 1) / 9))
	{
		EffectSetting* thisMGEF = GetMGEFbyIndex(mgefIdx);
		if (!thisMGEF)
		{
			_MESSAGE("ERROR: Attempted to set Hit Art on NULL effect [mgefIdx %u, idx %u, range %u, arg %08X]", mgefIdx, idx, range, (arg) ? arg->formID : 0);
			return;
		}

		thisMGEF->properties.hitEffectArt = arg;
		for (UInt32 i = idx; i < (idx + range); i++)
			_hArt[i] = arg;
	}
}

void EAr_MGEFInfoLib::SetProjectile(BGSProjectile* arg, UInt32 idx, UInt32 range)
{
	UInt32 mgefIdx = idx / 9;
	if (READY && (mgefIdx == (idx + range - 1) / 9))
	{
		EffectSetting* thisMGEF = GetMGEFbyIndex(mgefIdx);
		if (!thisMGEF)
		{
			_MESSAGE("ERROR: Attempted to set Projectile on NULL effect [mgefIdx %u, idx %u, range %u, arg %08X]", mgefIdx, idx, range, (arg) ? arg->formID : 0);
			return;
		}

		thisMGEF->properties.projectile = arg;
		for (UInt32 i = idx; i < (idx + range); i++)
			_projectiles[i] = arg;
	}
}

void EAr_MGEFInfoLib::SetImpactData(BGSImpactDataSet* arg, UInt32 idx, UInt32 range)
{
	UInt32 mgefIdx = idx / 9;
	if (READY && (mgefIdx == (idx + range - 1) / 9))
	{
		EffectSetting* thisMGEF = GetMGEFbyIndex(mgefIdx);
		if (!thisMGEF)
		{
			_MESSAGE("ERROR: Attempted to set IDS on NULL effect [mgefIdx %u, idx %u, range %u, arg %08X]", mgefIdx, idx, range, (arg) ? arg->formID : 0);
			return;
		}

		thisMGEF->properties.impactDataSet = arg;
		for (UInt32 i = idx; i < (idx + range); i++)
			_impactData[i] = arg;
	}
}

void EAr_MGEFInfoLib::SetPersistFlag(UInt32 arg, UInt32 idx, UInt32 range)
{
	UInt32 mgefIdx = idx / 9;
	if (READY && (mgefIdx == (idx + range - 1) / 9))
	{
		EffectSetting* thisMGEF = GetMGEFbyIndex(mgefIdx);
		if (!thisMGEF)
		{
			_MESSAGE("ERROR: Attempted to set Persist Flag on NULL effect [mgefIdx %u, idx %u, range %u, arg %u]", mgefIdx, idx, range, arg);
			return;
		}

		if (arg > 0)
			thisMGEF->properties.flags  |=  thisMGEF->properties.kEffectType_FXPersist;
		else
			thisMGEF->properties.flags  &=  ~(thisMGEF->properties.kEffectType_FXPersist);

		for (UInt32 i = idx; i < (idx + range); i++)
			_persistFlags[i] = arg;
	}
}

void EAr_MGEFInfoLib::SetTaperWeight(float arg, UInt32 idx, UInt32 range)
{
	UInt32 mgefIdx = idx / 9;
	if (READY && (mgefIdx == (idx + range - 1) / 9))
	{
		EffectSetting* thisMGEF = GetMGEFbyIndex(mgefIdx);
		if (!thisMGEF)
		{
			_MESSAGE("ERROR: Attempted to set Taper Weight on NULL effect [mgefIdx %u, idx %u, range %u, arg %g]", mgefIdx, idx, range, arg);
			return;
		}

		thisMGEF->properties.taperWeight = arg;
		for (UInt32 i = idx; i < (idx + range); i++)
			_tWeights[i] = arg;
	}
}

void EAr_MGEFInfoLib::SetTaperCurve(float arg, UInt32 idx, UInt32 range)
{
	UInt32 mgefIdx = idx / 9;
	if (READY && (mgefIdx == (idx + range - 1) / 9))
	{
		EffectSetting* thisMGEF = GetMGEFbyIndex(mgefIdx);
		if (!thisMGEF)
		{
			_MESSAGE("ERROR: Attempted to set Taper Curve on NULL effect [mgefIdx %u, idx %u, range %u, arg %g]", mgefIdx, idx, range, arg);
			return;
		}

		thisMGEF->properties.taperCurve = arg;
		for (UInt32 i = idx; i < (idx + range); i++)
			_tCurves[i] = arg;
	}
}

void EAr_MGEFInfoLib::SetTaperDuration(float arg, UInt32 idx, UInt32 range)
{
	UInt32 mgefIdx = idx / 9;
	if (READY && (mgefIdx == (idx + range - 1) / 9))
	{
		EffectSetting* thisMGEF = GetMGEFbyIndex(mgefIdx);
		if (!thisMGEF)
		{
			_MESSAGE("ERROR: Attempted to set Taper Duration on NULL effect [mgefIdx %u, idx %u, range %u, arg %g]", mgefIdx, idx, range, arg);
			return;
		}

		thisMGEF->properties.taperDuration = arg;
		for (UInt32 i = idx; i < (idx + range); i++)
			_tDurations[i] = arg;
	}
}