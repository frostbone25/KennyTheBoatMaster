require("KTBM_Cutscene_Utilities.lua");

KTBM_Cutscene_Menu_PrepareCamera = function()
    local cam_prop = "module_camera.prop";
    
    local newPosition = Vector(-0.827604, 0.902787, 1.085702);
    local newRotation = Vector(-1.833327, 168.750092, 0.0);
    
    local cameraAgent = AgentCreate("myMenuCamera", cam_prop, newPosition, newRotation, KTBM_Cutscene_Menu_kScene, false, false);
    
    KTBM_AgentSetProperty("myMenuCamera", "Clip Plane - Far", 2500, KTBM_Cutscene_Menu_kScene);
    KTBM_AgentSetProperty("myMenuCamera", "Clip Plane - Near", 0.05, KTBM_Cutscene_Menu_kScene);
    KTBM_AgentSetProperty("myMenuCamera", "Lens - Current Lens", nil, KTBM_Cutscene_Menu_kScene);

    KTBM_RemovingAgentsWithPrefix(KTBM_Cutscene_Menu_kScene, "cam_");

    CameraPush("myMenuCamera");
    --CameraActivate("myMenuCamera");
end

local controller_music = nil;
local controller_sound_sceneAmbient = nil;
local controller_kenny_idle = nil;
local agent_kenny = nil;

local number_sceneStartTime = 0;

--main function that prepares the level enviorment
KTBM_Cutscene_Menu_Build = function()
    KTBM_Costumes_Boat_Build(KTBM_Cutscene_Menu_kScene);
    KTBM_Costumes_Kenny_AddToBoat(KTBM_Cutscene_Menu_kScene);

    --------------------------------------------------------
    --create our audio
    
    --set our soundtrack
    controller_music = SoundPlay("mus_linear_intro_lakeBridgeApproach.wav");
    ControllerSetLooping(controller_music, true);
    ControllerSetSoundVolume(controller_music, 0.5);
    ControllerFadeIn(controller_music, 2.0);
    
    --do scene ambient sound
    controller_sound_sceneAmbient = SoundPlay("KTBM_Sound_MenuAmbience.wav");
    ControllerSetLooping(controller_sound_sceneAmbient, true);
    ControllerSetSoundVolume(controller_sound_sceneAmbient, 1.0);
    ControllerFadeIn(controller_sound_sceneAmbient, 2.0);
    
    --------------------------------------------------------
    --prepare kennys base idle animations

    agent_kenny = AgentFindInScene("Kenny", KTBM_Cutscene_Menu_kScene);

    --play a sitting animation
    controller_kenny_idle = PlayAnimation(agent_kenny, "sk54_idle_wD200GMSit.anm");
    
    --loop the idle animation
    ControllerSetLooping(controller_kenny_idle, true);
    
    --position him in the boat so hes properly sitting
    KTBM_SetAgentPosition("Kenny", Vector(0, 0.05, -0.8), KTBM_Cutscene_Menu_kScene);

    number_sceneStartTime = GetTotalTime();
end

local strings_kennyEyeDartAnimations = 
{
    "kenny200_face_eyeDartsA_add.anm",
    "kenny200_face_eyeDartsB_add",
    "kenny200_face_eyeDartsC_add"
};

local strings_kennyHeadGesturesAnimations = 
{
    "wd200GM_headGesture_tiltLeftA_add.anm",
    "wd200GM_headGesture_tiltLeftB_add.anm",
    "wd200GM_headGesture_tiltRightA_add.anm",
    "wd200GM_headGesture_tiltRightB_add.anm",
    "wd200GM_headGesture_lookRight_add.anm",
    "wd200GM_headGesture_lookUp_add.anm",
    "wd200GM_headGesture_lookDown_add.anm"
};

local strings_kennyLeansAnimations = 
{
    "sk54_kenny200SitCouch_leanFwd_add.anm",
    "sk54_kenny200SitCouch_leanLeft_add.anm",
    "sk54_kenny200SitCouch_leanRight_add.anm"
};

local strings_kennyEmotionsChoreClips = 
{
    "sk54_kenny200_toHappyA",
    "sk54_kenny200_toHappyB",
    "sk54_kenny200_toHappyC"
--    "sk54_kenny200_toNormalA"
--    "sk54_kenny200_toNormalB"
};


local bool_doIntroductionVoiceLines = true;
local bool_marker_voiceLine1 = false;
local bool_marker_voiceLine2 = false;
local bool_marker_voiceLine3 = false;
local bool_introductionVoiceLinesComplete = false;

local number_blinkTime = 2.5;
local number_nextBlinkTime = 0;

local number_randomEmotionTime = 5.0;
local number_randomEmotionNextTime = 0;

local number_randomEyeDartsTime = 6.5;
local number_randomEyeDartsNextTime = 0;

local number_randomHeadGestureTime = 3.5;
local number_randomHeadGestureNextTime = 0;

local number_randomLeansTime = 4.5;
local number_randomLeansNextTime = 0;

--102 - 308617547 - "thats what i'm thinkin"
--102 - 310411539 - "you found it too eh?"
--102 - 310416205 - "I could eat a horse"
--102 - 310480962 - "so, uh... whats up?"
--102 - 310522918 - "you might earn yourself a place on the rv after all"
--103 - 312483841 - "looks like this is our lucky day"
--103 - 312504603 - "i apprecaite it though"
--103 - 312705025 - "next stop, the atlantic"
--103 - 314720438 - "what about the boat?"

local bool_kennyVoiceLineQuip_browsingBoatSkins = false;
local bool_kennyVoiceLineQuip_browsingKennySkins = false;
local bool_kennyVoiceLineQuip_leavingKennySkins = false;

KTBM_Cutscene_Menu_PlayVoiceLine_BrowsingBoatSkins = function()
    if(bool_kennyVoiceLineQuip_browsingBoatSkins == false) and (bool_introductionVoiceLinesComplete == true) then
        KTBM_Cutscene_PlayVoiceLine(agent_kenny, "314609782", 1.0, 1.0); --103 - 314609782 - "oh yeah? know alot about boats do ya?"

        bool_kennyVoiceLineQuip_browsingBoatSkins = true;
    end
end

KTBM_Cutscene_Menu_PlayVoiceLine_BrowsingKennySkins = function()
    if(bool_kennyVoiceLineQuip_browsingKennySkins == false) and (bool_introductionVoiceLinesComplete == true) then
        KTBM_Cutscene_PlayVoiceLine(agent_kenny, "310419862", 1.0, 1.0); --102 - 310419862 - "you got any ideas?"

        bool_kennyVoiceLineQuip_browsingKennySkins = true;
    end
end

KTBM_Cutscene_Menu_PlayVoiceLine_LeavingKennySkins = function()
    if(bool_kennyVoiceLineQuip_leavingKennySkins == false) and (bool_introductionVoiceLinesComplete == true) then
        KTBM_Cutscene_PlayVoiceLine(agent_kenny, "312484054", 1.0, 1.0); --103 - 312484054 - "you made up your mind yet?"

        bool_kennyVoiceLineQuip_leavingKennySkins = true;
    end
end

KTBM_Cutscene_Menu_Update = function()
    local number_currentDeltaTime = GetFrameTime();
    local number_currentTotalGameTime = GetTotalTime();

    ----------------------------------------------
    if(number_currentTotalGameTime > number_nextBlinkTime) then
        local controller_blink = PlayAnimation(agent_kenny, "kenny_face_blinkNormal_add.anm");
        ControllerSetLooping(controller_blink, false);
        ControllerSetContribution(controller_blink, 1.0);

        number_nextBlinkTime = number_currentTotalGameTime + number_blinkTime;
    end

    if(number_currentTotalGameTime > number_randomEmotionNextTime) then
        local number_randomEmotionsClipIndex = math.random(1, #strings_kennyEmotionsChoreClips);
        local string_kennyEmotionsChoreClip = strings_kennyEmotionsChoreClips[number_randomEmotionsClipIndex];

        local controller_emotion = KTBM_ChorePlayOnAgent(string_kennyEmotionsChoreClip, agent_kenny, nil, nil);
        ControllerSetLooping(controller_emotion, false);
        ControllerFadeIn(controller_emotion, 2.0);

        number_randomEmotionNextTime = number_currentTotalGameTime + number_randomEmotionTime;
    end

    if(number_currentTotalGameTime > number_randomEyeDartsNextTime) then
        local number_randomEyeDartClipIndex = math.random(1, #strings_kennyEyeDartAnimations);
        local string_kennyEyeDartAnimation = strings_kennyEyeDartAnimations[number_randomEyeDartClipIndex];
        
        local controller_eyeDart = PlayAnimation(agent_kenny, string_kennyEyeDartAnimation);
        ControllerSetLooping(controller_eyeDart, false);

        number_randomEyeDartsNextTime = number_currentTotalGameTime + number_randomEyeDartsTime;
    end

    if(number_currentTotalGameTime > number_randomHeadGestureNextTime) then
        local number_randomHeadGestureClipIndex = math.random(1, #strings_kennyHeadGesturesAnimations);
        local string_kennyHeadGesturesAnimation = strings_kennyHeadGesturesAnimations[number_randomHeadGestureClipIndex];
        
        local controller_headGesture = PlayAnimation(agent_kenny, string_kennyHeadGesturesAnimation);
        ControllerSetLooping(controller_headGesture, false);

        number_randomHeadGestureNextTime = number_currentTotalGameTime + number_randomHeadGestureTime;
    end

    if(number_currentTotalGameTime > number_randomLeansNextTime) then
        local number_randomLeansClipIndex = math.random(1, #strings_kennyLeansAnimations);
        local string_kennyLeanAnimation = strings_kennyLeansAnimations[number_randomLeansClipIndex];
        
        local controller_lean = PlayAnimation(agent_kenny, string_kennyLeanAnimation);
        ControllerSetLooping(controller_lean, false);

        number_randomLeansNextTime = number_currentTotalGameTime + number_randomLeansTime;
    end

    ----------------------------------------------
    if(bool_doIntroductionVoiceLines == true) then
        if(number_currentTotalGameTime > number_sceneStartTime + 4.0) then
            if(bool_marker_voiceLine1 == false) then
                KTBM_Cutscene_PlayVoiceLine(agent_kenny, "310415606", 2.0, 1.0);

                bool_marker_voiceLine1 = true;
            end
        end

        if(number_currentTotalGameTime > number_sceneStartTime + 10.0) then
            if(bool_marker_voiceLine2 == false) then
                KTBM_Cutscene_PlayVoiceLine(agent_kenny, "310415609", 5.0, 1.0);

                bool_marker_voiceLine2 = true;
            end
        end

        if(number_currentTotalGameTime > number_sceneStartTime + 21.0) then
            if(bool_marker_voiceLine3 == false) then
                KTBM_Cutscene_PlayVoiceLine(agent_kenny, "310415610", 2.0, 1.0);

                bool_introductionVoiceLinesComplete = true;
                bool_marker_voiceLine3 = true;
            end
        end
    else
        bool_introductionVoiceLinesComplete = true;
    end
end






--proceudal boat buoyancy animation variables
local boatBuoyancy_currentRotation = Vector(0, 0, 0);
local boatBuoyancy_level1 = Vector(0, 0, 0);
local boatBuoyancy_level2 = Vector(0, 0, 0);
local boatBuoyancy_level3 = Vector(0, 0, 0);
local boatBuoyancy_level4 = Vector(0, 0, 0);

KTBM_Cutscene_Menu_Animation_UpdateBoatBuoyancy = function()
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
    KTBM_SetAgentRotation("BoatAnimGroup", boatBuoyancy_currentRotation, KTBM_Cutscene_Menu_kScene);
end

--proceudal handheld camera animation variables
local handheldCamera_currentRotation = Vector(0, 0, 0);
local handheldCamera_level1 = Vector(0, 0, 0);
local handheldCamera_level2 = Vector(0, 0, 0);
local handheldCamera_level3 = Vector(0, 0, 0);
local handheldCamera_level4 = Vector(0, 0, 0);

KTBM_Cutscene_Menu_Animation_UpdateHandheldCamera = function()
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
    KTBM_SetAgentRotation("myMenuCamera", handheldCamera_currentRotation, KTBM_Cutscene_Menu_kScene);
end