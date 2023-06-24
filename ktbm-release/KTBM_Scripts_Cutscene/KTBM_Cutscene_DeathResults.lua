require("KTBM_Cutscene_Utilities.lua");
require("KTBM_Cutscene_Skip.lua");

KTBM_Cutscene_DeathResults_PrepareCamera = function()
    local cam_prop = "module_camera.prop";
    
    local newPosition = Vector(0.4577, 1.5724, 0.0);
    local newRotation = Vector(0, -90, 0);
    
    local cameraAgent = AgentCreate("myMenuCamera", cam_prop, newPosition, newRotation, KTBM_Cutscene_DeathResults_kScene, false, false);
    
    KTBM_AgentSetProperty("myMenuCamera", "Clip Plane - Far", 2500, KTBM_Cutscene_DeathResults_kScene);
    KTBM_AgentSetProperty("myMenuCamera", "Clip Plane - Near", 0.05, KTBM_Cutscene_DeathResults_kScene);
    KTBM_AgentSetProperty("myMenuCamera", "Lens - Current Lens", nil, KTBM_Cutscene_DeathResults_kScene);
    KTBM_AgentSetProperty("myMenuCamera", "Field of View", 50, KTBM_Cutscene_DeathResults_kScene);

    KTBM_RemovingAgentsWithPrefix(KTBM_Cutscene_DeathResults_kScene, "cam_");

    CameraPush("myMenuCamera");
    --CameraActivate("myMenuCamera");
end

local agent_kenny = nil;
local agent_kennyParent = nil;

local bool_marker_kennyPunchCamera = false;
local bool_marker_playCutsceneAudio = false;
local bool_marker_showStagedScene = false;

local number_sceneStartTime = 0;
local controller_kenny_running = nil;
local controller_kenny_punch = nil;

local controller_cutsceneAudio = nil;
local controller_fireAmbience = nil;
--local controller_

--main function that prepares the level enviorment
KTBM_Cutscene_DeathResults_Build = function()
    KTBM_Cutscene_Skip_Build();
    KTBM_Costumes_Kenny_AddToScene(KTBM_Cutscene_DeathResults_kScene);

    agent_kenny = AgentFindInScene("Kenny", KTBM_Cutscene_DeathResults_kScene);
    agent_kennyParent = AgentCreate("agent_kennyParent", "group.prop", Vector(0, 0, 0), Vector(0, 0, 0), KTBM_Cutscene_DeathResults_kScene, false, false);

    AgentAttach(agent_kenny, agent_kennyParent);

    -----------------------------------------------
    local controllersTable_character = AgentGetControllers(agent_kenny);
    
    for i, cnt in ipairs(controllersTable_character) do
        ControllerKill(cnt);
    end

    --sk54_action_carverPunchesCarlos.anm
    --sk54_kenny_run
    --sk54_wd200GM_walkFast
    --sk54_wd200GM_run
    controller_kenny_running = PlayAnimation(agent_kenny, "sk54_wd200GM_run.anm");

    --PlayAnimation(agent_kenny, "kenny200_face_squint_add.anm");
    --kenny200_face_squint_add
    
    --loop the idle animation
    ControllerSetLooping(controller_kenny_running, true);

    --sk54_kenny200_toAngryA
    --sk54_kenny200_toAngryB
    --sk54_kenny200_toAngryC
    --sk54_kenny200_toAngryCX
    local emotionController = KTBM_ChorePlayOnAgent("sk54_kenny200_toAngryA.chore", agent_kenny, nil, nil);
    ControllerSetLooping(emotionController, true);
    
    --position him in the boat so hes properly sitting
    KTBM_SetAgentPosition("Kenny", Vector(0, 0, 0), KTBM_Cutscene_DeathResults_kScene);
    KTBM_SetAgentRotation("Kenny", Vector(0, 0, 0), KTBM_Cutscene_DeathResults_kScene);
    KTBM_SetAgentWorldPosition("agent_kennyParent", Vector(-15, 0, 0), KTBM_Cutscene_DeathResults_kScene);
    KTBM_SetAgentWorldRotation("agent_kennyParent", Vector(0, 90, 0), KTBM_Cutscene_DeathResults_kScene);

    -----------------------------------------------
    local agent_endScreenGroup = AgentCreate("agent_endScreenGroup", "group.prop", Vector(0, 0, 0), Vector(0, 0, 0), KTBM_Cutscene_DeathResults_kScene, false, false);
    local agent_boat = AgentCreate("agent_boat", "obj_boatMotorChesapeake.prop", Vector(0, 0, 0), Vector(0, 135, 0), KTBM_Cutscene_DeathResults_kScene, false, false);
    
    --fx_fireA_embers
    --fx_fireB_embers
    --fx_fireFireplaceLodge
    --fx_fireCampfireWD201Low
    --fx_fireOmni
    --fx_fireOmniWD3
    --fx_smokeCampfire201Emitter
    local agent_fireFX1 = AgentCreate("agent_fireFX1", "fx_fireOmniWD3.prop", Vector(-1.6, 0.89, 1.98), Vector(0, 0, 0), KTBM_Cutscene_DeathResults_kScene, false, false);
    KTBM_SetPropertyBySymbol(AgentGetRuntimeProperties(agent_fireFX1), "689599953923669477", true) --enable emitter

    local agent_fireFX2 = AgentCreate("agent_fireFX2", "fx_fireOmniWD3.prop", Vector(2, 0.1, -0.65), Vector(0, 0, 0), KTBM_Cutscene_DeathResults_kScene, false, false);
    KTBM_SetPropertyBySymbol(AgentGetRuntimeProperties(agent_fireFX2), "689599953923669477", true) --enable emitter
    
    local agent_fireFX3 = AgentCreate("agent_fireFX3", "fx_fireOmniWD3.prop", Vector(0.92, 0.71, -0.19), Vector(0, 0, 0), KTBM_Cutscene_DeathResults_kScene, false, false);
    KTBM_SetPropertyBySymbol(AgentGetRuntimeProperties(agent_fireFX3), "689599953923669477", true) --enable emitter

    local agent_fireFX4 = AgentCreate("agent_fireFX4", "fx_fireOmniWD3.prop", Vector(-1.8, 0.2, 2.44), Vector(0, 0, 0), KTBM_Cutscene_DeathResults_kScene, false, false);
    KTBM_SetPropertyBySymbol(AgentGetRuntimeProperties(agent_fireFX4), "689599953923669477", true) --enable emitter

    local agent_fireFX5 = AgentCreate("agent_fireFX5", "fx_fireOmniWD3.prop", Vector(1.6, 0.18, -2.5), Vector(0, 0, 0), KTBM_Cutscene_DeathResults_kScene, false, false);
    KTBM_SetPropertyBySymbol(AgentGetRuntimeProperties(agent_fireFX5), "689599953923669477", true) --enable emitter

    local agent_fireFX6 = AgentCreate("agent_fireFX6", "fx_fireOmniWD3.prop", Vector(1.7, 0.87, -2.52), Vector(0, 0, 0), KTBM_Cutscene_DeathResults_kScene, false, false);
    KTBM_SetPropertyBySymbol(AgentGetRuntimeProperties(agent_fireFX6), "689599953923669477", true) --enable emitter

    local agent_embersFX1 = AgentCreate("agent_embersFX1", "fx_fireB_embers.prop", Vector(-1.6, 0.89, 1.98), Vector(0, 0, 0), KTBM_Cutscene_DeathResults_kScene, false, false);
    KTBM_SetPropertyBySymbol(AgentGetRuntimeProperties(agent_embersFX1), "689599953923669477", true) --enable emitter

    local agent_embersFX2 = AgentCreate("agent_embersFX2", "fx_fireA_embers.prop", Vector(2, 0.1, -0.65), Vector(0, 0, 0), KTBM_Cutscene_DeathResults_kScene, false, false);
    KTBM_SetPropertyBySymbol(AgentGetRuntimeProperties(agent_embersFX2), "689599953923669477", true) --enable emitter

    local agent_embersFX3 = AgentCreate("agent_embersFX3", "fx_fireA_embers.prop", Vector(0.92, 0.71, -0.19), Vector(0, 0, 0), KTBM_Cutscene_DeathResults_kScene, false, false);
    KTBM_SetPropertyBySymbol(AgentGetRuntimeProperties(agent_embersFX3), "689599953923669477", true) --enable emitter

    local agent_embersFX4 = AgentCreate("agent_embersFX4", "fx_fireA_embers.prop", Vector(-1.8, 0.2, 2.44), Vector(0, 0, 0), KTBM_Cutscene_DeathResults_kScene, false, false);
    KTBM_SetPropertyBySymbol(AgentGetRuntimeProperties(agent_embersFX4), "689599953923669477", true) --enable emitter

    local agent_embersFX5 = AgentCreate("agent_embersFX5", "fx_fireB_embers.prop", Vector(1.6, 0.18, -2.5), Vector(0, 0, 0), KTBM_Cutscene_DeathResults_kScene, false, false);
    KTBM_SetPropertyBySymbol(AgentGetRuntimeProperties(agent_embersFX5), "689599953923669477", true) --enable emitter

    local agent_embersFX6 = AgentCreate("agent_embersFX6", "fx_fireA_embers.prop", Vector(1.7, 0.87, -2.52), Vector(0, 0, 0), KTBM_Cutscene_DeathResults_kScene, false, false);
    KTBM_SetPropertyBySymbol(AgentGetRuntimeProperties(agent_embersFX6), "689599953923669477", true) --enable emitter
    
    local agent_fireFX1_Light = KTBM_LevelRelight_M101_FlagshipExteriorDeck_SpawnSpotLight("agent_fireFX1_Light", Vector(-0.05, 3.43, 1.95), Vector(56.5, -90, 0), 25, 15, 45, 90, Color(1, 0.3, 0), KTBM_Cutscene_DeathResults_kScene);
    local agent_fireFX2_Light = KTBM_LevelRelight_M101_FlagshipExteriorDeck_SpawnPointLight("agent_fireFX2_Light", Vector(2, 0.1, -0.65), Vector(30.8, -71.8, 0), 55, 3.5, Color(1, 0.3, 0), KTBM_Cutscene_DeathResults_kScene);
    local agent_fireFX3_Light = KTBM_LevelRelight_M101_FlagshipExteriorDeck_SpawnPointLight("agent_fireFX3_Light", Vector(1.6, 0.18, -2.5), Vector(0, 0, 0), 55, 3.5, Color(1, 0.3, 0), KTBM_Cutscene_DeathResults_kScene);
    
    local agent_kennyLight1 = KTBM_LevelRelight_M101_FlagshipExteriorDeck_SpawnSpotLight("agent_kennyLight1", Vector(5, 1.89, 1.72), Vector(16.67, -126, 0), 3, 15, 45, 90, Color(1, 0.3, 0), KTBM_Cutscene_DeathResults_kScene);
    local agent_kennyLight2 = KTBM_LevelRelight_M101_FlagshipExteriorDeck_SpawnSpotLight("agent_kennyLight2", Vector(5, 1.89, 1.72), Vector(10, -131, 0), 10, 15, 15, 45, Color(1, 0.5, 0.25), KTBM_Cutscene_DeathResults_kScene);

    local water_agent = AgentCreate("obj_puddlePoolClemHouse400_mine", "obj_puddlePoolClemHouse400.prop", Vector(0.0, 0.1, 0.0), Vector(0,0,0), KTBM_Cutscene_DeathResults_kScene, false, false);
    local water_props = AgentGetRuntimeProperties(water_agent);
    
    KTBM_SetPropertyBySymbol(water_props, "1504390651565685996", 256); --wave-scale1
    KTBM_SetPropertyBySymbol(water_props, "15272138922562676569", 256); --wave-scale2
    KTBM_SetPropertyBySymbol(water_props, "4273370320593893048", 0.05); --wave-speed
    --KTBM_SetPropertyBySymbol(water_props, "4279570706014850606", 1); --wave-strength
    KTBM_SetPropertyBySymbol(water_props, "4857578369356927332", 0.5); --wave-strength2
    --KTBM_SetPropertyBySymbol(water_props, "5950422962495852891", 0.1); --water-speed2?
    KTBM_SetPropertyBySymbol(water_props, "5138029077440829486", 0.99); --water-roughness
    KTBM_SetPropertyBySymbol(water_props, "29917189130296323", true); --enable reflection map
    KTBM_SetPropertyBySymbol(water_props, "9318400394721951400", 0); --WATER-LIGHT-GROUP
    KTBM_SetPropertyBySymbol(water_props, "4524265211594962055", RGBColor(128, 178, 255, 255)); --reflection-color
    KTBM_SetPropertyBySymbol(water_props, "5066756895947174386", 2); --reflection-strength  
    --KTBM_SetPropertyBySymbol(water_props, "15065044257655169889", RGBColor(40, 40, 0, 255)); --refraction-color
    --KTBM_SetPropertyBySymbol(water_props, "9181020696151788533", -6); --refraction-water-fog-amount1
    --KTBM_SetPropertyBySymbol(water_props, "4847108626039527005", -5); --refraction-brightness
    --KTBM_SetPropertyBySymbol(water_props, "12012789014150368376", 5); --refraction-brightness2
    --KTBM_SetPropertyBySymbol(water_props, "13524572792830703280", 5); --refraction-brightness3
    KTBM_SetPropertyBySymbol(water_props, "13985881739645500197", 0.1); --refraction-strength
    KTBM_SetPropertyBySymbol(water_props, "9887842711884399492", false); --false - high quality, true - low quality? (on RiverShore201 seems to fix grass)
    KTBM_SetPropertyBySymbol(water_props, "12146612972960654343", false); --disable-refraction (on RiverShore201 seems to fix grass)
    KTBM_SetPropertyBySymbol(water_props, "13551425408333398071", false); --refraction-disable2
    --KTBM_SetPropertyBySymbol(water_props, "1964881308567356031", RGBColor(255, 255, 255, 255)); --foam-color
    --KTBM_SetPropertyBySymbol(water_props, "869772803424442523", 0.10102); --foam-stretch1
    KTBM_SetPropertyBySymbol(water_props, "6759651374164386688", 128); --foam-scale
    KTBM_SetPropertyBySymbol(water_props, "11159419739102705717", 128); --foam-scale2
    --KTBM_SetPropertyBySymbol(water_props, "14260522637935869462", 0); --foam-fade1
    KTBM_SetPropertyBySymbol(water_props, "14326746451085487896", -0.025); --foam-scroll-speed
    KTBM_SetPropertyBySymbol(water_props, "17818319915486731111", 0.1); --foam-coverage
    --KTBM_SetPropertyBySymbol(water_props, "17178421325407310363", 0.0001); --SHORE-FADE
    KTBM_SetPropertyBySymbol(water_props, "17178421325407310363", 0.0001); --SHORE-FADE
    KTBM_SetPropertyBySymbol(water_props, "17888434372283380553", 3.3); --water-clear-fade
    
    KTBM_AgentSetProperty("obj_puddlePoolClemHouse400_mine", "Runtime: Visible", true, KTBM_Cutscene_DeathResults_kScene);
    KTBM_AgentSetProperty("obj_puddlePoolClemHouse400_mine", "Render Global Scale", 200, KTBM_Cutscene_DeathResults_kScene);
    KTBM_AgentSetProperty("obj_puddlePoolClemHouse400_mine", "Render Cull", false, KTBM_Cutscene_DeathResults_kScene); --disable culling since when the object is super large it gets culled out of the screen noticably


    AgentAttach(agent_boat, agent_endScreenGroup);
    AgentAttach(water_agent, agent_endScreenGroup);
    AgentAttach(agent_fireFX1, agent_endScreenGroup);
    AgentAttach(agent_fireFX2, agent_endScreenGroup);
    AgentAttach(agent_fireFX3, agent_endScreenGroup);
    AgentAttach(agent_fireFX4, agent_endScreenGroup);
    AgentAttach(agent_fireFX5, agent_endScreenGroup);
    AgentAttach(agent_fireFX6, agent_endScreenGroup);

    AgentAttach(agent_embersFX1, agent_endScreenGroup);
    AgentAttach(agent_embersFX2, agent_endScreenGroup);
    AgentAttach(agent_embersFX3, agent_endScreenGroup);
    AgentAttach(agent_embersFX4, agent_endScreenGroup);
    AgentAttach(agent_embersFX5, agent_endScreenGroup);
    AgentAttach(agent_embersFX6, agent_endScreenGroup);

    AgentAttach(agent_fireFX1_Light, agent_endScreenGroup);
    AgentAttach(agent_fireFX2_Light, agent_endScreenGroup);
    AgentAttach(agent_fireFX3_Light, agent_endScreenGroup);

    AgentAttach(agent_kennyLight1, agent_endScreenGroup);
    AgentAttach(agent_kennyLight2, agent_endScreenGroup);

    AgentSetWorldPos(agent_endScreenGroup, Vector(0, -1000, 0));


    KTBM_AgentSetProperty("myMenuCamera", "Field of View", 50, KTBM_Cutscene_DeathResults_kScene);

    KTBM_AgentSetProperty("light_camera", "EnvLight - Intensity", 7, KTBM_Cutscene_DeathResults_kScene)
    KTBM_AgentSetProperty("light_D", "EnvLight - Intensity", 50, KTBM_Cutscene_DeathResults_kScene)

    KTBM_SetAgentWorldPosition("agent_endScreenGroup", Vector(0, -1000, 0), KTBM_Cutscene_DeathResults_kScene);

    -----------------------------------------------
    CursorHide(true);
    CursorEnable(true);

    number_sceneStartTime = GetTotalTime();
end

KTBM_Cutscene_DeathResults_Update = function()
    KTBM_Cutscene_Skip_Update();

    local cutSceneCamera = AgentFindInScene("myMenuCamera", KTBM_Cutscene_DeathResults_kScene);

    agent_kenny = AgentFindInScene("Kenny", KTBM_Cutscene_DeathResults_kScene);

    local lockedPos = VectorScale(Vector(0,0,0), AgentGetForwardAnimVelocity(agent_kenny));
    local currentPos = AgentGetWorldPos(agent_kennyParent);

    AgentSetPos(agent_kenny, lockedPos);
    AgentSetPos(agent_kenny, Vector(0,0,0));
    KTBM_SetAgentPosition("Kenny", lockedPos, KTBM_Cutscene_DeathResults_kScene);

    ----------------------------------------------------------
    if(KTBM_Cutscene_Skip_Skipped == true) then
        if(bool_marker_showStagedScene == false) then
            ControllerKill(controller_cutsceneAudio);

            local controllersTable_character = AgentGetControllers(agent_kenny);
    
            for i, cnt in ipairs(controllersTable_character) do
                ControllerKill(cnt);
            end

            KTBM_SetAgentWorldPosition("myMenuCamera", Vector(7.327, 1.125, 0.511), KTBM_Cutscene_DeathResults_kScene);
            KTBM_SetAgentWorldRotation("myMenuCamera", Vector(4.333, -83.156, 0.0), KTBM_Cutscene_DeathResults_kScene);
            KTBM_AgentSetProperty("myMenuCamera", "Field of View", 71, KTBM_Cutscene_DeathResults_kScene);

            KTBM_SetAgentWorldPosition("agent_endScreenGroup", Vector(0, 0, 0), KTBM_Cutscene_DeathResults_kScene);

            KTBM_AgentSetProperty("light_camera", "EnvLight - Intensity", 0, KTBM_Cutscene_DeathResults_kScene)
            KTBM_AgentSetProperty("light_D", "EnvLight - Intensity", 0, KTBM_Cutscene_DeathResults_kScene)

            KTBM_SetAgentRotation("Kenny", Vector(0, 90, 0), KTBM_Cutscene_DeathResults_kScene);
            KTBM_SetAgentWorldPosition("agent_kennyParent", Vector(4.12, 0, 0.62), KTBM_Cutscene_DeathResults_kScene);
            KTBM_SetAgentWorldRotation("agent_kennyParent", Vector(0, 0, 0), KTBM_Cutscene_DeathResults_kScene);

            local cnt_idleAnimation = PlayAnimation(agent_kenny, "sk54_idle_kennyArmsX.anm");
            ControllerSetLooping(cnt_idleAnimation, true);

            controller_fireAmbience = SoundPlay("fireplace_lp.wav");
            ControllerSetLooping(controller_fireAmbience, true);
            ControllerSetSoundVolume(controller_fireAmbience, 1);

            KTBM_Cutscene_DeathResults_ShowUI = true;
            KTBM_Cutscene_Skip_CutsceneFinished = true;

            CursorHide(false);
            CursorEnable(true);

            bool_marker_showStagedScene = true;

            return;
        end
    end

    ----------------------------------------------------------
    local number_currentDeltaTime = GetFrameTime();
    local number_currentTotalGameTime = GetTotalTime();

    if(number_currentTotalGameTime > number_sceneStartTime + 1.6) then
        if(bool_marker_playCutsceneAudio == false) then
            controller_cutsceneAudio = SoundPlay("KTBM_Sound_DeathSequenceAudio.wav");
            ControllerSetLooping(controller_cutsceneAudio, false);
            ControllerSetSoundVolume(controller_cutsceneAudio, 2.0);

            bool_marker_playCutsceneAudio = true;
        end
    end

    if(number_currentTotalGameTime < number_sceneStartTime + 3.49) then
        AgentSetWorldPos(agent_kennyParent, VectorAdd(currentPos, Vector(4.0 * number_currentDeltaTime, 0, 0)));
    else
        if(bool_marker_kennyPunchCamera == false) then
            ControllerSetContribution(controller_kenny_running, 0.0);
            controller_kenny_punch = PlayAnimation(agent_kenny, "sk54_action_carverPunchesCarlos.anm");
            KTBM_SetAgentWorldRotation("agent_kennyParent", Vector(0.5, -15, 0), KTBM_Cutscene_DeathResults_kScene);

            PlayAnimation(agent_kenny, "kenny200_face_eyesWide_add.anm");
            PlayAnimation(agent_kenny, "kenny200_face_browsGestureDown_add.anm");
            KTBM_ChorePlayOnAgent("sk54_kenny200_toAngryA.chore", agent_kenny, nil, nil);

            RenderDelay(1);

            bool_marker_kennyPunchCamera = true;
        end
    end

    if(number_currentTotalGameTime > number_sceneStartTime + 4.05) then
        if(bool_marker_showStagedScene == false) then
            KTBM_SetAgentWorldRotation("myMenuCamera", Vector(0, -10, 0), KTBM_Cutscene_DeathResults_kScene);
        end
    end

    if(number_currentTotalGameTime > number_sceneStartTime + 8.4) then
        if(bool_marker_showStagedScene == false) then
            KTBM_SetAgentWorldPosition("myMenuCamera", Vector(7.327, 1.125, 0.511), KTBM_Cutscene_DeathResults_kScene);
            KTBM_SetAgentWorldRotation("myMenuCamera", Vector(4.333, -83.156, 0.0), KTBM_Cutscene_DeathResults_kScene);
            KTBM_AgentSetProperty("myMenuCamera", "Field of View", 71, KTBM_Cutscene_DeathResults_kScene);

            KTBM_SetAgentWorldPosition("agent_endScreenGroup", Vector(0, 0, 0), KTBM_Cutscene_DeathResults_kScene);

            KTBM_AgentSetProperty("light_camera", "EnvLight - Intensity", 0, KTBM_Cutscene_DeathResults_kScene)
            KTBM_AgentSetProperty("light_D", "EnvLight - Intensity", 0, KTBM_Cutscene_DeathResults_kScene)

            KTBM_SetAgentWorldPosition("agent_kennyParent", Vector(4.12, 0, 0.62), KTBM_Cutscene_DeathResults_kScene);
            KTBM_SetAgentWorldRotation("agent_kennyParent", Vector(0, 0, 0), KTBM_Cutscene_DeathResults_kScene);

            local controllersTable_character = AgentGetControllers(agent_kenny);
    
            for i, cnt in ipairs(controllersTable_character) do
                ControllerKill(cnt);
            end

            local cnt_idleAnimation = PlayAnimation(agent_kenny, "sk54_idle_kennyArmsX.anm");
            ControllerSetLooping(cnt_idleAnimation, true);

            controller_fireAmbience = SoundPlay("fireplace_lp.wav");
            ControllerSetLooping(controller_fireAmbience, true);
            ControllerSetSoundVolume(controller_fireAmbience, 1);

            RenderDelay(1);

            KTBM_Cutscene_DeathResults_ShowUI = true;
            KTBM_Cutscene_Skip_CutsceneFinished = true;

            CursorHide(false);
            CursorEnable(true);

            bool_marker_showStagedScene = true;
        end
    end
end