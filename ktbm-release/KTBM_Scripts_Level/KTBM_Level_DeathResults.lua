--include our custom scripts/extensions
require("KTBM_Core_Inclusions.lua")

--include level specific scripts
require("KTBM_LevelCleanup_M101_FlagshipExteriorDeck.lua");
require("KTBM_LevelRelight_M101_FlagshipExteriorDeck.lua");
require("KTBM_Cutscene_DeathResults.lua");
require("KTBM_Costumes_Kenny.lua");

require("KTBM_UI_DeathResults.lua");

--our main level variables
local kScript = "KTBM_Level_DeathResults";
local kScene = "adv_flagshipExteriorDeck";
local kSceneAgentName = kScene .. ".scene";

--setup KTBM
KTBM_Core_Project_SetProjectSettings();
KTBM_Core_Project_EnableGameArchives();

KTBM_Cutscene_DeathResults_kScene = kScene;
KTBM_LevelRelight_kScene = kScene;

KTBM_Development_SceneObject = kScene;
KTBM_Development_SceneObjectAgentName = kSceneAgentName;
KTBM_Development_UseSeasonOneAPI = false;
KTBM_Development_FreecamUseFOVScale = false;

KTBM_Cutscene_DeathResults_ShowUI = false;
KTBM_Cutscene_DeathResults_CanSkipToMenu = false;

--main level function (called when scene starts)
KTBM_Level_DeathResults = function()    
    KTBM_LevelCleanup_M101_FlagshipExteriorDeck_FullPurge(kScene);
    KTBM_LevelRelight_M101_FlagshipExteriorDeck_Build_DeathResults(kScene, kSceneAgentName);

    KTBM_Cutscene_DeathResults_PrepareCamera(kScene);
    KTBM_Cutscene_DeathResults_Build(kScene);

    KTBM_Costumes_Kenny_ApplySelectedOutfit(kScene);

    --if (KTBM_Core_Project_DebugFreecamMode) then
        --development helpers
        --KTBM_PrintSceneListToTXT(kScene, "sceneobject_ktbm-menu1.txt")
        --KTBM_LuaHelper_WriteSceneCleanupScript(kScene, "KTBM_LevelCleanup", "KTBM_Level.lua");
        
        --Callback_OnPostUpdate:Add(UpdateBoatBuoyancyAnimation);
        --Callback_OnPostUpdate:Add(KennyVoiceLineTest);
        --Callback_OnPostUpdate:Add(UpdateKennyIdleAnimation);

        --KTBM_Development_CreateFreeCamera();
        --KTBM_Development_InitalizeRelightTools();

        --Callback_OnPostUpdate:Add(KTBM_Development_UpdateFreeCamera);
        --Callback_OnPostUpdate:Add(KTBM_Development_UpdateRelightTools_Input);
        --Callback_OnPostUpdate:Add(KTBM_Development_UpdateRelightTools_Main);
    --else

        Callback_OnPostUpdate:Add(KTBM_Cutscene_DeathResults_Update);
    --end

    KTBM_UI_PrepareDeathResultsUI();
    Callback_OnPostUpdate:Add(KTBM_UI_UpdateDeathResultsUI);

    if (KTBM_Core_Project_DebugPeformanceMetrics) then
        KTBM_Development_PerformanceMetrics_Initalize();
        Callback_OnPostUpdate:Add(KTBM_Development_PerformanceMetrics_Update);
    end
end

SceneOpen(kScene, kScript);