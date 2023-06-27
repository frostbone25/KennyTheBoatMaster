KTBM_Gameplay_ZombiesUpdate_LastRanTime = 0;
KTBM_Gameplay_Zombies_AgentGroupArray = {};
KTBM_Gameplay_Zombies_PropArray = {
    "sk54_zombieScavengerA.prop",
    "sk54_zombieScavengerB.prop",
    "sk54_zombieScavengerC.prop",
    "sk55_zombieAverage200.prop",
    "sk54_zombieTree.prop",
    "sk54_zombieShed.prop"
};

KTBM_Gameplay_ZombiesUpdate = function()
    if(KTBM_Gameplay_State_HasCrashed == true) or (KTBM_Core_Project_DebugDisableZombies == true) or (KTBM_Gameplay_State_Paused == true) then
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

    --Spawn a new zombie (THIS RUNS ONLY ONCE PER "KTBM_Gameplay_ZombiesSpawnInterval" INTERVAL)
    if(number_totalGameTime > KTBM_Gameplay_ZombiesUpdate_LastRanTime) then
        local number_xPosition = KTBM_RandomFloatValue(-KTBM_Gameplay_ZombiesHorizontalBoundarySize, KTBM_Gameplay_ZombiesHorizontalBoundarySize, 1000);

        local vector_newZombiePosition = Vector(number_xPosition, KTBM_Gameplay_EnvironmentHeightOffset + KTBM_Gameplay_ZombiesStartingHeight, KTBM_Gameplay_ZombiesStartingDistance);
        local vector_newZombieRotation = Vector(0, 180, 0);

        local string_newZombieName = "Zombie" .. tostring(number_totalGameTime);
        local string_newZombieGroupName = "ZombieGroup" .. tostring(number_totalGameTime);

        local number_newZombiePropFileIndex = KTBM_RandomIntegerValue(1, #KTBM_Gameplay_Zombies_PropArray);
        local string_newZombiePropFile = KTBM_Gameplay_Zombies_PropArray[number_newZombiePropFileIndex];

        --NOTE: When spawning zombies, they already have animations on them.
        --These animations modify their root position, which forces them to be at world origin (0, 0, 0).
        --This is a problem since we want to move their position/rotation in the scene.
        local agent_newZombie = AgentCreate(string_newZombieName, string_newZombiePropFile, Vector(0, 0, 0), Vector(0, 0, 0), KTBM_Gameplay_kScene, false, false);
        KTBM_PropertySet(agent_newZombie, "Render Cull", false);
        KTBM_PropertySet(agent_newZombie, "Render Static", false);

        --To solve the problem with not being able to move an animated object, we will parent them instead to an empty group object.
        --And when it comes to moving the animated object, we move the group instead (which will naturally move the animated object).
        local agent_newZombieGroup = AgentCreate(string_newZombieGroupName, "group.prop", vector_newZombiePosition, vector_newZombieRotation, KTBM_Gameplay_kScene, false, false);
        
        --NOTE: The order of operations here with attaching and setting the local position/rotation is CRITICAL

        --Attach the spawned animated object to the empty group
        AgentAttach(agent_newZombie, agent_newZombieGroup);

        --After attaching, zero out the LOCAL transformations so the spawned animated object is placed/rotated to where the empty group is.
        AgentSetPos(agent_newZombie, Vector(0, 0, 0));
        AgentSetRot(agent_newZombie, Vector(0, 0, 0));

        table.insert(KTBM_Gameplay_Zombies_AgentGroupArray, agent_newZombieGroup);

        KTBM_Gameplay_ZombiesUpdate_LastRanTime = number_totalGameTime + KTBM_Gameplay_ZombiesSpawnInterval;
    end

    -------------------------------------------------------

    --FIX: Initalize a temporary local array that will keep track of the spawned Zombie agents that need to be deleted later
    --(We can't be deleting agents in an array that we are also iterating through currently as this causes some issues)
    local agentArray_zombieGroupAgentsToDelete = {};

    --Iterate through all of the spawned Zombie Group agents
    for index1 = 1, #KTBM_Gameplay_Zombies_AgentGroupArray do
        local agent_zombieGroup = KTBM_Gameplay_Zombies_AgentGroupArray[#KTBM_Gameplay_Zombies_AgentGroupArray + 1 - index1];

        local vector_currentZombiePosition = AgentGetWorldPos(agent_zombieGroup);

        local number_newPosition_z = vector_currentZombiePosition.z;
        local number_newPosition_y = vector_currentZombiePosition.y;

        number_newPosition_z = number_newPosition_z - (KTBM_Gameplay_EnvironmentCurrentMovementSpeed * number_deltaTime);

        if(number_newPosition_y < KTBM_Gameplay_ZombiesEndingHeight + KTBM_Gameplay_EnvironmentHeightOffset) then
            number_newPosition_y = number_newPosition_y + (KTBM_Gameplay_ZombiesHeightRiseSpeed * number_deltaTime);
        end

        local vector_newPosition = Vector(vector_currentZombiePosition.x, number_newPosition_y, number_newPosition_z);

        AgentSetWorldPos(agent_zombieGroup, vector_newPosition); 

        --When the current position of the Zombie goes behind camera and is out of view
        if(vector_newPosition.z < KTBM_Gameplay_ZombiesMinimumDistance) then
            table.insert(agentArray_zombieGroupAgentsToDelete, agent_zombieGroup);
        end
    end

    -------------------------------------------------------
    --FIX: Last thing here is to delete the objects that we "marked" earlier.
    --These are objects that are out of view of the camera and therefore should be discarded.
    --We don't want to keep spawning new agents and never getting rid of the old ones for performance and longevitiy sake.

    --Iterate through the agents marked for deletion
    for index2 = 1, #agentArray_zombieGroupAgentsToDelete do
        --get the agent object
        local agent_zombieGroupAgent = agentArray_zombieGroupAgentsToDelete[index2];

        --the index for the main Zombie agent array of the object that we will delete
        local tempIndex = nil;

        --iterate through the current Zombie agent array to make sure that it's the same object we have marked.
        for index3 = 1, #KTBM_Gameplay_Zombies_AgentGroupArray do
            local agent_originalZombieAgent = KTBM_Gameplay_Zombies_AgentGroupArray[index3];

            --when we find it, get the index of it in the original array so we can remove it in a bit.
            if(agent_zombieGroupAgent == agent_originalZombieAgent) then
                tempIndex = index3;
            end
        end

        --make sure that we assigned an index value, and remove the object from the original array
        if(tempIndex ~= nil) then
            table.remove(KTBM_Gameplay_Zombies_AgentGroupArray, tempIndex);
        end

        local string_zombieGroupAgentName = AgentGetName(agent_zombieGroupAgent); --ZombieGroup
        local string_timeWhenSpawned =  string_zombieGroupAgentName:sub(12);
        local string_zombieChildAgentName = "Zombie" .. string_timeWhenSpawned;
        local string_zombieLookAtTargetAgentName = "obj_lookAt" .. string_zombieChildAgentName;
        local agent_zombieChild = AgentFindInScene(string_zombieChildAgentName, KTBM_Gameplay_kScene);
        local agent_zombieLookAtTarget = AgentFindInScene(string_zombieLookAtTargetAgentName, KTBM_Gameplay_kScene);

        AgentDestroy(agent_zombieLookAtTarget);
        AgentDestroy(agent_zombieChild);
        AgentDestroy(agent_zombieGroupAgent);
    end

    --SELF NOTE: no need to clear "agentArray_zombieGroupAgentsToDelete" because its not persistent.

end