--[[

]]

--[[
KTBM_Development_BoundsDebug_ExtentsDebugging = true;
KTBM_Development_BoundsDebug_Agents = {
    "SceneAgentName"
};
]]

--[[
KTBM_DevelopBoundsDebug_AgentBoundCorners = {
    AgentReference = nil,
    AgentCorner1 = nil,
    AgentCorner2 = nil,
    AgentCorner3 = nil,
    AgentCorner4 = nil,
    AgentCorner5 = nil,
    AgentCorner6 = nil,
    AgentCorner7 = nil,
    AgentCorner8 = nil
};

KTBM_DevelopBoundsDebug_AgentBoundExtents = {
    AgentReference = nil,
    AgentExtentsMin = nil,
    AgentExtentsMax = nil
};
]]

KTBM_DevelopBoundsDebug_AgentTextObjects_CornersCount = 0;
KTBM_DevelopBoundsDebug_AgentTextObjects_Corners = {};

KTBM_DevelopBoundsDebug_AgentTextObjects_ExtentsCount = 0;
KTBM_DevelopBoundsDebug_AgentTextObjects_Extents = {};

KTBM_Development_BoundsDebug_Initalize = function()


    for index, string_agentName in ipairs(KTBM_Development_BoundsDebug_Agents) do
        local string_newBoundObjectName = "Bounds" .. tostring(index);

        local agent_agentInScene = AgentFindInScene(string_agentName, KTBM_Development_SceneObject);


        if(agent_agentInScene ~= nil) then
            if(KTBM_Development_BoundsDebug_ExtentsDebugging == true) then
                local string_extentsMinAgentName = string_agentName .. "_ExtentsMin" .. tostring(index);
                local string_extentsMaxAgentName = string_agentName .. "_ExtentsMax" .. tostring(index);

                local string_extentsMinText = ".min " .. tostring(index) .. "";
                local string_extentsMaxText = ".max " .. tostring(index) .. "";

                local agent_extentsMin = KTBM_TextUI_CreateTextAgent(string_extentsMinAgentName, string_extentsMinText, Vector(0, 0, 0), 0, 0);
                local agent_extentsMax = KTBM_TextUI_CreateTextAgent(string_extentsMaxAgentName, string_extentsMaxText, Vector(0, 0, 0), 0, 0);

                TextSetColor(agent_extentsMin, Color(0.5, 1.0, 0.5, 1.0));
                TextSetColor(agent_extentsMax, Color(0.5, 1.0, 0.5, 1.0));
                TextSetScale(agent_extentsMin, 0.25);
                TextSetScale(agent_extentsMax, 0.25);

                local agentBoundExtents_newObject = {
                    AgentReference = agent_agentInScene,
                    AgentExtentsMin = agent_extentsMin,
                    AgentExtentsMax = agent_extentsMax
                };

                KTBM_DevelopBoundsDebug_AgentTextObjects_Extents[string_newBoundObjectName] = agentBoundExtents_newObject;
                KTBM_DevelopBoundsDebug_AgentTextObjects_ExtentsCount = KTBM_DevelopBoundsDebug_AgentTextObjects_ExtentsCount + 1;
            else
                --not implemented
            end
        end
        

    end

    
end

KTBM_Development_BoundsDebug_Update = function()  


    for index = 1, KTBM_DevelopBoundsDebug_AgentTextObjects_ExtentsCount do
        local string_boundObjectName = "Bounds" .. tostring(index);

        if(KTBM_Development_BoundsDebug_ExtentsDebugging == true) then
            local agentBoundExtents_object = KTBM_DevelopBoundsDebug_AgentTextObjects_Extents[string_boundObjectName];

            local agent_agentReference = agentBoundExtents_object["AgentReference"];
            local agent_extentsMin = agentBoundExtents_object["AgentExtentsMin"];
            local agent_extentsMax = agentBoundExtents_object["AgentExtentsMax"];

            local vector_extentsMin, vector_extentsMax = TextGetWorldExtents(agent_agentReference);
            --local vector_extentsMin = KTBM_PropertyGet(agent_agentReference, "Extents Min");
            --local vector_extentsMax = KTBM_PropertyGet(agent_agentReference, "Extents Max");
            local camera_sceneCamera = AgentGetCamera(agent_agentReference);
    
            vector_extentsMin = CameraGetScreenPosFromWorldPos(camera_sceneCamera, AgentLocalToWorld(agent_agentReference, vector_extentsMin));
            vector_extentsMax = CameraGetScreenPosFromWorldPos(camera_sceneCamera, AgentLocalToWorld(agent_agentReference, vector_extentsMax));

            --vector_extentsMin = AgentLocalToWorld(agent_agentReference, vector_extentsMin);
            --vector_extentsMax = AgentLocalToWorld(agent_agentReference, vector_extentsMax);

            AgentSetWorldPosFromLogicalScreenPos(agent_extentsMin, vector_extentsMin);
            AgentSetWorldPosFromLogicalScreenPos(agent_extentsMax, vector_extentsMax);
        else
            --not implemented
        end
    end


end