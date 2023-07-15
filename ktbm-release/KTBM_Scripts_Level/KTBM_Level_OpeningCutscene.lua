--[[
-----------------------------------------------------------------------------------------
KTBM_Scene_OpeningCutscene

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
require("KTBM_Cutscene_OpeningCutscene.lua");

--our main level variables
local kScript = "KTBM_Level_OpeningCutscene";
local kScene = "adv_flagshipExteriorDeck";
local kSceneAgentName = kScene .. ".scene";

--setup KTBM
KTBM_Project_SetProjectSettings();
KTBM_Project_EnableGameArchives();

KTBM_Cutscene_OpeningCutscene_kScene = kScene;
KTBM_LevelRelight_kScene = kScene;

KTBM_Development_SceneObject = kScene;
KTBM_Development_SceneObjectAgentName = kSceneAgentName;
KTBM_Development_UseSeasonOneAPI = false;
KTBM_Development_FreecamUseFOVScale = false;

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
KTBM_Level_OpeningCutscene = function()    
    KTBM_LevelCleanup_M101_FlagshipExteriorDeck_Purge(kScene);
    KTBM_LevelRelight_M101_FlagshipExteriorDeck_Build(kScene, kSceneAgentName);
    Callback_OnPostUpdate:Add(KTBM_LevelRelight_M101_FlagshipExteriorDeck_UpdateLighting);

    KTBM_Costumes_Kenny_ApplySelectedOutfit(kScene);
    KTBM_Costumes_Boat_ApplySelectedOutfit(kScene);

    if (KTBM_Project_DebugEditorMode) then
        --development helpers
        --KTBM_PrintSceneListToTXT(kScene, "sceneobject_ktbm-menu1.txt")
        --KTBM_LuaHelper_WriteSceneCleanupScript(kScene, "KTBM_LevelCleanup", "KTBM_Level.lua");
        --KTBM_PrintValidPropertyNames(AgentFindInScene("Kenny", kScene));
        
        --Callback_OnPostUpdate:Add(UpdateBoatBuoyancyAnimation);
        --Callback_OnPostUpdate:Add(KennyVoiceLineTest);
        --Callback_OnPostUpdate:Add(UpdateKennyIdleAnimation);

        if(KTBM_Project_DebugFreecamMode == true) then
            KTBM_Development_CreateFreeCamera();
            Callback_OnPostUpdate:Add(KTBM_Development_UpdateFreeCamera);
        else
            Callback_OnPostUpdate:Add(KTBM_Development_Editor_Input_Update);

            KTBM_Development_CreateSceneCamera();
            Callback_OnPostUpdate:Add(KTBM_Development_UpdateSceneCamera);

            KTBM_Development_ObjectIcons_Initalize(kScene);
            Callback_OnPostUpdate:Add(KTBM_Development_ObjectIcons_Update);

            KTBM_Development_TransformTool_Initalize();
            Callback_OnPostUpdate:Add(KTBM_Development_TransformTool_Update);

            --KTBM_Development_InitalizeRelightTools();
            --Callback_OnPostUpdate:Add(KTBM_Development_UpdateRelightTools_Input);
            --Callback_OnPostUpdate:Add(KTBM_Development_UpdateRelightTools_Main);

            KTBM_Development_MainGUI_Initalize();
            Callback_OnPostUpdate:Add(KTBM_Development_MainGUI_Update);
        end
    else
        KTBM_Cutscene_OpeningCutscene_PrepareCamera();
    end

    KTBM_Cutscene_OpeningCutscene_Start();
    Callback_OnPostUpdate:Add(KTBM_Cutscene_OpeningCutscene_Update);

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

    if (KTBM_Project_ShowDevelopmentText) and (KTBM_Project_DebugEditorMode == false) then
        KTBM_Development_DevelopmentBuildText_Initalize();
        Callback_OnPostUpdate:Add(KTBM_Development_DevelopmentBuildText_Update);
    end
end

SceneOpen(kScene, kScript);