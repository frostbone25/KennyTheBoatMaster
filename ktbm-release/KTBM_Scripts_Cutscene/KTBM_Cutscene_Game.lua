local controller_music = nil;
local controller_sound_sceneAmbient = nil;

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
    local agent_kenny = AgentFindInScene("Kenny", kScene);
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
    --ControllerSetSoundVolume(controller_music, 0.5);
    ControllerSetSoundVolume(controller_music, 7.0);
    
    --do scene ambient sound
    controller_sound_sceneAmbient = SoundPlay("amb_river_shore_calm_water.wav");
    ControllerSetLooping(controller_sound_sceneAmbient, true);
    ControllerSetSoundVolume(controller_sound_sceneAmbient, 0.25);
    
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
    ControllerKill(controller_music);
    ControllerKill(controller_sound_sceneAmbient);
end