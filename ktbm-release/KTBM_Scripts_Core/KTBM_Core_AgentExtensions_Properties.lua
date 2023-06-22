--[[
    This script has functions to help deal with properties on agents.

    Properties are essential to how the Telltale Tool works, agents can
    have many properties attached to them. These properties are usually
    responsible for many things, like controlling the color of a material,
    or controlling the scale of an object.

    Finding these properties can be tough especially since we don't have
    an editor, but many of these property names can be found through
    Telltale's native lua scripts in their data archives, or you can
    also extract strings from the Game.exe and find properties that way
    as well.

    NOTE: AgentFindInScene calls especially in a large bulk can be expensive.
]]

--||||||||||||||||||||||||| PROPERTIES - BOOLEAN |||||||||||||||||||||||||
--||||||||||||||||||||||||| PROPERTIES - BOOLEAN |||||||||||||||||||||||||
--||||||||||||||||||||||||| PROPERTIES - BOOLEAN |||||||||||||||||||||||||

--This finds an agent in a scene by its name, and checks if it has the given property.
--RETURNS: Boolean (True/False)
KTBM_AgentHasProperty = function(string_agentName, string_propertyName, string_scene)
    local agent_object = AgentFindInScene(string_agentName, string_scene);
    return AgentHasProperty(agent_object, string_propertyName);
end

--||||||||||||||||||||||||| PROPERTIES - SET |||||||||||||||||||||||||
--||||||||||||||||||||||||| PROPERTIES - SET |||||||||||||||||||||||||
--||||||||||||||||||||||||| PROPERTIES - SET |||||||||||||||||||||||||

--Given an agent, it sets a property on it.
--RETURNS: Nothing
--NOTE: type_propertyValue can be any value type.
KTBM_PropertySet = function(agent_object, string_propertyName, type_propertyValue)
    local propertySet_agentProps = AgentGetRuntimeProperties(agent_object);
    PropertySet(propertySet_agentProps, string_propertyName, type_propertyValue);
end

--Finds an agent in a scene by it's name, it sets a property on it.
--RETURNS: Nothing
--NOTE: type_propertyValue can be any value type.
KTBM_AgentSetProperty = function(string_agentName, string_propertyName, type_propertyValue, string_scene)
    local agent_object = AgentFindInScene(string_agentName, string_scene);
    KTBM_PropertySet(agent_object, string_propertyName, type_propertyValue);
end

--Finds an agent in a scene by it's name, and forcibly sets a property on it.
--RETURNS: Nothing
--NOTE: type_propertyValue can be any value type.
KTBM_AgentForceSetProperty = function(string_agentName, string_propertyName, string_propertyValueType, type_propertyValue, string_scene)
    local agent_object = AgentFindInScene(string_agentName, string_scene);
    local propertySet_agentObject = AgentGetProperties(agent_object);
	--local propertySet_agentObject = AgentGetRuntimeProperties(agent_object);

	if not (AgentHasProperty(agent_object, string_propertyName)) then
        PropertyCreate(propertySet_agentObject, string_propertyName, string_propertyValueType, type_propertyValue);
	end

    PropertySet(propertySet_agentObject, string_propertyName, type_propertyValue);
end

--Sets a property on all agents with the given prefix in a scene.
--RETURNS: Nothing
--NOTE: type_propertyValue can be any value type.
KTBM_SetPropertyOnAgentsWithPrefix = function(string_scene, string_prefix, string_propertyName, type_propertyValue)
    local agents_sceneAgents = SceneGetAgents(string_scene);

    for i, agent_sceneAgent in pairs(agents_sceneAgents) do
        local string_agentName = tostring(AgentGetName(agent_sceneAgent));

        if (string.match)(string_agentName, string_prefix) then
            KTBM_AgentSetProperty(string_agentName, string_propertyName, type_propertyValue, string_scene);
        end
    end
end

--Sets a property on all camera objects in a scene.
--RETURNS: Nothing
--NOTE: type_propertyValue can be any value type.
KTBM_SetPropertyOnAllCameras = function(string_scene, string_propertyName, type_propertyValue)
    local agents_sceneAgents = SceneGetAgents(string_scene);

    for i, agent_sceneAgent in pairs(agents_sceneAgents) do
        local string_agentName = tostring(AgentGetName(agent_sceneAgent));

        if (string.match)(string_agentName, "cam_") then
            KTBM_AgentSetProperty(string_agentName, string_propertyName, type_propertyValue, string_scene);
        end
    end
end

--Attempts to set all textures (by the texture name prefix) on an agent.
--RETURNS: Nothing
--NOTE: THIS REQUIRES A TEXT FILE WITH ALL TELLTALE PROP NAMES AND FILE NAMES ON IT (Most likely you won't have it)
--NOTE: type_newPropertyValue can be any value type.
KTBM_SetTexturesOnAgentWithNamePrefix = function(string_agentName, string_texturePrefix, type_newPropertyValue, string_cacheObjectListFileName, string_scene)
    local agent_object = AgentFindInScene(string_agentName, string_scene);
    local propertySet_agentObject = AgentGetProperties(agent_object);
    local propertyKeys_agentObject = PropertyGetKeys(propertySet_agentObject);
    
    local propertyKeys_textureKeys = {};

    for index1, propertyKey_key in ipairs(propertyKeys_agentObject) do
        local type_propertyValue = PropertyGet(propertySet_agentObject, propertyKey_key);

        if (type_propertyValue) then
            local string_propertyValue = tostring(type_propertyValue);

            if (string.match)(string_propertyValue, "Cached Object") then
                local string_shortened1 = string_propertyValue:gsub("Cached Object: ", "");
                local string_shortened2 = string_shortened1:gsub('"','');

                local file_propertyFileList = io.open(string_cacheObjectListFileName, "r");

                for string_line in file_propertyFileList:lines() do
                    if (string.find)(string_line, string_shortened2) then
                        if (string.find)(string_line, ".d3dtx") then
                            if (string.find)(string_line, string_texturePrefix) then
                                table.insert(propertyKeys_textureKeys, propertyKey_key);
                            end
                        end
                    end
                end

                file_propertyFileList:close();
            end
        end
    end

    for index2, propertyKey_textureKey in ipairs(propertyKeys_textureKeys) do
        PropertySet(propertySet_agentObject, propertyKey_textureKey, type_newPropertyValue);
    end
end

--Attempts to set all textures (by the texture name prefix) on all agents with the name prefix
--RETURNS: Nothing
--NOTE: THIS REQUIRES A TEXT FILE WITH ALL TELLTALE PROP NAMES AND FILE NAMES ON IT (Most likely you won't have it)
--NOTE: type_newPropertyValue can be any value type.
KTBM_SetTexturesOnAgentsWithNamePrefixes = function(string_agentNamePrefix, string_texturePrefix, type_newPropertyValue, string_cacheObjectListFileName, string_scene)
    local agents_sceneAgents = SceneGetAgents(string_scene);

    for index, agent_sceneAgent in pairs(agents_sceneAgents) do
        local string_agentName = tostring(AgentGetName(agent_sceneAgent));

        if (string.match)(string_agentName, string_agentNamePrefix) then
            KTBM_SetTexturesOnAgentWithNamePrefix(string_agentName, string_texturePrefix, type_newPropertyValue, string_cacheObjectListFileName, string_scene);
        end
    end
end

--Attempts to set all diffuse textures (by the texture name prefix) on all agents with the name prefix
--RETURNS: Nothing
--NOTE: THIS REQUIRES A TEXT FILE WITH ALL TELLTALE PROP NAMES AND FILE NAMES ON IT (Most likely you won't have it)
--NOTE: type_newPropertyValue can be any value type.
KTBM_SetDiffuseTexturesOnAgentsWithNamePrefixes = function(string_agentNamePrefix, type_newPropertyValue, string_cacheObjectListFileName, string_scene)
    local agents_sceneAgents = SceneGetAgents(string_scene);

    for index1, agent_sceneAgent in pairs(agents_sceneAgents) do
        local string_agentName = tostring(AgentGetName(agent_sceneAgent));

        if (string.match)(string_agentName, string_agentNamePrefix) then
            local agent_object = AgentFindInScene(string_agentName, string_scene);
            local propertySet_agentObject = AgentGetProperties(agent_object);
            local propertyKeys_agentObject = PropertyGetKeys(propertySet_agentObject);
    
            local propertyKeys_textureKeys = {};

            for index2, propertyKey_key in ipairs(propertyKeys_agentObject) do
                local type_propertyValue = PropertyGet(propertySet_agentObject, propertyKey_key);

                if (type_propertyValue) then
                    local string_propertyValue = tostring(type_propertyValue);

                    if (string.match)(string_propertyValue, "Cached Object") then
                        local string_shortened1 = string_propertyValue:gsub("Cached Object: ", "");
                        local string_shortened2 = string_shortened1:gsub('"','');

                        local file_propertyFileList = io.open(string_cacheObjectListFileName, "r")

                        for string_line in file_propertyFileList:lines() do
                            if (string.find)(string_line, string_shortened2) then
                                if (string.find)(string_line, ".d3dtx") then
                                    local bool_case1 = (string.find)(string_line, "_detail");
                                    local bool_case2 = (string.find)(string_line, "_ink");
                                    local bool_case3 = (string.find)(string_line, "_nm");
                                    local bool_case4 = (string.find)(string_line, "_bnm");
                                    local bool_case5 = (string.find)(string_line, "_spec");
                                    local bool_case6 = (string.find)(string_line, "_mask");
                                    local bool_case7 = (string.find)(string_line, "_microdetail");
                                    local bool_case8 = (string.find)(string_line, "_grime");
                                    local bool_combinedCases = (not bool_case1) and (not bool_case2) and (not bool_case3) and (not bool_case4) and (not bool_case5) and (not bool_case6) and (not bool_case7) and (not bool_case8);

                                    if(bool_combinedCases == true) then
                                        table.insert(propertyKeys_textureKeys, propertyKey_key);
                                    end
                                end
                            end
                        end

                        file_propertyFileList:close();
                    end
                end
            end

            for index3, propertyKey_textureKey in ipairs(propertyKeys_textureKeys) do
                PropertySet(propertySet_agentObject, propertyKey_textureKey, type_newPropertyValue);
            end
        end
    end
end

--||||||||||||||||||||||||| PROPERTIES - GET |||||||||||||||||||||||||
--||||||||||||||||||||||||| PROPERTIES - GET |||||||||||||||||||||||||
--||||||||||||||||||||||||| PROPERTIES - GET |||||||||||||||||||||||||

--Gets a property on a given agent.
--RETURNS: Dynamic type depending on the property
KTBM_PropertyGet = function(agent_object, string_propertyName)
    local propertySet_agentObject = AgentGetRuntimeProperties(agent_object);
    return PropertyGet(propertySet_agentObject, string_propertyName);
end

--Finds an agent in a scene by it's name and gets the property on it.
--RETURNS: Dynamic type depending on the property
KTBM_AgentGetProperty = function(string_agentName, string_propertyName, string_scene)
    local agent_object = AgentFindInScene(string_agentName, string_scene);
    return KTBM_PropertyGet(agent_object, string_propertyName);
end

--Finds an agent in a scene by it's name and gets the property set.
--RETURNS: PropertySet
KTBM_AgentGetProperties = function(string_agentName, string_scene)
    local agent_object = AgentFindInScene(string_agentName, string_scene);
    return AgentGetProperties(agent_object);
end

--Finds an agent in a scene by it's name and gets the runtime property set.
--RETURNS: PropertySet
KTBM_AgentGetRuntimeProperties = function(string_agentName, string_scene)
    local agent_object = AgentFindInScene(string_agentName, string_scene);
    return AgentGetRuntimeProperties(agent_object);
end