#include "EA_Events.h"
#include "EA_EffectLib.h"
#include "EA_Internal.h"



EventDispatcher<TESEquipEvent>*		g_equipEventDispatcher = (EventDispatcher<TESEquipEvent>*) 0x012E4EA0;
TESEquipEventHandler				g_equipEventHandler;

EventDispatcher<SKSEActionEvent>*	g_skseActionEventDispatcher;
LocalActionEventHandler				g_skseActionEventHandler;

EventResult TESEquipEventHandler::ReceiveEvent(TESEquipEvent * evn, EventDispatcher<TESEquipEvent> * dispatcher)
{
	static bool isEquippingEnchantment = false;

	TESForm* eqForm = LookupFormByID(evn->equippedFormID);

	if (!isEquippingEnchantment)
	{
		EnchantmentItem* eqEnch = DYNAMIC_CAST(eqForm, TESForm, EnchantmentItem);
		if (eqEnch)
		{
			eq_map[evn->actor] = eqEnch;	//Map enchantment to actor
			isEquippingEnchantment = true;
			return kEvent_Continue;			//Wait for weapon equip event to come next
		}
	}

	else //Enchantment equip event was just received
	{
		TESObjectWEAP* eqWeap = DYNAMIC_CAST(eqForm, TESForm, TESObjectWEAP);
		if (eqWeap)
		{
			EquippedEnchantMap::iterator it = eq_map.find(evn->actor);
			EquippedEnchantMap::iterator itEnd = eq_map.end();
			if (it != itEnd)
			{
				eq_map.erase(it);
				EArInternal::UpdateCurrentEquipInfo(evn->actor);
			}
		}
		isEquippingEnchantment = false;
	}

	return kEvent_Continue;
}

EventResult LocalActionEventHandler::ReceiveEvent(SKSEActionEvent * evn, EventDispatcher<SKSEActionEvent> * dispatcher)
{
	if (evn && (evn->type == 7)) // unsheathe begin
	{
		if (!evn->actor)
			return kEvent_Continue;

		if (enchantedWeapon_map.find(evn->actor) == enchantedWeapon_map.end()) //no current record of this actor's equipment
		{
			EArInternal::UpdateCurrentEquipInfo(evn->actor);
		}

		else
		{
			if (enchantedWeapon_map[evn->actor].rightHand.enchantment)
			{
				if (enchantedWeapon_map[evn->actor].rightHand.custom)
					customMGEFInfoLibrary.ApplyEffects(enchantedWeapon_map[evn->actor].rightHand.mgefIndex, enchantedWeapon_map[evn->actor].rightHand.weaponType);
				else
					MGEFInfoLibrary.ApplyEffects(enchantedWeapon_map[evn->actor].rightHand.mgefIndex, enchantedWeapon_map[evn->actor].rightHand.weaponType);
			}

			if (enchantedWeapon_map[evn->actor].leftHand.enchantment)
			{
				if (enchantedWeapon_map[evn->actor].leftHand.custom)
					customMGEFInfoLibrary.ApplyEffects(enchantedWeapon_map[evn->actor].leftHand.mgefIndex, enchantedWeapon_map[evn->actor].leftHand.weaponType);
				else
					MGEFInfoLibrary.ApplyEffects(enchantedWeapon_map[evn->actor].leftHand.mgefIndex, enchantedWeapon_map[evn->actor].leftHand.weaponType);
			}
		}
	}

	return kEvent_Continue;
}