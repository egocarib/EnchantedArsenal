Scriptname EAr_Mothership extends Quest
{Databank}

MagicEffect[] Property enchList auto ;filled in CK

	int property cEnchFire			= 0  autoreadonly ; enchList[0]  = EnchFireDamageFFContact
	int property cEnchFrost			= 1  autoreadonly ; enchList[1]  = EnchFrostDamageFFContact
	int property cEnchShock			= 2  autoreadonly ; enchList[2]  = EnchShockDamageFFContact
	int property cEnchSoulTrap		= 3  autoreadonly ; enchList[3]  = EnchSoulTrapFFContact (& FierySoulTrap)
	int property cEnchAbHealth		= 4  autoreadonly ; enchList[4]  = EnchAbsorbHealthFFContact
	int property cEnchAbStamina		= 5  autoreadonly ; enchList[5]  = EnchAbsorbStaminaFFContact
	int property cEnchAbMagicka		= 6  autoreadonly ; enchList[6]  = EnchAbsorbMagickaFFContact
	int property cEnchStaminaDam	= 7  autoreadonly ; enchList[7]  = EnchStaminaDamageFFContact
	int property cEnchMagickaDam	= 8  autoreadonly ; enchList[8]  = EnchMagickaDamageFFContact
	int property cEnchTurnUndead	= 9  autoreadonly ; enchList[9]  = EnchTurnUndeadFFContact
	int property cEnchParalysis		= 10 autoreadonly ; enchList[10] = EnchParalysisFFContact
	int property cEnchBanish		= 11 autoreadonly ; enchList[11] = EnchBanishFFContact
	int property cEnchFear			= 12 autoreadonly ; enchList[12] = EnchInfluenceConfDownFFContactLow (Fear)
	int property cEnchSilentMoons	= 13 autoreadonly ; enchList[13] = dunSilentMoonsEnchFFContact

bool bDAWNGUARD = false

EAr_Menu property menu auto
;EAr_PlayerListener property pListener auto
string[] property WeaponMGEFStrs auto hidden
string[] property WeaponMGEFShaderStrs auto hidden
string[] property WeaponMGEFShaderStrsSpecDefault auto hidden
string[] property bufferedWeaponMGEFStrs auto hidden


Event OnInit()
	registerForSingleUpdate(0.01)
EndEvent

Event OnUpdate()
	WeaponMGEFStrs = new string[50]
	 WeaponMGEFStrs[cEnchAbHealth]		= "$Absorb Health"
	 WeaponMGEFStrs[cEnchAbMagicka]		= "$Absorb Magicka"
	 WeaponMGEFStrs[cEnchAbStamina]		= "$Absorb Stamina"
	 WeaponMGEFStrs[cEnchBanish]		= "$Banish"
	 WeaponMGEFStrs[cEnchFear]			= "$Fear"
	 WeaponMGEFStrs[cEnchSoulTrap]		= "$Soul Trap"
	 WeaponMGEFStrs[cEnchFire]			= "$Fire Damage"
	 WeaponMGEFStrs[cEnchFrost]			= "$Frost Damage"
	 WeaponMGEFStrs[cEnchMagickaDam]	= "$Magicka Damage"
	 WeaponMGEFStrs[cEnchParalysis]		= "$Paralysis"
	 WeaponMGEFStrs[cEnchShock]			= "$Shock Damage"
	 WeaponMGEFStrs[cEnchSilentMoons]	= "$Silent Moons"
	 WeaponMGEFStrs[cEnchStaminaDam]	= "$Stamina Damage"
	 WeaponMGEFStrs[cEnchTurnUndead]	= "$Turn Undead"
	 ;add silver weapons, maybe?

	;these are for use in the Menu ----------------->
	bufferedWeaponMGEFStrs = new string[50]
	 bufferedWeaponMGEFStrs[cEnchAbHealth]		= "$     Absorb Health"
	 bufferedWeaponMGEFStrs[cEnchAbMagicka]		= "$     Absorb Magicka"
	 bufferedWeaponMGEFStrs[cEnchAbStamina]		= "$     Absorb Stamina"
	 bufferedWeaponMGEFStrs[cEnchBanish]		= "$     Banish"
	 bufferedWeaponMGEFStrs[cEnchFear]			= "$     Fear"
	 bufferedWeaponMGEFStrs[cEnchSoulTrap]		= "$     Soul Trap"
	 bufferedWeaponMGEFStrs[cEnchFire]			= "$     Fire Damage"
	 bufferedWeaponMGEFStrs[cEnchFrost]			= "$     Frost Damage"
	 bufferedWeaponMGEFStrs[cEnchMagickaDam]	= "$     Magicka Damage"
	 bufferedWeaponMGEFStrs[cEnchParalysis]		= "$     Paralysis"
	 bufferedWeaponMGEFStrs[cEnchShock]			= "$     Shock Damage"
	 bufferedWeaponMGEFStrs[cEnchSilentMoons]	= "$     Silent Moons"
	 bufferedWeaponMGEFStrs[cEnchStaminaDam]	= "$     Stamina Damage"
	 bufferedWeaponMGEFStrs[cEnchTurnUndead]	= "$     Turn Undead"

	WeaponMGEFShaderStrs = new string[50]
	 WeaponMGEFShaderStrs[cEnchAbHealth]	= "$Red FX"
	 WeaponMGEFShaderStrs[cEnchAbMagicka]	= "$Blue FX"
	 WeaponMGEFShaderStrs[cEnchAbStamina]	= "$Green FX"
	 WeaponMGEFShaderStrs[cEnchBanish]		= "$Purple FX"
	 WeaponMGEFShaderStrs[cEnchFear]		= "$Red FX"
	 WeaponMGEFShaderStrs[cEnchSoulTrap]	= "$Purple FX"
	 WeaponMGEFShaderStrs[cEnchFire]		= "$Fire FX"
	 WeaponMGEFShaderStrs[cEnchFrost]		= "$Frost FX"
	 WeaponMGEFShaderStrs[cEnchMagickaDam]	= "$Blue FX"
	 WeaponMGEFShaderStrs[cEnchParalysis]	= "$Green FX"
	 WeaponMGEFShaderStrs[cEnchShock]		= "$Shock FX"
	 WeaponMGEFShaderStrs[cEnchSilentMoons]	= "$Green FX"
	 WeaponMGEFShaderStrs[cEnchStaminaDam]	= "$Green FX"
	 WeaponMGEFShaderStrs[cEnchTurnUndead]	= "$Blue FX" ;error, should be specialFX - planned to be corrected in 1.2 update

	WeaponMGEFShaderStrsSpecDefault = new string[50]
	 WeaponMGEFShaderStrsSpecDefault[cEnchAbHealth]		= "$Default Absorb Health FX"
	 WeaponMGEFShaderStrsSpecDefault[cEnchAbMagicka]	= "$Default Absorb Magicka FX"
	 WeaponMGEFShaderStrsSpecDefault[cEnchAbStamina]	= "$Default Absorb Stamina FX"
	 WeaponMGEFShaderStrsSpecDefault[cEnchBanish]		= "$Default Banish FX"
	 WeaponMGEFShaderStrsSpecDefault[cEnchFear]			= "$Default Fear FX"
	 WeaponMGEFShaderStrsSpecDefault[cEnchSoulTrap]		= "$Default Soul Trap FX"
	 WeaponMGEFShaderStrsSpecDefault[cEnchFire]			= "$Default Fire FX"
	 WeaponMGEFShaderStrsSpecDefault[cEnchFrost]		= "$Default Frost FX"
	 WeaponMGEFShaderStrsSpecDefault[cEnchMagickaDam]	= "$Default Magicka Damage FX"
	 WeaponMGEFShaderStrsSpecDefault[cEnchParalysis]	= "$Default Paralysis FX"
	 WeaponMGEFShaderStrsSpecDefault[cEnchShock]		= "$Default Shock FX"
	 WeaponMGEFShaderStrsSpecDefault[cEnchSilentMoons]	= "$Default Silent Moons FX"
	 WeaponMGEFShaderStrsSpecDefault[cEnchStaminaDam]	= "$Default Stamina Damage FX"
	 WeaponMGEFShaderStrsSpecDefault[cEnchTurnUndead]	= "$Default Turn Undead FX"

	int dlcCheck = Game.GetModByName("Dawnguard.esm")
	bDAWNGUARD = (dlcCheck > 0 && dlcCheck < 255)

	;InitializeFXArrays()

	InitializeDefaultData() ;must be called before InitializeVault

	InitializeEffectSets()

	InitializeVault() ;must be called before InitializePlayerData

	InitializePlayerData()

	RunLoadMaintenance()                                          ;NEED TO MAKE SURE TO DO THIS STUFF EVERY GAME LOAD!!!!!!!!

	menu.DataLink(self)

	(self.GetAlias(1) as EAr_LoaderDrone).UpdateMod(self) ;Apply Updates

	;pListener.DataLink(self)
EndEvent






;____________________________________________________________________________________________________________________________________
;=========================================== MENU EVENT SETTERS =====================================================================

	;DEPRICATED

;maybe these should be functions instead so that I can wait for them to return, and then reset the MCMpage?

; Event OnSetEffects_Global(int primarySetID, int backupSetID)
; EndEvent

; Event OnSetEffects_Enchantment(string fxType, int setID)
; 	;may not set every entry if not all can be set - will leave the rest as they are currently
; EndEvent

; Event OnSetEffects_Weapon(string fxType, int index)
; 	int typeID = sFXTypes.find(fxType)
; 	;set based on arrays/defaults below
; EndEvent

; Event OnSetEffects_Specific()
; EndEvent






;__________________________________________________________________________________________________________________________________________
;--------------------------------------------------- PRE-DEFINED EFFECT SETS --------------------------------------------------------------

string[] property sFXTypes   auto hidden

string[] property sFireFX    auto hidden
string[] property sFrostFX   auto hidden
string[] property sShockFX   auto hidden
string[] property sBlueFX    auto hidden
string[] property sGreenFX   auto hidden
string[] property sPurpleFX  auto hidden
string[] property sRedFX     auto hidden
string[] property sSpecialFX auto hidden

EffectShader[]  property  effShaderFireFX     auto
EffectShader[]  property  effShaderFrostFX    auto
EffectShader[]  property  effShaderShockFX    auto
EffectShader[]  property  effShaderBlueFX     auto  ;these filled in CK (DO NOT DELETE OR CHANGE NAME)
EffectShader[]  property  effShaderGreenFX    auto
EffectShader[]  property  effShaderPurpleFX   auto
EffectShader[]  property  effShaderRedFX      auto
EffectShader[]  property  effShaderSpecialFX  auto

	int[] property idxEnchArtFireFX    auto hidden
	int[] property idxEnchArtFrostFX   auto hidden
	int[] property idxEnchArtShockFX   auto hidden
	int[] property idxEnchArtBlueFX    auto hidden
	int[] property idxEnchArtGreenFX   auto hidden
	int[] property idxEnchArtPurpleFX  auto hidden
	int[] property idxEnchArtRedFX     auto hidden
	int[] property idxEnchArtSpecialFX auto hidden
	int[] property idxEnchArtDefault   auto hidden

	; int[] property idxEnchShaderFireFX   auto hidden
	; int[] property idxEnchShaderFrostFX  auto hidden
	; int[] property idxEnchShaderShockFX  auto hidden
	; int[] property idxEnchShaderBlueFX   auto hidden
	; int[] property idxEnchShaderGreenFX  auto hidden
	; int[] property idxEnchShaderPurpleFX auto hidden
	; int[] property idxEnchShaderRedFX    auto hidden
	; int[] property idxEnchShaderSpecialFX    auto hidden

	bool[] property bIsEnchShaderStrFireFX    auto hidden
	bool[] property bIsEnchShaderStrFrostFX   auto hidden
	bool[] property bIsEnchShaderStrShockFX   auto hidden
	bool[] property bIsEnchShaderStrBlueFX    auto hidden
	bool[] property bIsEnchShaderStrGreenFX   auto hidden
	bool[] property bIsEnchShaderStrPurpleFX  auto hidden
	bool[] property bIsEnchShaderStrRedFX     auto hidden
	bool[] property bIsEnchShaderStrSpecialFX auto hidden

	int[] property idxHitArtFireFX    auto hidden
	int[] property idxHitArtFrostFX   auto hidden
	int[] property idxHitArtShockFX   auto hidden
	int[] property idxHitArtBlueFX    auto hidden
	int[] property idxHitArtGreenFX   auto hidden
	int[] property idxHitArtPurpleFX  auto hidden
	int[] property idxHitArtRedFX     auto hidden
	int[] property idxHitArtSpecialFX auto hidden

	int[] property idxHitShaderFireFX    auto hidden
	int[] property idxHitShaderFrostFX   auto hidden
	int[] property idxHitShaderShockFX   auto hidden
	int[] property idxHitShaderBlueFX    auto hidden
	int[] property idxHitShaderGreenFX   auto hidden
	int[] property idxHitShaderPurpleFX  auto hidden
	int[] property idxHitShaderRedFX     auto hidden
	int[] property idxHitShaderSpecialFX auto hidden

	int[] property idxProjectileFireFX    auto hidden
	int[] property idxProjectileFrostFX   auto hidden
	int[] property idxProjectileShockFX   auto hidden
	int[] property idxProjectileBlueFX    auto hidden
	int[] property idxProjectileGreenFX   auto hidden
	int[] property idxProjectilePurpleFX  auto hidden
	int[] property idxProjectileRedFX     auto hidden
	int[] property idxProjectileSpecialFX auto hidden

	int[] property idxImpactDataFireFX    auto hidden
	int[] property idxImpactDataFrostFX   auto hidden
	int[] property idxImpactDataShockFX   auto hidden
	int[] property idxImpactDataBlueFX    auto hidden
	int[] property idxImpactDataGreenFX   auto hidden
	int[] property idxImpactDataPurpleFX  auto hidden
	int[] property idxImpactDataRedFX     auto hidden
	int[] property idxImpactDataSpecialFX auto hidden

	int[] property fxPersistFireFX    auto hidden
	int[] property fxPersistFrostFX   auto hidden
	int[] property fxPersistShockFX   auto hidden
	int[] property fxPersistBlueFX    auto hidden
	int[] property fxPersistGreenFX   auto hidden
	int[] property fxPersistPurpleFX  auto hidden
	int[] property fxPersistRedFX     auto hidden
	int[] property fxPersistSpecialFX auto hidden

	float[] property taperWeightFireFX    auto hidden
	float[] property taperWeightFrostFX   auto hidden
	float[] property taperWeightShockFX   auto hidden
	float[] property taperWeightBlueFX    auto hidden
	float[] property taperWeightGreenFX   auto hidden
	float[] property taperWeightPurpleFX  auto hidden
	float[] property taperWeightRedFX     auto hidden
	float[] property taperWeightSpecialFX auto hidden

	float[] property taperCurveFireFX    auto hidden
	float[] property taperCurveFrostFX   auto hidden
	float[] property taperCurveShockFX   auto hidden
	float[] property taperCurveBlueFX    auto hidden
	float[] property taperCurveGreenFX   auto hidden
	float[] property taperCurvePurpleFX  auto hidden
	float[] property taperCurveRedFX     auto hidden
	float[] property taperCurveSpecialFX auto hidden

	float[] property taperDurationFireFX    auto hidden
	float[] property taperDurationFrostFX   auto hidden
	float[] property taperDurationShockFX   auto hidden
	float[] property taperDurationBlueFX    auto hidden
	float[] property taperDurationGreenFX   auto hidden
	float[] property taperDurationPurpleFX  auto hidden
	float[] property taperDurationRedFX     auto hidden
	float[] property taperDurationSpecialFX auto hidden

	int[] property presetBaseOverrideFireFX    auto hidden
	int[] property presetBaseOverrideFrostFX   auto hidden
	int[] property presetBaseOverrideShockFX   auto hidden
	int[] property presetBaseOverrideBlueFX    auto hidden  ;allow specifying a particular MGEF to use as a "base" for defaults when preset is selected
	int[] property presetBaseOverrideGreenFX   auto hidden
	int[] property presetBaseOverridePurpleFX  auto hidden
	int[] property presetBaseOverrideRedFX     auto hidden
	int[] property presetBaseOverrideSpecialFX auto hidden

	int[]   property invalidIntArray       auto hidden
	float[] property invalidFloatArray     auto hidden

Function InitializeEffectSets()

	idxEnchArtFireFX    = new int[128]
	idxEnchArtFrostFX   = new int[128]
	idxEnchArtShockFX   = new int[128]
	idxEnchArtBlueFX    = new int[128]
	idxEnchArtGreenFX   = new int[128]
	idxEnchArtPurpleFX  = new int[128]
	idxEnchArtRedFX     = new int[128]
	idxEnchArtSpecialFX = new int[128]

	; idxEnchShaderFireFX    = new int[128]
	; idxEnchShaderFrostFX   = new int[128]
	; idxEnchShaderShockFX   = new int[128]
	; idxEnchShaderBlueFX    = new int[128]
	; idxEnchShaderGreenFX   = new int[128]
	; idxEnchShaderPurpleFX  = new int[128]
	; idxEnchShaderRedFX     = new int[128]
	; idxEnchShaderSpecialFX = new int[128]

	bIsEnchShaderStrFireFX    = new bool[128]
	bIsEnchShaderStrFrostFX   = new bool[128]
	bIsEnchShaderStrShockFX   = new bool[128]
	bIsEnchShaderStrBlueFX    = new bool[128]
	bIsEnchShaderStrGreenFX   = new bool[128]
	bIsEnchShaderStrPurpleFX  = new bool[128]
	bIsEnchShaderStrRedFX     = new bool[128]
	bIsEnchShaderStrSpecialFX = new bool[128]

	idxHitArtFireFX    = new int[128]
	idxHitArtFrostFX   = new int[128]
	idxHitArtShockFX   = new int[128]
	idxHitArtBlueFX    = new int[128]
	idxHitArtGreenFX   = new int[128]
	idxHitArtPurpleFX  = new int[128]
	idxHitArtRedFX     = new int[128]
	idxHitArtSpecialFX = new int[128]

	idxHitShaderFireFX    = new int[128]
	idxHitShaderFrostFX   = new int[128]
	idxHitShaderShockFX   = new int[128]
	idxHitShaderBlueFX    = new int[128]
	idxHitShaderGreenFX   = new int[128]
	idxHitShaderPurpleFX  = new int[128]
	idxHitShaderRedFX     = new int[128]
	idxHitShaderSpecialFX = new int[128]

	idxProjectileFireFX    = new int[128]
	idxProjectileFrostFX   = new int[128]
	idxProjectileShockFX   = new int[128]
	idxProjectileBlueFX    = new int[128]
	idxProjectileGreenFX   = new int[128]
	idxProjectilePurpleFX  = new int[128]
	idxProjectileRedFX     = new int[128]
	idxProjectileSpecialFX = new int[128]

	idxImpactDataFireFX    = new int[128]
	idxImpactDataFrostFX   = new int[128]
	idxImpactDataShockFX   = new int[128]
	idxImpactDataBlueFX    = new int[128]
	idxImpactDataGreenFX   = new int[128]
	idxImpactDataPurpleFX  = new int[128]
	idxImpactDataRedFX     = new int[128]
	idxImpactDataSpecialFX = new int[128]

	fxPersistFireFX    = new int[128]
	fxPersistFrostFX   = new int[128]
	fxPersistShockFX   = new int[128]
	fxPersistBlueFX    = new int[128]
	fxPersistGreenFX   = new int[128]
	fxPersistPurpleFX  = new int[128]
	fxPersistRedFX     = new int[128]
	fxPersistSpecialFX = new int[128]

	taperWeightFireFX    = new float[128]
	taperWeightFrostFX   = new float[128]
	taperWeightShockFX   = new float[128]
	taperWeightBlueFX    = new float[128]
	taperWeightGreenFX   = new float[128]
	taperWeightPurpleFX  = new float[128]
	taperWeightRedFX     = new float[128]
	taperWeightSpecialFX = new float[128]

	taperCurveFireFX    = new float[128]
	taperCurveFrostFX   = new float[128]
	taperCurveShockFX   = new float[128]
	taperCurveBlueFX    = new float[128]
	taperCurveGreenFX   = new float[128]
	taperCurvePurpleFX  = new float[128]
	taperCurveRedFX     = new float[128]
	taperCurveSpecialFX = new float[128]

	taperDurationFireFX    = new float[128]
	taperDurationFrostFX   = new float[128]
	taperDurationShockFX   = new float[128]
	taperDurationBlueFX    = new float[128]
	taperDurationGreenFX   = new float[128]
	taperDurationPurpleFX  = new float[128]
	taperDurationRedFX     = new float[128]
	taperDurationSpecialFX = new float[128]

	presetBaseOverrideFireFX    = new int[128]
	presetBaseOverrideFrostFX   = new int[128]
	presetBaseOverrideShockFX   = new int[128]
	presetBaseOverrideBlueFX    = new int[128]
	presetBaseOverrideGreenFX   = new int[128]
	presetBaseOverridePurpleFX  = new int[128]
	presetBaseOverrideRedFX     = new int[128]
	presetBaseOverrideSpecialFX = new int[128]

	invalidIntArray   = new int[128]
	invalidFloatArray = new float[128]

	int i = 128
	while i ;(negative will indicate to use default when there is no info)
		i -= 1
		idxEnchArtFireFX[i]          = -1
		idxEnchArtFrostFX[i]         = -1
		idxEnchArtShockFX[i]         = -1
		idxEnchArtBlueFX[i]          = -1
		idxEnchArtGreenFX[i]         = -1
		idxEnchArtPurpleFX[i]        = -1
		idxEnchArtRedFX[i]           = -1
		idxEnchArtSpecialFX[i]       = -1
		; idxEnchShaderFireFX[i]     = -1
		; idxEnchShaderFrostFX[i]    = -1
		; idxEnchShaderShockFX[i]    = -1
		; idxEnchShaderBlueFX[i]     = -1
		; idxEnchShaderGreenFX[i]    = -1
		; idxEnchShaderPurpleFX[i]   = -1
		; idxEnchShaderRedFX[i]      = -1
		; idxEnchShaderSpecialFX[i]  = -1
		idxHitArtFireFX[i]           = -1
		idxHitArtFrostFX[i]          = -1
		idxHitArtShockFX[i]          = -1
		idxHitArtBlueFX[i]           = -1
		idxHitArtGreenFX[i]          = -1
		idxHitArtPurpleFX[i]         = -1
		idxHitArtRedFX[i]            = -1
		idxHitArtSpecialFX[i]        = -1
		idxHitShaderFireFX[i]        = -1
		idxHitShaderFrostFX[i]       = -1
		idxHitShaderShockFX[i]       = -1
		idxHitShaderBlueFX[i]        = -1
		idxHitShaderGreenFX[i]       = -1
		idxHitShaderPurpleFX[i]      = -1
		idxHitShaderRedFX[i]         = -1
		idxHitShaderSpecialFX[i]     = -1
		idxProjectileFireFX[i]       = -1
		idxProjectileFrostFX[i]      = -1
		idxProjectileShockFX[i]      = -1
		idxProjectileBlueFX[i]       = -1
		idxProjectileGreenFX[i]      = -1
		idxProjectilePurpleFX[i]     = -1
		idxProjectileRedFX[i]        = -1
		idxProjectileSpecialFX[i]    = -1
		idxImpactDataFireFX[i]       = -1
		idxImpactDataFrostFX[i]      = -1
		idxImpactDataShockFX[i]      = -1
		idxImpactDataBlueFX[i]       = -1
		idxImpactDataGreenFX[i]      = -1
		idxImpactDataPurpleFX[i]     = -1
		idxImpactDataRedFX[i]        = -1
		idxImpactDataSpecialFX[i]    = -1
		fxPersistFireFX[i]           = -1
		fxPersistFrostFX[i]          = -1
		fxPersistShockFX[i]          = -1
		fxPersistBlueFX[i]           = -1
		fxPersistGreenFX[i]          = -1
		fxPersistPurpleFX[i]         = -1
		fxPersistRedFX[i]            = -1
		fxPersistSpecialFX[i]        = -1
		taperWeightFireFX[i]         = -1.0
		taperWeightFrostFX[i]        = -1.0
		taperWeightShockFX[i]        = -1.0
		taperWeightBlueFX[i]         = -1.0
		taperWeightGreenFX[i]        = -1.0
		taperWeightPurpleFX[i]       = -1.0
		taperWeightRedFX[i]          = -1.0
		taperWeightSpecialFX[i]      = -1.0
		taperCurveFireFX[i]          = -1.0
		taperCurveFrostFX[i]         = -1.0
		taperCurveShockFX[i]         = -1.0
		taperCurveBlueFX[i]          = -1.0
		taperCurveGreenFX[i]         = -1.0
		taperCurvePurpleFX[i]        = -1.0
		taperCurveRedFX[i]           = -1.0
		taperCurveSpecialFX[i]       = -1.0
		taperDurationFireFX[i]       = -1.0
		taperDurationFrostFX[i]      = -1.0
		taperDurationShockFX[i]      = -1.0
		taperDurationBlueFX[i]       = -1.0
		taperDurationGreenFX[i]      = -1.0
		taperDurationPurpleFX[i]     = -1.0
		taperDurationRedFX[i]        = -1.0
		taperDurationSpecialFX[i]    = -1.0
		presetBaseOverrideFireFX[i]    = -1
		presetBaseOverrideFrostFX[i]   = -1
		presetBaseOverrideShockFX[i]   = -1
		presetBaseOverrideBlueFX[i]    = -1
		presetBaseOverrideGreenFX[i]   = -1
		presetBaseOverridePurpleFX[i]  = -1
		presetBaseOverrideRedFX[i]     = -1
		presetBaseOverrideSpecialFX[i] = -1
		invalidIntArray[i]             = -1
		invalidFloatArray[i]         = -1.0
		;used to mark presets with duplicate enchant shaders to repress showing their string in Enchant Shader advanced menu:
		bIsEnchShaderStrFireFX[i]    = true
		bIsEnchShaderStrFrostFX[i]   = true
		bIsEnchShaderStrShockFX[i]   = true
		bIsEnchShaderStrBlueFX[i]    = true
		bIsEnchShaderStrGreenFX[i]   = true
		bIsEnchShaderStrPurpleFX[i]  = true
		bIsEnchShaderStrRedFX[i]     = true
		bIsEnchShaderStrSpecialFX[i] = true
	endWhile


	sFXTypes   = new string[10]
	sFireFX    = new string[128]
	sFrostFX   = new string[128]
	sShockFX   = new string[128]
	sBlueFX    = new string[128]
	sGreenFX   = new string[128]
	sPurpleFX  = new string[128]
	sRedFX     = new string[128]
	sSpecialFX = new string[128]

	sFXTypes[0] = "$Fire FX"
	sFXTypes[1] = "$Frost FX"
	sFXTypes[2] = "$Shock FX"
	sFXTypes[3] = "$Blue FX"
	sFXTypes[4] = "$Green FX"
	sFXTypes[5] = "$Purple FX"
	sFXTypes[6] = "$Red FX"
	sFXTypes[7] = "$Special FX"
	sFXTypes[8] = "$NONE"
	;(if adding more to sFXTypes, need to edit "% 9" op handler in menu)


	sFireFX[0]  = "$Default Fire FX"                      ;THESE DEFAULTS WILL HAVE TO BE HANDLED SPECIALLY when chosen in menu. I can't fill them here because, for example,
	sFireFX[1]  = "$Fire  (Vysh)" ;Vysh                      ;there are multiple defaults for "purple" -- could be soul trap or banish or who knows what. Need to read the default
	sFireFX[2]  = "$Fire Silent  (Vysh)"                     ;value from the default effect shader array based on the chosen effect instead. (whenever the enchant shader in this
	sFireFX[3]  = "$Fire  (Myopic)" ;Myopic      ;slot == none, will check for a default instead.
	sFireFX[4]  = "$Fire Letters Added  (Myopic)"
	sFireFX[5]  = "$Fire Letters Only  (Myopic)"
	sFireFX[6]  = "$Fire  (darkman24)" ;darkman24
	sFireFX[7]  = "$Fire Alt  (darkman24)"
	sFireFX[8]  = "$Fire  (Aetherius)" ;warden01
	sFireFX[9]  = "$Fire  (SpiderAkiraC)" ;SpiderAkiraC
	sFireFX[10] = "$Flames  (GRIMELEVEN)" ;Grimeleven
	sFireFX[11] = "$Fire Sparks  (BrotherBob)" ;BrotherBob
	sFireFX[12] = "$Fire Smoke  (BrotherBob)"
	sFireFX[13] = "$Fire Smoke Silent  (BrotherBob)"
	sFireFX[14] = "$Fire  (Sinobol)"
	;sFireFX[14] = "$AEE Hand Flames" ;Rizing/jjim83
	sFireFX[15] = "$Aelfa Script  (Doorn)" ;Doorn
	sFireFX[16] = "$Daedric Script  (Doorn)"
	sFireFX[17] = "$Dragon Script  (Doorn)"
	sFireFX[18] = "$Dwemer Script  (Doorn)"
	sFireFX[19] = "$Vanilla Alt  (Doorn)"
	sFireFX[20] = "$Energized  (Doorn)"
	sFireFX[21] = "$Peaceful  (Doorn)"
	sFireFX[22] = "$Smoke  (Doorn)"
	sFireFX[23] = "$Wind  (Doorn)"
	sFireFX[24] = "$Aelfa Script Dark  (Doorn)"
	sFireFX[25] = "$Daedric Script Dark  (Doorn)"
	sFireFX[26] = "$Dragon Script Dark  (Doorn)"
	sFireFX[27] = "$Dwemer Script Dark  (Doorn)"
	sFireFX[28] = "$Vanilla Alt Dark  (Doorn)"
	sFireFX[29] = "$Energized Dark  (Doorn)"
	sFireFX[30] = "$Peaceful Dark  (Doorn)"
	sFireFX[31] = "$Smoke Dark  (Doorn)"
	sFireFX[32] = "$Wind Dark  (Doorn)"
	sFireFX[33] = "$Daedric Script  (AwkwardPsyche)" ;AwkwardPsyche
	sFireFX[34] = "$Dragon Script  (AwkwardPsyche)"
	sFireFX[35] = "$Dwemer Script  (AwkwardPsyche)"
	sFireFX[36] = "$Esoteric Script  (AwkwardPsyche)"
	sFireFX[37] = "$Falmer Script  (AwkwardPsyche)"

	idxEnchArtFireFX[8]  = 7
	idxEnchArtFireFX[9]  = 21
	idxEnchArtFireFX[10] = 31   ;if true, has art. Call fetchArt() to get right one for weapon
	idxEnchArtFireFX[11] = 40   ; probably I should optimize if it doesnt have art and no be checking all
	idxEnchArtFireFX[12] = 34   ; the time when something is equipped.
	idxEnchArtFireFX[13] = 34
	idxEnchArtFireFX[14] = 45

	fxPersistFireFX[9]     = 1
	taperWeightFireFX[9]   = 0.14
	taperCurveFireFX[9]    = 5.0
	taperDurationFireFX[9] = 5.0

	sFrostFX[0]  = "$Default Frost FX"
	sFrostFX[1]  = "$Frost  (Vysh)" ;Vysh
	sFrostFX[2]  = "$Frost Silent  (Vysh)"
	sFrostFX[3]  = "$Frost  (Myopic)" ;Myopic
	sFrostFX[4]  = "$Frost Letters Added  (Myopic)"
	sFrostFX[5]  = "$Frost Letters Only  (Myopic)"
	sFrostFX[6]  = "$Frost  (darkman24)" ;darkman24
	sFrostFX[7]  = "$Frost  (Aetherius)" ;warden01
	sFrostFX[8]  = "$Frost  (SpiderAkiraC)" ;SpiderAkiraC
	sFrostFX[9]  = "$Frost  (GRIMELEVEN)" ;Grimeleven
	sFrostFX[10] = "$Frost  (BrotherBob)" ;BrotherBob
	sFrostFX[11] = "$Frost Alt  (BrotherBob)"
	sFrostFX[12] = "$Frost Silent  (BrotherBob)"
	sFrostFX[13] = "$Frost Alt Silent  (BrotherBob)"
	sFrostFX[14] = "$Frost  (Sinobol)"
	;sFrostFX[14] = "$AEE Blue Ice" ;Rizing/jjim83
	sFrostFX[15] = "$Aelfa Script  (Doorn)" ;Doorn
	sFrostFX[16] = "$Daedric Script  (Doorn)"
	sFrostFX[17] = "$Dragon Script  (Doorn)"
	sFrostFX[18] = "$Dwemer Script  (Doorn)"
	sFrostFX[19] = "$Vanilla Alt  (Doorn)"
	sFrostFX[20] = "$Energized  (Doorn)"
	sFrostFX[21] = "$Peaceful  (Doorn)"
	sFrostFX[22] = "$Smoke  (Doorn)"
	sFrostFX[23] = "$Wind  (Doorn)"
	sFrostFX[24] = "$Aelfa Script Dark  (Doorn)"
	sFrostFX[25] = "$Daedric Script Dark  (Doorn)"
	sFrostFX[26] = "$Dragon Script Dark  (Doorn)"
	sFrostFX[27] = "$Dwemer Script Dark  (Doorn)"
	sFrostFX[28] = "$Vanilla Alt Dark  (Doorn)"
	sFrostFX[29] = "$Energized Dark  (Doorn)"
	sFrostFX[30] = "$Peaceful Dark  (Doorn)"
	sFrostFX[31] = "$Smoke Dark  (Doorn)"
	sFrostFX[32] = "$Wind Dark  (Doorn)"
	sFrostFX[33] = "$Daedric Script  (AwkwardPsyche)" ;AwkwardPsyche
	sFrostFX[34] = "$Dragon Script  (AwkwardPsyche)"
	sFrostFX[35] = "$Dwemer Script  (AwkwardPsyche)"
	sFrostFX[36] = "$Esoteric Script  (AwkwardPsyche)"
	sFrostFX[37] = "$Falmer Script  (AwkwardPsyche)"

	bIsEnchShaderStrFrostFX[11] = false
	bIsEnchShaderStrFrostFX[13] = false
	idxEnchArtFrostFX[7]  = 8
	idxEnchArtFrostFX[8]  = 22
	idxEnchArtFrostFX[9]  = 28
	idxHitShaderFrostFX[9] = 3 ;FrostFXShader
	idxEnchArtFrostFX[10] = 41
	idxEnchArtFrostFX[11] = 40
	idxEnchArtFrostFX[12] = 41
	idxEnchArtFrostFX[13] = 40
	idxEnchArtFrostFX[14] = 46

	;fxPersistFrostFX[8]     = 1 default already
	taperWeightFrostFX[8]   = 0.14
	taperCurveFrostFX[8]    = 5.0
	taperDurationFrostFX[8] = 5.0

	sShockFX[0]  = "$Default Shock FX"
	sShockFX[1]  = "$Shock  (Vysh)" ;Vysh
	sShockFX[2]  = "$Shock Silent  (Vysh)"
	sShockFX[3]  = "$Shock  (Myopic)" ;Myopic
	sShockFX[4]  = "$Shock Letters Added  (Myopic)"
	sShockFX[5]  = "$Shock Letters Only  (Myopic)"
	sShockFX[6]  = "$Shock  (darkman24)" ;darkman24
	sShockFX[7]  = "$Shock Alt  (darkman24)"
	sShockFX[8]  = "$Sparks  (Aetherius)" ;warden01
	sShockFX[9]  = "$Sparks  (SpiderAkiraC)" ;SpiderAkiraC
	sShockFX[10] = "$Sparks  (GRIMELEVEN)" ;Grimeleven
	sShockFX[11] = "$Sparks  (BrotherBob)" ;BrotherBob
	sShockFX[12] = "$Sparks Silent  (BrotherBob)"
	sShockFX[13] = "$Shock  (Sinobol)"
	;sShockFX[13] = "$AEE Hand Sparks" ;Rizing/jjim83
	sShockFX[14] = "$Aelfa Script  (Doorn)" ;Doorn
	sShockFX[15] = "$Daedric Script  (Doorn)"
	sShockFX[16] = "$Dragon Script  (Doorn)"
	sShockFX[17] = "$Dwemer Script  (Doorn)"
	sShockFX[18] = "$Vanilla Alt  (Doorn)"
	sShockFX[19] = "$Energized  (Doorn)"
	sShockFX[20] = "$Peaceful  (Doorn)"
	sShockFX[21] = "$Smoke  (Doorn)"
	sShockFX[22] = "$Wind  (Doorn)"
	sShockFX[23] = "$Aelfa Script Dark  (Doorn)"
	sShockFX[24] = "$Daedric Script Dark  (Doorn)"
	sShockFX[25] = "$Dragon Script Dark  (Doorn)"
	sShockFX[26] = "$Dwemer Script Dark  (Doorn)"
	sShockFX[27] = "$Vanilla Alt Dark  (Doorn)"
	sShockFX[28] = "$Energized Dark  (Doorn)"
	sShockFX[29] = "$Peaceful Dark  (Doorn)"
	sShockFX[30] = "$Smoke Dark  (Doorn)"
	sShockFX[31] = "$Wind Dark  (Doorn)"
	sShockFX[32] = "$Daedric Script  (AwkwardPsyche)" ;AwkwardPsyche
	sShockFX[33] = "$Dragon Script  (AwkwardPsyche)"
	sShockFX[34] = "$Dwemer Script  (AwkwardPsyche)"
	sShockFX[35] = "$Esoteric Script  (AwkwardPsyche)"
	sShockFX[36] = "$Falmer Script  (AwkwardPsyche)"

	idxEnchArtShockFX[8]  = 10
	idxEnchArtShockFX[9]  = 25
	idxEnchArtShockFX[10] = 29
	idxEnchArtShockFX[11] = 34
	idxEnchArtShockFX[12] = 34
	idxEnchArtShockFX[13] = 47

	;fxPersistShockFX[9]     = 1 default already
	taperWeightShockFX[9]   = 0.14
	taperCurveShockFX[9]    = 5.0
	taperDurationShockFX[9] = 5.0

	sBlueFX[0]  = "$Default Blue FX"
	sBlueFX[1]  = "$Cloudy Blue  (Vysh)" ;Vysh
	sBlueFX[2]  = "$Spider Blue  (Vysh)"
	sBlueFX[3]  = "$Soul Blue  (Vysh)"
	sBlueFX[4]  = "$Cloudy Blue Silent  (Vysh)"
	sBlueFX[5]  = "$Spider Blue Silent  (Vysh)"
	sBlueFX[6]  = "$Soul Blue Silent  (Vysh)"
	sBlueFX[7]  = "$Blue  (Myopic)" ;Myopic
	sBlueFX[8]  = "$Blue Letters Added  (Myopic)"
	sBlueFX[9]  = "$Blue Letters Only  (Myopic)"
	sBlueFX[10] = "$Blue  (darkman24)" ;darkman24
	sBlueFX[11] = "$Blue  (Aetherius)" ;warden01
	sBlueFX[12] = "$Blue Absorb  (Aetherius)"
	sBlueFX[13] = "$Blue Ice  (Aetherius)"
	sBlueFX[14] = "$Blue  (SpiderAkiraC)" ;SpiderAkiraC
	sBlueFX[15] = "$Blue Alt  (SpiderAkiraC)"
	sBlueFX[16] = "$Blue Magic  (GRIMELEVEN)" ;Grimeleven
	sBlueFX[17] = "$Blue  (Sinobol)"
	;sBlueFX[17] = "$AEE Blue Ice" ;Rizing/jjim83
	sBlueFX[18] = "$Aelfa Script  (Doorn)" ;Doorn
	sBlueFX[19] = "$Daedric Script  (Doorn)"
	sBlueFX[20] = "$Dragon Script  (Doorn)"
	sBlueFX[21] = "$Dwemer Script  (Doorn)"
	sBlueFX[22] = "$Vanilla Alt  (Doorn)"
	sBlueFX[23] = "$Energized  (Doorn)"
	sBlueFX[24] = "$Peaceful  (Doorn)"
	sBlueFX[25] = "$Smoke  (Doorn)"
	sBlueFX[26] = "$Wind  (Doorn)"
	sBlueFX[27] = "$Aelfa Script Dark  (Doorn)"
	sBlueFX[28] = "$Daedric Script Dark  (Doorn)"
	sBlueFX[29] = "$Dragon Script Dark  (Doorn)"
	sBlueFX[30] = "$Dwemer Script Dark  (Doorn)"
	sBlueFX[31] = "$Vanilla Alt Dark  (Doorn)"
	sBlueFX[32] = "$Energized Dark  (Doorn)"
	sBlueFX[33] = "$Peaceful Dark  (Doorn)"
	sBlueFX[34] = "$Smoke Dark  (Doorn)"
	sBlueFX[35] = "$Wind Dark  (Doorn)"
	sBlueFX[36] = "$Daedric Script  (AwkwardPsyche)" ;AwkwardPsyche
	sBlueFX[37] = "$Dragon Script  (AwkwardPsyche)"
	sBlueFX[38] = "$Dwemer Script  (AwkwardPsyche)"
	sBlueFX[39] = "$Esoteric Script  (AwkwardPsyche)"
	sBlueFX[40] = "$Falmer Script  (AwkwardPsyche)"

	bIsEnchShaderStrBlueFX[12] = false
	idxEnchArtBlueFX[11] = 4
	idxEnchArtBlueFX[12] = 1
	idxEnchArtBlueFX[14] = 27
	idxEnchArtBlueFX[15] = 23
	idxEnchArtBlueFX[16] = 32
	idxEnchArtBlueFX[17] = 51

	idxEnchArtBlueFX[13]    = 12  ;SpecialBlueAO
	idxHitShaderBlueFX[13]  = 14  ;FrostIceFormFXShader02
	idxProjectileBlueFX[13] = 11  ;VoiceIceFormProjectile01
	idxImpactDataBlueFX[13] = 12  ;MAGFrostIceStorm01ImpactSet
	fxPersistBlueFX[13]     = 1

	sGreenFX[0]  = "$Default Green FX"
	sGreenFX[1]  = "$Cloudy Green  (Vysh)" ;Vysh
	sGreenFX[2]  = "$Spider Green  (Vysh)"
	sGreenFX[3]  = "$Paralyze Green  (Vysh)"
	sGreenFX[4]  = "$Green & Black  (Vysh)"
	sGreenFX[5]  = "$Cloudy Green Silent  (Vysh)"
	sGreenFX[6]  = "$Spider Green Silent  (Vysh)"
	sGreenFX[7]  = "$Paralyze Green Silent  (Vysh)"
	sGreenFX[8]  = "$Green & Black Silent  (Vysh)"
	sGreenFX[9]  = "$Green  (Myopic)" ;Myopic
	sGreenFX[10] = "$Green Letters Added  (Myopic)"
	sGreenFX[11] = "$Green Letters Only  (Myopic)"
	sGreenFX[12] = "$Green  (darkman24)" ;darkman24
	sGreenFX[13] = "$Yellow  (Aetherius)";warden01
	sGreenFX[14] = "$Green  (Aetherius)"
	sGreenFX[15] = "$Green Absorb  (Aetherius)"
	sGreenFX[16] = "$Green Paralyze  (Aetherius)"
	sGreenFX[17] = "$Green Special  (Aetherius)"
	sGreenFX[18] = "$Green  (SpiderAkiraC)" ;SpiderAkiraC
	sGreenFX[19] = "$Green Alt  (SpiderAkiraC)"
	sGreenFX[20] = "$Green  (GRIMELEVEN)"
	sGreenFX[21] = "$Green  (Sinobol)"
	sGreenFX[22] = "$Aelfa Script  (Doorn)" ;Doorn
	sGreenFX[23] = "$Daedric Script  (Doorn)"
	sGreenFX[24] = "$Dragon Script  (Doorn)"
	sGreenFX[25] = "$Dwemer Script  (Doorn)"
	sGreenFX[26] = "$Vanilla Alt  (Doorn)"
	sGreenFX[27] = "$Energized  (Doorn)"
	sGreenFX[28] = "$Peaceful  (Doorn)"
	sGreenFX[29] = "$Smoke  (Doorn)"
	sGreenFX[30] = "$Wind  (Doorn)"
	sGreenFX[31] = "$Aelfa Script Dark  (Doorn)"
	sGreenFX[32] = "$Daedric Script Dark  (Doorn)"
	sGreenFX[33] = "$Dragon Script Dark  (Doorn)"
	sGreenFX[34] = "$Dwemer Script Dark  (Doorn)"
	sGreenFX[35] = "$Vanilla Alt Dark  (Doorn)"
	sGreenFX[36] = "$Energized Dark  (Doorn)"
	sGreenFX[37] = "$Peaceful Dark  (Doorn)"
	sGreenFX[38] = "$Smoke Dark  (Doorn)"
	sGreenFX[39] = "$Wind Dark  (Doorn)"
	sGreenFX[40] = "$Daedric Script  (AwkwardPsyche)" ;AwkwardPsyche
	sGreenFX[41] = "$Dragon Script  (AwkwardPsyche)"
	sGreenFX[42] = "$Dwemer Script  (AwkwardPsyche)"
	sGreenFX[43] = "$Esoteric Script  (AwkwardPsyche)"
	sGreenFX[44] = "$Falmer Script  (AwkwardPsyche)"

	bIsEnchShaderStrGreenFX[15] = false
	bIsEnchShaderStrGreenFX[16] = false

	idxEnchArtGreenFX[14] = 5 ;warden damage green
	idxEnchArtGreenFX[15] = 2 ;warden absorb green
	idxEnchArtGreenFX[16] = 9 ;warden paralyze green
	idxEnchArtGreenFX[18] = 18
	idxEnchArtGreenFX[19] = 24
	idxEnchArtGreenFX[20] = 34
	idxEnchArtGreenFX[21] = 50

	idxEnchArtGreenFX[13]    = 16 ;warden special yellow AO
	idxHitShaderGreenFX[13]  = 4  ;ShockFXShader
	idxImpactDataGreenFX[13] = 4  ;MAGShock01ImpactSet

	idxEnchArtGreenFX[17]    = 13 ;warden special green
	idxHitShaderGreenFX[17]  = 15 ;ChaurusPoisonFXShader
	idxHitArtGreenFX[17]     = 3  ;PoisonCloak01
	idxProjectileGreenFX[17] = 10 ;DA13PoisonSprayProjectile
	idxImpactDataGreenFX[17] = 11 ;MAGPoisonSprayImpactSet
	fxPersistGreenFX[17]     = 1
	taperWeightGreenFX[17]   = 0.14
	taperCurveGreenFX[17]    = 5.0
	taperDurationGreenFX[17] = 4.0

	sPurpleFX[0]  = "$Default Purple FX"
	sPurpleFX[1]  = "$Cloudy Purple  (Vysh)" ;Vysh
	sPurpleFX[2]  = "$Cloudy Purple Silent  (Vysh)"
	sPurpleFX[3]  = "$Purple  (Myopic)" ;Myopic
	sPurpleFX[4]  = "$Purple Letters Added  (Myopic)"
	sPurpleFX[5]  = "$Purple Letters Only  (Myopic)"
	sPurpleFX[6]  = "$Purple  (darkman24)" ;darkman24
	sPurpleFX[7]  = "$Purple  (Aetherius)" ;warden01
	sPurpleFX[8]  = "$Violet  (Aetherius)"
	sPurpleFX[9]  = "$Purple  (SpiderAkiraC)" ;SpiderAkiraC
	sPurpleFX[10] = "$Soul Purple  (GRIMELEVEN)" ;Grimeleven
	sPurpleFX[11] = "$Purple  (Sinobol)"
	sPurpleFX[12] = "$Aelfa Script  (Doorn)" ;Doorn
	sPurpleFX[13] = "$Daedric Script  (Doorn)"
	sPurpleFX[14] = "$Dragon Script  (Doorn)"
	sPurpleFX[15] = "$Dwemer Script  (Doorn)"
	sPurpleFX[16] = "$Vanilla Alt  (Doorn)"
	sPurpleFX[17] = "$Energized  (Doorn)"
	sPurpleFX[18] = "$Peaceful  (Doorn)"
	sPurpleFX[19] = "$Smoke  (Doorn)"
	sPurpleFX[20] = "$Wind  (Doorn)"
	sPurpleFX[21] = "$Aelfa Script Dark  (Doorn)"
	sPurpleFX[22] = "$Daedric Script Dark  (Doorn)"
	sPurpleFX[23] = "$Dragon Script Dark  (Doorn)"
	sPurpleFX[24] = "$Dwemer Script Dark  (Doorn)"
	sPurpleFX[25] = "$Vanilla Alt Dark  (Doorn)"
	sPurpleFX[26] = "$Energized Dark  (Doorn)"
	sPurpleFX[27] = "$Peaceful Dark  (Doorn)"
	sPurpleFX[28] = "$Smoke Dark  (Doorn)"
	sPurpleFX[29] = "$Wind Dark  (Doorn)"
	sPurpleFX[30] = "$Daedric Script  (AwkwardPsyche)" ;AwkwardPsyche
	sPurpleFX[31] = "$Dragon Script  (AwkwardPsyche)"
	sPurpleFX[32] = "$Dwemer Script  (AwkwardPsyche)"
	sPurpleFX[33] = "$Esoteric Script  (AwkwardPsyche)"
	sPurpleFX[34] = "$Falmer Script  (AwkwardPsyche)"

	idxEnchArtPurpleFX[7]  = 11 ;warden soul trap AO
	idxEnchArtPurpleFX[9]  = 26 ;soul trap art
	idxEnchArtPurpleFX[10] = 33
	idxEnchArtPurpleFX[11] = 52

	idxEnchArtPurpleFX[8]    = 15 ;warden special violet AO
	idxHitShaderPurpleFX[8]  = 3 ;FrostFXShader
	idxImpactDataPurpleFX[8] = 9 ;TurnUnlImpactSet       ;this is my mixture of a few of his kagonite effects, meant for Turn Undead (since he doesn't have one)
	idxProjectilePurpleFX[8] = 8 ;TurnUndeadProjectile
	fxPersistPurpleFX[8]     = 1

	sRedFX[0]  = "$Default Red FX"
	sRedFX[1]  = "$Cloudy Red  (Vysh)" ;Vysh
	sRedFX[2]  = "$Spider Red  (Vysh)"
	sRedFX[3]  = "$Red & Black  (Vysh)"
	sRedFX[4]  = "$Cloudy Red Silent  (Vysh)"
	sRedFX[5]  = "$Spider Red Silent  (Vysh)"
	sRedFX[6]  = "$Red & Black Silent  (Vysh)"
	sRedFX[7]  = "$Red  (Myopic)" ;Myopic
	sRedFX[8]  = "$Red Letters Added  (Myopic)"
	sRedFX[9]  = "$Red Letters Only  (Myopic)"
	sRedFX[10] = "$Red  (darkman24)" ;darkman24
	sRedFX[11] = "$Pink  (Aetherius)" ;warden01
	sRedFX[12] = "$Red Absorb  (Aetherius)"
	sRedFX[13] = "$Red Flare  (Aetherius)"
	sRedFX[14] = "$Red  (SpiderAkiraC)" ;SpiderAkiraC
	sRedFX[15] = "$Blood Red  (GRIMELEVEN)" ;Grimeleven
	sRedFX[16] = "$Red  (Sinobol)"
	;sRedFX[16] = "$AEE Dark Red" ;Rizer/jjim83
	sRedFX[17] = "$Aelfa Script  (Doorn)" ;Doorn
	sRedFX[18] = "$Daedric Script  (Doorn)"
	sRedFX[19] = "$Dragon Script  (Doorn)"
	sRedFX[20] = "$Dwemer Script  (Doorn)"
	sRedFX[21] = "$Vanilla Alt  (Doorn)"
	sRedFX[22] = "$Energized  (Doorn)"
	sRedFX[23] = "$Peaceful  (Doorn)"
	sRedFX[24] = "$Smoke  (Doorn)"
	sRedFX[25] = "$Wind  (Doorn)"
	sRedFX[26] = "$Aelfa Script Dark  (Doorn)"
	sRedFX[27] = "$Daedric Script Dark  (Doorn)"
	sRedFX[28] = "$Dragon Script Dark  (Doorn)"
	sRedFX[29] = "$Dwemer Script Dark  (Doorn)"
	sRedFX[30] = "$Vanilla Alt Dark  (Doorn)"
	sRedFX[31] = "$Energized Dark  (Doorn)"
	sRedFX[32] = "$Peaceful Dark  (Doorn)"
	sRedFX[33] = "$Smoke Dark  (Doorn)"
	sRedFX[34] = "$Wind Dark  (Doorn)"
	sRedFX[35] = "$Daedric Script  (AwkwardPsyche)" ;AwkwardPsyche
	sRedFX[36] = "$Dragon Script  (AwkwardPsyche)"
	sRedFX[37] = "$Dwemer Script  (AwkwardPsyche)"
	sRedFX[38] = "$Esoteric Script  (AwkwardPsyche)"
	sRedFX[39] = "$Falmer Script  (AwkwardPsyche)"

	idxEnchArtRedFX[11] = 6 ;pink - warden Fear AO
	idxEnchArtRedFX[12] = 3 ;red - warden Absorb AO
	idxEnchArtRedFX[14] = 17 ;best guess
	idxEnchArtRedFX[15] = 30
	idxEnchArtRedFX[16] = 48

	idxEnchArtRedFX[13]    = 14 ;warden special red AO
	idxHitShaderRedFX[13]  = 1  ;FireFXShader
	idxImpactDataRedFX[13] = 1  ;MAGFirebolt01ImpactSet

	sSpecialFX[0]  = "$Banish  (Vysh)"
	sSpecialFX[1]  = "$Turn  (Vysh)"
	sSpecialFX[2]  = "$Cloudburst  (Vysh)" ;TimeFadeOutFXS
	sSpecialFX[3]  = "$Banish Silent  (Vysh)"
	sSpecialFX[4]  = "$Turn Silent  (Vysh)"
	sSpecialFX[5]  = "$Cloudburst Silent  (Vysh)" ;TimeFadeOutFXS
	sSpecialFX[6]  = "$Silvered  (Aetherius)" ;maybe add support for silver weapons to mod?
	sSpecialFX[7]  = "$Fear  (SpiderAkiraC)"
	sSpecialFX[8]  = "$Holy  (SpiderAkiraC)"
	sSpecialFX[9]  = "$Soul Trap  (SpiderAkiraC)"
	sSpecialFX[10] = "$Holy  (GRIMELEVEN)"
	sSpecialFX[11] = "$Holy  (satorius13)"
	sSpecialFX[12] = "$Holy Soul Trap  (satorius13)"
	sSpecialFX[13] = "$Yellow  (Sinobol)"

	if bDAWNGUARD
		sSpecialFX[14] = "$Dawnguard Sunfire" ;this Enchant Shader is a copy of DLC1SunFireFXShader with ambient sound removed.
		idxHitShaderSpecialFX[14] = 20        ;the original DLC1SunFireFXShader is still used as a hit shader in combo with this.
		fxPersistSpecialFX[14] = 1
		taperWeightSpecialFX[14] = 0.17
		taperCurveSpecialFX[14] = 3.0
		taperDurationSpecialFX[14] = 2.0
	endif

	presetBaseOverrideSpecialFX[0] = cEnchBanish
	presetBaseOverrideSpecialFX[1] = cEnchTurnUndead
	presetBaseOverrideSpecialFX[3] = cEnchBanish
	presetBaseOverrideSpecialFX[4] = cEnchTurnUndead
	presetBaseOverrideSpecialFX[7] = cEnchFear
	presetBaseOverrideSpecialFX[8] = cEnchTurnUndead
	presetBaseOverrideSpecialFX[9] = cEnchSoulTrap
	presetBaseOverrideSpecialFX[10] = cEnchTurnUndead

	idxEnchArtSpecialFX[7] = 20
	idxEnchArtSpecialFX[8] = 27
	idxEnchArtSpecialFX[9] = 26
	idxEnchArtSpecialFX[10] = 35
	idxEnchArtSpecialFX[13] = 49

	idxEnchArtSpecialFX[11] = 43
	idxHitShaderSpecialFX[11] = 18
	idxImpactDataSpecialFX[11] = 9

	idxEnchArtSpecialFX[12] = 43
	idxHitShaderSpecialFX[12] = 19
	idxImpactDataSpecialFX[12] = 9
	idxProjectileSpecialFX[12] = 12
	idxHitArtSpecialFX[12] = 1
	bIsEnchShaderStrSpecialFX[12] = false

	idxHitShaderSpecialFX[2]  = 0
	idxHitArtSpecialFX[2]     = 0
	idxImpactDataSpecialFX[2] = 0
	idxProjectileSpecialFX[2] = 0
	fxPersistSpecialFX[2]     = 0
	taperWeightSpecialFX[2]   = 0.0
	taperCurveSpecialFX[2]    = 0.0
	taperDurationSpecialFX[2] = 0.0

	idxHitShaderSpecialFX[5]  = 0
	idxHitArtSpecialFX[5]     = 0
	idxImpactDataSpecialFX[5] = 0
	idxProjectileSpecialFX[5] = 0
	fxPersistSpecialFX[5]     = 0
	taperWeightSpecialFX[5]   = 0.0
	taperCurveSpecialFX[5]    = 0.0
	taperDurationSpecialFX[5] = 0.0

	idxHitShaderSpecialFX[6]  = 0
	idxHitArtSpecialFX[6]     = 0
	idxImpactDataSpecialFX[6] = 0
	idxProjectileSpecialFX[6] = 0
	fxPersistSpecialFX[6]     = 0
	taperWeightSpecialFX[6]   = 0.0
	taperCurveSpecialFX[6]    = 0.0
	taperDurationSpecialFX[6] = 0.0
EndFunction



int[] Function fetchEnchArtInfo(int fxType)
	if (fxType < 4)
		if fxType == 0
			return idxEnchArtFireFX
		elseif fxType == 1
			return idxEnchArtFrostFX
		elseif fxType == 2
			return idxEnchArtShockFX
		elseif fxType == 3
			return idxEnchArtBlueFX
		endif
	else
		if fxType == 4
			return idxEnchArtGreenFX
		elseif fxType == 5
			return idxEnchArtPurpleFX
		elseif fxType == 6
			return idxEnchArtRedFX
		elseif fxType == 7
			return idxEnchArtSpecialFX
		endif
	endif
	return invalidIntArray
EndFunction

int[] Function fetchHitArtInfo(int fxType)
	if (fxType < 4)
		if fxType == 0
			return idxHitArtFireFX
		elseif fxType == 1
			return idxHitArtFrostFX
		elseif fxType == 2
			return idxHitArtShockFX
		elseif fxType == 3
			return idxHitArtBlueFX
		endif
	else
		if fxType == 4
			return idxHitArtGreenFX
		elseif fxType == 5
			return idxHitArtPurpleFX
		elseif fxType == 6
			return idxHitArtRedFX
		elseif fxType == 7
			return idxHitArtSpecialFX
		endif
	endif
	return invalidIntArray
EndFunction

int[] Function fetchHitShaderInfo(int fxType)
	if (fxType < 4)
		if fxType == 0
			return idxHitShaderFireFX
		elseif fxType == 1
			return idxHitShaderFrostFX
		elseif fxType == 2
			return idxHitShaderShockFX
		elseif fxType == 3
			return idxHitShaderBlueFX
		endif
	else
		if fxType == 4
			return idxHitShaderGreenFX
		elseif fxType == 5
			return idxHitShaderPurpleFX
		elseif fxType == 6
			return idxHitShaderRedFX
		elseif fxType == 7
			return idxHitShaderSpecialFX
		endif
	endif
	return invalidIntArray
EndFunction

int[] Function fetchImpactDataInfo(int fxType)
	if (fxType < 4)
		if fxType == 0
			return idxImpactDataFireFX
		elseif fxType == 1
			return idxImpactDataFrostFX
		elseif fxType == 2
			return idxImpactDataShockFX
		elseif fxType == 3
			return idxImpactDataBlueFX
		endif
	else
		if fxType == 4
			return idxImpactDataGreenFX
		elseif fxType == 5
			return idxImpactDataPurpleFX
		elseif fxType == 6
			return idxImpactDataRedFX
		elseif fxType == 7
			return idxImpactDataSpecialFX
		endif
	endif
	return invalidIntArray
EndFunction

int[] Function fetchProjectileInfo(int fxType)
	if (fxType < 4)
		if fxType == 0
			return idxProjectileFireFX
		elseif fxType == 1
			return idxProjectileFrostFX
		elseif fxType == 2
			return idxProjectileShockFX
		elseif fxType == 3
			return idxProjectileBlueFX
		endif
	else
		if fxType == 4
			return idxProjectileGreenFX
		elseif fxType == 5
			return idxProjectilePurpleFX
		elseif fxType == 6
			return idxProjectileRedFX
		elseif fxType == 7
			return idxProjectileSpecialFX
		endif
	endif
	return invalidIntArray
EndFunction

int[] Function fetchFXPersistInfo(int fxType)
	if (fxType < 4)
		if fxType == 0
			return fxPersistFireFX
		elseif fxType == 1
			return fxPersistFrostFX
		elseif fxType == 2
			return fxPersistShockFX
		elseif fxType == 3
			return fxPersistBlueFX
		endif
	else
		if fxType == 4
			return fxPersistGreenFX
		elseif fxType == 5
			return fxPersistPurpleFX
		elseif fxType == 6
			return fxPersistRedFX
		elseif fxType == 7
			return fxPersistSpecialFX
		endif
	endif
	return invalidIntArray
EndFunction

float[] Function fetchTaperWeightInfo(int fxType)
	if (fxType < 4)
		if fxType == 0
			return taperWeightFireFX
		elseif fxType == 1
			return taperWeightFrostFX
		elseif fxType == 2
			return taperWeightShockFX
		elseif fxType == 3
			return taperWeightBlueFX
		endif
	else
		if fxType == 4
			return taperWeightGreenFX
		elseif fxType == 5
			return taperWeightPurpleFX
		elseif fxType == 6
			return taperWeightRedFX
		elseif fxType == 7
			return taperWeightSpecialFX
		endif
	endif
	return invalidFloatArray
EndFunction

float[] Function fetchTaperCurveInfo(int fxType)
	if (fxType < 4)
		if fxType == 0
			return taperCurveFireFX
		elseif fxType == 1
			return taperCurveFrostFX
		elseif fxType == 2
			return taperCurveShockFX
		elseif fxType == 3
			return taperCurveBlueFX
		endif
	else
		if fxType == 4
			return taperCurveGreenFX
		elseif fxType == 5
			return taperCurvePurpleFX
		elseif fxType == 6
			return taperCurveRedFX
		elseif fxType == 7
			return taperCurveSpecialFX
		endif
	endif
	return invalidFloatArray
EndFunction

float[] Function fetchTaperDurationInfo(int fxType)
	if (fxType < 4)
		if fxType == 0
			return taperDurationFireFX
		elseif fxType == 1
			return taperDurationFrostFX
		elseif fxType == 2
			return taperDurationShockFX
		elseif fxType == 3
			return taperDurationBlueFX
		endif
	else
		if fxType == 4
			return taperDurationGreenFX
		elseif fxType == 5
			return taperDurationPurpleFX
		elseif fxType == 6
			return taperDurationRedFX
		elseif fxType == 7
			return taperDurationSpecialFX
		endif
	endif
	return invalidFloatArray
EndFunction

bool[] Function fetchIsEnchShaderInfo(int fxType)
	if (fxType < 4)
		if fxType == 0
			return bIsEnchShaderStrFireFX
		elseif fxType == 1
			return bIsEnchShaderStrFrostFX
		elseif fxType == 2
			return bIsEnchShaderStrShockFX
		elseif fxType == 3
			return bIsEnchShaderStrBlueFX
		endif
	else
		if fxType == 4
			return bIsEnchShaderStrGreenFX
		elseif fxType == 5
			return bIsEnchShaderStrPurpleFX
		elseif fxType == 6
			return bIsEnchShaderStrRedFX
		elseif fxType == 7
			return bIsEnchShaderStrSpecialFX
		endif
	endif
	bool[] trueArr = new bool[128]
	int i = 128
	while i
		i -= 1
		trueArr[i] = true
	endWhile
	return trueArr
EndFunction

int[] Function fetchPresetOverride(int fxType)
	if (fxType < 4)
		if fxType == 0
			return presetBaseOverrideFireFX
		elseif fxType == 1
			return presetBaseOverrideFrostFX
		elseif fxType == 2
			return presetBaseOverrideShockFX
		elseif fxType == 3
			return presetBaseOverrideBlueFX
		endif
	else
		if fxType == 4
			return presetBaseOverrideGreenFX
		elseif fxType == 5
			return presetBaseOverridePurpleFX
		elseif fxType == 6
			return presetBaseOverrideRedFX
		elseif fxType == 7
			return presetBaseOverrideSpecialFX
		endif
	endif
	return invalidIntArray
EndFunction



;__________________________________________________________________________________________________________________________________________
;------------------------------------------------------ VANILLA DEFAULTS ------------------------------------------------------------------

int[]			property effectDefaultsFXPersist     auto hidden
float[]			property effectDefaultsTaperWeight   auto hidden
float[]			property effectDefaultsTaperCurve    auto hidden
float[]			property effectDefaultsTaperDuration auto hidden
Art[]			property effectDefaultsHitArt        auto hidden
Art[]			property effectDefaultsEnchArt       auto hidden
EffectShader[] 	property effectDefaultsHitShader     auto ;filled in CK
EffectShader[]	property effectDefaultsEnchShader    auto ;filled in CK
Projectile[] 	property effectDefaultsProjectile    auto ;filled in CK
ImpactDataSet[]	property effectDefaultsImpactData    auto hidden

Function InitializeDefaultData()
;these default data sets are derived from vanilla and will be used to set anything without a defined value (>= 0)
;in the preset visual effect sets. Need to be seperate because vanilla effects even with same color have diff data
	effectDefaultsFXPersist		= new int[50] ;0=false, 1=true (not bool b/c need -1 to indicate no data in parallel array for effect sets)
	effectDefaultsTaperWeight	= new float[50]
	effectDefaultsTaperCurve	= new float[50]
	effectDefaultsTaperDuration	= new float[50]
	effectDefaultsHitArt		= new Art[50]
	effectDefaultsEnchArt		= new Art[50]
	effectDefaultsImpactData	= new ImpactDataSet[50]

	effectDefaultsFXPersist[cEnchAbHealth]		= 1
	effectDefaultsFXPersist[cEnchAbMagicka]		= 1  ;these 3 have no effect at all either
	effectDefaultsFXPersist[cEnchAbStamina]		= 1
	effectDefaultsFXPersist[cEnchBanish]		= 0
	effectDefaultsFXPersist[cEnchFear]			= 1
	effectDefaultsFXPersist[cEnchSoulTrap]		= 1
	effectDefaultsFXPersist[cEnchFire]			= 0
	effectDefaultsFXPersist[cEnchFrost]			= 1  ;this has no effect whatsoever
	effectDefaultsFXPersist[cEnchMagickaDam]	= 0
	effectDefaultsFXPersist[cEnchParalysis]		= 1
	effectDefaultsFXPersist[cEnchShock]			= 1  ;no effect either, even though shock has 1 second duration (effectShader duration probably just longer than 1 sec anyway)
	effectDefaultsFXPersist[cEnchSilentMoons]	= 0
	effectDefaultsFXPersist[cEnchStaminaDam]	= 0
	effectDefaultsFXPersist[cEnchTurnUndead]	= 1

	;effectDefaultsTaperWeight[cEnchAbHealth]	= 1.0
	;effectDefaultsTaperWeight[cEnchAbMagicka]	= 1.0 ;these 1.0 vals have no effect either for absorb effects, since no taper duration exists
	;effectDefaultsTaperWeight[cEnchAbStamina]	= 1.0
	effectDefaultsTaperWeight[cEnchFire]		= 0.2
	effectDefaultsTaperWeight[cEnchSilentMoons]	= 0.2

	effectDefaultsTaperCurve[cEnchFire]			= 2.0
	effectDefaultsTaperCurve[cEnchSilentMoons]	= 2.0

	effectDefaultsTaperDuration[cEnchFire]			= 1.0
	effectDefaultsTaperDuration[cEnchSilentMoons]	= 2.0

	effectDefaultsHitArt[cEnchSoulTrap]		= game.GetFormFromFile(0x0506D6, "Skyrim.esm") as Art ;SoulTrapTargetEffects [ARTO:000506D6]
	effectDefaultsHitArt[cEnchParalysis]	= game.GetFormFromFile(0x06DE86, "Skyrim.esm") as Art ;ParalyzeFXBody01 [ARTO:0006DE86]

	; effectDefaultsEnchArt[]		-	leave NONE, not used in any vanilla FX

	; effectDefaultsHitShader[]		-	FILLED IN CK

	; effectDefaultsEnchShader[]	-	FILLED IN CK

	; effectDefaultsProjectile[]	-	FILLED IN CK

	effectDefaultsImpactData[cEnchAbHealth]		= game.GetFormFromFile(0x0ABF01, "Skyrim.esm") as ImpactDataSet ;MAGAbsorbRedImpactSet
	effectDefaultsImpactData[cEnchAbMagicka]	= game.GetFormFromFile(0x0ABF0B, "Skyrim.esm") as ImpactDataSet ;MAGAbsorbBlueImpactSet
	effectDefaultsImpactData[cEnchAbStamina]	= game.GetFormFromFile(0x0ABF0C, "Skyrim.esm") as ImpactDataSet ;MAGAbsorbGreenImpactSet
	effectDefaultsImpactData[cEnchBanish]		= game.GetFormFromFile(0x03A1E9, "Skyrim.esm") as ImpactDataSet ;MAGConjure01ImpactSet
	effectDefaultsImpactData[cEnchFear]			= game.GetFormFromFile(0x04C6DA, "Skyrim.esm") as ImpactDataSet ;MAGTurnUnlImpactSet
	effectDefaultsImpactData[cEnchSoulTrap]		= effectDefaultsImpactData[cEnchFear]							;MAGTurnUnlImpactSet
	effectDefaultsImpactData[cEnchFire]			= game.GetFormFromFile(0x01C2AF, "Skyrim.esm") as ImpactDataSet ;MAGFirebolt01ImpactSet
	effectDefaultsImpactData[cEnchFrost]		= game.GetFormFromFile(0x032DA7, "Skyrim.esm") as ImpactDataSet ;MAGFrostBolt01ImpactSet
	effectDefaultsImpactData[cEnchMagickaDam]	= effectDefaultsImpactData[cEnchFire]							;MAGFirebolt01ImpactSet
	effectDefaultsImpactData[cEnchShock]		= game.GetFormFromFile(0x038B05, "Skyrim.esm") as ImpactDataSet ;MAGShock01ImpactSet
	effectDefaultsImpactData[cEnchStaminaDam]	= effectDefaultsImpactData[cEnchFire]							;MAGFirebolt01ImpactSet
	effectDefaultsImpactData[cEnchTurnUndead]	= effectDefaultsImpactData[cEnchFear]							;MAGTurnUnlImpactSet
	;effectDefaultsImpactData[cEnchParalysis]	= 																;none
	;effectDefaultsImpactData[cEnchSilentMoons]	= 																;none
EndFunction






;__________________________________________________________________________________________________________________________________________
;---------------------------------------------------------- CORE OBJECT DATA VAULT --------------------------------------------------------
;
; most of the time things refer back to these arrays instead of storing the MGEF objects themselves elsewhere (well, in theory. Heh.)
;

;data for Enchant Shaders is not needed here, will reference the arrays above already sorted by effect type & including strings

string[] property xHitArtStrings       auto hidden
string[] property xHitShaderStrings    auto hidden
string[] property xImpactDataStrings   auto hidden
string[] property xProjectileStrings   auto hidden
string[] property xFXPersistStrings    auto hidden
string[] property xEnchArtStrings      auto hidden

string[] Function xEnchShaderStrings(int fxCode, bool filterShaders = true) ;return corresponding strings for this effect color type

	string[] strs = new string[128]
	bool[] include

	if fxCode >= 0
		if fxCode < 4
			if fxCode == 0
				strs = sFireFX
				include = bIsEnchShaderStrFireFX
			elseif fxCode == 1
				strs = sFrostFX
				include = bIsEnchShaderStrFrostFX
			elseif fxCode == 2
				strs = sShockFX
				include = bIsEnchShaderStrShockFX
			elseif fxCode == 3
				strs = sBlueFX
				include = bIsEnchShaderStrBlueFX
			endif
		elseif fxCode < 8
			if fxCode == 4
				strs = sGreenFX
				include = bIsEnchShaderStrGreenFX
			elseif fxCode == 5
				strs = sPurpleFX
				include = bIsEnchShaderStrPurpleFX
			elseif fxCode == 6
				strs = sRedFX
				include = bIsEnchShaderStrRedFX
			elseif fxCode == 7
				strs = sSpecialFX
				include = bIsEnchShaderStrSpecialFX
			endif
		endif
	endif

	if ((!strs[0]) || (!filterShaders)) ;if undefined or no filtering needed
		return strs
	endif

	string[] retStrs = new string[128]

	;filter out duplicate/unnecessary shader strings
	int idx = 0
	int retIdx = 0
	while (strs[idx] != "")
		if include[idx]
			retStrs[retIdx] = strs[idx]
			retIdx += 1
		endif
		idx += 1
	endWhile

	return retStrs
EndFunction


Art[]           property xHitArtArray         auto hidden
EffectShader[]  property xHitShaderArray      auto hidden
ImpactDataSet[] property xImpactDataArray     auto hidden
Projectile[]    property xProjectileArray     auto hidden
float[]         property xTaperWeightArray    auto hidden
float[]         property xTaperCurveArray     auto hidden
float[]         property xTaperDurationArray  auto hidden

EffectShader[] Function xEnchShaderArray(int fxCode) ;return corresponding effects for this effect color type
	if fxCode >= 0
		if fxCode < 4
			if fxCode == 0
				return effShaderFireFX
			elseif fxCode == 1
				return effShaderFrostFX
			elseif fxCode == 2
				return effShaderShockFX
			elseif fxCode == 3
				return effShaderBlueFX
			endif
		elseif fxCode < 8
			if fxCode == 4
				return effShaderGreenFX
			elseif fxCode == 5
				return effShaderPurpleFX
			elseif fxCode == 6
				return effShaderRedFX
			elseif fxCode == 7
				return effShaderSpecialFX
			endif
		endif
	endif
	EffectShader[] nullShaders = new EffectShader[128]
	return nullShaders
EndFunction

int Function GetModifiedWeaponType(Weapon weap)
	int weapType = weap.GetWeaponType()
	;/ Weap Types returned from GetWeaponType
		0=Fists
		1=Swords
		2=Daggers
		3=War Axes
		4=Maces
		5=Greatswords
		6=Battleaxes AND Warhammers
		7=Bows
		8=Staff
		9=Crossbows /;
	if weapType == 0 || weapType == 8 ;unarmed/staff not supported
		return -1
	endif
	if weapType < 6 || weapType == 9 || (weapType == 6  &&  weap.isBattleAxe())
		weapType -= 1
	endif ;this will result in: 0=sword, 1=dagger, 2=waraxe, 3=mace, 4=greatsword, 5=battleaxe, 6=warhammer, 7=bow, 8=crossbow
	return weapType
EndFunction

Art[] Function xEnchArtArray_FromWeapon(Weapon weap) ;determine modified weapon code and then call xEnchArtArray
	int wType = GetModifiedWeaponType(weap)
	if (wType == -1) ;unarmed/staff not supported
		Art[] nullArt = new Art[128]
		return nullArt
	endif
	return xEnchArtArray(wType)
EndFunction
Art[] Function xEnchArtArray(int modifiedWeapCode) ;Art Object 2-dimensional array implementation
	if modifiedWeapCode < 5
		if modifiedWeapCode == 0
			return _enchArt_Sword
		elseif modifiedWeapCode == 1
			return _enchArt_Dagger
		elseif modifiedWeapCode == 2
			return _enchArt_WarAxe
		elseif modifiedWeapCode == 3
			return _enchArt_Mace
		elseif modifiedWeapCode == 4
			return _enchArt_Greatsword
		endif
	else ;modifiedWeapCode >= 5
		if modifiedWeapCode == 5
			return _enchArt_Battleaxe
		elseif modifiedWeapCode == 6
			return _enchArt_Warhammer
		elseif modifiedWeapCode == 7
			return _enchArt_Bow
		elseif modifiedWeapCode == 8
			return _enchArt_Crossbow
		endif
	endif
	;shouldn't ever happen, but just in case:
	return _enchArt_Default 
EndFunction
string[] Function filteredEnchArtStrings(int modifiedWeapCode)
	Art[] thisWeapArt = xEnchArtArray(modifiedWeapCode)
	string[] filterStrings = new string[128]
	filterStrings[0] = xEnchArtStrings[0]
	int i = 1
	int j = 1
	while (xEnchArtStrings[i])
		if thisWeapArt[i]
			filterStrings[j] = xEnchArtStrings[i]
			j += 1
		endif
		i += 1
	endWhile
	return filterStrings
EndFunction

Art[]	_enchArt_Sword
Art[]	_enchArt_Dagger
Art[]	_enchArt_WarAxe
Art[]	_enchArt_Mace
Art[]	_enchArt_Greatsword
Art[]	_enchArt_Battleaxe
Art[]	_enchArt_Warhammer
Art[]	_enchArt_Bow
Art[]	_enchArt_Crossbow
Art[]	_enchArt_Default





Function InitializeVault()

;;------------------------------------------------------- HIT EFFECTS ------------------------------------------------------------
	xHitArtArray      = new Art[128]
	xHitShaderArray   = new EffectShader[128]
	xHitArtStrings    = new string[128]
	xHitShaderStrings = new string[128]

	;MORE HIT ART HAS BEEN ADDED THROUGH THE UPDATE SCRIPT, AND THESE INDICES ARE NO LONGER CORRECT ---------------------->

	xHitArtArray[0] = none
	xHitArtArray[1] = effectDefaultsHitArt[cEnchSoulTrap]			;SoulTrapTargetEffects                              <--not included
	xHitArtArray[2] = effectDefaultsHitArt[cEnchParalysis]			;ParalyzeFXBody01                                   <--not included
	xHitArtArray[3] = game.GetFormFromFile(0x1046CD, "Skyrim.esm") as Art ;PoisonCloak01 (used by warden/EnchUp)        <--included
	xHitArtArray[4] = game.GetFormFromFile(0x074795, "Skyrim.esm") as Art ;IllusionNegFXBody01 (used by warden/EnchUp)  <--not included
	xHitArtArray[5] = game.GetFormFromFile(0x07331C, "Skyrim.esm") as Art ;IllusionPosFXBody01 (used by warden/EnchUp)  <--included

	xHitArtStrings[0] = "$NONE"
	xHitArtStrings[1] = "$Soul Trap HitFX"
	xHitArtStrings[2] = "$Paralyze HitFX"
	xHitArtStrings[3] = "$Poison HitFX"
	xHitArtStrings[4] = "$Calm HitFX"
	xHitArtStrings[5] = "$Frenzy HitFX"

	xHitShaderArray[0]  = none
	xHitShaderArray[1]  = effectDefaultsHitShader[cEnchFire]							;FireFXShader
	xHitShaderArray[2]  = effectDefaultsHitShader[cEnchFrost]							;FrostShortFXShader
	xHitShaderArray[3]  = game.GetFormFromFile(0x01F03A, "Skyrim.esm") as EffectShader	;FrostFXShader (used by warden/EnchUp)
	xHitShaderArray[4]  = effectDefaultsHitShader[cEnchShock]							;ShockFXShader
	xHitShaderArray[5]  = effectDefaultsHitShader[cEnchAbHealth]						;AbsorbHealthFXS
	xHitShaderArray[6]  = effectDefaultsHitShader[cEnchMagickaDam]						;EnchDamageBlueFXS
	xHitShaderArray[7]  = effectDefaultsHitShader[cEnchStaminaDam]						;EnchDamageGreenFXS
	xHitShaderArray[8]  = effectDefaultsHitShader[cEnchSoulTrap]						;SoulTrapFXShader
	xHitShaderArray[9]  = effectDefaultsHitShader[cEnchBanish]                          ;SoulTrapTargetActFXS
	xHitShaderArray[10] = effectDefaultsHitShader[cEnchParalysis]						;ParalyzeFxShader
	xHitShaderArray[11] = effectDefaultsHitShader[cEnchTurnUndead]						;TurnUnFXShader
	xHitShaderArray[12] = effectDefaultsHitShader[cEnchSilentMoons]						;ShieldSpellFXS
	xHitShaderArray[13] = game.GetFormFromFile(0x10A044, "Skyrim.esm") as EffectShader	;FrostChillRendHitFXShader (used by warden/EnchUp)
	xHitShaderArray[14] = game.GetFormFromFile(0x0DC20E, "Skyrim.esm") as EffectShader	;FrostIceFormFXShader02 (used by warden/EnchUp)
	xHitShaderArray[15] = game.GetFormFromFile(0x10CC64, "Skyrim.esm") as EffectShader	;ChaurusPoisonFXShader (used by warden/EnchUp)
	xHitShaderArray[16] = game.GetFormFromFile(0x074799, "Skyrim.esm") as EffectShader	;IllusionNegativeFXS (used by warden/EnchUp)
	xHitShaderArray[17] = game.GetFormFromFile(0x073321, "Skyrim.esm") as EffectShader	;IllusionPositiveFXS (used by warden/EnchUp)
	xHitShaderArray[18] = game.GetFormFromFile(0x000962, "EnchantedArsenal.esp") as EffectShader	;EAr_satorius13_HolyHitShader
	xHitShaderArray[19] = game.GetFormFromFile(0x000963, "EnchantedArsenal.esp") as EffectShader	;EAr_satorius13_HolySoultrapFXS

	xHitShaderStrings[0]  = "$NONE"
	xHitShaderStrings[1]  = "$Fire HitShader"
	xHitShaderStrings[2]  = "$Frost HitShader"
	xHitShaderStrings[3]  = "$Frost Alt HitShader"
	xHitShaderStrings[4]  = "$Shock HitShader"
	xHitShaderStrings[5]  = "$Red HitShader"
	xHitShaderStrings[6]  = "$Blue HitShader"
	xHitShaderStrings[7]  = "$Green HitShader"
	xHitShaderStrings[8]  = "$Purple HitShader"
	xHitShaderStrings[9]  = "$Blue-Purple HitShader"
	xHitShaderStrings[10] = "$Paralyze HitShader"
	xHitShaderStrings[11] = "$Turn Undead HitShader"
	xHitShaderStrings[12] = "$Silent Moons HitShader"
	xHitShaderStrings[13] = "$Chillrend HitShader"
	xHitShaderStrings[14] = "$Ice Form HitShader"
	xHitShaderStrings[15] = "$Chaurus Poison HitShader"
	xHitShaderStrings[16] = "$Frenzy HitShader"
	xHitShaderStrings[17] = "$Calm HitShader"
	xHitShaderStrings[18] = "$Holy HitShader  (satorius13)"
	xHitShaderStrings[19] = "$Holy Soul HitShader  (satorius13)"

	if bDAWNGUARD
		xHitShaderArray[20]   = game.GetFormFromFile(0x00A3BB, "Dawnguard.esm") as EffectShader ;DLC1SunFireFXShader
		xHitShaderStrings[20] = "$Dawnguard Sunfire HitShader"
	endif



;;------------------------------------------------- IMPACT DATA & PROJECTILES ----------------------------------------------------
	xImpactDataArray   = new ImpactDataSet[128]
	xProjectileArray   = new Projectile[128]
	xImpactDataStrings = new string[128]
	xProjectileStrings = new string[128]

	xImpactDataArray[0]  = none
	xImpactDataArray[1]  = effectDefaultsImpactData[cEnchFire]								;MAGFirebolt01ImpactSet
	xImpactDataArray[2]  = effectDefaultsImpactData[cEnchFrost]								;MAGFrostBolt01ImpactSet
	xImpactDataArray[3]  = game.GetFormFromFile(0x018A2E, "Skyrim.esm") as ImpactDataSet	;MAGFrost01ImpactSet (used by warden/EnchUp)
	xImpactDataArray[4]  = effectDefaultsImpactData[cEnchShock]								;MAGShock01ImpactSet
	xImpactDataArray[5]  = effectDefaultsImpactData[cEnchAbHealth]							;MAGAbsorbRedImpactSet
	xImpactDataArray[6]  = effectDefaultsImpactData[cEnchAbMagicka]							;MAGAbsorbBlueImpactSet
	xImpactDataArray[7]  = effectDefaultsImpactData[cEnchAbStamina]							;MAGAbsorbGreenImpactSet
	xImpactDataArray[8]  = effectDefaultsImpactData[cEnchBanish]							;MAGConjure01ImpactSet [Banish]
	xImpactDataArray[9]  = effectDefaultsImpactData[cEnchFear]								;MAGTurnUnlImpactSet
	xImpactDataArray[10] = game.GetFormFromFile(0x015C7B, "Skyrim.esm") as ImpactDataSet	;VOCShoutPush01ImpactSet (used by warden/EnchUp)
	xImpactDataArray[11] = game.GetFormFromFile(0x0FFF4B, "Skyrim.esm") as ImpactDataSet	;MAGPoisonSprayImpactSet (used by warden/EnchUp)
	xImpactDataArray[12] = game.GetFormFromFile(0x049B64, "Skyrim.esm") as ImpactDataSet	;MAGFrostIceStorm01ImpactSet (used by warden/EnchUp)
	xImpactDataArray[13] = game.GetFormFromFile(0x074798, "Skyrim.esm") as ImpactDataSet	;MAGIllusionNegImpactSet (used by warden/EnchUp)
	xImpactDataArray[14] = game.GetFormFromFile(0x073320, "Skyrim.esm") as ImpactDataSet	;MAGIllusionImpactSet (used by warden/EnchUp)

	xImpactDataStrings[0]  = "$NONE"
	xImpactDataStrings[1]  = "$Burn Impact"
	xImpactDataStrings[2]  = "$Frost Impact"
	xImpactDataStrings[3]  = "$Frost Alt Impact"
	xImpactDataStrings[4]  = "$Shock Impact"
	xImpactDataStrings[5]  = "$Red Impact"
	xImpactDataStrings[6]  = "$Blue Impact"
	xImpactDataStrings[7]  = "$Green Impact"
	xImpactDataStrings[8]  = "$Purple Impact"
	xImpactDataStrings[9]  = "$Turn Undead Impact"
	xImpactDataStrings[10] = "$Force Push Impact"
	xImpactDataStrings[11] = "$Poison Spray Impact"
	xImpactDataStrings[12] = "$Ice Storm Impact"
	xImpactDataStrings[13] = "$Frenzy Impact"
	xImpactDataStrings[14] = "$Calm Impact"

	xProjectileArray[0]  = none
	xProjectileArray[1]  = game.GetFormFromFile(0x012E84, "Skyrim.esm") as Projectile		;FireboltProjectile01 (used by SeeEnch)
	xProjectileArray[2]  = effectDefaultsProjectile[cEnchFrost]								;FrostIcicleProjectile01
	xProjectileArray[3]  = effectDefaultsProjectile[cEnchShock]								;FXProjectileShockBolt
	xProjectileArray[4]  = effectDefaultsProjectile[cEnchAbHealth]							;AbsorbBeam01
	xProjectileArray[5]  = effectDefaultsProjectile[cEnchAbMagicka]							;AbsorbBlueBeam01
	xProjectileArray[6]  = effectDefaultsProjectile[cEnchAbStamina]							;AbsorbGreenBeam01
	xProjectileArray[7]  = effectDefaultsProjectile[cEnchParalysis]							;ParalyzeProjectile
	xProjectileArray[8]  = effectDefaultsProjectile[cEnchSoulTrap]							;TurnUndeadProjectile
	xProjectileArray[9]  = game.GetFormFromFile(0x013DF4, "Skyrim.esm") as Projectile		;VoicePushProjectile01 (used by warden/EnchUp)
	xProjectileArray[10] = game.GetFormFromFile(0x059325, "Skyrim.esm") as Projectile		;DA13PoisonSprayProjectile (used by warden/EnchUp)
	xProjectileArray[11] = game.GetFormFromFile(0x0DEDCA, "Skyrim.esm") as Projectile		;VoiceIceFormProjectile01 (used by warden/EnchUp)
	xProjectileArray[12] = game.GetFormFromFile(0x001200, "EnchantedArsenal.esp") as Projectile	;EAr_satorius13_HolyProjectile

	xProjectileStrings[0]  = "$NONE"
	xProjectileStrings[1]  = "$Fire Projectile"
	xProjectileStrings[2]  = "$Frost Projectile"
	xProjectileStrings[3]  = "$Shock Projectile"
	xProjectileStrings[4]  = "$Red Projectile"
	xProjectileStrings[5]  = "$Blue Projectile"
	xProjectileStrings[6]  = "$Green Projectile"
	xProjectileStrings[7]  = "$Paralyze Projectile"
	xProjectileStrings[8]  = "$Turn Undead Projectile"
	xProjectileStrings[9]  = "$Force Push Projectile"
	xProjectileStrings[10] = "$Poison Spray Projectile"
	xProjectileStrings[11] = "$Ice Form Projectile"
	xProjectileStrings[12] = "$Holy Projectile  (satorius13)"



;;------------------------------------------------------- FX PERSIST -------------------------------------------------------------
	xFXPersistStrings   = new string[6]
	xTaperWeightArray   = new float[6]
	xTaperCurveArray    = new float[6]
	xTaperDurationArray = new float[6]

;need to handle these two ways. One is like below, for most single-hit type effects (fire, frost, shock, silent moons, etc)
;the other way is to just have a simple ON / OFF toggle for FX persist, this is for effects whose FX persistence is more
;controlled by duration - like SoulTrap, Paralysis, Fear, TurnUndead, etc...

	xFXPersistStrings[0] = "$NONE"
	xFXPersistStrings[1] = "$Slight"
	xFXPersistStrings[2] = "$Moderate"
	xFXPersistStrings[3] = "$Medium"
	xFXPersistStrings[4] = "$Strong"
	xFXPersistStrings[5] = "$Extreme"
	;if editing this array, need to update "% 6" op handler in menu

	xTaperWeightArray[0]   = 0.0
	xTaperCurveArray[0]    = 0.0   ;fxPersist flag automatically turn off (well, not always - see note above)
	xTaperDurationArray[0] = 0.0

	xTaperWeightArray[1]   = 0.2
	xTaperCurveArray[1]    = 2.0   ;fxPersist flag turned on for all the rest of these
	xTaperDurationArray[1] = 1.0      ;1.33dam if 20mag

	xTaperWeightArray[2]   = 0.17
	xTaperCurveArray[2]    = 3.0      ;1.70dam if 20mag
	xTaperDurationArray[2] = 2.0

	xTaperWeightArray[3]   = 0.14
	xTaperCurveArray[3]    = 5.0      ;1.87dam if 20mag
	xTaperDurationArray[3] = 4.0

	xTaperWeightArray[4]   = 0.12
	xTaperCurveArray[4]    = 6.0      ;2.05dam if 20mag
	xTaperDurationArray[4] = 6.0

	xTaperWeightArray[5]   = 0.1
	xTaperCurveArray[5]    = 8.0      ;2.22dam if 20mag
	xTaperDurationArray[5] = 10.0



;;------------------------------------------------------- ENCHANT ART ------------------------------------------------------------

	_enchArt_Sword      = new Art[128]
	_enchArt_Dagger     = new Art[128]
	_enchArt_WarAxe     = new Art[128]
	_enchArt_Mace       = new Art[128]
	_enchArt_Greatsword = new Art[128]
	_enchArt_Battleaxe  = new Art[128]
	_enchArt_Warhammer  = new Art[128]
	_enchArt_Bow        = new Art[128]
	_enchArt_Crossbow   = new Art[128]
	_enchArt_Default    = new Art[128] ;array of NONE

	xEnchArtStrings     = new string[128]


	;import art (can't fill these in CK or TES5Edit yet, since new SKSE-enabled type)
	_enchArt_Sword[0]  = none
	_enchArt_Sword[1]  = game.getFormFromFile(0x0800, "EnchantedArsenal.esp") as Art ;EAr_warden01_AbsBlueAO
	_enchArt_Sword[2]  = game.getFormFromFile(0x0801, "EnchantedArsenal.esp") as Art ;EAr_warden01_AbsGreenAO
	_enchArt_Sword[3]  = game.getFormFromFile(0x0802, "EnchantedArsenal.esp") as Art ;EAr_warden01_AbsRedAO
	_enchArt_Sword[4]  = game.getFormFromFile(0x0803, "EnchantedArsenal.esp") as Art ;EAr_warden01_DamageBlueAO
	_enchArt_Sword[5]  = game.getFormFromFile(0x0804, "EnchantedArsenal.esp") as Art ;EAr_warden01_DamageGreenAO
	_enchArt_Sword[6]  = game.getFormFromFile(0x0805, "EnchantedArsenal.esp") as Art ;EAr_warden01_FearAO
	_enchArt_Sword[7]  = game.getFormFromFile(0x0806, "EnchantedArsenal.esp") as Art ;EAr_warden01_FireAO
	_enchArt_Sword[8]  = game.getFormFromFile(0x0807, "EnchantedArsenal.esp") as Art ;EAr_warden01_FrostAO
	_enchArt_Sword[9]  = game.getFormFromFile(0x0808, "EnchantedArsenal.esp") as Art ;EAr_warden01_ParalyzeAO
	_enchArt_Sword[10] = game.getFormFromFile(0x0809, "EnchantedArsenal.esp") as Art ;EAr_warden01_ShockAO
	_enchArt_Sword[11] = game.getFormFromFile(0x080A, "EnchantedArsenal.esp") as Art ;EAr_warden01_SoulTrapAO
	_enchArt_Sword[12] = game.getFormFromFile(0x080B, "EnchantedArsenal.esp") as Art ;EAr_warden01_SpecialBlueAO
	_enchArt_Sword[13] = game.getFormFromFile(0x080C, "EnchantedArsenal.esp") as Art ;EAr_warden01_SpecialGreenAO
	_enchArt_Sword[14] = game.getFormFromFile(0x080D, "EnchantedArsenal.esp") as Art ;EAr_warden01_SpecialRedAO
	_enchArt_Sword[15] = game.getFormFromFile(0x080E, "EnchantedArsenal.esp") as Art ;EAr_warden01_SpecialVioletAO
	_enchArt_Sword[16] = game.getFormFromFile(0x080F, "EnchantedArsenal.esp") as Art ;EAr_warden01_SpecialYellowAO
	_enchArt_Sword[17] = game.getFormFromFile(0x0810, "EnchantedArsenal.esp") as Art ;EAr_SpiderAkiraC_AbsorbHealthAO
	_enchArt_Sword[18] = game.getFormFromFile(0x0811, "EnchantedArsenal.esp") as Art ;EAr_SpiderAkiraC_AbsorbStaminaAO
	_enchArt_Sword[19] = game.getFormFromFile(0x0812, "EnchantedArsenal.esp") as Art ;EAr_SpiderAkiraC_ChaosAO
	_enchArt_Sword[20] = game.getFormFromFile(0x0813, "EnchantedArsenal.esp") as Art ;EAr_SpiderAkiraC_FearAO
	_enchArt_Sword[21] = game.getFormFromFile(0x0814, "EnchantedArsenal.esp") as Art ;EAr_SpiderAkiraC_FireAO
	_enchArt_Sword[22] = game.getFormFromFile(0x0815, "EnchantedArsenal.esp") as Art ;EAr_SpiderAkiraC_FrostAO
	_enchArt_Sword[23] = game.getFormFromFile(0x0816, "EnchantedArsenal.esp") as Art ;EAr_SpiderAkiraC_MagicBlueAO
	_enchArt_Sword[24] = game.getFormFromFile(0x0817, "EnchantedArsenal.esp") as Art ;EAr_SpiderAkiraC_MagicGreenAO
	_enchArt_Sword[25] = game.getFormFromFile(0x0818, "EnchantedArsenal.esp") as Art ;EAr_SpiderAkiraC_ShockAO
	_enchArt_Sword[26] = game.getFormFromFile(0x0819, "EnchantedArsenal.esp") as Art ;EAr_SpiderAkiraC_SoultrapAO
	_enchArt_Sword[27] = game.getFormFromFile(0x081A, "EnchantedArsenal.esp") as Art ;EAr_SpiderAkiraC_TurnUndeadAO
	_enchArt_Sword[28] = game.getFormFromFile(0x081B, "EnchantedArsenal.esp") as Art ;EAr_Grimeleven_AllWeapFrostAO
	_enchArt_Sword[29] = game.getFormFromFile(0x081C, "EnchantedArsenal.esp") as Art ;EAr_Grimeleven_AllWeapShockAO
	_enchArt_Sword[30] = game.getFormFromFile(0x0825, "EnchantedArsenal.esp") as Art ;EAr_Grimeleven_SwordBloodAO
	_enchArt_Sword[31] = game.getFormFromFile(0x0826, "EnchantedArsenal.esp") as Art ;EAr_Grimeleven_SwordFireAO
	_enchArt_Sword[32] = game.getFormFromFile(0x0827, "EnchantedArsenal.esp") as Art ;EAr_Grimeleven_SwordMagicAO
	_enchArt_Sword[33] = game.getFormFromFile(0x0828, "EnchantedArsenal.esp") as Art ;EAr_Grimeleven_SwordSoulAO
	_enchArt_Sword[34] = game.getFormFromFile(0x0834, "EnchantedArsenal.esp") as Art ;EAr_Grimeleven_SwordGreenAO
	_enchArt_Sword[35] = game.getFormFromFile(0x0837, "EnchantedArsenal.esp") as Art ;EAr_Grimeleven_SwordHolyAO
	_enchArt_Sword[36] = game.getFormFromFile(0x0829, "EnchantedArsenal.esp") as Art ;EAr_BrotherBob_FireAO
	_enchArt_Sword[37] = game.getFormFromFile(0x082A, "EnchantedArsenal.esp") as Art ;EAr_Rizing_FireEnchAO  ;REQUIRES DAWNGUARD MESH!!!
	_enchArt_Sword[38] = game.getFormFromFile(0x082B, "EnchantedArsenal.esp") as Art ;EAr_Rizing_ShockEnchAO
	_enchArt_Sword[39] = game.getFormFromFile(0x082C, "EnchantedArsenal.esp") as Art ;EAr_Rizing_TurnundeadEnchAO
	_enchArt_Sword[40] = game.getFormFromFile(0x082D, "EnchantedArsenal.esp") as Art ;EAr_Rizing_DarkSoulEnchAO
	_enchArt_Sword[41] = game.getFormFromFile(0x082E, "EnchantedArsenal.esp") as Art ;EAr_Rizing_BlueSoulEnchAO
	_enchArt_Sword[42] = game.getFormFromFile(0x0F71E2, "Skyrim.esm") as Art ;FXDraugrMagicSwordStreakObject(BrotherBob)
	_enchArt_Sword[43] = game.getFormFromFile(0x10A045, "Skyrim.esm") as Art ;ChillrendEnchFX(BrotherBob)
	_enchArt_Sword[44] = game.getFormFromFile(0x0831, "EnchantedArsenal.esp") as Art ;EAr_satorius13_HolyAO
	_enchArt_Sword[45] = game.getFormFromFile(0x0839, "EnchantedArsenal.esp") as Art ;EAr_Sinobol_OrangeAO
	_enchArt_Sword[46] = game.getFormFromFile(0x083C, "EnchantedArsenal.esp") as Art ;EAr_Sinobol_FrostAO
	_enchArt_Sword[47] = game.getFormFromFile(0x083F, "EnchantedArsenal.esp") as Art ;EAr_Sinobol_PurpleBlueAO
	_enchArt_Sword[48] = game.getFormFromFile(0x0838, "EnchantedArsenal.esp") as Art ;EAr_Sinobol_RedAO
	_enchArt_Sword[49] = game.getFormFromFile(0x083A, "EnchantedArsenal.esp") as Art ;EAr_Sinobol_YellowAO
	_enchArt_Sword[50] = game.getFormFromFile(0x083B, "EnchantedArsenal.esp") as Art ;EAr_Sinobol_GreenAO
	_enchArt_Sword[51] = game.getFormFromFile(0x083D, "EnchantedArsenal.esp") as Art ;EAr_Sinobol_BlueAO
	_enchArt_Sword[52] = game.getFormFromFile(0x083E, "EnchantedArsenal.esp") as Art ;EAr_Sinobol_PurpleAO


	_enchArt_Dagger[0]  = none
	_enchArt_Dagger[1]  = _enchArt_Sword[1] ;EAr_warden01_AbsBlueAO
	_enchArt_Dagger[2]  = _enchArt_Sword[2] ;EAr_warden01_AbsGreenAO
	_enchArt_Dagger[3]  = _enchArt_Sword[3] ;EAr_warden01_AbsRedAO
	_enchArt_Dagger[4]  = _enchArt_Sword[4] ;EAr_warden01_DamageBlueAO
	_enchArt_Dagger[5]  = _enchArt_Sword[5] ;EAr_warden01_DamageGreenAO
	_enchArt_Dagger[6]  = _enchArt_Sword[6] ;EAr_warden01_FearAO
	_enchArt_Dagger[7]  = _enchArt_Sword[7] ;EAr_warden01_FireAO
	_enchArt_Dagger[8]  = _enchArt_Sword[8] ;EAr_warden01_FrostAO
	_enchArt_Dagger[9]  = _enchArt_Sword[9] ;EAr_warden01_ParalyzeAO
	_enchArt_Dagger[10] = _enchArt_Sword[10] ;EAr_warden01_ShockAO
	_enchArt_Dagger[11] = _enchArt_Sword[11] ;EAr_warden01_SoulTrapAO
	_enchArt_Dagger[12] = _enchArt_Sword[12] ;EAr_warden01_SpecialBlueAO
	_enchArt_Dagger[13] = _enchArt_Sword[13] ;EAr_warden01_SpecialGreenAO
	_enchArt_Dagger[14] = _enchArt_Sword[14] ;EAr_warden01_SpecialRedAO
	_enchArt_Dagger[15] = _enchArt_Sword[15] ;EAr_warden01_SpecialVioletAO
	_enchArt_Dagger[16] = _enchArt_Sword[16] ;EAr_warden01_SpecialYellowAO
	_enchArt_Dagger[17] = _enchArt_Sword[17] ;EAr_SpiderAkiraC_AbsorbHealthAO
	_enchArt_Dagger[18] = _enchArt_Sword[18] ;EAr_SpiderAkiraC_AbsorbStaminaAO
	_enchArt_Dagger[19] = _enchArt_Sword[19] ;EAr_SpiderAkiraC_ChaosAO
	_enchArt_Dagger[20] = _enchArt_Sword[20] ;EAr_SpiderAkiraC_FearAO
	_enchArt_Dagger[21] = _enchArt_Sword[21] ;EAr_SpiderAkiraC_FireAO
	_enchArt_Dagger[22] = _enchArt_Sword[22] ;EAr_SpiderAkiraC_FrostAO
	_enchArt_Dagger[23] = _enchArt_Sword[23] ;EAr_SpiderAkiraC_MagicBlueAO
	_enchArt_Dagger[24] = _enchArt_Sword[24] ;EAr_SpiderAkiraC_MagicGreenAO
	_enchArt_Dagger[25] = _enchArt_Sword[25] ;EAr_SpiderAkiraC_ShockAO
	_enchArt_Dagger[26] = _enchArt_Sword[26] ;EAr_SpiderAkiraC_SoultrapAO
	_enchArt_Dagger[27] = _enchArt_Sword[27] ;EAr_SpiderAkiraC_TurnUndeadAO
	_enchArt_Dagger[28] = _enchArt_Sword[28] ;EAr_Grimeleven_AllWeapFrostAO
	_enchArt_Dagger[29] = _enchArt_Sword[29] ;EAr_Grimeleven_AllWeapShockAO
	_enchArt_Dagger[30] = game.getFormFromFile(0x0821, "EnchantedArsenal.esp") as Art ;EAr_Grimeleven_DaggerBloodAO
	_enchArt_Dagger[31] = game.getFormFromFile(0x0822, "EnchantedArsenal.esp") as Art ;EAr_Grimeleven_DaggerFireAO
	_enchArt_Dagger[32] = game.getFormFromFile(0x0823, "EnchantedArsenal.esp") as Art ;EAr_Grimeleven_DaggerMagicAO
	_enchArt_Dagger[33] = game.getFormFromFile(0x0824, "EnchantedArsenal.esp") as Art ;EAr_Grimeleven_DaggerSoulAO
	_enchArt_Dagger[34] = game.getFormFromFile(0x0833, "EnchantedArsenal.esp") as Art ;EAr_Grimeleven_DaggerGreenAO
	_enchArt_Dagger[35] = game.getFormFromFile(0x0836, "EnchantedArsenal.esp") as Art ;EAr_Grimeleven_DaggerHolyAO
	_enchArt_Dagger[36] = _enchArt_Sword[36] ;EAr_BrotherBob_FireAO
	_enchArt_Dagger[37] = _enchArt_Sword[37] ;EAr_Rizing_FireEnchAO
	_enchArt_Dagger[38] = _enchArt_Sword[38] ;EAr_Rizing_ShockEnchAO
	_enchArt_Dagger[39] = _enchArt_Sword[39] ;EAr_Rizing_TurnundeadEnchAO
	_enchArt_Dagger[40] = _enchArt_Sword[40] ;EAr_Rizing_DarkSoulEnchAO
	_enchArt_Dagger[41] = _enchArt_Sword[41] ;EAr_Rizing_BlueSoulEnchAO
	_enchArt_Dagger[42] = _enchArt_Sword[42] ;FXDraugrMagicSwordStreakObject(BrotherBob)
	_enchArt_Dagger[43] = _enchArt_Sword[43] ;ChillrendEnchFX(BrotherBob)
	_enchArt_Dagger[44] = _enchArt_Sword[44] ;EAr_satorius13_HolyAO
	_enchArt_Dagger[45] = _enchArt_Sword[45] ;EAr_Sinobol_OrangeAO
	_enchArt_Dagger[46] = _enchArt_Sword[46] ;EAr_Sinobol_FrostAO
	_enchArt_Dagger[47] = _enchArt_Sword[47] ;EAr_Sinobol_PurpleBlueAO
	_enchArt_Dagger[48] = _enchArt_Sword[48] ;EAr_Sinobol_RedAO
	_enchArt_Dagger[49] = _enchArt_Sword[49] ;EAr_Sinobol_YellowAO
	_enchArt_Dagger[50] = _enchArt_Sword[50] ;EAr_Sinobol_GreenAO
	_enchArt_Dagger[51] = _enchArt_Sword[51] ;EAr_Sinobol_BlueAO
	_enchArt_Dagger[52] = _enchArt_Sword[52] ;EAr_Sinobol_PurpleAO


	_enchArt_WarAxe[0]  = none
	_enchArt_WarAxe[1]  = _enchArt_Sword[1] ;EAr_warden01_AbsBlueAO
	_enchArt_WarAxe[2]  = _enchArt_Sword[2] ;EAr_warden01_AbsGreenAO
	_enchArt_WarAxe[3]  = _enchArt_Sword[3] ;EAr_warden01_AbsRedAO
	_enchArt_WarAxe[4]  = _enchArt_Sword[4] ;EAr_warden01_DamageBlueAO
	_enchArt_WarAxe[5]  = _enchArt_Sword[5] ;EAr_warden01_DamageGreenAO
	_enchArt_WarAxe[6]  = _enchArt_Sword[6] ;EAr_warden01_FearAO
	_enchArt_WarAxe[7]  = _enchArt_Sword[7] ;EAr_warden01_FireAO
	_enchArt_WarAxe[8]  = _enchArt_Sword[8] ;EAr_warden01_FrostAO
	_enchArt_WarAxe[9]  = _enchArt_Sword[9] ;EAr_warden01_ParalyzeAO
	_enchArt_WarAxe[10] = _enchArt_Sword[10] ;EAr_warden01_ShockAO
	_enchArt_WarAxe[11] = _enchArt_Sword[11] ;EAr_warden01_SoulTrapAO
	_enchArt_WarAxe[12] = _enchArt_Sword[12] ;EAr_warden01_SpecialBlueAO
	_enchArt_WarAxe[13] = _enchArt_Sword[13] ;EAr_warden01_SpecialGreenAO
	_enchArt_WarAxe[14] = _enchArt_Sword[14] ;EAr_warden01_SpecialRedAO
	_enchArt_WarAxe[15] = _enchArt_Sword[15] ;EAr_warden01_SpecialVioletAO
	_enchArt_WarAxe[16] = _enchArt_Sword[16] ;EAr_warden01_SpecialYellowAO
	_enchArt_WarAxe[17] = _enchArt_Sword[17] ;EAr_SpiderAkiraC_AbsorbHealthAO
	_enchArt_WarAxe[18] = _enchArt_Sword[18] ;EAr_SpiderAkiraC_AbsorbStaminaAO
	_enchArt_WarAxe[19] = _enchArt_Sword[19] ;EAr_SpiderAkiraC_ChaosAO
	_enchArt_WarAxe[20] = _enchArt_Sword[20] ;EAr_SpiderAkiraC_FearAO
	_enchArt_WarAxe[21] = _enchArt_Sword[21] ;EAr_SpiderAkiraC_FireAO
	_enchArt_WarAxe[22] = _enchArt_Sword[22] ;EAr_SpiderAkiraC_FrostAO
	_enchArt_WarAxe[23] = _enchArt_Sword[23] ;EAr_SpiderAkiraC_MagicBlueAO
	_enchArt_WarAxe[24] = _enchArt_Sword[24] ;EAr_SpiderAkiraC_MagicGreenAO
	_enchArt_WarAxe[25] = _enchArt_Sword[25] ;EAr_SpiderAkiraC_ShockAO
	_enchArt_WarAxe[26] = _enchArt_Sword[26] ;EAr_SpiderAkiraC_SoultrapAO
	_enchArt_WarAxe[27] = _enchArt_Sword[27] ;EAr_SpiderAkiraC_TurnUndeadAO
	_enchArt_WarAxe[28] = _enchArt_Sword[28] ;EAr_Grimeleven_AllWeapFrostAO
	_enchArt_WarAxe[29] = _enchArt_Sword[29] ;EAr_Grimeleven_AllWeapShockAO
	_enchArt_WarAxe[30] = none ;no Grimeleven available for WarAxe
	_enchArt_WarAxe[31] = none ;no Grimeleven available for WarAxe
	_enchArt_WarAxe[32] = none ;no Grimeleven available for WarAxe
	_enchArt_WarAxe[33] = none ;no Grimeleven available for WarAxe
	_enchArt_WarAxe[34] = none ;no Grimeleven available for WarAxe
	_enchArt_WarAxe[35] = none ;no Grimeleven available for WarAxe
	_enchArt_WarAxe[36] = _enchArt_Sword[36] ;EAr_BrotherBob_FireAO
	_enchArt_WarAxe[37] = _enchArt_Sword[37] ;EAr_Rizing_FireEnchAO
	_enchArt_WarAxe[38] = _enchArt_Sword[38] ;EAr_Rizing_ShockEnchAO
	_enchArt_WarAxe[39] = _enchArt_Sword[39] ;EAr_Rizing_TurnundeadEnchAO
	_enchArt_WarAxe[40] = _enchArt_Sword[40] ;EAr_Rizing_DarkSoulEnchAO
	_enchArt_WarAxe[41] = _enchArt_Sword[41] ;EAr_Rizing_BlueSoulEnchAO
	_enchArt_WarAxe[42] = _enchArt_Sword[42] ;FXDraugrMagicSwordStreakObject(BrotherBob)
	_enchArt_WarAxe[43] = _enchArt_Sword[43] ;ChillrendEnchFX(BrotherBob)
	_enchArt_WarAxe[44] = _enchArt_Sword[44] ;EAr_satorius13_HolyAO
	_enchArt_WarAxe[45] = _enchArt_Sword[45] ;EAr_Sinobol_OrangeAO
	_enchArt_WarAxe[46] = _enchArt_Sword[46] ;EAr_Sinobol_FrostAO
	_enchArt_WarAxe[47] = _enchArt_Sword[47] ;EAr_Sinobol_PurpleBlueAO
	_enchArt_WarAxe[48] = _enchArt_Sword[48] ;EAr_Sinobol_RedAO
	_enchArt_WarAxe[49] = _enchArt_Sword[49] ;EAr_Sinobol_YellowAO
	_enchArt_WarAxe[50] = _enchArt_Sword[50] ;EAr_Sinobol_GreenAO
	_enchArt_WarAxe[51] = _enchArt_Sword[51] ;EAr_Sinobol_BlueAO
	_enchArt_WarAxe[52] = _enchArt_Sword[52] ;EAr_Sinobol_PurpleAO


	_enchArt_Mace[0]  = none
	_enchArt_Mace[1]  = _enchArt_Sword[1] ;EAr_warden01_AbsBlueAO
	_enchArt_Mace[2]  = _enchArt_Sword[2] ;EAr_warden01_AbsGreenAO
	_enchArt_Mace[3]  = _enchArt_Sword[3] ;EAr_warden01_AbsRedAO
	_enchArt_Mace[4]  = _enchArt_Sword[4] ;EAr_warden01_DamageBlueAO
	_enchArt_Mace[5]  = _enchArt_Sword[5] ;EAr_warden01_DamageGreenAO
	_enchArt_Mace[6]  = _enchArt_Sword[6] ;EAr_warden01_FearAO
	_enchArt_Mace[7]  = _enchArt_Sword[7] ;EAr_warden01_FireAO
	_enchArt_Mace[8]  = _enchArt_Sword[8] ;EAr_warden01_FrostAO
	_enchArt_Mace[9]  = _enchArt_Sword[9] ;EAr_warden01_ParalyzeAO
	_enchArt_Mace[10] = _enchArt_Sword[10] ;EAr_warden01_ShockAO
	_enchArt_Mace[11] = _enchArt_Sword[11] ;EAr_warden01_SoulTrapAO
	_enchArt_Mace[12] = _enchArt_Sword[12] ;EAr_warden01_SpecialBlueAO
	_enchArt_Mace[13] = _enchArt_Sword[13] ;EAr_warden01_SpecialGreenAO
	_enchArt_Mace[14] = _enchArt_Sword[14] ;EAr_warden01_SpecialRedAO
	_enchArt_Mace[15] = _enchArt_Sword[15] ;EAr_warden01_SpecialVioletAO
	_enchArt_Mace[16] = _enchArt_Sword[16] ;EAr_warden01_SpecialYellowAO
	_enchArt_Mace[17] = _enchArt_Sword[17] ;EAr_SpiderAkiraC_AbsorbHealthAO
	_enchArt_Mace[18] = _enchArt_Sword[18] ;EAr_SpiderAkiraC_AbsorbStaminaAO
	_enchArt_Mace[19] = _enchArt_Sword[19] ;EAr_SpiderAkiraC_ChaosAO
	_enchArt_Mace[20] = _enchArt_Sword[20] ;EAr_SpiderAkiraC_FearAO
	_enchArt_Mace[21] = _enchArt_Sword[21] ;EAr_SpiderAkiraC_FireAO
	_enchArt_Mace[22] = _enchArt_Sword[22] ;EAr_SpiderAkiraC_FrostAO
	_enchArt_Mace[23] = _enchArt_Sword[23] ;EAr_SpiderAkiraC_MagicBlueAO
	_enchArt_Mace[24] = _enchArt_Sword[24] ;EAr_SpiderAkiraC_MagicGreenAO
	_enchArt_Mace[25] = _enchArt_Sword[25] ;EAr_SpiderAkiraC_ShockAO
	_enchArt_Mace[26] = _enchArt_Sword[26] ;EAr_SpiderAkiraC_SoultrapAO
	_enchArt_Mace[27] = _enchArt_Sword[27] ;EAr_SpiderAkiraC_TurnUndeadAO
	_enchArt_Mace[28] = _enchArt_Sword[28] ;EAr_Grimeleven_AllWeapFrostAO
	_enchArt_Mace[29] = _enchArt_Sword[29] ;EAr_Grimeleven_AllWeapShockAO
	_enchArt_Mace[30] = none ;no Grimeleven available for Mace
	_enchArt_Mace[31] = none ;no Grimeleven available for Mace
	_enchArt_Mace[32] = none ;no Grimeleven available for Mace
	_enchArt_Mace[33] = none ;no Grimeleven available for Mace
	_enchArt_Mace[34] = none ;no Grimeleven available for Mace
	_enchArt_Mace[35] = none ;no Grimeleven available for Mace
	_enchArt_Mace[36] = _enchArt_Sword[36] ;EAr_BrotherBob_FireAO
	_enchArt_Mace[37] = _enchArt_Sword[37] ;EAr_Rizing_FireEnchAO
	_enchArt_Mace[38] = _enchArt_Sword[38] ;EAr_Rizing_ShockEnchAO
	_enchArt_Mace[39] = _enchArt_Sword[39] ;EAr_Rizing_TurnundeadEnchAO
	_enchArt_Mace[40] = _enchArt_Sword[40] ;EAr_Rizing_DarkSoulEnchAO
	_enchArt_Mace[41] = _enchArt_Sword[41] ;EAr_Rizing_BlueSoulEnchAO
	_enchArt_Mace[42] = _enchArt_Sword[42] ;FXDraugrMagicSwordStreakObject(BrotherBob)
	_enchArt_Mace[43] = _enchArt_Sword[43] ;ChillrendEnchFX(BrotherBob)
	_enchArt_Mace[44] = _enchArt_Sword[44] ;EAr_satorius13_HolyAO
	_enchArt_Mace[45] = _enchArt_Sword[45] ;EAr_Sinobol_OrangeAO
	_enchArt_Mace[46] = _enchArt_Sword[46] ;EAr_Sinobol_FrostAO
	_enchArt_Mace[47] = _enchArt_Sword[47] ;EAr_Sinobol_PurpleBlueAO
	_enchArt_Mace[48] = _enchArt_Sword[48] ;EAr_Sinobol_RedAO
	_enchArt_Mace[49] = _enchArt_Sword[49] ;EAr_Sinobol_YellowAO
	_enchArt_Mace[50] = _enchArt_Sword[50] ;EAr_Sinobol_GreenAO
	_enchArt_Mace[51] = _enchArt_Sword[51] ;EAr_Sinobol_BlueAO
	_enchArt_Mace[52] = _enchArt_Sword[52] ;EAr_Sinobol_PurpleAO


	_enchArt_Greatsword[0]  = none
	_enchArt_Greatsword[1]  = _enchArt_Sword[1] ;EAr_warden01_AbsBlueAO
	_enchArt_Greatsword[2]  = _enchArt_Sword[2] ;EAr_warden01_AbsGreenAO
	_enchArt_Greatsword[3]  = _enchArt_Sword[3] ;EAr_warden01_AbsRedAO
	_enchArt_Greatsword[4]  = _enchArt_Sword[4] ;EAr_warden01_DamageBlueAO
	_enchArt_Greatsword[5]  = _enchArt_Sword[5] ;EAr_warden01_DamageGreenAO
	_enchArt_Greatsword[6]  = _enchArt_Sword[6] ;EAr_warden01_FearAO
	_enchArt_Greatsword[7]  = _enchArt_Sword[7] ;EAr_warden01_FireAO
	_enchArt_Greatsword[8]  = _enchArt_Sword[8] ;EAr_warden01_FrostAO
	_enchArt_Greatsword[9]  = _enchArt_Sword[9] ;EAr_warden01_ParalyzeAO
	_enchArt_Greatsword[10] = _enchArt_Sword[10] ;EAr_warden01_ShockAO
	_enchArt_Greatsword[11] = _enchArt_Sword[11] ;EAr_warden01_SoulTrapAO
	_enchArt_Greatsword[12] = _enchArt_Sword[12] ;EAr_warden01_SpecialBlueAO
	_enchArt_Greatsword[13] = _enchArt_Sword[13] ;EAr_warden01_SpecialGreenAO
	_enchArt_Greatsword[14] = _enchArt_Sword[14] ;EAr_warden01_SpecialRedAO
	_enchArt_Greatsword[15] = _enchArt_Sword[15] ;EAr_warden01_SpecialVioletAO
	_enchArt_Greatsword[16] = _enchArt_Sword[16] ;EAr_warden01_SpecialYellowAO
	_enchArt_Greatsword[17] = _enchArt_Sword[17] ;EAr_SpiderAkiraC_AbsorbHealthAO
	_enchArt_Greatsword[18] = _enchArt_Sword[18] ;EAr_SpiderAkiraC_AbsorbStaminaAO
	_enchArt_Greatsword[19] = _enchArt_Sword[19] ;EAr_SpiderAkiraC_ChaosAO
	_enchArt_Greatsword[20] = _enchArt_Sword[20] ;EAr_SpiderAkiraC_FearAO
	_enchArt_Greatsword[21] = _enchArt_Sword[21] ;EAr_SpiderAkiraC_FireAO
	_enchArt_Greatsword[22] = _enchArt_Sword[22] ;EAr_SpiderAkiraC_FrostAO
	_enchArt_Greatsword[23] = _enchArt_Sword[23] ;EAr_SpiderAkiraC_MagicBlueAO
	_enchArt_Greatsword[24] = _enchArt_Sword[24] ;EAr_SpiderAkiraC_MagicGreenAO
	_enchArt_Greatsword[25] = _enchArt_Sword[25] ;EAr_SpiderAkiraC_ShockAO
	_enchArt_Greatsword[26] = _enchArt_Sword[26] ;EAr_SpiderAkiraC_SoultrapAO
	_enchArt_Greatsword[27] = _enchArt_Sword[27] ;EAr_SpiderAkiraC_TurnUndeadAO
	_enchArt_Greatsword[28] = _enchArt_Sword[28] ;EAr_Grimeleven_AllWeapFrostAO
	_enchArt_Greatsword[29] = _enchArt_Sword[29] ;EAr_Grimeleven_AllWeapShockAO
	_enchArt_Greatsword[30] = _enchArt_Sword[30] ;EAr_Grimeleven_SwordBloodAO
	_enchArt_Greatsword[31] = _enchArt_Sword[31] ;EAr_Grimeleven_SwordFireAO
	_enchArt_Greatsword[32] = _enchArt_Sword[32] ;EAr_Grimeleven_SwordMagicAO
	_enchArt_Greatsword[33] = _enchArt_Sword[33] ;EAr_Grimeleven_SwordSoulAO
	_enchArt_Greatsword[34] = _enchArt_Sword[34] ;EAr_Grimeleven_SwordGreenAO
	_enchArt_Greatsword[35] = _enchArt_Sword[35] ;EAr_Grimeleven_SwordHolyAO
	_enchArt_Greatsword[36] = _enchArt_Sword[36] ;EAr_BrotherBob_FireAO
	_enchArt_Greatsword[37] = _enchArt_Sword[37] ;EAr_Rizing_FireEnchAO
	_enchArt_Greatsword[38] = _enchArt_Sword[38] ;EAr_Rizing_ShockEnchAO
	_enchArt_Greatsword[39] = _enchArt_Sword[39] ;EAr_Rizing_TurnundeadEnchAO
	_enchArt_Greatsword[40] = _enchArt_Sword[40] ;EAr_Rizing_DarkSoulEnchAO
	_enchArt_Greatsword[41] = _enchArt_Sword[41] ;EAr_Rizing_BlueSoulEnchAO
	_enchArt_Greatsword[42] = _enchArt_Sword[42] ;FXDraugrMagicSwordStreakObject(BrotherBob)
	_enchArt_Greatsword[43] = _enchArt_Sword[43] ;ChillrendEnchFX(BrotherBob)
	_enchArt_Greatsword[44] = _enchArt_Sword[44] ;EAr_satorius13_HolyAO
	_enchArt_Greatsword[45] = _enchArt_Sword[45] ;EAr_Sinobol_OrangeAO
	_enchArt_Greatsword[46] = _enchArt_Sword[46] ;EAr_Sinobol_FrostAO
	_enchArt_Greatsword[47] = _enchArt_Sword[47] ;EAr_Sinobol_PurpleBlueAO
	_enchArt_Greatsword[48] = _enchArt_Sword[48] ;EAr_Sinobol_RedAO
	_enchArt_Greatsword[49] = _enchArt_Sword[49] ;EAr_Sinobol_YellowAO
	_enchArt_Greatsword[50] = _enchArt_Sword[50] ;EAr_Sinobol_GreenAO
	_enchArt_Greatsword[51] = _enchArt_Sword[51] ;EAr_Sinobol_BlueAO
	_enchArt_Greatsword[52] = _enchArt_Sword[52] ;EAr_Sinobol_PurpleAO


	_enchArt_Battleaxe[0]  = none
	_enchArt_Battleaxe[1]  = _enchArt_Sword[1] ;EAr_warden01_AbsBlueAO
	_enchArt_Battleaxe[2]  = _enchArt_Sword[2] ;EAr_warden01_AbsGreenAO
	_enchArt_Battleaxe[3]  = _enchArt_Sword[3] ;EAr_warden01_AbsRedAO
	_enchArt_Battleaxe[4]  = _enchArt_Sword[4] ;EAr_warden01_DamageBlueAO
	_enchArt_Battleaxe[5]  = _enchArt_Sword[5] ;EAr_warden01_DamageGreenAO
	_enchArt_Battleaxe[6]  = _enchArt_Sword[6] ;EAr_warden01_FearAO
	_enchArt_Battleaxe[7]  = _enchArt_Sword[7] ;EAr_warden01_FireAO
	_enchArt_Battleaxe[8]  = _enchArt_Sword[8] ;EAr_warden01_FrostAO
	_enchArt_Battleaxe[9]  = _enchArt_Sword[9] ;EAr_warden01_ParalyzeAO
	_enchArt_Battleaxe[10] = _enchArt_Sword[10] ;EAr_warden01_ShockAO
	_enchArt_Battleaxe[11] = _enchArt_Sword[11] ;EAr_warden01_SoulTrapAO
	_enchArt_Battleaxe[12] = _enchArt_Sword[12] ;EAr_warden01_SpecialBlueAO
	_enchArt_Battleaxe[13] = _enchArt_Sword[13] ;EAr_warden01_SpecialGreenAO
	_enchArt_Battleaxe[14] = _enchArt_Sword[14] ;EAr_warden01_SpecialRedAO
	_enchArt_Battleaxe[15] = _enchArt_Sword[15] ;EAr_warden01_SpecialVioletAO
	_enchArt_Battleaxe[16] = _enchArt_Sword[16] ;EAr_warden01_SpecialYellowAO
	_enchArt_Battleaxe[17] = _enchArt_Sword[17] ;EAr_SpiderAkiraC_AbsorbHealthAO
	_enchArt_Battleaxe[18] = _enchArt_Sword[18] ;EAr_SpiderAkiraC_AbsorbStaminaAO
	_enchArt_Battleaxe[19] = _enchArt_Sword[19] ;EAr_SpiderAkiraC_ChaosAO
	_enchArt_Battleaxe[20] = _enchArt_Sword[20] ;EAr_SpiderAkiraC_FearAO
	_enchArt_Battleaxe[21] = _enchArt_Sword[21] ;EAr_SpiderAkiraC_FireAO
	_enchArt_Battleaxe[22] = _enchArt_Sword[22] ;EAr_SpiderAkiraC_FrostAO
	_enchArt_Battleaxe[23] = _enchArt_Sword[23] ;EAr_SpiderAkiraC_MagicBlueAO
	_enchArt_Battleaxe[24] = _enchArt_Sword[24] ;EAr_SpiderAkiraC_MagicGreenAO
	_enchArt_Battleaxe[25] = _enchArt_Sword[25] ;EAr_SpiderAkiraC_ShockAO
	_enchArt_Battleaxe[26] = _enchArt_Sword[26] ;EAr_SpiderAkiraC_SoultrapAO
	_enchArt_Battleaxe[27] = _enchArt_Sword[27] ;EAr_SpiderAkiraC_TurnUndeadAO
	_enchArt_Battleaxe[28] = _enchArt_Sword[28] ;EAr_Grimeleven_AllWeapFrostAO
	_enchArt_Battleaxe[29] = _enchArt_Sword[29] ;EAr_Grimeleven_AllWeapShockAO
	_enchArt_Battleaxe[30] = game.getFormFromFile(0x081D, "EnchantedArsenal.esp") as Art ;EAr_Grimeleven_AxeBloodAO
	_enchArt_Battleaxe[31] = game.getFormFromFile(0x081E, "EnchantedArsenal.esp") as Art ;EAr_Grimeleven_AxeFireAO
	_enchArt_Battleaxe[32] = game.getFormFromFile(0x081F, "EnchantedArsenal.esp") as Art ;EAr_Grimeleven_AxeMagicAO
	_enchArt_Battleaxe[33] = game.getFormFromFile(0x0820, "EnchantedArsenal.esp") as Art ;EAr_Grimeleven_AxeSoulAO
	_enchArt_Battleaxe[34] = game.getFormFromFile(0x0832, "EnchantedArsenal.esp") as Art ;EAr_Grimeleven_AxeGreenAO
	_enchArt_Battleaxe[35] = game.getFormFromFile(0x0835, "EnchantedArsenal.esp") as Art ;EAr_Grimeleven_AxeHolyAO
	_enchArt_Battleaxe[36] = _enchArt_Sword[36] ;EAr_BrotherBob_FireAO
	_enchArt_Battleaxe[37] = _enchArt_Sword[37] ;EAr_Rizing_FireEnchAO
	_enchArt_Battleaxe[38] = _enchArt_Sword[38] ;EAr_Rizing_ShockEnchAO
	_enchArt_Battleaxe[39] = _enchArt_Sword[39] ;EAr_Rizing_TurnundeadEnchAO
	_enchArt_Battleaxe[40] = _enchArt_Sword[40] ;EAr_Rizing_DarkSoulEnchAO
	_enchArt_Battleaxe[41] = _enchArt_Sword[41] ;EAr_Rizing_BlueSoulEnchAO
	_enchArt_Battleaxe[42] = _enchArt_Sword[42] ;FXDraugrMagicSwordStreakObject(BrotherBob)
	_enchArt_Battleaxe[43] = _enchArt_Sword[43] ;ChillrendEnchFX(BrotherBob)
	_enchArt_Battleaxe[44] = _enchArt_Sword[44] ;EAr_satorius13_HolyAO
	_enchArt_Battleaxe[45] = _enchArt_Sword[45] ;EAr_Sinobol_OrangeAO
	_enchArt_Battleaxe[46] = _enchArt_Sword[46] ;EAr_Sinobol_FrostAO
	_enchArt_Battleaxe[47] = _enchArt_Sword[47] ;EAr_Sinobol_PurpleBlueAO
	_enchArt_Battleaxe[48] = _enchArt_Sword[48] ;EAr_Sinobol_RedAO
	_enchArt_Battleaxe[49] = _enchArt_Sword[49] ;EAr_Sinobol_YellowAO
	_enchArt_Battleaxe[50] = _enchArt_Sword[50] ;EAr_Sinobol_GreenAO
	_enchArt_Battleaxe[51] = _enchArt_Sword[51] ;EAr_Sinobol_BlueAO
	_enchArt_Battleaxe[52] = _enchArt_Sword[52] ;EAr_Sinobol_PurpleAO


	_enchArt_Warhammer[0]  = none
	_enchArt_Warhammer[1]  = _enchArt_Battleaxe[1] ;EAr_warden01_AbsBlueAO
	_enchArt_Warhammer[2]  = _enchArt_Battleaxe[2] ;EAr_warden01_AbsGreenAO
	_enchArt_Warhammer[3]  = _enchArt_Battleaxe[3] ;EAr_warden01_AbsRedAO
	_enchArt_Warhammer[4]  = _enchArt_Battleaxe[4] ;EAr_warden01_DamageBlueAO
	_enchArt_Warhammer[5]  = _enchArt_Battleaxe[5] ;EAr_warden01_DamageGreenAO
	_enchArt_Warhammer[6]  = _enchArt_Battleaxe[6] ;EAr_warden01_FearAO
	_enchArt_Warhammer[7]  = _enchArt_Battleaxe[7] ;EAr_warden01_FireAO
	_enchArt_Warhammer[8]  = _enchArt_Battleaxe[8] ;EAr_warden01_FrostAO
	_enchArt_Warhammer[9]  = _enchArt_Battleaxe[9] ;EAr_warden01_ParalyzeAO
	_enchArt_Warhammer[10] = _enchArt_Battleaxe[10] ;EAr_warden01_ShockAO
	_enchArt_Warhammer[11] = _enchArt_Battleaxe[11] ;EAr_warden01_SoulTrapAO
	_enchArt_Warhammer[12] = _enchArt_Battleaxe[12] ;EAr_warden01_SpecialBlueAO
	_enchArt_Warhammer[13] = _enchArt_Battleaxe[13] ;EAr_warden01_SpecialGreenAO
	_enchArt_Warhammer[14] = _enchArt_Battleaxe[14] ;EAr_warden01_SpecialRedAO
	_enchArt_Warhammer[15] = _enchArt_Battleaxe[15] ;EAr_warden01_SpecialVioletAO
	_enchArt_Warhammer[16] = _enchArt_Battleaxe[16] ;EAr_warden01_SpecialYellowAO
	_enchArt_Warhammer[17] = _enchArt_Battleaxe[17] ;EAr_SpiderAkiraC_AbsorbHealthAO
	_enchArt_Warhammer[18] = _enchArt_Battleaxe[18] ;EAr_SpiderAkiraC_AbsorbStaminaAO
	_enchArt_Warhammer[19] = _enchArt_Battleaxe[19] ;EAr_SpiderAkiraC_ChaosAO
	_enchArt_Warhammer[20] = _enchArt_Battleaxe[20] ;EAr_SpiderAkiraC_FearAO
	_enchArt_Warhammer[21] = _enchArt_Battleaxe[21] ;EAr_SpiderAkiraC_FireAO
	_enchArt_Warhammer[22] = _enchArt_Battleaxe[22] ;EAr_SpiderAkiraC_FrostAO
	_enchArt_Warhammer[23] = _enchArt_Battleaxe[23] ;EAr_SpiderAkiraC_MagicBlueAO
	_enchArt_Warhammer[24] = _enchArt_Battleaxe[24] ;EAr_SpiderAkiraC_MagicGreenAO
	_enchArt_Warhammer[25] = _enchArt_Battleaxe[25] ;EAr_SpiderAkiraC_ShockAO
	_enchArt_Warhammer[26] = _enchArt_Battleaxe[26] ;EAr_SpiderAkiraC_SoultrapAO
	_enchArt_Warhammer[27] = _enchArt_Battleaxe[27] ;EAr_SpiderAkiraC_TurnUndeadAO
	_enchArt_Warhammer[28] = _enchArt_Battleaxe[28] ;EAr_Grimeleven_AllWeapFrostAO
	_enchArt_Warhammer[29] = _enchArt_Battleaxe[29] ;EAr_Grimeleven_AllWeapShockAO
	_enchArt_Warhammer[30] = _enchArt_Battleaxe[30] ;EAr_Grimeleven_AxeBloodAO
	_enchArt_Warhammer[31] = _enchArt_Battleaxe[31] ;EAr_Grimeleven_AxeFireAO
	_enchArt_Warhammer[32] = _enchArt_Battleaxe[32] ;EAr_Grimeleven_AxeMagicAO
	_enchArt_Warhammer[33] = _enchArt_Battleaxe[33] ;EAr_Grimeleven_AxeSoulAO
	_enchArt_Warhammer[34] = _enchArt_Battleaxe[34] ;EAr_Grimeleven_AxeGreenAO
	_enchArt_Warhammer[35] = _enchArt_Battleaxe[35] ;EAr_Grimeleven_AxeGreenAO
	_enchArt_Warhammer[36] = _enchArt_Battleaxe[36] ;EAr_BrotherBob_FireAO
	_enchArt_Warhammer[37] = _enchArt_Battleaxe[37] ;EAr_Rizing_FireEnchAO
	_enchArt_Warhammer[38] = _enchArt_Battleaxe[38] ;EAr_Rizing_ShockEnchAO
	_enchArt_Warhammer[39] = _enchArt_Battleaxe[39] ;EAr_Rizing_TurnundeadEnchAO
	_enchArt_Warhammer[40] = _enchArt_Battleaxe[40] ;EAr_Rizing_DarkSoulEnchAO
	_enchArt_Warhammer[41] = _enchArt_Battleaxe[41] ;EAr_Rizing_BlueSoulEnchAO
	_enchArt_Warhammer[42] = _enchArt_Sword[42] ;FXDraugrMagicSwordStreakObject(BrotherBob)
	_enchArt_Warhammer[43] = _enchArt_Sword[43] ;ChillrendEnchFX(BrotherBob)
	_enchArt_Warhammer[44] = _enchArt_Sword[44] ;EAr_satorius13_HolyAO
	_enchArt_Warhammer[45] = _enchArt_Sword[45] ;EAr_Sinobol_OrangeAO
	_enchArt_Warhammer[46] = _enchArt_Sword[46] ;EAr_Sinobol_FrostAO
	_enchArt_Warhammer[47] = _enchArt_Sword[47] ;EAr_Sinobol_PurpleBlueAO
	_enchArt_Warhammer[48] = _enchArt_Sword[48] ;EAr_Sinobol_RedAO
	_enchArt_Warhammer[49] = _enchArt_Sword[49] ;EAr_Sinobol_YellowAO
	_enchArt_Warhammer[50] = _enchArt_Sword[50] ;EAr_Sinobol_GreenAO
	_enchArt_Warhammer[51] = _enchArt_Sword[51] ;EAr_Sinobol_BlueAO
	_enchArt_Warhammer[52] = _enchArt_Sword[52] ;EAr_Sinobol_PurpleAO


	_enchArt_Bow[0]  = none
	_enchArt_Bow[1]  = _enchArt_Sword[1] ;EAr_warden01_AbsBlueAO
	_enchArt_Bow[2]  = _enchArt_Sword[2] ;EAr_warden01_AbsGreenAO
	_enchArt_Bow[3]  = _enchArt_Sword[3] ;EAr_warden01_AbsRedAO
	_enchArt_Bow[4]  = _enchArt_Sword[4] ;EAr_warden01_DamageBlueAO
	_enchArt_Bow[5]  = _enchArt_Sword[5] ;EAr_warden01_DamageGreenAO
	_enchArt_Bow[6]  = _enchArt_Sword[6] ;EAr_warden01_FearAO
	_enchArt_Bow[7]  = _enchArt_Sword[7] ;EAr_warden01_FireAO
	_enchArt_Bow[8]  = _enchArt_Sword[8] ;EAr_warden01_FrostAO
	_enchArt_Bow[9]  = _enchArt_Sword[9] ;EAr_warden01_ParalyzeAO
	_enchArt_Bow[10] = _enchArt_Sword[10] ;EAr_warden01_ShockAO               THESE NEED TESTING - NOT ALL MAY WORK WITH BOW !!!!
	_enchArt_Bow[11] = _enchArt_Sword[11] ;EAr_warden01_SoulTrapAO
	_enchArt_Bow[12] = _enchArt_Sword[12] ;EAr_warden01_SpecialBlueAO
	_enchArt_Bow[13] = _enchArt_Sword[13] ;EAr_warden01_SpecialGreenAO
	_enchArt_Bow[14] = _enchArt_Sword[14] ;EAr_warden01_SpecialRedAO
	_enchArt_Bow[15] = _enchArt_Sword[15] ;EAr_warden01_SpecialVioletAO
	_enchArt_Bow[16] = _enchArt_Sword[16] ;EAr_warden01_SpecialYellowAO
	_enchArt_Bow[17] = _enchArt_Sword[17] ;EAr_SpiderAkiraC_AbsorbHealthAO
	_enchArt_Bow[18] = _enchArt_Sword[18] ;EAr_SpiderAkiraC_AbsorbStaminaAO
	_enchArt_Bow[19] = _enchArt_Sword[19] ;EAr_SpiderAkiraC_ChaosAO
	_enchArt_Bow[20] = _enchArt_Sword[20] ;EAr_SpiderAkiraC_FearAO
	_enchArt_Bow[21] = _enchArt_Sword[21] ;EAr_SpiderAkiraC_FireAO
	_enchArt_Bow[22] = _enchArt_Sword[22] ;EAr_SpiderAkiraC_FrostAO
	_enchArt_Bow[23] = _enchArt_Sword[23] ;EAr_SpiderAkiraC_MagicBlueAO
	_enchArt_Bow[24] = _enchArt_Sword[24] ;EAr_SpiderAkiraC_MagicGreenAO
	_enchArt_Bow[25] = _enchArt_Sword[25] ;EAr_SpiderAkiraC_ShockAO
	_enchArt_Bow[26] = _enchArt_Sword[26] ;EAr_SpiderAkiraC_SoultrapAO
	_enchArt_Bow[27] = _enchArt_Sword[27] ;EAr_SpiderAkiraC_TurnUndeadAO
	_enchArt_Bow[28] = _enchArt_Sword[28] ;EAr_Grimeleven_AllWeapFrostAO
	_enchArt_Bow[29] = _enchArt_Sword[29] ;EAr_Grimeleven_AllWeapShockAO
	_enchArt_Bow[30] = none
	_enchArt_Bow[31] = none
	_enchArt_Bow[32] = none ;no Grimeleven available for Bow
	_enchArt_Bow[33] = none
	_enchArt_Bow[34] = none
	_enchArt_Bow[35] = none
	_enchArt_Bow[36] = _enchArt_Sword[36] ;EAr_BrotherBob_FireAO
	_enchArt_Bow[37] = _enchArt_Sword[37] ;EAr_Rizing_FireEnchAO
	_enchArt_Bow[38] = _enchArt_Sword[38] ;EAr_Rizing_ShockEnchAO
	_enchArt_Bow[39] = _enchArt_Sword[39] ;EAr_Rizing_TurnundeadEnchAO
	_enchArt_Bow[40] = _enchArt_Sword[40] ;EAr_Rizing_DarkSoulEnchAO
	_enchArt_Bow[41] = _enchArt_Sword[41] ;EAr_Rizing_BlueSoulEnchAO
	_enchArt_Bow[42] = _enchArt_Sword[42] ;FXDraugrMagicSwordStreakObject(BrotherBob)
	_enchArt_Bow[43] = _enchArt_Sword[43] ;ChillrendEnchFX(BrotherBob)
	_enchArt_Bow[44] = _enchArt_Sword[44] ;EAr_satorius13_HolyAO
	_enchArt_Bow[45] = _enchArt_Sword[45] ;EAr_Sinobol_OrangeAO
	_enchArt_Bow[46] = _enchArt_Sword[46] ;EAr_Sinobol_FrostAO
	_enchArt_Bow[47] = _enchArt_Sword[47] ;EAr_Sinobol_PurpleBlueAO
	_enchArt_Bow[48] = _enchArt_Sword[48] ;EAr_Sinobol_RedAO
	_enchArt_Bow[49] = _enchArt_Sword[49] ;EAr_Sinobol_YellowAO
	_enchArt_Bow[50] = _enchArt_Sword[50] ;EAr_Sinobol_GreenAO
	_enchArt_Bow[51] = _enchArt_Sword[51] ;EAr_Sinobol_BlueAO
	_enchArt_Bow[52] = _enchArt_Sword[52] ;EAr_Sinobol_PurpleAO


	_enchArt_Crossbow[0]  = none
	_enchArt_Crossbow[1]  = _enchArt_Sword[1] ;EAr_warden01_AbsBlueAO
	_enchArt_Crossbow[2]  = _enchArt_Sword[2] ;EAr_warden01_AbsGreenAO
	_enchArt_Crossbow[3]  = _enchArt_Sword[3] ;EAr_warden01_AbsRedAO
	_enchArt_Crossbow[4]  = _enchArt_Sword[4] ;EAr_warden01_DamageBlueAO
	_enchArt_Crossbow[5]  = _enchArt_Sword[5] ;EAr_warden01_DamageGreenAO
	_enchArt_Crossbow[6]  = _enchArt_Sword[6] ;EAr_warden01_FearAO
	_enchArt_Crossbow[7]  = _enchArt_Sword[7] ;EAr_warden01_FireAO
	_enchArt_Crossbow[8]  = _enchArt_Sword[8] ;EAr_warden01_FrostAO
	_enchArt_Crossbow[9]  = _enchArt_Sword[9] ;EAr_warden01_ParalyzeAO
	_enchArt_Crossbow[10] = _enchArt_Sword[10] ;EAr_warden01_ShockAO           THESE NEED TESTING - NOT ALL MAY WORK WITH CROSSBOW !!!!
	_enchArt_Crossbow[11] = _enchArt_Sword[11] ;EAr_warden01_SoulTrapAO
	_enchArt_Crossbow[12] = _enchArt_Sword[12] ;EAr_warden01_SpecialBlueAO
	_enchArt_Crossbow[13] = _enchArt_Sword[13] ;EAr_warden01_SpecialGreenAO
	_enchArt_Crossbow[14] = _enchArt_Sword[14] ;EAr_warden01_SpecialRedAO
	_enchArt_Crossbow[15] = _enchArt_Sword[15] ;EAr_warden01_SpecialVioletAO
	_enchArt_Crossbow[16] = _enchArt_Sword[16] ;EAr_warden01_SpecialYellowAO
	_enchArt_Crossbow[17] = _enchArt_Sword[17] ;EAr_SpiderAkiraC_AbsorbHealthAO
	_enchArt_Crossbow[18] = _enchArt_Sword[18] ;EAr_SpiderAkiraC_AbsorbStaminaAO
	_enchArt_Crossbow[19] = _enchArt_Sword[19] ;EAr_SpiderAkiraC_ChaosAO
	_enchArt_Crossbow[20] = _enchArt_Sword[20] ;EAr_SpiderAkiraC_FearAO
	_enchArt_Crossbow[21] = _enchArt_Sword[21] ;EAr_SpiderAkiraC_FireAO
	_enchArt_Crossbow[22] = _enchArt_Sword[22] ;EAr_SpiderAkiraC_FrostAO
	_enchArt_Crossbow[23] = _enchArt_Sword[23] ;EAr_SpiderAkiraC_MagicBlueAO
	_enchArt_Crossbow[24] = _enchArt_Sword[24] ;EAr_SpiderAkiraC_MagicGreenAO
	_enchArt_Crossbow[25] = _enchArt_Sword[25] ;EAr_SpiderAkiraC_ShockAO
	_enchArt_Crossbow[26] = _enchArt_Sword[26] ;EAr_SpiderAkiraC_SoultrapAO
	_enchArt_Crossbow[27] = _enchArt_Sword[27] ;EAr_SpiderAkiraC_TurnUndeadAO
	_enchArt_Crossbow[28] = _enchArt_Sword[28] ;EAr_Grimeleven_AllWeapFrostAO
	_enchArt_Crossbow[29] = _enchArt_Sword[29] ;EAr_Grimeleven_AllWeapShockAO
	_enchArt_Crossbow[30] = none
	_enchArt_Crossbow[31] = none
	_enchArt_Crossbow[32] = none ;no Grimeleven available for Crossbow
	_enchArt_Crossbow[33] = none
	_enchArt_Crossbow[34] = none
	_enchArt_Crossbow[35] = none
	_enchArt_Crossbow[36] = _enchArt_Sword[36] ;EAr_BrotherBob_FireAO
	_enchArt_Crossbow[37] = _enchArt_Sword[37] ;EAr_Rizing_FireEnchAO
	_enchArt_Crossbow[38] = _enchArt_Sword[38] ;EAr_Rizing_ShockEnchAO
	_enchArt_Crossbow[39] = _enchArt_Sword[39] ;EAr_Rizing_TurnundeadEnchAO
	_enchArt_Crossbow[40] = _enchArt_Sword[40] ;EAr_Rizing_DarkSoulEnchAO
	_enchArt_Crossbow[41] = _enchArt_Sword[41] ;EAr_Rizing_BlueSoulEnchAO
	_enchArt_Crossbow[42] = _enchArt_Sword[42] ;FXDraugrMagicSwordStreakObject(BrotherBob)
	_enchArt_Crossbow[43] = _enchArt_Sword[43] ;ChillrendEnchFX(BrotherBob)
	_enchArt_Crossbow[44] = _enchArt_Sword[44] ;EAr_satorius13_HolyAO
	_enchArt_Crossbow[45] = _enchArt_Sword[45] ;EAr_Sinobol_OrangeAO
	_enchArt_Crossbow[46] = _enchArt_Sword[46] ;EAr_Sinobol_FrostAO
	_enchArt_Crossbow[47] = _enchArt_Sword[47] ;EAr_Sinobol_PurpleBlueAO
	_enchArt_Crossbow[48] = _enchArt_Sword[48] ;EAr_Sinobol_RedAO
	_enchArt_Crossbow[49] = _enchArt_Sword[49] ;EAr_Sinobol_YellowAO
	_enchArt_Crossbow[50] = _enchArt_Sword[50] ;EAr_Sinobol_GreenAO
	_enchArt_Crossbow[51] = _enchArt_Sword[51] ;EAr_Sinobol_BlueAO
	_enchArt_Crossbow[52] = _enchArt_Sword[52] ;EAr_Sinobol_PurpleAO


	xEnchArtStrings[0]  = "$NONE"
	xEnchArtStrings[1]  = "$Absorb Blue Art  (Aetherius)" ;EAr_warden01_AbsBlueAO
	xEnchArtStrings[2]  = "$Absorb Green Art  (Aetherius)" ;EAr_warden01_AbsGreenAO
	xEnchArtStrings[3]  = "$Absorb Red Art  (Aetherius)" ;EAr_warden01_AbsRedAO
	xEnchArtStrings[4]  = "$Damaging Blue Art  (Aetherius)" ;EAr_warden01_DamageBlueAO
	xEnchArtStrings[5]  = "$Damaging Green Art  (Aetherius)" ;EAr_warden01_DamageGreenAO
	xEnchArtStrings[6]  = "$Fear Art  (Aetherius)" ;EAr_warden01_FearAO
	xEnchArtStrings[7]  = "$Fire Art  (Aetherius)" ;EAr_warden01_FireAO
	xEnchArtStrings[8]  = "$Frost Art  (Aetherius)" ;EAr_warden01_FrostAO
	xEnchArtStrings[9]  = "$Paralyze Art  (Aetherius)" ;EAr_warden01_ParalyzeAO
	xEnchArtStrings[10] = "$Shock Art  (Aetherius)" ;EAr_warden01_ShockAO
	xEnchArtStrings[11] = "$Soul Trap Art  (Aetherius)" ;EAr_warden01_SoulTrapAO
	xEnchArtStrings[12] = "$Special Blue Art  (Aetherius)" ;EAr_warden01_SpecialBlueAO
	xEnchArtStrings[13] = "$Special Green Art  (Aetherius)" ;EAr_warden01_SpecialGreenAO
	xEnchArtStrings[14] = "$Special Red Art  (Aetherius)" ;EAr_warden01_SpecialRedAO
	xEnchArtStrings[15] = "$Special Violet Art  (Aetherius)" ;EAr_warden01_SpecialVioletAO
	xEnchArtStrings[16] = "$Special Yellow Art  (Aetherius)" ;EAr_warden01_SpecialYellowAO
	xEnchArtStrings[17] = "$Absorb Red Art  (SpiderAkiraC)" ;EAr_SpiderAkiraC_AbsorbHealthAO
	xEnchArtStrings[18] = "$Absorb Green Art  (SpiderAkiraC)" ;EAr_SpiderAkiraC_AbsorbStaminaAO
	xEnchArtStrings[19] = "$Chaos Art  (SpiderAkiraC)" ;EAr_SpiderAkiraC_ChaosAO
	xEnchArtStrings[20] = "$Fear Art  (SpiderAkiraC)" ;EAr_SpiderAkiraC_FearAO
	xEnchArtStrings[21] = "$Fire Art  (SpiderAkiraC)" ;EAr_SpiderAkiraC_FireAO
	xEnchArtStrings[22] = "$Frost Art  (SpiderAkiraC)" ;EAr_SpiderAkiraC_FrostAO
	xEnchArtStrings[23] = "$Magic Blue Art  (SpiderAkiraC)" ;EAr_SpiderAkiraC_MagicBlueAO
	xEnchArtStrings[24] = "$Magic Green Art  (SpiderAkiraC)" ;EAr_SpiderAkiraC_MagicGreenAO
	xEnchArtStrings[25] = "$Shock Art  (SpiderAkiraC)" ;EAr_SpiderAkiraC_ShockAO
	xEnchArtStrings[26] = "$Soul Trap Art  (SpiderAkiraC)" ;EAr_SpiderAkiraC_SoultrapAO
	xEnchArtStrings[27] = "$Turn Undead Art  (SpiderAkiraC)" ;EAr_SpiderAkiraC_TurnUndeadAO
	xEnchArtStrings[28] = "$Frost Art  (GRIMELEVEN)" ;EAr_Grimeleven_AllWeapFrostAO
	xEnchArtStrings[29] = "$Shock Art  (GRIMELEVEN)" ;EAr_Grimeleven_AllWeapShockAO
	xEnchArtStrings[30] = "$Blood Art  (GRIMELEVEN)"
	xEnchArtStrings[31] = "$Fire Art  (GRIMELEVEN)"
	xEnchArtStrings[32] = "$Magic Art  (GRIMELEVEN)"
	xEnchArtStrings[33] = "$Soul Art  (GRIMELEVEN)"
	xEnchArtStrings[34] = "$Green Art  (GRIMELEVEN)"
	xEnchArtStrings[35] = "$Holy Art  (GRIMELEVEN)"
	xEnchArtStrings[36] = "$Fire Art  (BrotherBob)" ;EAr_BrotherBob_FireAO
	xEnchArtStrings[37] = "$Hand Flames Art  (Rizing)" ;EAr_Rizing_FireEnchAO
	xEnchArtStrings[38] = "$Hand Sparks Art  (Rizing)" ;EAr_Rizing_ShockEnchAO
	xEnchArtStrings[39] = "$Turn Undead Art  (Rizing)" ;EAr_Rizing_TurnundeadEnchAO
	xEnchArtStrings[40] = "$Dark Soul Art  (Rizing)" ;EAr_Rizing_DarkSoulEnchAO
	xEnchArtStrings[41] = "$Blue Soul Art  (Rizing)" ;EAr_Rizing_BlueSoulEnchAO
	xEnchArtStrings[42] = "$Blue Wisp Art  (BrotherBob)" ;FXDraugrMagicSwordStreakObject(BrotherBob)
	xEnchArtStrings[43] = "$Chillrend Art  (BrotherBob)" ;ChillrendEnchFX(BrotherBob)
	xEnchArtStrings[44] = "$Holy Art  (satorius13)" ;EAr_satorius13_HolyAO
	xEnchArtStrings[45] = "$Fire Art  (Sinobol)" ;EAr_Sinobol_OrangeAO
	xEnchArtStrings[46] = "$Frost Art  (Sinobol)" ;EAr_Sinobol_FrostAO
	xEnchArtStrings[47] = "$Shock Art  (Sinobol)" ;EAr_Sinobol_PurpleBlueAO
	xEnchArtStrings[48] = "$Red Art  (Sinobol)" ;EAr_Sinobol_RedAO
	xEnchArtStrings[49] = "$Yellow Art  (Sinobol)" ;EAr_Sinobol_YellowAO
	xEnchArtStrings[50] = "$Green Art  (Sinobol)" ;EAr_Sinobol_GreenAO
	xEnchArtStrings[51] = "$Blue Art  (Sinobol)" ;EAr_Sinobol_BlueAO
	xEnchArtStrings[52] = "$Purple Art  (Sinobol)" ;EAr_Sinobol_PurpleAO
EndFunction






;__________________________________________________________________________________________________________________________________________
;-------------------------------------------------------- PLAYER SETTINGS DATA VAULT ------------------------------------------------------

;player arrays work like this:
;	idx 0   - 8   ::   Fire Damage  (for Sword,Dagger,WarAxe,Mace,Greatsword,Battleaxe,Warhammer,Bow,Crossbow)
;	idx 9   - 17  ::   Frost Damage (for same weapons)
;	idx 18  - 26  ::   Shock Damage (etc)
;	idx 27  - 35  ::   Soul Trap
;	idx 36  - 44  ::   AbsorbHealth
;	idx 45  - 53  ::   AbsorbStamina
;	idx 54  - 62  ::   AbsorbMagicka
;	idx 63  - 71  ::   Stamina Damage
;	idx 72  - 80  ::   Magicka Damage
;	idx 81  - 89  ::   Turn Undead
;	idx 90  - 98  ::   Paralysis
;	idx 99  - 107 ::   Banish
;	idx 108 - 116 ::   Fear
;	idx 117 - 125 ::   Silent Moons

EffectShader[]  property pEnchShader      auto hidden
Art[]           property pEnchArt         auto hidden
EffectShader[]  property pHitShader       auto hidden
Art[]           property pHitArt          auto hidden
ImpactDataSet[] property pImpactData      auto hidden
int[]           property pFXPersistPreset auto hidden
float[]         property pTaperWeight     auto hidden ;(hidden from player)
float[]         property pTaperCurve      auto hidden ;(hidden from player) <---- these derived from defaults or player-chosen FX Preset
float[]         property pTaperDuration   auto hidden ;(hidden from player)
Projectile[]    property pProjectile      auto hidden ;(hidden from player, just associate this with effect set)

string[] property pStrEnchShader       auto hidden
string[] property pStrEnchShaderSpec   auto hidden
string[] property pStrEnchShaderPreset auto hidden
string[] property pStrEnchArt          auto hidden
string[] property pStrHitShader        auto hidden            ;STRINGS
string[] property pStrHitArt           auto hidden
string[] property pStrImpactData       auto hidden
string[] property pStrFXPersistPreset  auto hidden
string[] property pStrProjectile       auto hidden


Function InitializePlayerData()
	pEnchShader          = new EffectShader[128]
	pEnchArt             = new Art[128]
	pHitShader           = new EffectShader[128]
	pHitArt              = new Art[128]
	pImpactData          = new ImpactDataSet[128]
	pFXPersistPreset     = new int[128]
	pTaperWeight         = new float[128]
	pTaperCurve          = new float[128]
	pTaperDuration       = new float[128]
	pProjectile          = new Projectile[128]
	pStrEnchShader       = new string[128]
	pStrEnchShaderSpec   = new string[128]
	pStrEnchShaderPreset = new string[128]
	pStrEnchArt          = new string[128]
	pStrHitShader        = new string[128]
	pStrHitArt           = new string[128]
	pStrImpactData       = new string[128]
	pStrFXPersistPreset  = new string[128]
	pStrProjectile       = new string[128]


	int i = 0
	while i < 14
		int j = 0
		while j < 9
			int idx = i * 9 + j
			pEnchShader[idx]          = effectDefaultsEnchShader[i]
			pEnchArt[idx]             = effectDefaultsEnchArt[i]
			pHitShader[idx]           = effectDefaultsHitShader[i]
			pHitArt[idx]              = effectDefaultsHitArt[i]
			pImpactData[idx]          = effectDefaultsImpactData[i]
			pProjectile[idx]          = effectDefaultsProjectile[i]
			pFXPersistPreset[idx]     = effectDefaultsFXPersist[i]
			pTaperWeight[idx]         = effectDefaultsTaperWeight[i]
			pTaperCurve[idx]          = effectDefaultsTaperCurve[i]
			pTaperDuration[idx]       = effectDefaultsTaperDuration[i]
			pStrEnchShader[idx]       = WeaponMGEFShaderStrs[i]
			pStrEnchShaderSpec[idx]   = WeaponMGEFShaderStrsSpecDefault[i]
			pStrEnchShaderPreset[idx] = WeaponMGEFShaderStrsSpecDefault[i]
			pStrEnchArt[idx]          = "$NONE"
			int locate                = xHitShaderArray.find(pHitShader[idx])
			pStrHitShader[idx]        = xHitShaderStrings[locate]
			locate                    = xHitArtArray.find(pHitArt[idx])
			pStrHitArt[idx]           = xHitArtStrings[locate]
			locate                    = xImpactDataArray.find(pImpactData[idx])
			pStrImpactData[idx]       = xImpactDataStrings[locate]
			locate                    = xProjectileArray.find(pProjectile[idx])
			pStrProjectile[idx]       = xProjectileStrings[locate]

			if i == cEnchFear || i == cEnchSoulTrap || i == cEnchParalysis || i == cEnchTurnUndead
				pStrFXPersistPreset[idx] = "$Full Effect Duration"
			else
				locate                   = xTaperDurationArray.find(pTaperDuration[idx])
				pStrFXPersistPreset[idx] = xFXPersistStrings[locate]
			endif
			j += 1
		endWhile
		i += 1
	endWhile

EndFunction



;this only needs to run the first time the mod is installed now, the plugin takes over after that.
Function RunLoadMaintenance()

	if !EnchArsenal.SetupMGEFInfoLibrary(pEnchShader, pEnchArt, pHitShader, pHitArt, pProjectile, pImpactData, pFXPersistPreset, pTaperWeight, pTaperCurve, pTaperDuration)
		debug.trace("\n\n\n\n\n\n\n\n\nFAILED TO SETUP MGEF LIBRARY\n\n\n\n\n\n\n\n\n")
	endif
	if !EnchArsenal.SetupDefaultMGEFList(enchList)
		debug.trace("\n\n\n\n\n\n\n\n\nFAILED TO SETUP DEFAULT MGEFs\n\n\n\n\n\n\n\n\n")
	endif

EndFunction



Event OnUninstall(string eventName, string strArg, float numArg, Form sender)
	menu.Pages = new string[1]
	(menu as Quest).stop()
	(self as Quest).stop()
	EnchArsenal.UninstallEnchArsenalPlugin(true)
EndEvent










;EffectShaders
; EffectShader EAr_Vysh_CloudyBlueFXS
; EffectShader EAr_Vysh_CloudyGreenFXS
; EffectShader EAr_Vysh_CloudyPurpleFXS
; EffectShader EAr_Vysh_CloudyRedFXS
; EffectShader EAr_Vysh_BanishFXS
; EffectShader EAr_Vysh_FireFXS
; EffectShader EAr_Vysh_FireFXS_2x
; EffectShader EAr_Vysh_GreenBlackFXS
; EffectShader EAr_Vysh_GreenBlackFXS_2x
; EffectShader EAr_Vysh_RedBlackFXS
; EffectShader EAr_Vysh_RedBlackFXS_2x
; EffectShader EAr_Vysh_TurnFXS
; EffectShader EAr_Vysh_FrostFXS
; EffectShader EAr_Vysh_FXSpiderblue
; EffectShader EAr_Vysh_FXSpidergreen
; EffectShader EAr_Vysh_FXSpiderred
; EffectShader EAr_Vysh_NoSND_CloudyBlueFXS
; EffectShader EAr_Vysh_NoSND_CloudyGreenFXS
; EffectShader EAr_Vysh_NoSND_BanishFXS
; EffectShader EAr_Vysh_NoSND_FireFXS
; EffectShader EAr_Vysh_NoSND_FireFXS_2x
; EffectShader EAr_Vysh_NoSND_GreenBlackFXS
; EffectShader EAr_Vysh_NoSND_GreenBlackFXS_2x
; EffectShader EAr_Vysh_NoSND_RedBlackFXS
; EffectShader EAr_Vysh_NoSND_RedBlackFXS_2x
; EffectShader EAr_Vysh_NoSND_TurnFXS
; EffectShader EAr_Vysh_NoSND_FrostFXS
; EffectShader EAr_Vysh_NoSND_FXSpiderblue
; EffectShader EAr_Vysh_NoSND_FXSpidergreen
; EffectShader EAr_Vysh_NoSND_FXSpiderred
; EffectShader EAr_Vysh_NoSND_ParaXPFXS
; EffectShader EAr_Vysh_NoSND_ShockFXS
; EffectShader EAr_Vysh_NoSND_SoultrapFXS
; EffectShader EAr_Vysh_ParaXPFXS
; EffectShader EAr_Vysh_ShockFXS
; EffectShader EAr_Vysh_SoultrapFXS
; EffectShader EAr_Vysh_TimeFadeOut01FXS
; EffectShader EAr_Myopic_2x_BlueFXS
; EffectShader EAr_Myopic_2x_FireFXS
; EffectShader EAr_Myopic_2x_FrostFXS
; EffectShader EAr_Myopic_2x_GreenFXS
; EffectShader EAr_Myopic_2x_PurpleFXS
; EffectShader EAr_Myopic_2x_RedFXS
; EffectShader EAr_Myopic_2x_ShockFXS
; EffectShader EAr_Myopic_Combo_BlueFXS
; EffectShader EAr_Myopic_Combo_FireFXS
; EffectShader EAr_Myopic_Combo_FrostFXS
; EffectShader EAr_Myopic_Combo_GreenFXS
; EffectShader EAr_Myopic_Combo_PurpleFXS
; EffectShader EAr_Myopic_Combo_RedFXS
; EffectShader EAr_Myopic_Combo_ShockFXS
; EffectShader EAr_Myopic_Letters_BlueFXS
; EffectShader EAr_Myopic_Letters_FireFXS
; EffectShader EAr_Myopic_Letters_FrostFXS
; EffectShader EAr_Myopic_Letters_GreenFXS
; EffectShader EAr_Myopic_Letters_PurpleFXS
; EffectShader EAr_Myopic_Letters_RedFXS
; EffectShader EAr_Myopic_Letters_ShockFXS
; EffectShader EAr_darkman24_BlueFXS
; EffectShader EAr_darkman24_FireFXS
; EffectShader EAr_darkman24_FireFXS_Alt
; EffectShader EAr_darkman24_FrostFXS
; EffectShader EAr_darkman24_GreenFXS
; EffectShader EAr_darkman24_PurpleFXS
; EffectShader EAr_darkman24_RedFXS
; EffectShader EAr_darkman24_ShockFXS
; EffectShader EAr_darkman24_ShockFXS_Alt
; EffectShader EAr_warden01_BlueFXS
; EffectShader EAr_warden01_BlueFXS_2x
; EffectShader EAr_warden01_FireFXS
; EffectShader EAr_warden01_FireFXS_2x
; EffectShader EAr_warden01_FrostFXS
; EffectShader EAr_warden01_FrostFXS_2x
; EffectShader EAr_warden01_GreenFXS
; EffectShader EAr_warden01_GreenFXS_2x
; EffectShader EAr_warden01_PinkFXS
; EffectShader EAr_warden01_PinkFXS_2x
; EffectShader EAr_warden01_PurpleFXS
; EffectShader EAr_warden01_PurpleFXS_2x
; EffectShader EAr_warden01_RedFXS
; EffectShader EAr_warden01_RedFXS_2x
; EffectShader EAr_warden01_ShockFXS
; EffectShader EAr_warden01_SilveredFXS
; EffectShader EAr_warden01_SpecialBlueFXS
; EffectShader EAr_warden01_SpecialGreenFXS
; EffectShader EAr_warden01_SpecialRedFXS
; EffectShader EAr_warden01_SpecialVioletFXS
; EffectShader EAr_warden01_SpecialYellowFXS
; EffectShader EAr_SpiderAkiraC_FearFXS
; EffectShader EAr_SpiderAkiraC_FireFXS
; EffectShader EAr_SpiderAkiraC_HolyFXS
; EffectShader EAr_SpiderAkiraC_ShockFXS
; EffectShader EAr_SpiderAkiraC_SoulTrapFXS
; EffectShader EAr_SpiderAkiraC_BlueFXS
; EffectShader EAr_SpiderAkiraC_BlueFXS_2x
; EffectShader EAr_SpiderAkiraC_DamageBlueFXS
; EffectShader EAr_SpiderAkiraC_DamageGreenFXS
; EffectShader EAr_SpiderAkiraC_GreenFXS
; EffectShader EAr_SpiderAkiraC_PurpleFXS
; EffectShader EAr_SpiderAkiraC_PurpleFXS_2x
; EffectShader EAr_SpiderAkiraC_RedFXS
; EffectShader EAr_Grimeleven_BloodFXS
; EffectShader EAr_Grimeleven_OtherBloodFXS
; EffectShader EAr_Grimeleven_FrostFXS
; EffectShader EAr_Grimeleven_FireFXS
; EffectShader EAr_Grimeleven_MagicFXS
; EffectShader EAr_Grimeleven_ReanimateFXS








;     ===========================< FIRE DAMAGE >========================
;     |                    FX COLLECTION|   FX TYPE                    |
;     >=================================|>==============================
;     | Sword         ANIM ENCH OVERHAUL|   FireFX                     |
;     | Dagger        ANIM ENCH OVERHAUL|   FireFX                     |
;     | WarAxe                  SEE ENCH|   SpecialRed                 |
;     | Mace                    SEE ENCH|   SpecialRed                 |
;     | Greatsword    ANIM ENCH OVERHAUL|   SoulTrapFX                 |
;     | Battleaxe     ANIM ENCH OVERHAUL|   SoulTrapFX                 |
;     | Warhammer     ANIM ENCH OVERHAUL|   SoulTrapFX                 |
;     | Bow           ANIM WEAP ENCHANTS|   FireFX                     |
;     | Crossbow                 DEFAULT|   FireFX                     |
;     |                                 |                     RESET ALL|

		

; getCurrentSet(weapType)[enchType] ;return set used for this combo
; getCurrentFX(weapType)[enchType] ;could return number to find FX in main array



; Event applyCurrentFX(int wCode, int eCode)
; 	goToState(weaponStates[wCode])
; 	;retrieve all info from fxMasterCodes first to ensure thread safety
; 	int index1 = (fxMasterCodes[eCode] % 1000)
; 	int index2 = (fxMasterCodes[eCode] / 1000) % 10000
; 	int index3 = (fxMasterCodes[eCode] / 10000000)

; 	if index1 > 0 ;if custom EnchArt
; 		enchList[eCode].setEnchantArt(enchArtArray[index])
; 	endif

; 	if index2 > 0 ;if custom EffShader
; 		if (index / 1000) == 0 ;first EffShader array
; 			enchList[eCode].setEnchantShader(enchEffShaders1[index])
; 		else ;second EffShader array
; 			index = index % 1000
; 			enchList[eCode].setEnchantShader(enchEffShaders2[index])
; 		endif
; 	endif

; 	if index3 > 0 ;if custom HitShader
; 		enchList[eCode].setHitShader(enchHitShaders[index])
; 	endif
; EndEvent




; string[] weaponStates
; int[] fxMasterCodes
; int[] fxArray0
; int[] fxArray1
; int[] fxArray2
; int[] fxArray3
; int[] fxArray4
; int[] fxArray5
; int[] fxArray6
; int[] fxArray7
; int[] fxArray8

; Function InitializeFXArrays()
; 	;
; 	fxArray0  = new int[50]
; 	fxArray1  = new int[50]
; 	fxArray2  = new int[50]     ;HitShader, EffectShader, ArtObj
; 	fxArray3  = new int[50]     ;  000          0 000      000        ;EffShader gets extra zero to indicate array# (will need 2 arrays)
; 	fxArray4  = new int[50]     ;
; 	fxArray5  = new int[50]     ; example:
; 	fxArray6  = new int[50]     ;  (000)(0)105020 == no hit shader, EffShader 105 in array zero, artObj 20
; 	fxArray7  = new int[50]
; 	fxArray8  = new int[50]

; 	weaponStates = new string[9]
; 	weaponStates[0] = "_fxArray0State"
; 	weaponStates[1] = "_fxArray1State"
; 	weaponStates[2] = "_fxArray2State"
; 	weaponStates[3] = "_fxArray3State"
; 	weaponStates[4] = "_fxArray4State"
; 	weaponStates[5] = "_fxArray5State"
; 	weaponStates[6] = "_fxArray6State"
; 	weaponStates[7] = "_fxArray7State"
; 	weaponStates[8] = "_fxArray8State"
; EndFunction


; State _fxArray0State
; 	Event OnBeginState()
; 		fxMasterCodes = fxArray0
; 	EndEvent
; EndState
; State _fxArray1State
; 	Event OnBeginState()
; 		fxMasterCodes = fxArray1
; 	EndEvent
; EndState
; State _fxArray2State
; 	Event OnBeginState()
; 		fxMasterCodes = fxArray2
; 	EndEvent
; EndState
; State _fxArray3State
; 	Event OnBeginState()
; 		fxMasterCodes = fxArray3
; 	EndEvent
; EndState
; State _fxArray4State
; 	Event OnBeginState()
; 		fxMasterCodes = fxArray4
; 	EndEvent
; EndState
; State _fxArray5State
; 	Event OnBeginState()
; 		fxMasterCodes = fxArray5
; 	EndEvent
; EndState
; State _fxArray6State
; 	Event OnBeginState()
; 		fxMasterCodes = fxArray6
; 	EndEvent
; EndState
; State _fxArray7State
; 	Event OnBeginState()
; 		fxMasterCodes = fxArray7
; 	EndEvent
; EndState
; State _fxArray8State
; 	Event OnBeginState()
; 		fxMasterCodes = fxArray8
; 	EndEvent
; EndState