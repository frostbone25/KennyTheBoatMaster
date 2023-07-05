require("KTBM_Cutscene_Utilities.lua");

local controller_music = nil;
local controller_sound_sceneAmbient = nil;
local controller_sound_zombieKill = nil;
local controller_sound_zombieDeathVoice = nil;
local agent_kenny = nil;

local strings_zombieDeathVoiceSounds = {
    "vox_susan_hit_2_alt10.wav",
    "vox_susan_hit_2_alt8.wav",
    "vox_susan_hit_2_alt1.wav",
    "vox_susan_hit_2_alt6.wav",
    "vox_susan_hit_2_alt9.wav",
    "vox_susan_hit_2_alt7.wav",
    "vox_susan_hit_2_alt11.wav",
    "vox_susan_hit_2_alt2.wav",
    "vox_susan_hit_2_alt5.wav",
    "vox_susan_hit_2_alt4.wav",
    "vox_susan_hit_2_alt3.wav",
    "vox_susan_hit_2_alt12.wav",
    "vox_zomb_will_death_1.wav",
    "vox_zomb_nickM_death_6.wav",
    "vox_zomb_mark_death1.wav"
};

--main function that prepares the level enviorment
KTBM_Cutscene_Game_Start = function(kScene)
    --------------------------------------------------------
    --prepare our boat
    
    --reset the position and rotation on our boat
    local boat_agent = AgentFindInScene("obj_boatMotorChesapeake", kScene);
    KTBM_SetAgentWorldPosition("obj_boatMotorChesapeake", Vector(0,0,0), kScene);
    KTBM_SetAgentWorldRotation("obj_boatMotorChesapeake", Vector(0,0,0), kScene);
    
    local controller_boatObj_idle = PlayAnimation(boat_agent, "obj_boatMotorChesapeake_sk54_idle_zacharySitDriveBoat.anm");
    
    --loop the idle animation
    ControllerSetLooping(controller_boatObj_idle, true);

    --spawn the legend himself, kenny, into the scene
    agent_kenny = AgentFindInScene("Kenny", kScene);
    KTBM_AgentSetProperty("Kenny", "Walk Animation - Idle", nil, kScene)
    --KTBM_AgentSetProperty("Kenny", "Eye Look-At Properties", nil, kScene)
    KTBM_AgentSetProperty("Kenny", "Walk Animation - Eyes", nil, kScene)
    KTBM_AgentSetProperty("Kenny", "Walk Animation - Forward", nil, kScene)
    KTBM_AgentSetProperty("Kenny", "Walk Animation - Idle Face", nil, kScene)
    --KTBM_AgentSetProperty("Kenny", "Walk Animator - Enabled", false, kScene)
    --KTBM_AgentSetProperty("Kenny", "talking", false, kScene)

    --get rid of any existing controllers he might have on him
    local kenny_originalControllers = AgentGetControllers(agent_kenny);
    
    for i, controllerItem in ipairs(kenny_originalControllers) do
        ControllerSetLooping(controllerItem, false);
        --ControllerStop(controllerItem); --this breaks lipsync (fixes face idles though)
        --ControllerKill(controllerItem); --this breaks lipsync (fixes face idles though)
    end

    --were going to create a (group) and have both kenny and the boat attached to it
    --this will make it easier to move both around, but also being able to do bouyancy animation
    
    --create the group agent
    --local boat_group1_agent = AgentCreate("BoatGroup", "group.prop", Vector(0,0,0), Vector(0,0,0), kScene, false, false);
    --local boat_group2_agent = AgentCreate("BoatAnimGroup", "group.prop", Vector(0,0,0), Vector(0,0,0), kScene, false, false);
    
    
    --local boatWakeFX_agent = AgentCreate("boatWakeFX", "fx_waterBoatWake.prop", Vector(0,0.2,0), Vector(0,0,0), kScene, false, false);
    
    --local rockTest_agent = AgentCreate("rockTest", "obj_rockA.prop", Vector(0,0,4), Vector(0,0,0), kScene, false, false);
    --local rockTest_agent = AgentCreate("rockTest", "obj_rockB.prop", Vector(0,0,4), Vector(0,0,0), kScene, false, false);
    --local rockTest_agent = AgentCreate("rockTest", "obj_rockC.prop", Vector(0,0,4), Vector(0,0,0), kScene, false, false);
    --local rockTest_agent = AgentCreate("rockTest", "obj_rockBoulderHiRez.prop", Vector(0,0,4), Vector(0,0,0), kScene, false, false); --massive rock
    --local rockTest_agent = AgentCreate("rockTest", "obj_rockBoulderTrainStationHillA.prop", Vector(0,0,4), Vector(0,0,0), kScene, false, false); --massive rock
    
    --KTBM_AgentSetProperty("rockTest", "Render Global Scale", 2.0, kScene)
    --KTBM_AgentSetProperty("rockTest", "Render Cull", false, kScene)
    
    --attach both kenny and the boat itself to this group, effectively combining it into one
    --and attach it to the anim group first so we can do bouy/boat animations and have everything in the boat be affected.
    --AgentAttach(boatWakeFX_agent, boat_group2_agent);
    
    --------------------------------------------------------
    --create our audio
    
    --set our soundtrack
    controller_music = SoundPlay("mus_loop_action_11.wav");
    ControllerSetLooping(controller_music, true);
    ControllerSetSoundVolume(controller_music, 1.0);
    ControllerFadeIn(controller_music, 2.0);
    
    --do scene ambient sound
    controller_sound_sceneAmbient = SoundPlay("amb_river_shore_calm_water.wav");
    ControllerSetLooping(controller_sound_sceneAmbient, true);
    ControllerSetSoundVolume(controller_sound_sceneAmbient, 0.25);
    ControllerFadeIn(controller_sound_sceneAmbient, 2.0);
    
    --------------------------------------------------------
    --prepare kennys base idle animations
    
    --play a sitting animation
    --local controller_kenny_idle = PlayAnimation(agent_kenny, "sk54_idle_wD200GMSit.anm");
    local controller_kenny_idle = PlayAnimation(agent_kenny, "Zachary_sk54_idle_zacharySitDriveBoat.anm");
    
    --loop the idle animation
    ControllerSetLooping(controller_kenny_idle, true);
    
    --for some reason since his position is overriden once I play the animation, I can atleast scale him a bit so his hand properly lines up with the steering stick of the boat motor
    KTBM_AgentSetProperty("Kenny", "Render Global Scale", 0.9, kScene)
    
end

KTBM_Cutscene_Game_End = function(kScene)
    ControllerFadeOut(controller_music, 1.0);
    ControllerFadeOut(controller_sound_sceneAmbient, 1.0);
    --ControllerKill(controller_music);
    --ControllerKill(controller_sound_sceneAmbient);
end

local strings_voiceLinesAfterZombieKill = {
    "308285656", --101 - "you're a prick"
    "308285662", --101 - "murdering a bunch of folks don't make ya tough"
    "308285737", --101 - "ah screw you"
    "308285980", --101 - "there we go!"
    "308286078", --101 - "i'm not lettin sombody else get eaten today"
    "310391163", --102 - "lets go lets go!"
    "310498920", --102 - "nice air"
    "310521905", --102 - "i'm gettin sick of this shit"
    "310657067", --102 - "you're so full of bullshit"
    "312492120", --103 - "got em"
    "312492127", --103 - "lets go!"
    "312504622", --103 - "your wasting my time here"
    "312537212", --103 - "ugh this dumb fuck walker"
    "312537222", --103 - "gah there we go you ugly shit"
    "312537247", --103 - "there! i got em"
    "312590970", --103 - "lets fuckin enjoy this"
    "312591173", --103 - "thats the spirit"
    "312591765", --103 - "now we're talkin"
    "312594891", --103 - "you smug son of a bitch"
    "312594940", --103 - "just leave me the fuck alone!"
    "312700930", --103 - "fuuuuuck youuuuu"
    "312700937", --103 - "this aint shit"
    "312701387", --103 - "fuuuuuuuuuuck youuuuuuuuuuuuuuuu"
    "314593309", --104 - "hey, fuck you!"
    "314724360", --104 - "motherfucker"
    "316744386" --105 - "i gotcha"
};

KTBM_Cutscene_Game_PlayVoiceLineAfterZombieKill = function()
    if not (KTBM_Gameplay_Stats_ZombiesKilled % 5 == 0) then
        return
    end

    local number_randomClip = KTBM_RandomIntegerValue(1, #strings_voiceLinesAfterZombieKill);
    local string_voiceLineAfterZombieKill = strings_voiceLinesAfterZombieKill[number_randomClip];

    KTBM_Cutscene_PlayVoiceLine(agent_kenny, string_voiceLineAfterZombieKill, 1.0, 1.0);
end

KTBM_Cutscene_Game_PlayZombieKill = function(agent_zombie)
    if(controller_sound_zombieKill ~= nil) then
        ControllerKill(controller_sound_zombieKill);
        controller_sound_zombieKill = nil;
    end

    if(controller_sound_zombieDeathVoice ~= nil) then
        ControllerKill(controller_sound_zombieDeathVoice);
        controller_sound_zombieDeathVoice = nil;
    end

    controller_sound_zombieKill = SoundPlay("KTBM_Sound_KillZombie.wav");
    ControllerSetLooping(controller_sound_zombieKill, false);
    ControllerSetSoundVolume(controller_sound_zombieKill, 1.0);

    local number_randomClip = KTBM_RandomIntegerValue(1, #strings_zombieDeathVoiceSounds);
    local string_zombieDeathVoice = strings_zombieDeathVoiceSounds[number_randomClip];
    controller_sound_zombieDeathVoice = SoundPlay(string_zombieDeathVoice);
    ControllerSetLooping(controller_sound_zombieDeathVoice, false);
    ControllerSetSoundVolume(controller_sound_zombieDeathVoice, 0.25);


    local controllers_zombieControllers = AgentGetControllers(agent_zombie);
    
    for index, controller_item in ipairs(controllers_zombieControllers) do
        ControllerKill(controller_item);
    end
end