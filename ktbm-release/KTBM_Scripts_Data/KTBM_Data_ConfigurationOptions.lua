KTBM_Data_ConfigurationOptions_Audio_SetMusic = function(controller_music)
    local propertySet_preferences = GetPreferences();
    local number_masterVolume = PropertyGet(propertySet_preferences, "Audio Mix Master");
    local number_musicVolume = PropertyGet(propertySet_preferences, "Audio Mix Music");

    ControllerSetMusic(controller_music, true);
    ControllerSetSoundVolume(controller_music, number_musicVolume);
end

KTBM_Data_ConfigurationOptions_Audio_SetVoice = function(controller_voice)
    local propertySet_preferences = GetPreferences();
    local number_masterVolume = PropertyGet(propertySet_preferences, "Audio Mix Master");
    local number_voiceVolume = PropertyGet(propertySet_preferences, "Audio Mix Voice");

    ControllerSetVoice(controller_voice, true);
    ControllerSetSoundVolume(controller_voice, number_voiceVolume);
end

KTBM_Data_ConfigurationOptions_Audio_SetAmbient = function(controller_ambient)
    local propertySet_preferences = GetPreferences();
    local number_masterVolume = PropertyGet(propertySet_preferences, "Audio Mix Master");
    local number_ambientVolume = PropertyGet(propertySet_preferences, "Audio Mix Ambient");

    ControllerSetAmbient(controller_ambient, true);
    ControllerSetSoundVolume(controller_ambient, number_ambientVolume);
end

KTBM_Data_ConfigurationOptions_Audio_ApplySettings = function()
    local number_masterVolume = KTBM_Data_PlayerSettings["Audio"]["MasterVolume"];
    local number_musicVolume = KTBM_Data_PlayerSettings["Audio"]["MusicVolume"];
    local number_voiceVolume = KTBM_Data_PlayerSettings["Audio"]["VoiceVolume"];
    local number_ambientVolume = KTBM_Data_PlayerSettings["Audio"]["AmbientVolume"];

    local propertySet_preferences = GetPreferences();
    PropertySet(propertySet_preferences, "Audio Mix Master", number_masterVolume);
    PropertySet(propertySet_preferences, "Audio Mix Music", number_musicVolume);
    PropertySet(propertySet_preferences, "Audio Mix Voice", number_voiceVolume);
    PropertySet(propertySet_preferences, "Audio Mix Ambient", number_ambientVolume);
end

KTBM_Data_ConfigurationOptions_Video_ApplySettings = function(kScene, kSceneAgentName)
    -------------------------------------------------
    --Display Video Settings
    local number_renderResolutionWidth = KTBM_Data_PlayerSettings["Video"]["RenderResolutionWidth"];
    local number_renderResolutionHeight = KTBM_Data_PlayerSettings["Video"]["RenderResolutionHeight"];
    RenderSetScreenSize(number_renderResolutionWidth, number_renderResolutionHeight);

    local number_renderAspectRatioCustom = KTBM_Data_PlayerSettings["Video"]["RenderAspectRatioCustom"];
    local bool_renderAspectRatio16x9 = KTBM_Data_PlayerSettings["Video"]["RenderAspectRatio16x9"];
    
    if(bool_renderAspectRatio16x9 == true) then
        RenderForce_16_by_9_AspectRatio(true);
    else
        RenderForce_16_by_9_AspectRatio(false);
        RenderSetAspectRatio(number_renderAspectRatioCustom);
    end

    --An additional factor used for setting the internal game resolution.
    --This works like a multiplier for the current screen resolution.
    local number_renderScale = KTBM_Data_PlayerSettings["Video"]["RenderScale"];
    RenderSetScale(number_renderScale);

    --RenderSetScaleForResolution(1.0);
    --RenderGetDisplayResolutions(); --Vector2 Table

    --This works by forcing the game to load up to a certain mip level for textures.
    --NOTE 1: This will only affect textures that mip maps, textures with no mip maps are unaffected.
    --NOTE 2: This does it globally, so textures that are max 2048 will look better when forced to load only 1 mip level versus textures that are max 512x512.
    --For example, for a 1024x1024 texture with mip maps
    --0 - (1024x1024) the highest mip level of the texture (i.e. the maximum quality)
    --1 - (512x512) the next mip level of the texture
    local number_renderTextureQualityLevel = KTBM_Data_PlayerSettings["Video"]["TextureQualityLevel"];
    RenderSetTextureQuality(number_renderTextureQualityLevel);

    -------------------------------------------------
    --Post Processing Video Settings
    --NOTE: Disabling After Effects (or post processing as a whole) breaks water rendering
    --NOTE: Disabling "finalresolve" breaks UI elements by not rendering them.

    local bool_dofEnable = KTBM_Data_PlayerSettings["Video"]["DepthOfField"];
    local bool_bokehEnable = KTBM_Data_PlayerSettings["Video"]["DepthOfFieldBokeh"];
    RenderSetFeatureEnabled("dof", bool_dofEnable);
    RenderSetFeatureEnabled("bokeh", bool_bokehEnable);

    local bool_bloomEnable = KTBM_Data_PlayerSettings["Video"]["Bloom"];
    RenderSetFeatureEnabled("glow", bool_bloomEnable);

    local bool_motionBlurEnable = KTBM_Data_PlayerSettings["Video"]["MotionBlur"];
    RenderSetFeatureEnabled("motionblur", bool_motionBlurEnable);

    local bool_HBAOEnable = KTBM_Data_PlayerSettings["Video"]["HBAO"]; --Horizon Based Ambient Occlusion
    local bool_AntiAliasingEnable = KTBM_Data_PlayerSettings["Video"]["AntiAliasing"]; --Temporal Anti Aliasing

    KTBM_AgentSetProperty(kSceneAgentName, "FX anti-aliasing", bool_AntiAliasingEnable, kScene);
    KTBM_AgentSetProperty(kSceneAgentName, "HBAO Enabled", bool_HBAOEnable, kScene);


    --RenderSetVisibilityThreshold(1.0);
    --RenderSetShadowVisibilityThreshold(1.0);
    --RenderSetLightVisibilityThreshold(1.0);
    --RenderSetDecalVisibleDistance(1.0);
    --RenderSetHDRColorBufferScale(1.0);
    --RenderSetHDRSurfaceFormat("srgb");
    --RenderSetHDRSurfaceFormat("rgb10");
    --RenderSetHDRSurfaceFormat("rgb10f");
    --RenderSetHDRSurfaceFormat("rgb16f");
    --RenderSetHDRSurfaceFormat("default");
    --RenderSetGamma(1.0); --RenderGetGamma();

    --RenderSetFeatureEnabled("computecullshadows", false);
    --RenderSetFeatureEnabled("depthcullshadows", false);
    --RenderSetFeatureEnabled("forwardkeyshadow", false);
    --RenderSetFeatureEnabled("histencilshadow", false);
    --RenderSetFeatureEnabled("brush", true);
    --RenderSetFeatureEnabled("lowresalpha", true);
    --RenderSetFeatureEnabled("bakelit", true);
    --RenderSetFeatureEnabled("nprlines", true);
    --RenderSetFeatureEnabled("optimizesdsm", true);
    --RenderSetFeatureEnabled("enlighten", true);
    --RenderSetFeatureEnabled("invertz", true);
    --RenderSetFeatureEnabled("lod", true);
    --RenderSetFeatureEnabled("occlusion", true);
    --RenderSetFeatureEnabled("lowreslight", true);
    --RenderSetFeatureEnabled("computelightcluster", true);
    --RenderSetFeatureEnabled("computeskinning", true);
    --RenderSetFeatureEnabled("forcedepth", true);

    --local prefs = GetPreferences();
	--PropertySet(prefs, "Enable Graphic Black", false);
    --PropertySet(prefs, "Render - Graphic Black Enabled", false);

    --[NAME ]: Volume Sound (symbol: "17423740863009043236")
    --[VALUE]: (number) 1
    --[NAME ]: Volume Voice (symbol: "15476313337580584826")
    --[VALUE]: (number) 1
    --[NAME ]: Volume Ambient (symbol: "10007796259616430709")
    --[VALUE]: (number) 1
    --[NAME ]: Audio Mix Master (symbol: "16092587424441024941")
    --[VALUE]: (number) 1
    --[NAME ]: Audio Mix Music (symbol: "4790314106292915319")
    --[VALUE]: (number) 1
    --[NAME ]: Audio Mix Sound (symbol: "6001002726368829545")
    --[VALUE]: (number) 1
    --[NAME ]: Audio Mix Voice (symbol: "8380283199651097655")
    --[VALUE]: (number) 1
    --[NAME ]: Audio Mix Ambient (symbol: "2117136355292019464")
    --[VALUE]: (number) 1
    --[NAME ]: Volume Master (symbol: "16889163048446566040")
    --[VALUE]: (number) 1
    --[NAME ]: Volume Music (symbol: "16208677830460972858")
    --[VALUE]: (number) 1

    --[NAME ]: GFX - Render Quality (symbol: "13657534494545019405")
    --[VALUE]: (number) 1
    --[NAME ]: Render Quality (symbol: "4847270878829974542")
    --[VALUE]: (number) 9
    --[NAME ]: Texture Quality (symbol: "8593929930041009285")
    --[VALUE]: (number) 0
    --[NAME ]: Render - HBAO Platform Preset (symbol: "15291410647714921328")
    --[VALUE]: (number) 5
    --[NAME ]: Render - DOF Quality (symbol: "7682868197412686997")
    --[VALUE]: (number) 2
    --[NAME ]: Render - Bokeh Quality (symbol: "12993705590219824557")
    --[VALUE]: (number) 3
    --[NAME ]: FX anti-aliasing (symbol: "13757783596288558265")
    --[VALUE]: (boolean) true

    --[NAME ]: Windowed (symbol: "2887639367916837074")
    --[VALUE]: (boolean) false
end