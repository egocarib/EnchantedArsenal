set copysrc="C:\Users\Justin\Documents\My Games\SmartSteam_v1.4.1_Incl_Steam_2\SteamApps\common\Skyrim\Data\scripts\Source"
set copydst="C:\Skyrim Projects\Enchanted Arsenal\Data\scripts\Source"

robocopy %copysrc% EAr_* %copydst%
robocopy %copysrc% EnchArsenal* %copydst%
pause