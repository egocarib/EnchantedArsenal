Scriptname EAr_LoaderDrone extends ReferenceAlias

string UpdateMessage = ""
Event OnInit()
	UpdateMessage = "{newInstall}"
EndEvent

Event OnPlayerLoadGame()
	EAr_Mothership mothership = (GetOwningQuest() as EAr_Mothership)
   ; mothership.RunLoadMaintenance()
    mothership.menu.SetPages()
	mothership.RegisterForModEvent("EnchantedArsenal_Uninstall", "OnUninstall")
	mothership.menu.RegisterForMenu("Journal Menu")
	if ModVersion < GetModVersion()
		UpdateMod(mothership)
	endif
	Utility.waitmenumode(1.0)
	mothership.menu.RunCustomizationUpkeep()
EndEvent


int property ModVersion = 100 auto
int Function GetModVersion()
	return 221
EndFunction

Function UpdateMod(EAr_Mothership mothership)

	if ModVersion < 110 ;version 1.10
		ModVersion = 110

		;HIT ART UPDATE ----------------------------------------->

		;update linked defaults since index changed for these HitArt objects:
			mothership.idxHitArtGreenFX[17]     = 22  ;PoisonCloak01
			mothership.idxHitArtSpecialFX[12]   = 26  ;SoulTrapTargetEffects

		;fill the arrays with the new values:
			mothership.xHitArtArray[1] = game.GetFormFromFile(0x04253F, "Skyrim.esm") as Art ;FXIceCloak01
			mothership.xHitArtStrings[1] = "$Cloak of Ice HitFX"
			mothership.xHitArtArray[2] = game.GetFormFromFile(0x046007, "Skyrim.esm") as Art ;FXSpiderSpitHit
			mothership.xHitArtStrings[2] = "$Frost Cloud HitFX"
			mothership.xHitArtArray[3] = game.GetFormFromFile(0x08CC89, "Skyrim.esm") as Art ;FXWispParticleAttachObject
			mothership.xHitArtStrings[3] = "$Wisp Aura HitFX"
			mothership.xHitArtArray[4] = game.GetFormFromFile(0x02ACD7, "Skyrim.esm") as Art ;FXFireCloak01
			mothership.xHitArtStrings[4] = "$Cloak of Fire HitFX"
			mothership.xHitArtArray[5] = game.GetFormFromFile(0x086812, "Skyrim.esm") as Art ;FXDragonDeathRHandBitsObject
			mothership.xHitArtStrings[5] = "$Ember Flakes HitFX"
			mothership.xHitArtArray[6] = game.GetFormFromFile(0x086817, "Skyrim.esm") as Art ;FXDragonDeathLHandFireObject
			mothership.xHitArtStrings[6] = "$Ember Explosion HitFX"
			mothership.xHitArtArray[7] = game.GetFormFromFile(0x0339C8, "Skyrim.esm") as Art ;InvisFXBody01
			mothership.xHitArtStrings[7] = "$Flare Pulse HitFX"
			mothership.xHitArtArray[8] = game.GetFormFromFile(0x056AC8, "Skyrim.esm") as Art ;ShieldSpellBodyFX
			mothership.xHitArtStrings[8] = "$White Pulse HitFX"
			mothership.xHitArtArray[9] = game.GetFormFromFile(0x0ABF0E, "Skyrim.esm") as Art ;AbsorbBlueTargetPointFX
			mothership.xHitArtStrings[9] = "$White Particles HitFX"
			mothership.xHitArtArray[10] = game.GetFormFromFile(0x04BE34, "Skyrim.esm") as Art ;TurnUndeadTargetFX
			mothership.xHitArtStrings[10] = "$Phaser HitFX"
			mothership.xHitArtArray[11] = game.GetFormFromFile(0x05B1BC, "Skyrim.esm") as Art ;FXShockCloak01
			mothership.xHitArtStrings[11] = "$Cloak of Sparks HitFX"
			mothership.xHitArtArray[12] = game.GetFormFromFile(0x0506D6, "Skyrim.esm") as Art ;SoulTrapTargetEffects
			mothership.xHitArtStrings[12] = "$Spark Pulse HitFX"
			mothership.xHitArtArray[13] = game.GetFormFromFile(0x06D51F, "Skyrim.esm") as Art ;FXAtronachStormCloakObject
			mothership.xHitArtStrings[13] = "$Stormcloud HitFX"
			mothership.xHitArtArray[14] = game.GetFormFromFile(0x0BAD3E, "Skyrim.esm") as Art ;MuffleHitFX
			mothership.xHitArtStrings[14] = "$Magnetic Shards HitFX"
			mothership.xHitArtArray[15] = game.GetFormFromFile(0x048DD0, "Skyrim.esm") as Art ;SlowTimeHitEffect
			mothership.xHitArtStrings[15] = "$Magnetosphere HitFX"
			mothership.xHitArtArray[16] = game.GetFormFromFile(0x030B3A, "Skyrim.esm") as Art ;FXDwarvenCenturionObject
			mothership.xHitArtStrings[16] = "$Centurion Steamburst HitFX"
			mothership.xHitArtArray[17] = game.GetFormFromFile(0x04BB4A, "Skyrim.esm") as Art ;FXDwarvenSphereObject
			mothership.xHitArtStrings[17] = "$Steam Cloud HitFX"
			mothership.xHitArtArray[18] = game.GetFormFromFile(0x04EFB5, "Skyrim.esm") as Art ;FXDwarvenSpiderObject
			mothership.xHitArtStrings[18] = "$Dust Cloud HitFX"
			mothership.xHitArtArray[19] = game.GetFormFromFile(0x0510D4, "Skyrim.esm") as Art ;EnchElementalFuryFX
			mothership.xHitArtStrings[19] = "$Gust of Wind HitFX"
			mothership.xHitArtArray[20] = game.GetFormFromFile(0x078769, "Skyrim.esm") as Art ;DisguiseTargetPointFX
			mothership.xHitArtStrings[20] = "$Grey Smoke Faint HitFX"
			mothership.xHitArtArray[21] = game.GetFormFromFile(0x0AA853, "Skyrim.esm") as Art ;FXDragonPriestParticlesObject
			mothership.xHitArtStrings[21] = "$Black Smoke Faint HitFX"
			mothership.xHitArtArray[22] = game.GetFormFromFile(0x1046CD, "Skyrim.esm") as Art ;PoisonCloak01
			mothership.xHitArtStrings[22] = "$Black Cloud Faint HitFX"
			mothership.xHitArtArray[23] = game.GetFormFromFile(0x078768, "Skyrim.esm") as Art ;DisguiseCastPointFX01
			mothership.xHitArtStrings[23] = "$Inky Smoke HitFX"
			mothership.xHitArtArray[24] = game.GetFormFromFile(0x03F1B4, "Skyrim.esm") as Art ;HealTargetFX
			mothership.xHitArtStrings[24] = "$Heal Swirl HitFX"
			mothership.xHitArtArray[25] = game.GetFormFromFile(0x03F810, "Skyrim.esm") as Art ;HealConTargetFX
			mothership.xHitArtStrings[25] = "$Heal Cloud HitFX"
			mothership.xHitArtArray[26] = game.GetFormFromFile(0x0506D6, "Skyrim.esm") as Art ;SoulTrapTargetEffects
			mothership.xHitArtStrings[26] = "$Purple Soul Trap HitFX"
			mothership.xHitArtArray[27] = game.GetFormFromFile(0x0531AE, "Skyrim.esm") as Art ;SoulTrapTargetPointFX
			mothership.xHitArtStrings[27] = "$Purple Soul Absorb HitFX"
			mothership.xHitArtArray[28] = game.GetFormFromFile(0x04E221, "Skyrim.esm") as Art ;HealMystTargetFX
			mothership.xHitArtStrings[28] = "$Blue Swirl HitFX"
			mothership.xHitArtArray[29] = game.GetFormFromFile(0x04E223, "Skyrim.esm") as Art ;HealMystConTargetFX01
			mothership.xHitArtStrings[29] = "$Blue Swirl Lite HitFX"
			mothership.xHitArtArray[30] = game.GetFormFromFile(0x07024B, "Skyrim.esm") as Art ;CommandTargetFX
			mothership.xHitArtStrings[30] = "$Blue Cloudswirl HitFX"
			mothership.xHitArtArray[31] = game.GetFormFromFile(0x07E8F9, "Skyrim.esm") as Art ;DismayingTargetFX
			mothership.xHitArtStrings[31] = "$Blue Cloudspiral HitFX"
			mothership.xHitArtArray[32] = game.GetFormFromFile(0x0ABF10, "Skyrim.esm") as Art ;AbsorbBlueCastPointFX01
			mothership.xHitArtStrings[32] = "$Blue Cloud Faint HitFX"
			mothership.xHitArtArray[33] = game.GetFormFromFile(0x07534B, "Skyrim.esm") as Art ;ShoutSelfAreaEffect01
			mothership.xHitArtStrings[33] = "$Blue Sunburst HitFX"
			mothership.xHitArtArray[34] = game.GetFormFromFile(0x075271, "Skyrim.esm") as Art ;ReanimateTargetFX
			mothership.xHitArtStrings[34] = "$Blue Magic Bubbles HitFX"
			mothership.xHitArtArray[35] = game.GetFormFromFile(0x07331A, "Skyrim.esm") as Art ;IllusionPosFXHand01
			mothership.xHitArtStrings[35] = "$Green Illusion Swirl HitFX"
			mothership.xHitArtArray[36] = game.GetFormFromFile(0x0BCF28, "Skyrim.esm") as Art ;WaterBreathingTargetFX
			mothership.xHitArtStrings[36] = "$Green Swirl Thick HitFX"
			mothership.xHitArtArray[37] = game.GetFormFromFile(0x06DE86, "Skyrim.esm") as Art ;ParalyzeFXBody01
			mothership.xHitArtStrings[37] = "$Green Paralyze HitFX"
			mothership.xHitArtArray[38] = game.GetFormFromFile(0x0ABF0D, "Skyrim.esm") as Art ;AbsorbGreenCastPointFX01
			mothership.xHitArtStrings[38] = "$Green Beam-up HitFX"
			mothership.xHitArtArray[39] = game.GetFormFromFile(0x0ABF12, "Skyrim.esm") as Art ;AbsorbGreenTargetPointFX
			mothership.xHitArtStrings[39] = "$Green Particles HitFX"
			mothership.xHitArtArray[40] = game.GetFormFromFile(0x09186D, "Skyrim.esm") as Art ;FXGreybeardAbsorbObject
			mothership.xHitArtStrings[40] = "$Orange Beam-up HitFX"
			mothership.xHitArtArray[41] = game.GetFormFromFile(0x07331C, "Skyrim.esm") as Art ;IllusionPosFXBody01
			mothership.xHitArtStrings[41] = "$Red Fury Swirl HitFX"
			mothership.xHitArtArray[42] = game.GetFormFromFile(0x074795, "Skyrim.esm") as Art ;IllusionNegFXBody01
			mothership.xHitArtStrings[42] = "$Red Frenzy Swirl HitFX"
			mothership.xHitArtArray[43] = game.GetFormFromFile(0x08AFD1, "Skyrim.esm") as Art ;AuraWhisperBodyFX
			mothership.xHitArtStrings[43] = "$Red Micropulse HitFX"
			mothership.xHitArtArray[44] = game.GetFormFromFile(0x10F507, "Skyrim.esm") as Art ;NightingaleStrifeAbsorbTargetPointFX
			mothership.xHitArtStrings[44] = "$Red Beam-up HitFX"
			mothership.xHitArtArray[45] = game.GetFormFromFile(0x106ADB, "Skyrim.esm") as Art ;MS04MemoryFXBody01
			mothership.xHitArtStrings[45] = "$Red Cloud Faint HitFX"
			mothership.xHitArtArray[46] = game.GetFormFromFile(0x0ABEF9, "Skyrim.esm") as Art ;AbsorbCastPointFX01
			mothership.xHitArtStrings[46] = "$Red Smoke Faint HitFX"
			mothership.xHitArtArray[47] = game.GetFormFromFile(0x0FD7D7, "Skyrim.esm") as Art ;FXWWSpiritExtractHit
			mothership.xHitArtStrings[47] = "$Red/Black Accumulator HitFX"
			mothership.xHitArtArray[48] = game.GetFormFromFile(0x0A6EF6, "Skyrim.esm") as Art ;AbsorbSpellEffect
			mothership.xHitArtStrings[48] = "$Dimensional Rift HitFX"
			mothership.xHitArtArray[49] = game.GetFormFromFile(0x0EA518, "Skyrim.esm") as Art ;AbsorbSpellHitEffect01
			mothership.xHitArtStrings[49] = "$Dimensional Rift Alt HitFX"
			mothership.xHitArtArray[50] = game.GetFormFromFile(0x0EC353, "Skyrim.esm") as Art ;TimeTeleportTargetFX
			mothership.xHitArtStrings[50] = "$Timewarp HitFX"
			mothership.xHitArtArray[51] = game.GetFormFromFile(0x10950B, "Skyrim.esm") as Art ;DA16SkullDreamsteelHitFX
			mothership.xHitArtStrings[51] = "$Timewarp Purple HitFX"
			mothership.xHitArtArray[52] = game.GetFormFromFile(0x0998A5, "Skyrim.esm") as Art ;TFXfogVTobject
			mothership.xHitArtStrings[52] = "$Invisibility HitFX"
			mothership.xHitArtArray[53] = game.GetFormFromFile(0x041F06, "Skyrim.esm") as Art ;LightSpellActorFX
			mothership.xHitArtStrings[53] = "$Magelight HitFX"
			mothership.xHitArtArray[54] = game.GetFormFromFile(0x04EFBD, "Skyrim.esm") as Art ;FXDragonBiteObject
			mothership.xHitArtStrings[54] = "$Water Splash HitFX"
			mothership.xHitArtArray[55] = game.GetFormFromFile(0x09AA39, "Skyrim.esm") as Art ;FXSprigganFX01Object
			mothership.xHitArtStrings[55] = "$Spriggan Leaves Green HitFX"
			mothership.xHitArtArray[56] = game.GetFormFromFile(0x1090F4, "Skyrim.esm") as Art ;FXSprigganAttachmentsMatronObject
			mothership.xHitArtStrings[56] = "$Spriggan Leaves Gold HitFX"
			mothership.xHitArtArray[57] = game.GetFormFromFile(0x09AA42, "Skyrim.esm") as Art ;FXSprigganSwarmObject
			mothership.xHitArtStrings[57] = "$Spriggan Swarm HitFX"
			mothership.xHitArtArray[58] = game.GetFormFromFile(0x02E6A9, "Skyrim.esm") as Art ;MAGDragonPowerAbsorbObject
			mothership.xHitArtStrings[58] = "$Dragon Absorb Orange HitFX"
			mothership.xHitArtArray[59] = game.GetFormFromFile(0x02E6AA, "Skyrim.esm") as Art ;MAGDragonPowerAbsorbManObject
			mothership.xHitArtStrings[59] = "$Dragon Absorb Blue HitFX"
			mothership.xHitArtArray[60] = game.GetFormFromFile(0x055C0A, "Skyrim.esm") as Art ;DragonRendHitEffect
			mothership.xHitArtStrings[60] = "$Dragonrend HitFX"
			mothership.xHitArtArray[61] = game.GetFormFromFile(0x05B7FC, "Skyrim.esm") as Art ;FXAlduinTimRiftObject
			mothership.xHitArtStrings[61] = "$Alduin Cloudrift HitFX"
	endif

	;PLANNED UPDATES (NOT RELEASED YET)
	if ModVersion < 120
		ModVersion = 120

		mothership.WeaponMGEFShaderStrs[mothership.cEnchTurnUndead] = "$Special FX" ;correcting error in original build. Was linked to Blue FX.

		mothership.menu.SetupDemoUpdate()

		if (UpdateMessage != "{newInstall}")
			UpdateMessage = "$Be sure to check out the new Demo mode. It's an easy way to see all possible visual effects without jumping in and out of the menu!"
		endif

	endif

	if ModVersion < 200
		ModVersion = 200

		mothership.menu.SetupCustomizationUpdate(mothership)

		if (UpdateMessage != "{newInstall}")
			UpdateMessage = "$Enchanted Arsenal can now edit the visual effects of Artifacts, Unique items, Chaos Damage, and custom mod enchantments. Just head to the new 'Custom' page, and click 'Add New'!"
		endif

	endif

	if ModVersion < 210
		ModVersion = 210

		Art[]	_enchArt_Sword      = mothership.xEnchArtArray(0)
		Art[]	_enchArt_Dagger     = mothership.xEnchArtArray(1)
		Art[]	_enchArt_WarAxe     = mothership.xEnchArtArray(2)
		Art[]	_enchArt_Mace       = mothership.xEnchArtArray(3)
		Art[]	_enchArt_Greatsword = mothership.xEnchArtArray(4)
		Art[]	_enchArt_Battleaxe  = mothership.xEnchArtArray(5)
		Art[]	_enchArt_Warhammer  = mothership.xEnchArtArray(6)
		Art[]	_enchArt_Bow        = mothership.xEnchArtArray(7)
		Art[]	_enchArt_Crossbow   = mothership.xEnchArtArray(8)

		;foster xbl art object additions
		_enchArt_Sword[53]      = game.getFormFromFile(0x0842, "EnchantedArsenal.esp") as Art ;EAr_fosterxbl_FlamesGreatswordAO
		_enchArt_Sword[54]      = game.getFormFromFile(0x0845, "EnchantedArsenal.esp") as Art ;EAr_fosterxbl_SparksGreatswordAO
		_enchArt_Dagger[53]     = game.getFormFromFile(0x0841, "EnchantedArsenal.esp") as Art ;EAr_fosterxbl_FlamesDaggerAO
		_enchArt_Dagger[54]     = game.getFormFromFile(0x0844, "EnchantedArsenal.esp") as Art ;EAr_fosterxbl_SparksDaggerAO
		_enchArt_WarAxe[53]     = none
		_enchArt_WarAxe[54]     = none
		_enchArt_Mace[53]       = none
		_enchArt_Mace[54]       = none
		_enchArt_Greatsword[53] = _enchArt_Sword[53] ;EAr_fosterxbl_FlamesGreatswordAO
		_enchArt_Greatsword[54] = _enchArt_Sword[54] ;EAr_fosterxbl_SparksGreatswordAO
		_enchArt_Battleaxe[53]  = none
		_enchArt_Battleaxe[54]  = none
		_enchArt_Warhammer[53]  = game.getFormFromFile(0x0843, "EnchantedArsenal.esp") as Art ;EAr_fosterxbl_FlamesWarhammerAO
		_enchArt_Warhammer[54]  = game.getFormFromFile(0x0846, "EnchantedArsenal.esp") as Art ;EAr_fosterxbl_SparksWarhammerAO
		_enchArt_Bow[53]        = none
		_enchArt_Bow[54]        = none
		_enchArt_Crossbow[53]   = none
		_enchArt_Crossbow[54]   = none
		mothership.xEnchArtStrings[53]     = "$Flame Art  (foster xbl)" ;EAr_Sinobol_PurpleAO
		mothership.xEnchArtStrings[54]     = "$Spark Art  (foster xbl)" ;EAr_Sinobol_PurpleAO

		if (UpdateMessage != "{newInstall}")
			UpdateMessage = "$Version 2.10 -- New Flame & Spark Enchant Art is available, thanks to foster xbl!! -- Works for Daggers, Swords, Greatswords, and Warhammers. Try it out in the Advanced menu!"
		endif

	endif

	if modVersion < 221
		modVersion = 221

		UpdateMessage = ""
	endif

	;convey any update messages to the user through the menu next time they access it
	if (UpdateMessage != "{newInstall}")
		mothership.menu.recentUpdateString = UpdateMessage
	endif
	UpdateMessage = ""
EndFunction


