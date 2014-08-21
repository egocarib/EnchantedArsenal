Scriptname EnchArsenal hidden


;setup initial player enchant effect library inside the plugin
bool Function SetupMGEFInfoLibrary(EffectShader[] enchShaders, Art[] enchArt, EffectShader[] hitShaders, Art[] hitArt, Projectile[] proj, ImpactDataSet[] ids, int[] fxPersist, float[] tWeights, float[] tCurves, float[] tDurations) global native
;mgefs.length must equal 14 for current build:
bool Function SetupDefaultMGEFList(MagicEffect[] mgefs) global native

	;query effect library (no reason to use these currently)
	EffectShader  Function GetLibraryEnchantShader (int index) global native
	Art           Function GetLibraryEnchantArt    (int index) global native
	EffectShader  Function GetLibraryHitShader     (int index) global native
	Art           Function GetLibraryHitArt        (int index) global native
	Projectile    Function GetLibraryProjectile    (int index) global native
	ImpactDataSet Function GetLibraryImpactData    (int index) global native
	int           Function GetLibraryPersistFlag   (int index) global native
	float         Function GetLibraryTaperWeight   (int index) global native
	float         Function GetLibraryTaperCurve    (int index) global native
	float         Function GetLibraryTaperDuration (int index) global native

	EffectShader  Function GetLibraryCustomEnchantShader (int index) global native
	
	;modify effect library (will set range # of entries, starting from index)
	Function SetLibraryEnchantShader (EffectShader effShader, int index, int range = 1) global native
	Function SetLibraryEnchantArt    (Art artObj,             int index, int range = 1) global native
	Function SetLibraryHitShader     (EffectShader effShader, int index, int range = 1) global native
	Function SetLibraryHitArt        (Art artObj,             int index, int range = 1) global native
	Function SetLibraryProjectile    (Projectile proj,        int index, int range = 1) global native
	Function SetLibraryImpactData    (ImpactDataSet ids,      int index, int range = 1) global native
	Function SetLibraryPersistFlag   (int flag,               int index, int range = 1) global native
	Function SetLibraryTaperWeight   (float tWeight,          int index, int range = 1) global native
	Function SetLibraryTaperCurve    (float tCurve,           int index, int range = 1) global native
	Function SetLibraryTaperDuration (float tDuration,        int index, int range = 1) global native

	Function SetLibraryCustomEnchantShader (EffectShader effShader, int index, int range = 1) global native
	Function SetLibraryCustomEnchantArt    (Art artObj,             int index, int range = 1) global native
	Function SetLibraryCustomHitShader     (EffectShader effShader, int index, int range = 1) global native
	Function SetLibraryCustomHitArt        (Art artObj,             int index, int range = 1) global native
	Function SetLibraryCustomProjectile    (Projectile proj,        int index, int range = 1) global native
	Function SetLibraryCustomImpactData    (ImpactDataSet ids,      int index, int range = 1) global native
	Function SetLibraryCustomPersistFlag   (int flag,               int index, int range = 1) global native
	Function SetLibraryCustomTaperWeight   (float tWeight,          int index, int range = 1) global native
	Function SetLibraryCustomTaperCurve    (float tCurve,           int index, int range = 1) global native
	Function SetLibraryCustomTaperDuration (float tDuration,        int index, int range = 1) global native

;FISS-related methods
Function SaveTranslateShaders     (EffectShader[] effShaders, int[] iOutputFormID, int[] bOutputSkyrimEsm) global native
Function SaveTranslateArt         (Art[] artObjs,             int[] iOutputFormID, int[] bOutputSkyrimEsm) global native
Function SaveTranslateImpactData  (ImpactDataSet[] IDSs,      int[] iOutputFormID, int[] bOutputSkyrimEsm) global native
Function SaveTranslateProjectiles (Projectile[] projs,        int[] iOutputFormID, int[] bOutputSkyrimEsm) global native

;used to turn off serialization when the mod is uninstalled
Function UninstallEnchArsenalPlugin(bool shouldUninstall) global native

string Function AddCustomEnchantment(MagicEffect[] returnMGEF, bool[] returnPersistInfo) global native
Function RemoveCustomEnchantment(int index) global native
Function CheckForMissingCustomEnchantments(int[] indicesToCheck) global native
Function AssertCurrentCustomData(MagicEffect[] currentMGEFs) global native ;used to fix internal plugin data save error in versions before 2.21