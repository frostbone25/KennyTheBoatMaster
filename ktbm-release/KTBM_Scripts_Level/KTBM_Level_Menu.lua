--[[
-----------------------------------------------------------------------------------------
KTBM_Scene_Menu

This script deals with the main gameplay of the mini game.
-----------------------------------------------------------------------------------------
]]--

--include our custom scripts/extensions
require("KTBM_Core_Inclusions.lua")

--include level specific scripts
require("KTBM_LevelCleanup_M101_FlagshipExteriorDeck.lua");
require("KTBM_LevelRelight_M101_FlagshipExteriorDeck.lua");
require("KTBM_Costumes_Boat.lua");
require("KTBM_Costumes_Kenny.lua");
require("KTBM_Cutscene_Menu.lua");
require("KTBM_UI_MainMenu.lua");

--our main level variables
local kScript = "KTBM_Level_Menu";
local kScene = "adv_flagshipExteriorDeck";
local kSceneAgentName = kScene .. ".scene";

--setup KTBM
KTBM_Core_Project_SetProjectSettings();
KTBM_Core_Project_EnableGameArchives();

KTBM_Cutscene_Menu_kScene = kScene;
KTBM_LevelRelight_kScene = kScene;

KTBM_Development_SceneObject = kScene;
KTBM_Development_SceneObjectAgentName = kSceneAgentName;
KTBM_Development_UseSeasonOneAPI = false;
KTBM_Development_FreecamUseFOVScale = false;

KTBM_Development_BoundsDebug_ExtentsDebugging = false;
KTBM_Development_BoundsDebug_Agents = {
    "Page0_Play",
    "Page0_Costumes",
    "Page0_Options",
    "Page0_Help",
    "Page0_Credits",
    "Page0_ReturnToDE",
    "Page0_Quit"
};

--relighting dof autofocus variables
KTBM_DOF_AUTOFOCUS_SceneObject = kScene;
KTBM_DOF_AUTOFOCUS_SceneObjectAgentName = kScene .. ".scene";
KTBM_DOF_AUTOFOCUS_UseCameraDOF = true;
KTBM_DOF_AUTOFOCUS_UseLegacyDOF = false;
KTBM_DOF_AUTOFOCUS_UseHighQualityDOF = true;
KTBM_DOF_AUTOFOCUS_FocalRange = 1.0;
KTBM_DOF_AUTOFOCUS_GameplayCameraNames = 
{ 
    "None",
};
KTBM_DOF_AUTOFOCUS_ObjectEntries = 
{
    "Kenny"
};
KTBM_DOF_AUTOFOCUS_Settings =
{
    TargetValidation_IsOnScreen = true,
    TargetValidation_IsVisible = true,
    TargetValidation_IsWithinDistance = false,
    TargetValidation_IsFacingCamera = false,
    TargetValidation_IsOccluded = false,
    TargetValidation_RejectionAngle = 0.0, --goes from -1 to 1 (less than 0 is within the 180 forward facing fov of the given object)
    TargetValidation_RejectionDistance = 40.0, --the max distance before the agent is too far from camera to do autofocus
};
KTBM_DOF_AUTOFOCUS_BokehSettings =
{
    BokehBrightnessDeltaThreshold = 0.15,
    BokehBrightnessThreshold = 0.15,
    BokehBlurThreshold = 0.02,
    BokehMinSize = 0.0,
    BokehMaxSize = 0.025,
    BokehFalloff = 0.75,
    MaxBokehBufferAmount = 1.0,
    BokehPatternTexture = "bokeh_circle.d3dtx"
};

LensFlareEffect_kScene = kScene;

--main level function (called when scene starts)
KTBM_Level_Menu = function()    
    KTBM_LevelCleanup_M101_FlagshipExteriorDeck_Purge(kScene);
    KTBM_LevelRelight_M101_FlagshipExteriorDeck_Build(kScene, kSceneAgentName);
    Callback_OnPostUpdate:Add(KTBM_LevelRelight_M101_FlagshipExteriorDeck_UpdateLighting);

    KTBM_Cutscene_Menu_PrepareCamera(kScene);
    KTBM_Cutscene_Menu_Build(kScene);

    KTBM_Costumes_Kenny_ApplySelectedOutfit(kScene);

    Callback_OnPostUpdate:Add(KTBM_Cutscene_Menu_Animation_UpdateBoatBuoyancy);
    Callback_OnPostUpdate:Add(KTBM_Cutscene_Menu_Animation_UpdateHandheldCamera);

    --Callback_OnPostUpdate:Add(KTBM_Cutscene_Menu_KennyVoiceLineTest);
    --Callback_OnPostUpdate:Add(KTBM_Cutscene_Menu_UpdateKennyIdleAnimation);

    if (KTBM_Core_Project_DebugFreecamMode) then
        --development helpers
        --KTBM_PrintSceneListToTXT(kScene, "sceneobject_ktbm-menu1.txt")
        --KTBM_LuaHelper_WriteSceneCleanupScript(kScene, "KTBM_LevelCleanup", "KTBM_Level.lua");
        --KTBM_PrintValidPropertyNames(AgentFindInScene("Kenny", kScene));
        
        --Callback_OnPostUpdate:Add(UpdateBoatBuoyancyAnimation);
        --Callback_OnPostUpdate:Add(KennyVoiceLineTest);
        --Callback_OnPostUpdate:Add(UpdateKennyIdleAnimation);

        KTBM_Development_CreateFreeCamera();
        KTBM_Development_InitalizeRelightTools();

        Callback_OnPostUpdate:Add(KTBM_Development_UpdateFreeCamera);
        Callback_OnPostUpdate:Add(KTBM_Development_UpdateRelightTools_Input);
        Callback_OnPostUpdate:Add(KTBM_Development_UpdateRelightTools_Main);
    else
        KTBM_UI_MainMenu_Start();

        Callback_OnPostUpdate:Add(KTBM_UI_Update);
    end

    --LensFlareEffect_Initalize();
    --Callback_OnPostUpdate:Add(LensFlareEffect_Update);

    KTBM_DepthOfFieldAutofocus_SetupDOF();
    Callback_OnPostUpdate:Add(KTBM_DepthOfFieldAutofocus_PerformAutofocus);

    if (KTBM_Core_Project_DebugAllowBoundsDebug) then
        KTBM_Development_BoundsDebug_Initalize();
        Callback_OnPostUpdate:Add(KTBM_Development_BoundsDebug_Update);
    end

    if (KTBM_Core_Project_DebugPeformanceMetrics) then
        KTBM_Development_PerformanceMetrics_Initalize();
        Callback_OnPostUpdate:Add(KTBM_Development_PerformanceMetrics_Update);
    end
end

SceneOpen(kScene, kScript);