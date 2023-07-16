require("KTBM_Cutscene_Utilities.lua");
require("KTBM_Cutscene_Skip.lua");

KTBM_Cutscene_OpeningCutscene_PrepareCamera = function()
    local cam_prop = "module_camera.prop";
    
    local newPosition = Vector(-0.827604, 0.902787, 1.085702);
    local newRotation = Vector(-1.833327, 168.750092, 0.0);
    
    local cameraAgent = AgentCreate("myMenuCamera", cam_prop, newPosition, newRotation, KTBM_Cutscene_OpeningCutscene_kScene, false, false);
    
    KTBM_AgentSetProperty("myMenuCamera", "Clip Plane - Far", 2500, KTBM_Cutscene_OpeningCutscene_kScene);
    KTBM_AgentSetProperty("myMenuCamera", "Clip Plane - Near", 0.05, KTBM_Cutscene_OpeningCutscene_kScene);
    KTBM_AgentSetProperty("myMenuCamera", "Lens - Current Lens", nil, KTBM_Cutscene_OpeningCutscene_kScene);

    KTBM_RemovingAgentsWithPrefix(KTBM_Cutscene_OpeningCutscene_kScene, "cam_");

    CameraPush("myMenuCamera");
    --CameraActivate("myMenuCamera");
end

local controller_music = nil;
local controller_sound_sceneAmbient = nil;
local controller_kenny_idle = nil;
local kenny_agent = nil;

local number_sceneStartTime = 0;
local bool_trigger_loadGame = false;
local bool_trigger_cutsceneStart = false;

local agent_tempText = nil;

KTBM_Cutscene_OpeningCutscene_Start = function()
    -----------------------------------------------
    CursorHide(false);
    CursorEnable(true);

    KTBM_Cutscene_Skip_Build();

    agent_tempText = KTBM_TextUI_CreateTextAgent("agent_tempText", "Opening Cutscene Not Implemented Yet", Vector(0, 0, 0), 2, 0);
    TextSetScale(agent_tempText, 1.0);
    TextSetColor(agent_tempText, Color(1.0, 1.0, 1.0, 1.0));

    number_sceneStartTime = GetTotalTime();
end

--main function that prepares the level enviorment
KTBM_Cutscene_OpeningCutscene_Build = function()
    KTBM_Costumes_Boat_Build(KTBM_Cutscene_OpeningCutscene_kScene);
    KTBM_Costumes_Kenny_AddToBoat(KTBM_Cutscene_OpeningCutscene_kScene);

    --------------------------------------------------------
    --create our audio
    
    --set our soundtrack
    controller_music = SoundPlay("mus_linear_intro_lakeBridgeApproach.wav");
    ControllerSetLooping(controller_music, true);
    ControllerSetSoundVolume(controller_music, 0.5);
    
    --do scene ambient sound
    controller_sound_sceneAmbient = SoundPlay("amb_river_shore_calm_water.wav");
    ControllerSetLooping(controller_sound_sceneAmbient, true);
    ControllerSetSoundVolume(controller_sound_sceneAmbient, 0.25);
    
    --------------------------------------------------------
    --prepare kennys base idle animations

    kenny_agent = AgentFindInScene("Kenny", KTBM_Cutscene_OpeningCutscene_kScene);

    --play a sitting animation
    controller_kenny_idle = PlayAnimation(kenny_agent, "sk54_idle_wD200GMSit.anm");
    
    --loop the idle animation
    ControllerSetLooping(controller_kenny_idle, true);
    
    --position him in the boat so hes properly sitting
    KTBM_SetAgentPosition("Kenny", Vector(0, 0.05, -0.8), KTBM_Cutscene_OpeningCutscene_kScene);
end

KTBM_Cutscene_OpeningCutscene_Update = function()
    KTBM_Cutscene_Skip_Update();

    if(KTBM_Cutscene_Skip_Skipped == true) then
        OverlayShow("ui_loadingScreen.overlay", true);
        SubProject_Switch("Menu", "KTBM_Level_Game.lua");

        return;
    end

    local number_currentGameTime = GetTotalTime();

    if(number_currentGameTime > number_sceneStartTime + 1.0) then
        if(bool_trigger_cutsceneStart == false) then


            bool_trigger_cutsceneStart = true;
        end
    end

    if(number_currentGameTime > number_sceneStartTime + 6.0) then
        if(bool_trigger_loadGame == false) then
            OverlayShow("ui_loadingScreen.overlay", true);
            SubProject_Switch("Menu", "KTBM_Level_Game.lua");

            bool_trigger_loadGame = true;
        end
    end

    --screen pos notes
    --0.0 0.0 0.0 = top left
    --0.5 0.5 0.0 = center
    --0.0 1.0 0.0 = bottom left
    AgentSetWorldPosFromLogicalScreenPos(agent_tempText, Vector(0.5, 0.5, 0.0));
end

local animclips_kenny_eyeDarts = 
{
    "kenny200_face_eyeDartsA_add.anm",
    "kenny200_face_eyeDartsB_add",
    "kenny200_face_eyeDartsC_add"
};

local animclips_kenny_headGestures = 
{
    "wd200GM_headGesture_tiltLeftA_add.anm",
    "wd200GM_headGesture_tiltLeftB_add.anm",
    "wd200GM_headGesture_tiltRightA_add.anm",
    "wd200GM_headGesture_tiltRightB_add.anm",
    "wd200GM_headGesture_lookRight_add.anm",
    "wd200GM_headGesture_lookUp_add.anm",
    "wd200GM_headGesture_lookDown_add.anm"
};

local animclips_kenny_leans = 
{
    "sk54_kenny200SitCouch_leanFwd_add.anm",
    "sk54_kenny200SitCouch_leanLeft_add.anm",
    "sk54_kenny200SitCouch_leanRight_add.anm"
};

local choreclips_kenny_emotions = 
{
    "sk54_kenny200_toHappyA",
    "sk54_kenny200_toHappyB",
    "sk54_kenny200_toHappyC"
};

--local choreclips_kenny_emotions = 
--{
--    "sk54_kenny200_toHappyA",
--    "sk54_kenny200_toHappyB",
--    "sk54_kenny200_toHappyC",
--    "sk54_kenny200_toNormalA",
--    "sk54_kenny200_toNormalB"
--};

local tick_kenny_idle_blink = 0;
local tick_kenny_idle_eyeDart = 0;
local tick_kenny_idle_headGestures = 0;
local tick_kenny_idle_leans = 0;
local tick_kenny_idle_emotion = 0;

local maxTick_kenny_idle_blink = 100;
local maxTick_kenny_idle_eyeDart = 250;
local maxTick_kenny_idle_headGestures = 250;
local maxTick_kenny_idle_leans = 275;
local maxTick_kenny_idle_emotion = 200;

KTBM_Cutscene_OpeningCutscene_UpdateKennyIdleAnimation = function()
    --update our tick rates
    tick_kenny_idle_blink = tick_kenny_idle_blink + 1;
    tick_kenny_idle_eyeDart = tick_kenny_idle_eyeDart + 1;
    tick_kenny_idle_headGestures = tick_kenny_idle_headGestures + 1;
    tick_kenny_idle_leans = tick_kenny_idle_leans + 1;
    tick_kenny_idle_emotion = tick_kenny_idle_emotion + 1;

    --if the tick rate for blinks is greater than the max, time to play an animation
    if(tick_kenny_idle_blink > maxTick_kenny_idle_blink) then
        local blinkController = PlayAnimation(kenny_agent, "kenny_face_blinkNormal_add.anm");
        ControllerSetLooping(blinkController, false);
        
        --reset so this only is played once (until its played again later)
        tick_kenny_idle_blink = 0;
    end
    
    --if the tick rate for eye darts is greater than the max, time to play an animation
    if(tick_kenny_idle_eyeDart > maxTick_kenny_idle_eyeDart) then
        local randomEyeDartClipIndex = math.random(1, #animclips_kenny_eyeDarts);
        local eyeDartClip = animclips_kenny_eyeDarts[randomEyeDartClipIndex];
        
        local eyeDartController = PlayAnimation(kenny_agent, eyeDartClip);
        ControllerSetLooping(eyeDartController, false);
        
        --reset so this only is played once (until its played again later)
        tick_kenny_idle_eyeDart = 0;
    end
    
    --if the tick rate for eye darts is greater than the max, time to play an animation
    if(tick_kenny_idle_headGestures > maxTick_kenny_idle_headGestures) then
        local randomHeadGestureClipIndex = math.random(1, #animclips_kenny_headGestures);
        local headGestureClip = animclips_kenny_headGestures[randomHeadGestureClipIndex];
        
        local headGestureController = PlayAnimation(kenny_agent, headGestureClip);
        ControllerSetLooping(headGestureController, false);
        
        --reset so this only is played once (until its played again later)
        tick_kenny_idle_headGestures = 0;
    end
    
    --if the tick rate for eye darts is greater than the max, time to play an animation
    if(tick_kenny_idle_leans > maxTick_kenny_idle_leans) then
        local randomLeansClipIndex = math.random(1, #animclips_kenny_leans);
        local leanClip = animclips_kenny_leans[randomLeansClipIndex];
        
        local leanController = PlayAnimation(kenny_agent, leanClip);
        ControllerSetLooping(leanController, false);
        
        --reset so this only is played once (until its played again later)
        tick_kenny_idle_leans = 0;
    end
    
    --if the tick rate for eye darts is greater than the max, time to play an animation
    if(tick_kenny_idle_emotion > maxTick_kenny_idle_emotion) then
        local randomEmotionsClipIndex = math.random(1, #choreclips_kenny_emotions);
        local emotionClip = choreclips_kenny_emotions[randomEmotionsClipIndex];

        local emotionController = KTBM_ChorePlayOnAgent(emotionClip, kenny_agent, nil, nil);
        ControllerSetLooping(emotionController, false);
        
        --reset so this only is played once (until its played again later)
        tick_kenny_idle_emotion = 0;
    end
end

local voiceLineTick = 0;
local maxVoiceLineTick = 19200;

KTBM_Cutscene_OpeningCutscene_KennyVoiceLineTest = function()
    voiceLineTick = voiceLineTick + 1;

    if(voiceLineTick == 300) then
        KTBM_Cutscene_PlayVoiceLine(kenny_agent, "310415606", 2.0, 1.0);
    end
    
    if(voiceLineTick == 600) then
        KTBM_Cutscene_PlayVoiceLine(kenny_agent, "310415609", 5.0, 1.0);
    end
    
    if(voiceLineTick == 1200) then
        KTBM_Cutscene_PlayVoiceLine(kenny_agent, "310415610", 2.0, 1.0);
    end
end



--proceudal boat buoyancy animation variables
local boatBuoyancy_currentRotation = Vector(0, 0, 0);
local boatBuoyancy_level1 = Vector(0, 0, 0);
local boatBuoyancy_level2 = Vector(0, 0, 0);
local boatBuoyancy_level3 = Vector(0, 0, 0);
local boatBuoyancy_level4 = Vector(0, 0, 0);

KTBM_Cutscene_OpeningCutscene_Animation_UpdateBoatBuoyancy = function()
    local totalShakeAmount = 0.55;
    local number_frameTime = GetFrameTime();

    ------------------------------------------
    boatBuoyancy_level1.x = boatBuoyancy_level1.x + (number_frameTime * 1.5);
    boatBuoyancy_level2.x = boatBuoyancy_level2.x + (number_frameTime * 2.5);

    local level1_x = math.sin(boatBuoyancy_level1.x) * 0.3;
    local level2_x = math.sin(boatBuoyancy_level2.x) * 0.05;

    local totalX = level1_x - level2_x;
    totalX = totalX * totalShakeAmount;

    ------------------------------------------
    boatBuoyancy_level1.y = boatBuoyancy_level1.y + (number_frameTime * 1.5);
    boatBuoyancy_level2.y = boatBuoyancy_level2.y + (number_frameTime * 2.5);

    local level1_y = math.sin(boatBuoyancy_level1.y) * 0.3;
    local level2_y = math.sin(boatBuoyancy_level2.y) * 0.05;

    local totalY = level1_y + level2_y;
    totalY = totalY * totalShakeAmount;

    ------------------------------------------
    boatBuoyancy_level1.z = boatBuoyancy_level1.z + (number_frameTime * 0.5);
    boatBuoyancy_level2.z = boatBuoyancy_level2.z + (number_frameTime * 2.5);

    local level1_z = math.sin(boatBuoyancy_level1.z) * 0.15;
    local level2_z = math.sin(boatBuoyancy_level2.z) * 0.1;

    local totalZ = level1_z - level2_z;
    totalZ = totalZ * totalShakeAmount;

    ------------------------------------------
    boatBuoyancy_currentRotation = Vector(totalX, totalY, totalZ);

    --apply the animations to the boat animation group
    KTBM_SetAgentRotation("BoatAnimGroup", boatBuoyancy_currentRotation, KTBM_Cutscene_OpeningCutscene_kScene);
end

--proceudal handheld camera animation variables
local handheldCamera_currentRotation = Vector(0, 0, 0);
local handheldCamera_level1 = Vector(0, 0, 0);
local handheldCamera_level2 = Vector(0, 0, 0);
local handheldCamera_level3 = Vector(0, 0, 0);
local handheldCamera_level4 = Vector(0, 0, 0);

KTBM_Cutscene_OpeningCutscene_Animation_UpdateHandheldCamera = function()
    local totalShakeAmount = 0.55;
    local number_frameTime = GetFrameTime();

    ------------------------------------------
    handheldCamera_level1.x = handheldCamera_level1.x + (number_frameTime * 1.0);
    handheldCamera_level2.x = handheldCamera_level2.x + (number_frameTime * 2.0);

    local level1_x = math.sin(handheldCamera_level1.x) * 0.3;
    local level2_x = math.sin(handheldCamera_level2.x) * 0.05;

    local totalX = level1_x + level2_x;
    totalX = totalX * totalShakeAmount;

    ------------------------------------------
    handheldCamera_level1.y = handheldCamera_level1.y + (number_frameTime * 1.0);
    handheldCamera_level2.y = handheldCamera_level2.y + (number_frameTime * 2.0);

    local level1_y = math.sin(handheldCamera_level1.y) * 0.3;
    local level2_y = math.sin(handheldCamera_level2.y) * 0.05;

    local totalY = level1_y - level2_y;
    totalY = totalY * totalShakeAmount;

    ------------------------------------------
    handheldCamera_level1.z = handheldCamera_level1.z + (number_frameTime * 0.25);
    handheldCamera_level2.z = handheldCamera_level2.z + (number_frameTime * 2.0);

    local level1_z = math.sin(handheldCamera_level1.z) * 0.15;
    local level2_z = math.sin(handheldCamera_level2.z) * 0.1;

    local totalZ = level1_z + level2_z;
    totalZ = totalZ * totalShakeAmount;

    ------------------------------------------
    --handheldCamera_currentRotation = Vector(totalX, totalY, totalZ);

    handheldCamera_currentRotation.x = totalX + -1.833327;
    handheldCamera_currentRotation.y = totalY + 168.750092;
    handheldCamera_currentRotation.z = totalZ + 0.0;

    --apply the animations to the boat animation group
    KTBM_SetAgentRotation("myMenuCamera", handheldCamera_currentRotation, KTBM_Cutscene_OpeningCutscene_kScene);
end