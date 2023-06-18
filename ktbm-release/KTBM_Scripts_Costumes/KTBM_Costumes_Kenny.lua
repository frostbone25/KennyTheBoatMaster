KTBM_Costumes_Kenny_SelectedOutfit = "202";
KTBM_Costumes_Kenny_PropList = {
    "sk54_kenny", --Season 1 Episode 1 Kenny (white whirt, grey pants)
    "sk54_kennyAltShirt", --Season 1 Episode 2 Kenny (green shirt ontop of white long sleeves, grey pants)
    "sk54_kenny103", --Season 1 Episode 3 Kenny (black shirt ontop of white long sleeves with backpack, grey pants)
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

    if(string.match(KTBM_Costumes_Kenny_SelectedOutfit, "103Pack")) then
        KTBM_Costumes_Kenny_SetCostume_To103Pack(kScene);
    end

    if(string.match(KTBM_Costumes_Kenny_SelectedOutfit, "202")) then
        KTBM_Costumes_Kenny_SetCostume_To202(kScene);
    end
end

KTBM_Costumes_Kenny_SetCostume_To101 = function(kScene)
    local kennyCostumeProxy = AgentCreate("KennyCostumeProxy", "sk54_kenny.prop", Vector(0,0,0), Vector(0,0,0), kScene, false, false);
    local kennyCostumeProxy_mesh = KTBM_AgentGetProperty("KennyCostumeProxy", "D3D Mesh", kScene);
    local kennyCostumeProxy_meshes = KTBM_AgentGetProperty("KennyCostumeProxy", "D3D Mesh List", kScene);
    --local kennyCostumeProxy_skeleton = KTBM_AgentGetProperty("KennyCostumeProxy", "Skeleton File", kScene);
    --local kennyCostumeProxy_skeletonFace = KTBM_AgentGetProperty("KennyCostumeProxy", "Skeleton Face", kScene);
    --local kennyCostumeProxy_skeletonBody = KTBM_AgentGetProperty("KennyCostumeProxy", "Skeleton Body", kScene);

    KTBM_AgentSetProperty("Kenny", "D3D Mesh List", nil, kScene);
    KTBM_AgentSetProperty("Kenny", "D3D Mesh", nil, kScene);
    --KTBM_AgentSetProperty("Kenny", "Skeleton File", nil, kScene);
    --KTBM_AgentSetProperty("Kenny", "Skeleton Face", nil, kScene);
    --KTBM_AgentSetProperty("Kenny", "Skeleton Body", nil, kScene);

    KTBM_AgentSetProperty("Kenny", "Mesh sk54_kenny202 - Visible", false, kScene);

    KTBM_AgentSetProperty("Kenny", "D3D Mesh List", kennyCostumeProxy_meshes, kScene);
    KTBM_AgentSetProperty("Kenny", "D3D Mesh", kennyCostumeProxy_mesh, kScene);
    --KTBM_AgentSetProperty("Kenny", "Skeleton File", kennyCostumeProxy_skeleton, kScene);
    --KTBM_AgentSetProperty("Kenny", "Skeleton Face", kennyCostumeProxy_skeletonFace, kScene);
    --KTBM_AgentSetProperty("Kenny", "Skeleton Body", kennyCostumeProxy_skeletonBody, kScene);

    AgentDestroy(kennyCostumeProxy);

    KTBM_Costumes_Kenny_SelectedOutfit = "101";

    if(KTBM_Data_PlayerSettings ~= nil) then
        KTBM_Data_PlayerSettings.Gameplay.KennyOutfitProfile = KTBM_Costumes_Kenny_SelectedOutfit;
        KTBM_Data_Configuration_Save();
    end

    RenderDelay(1);
end

KTBM_Costumes_Kenny_SetCostume_To102 = function(kScene)
    local kennyCostumeProxy = AgentCreate("KennyCostumeProxy", "sk54_kennyAltShirt.prop", Vector(0,0,0), Vector(0,0,0), kScene, false, false);
    local kennyCostumeProxy_mesh = KTBM_AgentGetProperty("KennyCostumeProxy", "D3D Mesh", kScene);
    local kennyCostumeProxy_meshes = KTBM_AgentGetProperty("KennyCostumeProxy", "D3D Mesh List", kScene);

    KTBM_AgentSetProperty("Kenny", "D3D Mesh List", nil, kScene);
    KTBM_AgentSetProperty("Kenny", "D3D Mesh", nil, kScene);

    KTBM_AgentSetProperty("Kenny", "Mesh sk54_kenny202 - Visible", false, kScene);

    KTBM_AgentSetProperty("Kenny", "D3D Mesh List", kennyCostumeProxy_meshes, kScene);
    KTBM_AgentSetProperty("Kenny", "D3D Mesh", kennyCostumeProxy_mesh, kScene);

    AgentDestroy(kennyCostumeProxy);

    KTBM_Costumes_Kenny_SelectedOutfit = "102";

    if(KTBM_Data_PlayerSettings ~= nil) then
        KTBM_Data_PlayerSettings.Gameplay.KennyOutfitProfile = KTBM_Costumes_Kenny_SelectedOutfit;
        KTBM_Data_Configuration_Save();
    end

    RenderDelay(1);
end

KTBM_Costumes_Kenny_SetCostume_To103 = function(kScene)
    local kennyCostumeProxy = AgentCreate("KennyCostumeProxy", "sk54_kennyFlashback.prop", Vector(0,0,0), Vector(0,0,0), kScene, false, false);
    local kennyCostumeProxy_mesh = KTBM_AgentGetProperty("KennyCostumeProxy", "D3D Mesh", kScene);
    local kennyCostumeProxy_meshes = KTBM_AgentGetProperty("KennyCostumeProxy", "D3D Mesh List", kScene);

    KTBM_AgentSetProperty("Kenny", "D3D Mesh List", nil, kScene);
    KTBM_AgentSetProperty("Kenny", "D3D Mesh", nil, kScene);

    KTBM_AgentSetProperty("Kenny", "Mesh sk54_kenny202 - Visible", false, kScene);

    KTBM_AgentSetProperty("Kenny", "D3D Mesh List", kennyCostumeProxy_meshes, kScene);
    KTBM_AgentSetProperty("Kenny", "D3D Mesh", kennyCostumeProxy_mesh, kScene);

    AgentDestroy(kennyCostumeProxy);

    KTBM_Costumes_Kenny_SelectedOutfit = "103";

    if(KTBM_Data_PlayerSettings ~= nil) then
        KTBM_Data_PlayerSettings.Gameplay.KennyOutfitProfile = KTBM_Costumes_Kenny_SelectedOutfit;
        KTBM_Data_Configuration_Save();
    end

    RenderDelay(1);
end

KTBM_Costumes_Kenny_SetCostume_To103Pack = function(kScene)
    local kennyCostumeProxy = AgentCreate("KennyCostumeProxy", "sk54_kenny103.prop", Vector(0,0,0), Vector(0,0,0), kScene, false, false);
    local kennyCostumeProxy_mesh = KTBM_AgentGetProperty("KennyCostumeProxy", "D3D Mesh", kScene);
    local kennyCostumeProxy_meshes = KTBM_AgentGetProperty("KennyCostumeProxy", "D3D Mesh List", kScene);

    KTBM_AgentSetProperty("Kenny", "D3D Mesh List", nil, kScene);
    KTBM_AgentSetProperty("Kenny", "D3D Mesh", nil, kScene);

    KTBM_AgentSetProperty("Kenny", "Mesh sk54_kenny202 - Visible", false, kScene);

    KTBM_AgentSetProperty("Kenny", "D3D Mesh List", kennyCostumeProxy_meshes, kScene);
    KTBM_AgentSetProperty("Kenny", "D3D Mesh", kennyCostumeProxy_mesh, kScene);

    AgentDestroy(kennyCostumeProxy);

    KTBM_Costumes_Kenny_SelectedOutfit = "103Pack";

    if(KTBM_Data_PlayerSettings ~= nil) then
        KTBM_Data_PlayerSettings.Gameplay.KennyOutfitProfile = KTBM_Costumes_Kenny_SelectedOutfit;
        KTBM_Data_Configuration_Save();
    end

    RenderDelay(1);
end

KTBM_Costumes_Kenny_SetCostume_To202 = function(kScene)
    local kennyCostumeProxy = AgentCreate("KennyCostumeProxy", "sk54_kenny202.prop", Vector(0,0,0), Vector(0,0,0), kScene, false, false);
    local kennyCostumeProxy_mesh = KTBM_AgentGetProperty("KennyCostumeProxy", "D3D Mesh", kScene);
    local kennyCostumeProxy_meshes = KTBM_AgentGetProperty("KennyCostumeProxy", "D3D Mesh List", kScene);

    KTBM_AgentSetProperty("Kenny", "D3D Mesh List", nil, kScene);
    KTBM_AgentSetProperty("Kenny", "D3D Mesh", nil, kScene);

    KTBM_AgentSetProperty("Kenny", "Mesh sk54_kenny202 - Visible", true, kScene);

    KTBM_AgentSetProperty("Kenny", "D3D Mesh List", kennyCostumeProxy_meshes, kScene);
    KTBM_AgentSetProperty("Kenny", "D3D Mesh", kennyCostumeProxy_mesh, kScene);

    AgentDestroy(kennyCostumeProxy);

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
    local boatGroupParent_agent = AgentFindInScene("BoatGroup", kScene);

    --------------------------------------------------------
    --spawn the legend himself, kenny, into the scene

    local kenny_agent = AgentCreate("Kenny", "sk54_kenny202.prop", Vector(0,0,0), Vector(0,0,0), kScene, false, false);

    KTBM_AgentSetProperty("Kenny", "Walk Animation - Idle", nil, kScene)
    --KTBM_AgentSetProperty("Kenny", "Eye Look-At Properties", nil, kScene)
    KTBM_AgentSetProperty("Kenny", "Walk Animation - Eyes", nil, kScene)
    KTBM_AgentSetProperty("Kenny", "Walk Animation - Forward", nil, kScene)
    KTBM_AgentSetProperty("Kenny", "Walk Animation - Idle Face", nil, kScene)
    --KTBM_AgentSetProperty("Kenny", "Walk Animator - Enabled", false, kScene)
    --KTBM_AgentSetProperty("Kenny", "talking", false, kScene)

    --get rid of any existing controllers he might have on him
    local kenny_originalControllers = AgentGetControllers(kenny_agent);
    
    for i, controllerItem in ipairs(kenny_originalControllers) do
        ControllerSetLooping(controllerItem, false);
        --ControllerStop(controllerItem); --this breaks lipsync (fixes face idles though)
        --ControllerKill(controllerItem); --this breaks lipsync (fixes face idles though)
    end

    AgentAttach(kenny_agent, boatGroupParent_agent);
end

--main function that prepares the level enviorment
KTBM_Costumes_Kenny_AddToScene = function(kScene)
    --------------------------------------------------------
    --spawn the legend himself, kenny, into the scene

    local kenny_agent = AgentCreate("Kenny", "sk54_kenny202.prop", Vector(0,0,0), Vector(0,0,0), kScene, false, false);

    KTBM_AgentSetProperty("Kenny", "Walk Animation - Idle", nil, kScene)
    --KTBM_AgentSetProperty("Kenny", "Eye Look-At Properties", nil, kScene)
    KTBM_AgentSetProperty("Kenny", "Walk Animation - Eyes", nil, kScene)
    KTBM_AgentSetProperty("Kenny", "Walk Animation - Forward", nil, kScene)
    KTBM_AgentSetProperty("Kenny", "Walk Animation - Idle Face", nil, kScene)
    --KTBM_AgentSetProperty("Kenny", "Walk Animator - Enabled", false, kScene)
    --KTBM_AgentSetProperty("Kenny", "talking", false, kScene)

    --get rid of any existing controllers he might have on him
    local kenny_originalControllers = AgentGetControllers(kenny_agent);
    
    for i, controllerItem in ipairs(kenny_originalControllers) do
        ControllerSetLooping(controllerItem, false);
        --ControllerStop(controllerItem); --this breaks lipsync (fixes face idles though)
        --ControllerKill(controllerItem); --this breaks lipsync (fixes face idles though)
    end
end