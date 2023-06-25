require("KTBM_Cutscene_Skip.lua");

local controller_sound_sceneAmbient = nil;
local controller_sound_sequenceAudio = nil;
local number_cutsceneStartTime = 0;
local bool_startSequence = false;

--main function that prepares the level enviorment
KTBM_Cutscene_GameDeath_Start = function(kScene)
    KTBM_Cutscene_Skip_Build();

    local agent_boatGroupMain = AgentFindInScene("BoatGroup", kScene);
    local agent_boatGroupAnim = AgentFindInScene("BoatAnimGroup", kScene);
    local agent_boat = AgentFindInScene("obj_boatMotorChesapeake", kScene);
    local agent_kenny = AgentFindInScene("Kenny", kScene);

    local controllers_boat = AgentGetControllers(agent_boat);
    local controllers_kenny = AgentGetControllers(agent_kenny);
    
    for i, controller_item in ipairs(controllers_boat) do
        ControllerKill(controller_item);
    end

    local controllers_kenny = AgentGetControllers(agent_kenny);
    
    for i, controller_item in ipairs(controllers_kenny) do
        ControllerKill(controller_item);
    end

    --------------------------------------------------------
    --create our audio
    
    --do scene ambient sound
    controller_sound_sceneAmbient = SoundPlay("amb_river_shore_calm_water.wav");
    ControllerSetLooping(controller_sound_sceneAmbient, true);
    ControllerSetSoundVolume(controller_sound_sceneAmbient, 1.0);
    
    --do scene ambient sound
    controller_sound_sequenceAudio = SoundPlay("KTBM_Sound_InGameDeathSequenceAudio.wav");
    ControllerSetLooping(controller_sound_sequenceAudio, false);
    ControllerSetSoundVolume(controller_sound_sequenceAudio, 1.0);

    number_cutsceneStartTime = GetTotalTime();
    bool_startSequence = true;
end

KTBM_Cutscene_GameDeath_Update = function()
    if(bool_startSequence == false) then
        return;
    end

    KTBM_Cutscene_Skip_CanSkip = true;
    KTBM_Cutscene_Skip_Update();

    if(KTBM_Cutscene_Skip_Skipped == true) then
        ControllerKill(controller_sound_sceneAmbient);
        ControllerKill(controller_sound_sequenceAudio);

        KTBM_Cutscene_Skip_CutsceneFinished = true;

        return;
    end

    local number_currentGameTime = GetTotalTime();

    if(number_currentGameTime > number_cutsceneStartTime + 7.0) then
        KTBM_Cutscene_Skip_CutsceneFinished = true;
    end
end