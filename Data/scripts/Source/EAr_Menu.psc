Scriptname EAr_Menu extends SKI_ConfigBase

GlobalVariable property EAr_InstallComplete auto

int property FX_SCOPE = 9 autoreadonly ;(represents a full "span" of weapon-linked options specific to a single MGEF in the main effect arrays)
int property FX_ENTRY = 1 autoreadonly ;(single effect entry)

EAr_Mothership mothership

import FISSFactory
FISSInterface fiss

;Ops and Op Arrays
int[]		_op_AdvancedFX
int[]		_op_AdvancedHeader
int[]		_op_SimpleFX
int         uninstallOp
int[]		workaroundOp
string		curWorkaroundString = "$DEFAULT" ;DEPRICATED

;FISS Ops & Data Trackers
string[] FISS_PresetTitle
string[] FISS_PresetFilepath
bool[]   FISS_PresetHasData
int      presetMenuOp
int      presetSaveOp
int      presetLoadOp
int      presetRenameOp
int      presetDeleteOp
int      currentPreset
int      FISS_DEFAULT_SETTINGS

;Menu State Trackers
string[]	curMenuOpStrings
int         curMenuStartIndex
int			currentMainOp
bool		bSubMenu
bool		bMainMenu



Event OnConfigInit()
	ModName = "$Enchanted Arsenal"

	_op_AdvancedFX = new int[128]
	_op_AdvancedHeader = new int[128]
	_op_SimpleFX = new int[128]
	workaroundOp = new int[2]

	FISS_PresetHasData = new bool[5]
	FISS_PresetTitle = new string[5]
	FISS_PresetTitle[0] = "Preset 1"
	FISS_PresetTitle[1] = "Preset 2"
	FISS_PresetTitle[2] = "Preset 3"
	FISS_PresetTitle[3] = "Preset 4"
	FISS_PresetTitle[4] = "Preset 5"
	FISS_PresetFilepath = new string[6]
	FISS_PresetFilepath[0] = "Enchanted Arsenal\\Preset 1.xml"
	FISS_PresetFilepath[1] = "Enchanted Arsenal\\Preset 2.xml"
	FISS_PresetFilepath[2] = "Enchanted Arsenal\\Preset 3.xml"
	FISS_PresetFilepath[3] = "Enchanted Arsenal\\Preset 4.xml"
	FISS_PresetFilepath[4] = "Enchanted Arsenal\\Preset 5.xml"
	FISS_PresetFilepath[5] = "Enchanted Arsenal\\Preset Defaults.xml"
	FISS_DEFAULT_SETTINGS = 5

	SetPages()
	InitializeMenuStrings()
	InitializeKeyCodes()
	RegisterForMenu("Journal Menu")
EndEvent

Function SetPages()
	int hasFiss = game.getModByName("FISS.esp")
	if (hasFiss < 255 && hasFiss > 0)
		Pages = new string[7]
		Pages[0] = "$Simple"
		Pages[1] = "$Advanced"
		Pages[2] = "$Custom"
		Pages[3] = "$Presets"
		;Pages[3] = "$Options"
		Pages[4] = "$Demo"
		Pages[5] = "$Credits"
		Pages[6] = "$Uninstall"
	else
		Pages = new string[6]
		Pages[0] = "$Simple"
		Pages[1] = "$Advanced"
		Pages[2] = "$Custom"
		;Pages[2] = "$Options"
		Pages[3] = "$Demo"
		Pages[4] = "$Credits"
		Pages[5] = "$Uninstall"
	endif
EndFunction

string	property recentUpdateString auto hidden ;used by update script to convey a message


Event OnPageReset(string page)
	
	if page == ""
		LoadCustomContent("EnchantedArsenal/EAr_Logo.dds", 0, 0)
		;display update message, if any
		if (recentUpdateString)
			string tempStr = recentUpdateString
			recentUpdateString = ""
			utility.waitmenumode(1.0)
			ShowMessage(tempStr, false, "$Okay")
		endif
		return
	else
		UnloadCustomContent()
	endIf

	if page == "$Simple"

		BuildSimplePage()

	elseif page == "$Advanced"

		if !bSubMenu
			bMainMenu = true
			BuildAdvancedPageMain()

		else ;SubMenu
			bMainMenu = false
			BuildAdvancedPageSub()
			
		endif

	elseif page == "$Options"

		BuildOptionsPage()

	elseif page == "$Demo"

		BuildDemoPage()

	elseif page == "$Presets"

		BuildPresetsPage()

	elseif page == "$Credits"

		BuildCreditsPage()

	elseif page == "$Uninstall"

		BuildUninstallPage()

	elseif page == "$Custom"

		if !bSubMenu
			bMainMenu = true
			BuildCustomizePageMain()

		else ;SubMenu
			bMainMenu = false
			BuildCustomizePageSub()

		endif

	endif
	bSubMenu = false ;only draw subMenu once
EndEvent


Function BuildUninstallPage()
	SetCursorPosition(0)
	SetCursorFillMode(TOP_TO_BOTTOM)
	SetTitleText("$Uninstallation")
	uninstallOp = AddToggleOption("$Uninstall Enchanted Arsenal", false)
EndFunction




Function BuildCustomizePageMain()
	SetCursorPosition(0)
	SetCursorFillMode(TOP_TO_BOTTOM)
	int i = 0
	while (i < 14)
		if customEffectStrs[i]
			_customizeMenuOps[i] = AddTextOption(customEffectStrs[i], "")
		else
			_customizeMenuOps[i] = -1
		endif
		i += 1
	endWhile
	SetCursorPosition(9)
	_customizeMenuOps[i] = AddTextOption("", "$Add New")
	SetStarterInfoText("$Select an enchantment to edit, or add a new custom enchantment to your list.")

	i += 1
	while i < 30 ;remove residual ops from previous page loads
		_customizeMenuOps[i] = -1
		i += 1
	endWhile

	i = 14
	while i ;collapse all subOptions once subMenus are exited
		i -= 1
		_customExpandedOps[i] = false
	endWhile

EndFunction

Function BuildCustomizePageSub()
	SetTitleText(customEffectStrs[currentMainOp])
	SetCursorPosition(0)
	SetCursorFillMode(LEFT_TO_RIGHT)

	int fxOffset = currentMainOp * 9

	_customizeMenuHeaderOps[0] = AddTextOption("", "$GO BACK                                                            _") ;force bold aligned far left
	_customizeMenuHeaderOps[1] = AddTextOption("", "$DELETE THIS CUSTOM EFFECT")
	AddHeaderOption("")
	AddHeaderOption("")
	_customizeMenuOps[0] = AddTextOption(advancedOpStrings[0], customEffectEnchShaderStrs[currentMainOp])
	_customizeMenuOps[1] = AddMenuOption(customEffectEnchShaderStrsSpec[currentMainOp], "")

 ;	if (!expandedOps[currentMainOp]) ;SHOW BASIC OPTIONS

	; _customizeMenuOps[0]  = AddTextOption(advancedOpStrings[0], pStrEnchShader[fxOffset])
	; _customizeMenuOps[1]  = AddMenuOption(pStrEnchShaderSpec[fxOffset], "")

	if (!_customExpandedOps[currentMainOp])
		_customizeMenuOps[2]  = AddTextOption(advancedOpStrings[1], "$EXPAND")
		bool bHasArt = false
		bool iDefault = false
		int h = 9
		while h
			h -= 1
			if (customEffectEnchArtStrs[fxOffset + h] == "$DEFAULT")
				iDefault = true
				h = 0
			endif
			if (customEffectEnchArtStrs[fxOffset + h] != "$NONE")
				bHasArt = true
				h = 0
			endif
		endWhile
		if (iDefault)
			_customizeMenuOps[3] = AddMenuOption("$DEFAULT", "")
		elseif (bHasArt)
			_customizeMenuOps[3] = AddMenuOption("$CUSTOM", "")
		else
			_customizeMenuOps[3] = AddMenuOption("$NONE", "")
		endif
		int i = 4 ;cleanse expanded options
		while i < 32
			_customizeMenuOps[i] = -1
			i += 1
		endWhile

	else ;expandedOps
		_customizeMenuOps[2]  = AddTextOption(advancedOpStrings[1], "$COLLAPSE")
		_customizeMenuOps[3]  = AddMenuOption("", "")
		_customizeMenuOps[14] = AddTextOption(advancedArtOpStrings[0], "")
		_customizeMenuOps[15] = AddMenuOption(customEffectEnchArtStrs[fxOffset], "")
		_customizeMenuOps[16] = AddTextOption(advancedArtOpStrings[1], "")
		_customizeMenuOps[17] = AddMenuOption(customEffectEnchArtStrs[fxOffset + 1], "")
		_customizeMenuOps[18] = AddTextOption(advancedArtOpStrings[2], "")
		_customizeMenuOps[19] = AddMenuOption(customEffectEnchArtStrs[fxOffset + 2], "")
		_customizeMenuOps[20] = AddTextOption(advancedArtOpStrings[3], "")
		_customizeMenuOps[21] = AddMenuOption(customEffectEnchArtStrs[fxOffset + 3], "")
		_customizeMenuOps[22] = AddTextOption(advancedArtOpStrings[4], "")
		_customizeMenuOps[23] = AddMenuOption(customEffectEnchArtStrs[fxOffset + 4], "")
		_customizeMenuOps[24] = AddTextOption(advancedArtOpStrings[5], "")
		_customizeMenuOps[25] = AddMenuOption(customEffectEnchArtStrs[fxOffset + 5], "")
		_customizeMenuOps[26] = AddTextOption(advancedArtOpStrings[6], "")
		_customizeMenuOps[27] = AddMenuOption(customEffectEnchArtStrs[fxOffset + 6], "")
		_customizeMenuOps[28] = AddTextOption(advancedArtOpStrings[7], "")
		_customizeMenuOps[29] = AddMenuOption(customEffectEnchArtStrs[fxOffset + 7], "")
		_customizeMenuOps[30] = AddTextOption(advancedArtOpStrings[8], "")
		_customizeMenuOps[31] = AddMenuOption(customEffectEnchArtStrs[fxOffset + 8], "")
	endif

	_customizeMenuOps[4]  = AddTextOption(advancedOpStrings[2], "")
	_customizeMenuOps[5]  = AddMenuOption(customEffectHitShaderStrs[currentMainOp], "")
	_customizeMenuOps[6]  = AddTextOption(advancedOpStrings[3], "")
	_customizeMenuOps[7]  = AddMenuOption(customEffectHitArtStrs[currentMainOp], "")
	; _customizeMenuOps[8]  = AddTextOption(advancedOpStrings[4], "")
	; _customizeMenuOps[9]  = AddMenuOption(pStrImpactData[fxOffset], "")
	; _customizeMenuOps[10] = AddTextOption(advancedOpStrings[5], "")
	; _customizeMenuOps[11] = AddMenuOption(pStrProjectile[fxOffset], "")
	_customizeMenuOps[12] = AddTextOption(advancedOpStrings[6], "")
	_customizeMenuOps[13] = AddTextOption(customEffectLingeringFXStrs[currentMainOp], "")
EndFunction






int[] demoOps
bool bStartDemo
string curDemoEffectString
string curDemoComponentString
string curDemoFXTypeString
string[] demoComponentStrings
string[] demoFXTypeStrings

Function SetupDemoUpdate() ;used for Update to 1.20, called from LoaderDrone
	demoOps = new int[7]
	demoComponentStrings = new string[4]
	demoFXTypeStrings = new string[8]
	demoComponentStrings[0] = advancedOpStrings[0] ;"$Enchant Shader"
	demoComponentStrings[1] = advancedOpStrings[1] ;"$Enchant Art"
	demoComponentStrings[2] = advancedOpStrings[2] ;"$Hit Shader"
	demoComponentStrings[3] = advancedOpStrings[3] ;"$Hit Art"
	demoFXTypeStrings[0] = sFXTypes[0]
	demoFXTypeStrings[1] = sFXTypes[1]
	demoFXTypeStrings[2] = sFXTypes[2]
	demoFXTypeStrings[3] = sFXTypes[3]
	demoFXTypeStrings[4] = sFXTypes[4]
	demoFXTypeStrings[5] = sFXTypes[5]
	demoFXTypeStrings[6] = sFXTypes[6]
	demoFXTypeStrings[7] = sFXTypes[7]
	curDemoEffectString = WeaponMGEFStrs[cEnchFire] ;"$Fire Damage"
	curDemoComponentString = demoComponentStrings[3]
	curDemoFXTypeString = sFXTypes[0]
EndFunction



Function BuildDemoPage()
	SetCursorPosition(0)
	SetCursorFillMode(TOP_TO_BOTTOM)
	SetTitleText("$Demo Mode")
	AddEmptyOption()
	demoOps[0] = AddMenuOption("$Component To Demo", curDemoComponentString)
	;demoOps[2] = AddTextOption("$?", "")
	if (curDemoComponentString == demoComponentStrings[0])
		demoOps[5] = AddMenuOption("$     Begin With...", curDemoFXTypeString)
		;demoOps[6] = AddTextOption("$?", "")
	endif
	AddEmptyOption()
	demoOps[1] = AddMenuOption("$Enchantment to Demo On", curDemoEffectString)
	;demoOps[3] = AddTextOption("$?", "")
	AddEmptyOption()
	AddEmptyOption()
	demoOps[4] = AddToggleOption("$Start Demo", bStartDemo) ;message to say it will begin on leaving the menu and end upon reentering the menu
EndFunction



Function BuildOptionsPage()
; 	SetCursorPosition(0)
; 	SetCursorFillMode(TOP_TO_BOTTOM)
; 	SetTitleText("$Options")
; 	AddHeaderOption("$Workarounds")
EndFunction



Function BuildPresetsPage()
	fiss = FISSFactory.getFISS() ;get reference to the FISS Interface
	if (fiss)

		; fiss.beginLoad("Dynamic Potions\\Preset 5.xml")
		;   string trashString = fiss.loadString("PresetTitle")       ;NO LONGER NECESSARY WITH FISS 1.21+
		; trashString = fiss.endLoad()

		;load current names
		int i = 5
		while i 
			i -= 1
			fiss.beginLoad("Enchanted Arsenal\\Preset " + (i + 1) + ".xml")
				FISS_PresetTitle[i] = fiss.loadString("PresetTitle")
				FISS_PresetHasData[i] = fiss.loadBool("HasData")
			string loadResult = fiss.endLoad()
			if loadResult != "" ;load failed for some reason, not sure why (doesnt seem to fail if file doesnt exist)
				FISS_PresetTitle[i] = "Preset " + (i + 1)
				FISS_PresetHasData[i] = false
				debug.trace("$Enchanted Arsenal - Loading presets failed, Please ensure that the 'Data\\SKSE\\Plugins\\FISS\\Enchanted Arsenal' directory and its contents have not been deleted. (loadResult = " + loadResult + ")")
			endif
			if FISS_PresetTitle[i] == "" ;set to default name
				FISS_PresetTitle[i] = "Preset " + (i + 1)
			endif
		endWhile

		;build page:
		SetCursorPosition(0)
		SetCursorFillMode(TOP_TO_BOTTOM)
		AddHeaderOption("$Custom Saved Settings")
		presetMenuOp = AddMenuOption("$Preset", FISS_PresetTitle[currentPreset])
		if !FISS_PresetHasData[currentPreset]
			AddTextOption("", "$(empty)", 1)
		else 
			AddEmptyOption()
		endif
			AddEmptyOption()
			AddEmptyOption()
			AddEmptyOption()
			AddEmptyOption()
		;if FISS_PresetHasData[currentPreset]
			presetRenameOp = AddTextOption("$Rename This Preset", "")
		;else 
		;  AddEmptyOption()
		;endif
		AddHeaderOption("")

		SetCursorPosition(1)
		AddHeaderOption("")
		if FISS_PresetHasData[currentPreset]
			presetSaveOp = -1 ;otherwise will equal the same as presetLoadOp
			presetLoadOp = AddTextOption("$Load This Preset", "")
			AddEmptyOption()
			;presetSaveOp = AddTextOption("Save Current Settings to Preset", "")
				AddEmptyOption()
			AddEmptyOption()
			AddEmptyOption()
			AddEmptyOption()
			presetDeleteOp = AddTextOption("$Delete Current Preset Data", "")
		else
			presetLoadOp = -1
			presetSaveOp = AddTextOption("$Save Current Settings to Preset", "")
			AddEmptyOption()
			AddEmptyOption()
			AddEmptyOption()
			AddEmptyOption()
			AddEmptyOption()
			AddEmptyOption()
		endif
		AddHeaderOption("")
	else ;attempt to contact FISS Interface failed
		;should never happen, since this page is deleted on load when FISS not present
		AddTextOption("", "$FISS not detected, Presets Disabled.")
	endif
EndFunction


Function BuildCreditsPage()
	SetTitleText("$Credits")
	SetCursorPosition(0)
	SetCursorFillMode(LEFT_TO_RIGHT)
	AddTextOption("$Thank you to all the original mod authors!!", "")
	AddTextOption("$                                   (credits in random order)", "")
	AddEmptyOption()
	AddEmptyOption()
	;12 authors
	int[] shuffler = new int[12]
	int i = 0
	while i < 12
		shuffler[i] = i
		i += 1
	endWhile
	i = 0
	while i < 11 ;swapping the 11th with itself would be redundant, so stop at 10
		int j = utility.randomInt(i, 11)
		int k = shuffler[i]
		shuffler[i] = shuffler[j]
		shuffler[j] = k
		i += 1
	endWhile
	i = 0
	while i < 12
		AddTextOption("", ModNameStrs[shuffler[i]])
		AddTextOption(ModIDStrs[shuffler[i]], "")
		AddTextOption(AuthorStrs[shuffler[i]], "")
		AddEmptyOption()
		i += 1
	endWhile
EndFunction

Function BuildSimplePage()
	SetTitleText("$Simple Config")
	SetCursorPosition(0)
	SetCursorFillMode(LEFT_TO_RIGHT)
	AddHeaderOption("")
	AddHeaderOption("")
	AddTextOption("$CHOOSE FX COLLECTION:  Globally", "")
	_op_SimpleFX[0] = AddMenuOption(pCurrentGlobalFXSetting, "")
	AddHeaderOption("")
	AddHeaderOption("")
	AddTextOption("$CHOOSE FX COLLECTION:  By Enchantment", "")
	AddEmptyOption()
	int i = 0
	while (WeaponMGEFStrs[i] != "")
		;if (pStrEnchShader[i * 9] != WeaponMGEFShaderStrs[i])
			;DISPLAY CUSTOM SHADER COLOR SET if user has chosen one, just to indicate a more custom setting exists. cannot be adjusted here in simple menu.
		;	AddTextOption(bufferedWeaponMGEFStrs[i], pStrEnchShader[i * 9])
		;else
			AddTextOption(bufferedWeaponMGEFStrs[i], "")
		;endif
		_op_SimpleFX[i + 1] = AddMenuOption(pStrEnchShaderPreset[i * 9], "")
		i += 1
	endWhile
	AddHeaderOption("")
	AddHeaderOption("")

	;Giving up on these backup presets for now, too complicated to be worth it...
		; AddTextOption("", "$WORKAROUNDS                                                                        _")
		; AddEmptyOption()
		; AddTextOption("Backup Preset", "")
		; workaroundOp[0] = AddMenuOption(curWorkaroundString, "");FXSettingMenuStrs[curWorkaroundPreset])
		; AddEmptyOption()
		; workaroundOp[1] = AddTextOption("$More Info", "")
EndFunction

Function BuildAdvancedPageMain()
	int opIdx = 0

	SetTitleText("$Enchantment FX: Advanced Config")
	SetCursorPosition(0)
	SetCursorFillMode(TOP_TO_BOTTOM)

	int iColumn = (WeaponMGEFStrs.find("") + 1) / 2
	while opIdx < iColumn
		_op_AdvancedFX[opIdx] = addTextOption(WeaponMGEFStrs[opIdx], "")
		opIdx += 1
	endWhile
	setCursorPosition(1)
	iColumn = WeaponMGEFStrs.Find("")
	while opIdx < iColumn
		_op_AdvancedFX[opIdx] = addTextOption(WeaponMGEFStrs[opIdx], "")
		opIdx += 1
	endWhile
	SetStarterInfoText("$Select an enchantment to customize.")

	while opIdx < 128 ;remove residual ops from previous page loads
		_op_AdvancedFX[opIdx] = -1
		opIdx += 1
	endWhile

	int i = 14
	while i ;collapse all subOptions once subMenus are exited
		i -= 1
		expandedOps[i] = false
	endWhile
EndFunction

Function BuildAdvancedPageSub()

	SetTitleText(WeaponMGEFStrs[currentMainOp])
	SetCursorPosition(0)
	SetCursorFillMode(LEFT_TO_RIGHT)

	int fxOffset = currentMainOp * 9

	_op_AdvancedHeader[0] = AddTextOption("", "$GO BACK                                                            _") ;force bold aligned far left
	AddEmptyOption()
	AddHeaderOption("")
	AddHeaderOption("")
	_op_AdvancedHeader[1] = AddTextOption("$Load From Preset", pStrEnchShader[fxOffset])
	_op_AdvancedHeader[2] = AddMenuOption(pStrEnchShaderPreset[fxOffset], "")
	AddHeaderOption("")
	AddHeaderOption("")

 ;	if (!expandedOps[currentMainOp]) ;SHOW BASIC OPTIONS

	_op_AdvancedFX[0]  = AddTextOption(advancedOpStrings[0], pStrEnchShader[fxOffset])
	_op_AdvancedFX[1]  = AddMenuOption(pStrEnchShaderSpec[fxOffset], "")

	if (!expandedOps[currentMainOp])
		_op_AdvancedFX[2]  = AddTextOption(advancedOpStrings[1], "$EXPAND")
		bool bHasArt = false
		int h = 9
		while h
			h -= 1
			if (pStrEnchArt[fxOffset + h] != "$NONE")
				bHasArt = true
				h = 0
			endif
		endWhile
		if (bHasArt)
			_op_AdvancedFX[3] = AddMenuOption("$CUSTOM", "")
		else
			_op_AdvancedFX[3] = AddMenuOption("$NONE", "")
		endif
		int i = 14 ;cleanse expanded options
		while i < 32
			_op_AdvancedFX[i] = -1
			i += 1
		endWhile

	else ;expandedOps
		_op_AdvancedFX[2]  = AddTextOption(advancedOpStrings[1], "$COLLAPSE")
		_op_AdvancedFX[3]  = AddMenuOption("", "")
		_op_AdvancedFX[14] = AddTextOption(advancedArtOpStrings[0], "")
		_op_AdvancedFX[15] = AddMenuOption(pStrEnchArt[fxOffset], "")
		_op_AdvancedFX[16] = AddTextOption(advancedArtOpStrings[1], "")
		_op_AdvancedFX[17] = AddMenuOption(pStrEnchArt[fxOffset + 1], "")
		_op_AdvancedFX[18] = AddTextOption(advancedArtOpStrings[2], "")
		_op_AdvancedFX[19] = AddMenuOption(pStrEnchArt[fxOffset + 2], "")
		_op_AdvancedFX[20] = AddTextOption(advancedArtOpStrings[3], "")
		_op_AdvancedFX[21] = AddMenuOption(pStrEnchArt[fxOffset + 3], "")
		_op_AdvancedFX[22] = AddTextOption(advancedArtOpStrings[4], "")
		_op_AdvancedFX[23] = AddMenuOption(pStrEnchArt[fxOffset + 4], "")
		_op_AdvancedFX[24] = AddTextOption(advancedArtOpStrings[5], "")
		_op_AdvancedFX[25] = AddMenuOption(pStrEnchArt[fxOffset + 5], "")
		_op_AdvancedFX[26] = AddTextOption(advancedArtOpStrings[6], "")
		_op_AdvancedFX[27] = AddMenuOption(pStrEnchArt[fxOffset + 6], "")
		_op_AdvancedFX[28] = AddTextOption(advancedArtOpStrings[7], "")
		_op_AdvancedFX[29] = AddMenuOption(pStrEnchArt[fxOffset + 7], "")
		_op_AdvancedFX[30] = AddTextOption(advancedArtOpStrings[8], "")
		_op_AdvancedFX[31] = AddMenuOption(pStrEnchArt[fxOffset + 8], "")
	endif

	_op_AdvancedFX[4]  = AddTextOption(advancedOpStrings[2], "")
	_op_AdvancedFX[5]  = AddMenuOption(pStrHitShader[fxOffset], "")
	_op_AdvancedFX[6]  = AddTextOption(advancedOpStrings[3], "")
	_op_AdvancedFX[7]  = AddMenuOption(pStrHitArt[fxOffset], "")
	;_op_AdvancedFX[8]  = AddTextOption(advancedOpStrings[4], "")
	;_op_AdvancedFX[9]  = AddMenuOption(pStrImpactData[fxOffset], "")   //Version 2.20 --> Removing these options since they don't really work
	;_op_AdvancedFX[10] = AddTextOption(advancedOpStrings[5], "")
	;_op_AdvancedFX[11] = AddMenuOption(pStrProjectile[fxOffset], "")
	_op_AdvancedFX[12] = AddTextOption(advancedOpStrings[6], "")
	_op_AdvancedFX[13] = AddTextOption(pStrFXPersistPreset[fxOffset], "")
EndFunction



Event OnOptionMenuOpen(int o)
	if (_op_SimpleFX.find(o) >= 0) ;SIMPLE OPs

		int iOp = _op_SimpleFX.find(o)
		if (iOp == 0)
			curMenuOpStrings = FXSettingMenuStrs
			curMenuStartIndex = curMenuOpStrings.find(pCurrentGlobalFXSetting)
			SetMenuDialogStartIndex(curMenuStartIndex)
		else
			iOp -= 1 ;shift to match MGEFs index
			int fxOffset = iOp * 9

			int thisDefaultFX = sFXTypes.find(WeaponMGEFShaderStrs[iOp])
			curMenuOpStrings = mothership.xEnchShaderStrings(thisDefaultFX, filterShaders = false)

			curMenuStartIndex = curMenuOpStrings.find(pStrEnchShaderPreset[fxOffset])
			SetMenuDialogStartIndex(curMenuStartIndex)
		endif

		SetMenuDialogOptions(curMenuOpStrings)
		SetMenuDialogDefaultIndex(0)

	elseif o == _op_AdvancedHeader[2] ;ADVANCED PRESET OPs

		int fxOffset = currentMainOp * 9
		int curFX = sFXTypes.find(pStrEnchShader[fxOffset])
		curMenuOpStrings = mothership.xEnchShaderStrings(curFX, filterShaders = false)
		curMenuStartIndex = curMenuOpStrings.find(pStrEnchShaderPreset[fxOffset])
		SetMenuDialogStartIndex(curMenuStartIndex)
		SetMenuDialogOptions(curMenuOpStrings)
		SetMenuDialogDefaultIndex(0)

	elseif o == presetMenuOp
		SetMenuDialogOptions(FISS_PresetTitle)
		SetMenuDialogStartIndex(currentPreset)
		SetMenuDialogDefaultIndex(currentPreset)

	;elseif o == workaroundOp[0]
		; curMenuOpStrings = new string[100]
		; int i = 0
		; int j = 0

		; ;build modified option menu, only valid backup options should be in this array:
		; while (FXSettingMenuStrs[i] != "")
		; 	if FXSettingMenuStrs[i] != GRIMELEVEN_STRING
		; 		curMenuOpStrings[j] = FXSettingMenuStrs[i]
		; 		j += 1
		; 	endif
		; 	i += 1
		; endWhile
			
		; SetMenuDialogOptions(curMenuOpStrings)
		; SetMenuDialogStartIndex(0)
		; SetMenuDialogDefaultIndex(0)

	elseif (demoOps.find(o) >= 0) ;DEMO OPs
		if o == demoOps[0]
			curMenuOpStrings = demoComponentStrings
			curMenuStartIndex = curMenuOpStrings.find(curDemoComponentString)
		elseif o == demoOps[1]
			curMenuOpStrings = WeaponMGEFStrs
			curMenuStartIndex = curMenuOpStrings.find(curDemoEffectString)
		elseif o == demoOps[5]
			curMenuOpStrings = demoFXTypeStrings
			curMenuStartIndex = curMenuOpStrings.find(curDemoFXTypeString)
		endif
		SetMenuDialogStartIndex(curMenuStartIndex)
		SetMenuDialogOptions(curMenuOpStrings)
		SetMenuDialogDefaultIndex(0)

	elseif (_customizeMenuOps.find(o) >= 0) ;CUSTOMIZE MENU

		int fxOffset = currentMainOp * 9
		int opIdx = _customizeMenuOps.find(o)

		if (opIdx == 1) ;effect shader
			; if (sFXTypes.find(customEffectEnchShaderStrs[currentMainOp]) == -1)
			; 	customEffectEnchShaderStrs[currentMainOp] == sFXTypes[0]
			; 	;OnOptionSelect(_customizeMenuOps[0])
			; 	RefreshPage()
			; 	return
			; endif
			int curFX = sFXTypes.find(customEffectEnchShaderStrs[currentMainOp])
			curMenuOpStrings = mothership.xEnchShaderStrings(curFX, filterShaders = true)
			curMenuStartIndex = curMenuOpStrings.find(customEffectEnchShaderStrsSpec[currentMainOp])
			SetMenuDialogStartIndex(curMenuStartIndex)
		elseif (opIdx == 3) ;effect art (main, not weapons)
			curMenuOpStrings = new string[128]
			curMenuOpStrings[0] = "   " ;blank entry to use as default, so nothing will change if user cancel/exits the menu
			int i = 0
			while (xEnchArtStrings[i] && i < 126)
				curMenuOpStrings[i + 1] = xEnchArtStrings[i]
				i += 1
			endWhile
			;curMenuOpStrings = xEnchArtStrings ;will need to be filtered too eventually
			SetMenuDialogStartIndex(0) ;if choosing this main op instead of weapon specific ops, start at index 0 (NONE)
		elseif (opIdx == 5) ;hitshader
			curMenuOpStrings = xHitShaderStrings
			curMenuStartIndex = curMenuOpStrings.find(customEffectHitShaderStrs[currentMainOp])
			SetMenuDialogStartIndex(curMenuStartIndex)
		elseif (opIdx == 7) ;hit art
			curMenuOpStrings = xHitArtStrings
			curMenuStartIndex = curMenuOpStrings.find(customEffectHitArtStrs[currentMainOp])
			SetMenuDialogStartIndex(curMenuStartIndex)
		elseif (opIdx >= 15) && ((opIdx % 2) == 1) ;weapon specific ench art
			int weapType = (opIdx - 15) / 2
			fxOffset += weapType
			curMenuOpStrings = mothership.filteredEnchArtStrings(weapType)
			curMenuStartIndex = curMenuOpStrings.find(customEffectEnchArtStrs[fxOffset])
			SetMenuDialogStartIndex(curMenuStartIndex)
		endif

		SetMenuDialogOptions(curMenuOpStrings)
		SetMenuDialogDefaultIndex(0)


	else ;ADVANCED DETAIL OPs

		int fxOffset = currentMainOp * 9
		int opIdx = _op_AdvancedFX.find(o)

		if (opIdx == 1) ;effect shader
			int curFX = sFXTypes.find(pStrEnchShader[fxOffset])
			curMenuOpStrings = mothership.xEnchShaderStrings(curFX, filterShaders = true)
			curMenuStartIndex = curMenuOpStrings.find(pStrEnchShaderSpec[fxOffset])
			SetMenuDialogStartIndex(curMenuStartIndex)
		elseif (opIdx == 3) ;effect art (main, not weapons)
			curMenuOpStrings = new string[128]
			curMenuOpStrings[0] = "   " ;blank entry to use as default, so nothing will change if user cancel/exits the menu
			int i = 0
			while (xEnchArtStrings[i] && i < 126)
				curMenuOpStrings[i + 1] = xEnchArtStrings[i]
				i += 1
			endWhile
			;curMenuOpStrings = xEnchArtStrings ;will need to be filtered too eventually
			SetMenuDialogStartIndex(0) ;if choosing this main op instead of weapon specific ops, start at index 0 (blank)
		elseif (opIdx == 5) ;hitshader
			curMenuOpStrings = xHitShaderStrings
			curMenuStartIndex = curMenuOpStrings.find(pStrHitShader[fxOffset])
			SetMenuDialogStartIndex(curMenuStartIndex)
		elseif (opIdx == 7) ;hit art
			curMenuOpStrings = xHitArtStrings
			curMenuStartIndex = curMenuOpStrings.find(pStrHitArt[fxOffset])
			SetMenuDialogStartIndex(curMenuStartIndex)
		elseif (opIdx == 9) ;impact art
			curMenuOpStrings = xImpactDataStrings
			curMenuStartIndex = curMenuOpStrings.find(pStrImpactData[fxOffset])
			SetMenuDialogStartIndex(curMenuStartIndex)
		elseif (opIdx == 11) ;projectile
			curMenuOpStrings = xProjectileStrings
			curMenuStartIndex = curMenuOpStrings.find(pStrProjectile[fxOffset])
			SetMenuDialogStartIndex(curMenuStartIndex)
		elseif (opIdx >= 15) && ((opIdx % 2) == 1) ;weapon specific ench art
			int weapType = (opIdx - 15) / 2
			fxOffset += weapType
			curMenuOpStrings = mothership.filteredEnchArtStrings(weapType)
			curMenuStartIndex = curMenuOpStrings.find(pStrEnchArt[fxOffset])
			SetMenuDialogStartIndex(curMenuStartIndex)
		endif

		SetMenuDialogOptions(curMenuOpStrings)
		SetMenuDialogDefaultIndex(0)

	endif
EndEvent



Event OnOptionMenuAccept(int o, int index)

	if (_op_SimpleFX.find(o) >= 0) ;SIMPLE OPs
		int iOp = _op_SimpleFX.find(o)

		if (iOp == 0)
			if FXSettingMenuStrs.find(pCurrentGlobalFXSetting) < 0
				if !ShowMessage("$Are you sure you want to overwrite your custom settings?", true, "Confirm", "Cancel")
					return
				endif
			endif
			pCurrentGlobalFXSetting = FXSettingMenuStrs[index]

			int[] fxTypes = new int[14]
			int[] presetIndices = new int[14]
			ExtractPresetInfo(FXGlobalPresets[index], fxTypes, presetIndices)

			int iMGEF = 14
			while (iMGEF)
				iMGEF -= 1
				SetPresetEffects(fxTypes[iMGEF], presetIndices[iMGEF], iMGEF)
			endWhile

		else
			iOp -= 1
			int fxOffset = iOp * 9

			if (pStrEnchShaderPreset[fxOffset] == "$CUSTOM") || (pStrEnchShader[fxOffset] != WeaponMGEFShaderStrs[iOp]) ;make sure to set this to CUSTOM in advanced menu :P
				if !ShowMessage("$Are you sure you want to overwrite your custom settings?", true, "Confirm", "Cancel")
					return
				endif
			endif
			pCurrentGlobalFXSetting = "$CUSTOM" ;set global op to CUSTOM, since we're changing smaller details now
			SetArrayStrs(pStrEnchShader, WeaponMGEFShaderStrs[iOp], fxOffset, FX_SCOPE)
			if (index == 0)
				SetArrayStrs(pStrEnchShaderPreset, WeaponMGEFShaderStrsSpecDefault[iOp], fxOffset, FX_SCOPE)
			else
				SetArrayStrs(pStrEnchShaderPreset, curMenuOpStrings[index], fxOffset, FX_SCOPE)
			endif

			;///////;;Just added, hopefully will work --->
			int curFX = sFXTypes.find(WeaponMGEFShaderStrs[iOp])
			SetPresetEffects(curFX, index, iOp)

		endif

		RefreshPage()

	elseif o == presetMenuOp
		currentPreset = index
		RefreshPage()

	;elseif o == workaroundOp[0]

		;curWorkaroundString = curMenuOpStrings[index]
		;RefreshPage()

	elseif o == _op_AdvancedHeader[2] ;ADVANCED PRESET OPs
		int fxOffset = currentMainOp * 9

		;if (opIdx == 2) ;preset spec
			if (pStrEnchShaderPreset[fxOffset] == "$CUSTOM")
				if !ShowMessage("$Are you sure you want to overwrite this effect's custom settings?", true, "Confirm", "Cancel")
					return
				endif
			endif
			int curFX = sFXTypes.find(pStrEnchShader[fxOffset])
			SetPresetEffects(curFX, index, currentMainOp)
			pCurrentGlobalFXSetting = "$CUSTOM"
			bSubMenu = true
			RefreshPage()
		;endif

	elseif (demoOps.find(o) >= 0) ;DEMO OPs
		if o == demoOps[0]
			curDemoComponentString = curMenuOpStrings[index]
		elseif o == demoOps[1]
			curDemoEffectString = curMenuOpStrings[index]
		elseif o == demoOps[5]
			curDemoFXTypeString = curMenuOpStrings[index]
		endif
		RefreshPage()


	elseif (_customizeMenuOps.find(o) >= 0) ;CUSTOMIZE MENU

		int iOp = currentMainOp
		int fxOffset = currentMainOp * 9
		int opIdx = _customizeMenuOps.find(o)

		if (opIdx == 1) ;Set New Enchant Shader:
			; SetArrayStrs(pStrEnchShaderSpec, curMenuOpStrings[index], fxOffset, FX_SCOPE)
			customEffectEnchShaderStrsSpec[iOp] = curMenuOpStrings[index]
			int curFX = sFXTypes.find(customEffectEnchShaderStrs[currentMainOp])
			; int curFX = sFXTypes.find(pStrEnchShader[fxOffset])
			;since shader strings list may have been shortened when displayed to user, need to fetch index from full strings array to correct for that:
			int correctedShaderIndex = mothership.xEnchShaderStrings(curFX, filterShaders = false).find(curMenuOpStrings[index])
			customEffectEnchShader[currentMainOp] = mothership.xEnchShaderArray(curFX)[correctedShaderIndex]
			if (!customEffectEnchShader[currentMainOp])
				customEffectEnchShader[currentMainOp] = defaultShader
				;debug.trace(" :::: Enchanted Arsenal :::: Null shader selected, replacing with defaultShader...")
			endif
			EnchArsenal.SetLibraryCustomEnchantShader(customEffectEnchShader[currentMainOp], fxOffset, FX_SCOPE)

		elseif (opIdx == 3)  ;Set New Enchant Art:
			if (!index)
				return
			endif
			index -= 1

			int i = 0
			while i < 9
				int thisWeapEffectIdx = fxOffset + i
				customEffectEnchArt[thisWeapEffectIdx] = mothership.xEnchArtArray(i)[index]
				if (customEffectEnchArt[thisWeapEffectIdx] != none)
					customEffectEnchArtStrs[thisWeapEffectIdx] = curMenuOpStrings[index + 1]
				else ;art not compatible with this weapon type
					customEffectEnchArtStrs[thisWeapEffectIdx] = "$NONE"
				endif
				EnchArsenal.SetLibraryCustomEnchantArt(customEffectEnchArt[thisWeapEffectIdx], thisWeapEffectIdx, FX_ENTRY)
				i += 1
			endWhile
			_customExpandedOps[iOp] = (index as bool) ;expand options if set is chosen, collapse if NONE

		elseif (opIdx == 5) ;Set New Hit Shader:
			customEffectHitShader[currentMainOp] = xHitShaderArray[index]
			customEffectHitShaderStrs[currentMainOp] = curMenuOpStrings[index]
			EnchArsenal.SetLibraryCustomHitShader(customEffectHitShader[currentMainOp], fxOffset, FX_SCOPE)

		elseif (opIdx == 7) ;Set New Hit Art:
			customEffectHitArt[currentMainOp] = xHitArtArray[index]
			customEffectHitArtStrs[currentMainOp] = curMenuOpStrings[index]
			EnchArsenal.SetLibraryCustomHitArt(customEffectHitArt[currentMainOp], fxOffset, FX_SCOPE)

		elseif (opIdx >= 15) && ((opIdx % 2) == 1) ;weapon specific ench art
			int weapCode = (opIdx - 15) / 2
			fxOffset += weapCode
			customEffectEnchArtStrs[fxOffset] = curMenuOpStrings[index]
			int modifiedIndex = xEnchArtStrings.find(curMenuOpStrings[index]) ;correct index, since not all strings may have displayed
			; SetArrayStrs(pStrEnchArt, curMenuOpStrings[index], fxOffset, FX_ENTRY)
			customEffectEnchArt[fxOffset] = mothership.xEnchArtArray(weapCode)[modifiedIndex]
			EnchArsenal.SetLibraryCustomEnchantArt(customEffectEnchArt[fxOffset], fxOffset, FX_ENTRY)
		endif

		bSubMenu = true
		RefreshPage()

	else ;ADVANCED DETAIL OPs

		int iOp = currentMainOp
		int fxOffset = currentMainOp * 9
		int opIdx = _op_AdvancedFX.find(o)

		if (curMenuStartIndex != index)
			SetArrayStrs(pStrEnchShaderPreset, "$CUSTOM", fxOffset, FX_SCOPE)
			pCurrentGlobalFXSetting = "$CUSTOM"
		endif

		if (opIdx == 1) ;Set New Enchant Shader:
			SetArrayStrs(pStrEnchShaderSpec, curMenuOpStrings[index], fxOffset, FX_SCOPE)
			int curFX = sFXTypes.find(pStrEnchShader[fxOffset])
			;since shader strings list may have been shortened when displayed to user, need to fetch index from full strings array to correct for that:
			int correctedShaderIndex = mothership.xEnchShaderStrings(curFX, filterShaders = false).find(curMenuOpStrings[index])
			pEnchShader[fxOffset] = mothership.xEnchShaderArray(curFX)[correctedShaderIndex]
			EnchArsenal.SetLibraryEnchantShader(pEnchShader[fxOffset], fxOffset, FX_SCOPE)

		elseif (opIdx == 3)  ;Set New Enchant Art:
			if (!index)
				return
			endif
			index -= 1

			int i = 0
			while i < 9
				int thisWeapEffectIdx = fxOffset + i
				pEnchArt[thisWeapEffectIdx] = mothership.xEnchArtArray(i)[index]
				if (pEnchArt[thisWeapEffectIdx] != none)
					pStrEnchArt[thisWeapEffectIdx] = curMenuOpStrings[index + 1]
				else ;art not compatible with this weapon type
					pStrEnchArt[thisWeapEffectIdx] = "$NONE"
				endif
				EnchArsenal.SetLibraryEnchantArt(pEnchArt[thisWeapEffectIdx], thisWeapEffectIdx, FX_ENTRY)
				i += 1
			endWhile
			expandedOps[iOp] = (index as bool) ;expand options if set is chosen, collapse if NONE

		elseif (opIdx == 5) ;Set New Hit Shader:
			int i = fxOffset + 9
			while i > fxOffset
				i -= 1
				pHitShader[i] = xHitShaderArray[index]
			endWhile
			SetArrayStrs(pStrHitShader, curMenuOpStrings[index], fxOffset, FX_SCOPE)
			EnchArsenal.SetLibraryHitShader(pHitShader[fxOffset], fxOffset, FX_SCOPE)

		elseif (opIdx == 7) ;Set New Hit Art:
			int i = fxOffset + 9
			while i > fxOffset
				i -= 1
				pHitArt[i] = xHitArtArray[index]
			endWhile
			SetArrayStrs(pStrHitArt, curMenuOpStrings[index], fxOffset, FX_SCOPE)
			EnchArsenal.SetLibraryHitArt(pHitArt[fxOffset], fxOffset, FX_SCOPE)

		elseif (opIdx == 9) ;Set New Impact Data:
			int i = fxOffset + 9
			while i > fxOffset
				i -= 1
				pImpactData[i] = xImpactDataArray[index]
			endWhile
			SetArrayStrs(pStrImpactData, curMenuOpStrings[index], fxOffset, FX_SCOPE)
			EnchArsenal.SetLibraryImpactData(pImpactData[fxOffset], fxOffset, FX_SCOPE)

		elseif (opIdx == 11) ;projectile
			int i = fxOffset + 9
			while i > fxOffset
				i -= 1
				pProjectile[i] = xProjectileArray[index]
			endWhile
			SetArrayStrs(pStrProjectile, curMenuOpStrings[index], fxOffset, FX_SCOPE)
			EnchArsenal.SetLibraryProjectile(pProjectile[fxOffset], fxOffset, FX_SCOPE)

		elseif (opIdx >= 15) && ((opIdx % 2) == 1) ;weapon specific ench art
			int weapCode = (opIdx - 15) / 2
			fxOffset += weapCode
			SetArrayStrs(pStrEnchArt, curMenuOpStrings[index], fxOffset, FX_ENTRY)
			int modifiedIndex = xEnchArtStrings.find(curMenuOpStrings[index]) ;correct index, since not all strings may have displayed
			pEnchArt[fxOffset] = mothership.xEnchArtArray(weapCode)[modifiedIndex]
			EnchArsenal.SetLibraryEnchantArt(pEnchArt[fxOffset], fxOffset, FX_ENTRY)
		endif

		bSubMenu = true
		RefreshPage()
	endif
EndEvent


Event onOptionSelect(int o)
	;(no simple menu ops currently)

	if (o == uninstallOp)
		SetToggleOptionValue(o, true)
		if ShowMessage("$Are you sure you want to uninstall Enchanted Arsenal?", true, "$Uninstall", "$Cancel")
			sendModEvent("EnchantedArsenal_Uninstall")
			goToState("beginUninstalling")
			SetOptionFlags(o, OPTION_FLAG_DISABLED)
			ShowMessage("$The mod is being uninstalled. Please exit the MCM menu and wait ten seconds. You may then save the game and remove the mod files. The game will have to be restarted to reset the visual effects.", false, "$Okay")
		else
			SetToggleOptionValue(o, false)
		endif
		RefreshPage()

	elseif (o == presetRenameOp)

		RenameFISSPreset()

	elseif (o == presetDeleteOp)

		DeleteFISSPreset()

	elseif (o == presetSaveOp)

		SaveFISSPreset()

	elseif (o == presetLoadOp)

		LoadFISSPreset()

	;elseif (o == workaroundOp[1])

		;ShowMessage("$The Backup Preset is used when you choose a preset in this menu that does not include Enchant Art for all weapon types (GRIMELEVEN is the only preset like this currently). Your chosen Backup will provide effects for the weapon types that your main Preset can't be used for.", false, "$Okay")

	elseif (o == demoOps[4])

		bStartDemo = !bStartDemo
		SetToggleOptionValue(o, bStartDemo)

		if (bStartDemo)
			ShowMessage("$The demo will begin when you exit the MCM menu. Sheathe and draw your weapons to cycle to the next visual effect. Enable HUD to see messages. The demo will end when you re-open the MCM.", false, "$Okay")
		endif


;ADVANCED OPTIONS PAGE ----------------------->>>>>>
	elseif bMainMenu

		if (_customizeMenuOps[14] == o) ;Add New custom effect

			if !ShowMessage("$To add a new effect, you must be wielding the weapon that has the effect you would like to customize in your right hand. Are you wielding the weapon now?", true, "$Yes", "$No")
				return
			endif
			AddNewCustomEffect()
			RefreshPage()
			return

		else

			if (_customizeMenuOps.find(o) >= 0)
				currentMainOp = _customizeMenuOps.find(o)
			else
				currentMainOp = _op_AdvancedFX.Find(o)
			endif
			bSubMenu = true
			forcePageReset()

		endif

	else ;SubMenu

		if (_customizeMenuHeaderOps[0] == o)
			RefreshPage()
			return

		elseif (_customizeMenuHeaderOps[1] == o)
			RemoveCustomEffect(currentMainOp)
			RefreshPage()
			return

		elseif (_op_AdvancedHeader.find(o) >= 0) ;ADVANCED PRESET OPs
			int iOp = currentMainOp
			int fxOffset = iOp * 9
			int opIdx = _op_AdvancedHeader.find(o)

			if (opIdx == 0)
				RefreshPage()
				return ;reload top-level advanced page
			
			elseif (opIdx == 1)
				if (pStrEnchShaderPreset[fxOffset] == "$CUSTOM")
					if !ShowMessage("$Are you sure you want to overwrite this effect's custom settings?", true, "$Confirm", "$Cancel")
						return
					endif
				endif

				int fxType = (sFXTypes.find(pStrEnchShader[fxOffset]) + 1) % 9
				int presetIndex = 0
				SetPresetEffects(fxType, presetIndex, currentMainOp)
				pCurrentGlobalFXSetting = "$CUSTOM"

				bSubMenu = true
				RefreshPage()
			endif

		elseif (_customizeMenuOps.find(o) >= 0) ;CUSTOMIZE OPs
			int iOp = currentMainOp
			int fxOffset = iOp * 9
			int opIdx = _customizeMenuOps.find(o)

			;0 == fx cycle
			;2 == collapse/expand

			if (opIdx == 2) ;Expand Enchant Art Ops:
				_customExpandedOps[iOp] = !_customExpandedOps[iOp]

			elseif (opIdx == 0) ;Swap FX Shader Group:
				int iFX = (sFXTypes.find(customEffectEnchShaderStrs[currentMainOp]) + 1) % 9
				EffectShader esh = none
				esh = effectDefaultsEnchShader[iOp]
				customEffectEnchShaderStrsSpec[currentMainOp] = mothership.xEnchShaderStrings(iFX, filterShaders = false)[0]
				customEffectEnchShaderStrs[currentMainOp] = sFXTypes[iFX]
				EnchArsenal.SetLibraryCustomEnchantShader(esh, fxOffset, FX_SCOPE)

			elseif (opIdx == 13) ;Swap FX Persist Setting:
				int iPersist
				if customEffectIsDurational[currentMainOp]
					if customEffectLingeringFXStrs[currentMainOp] == "$Full Effect Duration"
						customEffectLingeringFXStrs[currentMainOp] == "$NONE"
						iPersist = 0
					else
						customEffectLingeringFXStrs[currentMainOp] == "$Full Effect Duration"
						iPersist = 1
					endif
				else
					iPersist = xFXPersistStrings.find(customEffectLingeringFXStrs[currentMainOp])
					iPersist = (iPersist + 1) % 6
					customEffectLingeringFXStrs[currentMainOp] = xFXPersistStrings[iPersist]
					EnchArsenal.SetLibraryTaperWeight(xTaperWeightArray[iPersist], fxOffset, FX_SCOPE)
					EnchArsenal.SetLibraryTaperCurve(xTaperCurveArray[iPersist], fxOffset, FX_SCOPE)
					EnchArsenal.SetLibraryTaperDuration(xTaperDurationArray[iPersist], fxOffset, FX_SCOPE)
				endif
				EnchArsenal.SetLibraryPersistFlag(iPersist, fxOffset, FX_SCOPE)
			endif

			bSubMenu = true
			RefreshPage()

		else ;ADVANCED DETAIL OPs (_op_AdvancedFX)
			int iOp = currentMainOp
			int fxOffset = iOp * 9
			int opIdx = _op_AdvancedFX.find(o)

			if (opIdx == 2) ;Expand Enchant Art Ops:
				expandedOps[iOp] = !expandedOps[iOp]

			elseif (opIdx == 0) ;Swap FX Shader Group:
				int iFX = (sFXTypes.find(pStrEnchShader[fxOffset]) + 1) % 9

				EffectShader esh = none
				;this is sort of convoluted, but can't think of a simpler way to do it:
				if sFXTypes[iFX] == WeaponMGEFShaderStrs[iOp]
					esh = effectDefaultsEnchShader[iOp]
					SetArrayStrs(pStrEnchShaderSpec, WeaponMGEFShaderStrsSpecDefault[iOp], fxOffset, FX_SCOPE)
				else
					int i = WeaponMGEFShaderStrs.find(sFXTypes[iFX])
					if i >= 0
						esh = effectDefaultsEnchShader[i]
					endif ;else user has chosen NONE; esh = none
					SetArrayStrs(pStrEnchShaderSpec, mothership.xEnchShaderStrings(iFX, filterShaders = false)[0], fxOffset, FX_SCOPE)
				endif
				SetArrayStrs(pStrEnchShader, sFXTypes[iFX], fxOffset, FX_SCOPE)
				EnchArsenal.SetLibraryEnchantShader(esh, fxOffset, FX_SCOPE)
				pCurrentGlobalFXSetting = "$CUSTOM"

			elseif (opIdx == 13) ;Swap FX Persist Setting:
				int iPersist
				if durationalEnchants.find(currentMainOp) >= 0
					if pStrFXPersistPreset[fxOffset] == "$Full Effect Duration"
						SetArrayStrs(pStrFXPersistPreset, "$NONE", fxOffset, FX_SCOPE)
						iPersist = 0
					else
						SetArrayStrs(pStrFXPersistPreset, "$Full Effect Duration", fxOffset, FX_SCOPE)
						iPersist = 1
					endif
				else
					iPersist = xFXPersistStrings.find(pStrFXPersistPreset[fxOffset])
					iPersist = (iPersist + 1) % 6
					SetArrayStrs(pStrFXPersistPreset, xFXPersistStrings[iPersist], fxOffset, FX_SCOPE)
					EnchArsenal.SetLibraryTaperWeight(xTaperWeightArray[iPersist], fxOffset, FX_SCOPE)
					EnchArsenal.SetLibraryTaperCurve(xTaperCurveArray[iPersist], fxOffset, FX_SCOPE)
					EnchArsenal.SetLibraryTaperDuration(xTaperDurationArray[iPersist], fxOffset, FX_SCOPE)
				endif
				EnchArsenal.SetLibraryPersistFlag(iPersist, fxOffset, FX_SCOPE)
				pCurrentGlobalFXSetting = "$CUSTOM"
			endif

			bSubMenu = true
			RefreshPage()
		endif
	endif
EndEvent



Function SetPresetEffects(int fxType, int presetIndex, int mgefCode)

	int fxOffset = mgefCode * 9

	int appliedMGEF = mgefCode
	int iOverride = mothership.fetchPresetOverride(fxType)[presetIndex]
	if (iOverride >= 0)
		appliedMGEF = iOverride
	;adjust defaults to resemble FX color instead of magic effect for better FX synergy:
	elseif (sFXTypes[fxType] != WeaponMGEFShaderStrs[mgefCode])
		int[] fxDefaultMgefs = new int[9]
		fxDefaultMgefs[0] = cEnchFire
		fxDefaultMgefs[1] = cEnchFrost
		fxDefaultMgefs[2] = cEnchShock
		fxDefaultMgefs[3] = cEnchMagickaDam
		fxDefaultMgefs[4] = cEnchStaminaDam
		fxDefaultMgefs[5] = cEnchBanish
		fxDefaultMgefs[6] = cEnchAbHealth
		fxDefaultMgefs[7] = cEnchFear
		fxDefaultMgefs[8] = 0

		appliedMGEF = fxDefaultMgefs[fxType]
	endif

	;First, set all defaults. Then we will override what's necessary:

	EffectShader  _eshE = effectDefaultsEnchShader[appliedMGEF]
	EffectShader  _eshH = effectDefaultsHitShader[appliedMGEF]
	Art           _artH = effectDefaultsHitArt[appliedMGEF]
	ImpactDataSet _ids  = effectDefaultsImpactData[appliedMGEF]
	Projectile    _proj = effectDefaultsProjectile[appliedMGEF]
	int           _fxP  = effectDefaultsFXPersist[appliedMGEF]
	float         _tWei = effectDefaultsTaperWeight[appliedMGEF]
	float         _tCur = effectDefaultsTaperCurve[appliedMGEF]
	float         _tDur = effectDefaultsTaperDuration[appliedMGEF]
	
	string str_eshE_shader = sFXTypes[fxType]

	string str_eshE_shaderSpec
	string str_eshE_shaderPreset
	if (sFXTypes[fxType] != WeaponMGEFShaderStrs[mgefCode])
		str_eshE_shaderSpec   = mothership.xEnchShaderStrings(fxType, false)[0]
		str_eshE_shaderPreset = mothership.xEnchShaderStrings(fxType, false)[0]
	else
		str_eshE_shaderSpec   = WeaponMGEFShaderStrsSpecDefault[mgefCode]
		str_eshE_shaderPreset = WeaponMGEFShaderStrsSpecDefault[mgefCode]
	endif

	int strIdx       = xHitShaderArray.find(_eshH)
	string str_eshH  = xHitShaderStrings[strIdx]
	strIdx           = xHitArtArray.find(_artH)
	string str_artH  = xHitArtStrings[strIdx]
	strIdx           = xImpactDataArray.find(_ids)
	string str_ids   = xImpactDataStrings[strIdx]
	strIdx           = xProjectileArray.find(_proj)
	string str_proj  = xProjectileStrings[strIdx]
	string str_fxP

	if (mgefCode == cEnchFear || mgefCode == cEnchSoulTrap || mgefCode == cEnchParalysis || mgefCode == cEnchTurnUndead)
		str_fxP = "$Full Effect Duration"
	else
		strIdx  = xTaperDurationArray.find(_tDur)
		str_fxP = xFXPersistStrings[strIdx]
	endif

	string[]      str_artE
	Art[]         _artE
	str_artE = new string[9]
	_artE    = new Art[9]

	int i = 9
	while i
		i -= 1
		str_artE[i] = "$NONE"
		_artE[i]    = none
	endWhile


	;BEGIN OVERRIDES-------------------------------------------------------------------->
	if (presetIndex > 0) ;(if zero, use defaults as already set up above)

		int idx

	  ;ENCHANT SHADER
		_eshE = mothership.xEnchShaderArray(fxType)[presetIndex]
		str_eshE_shaderPreset = mothership.xEnchShaderStrings(fxType, false)[presetIndex]
		int checkIdx = presetIndex
		while (!mothership.fetchIsEnchShaderInfo(fxType)[checkIdx]) && (checkIdx)
			checkIdx -= 1 ;move down preset array until finding correct shader string
		endWhile
		str_eshE_shaderSpec = mothership.xEnchShaderStrings(fxType, false)[checkIdx]

	  ;ENCHANT ART
		idx = mothership.fetchEnchArtInfo(fxType)[presetIndex]
		if idx >= 0
			;expandedOps[mgefCode] = true [undecided if I want to auto-expand these]
			int weapNum = 9
			while weapNum
				weapNum -= 1
				_artE[weapNum] = mothership.xEnchArtArray(weapNum)[idx]
				if (_artE[weapNum] != none)
					str_artE[weapNum] = xEnchArtStrings[idx]
				;elseif (idx > 0) ;no art, check to see if backup preset should be used
					;[this is gonna be way too complicated... gonna just give up I think...]
				endif
			endWhile
		endif

	  ;HIT SHADER
		idx = mothership.fetchHitShaderInfo(fxType)[presetIndex]
		if idx >= 0
			_eshH = xHitShaderArray[idx]
			str_eshH = xHitShaderStrings[idx]
		endif

	  ;HIT ART
		idx = mothership.fetchHitArtInfo(fxType)[presetIndex]
		if idx >= 0
			_artH = xHitArtArray[idx]
			str_artH = xHitArtStrings[idx]
		endif

	  ;IMPACT DATA
		idx = mothership.fetchImpactDataInfo(fxType)[presetIndex]
		if idx >= 0
			_ids = xImpactDataArray[idx]
			str_ids = xImpactDataStrings[idx]
		endif

	  ;PROJECTILE
		idx = mothership.fetchProjectileInfo(fxType)[presetIndex]
		if idx >= 0
			_proj = xProjectileArray[idx]
			str_proj = xProjectileStrings[idx]
		endif

	  ;FX PERSIST + TAPER VALS
		int fxVal = mothership.fetchFXPersistInfo(fxType)[presetIndex]
		if fxVal >= 0
			_fxP = fxVal
		endif
		float tVal = mothership.fetchTaperWeightInfo(fxType)[presetIndex]
		if tVal >= 0
			_tWei = tVal
		endif
		tVal = mothership.fetchTaperCurveInfo(fxType)[presetIndex]
		if tVal >= 0
			_tCur = tVal
		endif
		tVal = mothership.fetchTaperDurationInfo(fxType)[presetIndex]
		if tVal >= 0
			_tDur = tVal
		endif
		if (!_fxP)
			str_fxP = "$NONE"
		elseif (mgefCode == cEnchFear || mgefCode == cEnchSoulTrap || mgefCode == cEnchParalysis || mgefCode == cEnchTurnUndead)
				str_fxP = "$Full Effect Duration"
		else
			idx = 6
			while idx
				idx -= 1
				if (_tDur >= xTaperDurationArray[idx])
					str_fxP = xFXPersistStrings[idx]
					idx = 0
				endIf
			endWhile
		endif

	endif

	SetArrayStrs(pStrEnchShader, str_eshE_shader, fxOffset, FX_SCOPE)
	SetArrayStrs(pStrEnchShaderSpec, str_eshE_shaderSpec, fxOffset, FX_SCOPE)
	SetArrayStrs(pStrEnchShaderPreset, str_eshE_shaderPreset, fxOffset, FX_SCOPE)
	SetArrayStrs(pStrHitShader, str_eshH, fxOffset, FX_SCOPE)
	SetArrayStrs(pStrHitArt, str_artH, fxOffset, FX_SCOPE)
	SetArrayStrs(pStrImpactData, str_ids, fxOffset, FX_SCOPE)
	SetArrayStrs(pStrProjectile, str_proj, fxOffset, FX_SCOPE)
	SetArrayStrs(pStrFXPersistPreset, str_fxP, fxOffset, FX_SCOPE)

	i = 9
	int thisFX = fxOffset + 9
	while i
		i -= 1
		thisFX -= 1
		pEnchShader[thisFX] = _eshE
		pEnchArt[thisFX] = _artE[i]
		SetArrayStrs(pStrEnchArt, str_artE[i], thisFX, FX_ENTRY)
		EnchArsenal.SetLibraryEnchantArt(_artE[i], thisFX, FX_ENTRY)
		pHitShader[thisFX] = _eshH
		pHitArt[thisFX] = _artH
		pImpactData[thisFX] = _ids
		pProjectile[thisFX] = _proj
		pFXPersistPreset[thisFX] = _fxP
		pTaperWeight[thisFX] = _tWei
		pTaperCurve[thisFX] = _tCur
		pTaperDuration[thisFX] = _tDur
	endWhile


	EnchArsenal.SetLibraryEnchantShader(_eshE, fxOffset, FX_SCOPE)
	EnchArsenal.SetLibraryHitShader(_eshH, fxOffset, FX_SCOPE)
	EnchArsenal.SetLibraryHitArt(_artH, fxOffset, FX_SCOPE)
	EnchArsenal.SetLibraryImpactData(_ids, fxOffset, FX_SCOPE)
	EnchArsenal.SetLibraryProjectile(_proj, fxOffset, FX_SCOPE)
	EnchArsenal.SetLibraryPersistFlag(_fxP, fxOffset, FX_SCOPE)
	EnchArsenal.SetLibraryTaperWeight(_tWei, fxOffset, FX_SCOPE)
	EnchArsenal.SetLibraryTaperCurve(_tCur, fxOffset, FX_SCOPE)
	EnchArsenal.SetLibraryTaperDuration(_tDur, fxOffset, FX_SCOPE)
EndFunction


Function ExtractPresetInfo(string infoStr, int[] fxTypes, int[] presetIndices)
{takes in two empty 14 length arrays and fills them from the data string}
	;13 spaces, 14 hyphens
	string tempStr
	int idx1 = 0
	int idx2 = 0
	int i = 0
	while (idx1 < 14)
		i = StringUtil.find(infoStr, "-")
		tempStr = StringUtil.subString(infoStr, 0, i)
		fxTypes[idx1] = tempStr as int
		infoStr = StringUtil.subString(infoStr, (i + 1))
		i = StringUtil.find(infoStr, " ")
		tempStr = StringUtil.subString(infoStr, 0, i)
		presetIndices[idx2] = tempStr as int
		infoStr = StringUtil.subString(infoStr, (i + 1))
		idx1 += 1
		idx2 += 1
	endWhile
 EndFunction



Event onOptionHighlight(int o)
	;reserved
	if (demoOps.find(o) >= 0) ;DEMO OPs

		if o == demoOps[0]
			SetInfoText("$Choose the visual feature you would like to demo.")
		elseif o == demoOps[1]
			SetInfoText("$Choose the Enchantment to use for the demo. You must wield a weapon with this enchantment during the demo to see any changes.")
		elseif o == demoOps[5]
			SetInfoText("$Choose an Enchant Shader FX Type to begin with. The demo will continue to the next color after all of these are displayed.")
		endif
	endif
EndEvent










;______________________________________________________________________________________________________________________
;================== CUSTOM ENCHANTMENT FUNCTIONS ======================================================================
;``````````````````````````````````````````````````````````````````````````````````````````````````````````````````````

int[]			property _customizeMenuOps auto hidden
bool[]			property _customExpandedOps auto hidden
int[]			property _customizeMenuHeaderOps auto hidden

MagicEffect[]	property enchList auto hidden ;grabbing from mothership

int 			property customCurrentIndex = 0 auto hidden ;keep this equal to the next open slot
MagicEffect[] 	property customEffect auto hidden ;costliest effect      ;make "default" placeholders to put in array when default being used. otherwise lookup string.
EffectShader[] 	property customEffectEnchShader auto hidden
EffectShader[] 	property customEffectHitShader auto hidden
Art[] 			property customEffectEnchArt auto hidden
Art[] 			property customEffectHitArt auto hidden
bool[]			property customEffectIsDurational auto hidden ;determines what options to show for Lingering FX
int[]			property customEffectLingeringFX auto hidden ;uses xFXPersistStrings, but uses index of 6 to indicate Default

string[]		property customEffectStrs auto hidden
string[] 		property customEffectEnchShaderStrs auto hidden
string[]		property customEffectEnchShaderStrsSpec auto hidden
string[]	 	property customEffectHitShaderStrs auto hidden
string[] 		property customEffectEnchArtStrs auto hidden
string[] 		property customEffectHitArtStrs auto hidden
string[]		property customEffectLingeringFXStrs auto hidden
; float[]			property customEffectTWeight auto
; float[]			property customEffectTCurve auto ;defaults (save internally)
; float[]			property customEffectTDuration auto
Art property defaultArt auto hidden
EffectShader property defaultShader auto hidden


Function SetupCustomizationUpdate(EAr_Mothership headquarters)
	enchList = headquarters.enchList
	_customizeMenuOps = new int[32]
	_customExpandedOps = new bool[14]
	_customizeMenuHeaderOps = new int[2]

	customEffectStrs = new string[14]
	customEffectEnchShaderStrs = new string[14]
	customEffectEnchShaderStrsSpec = new string[14]
	customEffectEnchArtStrs = new string[126]
	customEffectHitShaderStrs = new string[14]
	customEffectHitArtStrs = new string[14]
	customEffectLingeringFXStrs = new string[14]

	customEffectEnchShader = new EffectShader[14]
	customEffectHitShader = new EffectShader[14]
	customEffectEnchArt = new Art[126]
	customEffectHitArt = new Art[14]
	customEffect = new MagicEffect[14]
	customEffectIsDurational = new bool[14]
	customEffectLingeringFX = new int[14]
	int i = 0
	defaultArt = game.getFormFromFile(0x0840, "EnchantedArsenal.esp") as Art
	defaultShader = game.getFormFromFile(0x096E, "EnchantedArsenal.esp") as EffectShader
	while i < 14
		customEffectEnchShader[i] = defaultShader
		customEffectHitArt[i] = defaultArt
		customEffectHitShader[i] = defaultShader
		customEffectEnchShaderStrs[i] = "$Special FX"
		customEffectEnchShaderStrsSpec[i] = "$DEFAULT"
		customEffectHitArtStrs[i] = "$DEFAULT"
		customEffectHitShaderStrs[i] = "$DEFAULT"
		int j = i * 9
		int k = (i * 9) + 9
		while j < k
			customEffectEnchArt[j] = defaultArt
			customEffectEnchArtStrs[j] = "$DEFAULT"
			j += 1
		endWhile
		i += 1
	endWhile
EndFunction


Function RunCustomizationUpkeep() ;removes any forms that originated from mods that are no longer loaded
	int[] removeForms = new int[14]
	EnchArsenal.CheckForMissingCustomEnchantments(removeForms)
	int i = 0
	while (removeForms[i] >= 0 && i < 14)
		RemoveCustomEffect(removeForms[i], bUpkeep = true)
		i += 1
	endWhile
EndFunction


Function AddNewCustomEffect() ;add currently equipped weapon's enchantment to MCM as custom editable effect
	MagicEffect[] thisMGEF = new MagicEffect[1]
	bool[] thisPersistInfo = new bool[2] ;idx 0 == has Duration?   idx 1 == is persist flag set?
	string newEnchName = EnchArsenal.AddCustomEnchantment(thisMGEF, thisPersistInfo) ;grabs from right hand

	if (newEnchName == "_CANT_PROCESS_")
		ShowMessage("$There was an error trying to process the effects of this enchantment. It will not be added.", false, "$Okay")
		return
	elseif (newEnchName == "_INVALID_" || thisMGEF[0] == none)
		ShowMessage("$The weapon you're wielding in your right hand doesn't seem to be enchanted.", false, "$Okay")
		return
	elseif (newEnchName == "_DUPLICATE_")
		int idxCheck = enchList.find(thisMGEF[0])
		if (idxCheck >= 0)
			ShowMessage("$The weapon you're wielding uses a vanilla enchantment that can already be edited in the MCM...", false, "$Continue")
			ShowMessage(WeaponMGEFStrs[idxCheck], false, "$Okay")
		else
			idxCheck = customEffect.find(thisMGEF[0])
			ShowMessage("$It looks like you've already added the enchantment on this weapon to your custom options...", false, "$Okay")
			ShowMessage(customEffectStrs[idxCheck], false, "$Okay")
		endif
		return
	elseif (customCurrentIndex >= 100)
		ShowMessage("$You have already reached the maximum number of 14 custom enchantments. No more can be added.", false, "$Okay")
		return
	endif

	;otherwise, valid new enchantment -->
	ShowMessage("$Setting up new enchantment... The custom effect name will display now. You can keep or change it.", false, "$Show Name")
	if (!newEnchName)
		newEnchName = "CUSTOM " + customCurrentIndex
	endif
	if !ShowMessage(newEnchName, true, "$Keep", "$Change")
		string entryString = GetTextEntry()
		if (entryString != "__error__")
			newEnchName = entryString
		endif
	endif

	;ADD NEW EFFECT
	customEffect[customCurrentIndex] = thisMGEF[0]
	customEffectStrs[customCurrentIndex] = newEnchName
	customEffectIsDurational[customCurrentIndex] = thisPersistInfo[0]
	customEffectLingeringFX[customCurrentIndex] = thisPersistInfo[1] as int
	if (thisPersistInfo[0] && thisPersistInfo[1])
		customEffectLingeringFXStrs[customCurrentIndex] = "$Full Effect Duration"
	elseif (!thisPersistInfo[0] && thisPersistInfo[1])
		customEffectLingeringFXStrs[customCurrentIndex] = "$Slight"
	else
		customEffectLingeringFXStrs[customCurrentIndex] = "$NONE"
	endif

	if (!EnchArsenal.GetLibraryCustomEnchantShader(customCurrentIndex * 9)) ;no default enchant shader, need to set one so enchant art will work:
		EnchArsenal.SetLibraryCustomEnchantShader(defaultShader, customCurrentIndex * 9, FX_SCOPE)
	endif

	customCurrentIndex += 1
EndFunction


Function RemoveCustomEffect(int index, bool bUpkeep = false)
	EnchArsenal.RemoveCustomEnchantment(index)
	int i = index
	customCurrentIndex -= 1
	while i < customCurrentIndex
		customEffect[i] = customEffect[i + 1]
		customEffectStrs[i] = customEffectStrs[i + 1]
		customEffectIsDurational[i] = customEffectIsDurational[i + 1]
		customEffectLingeringFX[i] = customEffectLingeringFX[i + 1]
		customEffectEnchShaderStrs[i] = customEffectEnchShaderStrs[i + 1]
		customEffectEnchArtStrs[i] = customEffectEnchArtStrs[i + 1]
		customEffectHitShaderStrs[i] = customEffectHitShaderStrs[i + 1]
		customEffectHitArtStrs[i] = customEffectHitArtStrs[i + 1]
		customEffectEnchShader[i] = customEffectEnchShader[i + 1]
		customEffectHitShader[i] = customEffectHitShader[i + 1]
		customEffectEnchArt[i] = customEffectEnchArt[i + 1]
		customEffectHitArt[i] = customEffectHitArt[i + 1]
		i += 1
	endWhile

	customEffect[customCurrentIndex] = none
	customEffectStrs[customCurrentIndex] = ""
	customEffectIsDurational[customCurrentIndex] = 0
	customEffectLingeringFX[customCurrentIndex] = 0
	customEffectEnchShaderStrs[customCurrentIndex] = "$Special FX"
	customEffectEnchArtStrs[customCurrentIndex] = "$DEFAULT"
	customEffectEnchShaderStrsSpec[customCurrentIndex] = "$DEFAULT"
	customEffectHitShaderStrs[customCurrentIndex] = "$DEFAULT"
	customEffectHitArtStrs[customCurrentIndex] = "$DEFAULT"
	customEffectEnchShader[customCurrentIndex] = defaultShader
	customEffectHitShader[customCurrentIndex] = defaultShader
	customEffectEnchArt[customCurrentIndex] = defaultArt
	customEffectHitArt[customCurrentIndex] = defaultArt

	if (bUpkeep)
		return
	endif

	ShowMessage("The chosen enchantment has been removed from you customization list. Restart your game to reset any altered visual effects on this enchantment.", false, "$Okay")

EndFunction




;______________________________________________________________________________________________________________________
;================== FISS PRESET FUNCTIONS =============================================================================
;``````````````````````````````````````````````````````````````````````````````````````````````````````````````````````

string Function GetTextEntry()
	int letterCounter
	displayString = " " ;starting space is required to avoid papyrus string caching issues
	currentChar = ""
	;the safetyMechanism is required to prevent crashes caused by fast typing. Users can type in between
	;separate iterations of the menu pop up, navigating away from the page and out of the MCM itself, at
	;which point trying to call ShowMessage crashes the game. This safetyMechanism prevents that from
	;happening by terminating text input and closing all messages once focus on this option is lost.
	string safetyPlace = "_root.ConfigPanelFader.configPanel.contentHolder.optionsPanel.optionsList.selectedIndex"
	int safetyMechanism = UI.GetInt("Journal Menu", safetyPlace)
	GoToState("RegisterInputState") ;start tracking keypresses             ;<<<<<<<<<<<<<<<<<<<<<<<<<
	typingMessage = true
	while typingMessage && (safetyMechanism == UI.GetInt("Journal Menu", safetyPlace))
		typingMessage = false
		if currentChar == ""
			ShowMessage("$Begin Typing a New Preset Name. (You MUST type slowly)", false, "$Cancel")
		elseif currentChar == "DEL"
			if letterCounter > 0
				displayString = stringUtil.subString(displayString, 0, letterCounter)
				letterCounter -= 1
				if !letterCounter
					currentChar = ""
				endif
			endif
			ShowMessage(displayString, true, "$Confirm New Name", "$Cancel")
		elseif currentChar != "ENT" ;enter will close the menu
			int curLength = stringUtil.getLength(displayString)
			if curLength < 41 ;max character limit
				letterCounter += 1
				string sTemp = stringUtil.subString(displayString, 0, letterCounter)
				displayString = sTemp + currentChar
				ShowMessage(displayString, true, "$Confirm New Name", "$Cancel")
			else 
				ShowMessage(displayString ;/+ "\n\nCharacter Limit Reached"/;, true, "$Confirm New Name", "$Cancel")
			endif
		endif
	endWhile
	GoToState("")

	if (safetyMechanism == UI.GetInt("Journal Menu", safetyPlace)) && currentChar == "ENT"
		if letterCounter
			displayString = stringUtil.subString(displayString, 1, letterCounter)
			return displayString
		endif
	endif
	return "__error__"
EndFunction

Function RenameFISSPreset()
	string newPresetName = GetTextEntry()
	if (newPresetName != "__error__")

		if !ShowMessage("$Renaming a preset usually takes about 60 seconds. Please do not leave the MCM menu until the messagebox pops up saying the preset has been renamed.", true, "$Okay", "$Cancel")
			return
		endif
		if !OverwriteFISSPreset(newPresetName, currentPreset, currentPreset, markDeleted = false) ;fiss error
			ShowMessage("$There was an unexpected error while attempting to rename your preset. Please ensure that the ''Data\\SKSE\\Plugins\\FISS\\Enchanted Arsenal'' directory and its contents have not been deleted.", false, "$Okay")
		else
			ShowMessage("$Your preset has been successfully renamed!", false, "$Okay")
			refreshPage()
		endif
	endif
EndFunction


Function SaveFISSPreset()

	if !ShowMessage("$Saving a preset usually takes about 60 seconds. Please do not leave the MCM menu until the messagebox pops up saying the save is complete.", true, "$Okay", "$Cancel")
		return
	endif

	fiss.beginSave(FISS_PresetFilepath[currentPreset], "EnchantedArsenal")

		fiss.saveString("PresetTitle", FISS_PresetTitle[currentPreset])
		fiss.saveBool("HasData", true)
		fiss.saveString("pCurrentGlobalFXSetting", pCurrentGlobalFXSetting)

		int[] localFormID = new int[128] ;six digit formID local to the plugin
		int[] fromSkyrimEsm = new int[128] ; 1 = from Skyrim.esm / 0 = from EnchantedArsenal.esp
		int i = 0

		EnchArsenal.SaveTranslateShaders(pEnchShader, localFormID, fromSkyrimEsm)
		while i < 126
			fiss.saveInt("eShaderForm" + i, localFormID[i])
			fiss.saveInt("eShaderFile" + i, fromSkyrimEsm[i])
			fiss.saveString("eShaderStr" + i, pStrEnchShader[i])
			fiss.saveString("eShaderStrPreset" + i, pStrEnchShaderPreset[i])
			fiss.saveString("eShaderStrSpec" + i, pStrEnchShaderSpec[i])
			i += 1
		endWhile

		i = 0
		EnchArsenal.SaveTranslateArt(pEnchArt, localFormID, fromSkyrimEsm)
		while i < 126
			fiss.saveInt("eArtForm" + i, localFormID[i])
			fiss.saveInt("eArtFile" + i, fromSkyrimEsm[i])
			fiss.saveString("eArtStr" + i, pStrEnchArt[i])
			i += 1
		endWhile

		i = 0
		EnchArsenal.SaveTranslateShaders(pHitShader, localFormID, fromSkyrimEsm)
		while i < 126
			fiss.saveInt("hShaderForm" + i, localFormID[i])
			fiss.saveInt("hShaderFile" + i, fromSkyrimEsm[i])
			fiss.saveString("hShaderStr" + i, pStrHitShader[i])
			i += 1
		endWhile

		i = 0
		EnchArsenal.SaveTranslateArt(pHitArt, localFormID, fromSkyrimEsm)
		while i < 126
			fiss.saveInt("hArtForm" + i, localFormID[i])
			fiss.saveInt("hArtFile" + i, fromSkyrimEsm[i])
			fiss.saveString("hArtStr" + i, pStrHitArt[i])
			i += 1
		endWhile

		i = 0
		EnchArsenal.SaveTranslateImpactData(pImpactData, localFormID, fromSkyrimEsm)
		while i < 126
			fiss.saveInt("impDataForm" + i, localFormID[i])
			fiss.saveInt("impDataFile" + i, fromSkyrimEsm[i])
			fiss.saveString("impDataStr" + i, pStrImpactData[i])
			i += 1
		endWhile

		i = 0
		EnchArsenal.SaveTranslateProjectiles(pProjectile, localFormID, fromSkyrimEsm)
		while i < 126
			fiss.saveInt("projForm" + i, localFormID[i])
			fiss.saveInt("projFile" + i, fromSkyrimEsm[i])
			fiss.saveString("projStr" + i, pStrProjectile[i])
			i += 1
		endWhile

		i = 0
		while i < 126
			fiss.saveFloat("tWei" + i, pTaperWeight[i])
			fiss.saveFloat("tCur" + i, pTaperCurve[i])
			fiss.saveFloat("tDur" + i, pTaperDuration[i])
			fiss.saveInt("fxpFlag" + i, pFXPersistPreset[i])
			fiss.saveString("fxpStr" + i, pStrFXPersistPreset[i])
			i += 1
		endWhile

	string saveResult = fiss.endSave()
	; check the result
	if saveResult != ""
		debug.trace("EnchantedArsenal - Preset Save Error: " + saveResult)
		ShowMessage("$There was an unexpected error while attempting to save your presets. Please ensure that the ''Data\\SKSE\\Plugins\\FISS\\Enchanted Arsenal'' directory and its contents have not been deleted.", false, "$Okay")
	else 
		ShowMessage("$Your settings have been successfully saved to this preset!", false, "$Okay")
	endif
	refreshPage()
EndFunction


Function LoadFISSPreset()

	if !ShowMessage("$Are you sure? Loading this preset will overwrite all your current settings.", true, "$Load ", "$Cancel")
		return
	endif
	if !ShowMessage("$Okay. Please do not leave the MCM menu until the messagebox pops up saying the load is complete.", true, "$Begin Load", "$Cancel")
		return
	endif

	fiss.beginLoad(FISS_PresetFilepath[currentPreset])

		pCurrentGlobalFXSetting = fiss.loadString("pCurrentGlobalFXSetting")

		string[] sourceFile = new string[2]
		sourceFile[0] = "EnchantedArsenal.esp"
		sourceFile[1] = "Skyrim.esm"
		int tempFormID
		int tempIndex
		int i = 0

		while i < 126
			tempFormID = fiss.loadInt("eShaderForm" + i)
			tempIndex = fiss.loadInt("eShaderFile" + i)
			pEnchShader[i] = game.getFormFromFile(tempFormID, sourceFile[tempIndex]) as EffectShader
			pStrEnchShader[i] = fiss.loadString("eShaderStr" + i)
			pStrEnchShaderPreset[i] = fiss.loadString("eShaderStrPreset" + i)
			pStrEnchShaderSpec[i] = fiss.loadString("eShaderStrSpec" + i)
			i += 1
		endWhile

		i = 0
		while i < 126
			tempFormID = fiss.loadInt("eArtForm" + i)
			tempIndex = fiss.loadInt("eArtFile" + i)
			pEnchArt[i] = game.getFormFromFile(tempFormID, sourceFile[tempIndex]) as Art
			pStrEnchArt[i] = fiss.loadString("eArtStr" + i)
			i += 1
		endWhile

		i = 0
		while i < 126
			tempFormID = fiss.loadInt("hShaderForm" + i)
			tempIndex = fiss.loadInt("hShaderFile" + i)
			pHitShader[i] = game.getFormFromFile(tempFormID, sourceFile[tempIndex]) as EffectShader
			pStrHitShader[i] = fiss.loadString("hShaderStr" + i)
			i += 1
		endWhile

		i = 0
		while i < 126
			tempFormID = fiss.loadInt("hArtForm" + i)
			tempIndex = fiss.loadInt("hArtFile" + i)
			pHitArt[i] = game.getFormFromFile(tempFormID, sourceFile[tempIndex]) as Art
			pStrHitArt[i] = fiss.loadString("hArtStr" + i)
			i += 1
		endWhile

		i = 0
		while i < 126
			tempFormID = fiss.loadInt("impDataForm" + i)
			tempIndex = fiss.loadInt("impDataFile" + i)
			pImpactData[i] = game.getFormFromFile(tempFormID, sourceFile[tempIndex]) as ImpactDataSet
			pStrImpactData[i] = fiss.loadString("impDataStr" + i)
			i += 1
		endWhile

		i = 0
		while i < 126
			tempFormID = fiss.loadInt("projForm" + i)
			tempIndex = fiss.loadInt("projFile" + i)
			pProjectile[i] = game.getFormFromFile(tempFormID, sourceFile[tempIndex]) as Projectile
			pStrProjectile[i] = fiss.loadString("projStr" + i)
			i += 1
		endWhile

		i = 0
		while i < 126
			pTaperWeight[i] = fiss.loadFloat("tWei" + i)
			pTaperCurve[i] = fiss.loadFloat("tCur" + i)
			pTaperDuration[i] = fiss.loadFloat("tDur" + i)
			pFXPersistPreset[i] = fiss.loadInt("fxpFlag" + i)
			pStrFXPersistPreset[i] = fiss.loadString("fxpStr" + i)
			i += 1
		endWhile

	string loadResult = fiss.endLoad()
	if loadResult != "" ;error
		ShowMessage("$Error reading preset file. Please ensure that the ''Data\\SKSE\\Plugins\\FISS\\Enchanted Arsenal'' directory and its contents have not been deleted.", false, "$Okay")
	endif

	; NOTE!!! The following call does NOT actually APPLY any of these effects, it only establishes them in the internal library.
	;         This is fine for now how I have things designed, since all effects are re-applied on every draw/equip event, but
	;         may need to be changed in the future if any of this infrastructure is redesigned.
	if !EnchArsenal.SetupMGEFInfoLibrary(pEnchShader, pEnchArt, pHitShader, pHitArt, pProjectile, pImpactData, pFXPersistPreset, pTaperWeight, pTaperCurve, pTaperDuration)
		ShowMessage("$Preset Load Error.", false, "$Okay")
	else
		ShowMessage("$Preset has been loaded successfully!", false, "$Okay")
	endif
	refreshPage()
EndFunction


Function DeleteFISSPreset()
	if !ShowMessage("$Are you sure?", true, "$Delete", "$Cancel")
		return
	endif
	if !ShowMessage("$This will take about 60 seconds. Please wait until the messagebox pops up saying the preset has been deleted.", true, "$Okay", "$Cancel")
		return
	endif

	if !OverwriteFISSPreset(FISS_PresetTitle[currentPreset], FISS_DEFAULT_SETTINGS, currentPreset, markDeleted = true)
		ShowMessage("$There was an unexpected error while attempting to delete this preset. Please ensure that the ''Data\\SKSE\\Plugins\\FISS\\Enchanted Arsenal'' directory and its contents have not been removed.", false, "$Okay")
	else
		ShowMessage("$The preset has been deleted successfully.", false, "$Okay")
	endif

	refreshPage()
EndFunction


;used for Delete & Rename process
bool Function OverwriteFISSPreset(string nameToApply, int sourceFile, int destFile, bool markDeleted)

	int i = 0
	string globalFXSetting
	int[] eShaderForm = new int[126]
	int[] eShaderFile = new int[126]
	string[] eShaderStr = new string[126]
	string[] eShaderStrPreset = new string[126]
	string[] eShaderStrSpec = new string[126]
	int[] eArtForm = new int[126]
	int[] eArtFile = new int[126]
	string[] eArtStr = new string[126]
	int[] hShaderForm = new int[126]
	int[] hShaderFile = new int[126]
	string[] hShaderStr = new string[126]
	int[] hArtForm = new int[126]
	int[] hArtFile = new int[126]
	string[] hArtStr = new string[126]
	int[] impDataForm = new int[126]
	int[] impDataFile = new int[126]
	string[] impDataStr = new string[126]
	int[] projForm = new int[126]
	int[] projFile = new int[126]
	string[] projStr = new string[126]
	float[] tWei = new float[126]
	float[] tCur = new float[126]
	float[] tDur = new float[126]
	int[] fxpFlag = new int[126]
	string[] fxpStr = new string[126]

	fiss.beginLoad(FISS_PresetFilepath[sourceFile])

		globalFXSetting = fiss.loadString("pCurrentGlobalFXSetting")

		i = 0
		while i < 126
			eShaderForm[i] = fiss.loadInt("eShaderForm" + i)
			eShaderFile[i] = fiss.loadInt("eShaderFile" + i)
			eShaderStr[i] = fiss.loadString("eShaderStr" + i)
			eShaderStrPreset[i] = fiss.loadString("eShaderStrPreset" + i)
			eShaderStrSpec[i] = fiss.loadString("eShaderStrSpec" + i)
			i += 1
		endWhile

		i = 0
		while i < 126
			eArtForm[i] = fiss.loadInt("eArtForm" + i)
			eArtFile[i] = fiss.loadInt("eArtFile" + i)
			eArtStr[i] = fiss.loadString("eArtStr" + i)
			i += 1
		endWhile

		i = 0
		while i < 126
			hShaderForm[i] = fiss.loadInt("hShaderForm" + i)
			hShaderFile[i] = fiss.loadInt("hShaderFile" + i)
			hShaderStr[i] = fiss.loadString("hShaderStr" + i)
			i += 1
		endWhile

		i = 0
		while i < 126
			hArtForm[i] = fiss.loadInt("hArtForm" + i)
			hArtFile[i] = fiss.loadInt("hArtFile" + i)
			hArtStr[i] = fiss.loadString("hArtStr" + i)
			i += 1
		endWhile

		i = 0
		while i < 126
			impDataForm[i] = fiss.loadInt("impDataForm" + i)
			impDataFile[i] = fiss.loadInt("impDataFile" + i)
			impDataStr[i] = fiss.loadString("impDataStr" + i)
			i += 1
		endWhile

		i = 0
		while i < 126
			projForm[i] = fiss.loadInt("projForm" + i)
			projFile[i] = fiss.loadInt("projFile" + i)
			projStr[i] = fiss.loadString("projStr" + i)
			i += 1
		endWhile

		i = 0
		while i < 126
			tWei[i] = fiss.loadFloat("tWei" + i)
			tCur[i] = fiss.loadFloat("tCur" + i)
			tDur[i] = fiss.loadFloat("tDur" + i)
			fxpFlag[i] = fiss.loadInt("fxpFlag" + i)
			fxpStr[i] = fiss.loadString("fxpStr" + i)
			i += 1
		endWhile

	string loadResult = fiss.endLoad()
	if loadResult != "" ;error
		debug.trace("Enchanted Arsenal - Preset Load Error During Rename/Delete: " + loadResult)
		return false
	endif

	fiss.beginSave(FISS_PresetFilepath[destFile], "EnchantedArsenal")

		fiss.saveString("PresetTitle", nameToApply)
		fiss.saveBool("HasData", !markDeleted)
		fiss.saveString("pCurrentGlobalFXSetting", globalFXSetting)

		i = 0
		while i < 126
			fiss.saveInt("eShaderForm" + i, eShaderForm[i])
			fiss.saveInt("eShaderFile" + i, eShaderFile[i])
			fiss.saveString("eShaderStr" + i, eShaderStr[i])
			fiss.saveString("eShaderStrPreset" + i, eShaderStrPreset[i])
			fiss.saveString("eShaderStrSpec" + i, eShaderStrSpec[i])
			i += 1
		endWhile

		i = 0
		while i < 126
			fiss.saveInt("eArtForm" + i, eArtForm[i])
			fiss.saveInt("eArtFile" + i, eArtFile[i])
			fiss.saveString("eArtStr" + i, eArtStr[i])
			i += 1
		endWhile

		i = 0
		while i < 126
			fiss.saveInt("hShaderForm" + i, hShaderForm[i])
			fiss.saveInt("hShaderFile" + i, hShaderFile[i])
			fiss.saveString("hShaderStr" + i, hShaderStr[i])
			i += 1
		endWhile

		i = 0
		while i < 126
			fiss.saveInt("hArtForm" + i, hArtForm[i])
			fiss.saveInt("hArtFile" + i, hArtFile[i])
			fiss.saveString("hArtStr" + i, hArtStr[i])
			i += 1
		endWhile

		i = 0
		while i < 126
			fiss.saveInt("impDataForm" + i, impDataForm[i])
			fiss.saveInt("impDataFile" + i, impDataFile[i])
			fiss.saveString("impDataStr" + i, impDataStr[i])
			i += 1
		endWhile

		i = 0
		while i < 126
			fiss.saveInt("projForm" + i, projForm[i])
			fiss.saveInt("projFile" + i, projFile[i])
			fiss.saveString("projStr" + i, projStr[i])
			i += 1
		endWhile

		i = 0
		while i < 126
			fiss.saveFloat("tWei" + i, tWei[i])
			fiss.saveFloat("tCur" + i, tCur[i])
			fiss.saveFloat("tDur" + i, tDur[i])
			fiss.saveInt("fxpFlag" + i, fxpFlag[i])
			fiss.saveString("fxpStr" + i, fxpStr[i])
			i += 1
		endWhile

	string saveResult = fiss.endSave()
	if saveResult != "" ;error
		debug.trace("Enchanted Arsenal - Save Access Error During Rename/Delete: " + saveResult)
		return false
	endif

	return true
EndFunction







;______________________________________________________________________________________________________________________
;================== STRING INIT & DATA IMPORT =========================================================================
;``````````````````````````````````````````````````````````````````````````````````````````````````````````````````````
string		pCurrentGlobalFXSetting ;global FX preset. "DEFAULT" to start, and "CUSTOM" if specific things are edited
string[]	FXSettingMenuStrs
string[]    FXGlobalPresets
string[]	ModNameStrs
string[]	AuthorStrs
string[]	ModIDStrs
bool[]		expandedOps
string[]	advancedOpStrings
string[]	advancedArtOpStrings

string		GRIMELEVEN_STRING = "$Animated Enchantments Overhaul  (GRIMELEVEN)" ;referenced in multiple places

Function InitializeMenuStrings()

	pCurrentGlobalFXSetting = "$DEFAULT"

	FXSettingMenuStrs = new string[128]
	FXGlobalPresets   = new string[128]

	; sFXTypes[0] = "$Fire FX"
	; sFXTypes[1] = "$Frost FX"
	; sFXTypes[2] = "$Shock FX"
	; sFXTypes[3] = "$Blue FX"
	; sFXTypes[4] = "$Green FX"
	; sFXTypes[5] = "$Purple FX"
	; sFXTypes[6] = "$Red FX"
	; sFXTypes[7] = "$Special FX"
	; sFXTypes[8] = "$NONE"

	 ; WeaponMGEFShaderStrs[cEnchFire]			= "$Fire FX"    0    (0)
	 ; WeaponMGEFShaderStrs[cEnchFrost]			= "$Frost FX"   1    (1)
	 ; WeaponMGEFShaderStrs[cEnchShock]			= "$Shock FX"   2    (2)
	 ; WeaponMGEFShaderStrs[cEnchSoulTrap]		= "$Purple FX"  3    (5)
	 ; WeaponMGEFShaderStrs[cEnchAbHealth]		= "$Red FX"     4    (6)
	 ; WeaponMGEFShaderStrs[cEnchAbStamina]		= "$Green FX"   5    (4)
	 ; WeaponMGEFShaderStrs[cEnchAbMagicka]		= "$Blue FX"    6    (3)
	 ; WeaponMGEFShaderStrs[cEnchStaminaDam]	= "$Green FX"   7    (4)
	 ; WeaponMGEFShaderStrs[cEnchMagickaDam]	= "$Blue FX"    8    (3)
	 ; WeaponMGEFShaderStrs[cEnchTurnUndead]	= "$Blue FX"    9    (3)
	 ; WeaponMGEFShaderStrs[cEnchParalysis]		= "$Green FX"   10   (4)
	 ; WeaponMGEFShaderStrs[cEnchBanish]		= "$Purple FX"  11   (5)
	 ; WeaponMGEFShaderStrs[cEnchFear]			= "$Red FX"     12   (6)
	 ; WeaponMGEFShaderStrs[cEnchSilentMoons]	= "$Green FX"   13   (4)

	;FXGlobalPresets store, for the 14 magic effects the location of default presets. Format is:  X-Y  where  X=sFXType  &  Y=presetIndex

	FXSettingMenuStrs[0]  = "$DEFAULT"
	FXGlobalPresets[0]															= "0-0 1-0 2-0 5-0 6-0 4-0 3-0 4-0 3-0 3-0 4-0 5-0 6-0 4-0"
	FXSettingMenuStrs[1]  = "$Animated Weapon Enchants  (Vysh)" ;Vysh
	FXGlobalPresets[1]                                                      	= "0-1 1-1 2-1 3-3 6-2 4-2 3-2 4-1 3-1 7-1 4-3 7-0 6-3 4-4"
	FXSettingMenuStrs[2]  = "$Animated Weapon Enchants [Silent]  (Vysh)"
	FXGlobalPresets[2]															= "0-2 1-2 2-2 3-6 6-5 4-6 3-5 4-5 3-4 7-4 4-7 7-3 6-6 4-8"
	FXSettingMenuStrs[3]  = GRIMELEVEN_STRING ;GRIMELEVEN
	FXGlobalPresets[3]															= "0-10 1-9 2-10 5-10 6-15 4-20 3-16 4-20 3-16 7-10 4-20 5-10 6-15 4-20" ;should customize some of these some more (new textures)
	FXSettingMenuStrs[4]  = "$Enchantment Effect Replacer [Basic]  (Myopic)" ;Myopic
	FXGlobalPresets[4]															= "0-3 1-3 2-3 5-3 6-7 4-9 3-7 4-9 3-7 3-7 4-9 5-3 6-7 4-9"
	FXSettingMenuStrs[5]  = "$Enchantment Effect Replacer [Letters]  (Myopic)"
	FXGlobalPresets[5]															= "0-5 1-5 2-5 5-5 6-9 4-11 3-9 4-11 3-9 3-9 4-11 5-5 6-9 4-11"
	FXSettingMenuStrs[6]  = "$Enchantment Effect Replacer [Combo]  (Myopic)"
	FXGlobalPresets[6]															= "0-4 1-4 2-4 5-4 6-8 4-10 3-8 4-10 3-8 3-8 4-10 5-4 6-8 4-10"
	FXSettingMenuStrs[7]  = "$Improved Weapon Enchantments  (darkman24)" ;darkman24      ;(technically, called "Improved WeaponS Enchantments")
	FXGlobalPresets[7]															= "0-6 1-6 2-6 5-6 6-10 4-12 3-10 4-12 3-10 3-10 4-12 5-6 3-10 4-12"
	FXSettingMenuStrs[8]  = "$Enchantments Upgraded  (Aetherius)" ;warden01
	FXGlobalPresets[8]															= "0-8 1-7 2-8 5-7 6-12 4-15 3-12 4-14 3-11 5-8 4-16 5-7 6-11 4-17"
	FXSettingMenuStrs[9]  = "$SeeEnchantments  (SpiderAkiraC)" ;SpiderAkiraC
	FXGlobalPresets[9]															= "0-9 1-8 2-9 7-9 6-14 4-18 3-14 4-18 3-15 3-14 4-19 3-15 7-7 4-18"
	FXSettingMenuStrs[10] = "$Overflowing Magic  (Sinobol)" ;Sinobol     ;(technically, called "Animated Enchantments Overhaul - OVERFLOWING MAGIC")
	FXGlobalPresets[10]                                                         = "0-14 1-14 2-13 5-11 6-16 4-21 3-17 4-21 3-17 7-13 4-21 5-11 2-13 4-21"
	; FXSettingMenuStrs[10] = "$Weapon Enchantments Redone  (BrotherBob)" ;BrotherBob
	; FXGlobalPresets[10]   = ""
	; FXSettingMenuStrs[11] = "$AnotherEnchantEffect  (Rizing)" ;Rizing/jjim83
	; FXGlobalPresets[11]   = ""
	FXSettingMenuStrs[11] = "$Variety Enchant [Aelfa]  (Doorn)" ;Doorn
	FXGlobalPresets[11]															= "0-15 1-15 2-14 5-12 6-17 4-22 3-18 4-22 3-18 3-18 4-22 5-12 6-17 4-22"
	FXSettingMenuStrs[12] = "$Variety Enchant [Daedric]  (Doorn)"
	FXGlobalPresets[12]															= "0-16 1-16 2-15 5-13 6-18 4-23 3-19 4-23 3-19 3-19 4-23 5-13 6-18 4-23"
	FXSettingMenuStrs[13] = "$Variety Enchant [Dragon]  (Doorn)"
	FXGlobalPresets[13]															= "0-17 1-17 2-16 5-14 6-19 4-24 3-20 4-24 3-20 3-20 4-24 5-14 6-19 4-24"
	FXSettingMenuStrs[14] = "$Variety Enchant [Dwemer]  (Doorn)"
	FXGlobalPresets[14]															= "0-18 1-18 2-17 5-15 6-20 4-25 3-21 4-25 3-21 3-21 4-25 5-15 6-20 4-25"
	FXSettingMenuStrs[15] = "$Variety Enchant [Vanilla Alt]  (Doorn)"
	FXGlobalPresets[15]															= "0-19 1-19 2-18 5-16 6-21 4-26 3-22 4-26 3-22 3-22 4-26 5-16 6-21 4-26"
	FXSettingMenuStrs[16] = "$Variety Enchant [Energized]  (Doorn)"
	FXGlobalPresets[16]															= "0-20 1-20 2-19 5-17 6-22 4-27 3-23 4-27 3-23 3-23 4-27 5-17 6-22 4-27"
	FXSettingMenuStrs[17] = "$Variety Enchant [Peaceful]  (Doorn)"
	FXGlobalPresets[17]															= "0-21 1-21 2-20 5-18 6-23 4-28 3-24 4-28 3-24 3-24 4-28 5-18 6-23 4-28"
	FXSettingMenuStrs[18] = "$Variety Enchant [Smoke]  (Doorn)"
	FXGlobalPresets[18]															= "0-22 1-22 2-21 5-19 6-24 4-29 3-25 4-29 3-25 3-25 4-29 5-19 6-24 4-29"
	FXSettingMenuStrs[19] = "$Variety Enchant [Wind]  (Doorn)"
	FXGlobalPresets[19]															= "0-23 1-23 2-22 5-20 6-25 4-30 3-26 4-30 3-26 3-26 4-30 5-20 6-25 4-30"
	FXSettingMenuStrs[20] = "$Variety Enchant [Aelfa Dark]  (Doorn)"
	FXGlobalPresets[20]															= "0-24 1-24 2-23 5-21 6-26 4-31 3-27 4-31 3-27 3-27 4-31 5-21 6-26 4-31"
	FXSettingMenuStrs[21] = "$Variety Enchant [Daedric Dark]  (Doorn)"
	FXGlobalPresets[21]															= "0-25 1-25 2-24 5-22 6-27 4-32 3-28 4-32 3-28 3-28 4-32 5-22 6-27 4-32"
	FXSettingMenuStrs[22] = "$Variety Enchant [Dragon Dark]  (Doorn)"
	FXGlobalPresets[22]															= "0-26 1-26 2-25 5-23 6-28 4-33 3-29 4-33 3-29 3-29 4-33 5-23 6-28 4-33"
	FXSettingMenuStrs[23] = "$Variety Enchant [Dwemer Dark]  (Doorn)"
	FXGlobalPresets[23]															= "0-27 1-27 2-26 5-24 6-29 4-34 3-30 4-34 3-30 3-30 4-34 5-24 6-29 4-34"
	FXSettingMenuStrs[24] = "$Variety Enchant [Vanilla Alt Dark]  (Doorn)" ;(Variety Enchant Effect)
	FXGlobalPresets[24]															= "0-28 1-28 2-27 5-25 6-30 4-35 3-31 4-35 3-31 3-31 4-35 5-25 6-30 4-35"
	FXSettingMenuStrs[25] = "$Variety Enchant [Energized Dark]  (Doorn)"
	FXGlobalPresets[25]															= "0-29 1-29 2-28 5-26 6-31 4-36 3-32 4-36 3-32 3-32 4-36 5-26 6-31 4-36"
	FXSettingMenuStrs[26] = "$Variety Enchant [Peaceful Dark]  (Doorn)"
	FXGlobalPresets[26]															= "0-30 1-30 2-29 5-27 6-32 4-37 3-33 4-37 3-33 3-33 4-37 5-27 6-32 4-37"
	FXSettingMenuStrs[27] = "$Variety Enchant [Smoke Dark]  (Doorn)"
	FXGlobalPresets[27]															= "0-31 1-31 2-30 5-28 6-33 4-38 3-34 4-38 3-34 3-34 4-38 5-28 6-33 4-38"
	FXSettingMenuStrs[28] = "$Variety Enchant [Wind Dark]  (Doorn)"
	FXGlobalPresets[28]															= "0-32 1-32 2-31 5-29 6-34 4-39 3-35 4-39 3-35 3-35 4-39 5-29 6-34 4-39"
	FXSettingMenuStrs[29] = "$Glyphic Enchantment [Daedric]  (AwkwardPsyche)" ;AwkwardPsyche (Glyphic Enchantment Effect)
	FXGlobalPresets[29]															= "0-33 1-33 2-32 5-30 6-35 4-40 3-36 4-40 3-36 3-36 4-40 5-30 6-35 4-40"
	FXSettingMenuStrs[30] = "$Glyphic Enchantment [Dragon]  (AwkwardPsyche)"
	FXGlobalPresets[30]															= "0-34 1-34 2-33 5-31 6-36 4-41 3-37 4-41 3-37 3-37 4-41 5-31 6-36 4-41"
	FXSettingMenuStrs[31] = "$Glyphic Enchantment [Dwemer]  (AwkwardPsyche)"
	FXGlobalPresets[31]															= "0-35 1-35 2-34 5-32 6-37 4-42 3-38 4-42 3-38 3-38 4-42 5-32 6-37 4-42"
	FXSettingMenuStrs[32] = "$Glyphic Enchantment [Esoteric]  (AwkwardPsyche)"
	FXGlobalPresets[32]															= "0-36 1-36 2-35 5-33 6-38 4-43 3-39 4-43 3-39 3-39 4-43 5-33 6-38 4-43"
	FXSettingMenuStrs[33] = "$Glyphic Enchantment [Falmer]  (AwkwardPsyche)"
	FXGlobalPresets[33]															= "0-37 1-37 2-36 5-34 6-39 4-44 3-40 4-44 3-40 3-40 4-44 5-34 6-39 4-44"


	ModNameStrs = new string[20]
	AuthorStrs  = new string[20]
	ModIDStrs   = new string[20]

	ModNameStrs[0]  = "$Animated Weapon Enchants                                                           _"
	ModNameStrs[1]  = "$Animated Enchantments Overhaul                                                     _"
	ModNameStrs[2]  = "$Enchantment Effect Replacer                                                        _"
	ModNameStrs[3]  = "$Improved Weapons Enchantments                                                      _" ;display in random order on credits page
	ModNameStrs[4]  = "$Enchantments Upgraded                                                              _"
	ModNameStrs[5]  = "$See Enchantments                                                                   _"
	ModNameStrs[6]  = "$Weapon Enchantments Redone                                                         _"
	ModNameStrs[7]  = "$AnotherEnchantEffect                                                               _"
	ModNameStrs[8]  = "$Variety Enchant Effect                                                             _"
	ModNameStrs[9]  = "$Glyphic Enchantment Effect                                                         _"
	ModNameStrs[10] = "$Holy Enchantments                                                                  _"
	ModNameStrs[11] = "$OVERFLOWING MAGIC                                                                  _"

	AuthorStrs[0]  = "$by Vysh"
	AuthorStrs[1]  = "$by GRIMELEVEN"
	AuthorStrs[2]  = "$by Myopic"
	AuthorStrs[3]  = "$by darkman24"
	AuthorStrs[4]  = "$by Aetherius"
	AuthorStrs[5]  = "$by SpiderAkiraC"
	AuthorStrs[6]  = "$by BrotherBob"
	AuthorStrs[7]  = "$by Rizing"
	AuthorStrs[8]  = "$by Doorn"
	AuthorStrs[9]  = "$by AwkwardPsyche"
	AuthorStrs[10] = "$by satorius13"
	AuthorStrs[11] = "$by Sinobol"

	ModIDStrs[0]  = "$(Nexus mod #12668)"
	ModIDStrs[1]  = "$(Nexus mod #41875)"
	ModIDStrs[2]  = "$(Nexus mod #1345)"
	ModIDStrs[3]  = "$(Nexus mod #33148)"
	ModIDStrs[4]  = "$(Nexus mod #29316)"
	ModIDStrs[5]  = "$(Nexus mod #38839)"
	ModIDStrs[6]  = "$(Nexus mod #28670)"
	ModIDStrs[7]  = "$(Nexus mod #49061)"
	ModIDStrs[8]  = "$(Nexus mod #5491)"
	ModIDStrs[9]  = "$(Nexus mod #21745)"
	ModIDStrs[10] = "$(Nexus mod #50439)"
	ModIDStrs[11] = "$(Nexus mod #53171)"

	advancedOpStrings    = new string[7]
	advancedArtOpStrings = new string[9]
	expandedOps          = new bool[14]	;have advanced options been expanded open?

	advancedOpStrings[0]  = "$Enchant Shader"
	advancedOpStrings[1]  = "$Enchant Art"
	advancedOpStrings[2]  = "$Hit Shader"
	advancedOpStrings[3]  = "$Hit Art"
	advancedOpStrings[4]  = "$Impact Art"
	advancedOpStrings[5]  = "$Projectile"
	advancedOpStrings[6]  = "$Lingering FX"

	advancedArtOpStrings[0]  = "$      Sword"
	advancedArtOpStrings[1]  = "$      Dagger"
	advancedArtOpStrings[2]  = "$      WarAxe"
	advancedArtOpStrings[3]  = "$      Mace"
	advancedArtOpStrings[4]  = "$      Greatsword"
	advancedArtOpStrings[5]  = "$      Battleaxe"
	advancedArtOpStrings[6]  = "$      Warhammer"
	advancedArtOpStrings[7]  = "$      Bow"
	advancedArtOpStrings[8]  = "$      Crossbow"
EndFunction

;IMPORTED ARRAYS & CONSTANTS --------------->

	int				cEnchFire
	int				cEnchFrost
	int				cEnchShock
	int				cEnchSoulTrap
	int				cEnchAbHealth
	int				cEnchAbStamina			;MGEF constants
	int				cEnchAbMagicka
	int				cEnchStaminaDam
	int				cEnchMagickaDam
	int				cEnchTurnUndead
	int				cEnchParalysis
	int				cEnchBanish
	int				cEnchFear
	int				cEnchSilentMoons

	string[]		sFXTypes                            ;names of main effect shader groupings
	string[]		WeaponMGEFStrs						;correlated to 14 MGEFs -ex: "$Soul Trap"
	string[]		bufferedWeaponMGEFStrs				;(leading spaces added) -ex: "$     Soul Trap"
	string[]		WeaponMGEFShaderStrs 				;correlated to 14 MGEFs -ex: "$Purple FX"
	string[]		WeaponMGEFShaderStrsSpecDefault		;correlated to 14 MGEFs -ex: "$Default Soul Trap FX"
	int[]			durationalEnchants

	int[]			effectDefaultsFXPersist
	float[]			effectDefaultsTaperWeight
	float[]			effectDefaultsTaperCurve
	float[]			effectDefaultsTaperDuration			;default data based on vanilla magic effects
	Art[]			effectDefaultsHitArt
	Art[]			effectDefaultsEnchArt
	EffectShader[]	effectDefaultsHitShader
	EffectShader[]	effectDefaultsEnchShader
	Projectile[]	effectDefaultsProjectile
	ImpactDataSet[]	effectDefaultsImpactData

	Art[]			xHitArtArray
	EffectShader[]	xHitShaderArray
	ImpactDataSet[]	xImpactDataArray		;central base storage for all possible effect data
	Projectile[]	xProjectileArray
	float[]			xTaperWeightArray
	float[]			xTaperCurveArray
	float[]			xTaperDurationArray

	string[]		xEnchArtStrings
	string[]		xHitArtStrings
	string[]		xHitShaderStrings		;strings for each possible effect choice
	string[]		xImpactDataStrings
	string[]		xProjectileStrings
	string[]		xFXPersistStrings

	EffectShader[]  pEnchShader
	Art[]           pEnchArt
	EffectShader[]  pHitShader
	Art[]           pHitArt					;effect data arrays  (these hold current settings)
	ImpactDataSet[] pImpactData
	int[]           pFXPersistPreset
	float[]         pTaperWeight
	float[]         pTaperCurve
	float[]         pTaperDuration
	Projectile[]    pProjectile

	string[]		pStrEnchShader
	string[]		pStrEnchShaderSpec
	string[]		pStrEnchShaderPreset
	string[]		pStrEnchArt				;effect data strings
	string[]		pStrHitShader
	string[]		pStrHitArt
	string[]		pStrImpactData
	string[]		pStrFXPersistPreset
	string[]		pStrProjectile

Function DataLink(EAr_Mothership visitor)
	mothership = visitor

	cEnchFire        = mothership.cEnchFire
	cEnchFrost       = mothership.cEnchFrost
	cEnchShock       = mothership.cEnchShock
	cEnchSoulTrap    = mothership.cEnchSoulTrap
	cEnchAbHealth    = mothership.cEnchAbHealth
	cEnchAbStamina   = mothership.cEnchAbStamina
	cEnchAbMagicka   = mothership.cEnchAbMagicka
	cEnchStaminaDam  = mothership.cEnchStaminaDam
	cEnchMagickaDam  = mothership.cEnchMagickaDam
	cEnchTurnUndead  = mothership.cEnchTurnUndead
	cEnchParalysis   = mothership.cEnchParalysis
	cEnchBanish      = mothership.cEnchBanish
	cEnchFear        = mothership.cEnchFear
	cEnchSilentMoons = mothership.cEnchSilentMoons

	sFXTypes                        = mothership.sFXTypes
	WeaponMGEFStrs                  = mothership.WeaponMGEFStrs
	bufferedWeaponMGEFStrs          = mothership.bufferedWeaponMGEFStrs
	WeaponMGEFShaderStrs            = mothership.WeaponMGEFShaderStrs
	WeaponMGEFShaderStrsSpecDefault = mothership.WeaponMGEFShaderStrsSpecDefault
	durationalEnchants              = new int[4]
	durationalEnchants[0]           = cEnchFear
	durationalEnchants[1]           = cEnchSoulTrap
	durationalEnchants[2]           = cEnchParalysis
	durationalEnchants[3]           = cEnchTurnUndead

	effectDefaultsFXPersist     = mothership.effectDefaultsFXPersist
	effectDefaultsTaperWeight   = mothership.effectDefaultsTaperWeight
	effectDefaultsTaperCurve    = mothership.effectDefaultsTaperCurve
	effectDefaultsTaperDuration = mothership.effectDefaultsTaperDuration
	effectDefaultsHitArt        = mothership.effectDefaultsHitArt
	effectDefaultsEnchArt       = mothership.effectDefaultsEnchArt
	effectDefaultsHitShader     = mothership.effectDefaultsHitShader
	effectDefaultsEnchShader    = mothership.effectDefaultsEnchShader
	effectDefaultsProjectile    = mothership.effectDefaultsProjectile
	effectDefaultsImpactData    = mothership.effectDefaultsImpactData

	xHitArtArray        = mothership.xHitArtArray
	xHitShaderArray     = mothership.xHitShaderArray
	xImpactDataArray    = mothership.xImpactDataArray
	xProjectileArray    = mothership.xProjectileArray
	xTaperWeightArray   = mothership.xTaperWeightArray
	xTaperCurveArray    = mothership.xTaperCurveArray
	xTaperDurationArray = mothership.xTaperDurationArray

	xEnchArtStrings     = mothership.xEnchArtStrings
	xHitArtStrings      = mothership.xHitArtStrings
	xHitShaderStrings   = mothership.xHitShaderStrings
	xImpactDataStrings  = mothership.xImpactDataStrings
	xProjectileStrings  = mothership.xProjectileStrings
	xFXPersistStrings   = mothership.xFXPersistStrings

	pStrEnchShader       = mothership.pStrEnchShader
	pStrEnchShaderSpec   = mothership.pStrEnchShaderSpec
	pStrEnchShaderPreset = mothership.pStrEnchShaderPreset
	pStrEnchArt          = mothership.pStrEnchArt
	pStrHitShader        = mothership.pStrHitShader
	pStrHitArt           = mothership.pStrHitArt
	pStrImpactData       = mothership.pStrImpactData
	pStrFXPersistPreset  = mothership.pStrFXPersistPreset
	pStrProjectile       = mothership.pStrProjectile

	pEnchShader      = mothership.pEnchShader
	pEnchArt         = mothership.pEnchArt
	pHitShader       = mothership.pHitShader
	pHitArt          = mothership.pHitArt
	pImpactData      = mothership.pImpactData
	pFXPersistPreset = mothership.pFXPersistPreset
	pTaperWeight     = mothership.pTaperWeight
	pTaperCurve      = mothership.pTaperCurve
	pTaperDuration   = mothership.pTaperDuration
	pProjectile      = mothership.pProjectile

	mothership.RegisterForModEvent("EnchantedArsenal_Uninstall", "OnUninstall")

	EAr_InstallComplete.SetValue(1.0)
EndFunction





; Event OnMenuOpen(string menu)
;     bStartDemo = false
;     UnregisterForActorAction(9) ;sheathe begin
;     UnregisterForActorAction(7) ;unsheathe begin
; EndEvent

bool bShowDemoStopMessage
Event OnConfigOpen()
	if bShowDemoStopMessage
		bShowDemoStopMessage = false
    	UnregisterForActorAction(9) ;sheathe begin
    	UnregisterForActorAction(7) ;unsheathe begin

    	int FXnum = demoActiveEffectNum * 9

	    if curDemoComponentString == "$Enchant Shader"
			EnchArsenal.SetLibraryEnchantShader(pEnchShader[FXnum], FXnum, FX_SCOPE)
		elseif curDemoComponentString == "$Enchant Art"
			int i = 9
			while i > 0
				i -= 1
				int tempIndex = FXnum + i
				EnchArsenal.SetLibraryEnchantArt(pEnchArt[tempIndex], tempIndex, FX_ENTRY)
			endWhile
		elseif curDemoComponentString == "$Hit Shader"
			EnchArsenal.SetLibraryHitShader(pHitShader[FXnum], FXnum, FX_SCOPE)
		elseif curDemoComponentString == "$Hit Shader"
			EnchArsenal.SetLibraryHitArt(pHitArt[FXnum], FXnum, FX_SCOPE)
		endif

    	ShowMessage("$Demo mode ended. Your original settings have been restored.", false, "$Okay")
    endif


EndEvent

Event OnMenuClose(string menu)
    if bStartDemo
    	demoActiveEffectNum = WeaponMGEFStrs.find(curDemoEffectString)
    	demoActiveFXType = demoFXTypeStrings.find(curDemoFXTypeString)
    	demoActiveIndex = 0
    	demoActiveQueuedString = ""
    	RegisterForActorAction(9) ;sheathe begin
    	RegisterForActorAction(7) ;unsheathe begin
    	bStartDemo = false
    	bShowDemoStopMessage = true
    endif
EndEvent

int demoActiveEffectNum
string demoActiveQueuedString
int demoActiveFXType
int demoActiveIndex
Event OnActorAction(int actionType, Actor akActor, Form source, int slot)

	;draw weapon:
	if actionType == 7
		debug.notification(demoActiveQueuedString)
		return
	endif

	;sheath weapon:
	if curDemoComponentString == "$Enchant Shader"
		string[] strs = mothership.xEnchShaderStrings(demoActiveFXType, false)
		EffectShader[] effs = mothership.xEnchShaderArray(demoActiveFXType)
		if (strs[demoActiveIndex] == "" && actionType < 11) ;actionType limit to protect against any chance of infinite loop
			demoActiveIndex = 0
			demoActiveFXType = (demoActiveFXType + 1) % 8
			OnActorAction(actionType + 1, akActor, source, slot)
			return
		endif
		demoActiveQueuedString = strs[demoActiveIndex]
		EnchArsenal.SetLibraryEnchantShader(effs[demoActiveIndex], (demoActiveEffectNum * 9), FX_SCOPE)
		demoActiveIndex += 1
		;set the new shader here

	elseif curDemoComponentString == "$Enchant Art"
		int weaponType = mothership.GetModifiedWeaponType(source as Weapon)
		if weaponType < 0 ;error check
			weaponType = 0
		endif
		Art[] effa = mothership.xEnchArtArray(weaponType)

		while (xEnchArtStrings[demoActiveIndex] && (effa[demoActiveIndex] == none)) ;if string but no art for this weapon type, advance..
			demoActiveIndex += 1
		endWhile

		if (xEnchArtStrings[demoActiveIndex] == "") ;end of array
			demoActiveIndex = 0
		endif

		demoActiveQueuedString = xEnchArtStrings[demoActiveIndex]
		EnchArsenal.SetLibraryEnchantArt(effa[demoActiveIndex], (demoActiveEffectNum * 9 + weaponType), FX_ENTRY)
		demoActiveIndex += 1

	elseif curDemoComponentString == "$Hit Shader"

		if (demoActiveIndex == 0 || xHitShaderStrings[demoActiveIndex] == "")
			demoActiveIndex = 1
		endif

		demoActiveQueuedString = xHitShaderStrings[demoActiveIndex]
		EnchArsenal.SetLibraryHitShader(xHitShaderArray[demoActiveIndex], (demoActiveEffectNum * 9), FX_SCOPE)
		demoActiveIndex += 1

	elseif curDemoComponentString == "$Hit Art"

		if (demoActiveIndex == 0 || xHitArtStrings[demoActiveIndex] == "")
			demoActiveIndex = 1
		endif

		demoActiveQueuedString = xHitArtStrings[demoActiveIndex]
		EnchArsenal.SetLibraryHitArt(xHitArtArray[demoActiveIndex], (demoActiveEffectNum * 9), FX_SCOPE)
		demoActiveIndex += 1

	endif
EndEvent



;______________________________________________________________________________________________________________________
;================== INPUT FRAMEWORK (for RenameFISSPreset) ===============================================================
;``````````````````````````````````````````````````````````````````````````````````````````````````````````````````````

int[] DXScanCodes
string[] DXScanChars
string displayString ;used by menu setter
bool typingMessage
bool bTypeSpeedLimiter
string currentChar ;new tester
;bool bInputPage ;used by menu setter

State RegisterInputState
	Event OnBeginState()
		int i = 51
		while i
			i -= 1
			RegisterForKey(DXScanCodes[i])
		endWhile
		RegisterForKey(14)  ;backspace
		RegisterForKey(211) ;delete
		RegisterForKey(28)  ;enter
	EndEvent

	Event OnKeyDown(int code)
		if !bTypeSpeedLimiter
			bTypeSpeedLimiter = true
			if code == 14 || code == 211 ;backspace/delete
				currentChar = "DEL"
			elseif code == 28 ;enter
				currentChar = "ENT"
			else
				int index = DXScanCodes.find(code)
				if index >= 0
					currentChar = DXScanChars[index]
				endif
			endif
			typingMessage = true
			UnregisterForKey(28) ;only listen for user to hit enter
			Input.TapKey(28)
			RegisterForKey(28)
			utility.waitmenumode(0.3)
			;typingMessage = false
			bTypeSpeedLimiter = false
		endif
	EndEvent

	Event OnEndState()
		UnregisterForAllKeys()
	EndEvent
EndState


;key init for the input feature 
Function InitializeKeyCodes()
	;list of basic alphanumeric character keys
	DXScanCodes = new int[51]
	DXScanCodes[0] = 16   ;begin capitalizable alphabet letters
	DXScanCodes[1] = 17
	DXScanCodes[2] = 18
	DXScanCodes[3] = 19
	DXScanCodes[4] = 20
	DXScanCodes[5] = 21
	DXScanCodes[6] = 22
	DXScanCodes[7] = 23
	DXScanCodes[8] = 24
	DXScanCodes[9] = 25
	DXScanCodes[10] = 30
	DXScanCodes[11] = 31
	DXScanCodes[12] = 32
	DXScanCodes[13] = 33
	DXScanCodes[14] = 34
	DXScanCodes[15] = 35
	DXScanCodes[16] = 36
	DXScanCodes[17] = 37
	DXScanCodes[18] = 38
	DXScanCodes[19] = 44
	DXScanCodes[20] = 45
	DXScanCodes[21] = 46
	DXScanCodes[22] = 47
	DXScanCodes[23] = 48
	DXScanCodes[24] = 49
	DXScanCodes[25] = 50  ;end capitalizable alphabet letters
	DXScanCodes[26] = 2
	DXScanCodes[27] = 3
	DXScanCodes[28] = 4
	DXScanCodes[29] = 5
	DXScanCodes[30] = 6
	DXScanCodes[31] = 7
	DXScanCodes[32] = 8
	DXScanCodes[33] = 9
	DXScanCodes[34] = 10
	DXScanCodes[35] = 11
	DXScanCodes[36] = 12
	DXScanCodes[37] = 40
	DXScanCodes[38] = 57  ;spacebar
	DXScanCodes[39] = 71
	DXScanCodes[40] = 72
	DXScanCodes[41] = 73
	DXScanCodes[42] = 74
	DXScanCodes[43] = 75
	DXScanCodes[44] = 76
	DXScanCodes[45] = 77
	DXScanCodes[46] = 78
	DXScanCodes[47] = 79
	DXScanCodes[48] = 80
	DXScanCodes[49] = 81
	DXScanCodes[50] = 82

	;characters correlated to Codes above:
	;(extra space added to try and avoid papyrus string caching inconsistencies)
	DXScanChars = new string[51]
	DXScanChars[0] = "Q "
	DXScanChars[1] = "W "
	DXScanChars[2] = "E "
	DXScanChars[3] = "R "
	DXScanChars[4] = "T "
	DXScanChars[5] = "Y "
	DXScanChars[6] = "U "
	DXScanChars[7] = "I "
	DXScanChars[8] = "O "
	DXScanChars[9] = "P "
	DXScanChars[10] = "A "
	DXScanChars[11] = "S "
	DXScanChars[12] = "D "
	DXScanChars[13] = "F "
	DXScanChars[14] = "G "
	DXScanChars[15] = "H "
	DXScanChars[16] = "J "
	DXScanChars[17] = "K "
	DXScanChars[18] = "L "
	DXScanChars[19] = "Z "
	DXScanChars[20] = "X "
	DXScanChars[21] = "C "
	DXScanChars[22] = "V "
	DXScanChars[23] = "B "
	DXScanChars[24] = "N "
	DXScanChars[25] = "M "
	DXScanChars[26] = "1 "
	DXScanChars[27] = "2 "
	DXScanChars[28] = "3 "
	DXScanChars[29] = "4 "
	DXScanChars[30] = "5 "
	DXScanChars[31] = "6 "
	DXScanChars[32] = "7 "
	DXScanChars[33] = "8 "
	DXScanChars[34] = "9 "
	DXScanChars[35] = "0 "
	DXScanChars[36] = "- "
	DXScanChars[37] = "' "
	DXScanChars[38] = "  "  ;spacebar
	DXScanChars[39] = "7 "
	DXScanChars[40] = "8 "
	DXScanChars[41] = "9 "
	DXScanChars[42] = "- "
	DXScanChars[43] = "4 "
	DXScanChars[44] = "5 "
	DXScanChars[45] = "6 "
	DXScanChars[46] = "+ "
	DXScanChars[47] = "1 "
	DXScanChars[48] = "2 "
	DXScanChars[49] = "3 "
	DXScanChars[50] = "0 "
EndFunction














;______________________________________________________________________________________________________________________
;================== UTILITY FUNCTIONS =================================================================================
;``````````````````````````````````````````````````````````````````````````````````````````````````````````````````````
Function SetArrayStrs(string[] strs, string strToSet, int idx, int range = 1)
{Write string to a contiguous range of array indices}
	range = idx + range
	while idx < range
		strs[idx] = strToSet
		idx += 1
	endWhile
 EndFunction

Function SetMenuDialogStartIndex(int idx)
{Override parent to correct negative indices (which lead to log spam)}
	if idx < 0
		idx = 0
	endif
	parent.SetMenuDialogStartIndex(idx)
 EndFunction

Function SetStarterInfoText(string desc)
{Description text setter, allows display of info text immediately when page is first selected}
	registerForModEvent("EAr_setPageDescrip", "OnPageDescriptionSet")
	sendModEvent("EAr_setPageDescrip", desc, 0)
 EndFunction
 Event OnPageDescriptionSet(string eventName, string desc, float iterations, Form sender)
	int readyState = UI.GetInt("Journal Menu", "_global.ConfigPanel.READY")
	int curState = UI.GetInt("Journal Menu", "_root.ConfigPanelFader.configPanel._state")

	if (curState == readyState || iterations > 10.0)
		UI.InvokeString("Journal Menu", "_root.ConfigPanelFader.configPanel.setInfoText", desc)
		UnregisterForModEvent("EAr_setPageDescrip")
	else
		utility.waitmenumode(0.05)
		SendModEvent("EAr_setPageDescrip", desc, iterations + 1.0)
	endif
 EndEvent

Function RefreshPage()
{Page Refresh that maintains highlight on currently selected option}
	int index = UI.GetInt("Journal Menu", "_root.ConfigPanelFader.configPanel.contentHolder.optionsPanel.optionsList.selectedIndex")
	registerForModEvent("EAr_pageRefresh", "EAr_onPageRefreshed")
	sendModEvent("EAr_pageRefresh", index as string, 0)
	forcePageReset()
 EndFunction
 Event EAr_onPageRefreshed(string eventName, string strArg, float iterations, Form sender)
	int returnPlace = strArg as int
	int readyState = UI.GetInt("Journal Menu", "_global.ConfigPanel.READY")
	int curState = UI.GetInt("Journal Menu", "_root.ConfigPanelFader.configPanel._state")

	if (curState == readyState || iterations > 10.0)
		UI.SetInt("Journal Menu", "_root.ConfigPanelFader.configPanel.contentHolder.optionsPanel.optionsList.selectedIndex", returnPlace)
		UnregisterForModEvent("EAr_pageRefresh")
	else
		utility.waitmenumode(0.04)
		SendModEvent("EAr_pageRefresh", strArg, iterations + 1.0)
	endif
 EndEvent



;______________________________________________________________________________________________________________________
;================== PRE-INSTALLATION MENU OVERRIDE ====================================================================
;``````````````````````````````````````````````````````````````````````````````````````````````````````````````````````
Auto State notInstalled
	Event OnPageReset(string page)
		
		if page == ""
			LoadCustomContent("EnchantedArsenal/EAr_Logo.dds", 0, 0)
			return
		else
			UnloadCustomContent()
		endIf

		if EAr_InstallComplete.getValue()
			goToState("")
			OnPageReset(page)
		else
			SetCursorPosition(0)
			SetCursorFillMode(TOP_TO_BOTTOM)
			AddEmptyOption()
			AddTextOption("", "$Installation still in progress...")
			AddEmptyOption()
			AddTextOption("$         Please re-open menu in a few moments", "")
		endif
	EndEvent
	Event OnOptionHighlight(int o)
	EndEvent
EndState

State beginUninstalling
	Event OnPageReset(string page)
		
		if page == ""
			LoadCustomContent("EnchantedArsenal/EAr_Logo.dds", 0, 0)
			return
		else
			UnloadCustomContent()
		endIf

		SetCursorPosition(0)
		AddTextOption("Enchanted Arsenal has been Uninstalled.", "")

	EndEvent
	Event OnOptionHighlight(int o)
	EndEvent
EndState