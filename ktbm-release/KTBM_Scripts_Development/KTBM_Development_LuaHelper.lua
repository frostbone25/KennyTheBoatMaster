--|||||||||||||||||||||||||||||||||||||||||||||| LUA HELPER ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| LUA HELPER ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| LUA HELPER ||||||||||||||||||||||||||||||||||||||||||||||

KTBM_LuaHelper_WriteSceneCleanupScript = function(kScene, luaSceneFunctionName, luaFilePath)
    local finalPath = "KTBMDevelopment/" .. luaFilePath;

    if(KTBM_FileExists(finalPath) == true) then
        KTBM_FileDelete(finalPath);
    else
        KTBM_DirectoryCreate("KTBMDevelopment");
    end

    local main_lua_file = io.open(finalPath, "a");
    local scene_agents = SceneGetAgents(kScene);
    local string_functionKSceneVariableName = "kScene";

    --||||||||||||||||||||||||||||||||||||||||||||||||||||| start of lua cleanup function |||||||||||||||||||||||||||||||||||||||||||||||||||||
    --||||||||||||||||||||||||||||||||||||||||||||||||||||| start of lua cleanup function |||||||||||||||||||||||||||||||||||||||||||||||||||||
    --||||||||||||||||||||||||||||||||||||||||||||||||||||| start of lua cleanup function |||||||||||||||||||||||||||||||||||||||||||||||||||||

    main_lua_file:write("", "\n");
    main_lua_file:write("KTBM_" .. luaSceneFunctionName .. " = function(" .. string_functionKSceneVariableName .. ")", "\n");
    main_lua_file:write("   ", "\n");

    --||||||||||||||||||||||||||||||||||||||||||||||||||||| sort scene agents into arrays |||||||||||||||||||||||||||||||||||||||||||||||||||||
    --||||||||||||||||||||||||||||||||||||||||||||||||||||| sort scene agents into arrays |||||||||||||||||||||||||||||||||||||||||||||||||||||
    --||||||||||||||||||||||||||||||||||||||||||||||||||||| sort scene agents into arrays |||||||||||||||||||||||||||||||||||||||||||||||||||||

    local stringArray_adv_agentNames = {};
    local stringArray_obj_agentNames = {};
    local stringArray_cam_agentNames = {};
    local stringArray_ui_agentNames = {};
    local stringArray_fx_agentNames = {};
    local stringArray_fxGroup_agentNames = {};
    local stringArray_module_agentNames = {};
    local stringArray_group_agentNames = {};
    local stringArray_light_agentNames = {};
    local stringArray_light_CHAR_CC_agentNames = {};
    local stringArray_lightrig_CC_agentNames = {};
    local stringArray_lightrotation_CC_agentNames = {};
    local stringArray_charLightComposer_agentNames = {};
    local stringArray_unsorted_agentNames = {};

    for i, agent_sceneAgent in pairs(scene_agents) do
        local string_agentName = tostring(AgentGetName(agent_sceneAgent))

        local subString3 = string.sub(string_agentName, 1, 3);
        local subString4 = string.sub(string_agentName, 1, 4);
        local subString6 = string.sub(string_agentName, 1, 6);
        local subString7 = string.sub(string_agentName, 1, 7);
        local subString8 = string.sub(string_agentName, 1, 8);
        local subString9 = string.sub(string_agentName, 1, 9);
        local subString12 = string.sub(string_agentName, 1, 12);
        local subString14 = string.sub(string_agentName, 1, 14);
        local subString17 = string.sub(string_agentName, 1, 17);
        local subString18 = string.sub(string_agentName, 1, 18);

        if (subString4 == "adv_") then
            table.insert(stringArray_adv_agentNames, string_agentName);
        elseif (subString4 == "obj_") then
            table.insert(stringArray_obj_agentNames, string_agentName);
        elseif (subString4 == "cam_") then
            table.insert(stringArray_cam_agentNames, string_agentName);
        elseif (subString3 == "ui_") then
            table.insert(stringArray_ui_agentNames, string_agentName);
        elseif (subString3 == "fx_") then
            table.insert(stringArray_fx_agentNames, string_agentName);
        elseif (subString8 == "fxGroup_") then
            table.insert(stringArray_fxGroup_agentNames, string_agentName);
        elseif (subString7 == "module_") then
            table.insert(stringArray_module_agentNames, string_agentName);
        elseif (subString6 == "group_") then
            table.insert(stringArray_group_agentNames, string_agentName);
        elseif (subString14 == "light_CHAR_CC_") then
            table.insert(stringArray_light_CHAR_CC_agentNames, string_agentName);
        elseif (subString6 == "light_") then
            table.insert(stringArray_light_agentNames, string_agentName);
        elseif (subString9 == "lightrig_") then
            table.insert(stringArray_lightrig_CC_agentNames, string_agentName);
        elseif (subString17 == "lightrotation_CC_") then
            table.insert(stringArray_lightrotation_CC_agentNames, string_agentName);
        elseif (subString18 == "charLightComposer_") then
            table.insert(stringArray_charLightComposer_agentNames, string_agentName);
        else
            table.insert(stringArray_unsorted_agentNames, string_agentName);
        end
    end

    --reference
    --KTBM_RemoveAgent("light_river_amb", relightScene)

    --||||||||||||||||||||||||||||||||||||||||||||||||||||| adv_ |||||||||||||||||||||||||||||||||||||||||||||||||||||
    --||||||||||||||||||||||||||||||||||||||||||||||||||||| adv_ |||||||||||||||||||||||||||||||||||||||||||||||||||||
    --||||||||||||||||||||||||||||||||||||||||||||||||||||| adv_ |||||||||||||||||||||||||||||||||||||||||||||||||||||

    main_lua_file:write("   --adv agents", "\n");
    for i, string_adv_agentName in pairs(stringArray_adv_agentNames) do
        main_lua_file:write("   --KTBM_RemoveAgent(" .. '"' .. string_adv_agentName .. '"' .. ", " .. string_functionKSceneVariableName .. ");", "\n");
    end
    main_lua_file:write("   ", "\n");

    --||||||||||||||||||||||||||||||||||||||||||||||||||||| obj_ |||||||||||||||||||||||||||||||||||||||||||||||||||||
    --||||||||||||||||||||||||||||||||||||||||||||||||||||| obj_ |||||||||||||||||||||||||||||||||||||||||||||||||||||
    --||||||||||||||||||||||||||||||||||||||||||||||||||||| obj_ |||||||||||||||||||||||||||||||||||||||||||||||||||||

    main_lua_file:write("   --obj agents", "\n");
    for i, string_obj_agentName in pairs(stringArray_obj_agentNames) do
        main_lua_file:write("   --KTBM_RemoveAgent(" .. '"' .. string_obj_agentName .. '"' .. ", " .. string_functionKSceneVariableName .. ");", "\n");
    end
    main_lua_file:write("   ", "\n");

    --||||||||||||||||||||||||||||||||||||||||||||||||||||| cam_ |||||||||||||||||||||||||||||||||||||||||||||||||||||
    --||||||||||||||||||||||||||||||||||||||||||||||||||||| cam_ |||||||||||||||||||||||||||||||||||||||||||||||||||||
    --||||||||||||||||||||||||||||||||||||||||||||||||||||| cam_ |||||||||||||||||||||||||||||||||||||||||||||||||||||

    main_lua_file:write("   --cam agents", "\n");
    for i, string_cam_agentName in pairs(stringArray_cam_agentNames) do
        main_lua_file:write("   --KTBM_RemoveAgent(" .. '"' .. string_cam_agentName .. '"' .. ", " .. string_functionKSceneVariableName .. ");", "\n");
    end
    main_lua_file:write("   ", "\n");

    --||||||||||||||||||||||||||||||||||||||||||||||||||||| ui_ |||||||||||||||||||||||||||||||||||||||||||||||||||||
    --||||||||||||||||||||||||||||||||||||||||||||||||||||| ui_ |||||||||||||||||||||||||||||||||||||||||||||||||||||
    --||||||||||||||||||||||||||||||||||||||||||||||||||||| ui_ |||||||||||||||||||||||||||||||||||||||||||||||||||||

    main_lua_file:write("   --ui agents", "\n");
    for i, string_ui_agentName in pairs(stringArray_ui_agentNames) do
        main_lua_file:write("   --KTBM_RemoveAgent(" .. '"' .. string_ui_agentName .. '"' .. ", " .. string_functionKSceneVariableName .. ");", "\n");
    end
    main_lua_file:write("   ", "\n");

    --||||||||||||||||||||||||||||||||||||||||||||||||||||| fx_ |||||||||||||||||||||||||||||||||||||||||||||||||||||
    --||||||||||||||||||||||||||||||||||||||||||||||||||||| fx_ |||||||||||||||||||||||||||||||||||||||||||||||||||||
    --||||||||||||||||||||||||||||||||||||||||||||||||||||| fx_ |||||||||||||||||||||||||||||||||||||||||||||||||||||

    main_lua_file:write("   --fx agents", "\n");
    for i, string_fx_agentName in pairs(stringArray_fx_agentNames) do
        main_lua_file:write("   --KTBM_RemoveAgent(" .. '"' .. string_fx_agentName .. '"' .. ", " .. string_functionKSceneVariableName .. ");", "\n");
    end
    main_lua_file:write("   ", "\n");

    --||||||||||||||||||||||||||||||||||||||||||||||||||||| fxGroup_ |||||||||||||||||||||||||||||||||||||||||||||||||||||
    --||||||||||||||||||||||||||||||||||||||||||||||||||||| fxGroup_ |||||||||||||||||||||||||||||||||||||||||||||||||||||
    --||||||||||||||||||||||||||||||||||||||||||||||||||||| fxGroup_ |||||||||||||||||||||||||||||||||||||||||||||||||||||

    main_lua_file:write("   --fxGroup agents", "\n");
    for i, string_fxGroup_agentName in pairs(stringArray_fxGroup_agentNames) do
        main_lua_file:write("   --KTBM_RemoveAgent(" .. '"' .. string_fxGroup_agentName .. '"' .. ", " .. string_functionKSceneVariableName .. ");", "\n");
    end
    main_lua_file:write("   ", "\n");

    --||||||||||||||||||||||||||||||||||||||||||||||||||||| module_ |||||||||||||||||||||||||||||||||||||||||||||||||||||
    --||||||||||||||||||||||||||||||||||||||||||||||||||||| module_ |||||||||||||||||||||||||||||||||||||||||||||||||||||
    --||||||||||||||||||||||||||||||||||||||||||||||||||||| module_ |||||||||||||||||||||||||||||||||||||||||||||||||||||

    main_lua_file:write("   --module agents", "\n");
    for i, string_module_agentName in pairs(stringArray_module_agentNames) do
        main_lua_file:write("   --KTBM_RemoveAgent(" .. '"' .. string_module_agentName .. '"' .. ", " .. string_functionKSceneVariableName .. ");", "\n");
    end
    main_lua_file:write("   ", "\n");

    --||||||||||||||||||||||||||||||||||||||||||||||||||||| group_ |||||||||||||||||||||||||||||||||||||||||||||||||||||
    --||||||||||||||||||||||||||||||||||||||||||||||||||||| group_ |||||||||||||||||||||||||||||||||||||||||||||||||||||
    --||||||||||||||||||||||||||||||||||||||||||||||||||||| group_ |||||||||||||||||||||||||||||||||||||||||||||||||||||

    main_lua_file:write("   --group agents", "\n");
    for i, string_group_agentName in pairs(stringArray_group_agentNames) do
        main_lua_file:write("   --KTBM_RemoveAgent(" .. '"' .. string_group_agentName .. '"' .. ", " .. string_functionKSceneVariableName .. ");", "\n");
    end
    main_lua_file:write("   ", "\n");

    --||||||||||||||||||||||||||||||||||||||||||||||||||||| light_ |||||||||||||||||||||||||||||||||||||||||||||||||||||
    --||||||||||||||||||||||||||||||||||||||||||||||||||||| light_ |||||||||||||||||||||||||||||||||||||||||||||||||||||
    --||||||||||||||||||||||||||||||||||||||||||||||||||||| light_ |||||||||||||||||||||||||||||||||||||||||||||||||||||

    main_lua_file:write("   --light agents", "\n");
    for i, string_light_agentName in pairs(stringArray_light_agentNames) do
        local lightAgent = AgentFindInScene(string_light_agentName, kScene);
        local lightTypeValue = KTBM_AgentGetProperty(string_light_agentName, "EnvLight - Type", kScene);
        local lightTypeValueString = KTBM_Enum_T3LightEnvType_ToString(lightTypeValue);
        local lightLuaComment = "--Light Type: " .. tostring(lightTypeValueString);

        main_lua_file:write("   KTBM_RemoveAgent(" .. '"' .. string_light_agentName .. '"' .. ", " .. string_functionKSceneVariableName .. "); " .. lightLuaComment, "\n");
    end
    main_lua_file:write("   ", "\n");

    --||||||||||||||||||||||||||||||||||||||||||||||||||||| light_CHAR_CC_ |||||||||||||||||||||||||||||||||||||||||||||||||||||
    --||||||||||||||||||||||||||||||||||||||||||||||||||||| light_CHAR_CC_ |||||||||||||||||||||||||||||||||||||||||||||||||||||
    --||||||||||||||||||||||||||||||||||||||||||||||||||||| light_CHAR_CC_ |||||||||||||||||||||||||||||||||||||||||||||||||||||

    main_lua_file:write("   --light_CHAR_CC agents", "\n");
    for i, string_light_CHAR_CC_agentName in pairs(stringArray_light_CHAR_CC_agentNames) do
        main_lua_file:write("   KTBM_RemoveAgent(" .. '"' .. string_light_CHAR_CC_agentName .. '"' .. ", " .. string_functionKSceneVariableName .. ");", "\n");
    end
    main_lua_file:write("   ", "\n");

    --||||||||||||||||||||||||||||||||||||||||||||||||||||| lightrig_CC_ |||||||||||||||||||||||||||||||||||||||||||||||||||||
    --||||||||||||||||||||||||||||||||||||||||||||||||||||| lightrig_CC_ |||||||||||||||||||||||||||||||||||||||||||||||||||||
    --||||||||||||||||||||||||||||||||||||||||||||||||||||| lightrig_CC_ |||||||||||||||||||||||||||||||||||||||||||||||||||||

    main_lua_file:write("   --lightrig_CC agents", "\n");
    for i, string_lightrig_CC_agentName in pairs(stringArray_lightrig_CC_agentNames) do
        main_lua_file:write("   KTBM_RemoveAgent(" .. '"' .. string_lightrig_CC_agentName .. '"' .. ", " .. string_functionKSceneVariableName .. ");", "\n");
    end
    main_lua_file:write("   ", "\n");

    --||||||||||||||||||||||||||||||||||||||||||||||||||||| lightrotation_CC_ |||||||||||||||||||||||||||||||||||||||||||||||||||||
    --||||||||||||||||||||||||||||||||||||||||||||||||||||| lightrotation_CC_ |||||||||||||||||||||||||||||||||||||||||||||||||||||
    --||||||||||||||||||||||||||||||||||||||||||||||||||||| lightrotation_CC_ |||||||||||||||||||||||||||||||||||||||||||||||||||||

    main_lua_file:write("   --lightrotation_CC agents", "\n");
    for i, string_lightrotation_CC_agentName in pairs(stringArray_lightrotation_CC_agentNames) do
        main_lua_file:write("   KTBM_RemoveAgent(" .. '"' .. string_lightrotation_CC_agentName .. '"' .. ", " .. string_functionKSceneVariableName .. ");", "\n");
    end
    main_lua_file:write("   ", "\n");

    --||||||||||||||||||||||||||||||||||||||||||||||||||||| charLightComposer_ |||||||||||||||||||||||||||||||||||||||||||||||||||||
    --||||||||||||||||||||||||||||||||||||||||||||||||||||| charLightComposer_ |||||||||||||||||||||||||||||||||||||||||||||||||||||
    --||||||||||||||||||||||||||||||||||||||||||||||||||||| charLightComposer_ |||||||||||||||||||||||||||||||||||||||||||||||||||||

    main_lua_file:write("   --charLightComposer agents", "\n");
    for i, string_charLightComposer_agentName in pairs(stringArray_charLightComposer_agentNames) do
        main_lua_file:write("   KTBM_RemoveAgent(" .. '"' .. string_charLightComposer_agentName .. '"' .. ", " .. string_functionKSceneVariableName .. ");", "\n");
    end
    main_lua_file:write("   ", "\n");

    --||||||||||||||||||||||||||||||||||||||||||||||||||||| unsorted |||||||||||||||||||||||||||||||||||||||||||||||||||||
    --||||||||||||||||||||||||||||||||||||||||||||||||||||| unsorted |||||||||||||||||||||||||||||||||||||||||||||||||||||
    --||||||||||||||||||||||||||||||||||||||||||||||||||||| unsorted |||||||||||||||||||||||||||||||||||||||||||||||||||||

    main_lua_file:write("   --unsorted agents", "\n");
    for i, string_unsorted_agentName in pairs(stringArray_unsorted_agentNames) do
        main_lua_file:write("   --KTBM_RemoveAgent(" .. '"' .. string_unsorted_agentName .. '"' .. ", " .. string_functionKSceneVariableName .. ");", "\n");
    end

    --||||||||||||||||||||||||||||||||||||||||||||||||||||| end of lua cleanup function |||||||||||||||||||||||||||||||||||||||||||||||||||||
    --||||||||||||||||||||||||||||||||||||||||||||||||||||| end of lua cleanup function |||||||||||||||||||||||||||||||||||||||||||||||||||||
    --||||||||||||||||||||||||||||||||||||||||||||||||||||| end of lua cleanup function |||||||||||||||||||||||||||||||||||||||||||||||||||||

    main_lua_file:write("   ", "\n");
    main_lua_file:write("end", "\n");
    main_lua_file:write("", "\n");
    main_lua_file:close();
end