#pragma once

#include "skse/GameExtraData.h"
#include "skse/GameBSExtraData.h"
#include "skse/GameRTTI.h"
#include <map>



struct EnchantedWeaponEquipInfo
{
	TESObjectWEAP*		weapon;
	UInt32				weaponType;		//0=sword, 1=dagger, 2=waraxe, 3=mace, 4=greatsword, 5=battleaxe, 6=warhammer, 7=bow, 8=crossbow
	EnchantmentItem*	enchantment;
	EffectSetting*		mgef;			//costliest MGEF in the Enchantment
	UInt32				mgefIndex;		//index of MGEF in MGEFLibrary
	bool				custom;
};

struct EnchantedWeaponInfo
{
	EnchantedWeaponEquipInfo	rightHand;
	EnchantedWeaponEquipInfo	leftHand;
};

typedef std::map<Actor*, EnchantmentItem*>		EquippedEnchantMap;
typedef std::map<Actor*, EnchantedWeaponInfo>	ActorEnchantedWeaponInfo;

extern	EquippedEnchantMap			eq_map;
extern	ActorEnchantedWeaponInfo	enchantedWeapon_map;


namespace EArInternal
{

	EquipData			ResolveEquippedObject(Actor * actor, UInt32 weaponSlot, UInt32 slotMask); //0 = left hand, 1 = right. Use 0 slotmask for weapon
	EnchantmentItem*	ResolveEquippedEnchantment(BaseExtraList * extraData);
	bool				WeaponHasKeyword(TESObjectWEAP* weap, BGSKeyword* keyToCheck);
	EffectSetting*		LookupCostliestEnchantmentMGEF(EnchantmentItem* pEnch);
	UInt32				LookupCostliestEnchantmentMGEFDuration(EnchantmentItem* pEnch);
	void				SetEnchantEffects(TESObjectWEAP* pWeap, EnchantmentItem* pEnch, EnchantedWeaponEquipInfo &weaponInfo, bool bApply = true);
	void				UpdateCurrentEquipInfo(Actor* actor);
	
}