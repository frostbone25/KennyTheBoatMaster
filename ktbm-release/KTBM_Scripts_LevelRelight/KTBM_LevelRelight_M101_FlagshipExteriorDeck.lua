local CreateNewWater = function(kScene)
    local water_pos = Vector(0.0, 0.1, 0.0);
    local water_agent = AgentCreate("obj_puddlePoolClemHouse400_mine", "obj_puddlePoolClemHouse400.prop", water_pos, Vector(0,0,0), kScene, false, false);
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
    
    KTBM_AgentSetProperty("obj_puddlePoolClemHouse400_mine", "Runtime: Visible", true, kScene);
    KTBM_AgentSetProperty("obj_puddlePoolClemHouse400_mine", "Render Global Scale", 200, kScene);
    KTBM_AgentSetProperty("obj_puddlePoolClemHouse400_mine", "Render Cull", false, kScene); --disable culling since when the object is super large it gets culled out of the screen noticably
    --KTBM_AgentSetProperty("obj_puddlePoolClemHouse400_mine", "Render Depth Write", false, kScene);
    --KTBM_AgentSetProperty("obj_puddlePoolClemHouse400_mine", "Render Depth Write Alpha", false, kScene);
    --KTBM_AgentSetProperty("obj_puddlePoolClemHouse400_mine", "Render Depth Test", false, kScene);
    --KTBM_AgentSetProperty("obj_puddlePoolClemHouse400_mine", "Render Constant Alpha Multiply", false, kScene);
    --KTBM_AgentSetProperty("obj_puddlePoolClemHouse400_mine", "Render After Anti-Aliasing", false, kScene);
    --KTBM_AgentSetProperty("obj_puddlePoolClemHouse400_mine", "Render Force As Alpha", false, kScene);
    --KTBM_AgentSetProperty("obj_puddlePoolClemHouse400_mine", "Render 3D Alpha", false, kScene);

    local agent_enviormentGroup = AgentFindInScene("group_enviorment", kScene);
    AgentAttach(water_agent, agent_enviormentGroup);
end

KTBM_LevelRelight_M101_FlagshipExteriorDeck_ModifyWaterForGame = function(kScene)
    local water_pos = Vector(0.0, 0.1, 0.0);
    local water_agent = AgentFindInScene("obj_puddlePoolClemHouse400_mine", kScene);
    local water_props = AgentGetRuntimeProperties(water_agent);
    
    AgentSetRot(water_agent, Vector(0, 45, 0));
    
    KTBM_SetPropertyBySymbol(water_props, "1504390651565685996", 216); --wave-scale1
    KTBM_SetPropertyBySymbol(water_props, "15272138922562676569", 216); --wave-scale2
    KTBM_SetPropertyBySymbol(water_props, "4273370320593893048", 1.15); --wave-speed
    --KTBM_SetPropertyBySymbol(water_props, "4279570706014850606", 1); --wave-strength
    KTBM_SetPropertyBySymbol(water_props, "4857578369356927332", 0.8); --wave-strength2
    KTBM_SetPropertyBySymbol(water_props, "5950422962495852891", 0.5); --water-speed2?
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
    KTBM_SetPropertyBySymbol(water_props, "14326746451085487896", -0.425); --foam-scroll-speed
    KTBM_SetPropertyBySymbol(water_props, "17818319915486731111", 0.1); --foam-coverage
    --KTBM_SetPropertyBySymbol(water_props, "17178421325407310363", 0.0001); --SHORE-FADE
    KTBM_SetPropertyBySymbol(water_props, "17178421325407310363", 0.0001); --SHORE-FADE
    KTBM_SetPropertyBySymbol(water_props, "17888434372283380553", 3.3); --water-clear-fade
end

KTBM_LevelRelight_M101_FlagshipExteriorDeck_MakeGameWaterStatic = function(kScene)
    local water_pos = Vector(0.0, 0.1, 0.0);
    local water_agent = AgentFindInScene("obj_puddlePoolClemHouse400_mine", kScene);
    local water_props = AgentGetRuntimeProperties(water_agent);
    
    AgentSetRot(water_agent, Vector(0, 45, 0));
    
    KTBM_SetPropertyBySymbol(water_props, "1504390651565685996", 216); --wave-scale1
    KTBM_SetPropertyBySymbol(water_props, "15272138922562676569", 216); --wave-scale2
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
end

KTBM_LevelRelight_M101_FlagshipExteriorDeck_SpawnPointLight = function(string_agentName, vector_position, vector_rotation, number_intensity, number_radius, color_lightColor, kScene)
    local envlight  = AgentFindInScene("light_D", kScene);
    local envlight_props = AgentGetRuntimeProperties(envlight);
    local envlight_groupEnabled = PropertyGet(envlight_props, "EnvLight - Enabled Group");
    local envlight_groups = PropertyGet(envlight_props, "EnvLight - Groups");
    local envlight_prop = "module_env_light.prop";

    local agent_newLight = AgentCreate(string_agentName, envlight_prop, vector_position, vector_rotation, kScene, false, false)
    KTBM_AgentSetProperty(string_agentName, "EnvLight - Type", 0, kScene);
    KTBM_AgentSetProperty(string_agentName, "EnvLight - Intensity", number_intensity, kScene);
    KTBM_AgentSetProperty(string_agentName, "EnvLight - Intensity Diffuse", 1.0, kScene);
    KTBM_AgentSetProperty(string_agentName, "EnvLight - Intensity Specular", 1.0, kScene);
    KTBM_AgentSetProperty(string_agentName, "EnvLight - Enlighten Intensity", 0, kScene);
    KTBM_AgentSetProperty(string_agentName, "EnvLight - Radius", number_radius, kScene)
    KTBM_AgentSetProperty(string_agentName, "EnvLight - Distance Falloff", 1, kScene)
    KTBM_AgentSetProperty(string_agentName, "EnvLight - Spot Angle Inner", 1, kScene)
    KTBM_AgentSetProperty(string_agentName, "EnvLight - Spot Angle Outer", 45, kScene)
    KTBM_AgentSetProperty(string_agentName, "EnvLight - Color", color_lightColor, kScene)
    KTBM_AgentSetProperty(string_agentName, "EnvLight - Enabled Group", envlight_groupEnabled, kScene)
    KTBM_AgentSetProperty(string_agentName, "EnvLight - Groups", envlight_groups, kScene)
    KTBM_AgentSetProperty(string_agentName, "EnvLight - Shadow Type", 2, kScene)
    KTBM_AgentSetProperty(string_agentName, "EnvLight - Wrap", 0.0, kScene)
    KTBM_AgentSetProperty(string_agentName, "EnvLight - Shadow Quality", 3, kScene)
    KTBM_AgentSetProperty(string_agentName, "EnvLight - HBAO Participation Type", 1, kScene)

    return agent_newLight;
end

KTBM_LevelRelight_M101_FlagshipExteriorDeck_SpawnSpotLight = function(string_agentName, vector_position, vector_rotation, number_intensity, number_radius, number_spotInner, number_spotOuter, color_lightColor, kScene)
    local envlight  = AgentFindInScene("light_D", kScene);
    local envlight_props = AgentGetRuntimeProperties(envlight);
    local envlight_groupEnabled = PropertyGet(envlight_props, "EnvLight - Enabled Group");
    local envlight_groups = PropertyGet(envlight_props, "EnvLight - Groups");
    local envlight_prop = "module_env_light.prop";

    local agent_newLight = AgentCreate(string_agentName, envlight_prop, vector_position, vector_rotation, kScene, false, false)
    KTBM_AgentSetProperty(string_agentName, "EnvLight - Type", 1, kScene);
    KTBM_AgentSetProperty(string_agentName, "EnvLight - Intensity", number_intensity, kScene);
    KTBM_AgentSetProperty(string_agentName, "EnvLight - Intensity Diffuse", 1.0, kScene);
    KTBM_AgentSetProperty(string_agentName, "EnvLight - Intensity Specular", 1.0, kScene);
    KTBM_AgentSetProperty(string_agentName, "EnvLight - Enlighten Intensity", 0, kScene);
    KTBM_AgentSetProperty(string_agentName, "EnvLight - Radius", number_radius, kScene)
    KTBM_AgentSetProperty(string_agentName, "EnvLight - Distance Falloff", 1, kScene)
    KTBM_AgentSetProperty(string_agentName, "EnvLight - Spot Angle Inner", number_spotInner, kScene)
    KTBM_AgentSetProperty(string_agentName, "EnvLight - Spot Angle Outer", number_spotOuter, kScene)
    KTBM_AgentSetProperty(string_agentName, "EnvLight - Color", color_lightColor, kScene)
    KTBM_AgentSetProperty(string_agentName, "EnvLight - Enabled Group", envlight_groupEnabled, kScene)
    KTBM_AgentSetProperty(string_agentName, "EnvLight - Groups", envlight_groups, kScene)
    KTBM_AgentSetProperty(string_agentName, "EnvLight - Shadow Type", 1, kScene)
    KTBM_AgentSetProperty(string_agentName, "EnvLight - Wrap", 0.0, kScene)
    KTBM_AgentSetProperty(string_agentName, "EnvLight - Shadow Quality", 3, kScene)
    KTBM_AgentSetProperty(string_agentName, "EnvLight - HBAO Participation Type", 1, kScene)

    return agent_newLight;
end

KTBM_LevelRelight_M101_FlagshipExteriorDeck_Build = function(kScene, kSceneAgentName)
    local envlight  = AgentFindInScene("light_D", kScene);
    local envlight_props = AgentGetRuntimeProperties(envlight);
    local envlight_groupEnabled = PropertyGet(envlight_props, "EnvLight - Enabled Group");
    local envlight_groups = PropertyGet(envlight_props, "EnvLight - Groups");
    local envlight_prop = "module_env_light.prop";

    --enviormental colors
    local sunColor     = RGBColor(255, 230, 198, 255) --RGBColor(255, 245, 227, 255)
    local ambientColor = RGBColor(108, 150, 225, 255) 
    local skyColor     = RGBColor(0, 80, 255, 255)
    local fogColor     = Desaturate_RGBColor(skyColor, 0.7)
    skyColor = Desaturate_RGBColor(skyColor, 0.2)
    fogColor = Multiplier_RGBColor(fogColor, 3.8)
    sunColor = Desaturate_RGBColor(sunColor, 0.15)
    ambientColor = Desaturate_RGBColor(ambientColor, 0.35)

    --sun
    KTBM_AgentSetProperty("light_D", "EnvLight - Type", 2, kScene)
    KTBM_AgentSetProperty("light_D", "EnvLight - Intensity", 8, kScene)
    KTBM_AgentSetProperty("light_D", "EnvLight - Enlighten Intensity", 0, kScene)
    KTBM_AgentSetProperty("light_D", "EnvLight - Color", sunColor, kScene)
    KTBM_AgentSetProperty("light_D", "EnvLight - Shadow Type", 2, kScene)
    KTBM_AgentSetProperty("light_D", "EnvLight - Wrap", 0.0, kScene)
    KTBM_AgentSetProperty("light_D", "EnvLight - Shadow Quality", 3, kScene)
    KTBM_AgentSetProperty("light_D", "EnvLight - HBAO Participation Type", 2, kScene)
    
    --ambient light
    KTBM_AgentSetProperty("light_amb", "EnvLight - Intensity", 1, kScene)
    KTBM_AgentSetProperty("light_amb", "EnvLight - Enlighten Intensity", 0, kScene)
    KTBM_AgentSetProperty("light_amb", "EnvLight - Color", sunColor, kScene)
    KTBM_AgentSetProperty("light_amb", "EnvLight - HBAO Participation Type", 1, kScene)

    --sky
    KTBM_AgentSetProperty("light_amb sky", "EnvLight - Intensity", 0.15, kScene)
    KTBM_AgentSetProperty("light_amb sky", "EnvLight - Color", skyColor, kScene)
    
    --fog
    KTBM_AgentSetProperty("module_environment", "Env - Fog Color", fogColor, kScene)
    KTBM_AgentSetProperty("module_environment", "Env - Fog Max Opacity", 1, kScene)
    KTBM_AgentSetProperty("module_environment", "Env - Fog Start Distance", 4.25, kScene)
    KTBM_AgentSetProperty("module_environment", "Env - Fog Height", 1.85, kScene)
    --KTBM_AgentSetProperty("module_environment", "Env - Fog Height", 1.85 + KTBM_Gameplay_EnvironmentHeightOffset, kScene)
    KTBM_AgentSetProperty("module_environment", "Env - Fog Density", 0.35, kScene)
    KTBM_AgentSetProperty("module_environment", "Env - Fog Enabled", true, kScene)
    KTBM_AgentSetProperty("module_environment", "Env - Enabled", true, kScene)
    KTBM_AgentSetProperty("module_environment", "Env - Enabled on High", true, kScene)
    KTBM_AgentSetProperty("module_environment", "Env - Enabled on Medium", true, kScene)
    KTBM_AgentSetProperty("module_environment", "Env - Enabled on Low", true, kScene)

    --comented out unfortunately because it doesn't work.
    --the material on kenny's eyes is not properly configured to recieve proper specular reflections.
    --attempting to fix it by overriding the specular textures also did not seem to work

    --eyelight
    --local agent_cameraEyelight = AgentCreate("light_eyelight", envlight_prop, Vector(0,0,0), Vector(0,0,0), kScene, false, false)
    --KTBM_AgentSetProperty("light_eyelight", "EnvLight - Type", 0, kScene)
    --KTBM_AgentSetProperty("light_eyelight", "EnvLight - Intensity", 55, kScene)
    --KTBM_AgentSetProperty("light_eyelight", "EnvLight - Intensity Diffuse", 0.0, kScene)
    --KTBM_AgentSetProperty("light_eyelight", "EnvLight - Intensity Specular", 1.0, kScene)
    --KTBM_AgentSetProperty("light_eyelight", "EnvLight - Enlighten Intensity", 0, kScene)
    --KTBM_AgentSetProperty("light_eyelight", "EnvLight - Radius", 100, kScene)
    --KTBM_AgentSetProperty("light_eyelight", "EnvLight - Distance Falloff", 1, kScene)
    --KTBM_AgentSetProperty("light_eyelight", "EnvLight - Spot Angle Inner", 5, kScene)
    --KTBM_AgentSetProperty("light_eyelight", "EnvLight - Spot Angle Outer", 85, kScene)
    --KTBM_AgentSetProperty("light_eyelight", "EnvLight - Color", Color(1,1,1,1), kScene)
    --KTBM_AgentSetProperty("light_eyelight", "EnvLight - Enabled Group", envlight_groupEnabled, kScene)
    --KTBM_AgentSetProperty("light_eyelight", "EnvLight - Groups", envlight_groups, kScene)
    --KTBM_AgentSetProperty("light_eyelight", "EnvLight - Shadow Type", 0, kScene)
    --KTBM_AgentSetProperty("light_eyelight", "EnvLight - Wrap", 0.0, kScene)
    --KTBM_AgentSetProperty("light_eyelight", "EnvLight - Shadow Quality", 0, kScene)
    --KTBM_AgentSetProperty("light_eyelight", "EnvLight - HBAO Participation Type", 1, kScene)

    --set post processing
    KTBM_AgentSetProperty(kSceneAgentName, "FX anti-aliasing", true, kScene)
    KTBM_AgentSetProperty(kSceneAgentName, "FX Sharp Shadows Enabled", true, kScene)
    KTBM_AgentSetProperty(kSceneAgentName, "Generate NPR Lines", false, kScene)
    KTBM_AgentSetProperty(kSceneAgentName, "Screen Space Lines - Enabled", false, kScene)
    KTBM_AgentSetProperty(kSceneAgentName, "FX Ambient Occlusion Enabled", true, kScene)
    KTBM_AgentSetProperty(kSceneAgentName, "FX Tonemap Intensity", 1.0, kScene)
    KTBM_AgentSetProperty(kSceneAgentName, "FX Tonemap White Point", 8.0, kScene)
    KTBM_AgentSetProperty(kSceneAgentName, "FX Tonemap Black Point", 0.005, kScene)
    KTBM_AgentSetProperty(kSceneAgentName, "FX Tonemap Filmic Toe Intensity", 1.0, kScene)
    KTBM_AgentSetProperty(kSceneAgentName, "FX Tonemap Filmic Shoulder Intensity", 0.75, kScene)
    KTBM_AgentSetProperty(kSceneAgentName, "FX Tonemap Type", 2, kScene)
    KTBM_AgentSetProperty(kSceneAgentName, "FX Tonemap Filmic Pivot", 0, kScene)
    KTBM_AgentSetProperty(kSceneAgentName, "FX Tonemap Filmic Shoulder Intensity", 0.8, kScene)
    KTBM_AgentSetProperty(kSceneAgentName, "HBAO Enabled", true, kScene)
    KTBM_AgentSetProperty(kSceneAgentName, "HBAO Intensity", 1.5, kScene)
    KTBM_AgentSetProperty(kSceneAgentName, "HBAO Radius", 0.75, kScene)
    KTBM_AgentSetProperty(kSceneAgentName, "HBAO Max Radius Percent", 0.5, kScene)
    KTBM_AgentSetProperty(kSceneAgentName, "HBAO Max Distance", 15.5, kScene)
    KTBM_AgentSetProperty(kSceneAgentName, "HBAO Distance Falloff", 1, kScene)
    KTBM_AgentSetProperty(kSceneAgentName, "HBAO Hemisphere Bias", -0.2, kScene)
    KTBM_AgentSetProperty(kSceneAgentName, "FX Bloom Threshold", -0.35, kScene)
    KTBM_AgentSetProperty(kSceneAgentName, "FX Bloom Intensity", 0.15, kScene)
    KTBM_AgentSetProperty(kSceneAgentName, "Ambient Color", RGBColor(0, 0, 0, 0), kScene)
    KTBM_AgentSetProperty(kSceneAgentName, "Shadow Color", RGBColor(0, 0, 0, 0), kScene)
    
    KTBM_AgentSetProperty(kSceneAgentName, "FX Vignette Tint Enabled", true, kScene)
    KTBM_AgentSetProperty(kSceneAgentName, "FX Vignette Tint", RGBColor(0, 0, 0, 128), kScene)
    KTBM_AgentSetProperty(kSceneAgentName, "FX Vignette Falloff", 1.5, kScene)
    KTBM_AgentSetProperty(kSceneAgentName, "FX Vignette Center", 0, kScene)
    KTBM_AgentSetProperty(kSceneAgentName, "FX Vignette Corners", 1.0, kScene)
    
    KTBM_AgentSetProperty(kSceneAgentName, "LightEnv Saturation", 1.0, kScene)
    KTBM_AgentSetProperty(kSceneAgentName, "LightEnv Reflection Intensity Shadow", 0.0, kScene)
    KTBM_AgentSetProperty(kSceneAgentName, "LightEnv Reflection Intensity", 0.0, kScene)
    KTBM_AgentSetProperty(kSceneAgentName, "LightEnv Shadow Max Distance", 10.5, kScene)
    KTBM_AgentSetProperty(kSceneAgentName, "LightEnv Shadow Position Offset Bias", 0.0, kScene)
    KTBM_AgentSetProperty(kSceneAgentName, "LightEnv Shadow Depth Bias", 0.0, kScene)
    KTBM_AgentSetProperty(kSceneAgentName, "LightEnv Shadow Auto Depth Bounds", false, kScene)
    KTBM_AgentSetProperty(kSceneAgentName, "Specular Multiplier Enabled", true, kScene)
    KTBM_AgentSetProperty(kSceneAgentName, "Specular Color Multiplier", 1, kScene)
    KTBM_AgentSetProperty(kSceneAgentName, "Specular Intensity Multiplier", 1, kScene)
    KTBM_AgentSetProperty(kSceneAgentName, "Specular Exponent Multiplier", 1, kScene)
    KTBM_AgentSetProperty(kSceneAgentName, "FX Noise Scale", 1, kScene)

    CreateNewWater(kScene);
end

KTBM_LevelRelight_M101_FlagshipExteriorDeck_UpdateLighting = function()
    --get the current camera, normally we would just cache this but scene cameras change all the time
    --local agent_currentSceneCamera = SceneGetCamera(KTBM_LevelRelight_kScene) --Agent type
    --local camera_currentSceneCamera = AgentGetCamera(agent_currentSceneCamera) --Camera type
    --local name_currentSceneCamera = tostring(AgentGetName(agent_currentSceneCamera))

    --note to self: cache these
    --local agent_sun = AgentFindInScene("myLight_ENV_MOON", KTBM_LevelRelight_kScene)
    
    --get look vectors
    --local currentCamera_forward_vector = AgentGetForwardVec(agent_currentSceneCamera) --Vector type
    --local currentCamera_forward_vector_neg = VectorNegate(currentCamera_forward_vector) --Vector type

    --local cameraRotation = AgentGetWorldRot(agent_currentSceneCamera)

    --local testRotX = 10;
    --local testRotY = cameraRotation.y + 120;
    --local testRotZ = cameraRotation.z;
    --local testRotZ = 0;
    --local testRotation = Vector(testRotX, testRotY, testRotZ);
    
    --RELIGHT_SetAgentRotation("myLight_ENV_MOON", testRotation, KTBM_LevelRelight_kScene)
    
    --local cameraPos = AgentGetWorldPos(agent_currentSceneCamera);
    --KTBM_SetAgentWorldPosition("light_eyelight", cameraPos, KTBM_LevelRelight_kScene);
end

KTBM_LevelRelight_M101_FlagshipExteriorDeck_Build_DeathResults = function(kScene, kSceneAgentName)
    local envlight  = AgentFindInScene("light_D", kScene);
    local envlight_props = AgentGetRuntimeProperties(envlight);
    local envlight_groupEnabled = PropertyGet(envlight_props, "EnvLight - Enabled Group");
    local envlight_groups = PropertyGet(envlight_props, "EnvLight - Groups");
    local envlight_prop = "module_env_light.prop";

    --sun
    KTBM_SetAgentWorldRotation("light_D", Vector(45, 90, 0), kScene)
    KTBM_AgentSetProperty("light_D", "EnvLight - Type", 2, kScene)
    KTBM_AgentSetProperty("light_D", "EnvLight - Intensity", 50, kScene)
    KTBM_AgentSetProperty("light_D", "EnvLight - Enlighten Intensity", 0, kScene)
    KTBM_AgentSetProperty("light_D", "EnvLight - Color", RGBColor(255, 0, 0, 255), kScene)
    KTBM_AgentSetProperty("light_D", "EnvLight - Shadow Type", 2, kScene)
    KTBM_AgentSetProperty("light_D", "EnvLight - Wrap", 0.0, kScene)
    KTBM_AgentSetProperty("light_D", "EnvLight - Shadow Quality", 3, kScene)
    KTBM_AgentSetProperty("light_D", "EnvLight - HBAO Participation Type", 2, kScene)

    local agent_cameraEyelight = AgentCreate("light_camera", envlight_prop, Vector(2,1.5,0), Vector(0,0,0), kScene, false, false)
    --KTBM_AgentSetProperty("light_camera", "EnvLight - Type", 0, kScene)
    KTBM_AgentSetProperty("light_camera", "EnvLight - Intensity", 7, kScene)
    KTBM_AgentSetProperty("light_camera", "EnvLight - Intensity", 0, kScene)
    KTBM_AgentSetProperty("light_camera", "EnvLight - Intensity Diffuse", 1.0, kScene)
    KTBM_AgentSetProperty("light_camera", "EnvLight - Intensity Specular", 1.0, kScene)
    KTBM_AgentSetProperty("light_camera", "EnvLight - Enlighten Intensity", 0, kScene)
    KTBM_AgentSetProperty("light_camera", "EnvLight - Radius", 10, kScene)
    KTBM_AgentSetProperty("light_camera", "EnvLight - Distance Falloff", 5, kScene)
    KTBM_AgentSetProperty("light_camera", "EnvLight - Spot Angle Inner", 5, kScene)
    KTBM_AgentSetProperty("light_camera", "EnvLight - Spot Angle Outer", 90, kScene)
    KTBM_AgentSetProperty("light_camera", "EnvLight - Color", Color(1,1,1,1), kScene)
    KTBM_AgentSetProperty("light_camera", "EnvLight - Enabled Group", envlight_groupEnabled, kScene)
    KTBM_AgentSetProperty("light_camera", "EnvLight - Groups", envlight_groups, kScene)
    KTBM_AgentSetProperty("light_camera", "EnvLight - Shadow Type", 0, kScene)
    KTBM_AgentSetProperty("light_camera", "EnvLight - Wrap", 0.0, kScene)
    KTBM_AgentSetProperty("light_camera", "EnvLight - Shadow Quality", 4, kScene)
    KTBM_AgentSetProperty("light_camera", "EnvLight - HBAO Participation Type", 1, kScene)

    --set post processing
    KTBM_AgentSetProperty(kSceneAgentName, "FX anti-aliasing", true, kScene)
    KTBM_AgentSetProperty(kSceneAgentName, "FX Sharp Shadows Enabled", true, kScene)
    KTBM_AgentSetProperty(kSceneAgentName, "Generate NPR Lines", false, kScene)
    KTBM_AgentSetProperty(kSceneAgentName, "Screen Space Lines - Enabled", false, kScene)
    KTBM_AgentSetProperty(kSceneAgentName, "FX Ambient Occlusion Enabled", true, kScene)
    KTBM_AgentSetProperty(kSceneAgentName, "FX Tonemap Intensity", 1.0, kScene)
    KTBM_AgentSetProperty(kSceneAgentName, "FX Tonemap White Point", 8.0, kScene)
    KTBM_AgentSetProperty(kSceneAgentName, "FX Tonemap Black Point", 0.005, kScene)
    KTBM_AgentSetProperty(kSceneAgentName, "FX Tonemap Filmic Toe Intensity", 1.0, kScene)
    KTBM_AgentSetProperty(kSceneAgentName, "FX Tonemap Filmic Shoulder Intensity", 0.75, kScene)
    KTBM_AgentSetProperty(kSceneAgentName, "FX Tonemap Type", 2, kScene)
    KTBM_AgentSetProperty(kSceneAgentName, "FX Tonemap Filmic Pivot", 0, kScene)
    KTBM_AgentSetProperty(kSceneAgentName, "FX Tonemap Filmic Shoulder Intensity", 0.8, kScene)
    KTBM_AgentSetProperty(kSceneAgentName, "HBAO Enabled", true, kScene)
    KTBM_AgentSetProperty(kSceneAgentName, "HBAO Intensity", 1.5, kScene)
    KTBM_AgentSetProperty(kSceneAgentName, "HBAO Radius", 0.75, kScene)
    KTBM_AgentSetProperty(kSceneAgentName, "HBAO Max Radius Percent", 0.5, kScene)
    KTBM_AgentSetProperty(kSceneAgentName, "HBAO Max Distance", 15.5, kScene)
    KTBM_AgentSetProperty(kSceneAgentName, "HBAO Distance Falloff", 1, kScene)
    KTBM_AgentSetProperty(kSceneAgentName, "HBAO Hemisphere Bias", -0.2, kScene)
    KTBM_AgentSetProperty(kSceneAgentName, "FX Bloom Threshold", -0.35, kScene)
    KTBM_AgentSetProperty(kSceneAgentName, "FX Bloom Intensity", 0.15, kScene)
    KTBM_AgentSetProperty(kSceneAgentName, "Ambient Color", RGBColor(0, 0, 0, 0), kScene)
    KTBM_AgentSetProperty(kSceneAgentName, "Shadow Color", RGBColor(0, 0, 0, 0), kScene)
    
    KTBM_AgentSetProperty(kSceneAgentName, "FX Vignette Tint Enabled", true, kScene)
    KTBM_AgentSetProperty(kSceneAgentName, "FX Vignette Tint", RGBColor(0, 0, 0, 128), kScene)
    KTBM_AgentSetProperty(kSceneAgentName, "FX Vignette Falloff", 1.5, kScene)
    KTBM_AgentSetProperty(kSceneAgentName, "FX Vignette Center", 0, kScene)
    KTBM_AgentSetProperty(kSceneAgentName, "FX Vignette Corners", 1.0, kScene)
    
    KTBM_AgentSetProperty(kSceneAgentName, "LightEnv Saturation", 1.0, kScene)
    KTBM_AgentSetProperty(kSceneAgentName, "LightEnv Reflection Intensity Shadow", 0.0, kScene)
    KTBM_AgentSetProperty(kSceneAgentName, "LightEnv Reflection Intensity", 0.0, kScene)
    KTBM_AgentSetProperty(kSceneAgentName, "LightEnv Shadow Max Distance", 10.5, kScene)
    KTBM_AgentSetProperty(kSceneAgentName, "LightEnv Shadow Position Offset Bias", 0.0, kScene)
    KTBM_AgentSetProperty(kSceneAgentName, "LightEnv Shadow Depth Bias", 0.0, kScene)
    KTBM_AgentSetProperty(kSceneAgentName, "LightEnv Shadow Auto Depth Bounds", true, kScene)
    KTBM_AgentSetProperty(kSceneAgentName, "Specular Multiplier Enabled", true, kScene)
    KTBM_AgentSetProperty(kSceneAgentName, "Specular Color Multiplier", 1, kScene)
    KTBM_AgentSetProperty(kSceneAgentName, "Specular Intensity Multiplier", 1, kScene)
    KTBM_AgentSetProperty(kSceneAgentName, "Specular Exponent Multiplier", 1, kScene)
    KTBM_AgentSetProperty(kSceneAgentName, "FX Noise Scale", 1, kScene)
end