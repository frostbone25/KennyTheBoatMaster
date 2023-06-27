KTBM_Gameplay_EnvironmentScrolling_AgentsCount = 5;
KTBM_Gameplay_EnvironmentScrolling_Agents = {
    EnvironmentAgent1 = {
        AgentName = "obj_flagshipExteriorDeckLandA",
        AgentPosition = Vector(KTBM_Gameplay_EnvironmentHorizontalBoundarySize, 0, 0),
        AgentRotation = Vector(0, 90, 0)
    },
    EnvironmentAgent2 = {
        AgentName = "obj_flagshipExteriorDeckLandB",
        AgentPosition = Vector(KTBM_Gameplay_EnvironmentHorizontalBoundarySize, 0, 0),
        AgentRotation = Vector(0, 90, 0)
    },
    EnvironmentAgent3 = {
        AgentName = "obj_flagshipExteriorDeckLandC",
        AgentPosition = Vector(KTBM_Gameplay_EnvironmentHorizontalBoundarySize, 0, 0),
        AgentRotation = Vector(0, 90, 0)
    },
    EnvironmentAgent4 = {
        AgentName = "obj_flagshipExteriorDeckLandD",
        AgentPosition = Vector(KTBM_Gameplay_EnvironmentHorizontalBoundarySize, 0, 0),
        AgentRotation = Vector(0, 90, 0)
    },
    EnvironmentAgent5 = {
        AgentName = "obj_flagshipExteriorDeckLandE",
        AgentPosition = Vector(KTBM_Gameplay_EnvironmentHorizontalBoundarySize, 0, 0),
        AgentRotation = Vector(0, 90, 0)
    }
};

KTBM_Gameplay_EnvironmentScrolling = function()
    if(KTBM_Gameplay_State_HasCrashed == true) or (KTBM_Gameplay_State_Paused == true) then
        return;
    end

    local deltaTime = GetFrameTime();

    for index = 1, KTBM_Gameplay_EnvironmentScrolling_AgentsCount do
        local string_EnvironmentAgentElementArray = "EnvironmentAgent" .. tostring(index);
        local object_EnvironmentAgent = KTBM_Gameplay_EnvironmentScrolling_Agents[string_EnvironmentAgentElementArray];

        local string_agentName = object_EnvironmentAgent["AgentName"];
        local vector_agentPosition =  object_EnvironmentAgent["AgentPosition"];
        local vector_agentRotation =  object_EnvironmentAgent["AgentRotation"];

        local agent_Environment = AgentFindInScene(string_agentName, KTBM_Gameplay_kScene);

        local vector_currentPosition = AgentGetWorldPos(agent_Environment);

        vector_agentPosition.z = vector_currentPosition.z - (KTBM_Gameplay_EnvironmentCurrentMovementSpeed * deltaTime);
        vector_agentPosition.y = KTBM_Gameplay_EnvironmentHeightOffset + KTBM_Gameplay_EnvironmentSpawnHeight;

        if(vector_agentPosition.z < KTBM_Gameplay_EnvironmentMinimumDistance) then
            vector_agentPosition.z = KTBM_Gameplay_EnvironmentDistanceSpawn;

            local randomInteger = KTBM_RandomIntegerValue(0, 3);

            if (randomInteger > 1) then
                vector_agentPosition.x = -KTBM_Gameplay_EnvironmentHorizontalBoundarySize;
                vector_agentRotation =  Vector(0, 90, 0);
            else
                vector_agentPosition.x = KTBM_Gameplay_EnvironmentHorizontalBoundarySize;
                vector_agentRotation =  Vector(0, -90, 0);
            end
        end

        AgentSetWorldPos(agent_Environment, vector_agentPosition); 
        AgentSetWorldRot(agent_Environment, vector_agentRotation); 
    end
end