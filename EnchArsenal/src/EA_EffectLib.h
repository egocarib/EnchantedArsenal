#pragma once

#include "skse/PapyrusArgs.h"
#include "skse/PapyrusKeyword.h"
#include "skse/GameObjects.h"
#include <vector>



typedef std::vector<TESEffectShader*>	ShaderVec;
typedef std::vector<BGSArtObject*>		ArtVec;
typedef std::vector<BGSProjectile*>		ProjectileVec;
typedef std::vector<BGSImpactDataSet*>	ImpactDataVec;
typedef std::vector<EffectSetting*>		MGEFVec;
typedef std::vector<UInt32>				IntVec;
typedef std::vector<float>				FloatVec;


class EAr_MGEFInfoLib //Internal Enchant Effect Settings Library
{
public:
	ShaderVec			_eShaders;
	ArtVec				_eArt;
	ShaderVec			_hShaders;
	ArtVec				_hArt;
	ProjectileVec		_projectiles;
	ImpactDataVec		_impactData;
	IntVec				_persistFlags;
	FloatVec			_tWeights;
	FloatVec			_tCurves;
	FloatVec			_tDurations;
	MGEFVec				_mgefs;      //now depricated and no longer used
	IntVec				_mgefForms;   //new as of 2.0
	bool				READY;
	bool				CUSTOMLIB;    //new as of 2.0

	EAr_MGEFInfoLib() :
		_eShaders(),
		_eArt(),
		_hShaders(),
		_hArt(),
		_projectiles(),
		_impactData(),
		_persistFlags(),
		_tWeights(),
		_tCurves(),
		_tDurations(),
		_mgefs(),
		_mgefForms(),
		READY(false),
		CUSTOMLIB(false)
	{
		_eShaders.reserve(126);
		_eArt.reserve(126);
		_hShaders.reserve(126);
		_hArt.reserve(126);
		_projectiles.reserve(126);
		_impactData.reserve(126);
		_persistFlags.reserve(126);
		_tWeights.reserve(126);
		_tCurves.reserve(126);
		_tDurations.reserve(126);
		_mgefs.reserve(14);
		_mgefForms.reserve(14);
	}


	bool SetMainArrays(
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

	void Reset()
	{
		_eShaders.clear();
		_eArt.clear();
		_hShaders.clear();
		_hArt.clear();
		_projectiles.clear();
		_impactData.clear();
		_persistFlags.clear();
		_tWeights.clear();
		_tCurves.clear();
		_tDurations.clear();
		_mgefs.clear();
		_mgefForms.clear();
		READY = false;
		battleaxeKeyword = NULL;
	}

	void	CompleteInternalSetup();
	bool	HasData()  { return READY; }
	bool	SetDefaultMGEFs(VMArray<EffectSetting*> effects);
	UInt32	LookupMGEF(EffectSetting* mgef);
	EffectSetting* GetMGEFbyIndex(UInt32 mgefIdx);
	void	ApplyEffects(UInt32 mgefIdx, UInt32 weapCode);

	BGSKeyword*		battleaxeKeyword; //needed to distinguish from warhammer
	//UInt32       FXPersistFlag = 0x00001000;

	TESEffectShader*  GetEnchantShader(UInt32 idx)	{  return  READY  ?  _eShaders[idx]     : NULL;  }
	BGSArtObject*     GetEnchantArt(UInt32 idx)		{  return  READY  ?  _eArt[idx]         : NULL;  }
	TESEffectShader*  GetHitShader(UInt32 idx)		{  return  READY  ?  _hShaders[idx]     : NULL;  }
	BGSArtObject*     GetHitArt(UInt32 idx)			{  return  READY  ?  _hArt[idx]         : NULL;  }
	BGSProjectile*    GetProjectile(UInt32 idx)		{  return  READY  ?  _projectiles[idx]  : NULL;  }
	BGSImpactDataSet* GetImpactData(UInt32 idx)		{  return  READY  ?  _impactData[idx]   : NULL;  }
	UInt32            GetPersistFlag(UInt32 idx)	{  return  READY  ?  _persistFlags[idx] : 0;     }
	float             GetTaperWeight(UInt32 idx)	{  return  READY  ?  _tWeights[idx]     : 0.0;   }
	float             GetTaperCurve(UInt32 idx)		{  return  READY  ?  _tCurves[idx]      : 0.0;   }
	float             GetTaperDuration(UInt32 idx)	{  return  READY  ?  _tDurations[idx]   : 0.0;   }

	void SetEnchantShader(TESEffectShader* arg, UInt32 idx, UInt32 range);
	void SetEnchantArt(BGSArtObject* arg, UInt32 idx, UInt32 range);
	void SetHitShader(TESEffectShader* arg, UInt32 idx, UInt32 range);
	void SetHitArt(BGSArtObject* arg, UInt32 idx, UInt32 range);
	void SetProjectile(BGSProjectile* arg, UInt32 idx, UInt32 range);
	void SetImpactData(BGSImpactDataSet* arg, UInt32 idx, UInt32 range);
	void SetPersistFlag(UInt32 arg, UInt32 idx, UInt32 range);
	void SetTaperWeight(float arg, UInt32 idx, UInt32 range);
	void SetTaperCurve(float arg, UInt32 idx, UInt32 range);
	void SetTaperDuration(float arg, UInt32 idx, UInt32 range);
};



extern	bool	EArDeactivated; //True when uninstalled or when essential data is missing
extern			EAr_MGEFInfoLib MGEFInfoLibrary; //Main effect info library
extern			EAr_MGEFInfoLib customMGEFInfoLibrary; //Custom effect info library