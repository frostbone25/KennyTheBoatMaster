--[[
-----------------------------------------------------------------------------------------
KTBM_Scene_Game

This script deals with the main gameplay of the mini game.
-----------------------------------------------------------------------------------------
]]--

--include our custom scripts/extensions
require("KTBM_Core_Inclusions.lua");

--all of our gameplay logic is in here
require("KTBM_Gameplay_Inclusions.lua");

require("KTBM_UI_Game.lua");

require("KTBM_Costumes_Boat.lua");
require("KTBM_Costumes_Kenny.lua");

--include level specific scripts
require("KTBM_LevelCleanup_M101_FlagshipExteriorDeck.lua");
require("KTBM_LevelRelight_M101_FlagshipExteriorDeck.lua");

require("KTBM_Cutscene_Game.lua");
require("KTBM_Cutscene_GameDeath.lua");

--setup KTBM
KTBM_Core_Project_SetProjectSettings();
KTBM_Core_Project_EnableGameArchives();

--our main level variables
local kScript = "KTBM_Level_Game";
local kScene = "adv_flagshipExteriorDeck";
local kSceneAgentName = kScene .. ".scene";

KTBM_Gameplay_kScene = kScene;

KTBM_Development_SceneObject = kScene;
KTBM_Development_SceneObjectAgentName = kSceneAgentName;
KTBM_Development_UseSeasonOneAPI = false;
KTBM_Development_FreecamUseFOVScale = false;

KTBM_Gameplay_CrashSequenceUpdate = function()
    if(KTBM_Gameplay_State_HasCrashed == false) then
        return;
    end

    KTBM_Gameplay_EnvironmentMovementSpeed = 0;
end

KTBM_Gameplay_GameLoopStart = function()
    KTBM_Gameplay_Player_CreateGameCamera(kScene);
    KTBM_Cutscene_Game_Start(kScene);
    KTBM_UI_GamePrepare();

    KTBM_SetAgentWorldPosition("group_enviorment", Vector(0, KTBM_Gameplay_EnvironmentHeightOffset, 0), kScene);

    KTBM_Gameplay_Stats_StartTime = GetTotalTime();
end

local bool_triggerOnce = false;

KTBM_Gameplay_GameLoopUpdate = function()
    KTBM_Gameplay_PlayerInputUpdate();
    KTBM_Gameplay_PhysicsUpdate();
    KTBM_Gameplay_CrashSequenceUpdate();
    KTBM_Gameplay_PlayerUpdate();
    KTBM_Gameplay_EnvironmentScrolling();
    KTBM_Gameplay_RocksUpdate();
    KTBM_Gameplay_ZombiesUpdate();

    KTBM_UI_GameUpdate();

    --this isnt necessary for all of these functions, ideally i'd avoid it.
    --but just for certainty and prevention we will do protected calls of all of these update functions.
    --this is to ensure that if a function somehow errors out it won't completely break the game.

    --local status_KTBM_Gameplay_PlayerInputUpdate = pcall(KTBM_Gameplay_PlayerInputUpdate);
    --local status_KTBM_Gameplay_PhysicsUpdate = pcall(KTBM_Gameplay_PhysicsUpdate);
    --local status_KTBM_Gameplay_CrashSequenceUpdate = pcall(KTBM_Gameplay_CrashSequenceUpdate);
    --local status_KTBM_Gameplay_PlayerUpdate = pcall(KTBM_Gameplay_PlayerUpdate);
    --local status_KTBM_Gameplay_EnviormentScrolling = pcall(KTBM_Gameplay_EnvironmentScrolling);
    --local status_KTBM_Gameplay_RocksUpdate = pcall(KTBM_Gameplay_RocksUpdate);
    --local status_KTBM_Gameplay_ZombiesUpdate = pcall(KTBM_Gameplay_ZombiesUpdate);

    --NOTE: Add UI elements and their update functions AFTER the main gameplay update code that moves the camera.
    --if not then it will cause a jittering to occur when the camera moves with the UI trying to stay on screen
    --local status_KTBM_Gameplay_UpdateGameUIText = pcall(KTBM_UI_GameUpdate);

    --keep tracking these stats until we crash
    if(KTBM_Gameplay_State_HasCrashed == false) then
        KTBM_Gameplay_Stats_DistanceTraveled = KTBM_Gameplay_Stats_DistanceTraveled + (KTBM_Gameplay_EnvironmentMovementSpeed * GetFrameTime());

        KTBM_Gameplay_Stats_EndTime = GetTotalTime();
        KTBM_Gameplay_Stats_TotalTime = KTBM_Gameplay_Stats_EndTime - KTBM_Gameplay_Stats_StartTime;
    else
        if(bool_triggerOnce == false) then
            KTBM_Cutscene_Game_End(kScene);
            KTBM_Cutscene_GameDeath_Start(kScene);
            KTBM_LevelRelight_M101_FlagshipExteriorDeck_MakeGameWaterStatic(kScene);

            local gameResults_object = KTBM_Data_BuildGameResultsObject(KTBM_Gameplay_Stats_DistanceTraveled, KTBM_Gameplay_Stats_ZombiesKilled, KTBM_Gameplay_Stats_TotalTime);
            KTBM_Data_SaveGameResults(gameResults_object);

            bool_triggerOnce = true;
        end
    end
end

--main level function (called when scene starts)
KTBM_Level_Game = function()    
    KTBM_LevelCleanup_M101_FlagshipExteriorDeck_Purge(kScene);
    KTBM_LevelRelight_M101_FlagshipExteriorDeck_Build(kScene, kSceneAgentName);
    KTBM_LevelRelight_M101_FlagshipExteriorDeck_ModifyWaterForGame(kScene);

    KTBM_Costumes_Boat_Build(kScene);
    KTBM_Costumes_Kenny_AddToBoat(kScene);
    KTBM_Costumes_Kenny_ApplySelectedOutfit(kScene);

    if (KTBM_Core_Project_DebugFreecamMode) then
        KTBM_Development_CreateFreeCamera();
        KTBM_Development_InitalizeRelightTools();

        Callback_OnPostUpdate:Add(KTBM_Development_UpdateFreeCamera);
        Callback_OnPostUpdate:Add(KTBM_Development_UpdateRelightTools_Input);
        Callback_OnPostUpdate:Add(KTBM_Development_UpdateRelightTools_Main);
    else
        
        KTBM_Gameplay_GameLoopStart();
        Callback_OnPostUpdate:Add(KTBM_Gameplay_GameLoopUpdate);

        Callback_OnPostUpdate:Add(KTBM_Cutscene_GameDeath_Update);

        if (KTBM_Core_Project_DebugRockCollisionsUI) then
            KTBM_Gameplay_PrepareDebugRockCollisionsUI();
            Callback_OnPostUpdate:Add(KTBM_Gameplay_UpdateDebugRockCollisionsUI);
        end
    end

    if (KTBM_Core_Project_DebugPeformanceMetrics) then
        KTBM_Development_PerformanceMetrics_Initalize();
        Callback_OnPostUpdate:Add(KTBM_Development_PerformanceMetrics_Update);
    end
end

SceneOpen(kScene, kScript);