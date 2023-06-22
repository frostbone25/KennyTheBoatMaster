KTBM_Gameplay_RocksUpdate_LastRanTime = 0;
KTBM_Gameplay_Rocks_AgentArray = {};
KTBM_Gameplay_Rocks_PropArray = {
    "obj_rockA.prop",
    "obj_rockB.prop",
    "obj_rockC.prop",
    "obj_rockBoulderHiRez"
};

KTBM_Gameplay_RocksUpdate = function()
    if(KTBM_Gameplay_State_HasCrashed == true) or (KTBM_Core_Project_DebugDisableRocks == true) or (KTBM_Gameplay_State_Paused == true) then
        return;
    end

    -------------------------------------------------------
    --this measures the time in seconds between each frame
    --when we do any movement operations we want to multiply them by the frame time so that they are consistent across machines.
    local number_deltaTime = GetFrameTime();

    --this measures the total game time since the exectuable was started.
    --we use this for tracking the interval in which we spawn new objects (so we don't spawn stuff every frame)
    local number_totalGameTime = GetTotalTime();
    -------------------------------------------------------

    --Spawn a new rock (THIS RUNS ONLY ONCE PER "KTBM_Gameplay_RocksSpawnInterval" INTERVAL)
    if(number_totalGameTime > KTBM_Gameplay_RocksUpdate_LastRanTime) then
        local number_xPosition = KTBM_RandomFloatValue(-KTBM_Gameplay_RocksHorizontalBoundarySize, KTBM_Gameplay_RocksHorizontalBoundarySize, 1000);
        local number_yRotation = KTBM_RandomFloatValue(-180, 180, 1000);
        
        local vector_newRockPosition = Vector(number_xPosition, KTBM_Gameplay_EnvironmentHeightOffset + KTBM_Gameplay_RocksStartingHeight, KTBM_Gameplay_RocksStartingDistance);
        local vector_newRockRotation = Vector(0, number_yRotation, 0);

        local string_newRockName = "Rock" .. tostring(number_totalGameTime);

        local number_newRockPropFileIndex = KTBM_RandomIntegerValue(1, #KTBM_Gameplay_Rocks_PropArray);
        local string_newRockPropFile = KTBM_Gameplay_Rocks_PropArray[number_newRockPropFileIndex];

        local number_newRockSize = KTBM_RandomFloatValue(1, 5, 100);

        local agent_newRock = AgentCreate(string_newRockName, string_newRockPropFile, vector_newRockPosition, vector_newRockRotation, KTBM_Gameplay_kScene, false, false);
        KTBM_AgentSetProperty(string_newRockName, "Render Global Scale", number_newRockSize, KTBM_Gameplay_kScene);
        KTBM_AgentSetProperty(string_newRockName, "Render Cull", false, KTBM_Gameplay_kScene);
        KTBM_AgentSetProperty(string_newRockName, "Render Static", false, KTBM_Gameplay_kScene);

        --NOTE: IMPORTANT! Corrects the existing bounds on the object to factor in the scaling operations we are doing
        KTBM_Bounds_AgentSetCorrectBounds(agent_newRock);

        table.insert(KTBM_Gameplay_Rocks_AgentArray, agent_newRock);

        KTBM_Gameplay_RocksUpdate_LastRanTime = number_totalGameTime + KTBM_Gameplay_RocksSpawnInterval;
    end

    -------------------------------------------------------

    --FIX: Initalize a temporary local array that will keep track of the spawned rock agents that need to be deleted later
    --(We can't be deleting agents in an array that we are also iterating through currently as this causes some issues)
    local agentArray_rockAgentsToDelete = {};

    --Iterate through all of the spawned rock agents
    for index1 = 1, #KTBM_Gameplay_Rocks_AgentArray do
        local agent_rock = KTBM_Gameplay_Rocks_AgentArray[#KTBM_Gameplay_Rocks_AgentArray + 1 - index1];
        local string_rockAgentName = AgentGetName(agent_rock);

        local vector_currentRockPosition = AgentGetWorldPos(agent_rock);

        local number_newPosition_z = vector_currentRockPosition.z;
        local number_newPosition_y = vector_currentRockPosition.y;

        number_newPosition_z = number_newPosition_z - (KTBM_Gameplay_EnvironmentMovementSpeed * number_deltaTime);

        if(number_newPosition_y < 0 + KTBM_Gameplay_EnvironmentHeightOffset) then
            number_newPosition_y = number_newPosition_y + (KTBM_Gameplay_RocksHeightRiseSpeed * number_deltaTime);
        end

        local vector_newPosition = Vector(vector_currentRockPosition.x, number_newPosition_y, number_newPosition_z);

        AgentSetWorldPos(agent_rock, vector_newPosition); 

        --When the current position of the rock goes behind camera and is out of view
        if(vector_newPosition.z < KTBM_Gameplay_RocksMinimumDistance) then

            --FIX: Add it to a temporary local array to be deleted later
            table.insert(agentArray_rockAgentsToDelete, agent_rock);

        end
    end

    -------------------------------------------------------
    --FIX: Last thing here is to delete the objects that we "marked" earlier.
    --These are objects that are out of view of the camera and therefore should be discarded.
    --We don't want to keep spawning new agents and never getting rid of the old ones for performance and longevitiy sake.

    --Iterate through the agents marked for deletion
    for index2 = 1, #agentArray_rockAgentsToDelete do
        --get the agent object
        local agent_rockAgent = agentArray_rockAgentsToDelete[index2];

        --the index for the main rock agent array of the object that we will delete
        local tempIndex = nil;

        --iterate through the current rock agent array to make sure that it's the same object we have marked.
        for index3 = 1, #KTBM_Gameplay_Rocks_AgentArray do
            local agent_originalRockAgent = KTBM_Gameplay_Rocks_AgentArray[index3];

            --when we find it, get the index of it in the original array so we can remove it in a bit.
            if(agent_rockAgent == agent_originalRockAgent) then
                tempIndex = index3;
            end
        end

        --make sure that we assigned an index value, and remove the object from the original array
        if(tempIndex ~= nil) then
            table.remove(KTBM_Gameplay_Rocks_AgentArray, tempIndex);
        end

        --after removing it now from the original array, now we can actually destroy the agent.
        AgentDestroy(agent_rockAgent);
    end

    --SELF NOTE: no need to clear "KTBM_Gameplay_Rocks_AgentArray" because its not persistent.

end