#include "EA_Internal.h"
#include "EA_EffectLib.h"


//Equipment methods adapted from skse\PapyrusWornObject.cpp (thanks SKSE team!)

EquippedEnchantMap			eq_map;
ActorEnchantedWeaponInfo	enchantedWeapon_map;

class MatchByEquipSlot : public FormMatcher
{
	UInt32 m_mask;
	UInt32 m_hand;
	Actor * m_actor;
public:
	MatchByEquipSlot(Actor * actor, UInt32 hand, UInt32 slot) : 
	  m_hand(hand),
	  m_mask(slot),
	  m_actor(actor)
	  {

	  }

	  enum
	  {
		  kSlotID_Left = 0,
		  kSlotID_Right
	  };

	  bool Matches(TESForm* pForm) const {
		  if (pForm) {
			  if(pForm->formType != TESObjectWEAP::kTypeID) { // If not a weapon use mask
				  BGSBipedObjectForm* pBip = DYNAMIC_CAST(pForm, TESForm, BGSBipedObjectForm);
				  if (pBip)
					  return (pBip->data.parts & m_mask) != 0;
			  } else if(m_mask == 0) { // Use hand if no mask specified
				  TESForm * equippedForm = m_actor->GetEquippedObject(m_hand == kSlotID_Left);
				  return (equippedForm && equippedForm == pForm);
			  }
		  }
		  return false;
	  }
};

//0 = left hand, 1 = right. Use 0 slotmask for weapon
EquipData EArInternal::ResolveEquippedObject(Actor * actor, UInt32 weaponSlot, UInt32 slotMask)
{
	EquipData foundData;
	foundData.pForm = NULL;
	foundData.pExtraData = NULL;
	if(!actor)
		return foundData;

	MatchByEquipSlot matcher(actor, weaponSlot, slotMask);
	ExtraContainerChanges* pContainerChanges = static_cast<ExtraContainerChanges*>(actor->extraData.GetByType(kExtraData_ContainerChanges));
	if (pContainerChanges) {
		foundData = pContainerChanges->FindEquipped(matcher, weaponSlot == MatchByEquipSlot::kSlotID_Right || slotMask != 0, weaponSlot == MatchByEquipSlot::kSlotID_Left);
		return foundData;
	}

	return foundData;
}

EnchantmentItem* EArInternal::ResolveEquippedEnchantment(BaseExtraList * extraData)
{
	if (!extraData)
		return NULL;
	ExtraEnchantment* extraEnchant = static_cast<ExtraEnchantment*>(extraData->GetByType(kExtraData_Enchantment));
	return extraEnchant ? extraEnchant->enchant : NULL;
}




bool EArInternal::WeaponHasKeyword(TESObjectWEAP* weap, BGSKeyword* keyToCheck)
{
	BGSKeywordForm* keys = &weap->keyword;
	for(UInt32 i = 0; i < keys->numKeywords; i++)
		if (keys->keywords[i] == keyToCheck)
			return true;

	return false;
}

EffectSetting* EArInternal::LookupCostliestEnchantmentMGEF(EnchantmentItem* pEnch)
{
	MagicItem::EffectItem* pEI = CALL_MEMBER_FN(pEnch, GetCostliestEffectItem)(5, false);
	if (!pEI)
	{
		_MESSAGE("ERROR: Unable to retrieve costliest effect info.");
		return NULL;
	}

	return pEI->mgef;
}

UInt32 EArInternal::LookupCostliestEnchantmentMGEFDuration(EnchantmentItem* pEnch)
{
	MagicItem::EffectItem* pEI = CALL_MEMBER_FN(pEnch, GetCostliestEffectItem)(5, false);
	return (pEI) ? pEI->duration : 0;
}

void EArInternal::SetEnchantEffects(TESObjectWEAP* pWeap, EnchantmentItem* pEnch, EnchantedWeaponEquipInfo &weaponInfo, bool bApply)
{
	weaponInfo.weapon = NULL;
	weaponInfo.enchantment = NULL;
	weaponInfo.mgef = NULL;
	weaponInfo.weaponType = 0;
	weaponInfo.mgefIndex = 0;
	weaponInfo.custom = false;

	EffectSetting* thisMGEF = LookupCostliestEnchantmentMGEF(pEnch);
	UInt32 mgefIdx = MGEFInfoLibrary.LookupMGEF(thisMGEF);
	if (mgefIdx > 13) // || weapType == 0 || weapType == 8) //these weapTypes shouldn't really be possible if mgefIdx is valid
	{
		mgefIdx = customMGEFInfoLibrary.LookupMGEF(thisMGEF);
		if (mgefIdx > 13)
			return;
		weaponInfo.custom = true;
	}

	UInt32 weapType = (pWeap) ? pWeap->type() : 1;
	//adjust weapType into the indexical value needed for library:
	if (weapType < 6 || weapType == 9 || (weapType == 6 && WeaponHasKeyword(pWeap, MGEFInfoLibrary.battleaxeKeyword)))
		weapType -= 1;
		//this will result in: 0=sword, 1=dagger, 2=waraxe, 3=mace, 4=greatsword, 5=battleaxe, 6=warhammer, 7=bow, 8=crossbow

	if (bApply)
	{
		if (weaponInfo.custom)
			customMGEFInfoLibrary.ApplyEffects(mgefIdx, weapType);
		else
			MGEFInfoLibrary.ApplyEffects(mgefIdx, weapType);
	}
	
	weaponInfo.weapon = pWeap;
	weaponInfo.weaponType = weapType;
	weaponInfo.enchantment = pEnch;
	weaponInfo.mgef = thisMGEF;
	weaponInfo.mgefIndex = mgefIdx;

	return;
}


void EArInternal::UpdateCurrentEquipInfo(Actor* actor)
{
	enchantedWeapon_map[actor].rightHand.weapon = NULL;
	enchantedWeapon_map[actor].rightHand.enchantment = NULL;
	enchantedWeapon_map[actor].rightHand.mgef = NULL;
	enchantedWeapon_map[actor].rightHand.weaponType = 0;
	enchantedWeapon_map[actor].rightHand.mgefIndex = 0;
	enchantedWeapon_map[actor].rightHand.custom = false;
	enchantedWeapon_map[actor].leftHand.weapon = NULL;
	enchantedWeapon_map[actor].leftHand.enchantment = NULL;
	enchantedWeapon_map[actor].leftHand.mgef = NULL;
	enchantedWeapon_map[actor].leftHand.weaponType = 0;
	enchantedWeapon_map[actor].leftHand.mgefIndex = 0; //scrub any old data
	enchantedWeapon_map[actor].leftHand.custom = false;

	//Right hand
	EquipData rightHandEquipped = ResolveEquippedObject(actor, 1, 0);
	if (rightHandEquipped.pForm)
	{
		TESObjectWEAP* rightHandWeapon = DYNAMIC_CAST(rightHandEquipped.pForm, TESForm, TESObjectWEAP);
		if (rightHandWeapon)
		{
			EnchantmentItem* rightHandEnchant = rightHandWeapon->enchantable.enchantment; //Pre-enchanted?
			if (!rightHandEnchant)
				rightHandEnchant = ResolveEquippedEnchantment(rightHandEquipped.pExtraData); //Player-enchanted?

			if (rightHandEnchant)
				EArInternal::SetEnchantEffects(rightHandWeapon, rightHandEnchant, enchantedWeapon_map[actor].rightHand);
		}
	}

	if (enchantedWeapon_map[actor].rightHand.weaponType < 4) //If two-handed weapon, skip left hand check
	{
		//Left hand
		EquipData leftHandEquipped = ResolveEquippedObject(actor, 0, 0);
		if (leftHandEquipped.pForm)
		{
			TESObjectWEAP* leftHandWeapon = DYNAMIC_CAST(leftHandEquipped.pForm, TESForm, TESObjectWEAP);
			if (leftHandWeapon)
			{
				EnchantmentItem* leftHandEnchant = leftHandWeapon->enchantable.enchantment; //Pre-enchanted?
				if (!leftHandEnchant)
					leftHandEnchant = ResolveEquippedEnchantment(leftHandEquipped.pExtraData); //Player-enchanted?

				if (leftHandEnchant)
					EArInternal::SetEnchantEffects(leftHandWeapon, leftHandEnchant, enchantedWeapon_map[actor].leftHand);
			}
		}
	}

}