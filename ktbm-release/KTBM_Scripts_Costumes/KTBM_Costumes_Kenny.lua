KTBM_Costumes_Kenny_SelectedOutfit = "202";
KTBM_Costumes_Kenny_PropList = {
    "sk54_kenny", --Season 1 Episode 1 Kenny (white whirt, grey pants)
    "sk54_kennyAltShirt", --Season 1 Episode 2 Kenny (green shirt ontop of white long sleeves, grey pants)
    "sk54_kennyFlashback", --Season 1 Episode 3 Kenny (black shirt ontop of white long sleeves, grey pants)
    "sk54_kenny202", --(DEFAULT) Season 2 Episode 2 Kenny (beige jacket with white shirt, bearded, blue pants)
    "sk54_kenny203",
}

KTBM_Costumes_Kenny_ApplySelectedOutfit = function(kScene)
    if(KTBM_Data_PlayerSettings ~= nil) then
        KTBM_Costumes_Kenny_SelectedOutfit = KTBM_Data_PlayerSettings.Gameplay.KennyOutfitProfile;
    end

    if(string.match(KTBM_Costumes_Kenny_SelectedOutfit, "101")) then
        KTBM_Costumes_Kenny_SetCostume_To101(kScene);
    end

    if(string.match(KTBM_Costumes_Kenny_SelectedOutfit, "102")) then
        KTBM_Costumes_Kenny_SetCostume_To102(kScene);
    end

    if(string.match(KTBM_Costumes_Kenny_SelectedOutfit, "103")) then
        KTBM_Costumes_Kenny_SetCostume_To103(kScene);
    end

    if(string.match(KTBM_Costumes_Kenny_SelectedOutfit, "202")) then
        KTBM_Costumes_Kenny_SetCostume_To202(kScene);
    end
end

KTBM_Costumes_Kenny_SetCostume_To101 = function(kScene)
    local agent_kenny = AgentFindInScene("Kenny", kScene);
    local agent_kennyCostumeProxy = AgentCreate("KennyCostumeProxy", "sk54_kenny.prop", Vector(0,0,0), Vector(0,0,0), kScene, false, false);
    local mesh_kennyCostumeProxy = KTBM_PropertyGet(agent_kennyCostumeProxy, "D3D Mesh");
    local meshes_kennyCostumeProxy = KTBM_PropertyGet(agent_kennyCostumeProxy, "D3D Mesh List");

    KTBM_PropertySet(agent_kenny, "D3D Mesh List", nil);
    KTBM_PropertySet(agent_kenny, "D3D Mesh", nil);
    KTBM_PropertySet(agent_kenny, "Mesh sk54_kenny202 - Visible", false);
    KTBM_PropertySet(agent_kenny, "D3D Mesh List", meshes_kennyCostumeProxy);
    KTBM_PropertySet(agent_kenny, "D3D Mesh", mesh_kennyCostumeProxy);

    AgentDestroy(agent_kennyCostumeProxy);

    ShaderOverrideTexture(agent_kenny, "sk_wdSharedParts_eye_brown.d3dtx", "sk_wdSharedParts_eye_brown200.d3dtx");
    ShaderOverrideTexture(agent_kenny, "sk_wdSharedParts_eye_brown106.d3dtx", "sk_wdSharedParts_eye_brown200.d3dtx");

    KTBM_Costumes_Kenny_SelectedOutfit = "101";

    if(KTBM_Data_PlayerSettings ~= nil) then
        KTBM_Data_PlayerSettings.Gameplay.KennyOutfitProfile = KTBM_Costumes_Kenny_SelectedOutfit;
        KTBM_Data_Configuration_Save();
    end

    RenderDelay(1);
end

KTBM_Costumes_Kenny_SetCostume_To102 = function(kScene)
    local agent_kenny = AgentFindInScene("Kenny", kScene);
    local agent_kennyCostumeProxy = AgentCreate("KennyCostumeProxy", "sk54_kennyAltShirt.prop", Vector(0,0,0), Vector(0,0,0), kScene, false, false);
    local mesh_kennyCostumeProxy = KTBM_PropertyGet(agent_kennyCostumeProxy, "D3D Mesh");
    local meshes_kennyCostumeProxy = KTBM_PropertyGet(agent_kennyCostumeProxy, "D3D Mesh List");

    KTBM_PropertySet(agent_kenny, "D3D Mesh List", nil);
    KTBM_PropertySet(agent_kenny, "D3D Mesh", nil);
    KTBM_PropertySet(agent_kenny, "Mesh sk54_kenny202 - Visible", false);
    KTBM_PropertySet(agent_kenny, "D3D Mesh List", meshes_kennyCostumeProxy);
    KTBM_PropertySet(agent_kenny, "D3D Mesh", mesh_kennyCostumeProxy);

    AgentDestroy(agent_kennyCostumeProxy);

    ShaderOverrideTexture(agent_kenny, "sk_wdSharedParts_eye_brown.d3dtx", "sk_wdSharedParts_eye_brown200.d3dtx");
    ShaderOverrideTexture(agent_kenny, "sk_wdSharedParts_eye_brown106.d3dtx", "sk_wdSharedParts_eye_brown200.d3dtx");
    --ShaderOverrideTexture(agent_kenny, "sk_wdSharedParts_eye_darkBrown.d3dtx", "sk_wdSharedParts_eye_brown200.d3dtx");

    KTBM_Costumes_Kenny_SelectedOutfit = "102";

    if(KTBM_Data_PlayerSettings ~= nil) then
        KTBM_Data_PlayerSettings.Gameplay.KennyOutfitProfile = KTBM_Costumes_Kenny_SelectedOutfit;
        KTBM_Data_Configuration_Save();
    end

    RenderDelay(1);
end

KTBM_Costumes_Kenny_SetCostume_To103 = function(kScene)
    local agent_kenny = AgentFindInScene("Kenny", kScene);
    local agent_kennyCostumeProxy = AgentCreate("KennyCostumeProxy", "sk54_kennyFlashback.prop", Vector(0,0,0), Vector(0,0,0), kScene, false, false);
    local mesh_kennyCostumeProxy = KTBM_PropertyGet(agent_kennyCostumeProxy, "D3D Mesh");
    local meshes_kennyCostumeProxy = KTBM_PropertyGet(agent_kennyCostumeProxy, "D3D Mesh List");

    KTBM_PropertySet(agent_kenny, "D3D Mesh List", nil);
    KTBM_PropertySet(agent_kenny, "D3D Mesh", nil);
    KTBM_PropertySet(agent_kenny, "Mesh sk54_kenny202 - Visible", false);
    KTBM_PropertySet(agent_kenny, "D3D Mesh List", meshes_kennyCostumeProxy);
    KTBM_PropertySet(agent_kenny, "D3D Mesh", mesh_kennyCostumeProxy);

    AgentDestroy(agent_kennyCostumeProxy);

    ShaderOverrideTexture(agent_kenny, "sk_wdSharedParts_eye_brown.d3dtx", "sk_wdSharedParts_eye_brown200.d3dtx");
    ShaderOverrideTexture(agent_kenny, "sk_wdSharedParts_eye_brown106.d3dtx", "sk_wdSharedParts_eye_brown200.d3dtx");
    --ShaderOverrideTexture(agent_kenny, "sk_wdSharedParts_eye_darkBrown.d3dtx", "sk_wdSharedParts_eye_brown200.d3dtx");

    KTBM_Costumes_Kenny_SelectedOutfit = "103";

    if(KTBM_Data_PlayerSettings ~= nil) then
        KTBM_Data_PlayerSettings.Gameplay.KennyOutfitProfile = KTBM_Costumes_Kenny_SelectedOutfit;
        KTBM_Data_Configuration_Save();
    end

    RenderDelay(1);
end

KTBM_Costumes_Kenny_SetCostume_To202 = function(kScene)
    local agent_kenny = AgentFindInScene("Kenny", kScene);
    local agent_kennyCostumeProxy = AgentCreate("KennyCostumeProxy", "sk54_kenny202.prop", Vector(0,0,0), Vector(0,0,0), kScene, false, false);
    local mesh_kennyCostumeProxy = KTBM_PropertyGet(agent_kennyCostumeProxy, "D3D Mesh");
    local meshes_kennyCostumeProxy = KTBM_PropertyGet(agent_kennyCostumeProxy, "D3D Mesh List");

    KTBM_PropertySet(agent_kenny, "D3D Mesh List", nil);
    KTBM_PropertySet(agent_kenny, "D3D Mesh", nil);
    KTBM_PropertySet(agent_kenny, "Mesh sk54_kenny202 - Visible", true);
    KTBM_PropertySet(agent_kenny, "D3D Mesh List", meshes_kennyCostumeProxy);
    KTBM_PropertySet(agent_kenny, "D3D Mesh", mesh_kennyCostumeProxy);

    AgentDestroy(agent_kennyCostumeProxy);

    ShaderOverrideTexture(agent_kenny, "sk_wdSharedParts_eye_brown.d3dtx", "sk_wdSharedParts_eye_brown200.d3dtx");
    ShaderOverrideTexture(agent_kenny, "sk_wdSharedParts_eye_brown106.d3dtx", "sk_wdSharedParts_eye_brown200.d3dtx");
    --ShaderOverrideTexture(agent_kenny, "sk_wdSharedParts_eye_darkBrown.d3dtx", "sk_wdSharedParts_eye_brown200.d3dtx");

    KTBM_Costumes_Kenny_SelectedOutfit = "202";

    if(KTBM_Data_PlayerSettings ~= nil) then
        KTBM_Data_PlayerSettings.Gameplay.KennyOutfitProfile = KTBM_Costumes_Kenny_SelectedOutfit;
        KTBM_Data_Configuration_Save();
    end

    RenderDelay(1);
end

--main function that prepares the level enviorment
KTBM_Costumes_Kenny_AddToBoat = function(kScene)
    --get the existing boat object in the scene and reset the position and rotation
    local agent_boatGroupParent = AgentFindInScene("BoatGroup", kScene);

    --------------------------------------------------------
    --spawn the legend himself, kenny, into the scene

    local agent_kenny = AgentCreate("Kenny", "sk54_kenny202.prop", Vector(0,0,0), Vector(0,0,0), kScene, false, false);

    KTBM_PropertySet(agent_kenny, "Walk Animation - Idle", nil);
    --KTBM_PropertySet(agent_kenny, "Eye Look-At Properties", nil);
    KTBM_PropertySet(agent_kenny, "Walk Animation - Eyes", nil);
    KTBM_PropertySet(agent_kenny, "Walk Animation - Forward", nil);
    KTBM_PropertySet(agent_kenny, "Walk Animation - Idle Face", nil);
    --KTBM_PropertySet(agent_kenny, "Walk Animator - Enabled", false);
    --KTBM_PropertySet(agent_kenny, "talking", false)

    --get rid of any existing controllers he might have on him
    local kenny_originalControllers = AgentGetControllers(agent_kenny);
    
    for i, controllerItem in ipairs(kenny_originalControllers) do
        ControllerSetLooping(controllerItem, false);
        --ControllerStop(controllerItem); --this breaks lipsync (fixes face idles though)
        --ControllerKill(controllerItem); --this breaks lipsync (fixes face idles though)
    end

    AgentAttach(agent_kenny, agent_boatGroupParent);
end

--main function that prepares the level enviorment
KTBM_Costumes_Kenny_AddToScene = function(kScene)
    --------------------------------------------------------
    --spawn the legend himself, kenny, into the scene

    local agent_kenny = AgentCreate("Kenny", "sk54_kenny202.prop", Vector(0,0,0), Vector(0,0,0), kScene, false, false);

    KTBM_PropertySet(agent_kenny, "Walk Animation - Idle", nil);
    --KTBM_PropertySet(agent_kenny, "Eye Look-At Properties", nil);
    KTBM_PropertySet(agent_kenny, "Walk Animation - Eyes", nil);
    KTBM_PropertySet(agent_kenny, "Walk Animation - Forward", nil);
    KTBM_PropertySet(agent_kenny, "Walk Animation - Idle Face", nil);
    --KTBM_PropertySet(agent_kenny, "Walk Animator - Enabled", false);
    --KTBM_PropertySet(agent_kenny, "talking", false);

    --get rid of any existing controllers he might have on him
    local kenny_originalControllers = AgentGetControllers(agent_kenny);
    
    for i, controllerItem in ipairs(kenny_originalControllers) do
        ControllerSetLooping(controllerItem, false);
        --ControllerStop(controllerItem); --this breaks lipsync (fixes face idles though)
        --ControllerKill(controllerItem); --this breaks lipsync (fixes face idles though)
    end
end