--[[
-----------------------------------------------------------------------------------------
KTBM_Gameplay_Physics

This script deals with the main collisions necessary for gameplay
-----------------------------------------------------------------------------------------
]]--

--||||||||||||||||||||||||||||||| PHYSICS MAIN |||||||||||||||||||||||||||||||
--||||||||||||||||||||||||||||||| PHYSICS MAIN |||||||||||||||||||||||||||||||
--||||||||||||||||||||||||||||||| PHYSICS MAIN |||||||||||||||||||||||||||||||

--This is the main "physics" loop for the game.
--This is intended to run every frame, and will check for rock and zombie collisions.
KTBM_Gameplay_PhysicsUpdate = function()
    --self note: using AABB's that account for orentation for now...
    --OBB's would be way more accurate and ideal, but I can't figure out how to implement them yet...

    --get the player boat bounds so we can test against other objects in the scene
    local agent_playerBoat = AgentFindInScene("obj_boatMotorChesapeake", KTBM_Gameplay_kScene);

    --||||||||||||||||||||||||||||||| PLAYER/ROCK COLLISION TESTING |||||||||||||||||||||||||||||||
    --||||||||||||||||||||||||||||||| PLAYER/ROCK COLLISION TESTING |||||||||||||||||||||||||||||||
    --||||||||||||||||||||||||||||||| PLAYER/ROCK COLLISION TESTING |||||||||||||||||||||||||||||||
    --Collision testing against the spawned rocks in the scene

    for index1 = 1, #KTBM_Gameplay_Rocks_AgentArray do
        local agent_rock = KTBM_Gameplay_Rocks_AgentArray[index1];

        --use native telltale api for doing an intersection test
        local bool_intersectionTest = AgentCollide(agent_playerBoat, agent_rock);

        if(bool_intersectionTest == true) and (KTBM_Project_DebugDisableRockCollisions == false) then
            KTBM_Gameplay_State_HasCrashed = true;
            break;
        else
            KTBM_Gameplay_State_HasCrashed = false;
        end
    end

    --||||||||||||||||||||||||||||||| PLAYER/ZOMBIE COLLISION TESTING |||||||||||||||||||||||||||||||
    --||||||||||||||||||||||||||||||| PLAYER/ZOMBIE COLLISION TESTING |||||||||||||||||||||||||||||||
    --||||||||||||||||||||||||||||||| PLAYER/ZOMBIE COLLISION TESTING |||||||||||||||||||||||||||||||
    --Collision testing against the spawned zombies in the scene
    local agentArray_zombiesToDestroy = {};

    for index2 = 1, #KTBM_Gameplay_Zombies_AgentGroupArray do
        local agent_zombieGroup = KTBM_Gameplay_Zombies_AgentGroupArray[index2];

        local string_zombieGroupAgentName = AgentGetName(agent_zombieGroup); --ZombieGroup
        local string_timeWhenSpawned =  string_zombieGroupAgentName:sub(12);
        local string_zombieChildAgentName = "Zombie" .. string_timeWhenSpawned;
        local agent_zombieChild = AgentFindInScene(string_zombieChildAgentName, KTBM_Gameplay_kScene);

        local bool_intersectionTest = AgentCollide(agent_playerBoat, agent_zombieChild);

        if(bool_intersectionTest == true) and (KTBM_Project_DebugDisableZombieCollisions == false) then
            local status_KTBM_Cutscene_Game_PlayZombieKill = pcall(KTBM_Cutscene_Game_PlayZombieKill, agent_zombieChild);
            local status_KTBM_Cutscene_Game_PlayVoiceLineAfterZombieKill = pcall(KTBM_Cutscene_Game_PlayVoiceLineAfterZombieKill);

            KTBM_Gameplay_Stats_ZombiesKilled = KTBM_Gameplay_Stats_ZombiesKilled + 1;

            table.insert(agentArray_zombiesToDestroy, agent_zombieGroup);
            break;
        end
    end

    --||||||||||||||||||||||||||||||| ROCK/ZOMBIE COLLISION TESTING |||||||||||||||||||||||||||||||
    --||||||||||||||||||||||||||||||| ROCK/ZOMBIE COLLISION TESTING |||||||||||||||||||||||||||||||
    --||||||||||||||||||||||||||||||| ROCK/ZOMBIE COLLISION TESTING |||||||||||||||||||||||||||||||
    --Removing any zombies that are spawned (or eventually end up) inside of rocks

    for index3 = 1, #KTBM_Gameplay_Zombies_AgentGroupArray do
        local agent_zombieGroup = KTBM_Gameplay_Zombies_AgentGroupArray[index3];

        local string_zombieGroupAgentName = AgentGetName(agent_zombieGroup); --ZombieGroup
        local string_timeWhenSpawned =  string_zombieGroupAgentName:sub(12);
        local string_zombieChildAgentName = "Zombie" .. string_timeWhenSpawned;
        local agent_zombieChild = AgentFindInScene(string_zombieChildAgentName, KTBM_Gameplay_kScene);

        for index4 = 1, #KTBM_Gameplay_Rocks_AgentArray do
            local agent_rock = KTBM_Gameplay_Rocks_AgentArray[index4];

            --use native telltale api for doing an intersection test
            local bool_intersectionTest = AgentCollide(agent_zombieChild, agent_rock);

            if(bool_intersectionTest == true) then
                table.insert(agentArray_zombiesToDestroy, agent_zombieGroup);
                break;
            end
        end
    end

    --||||||||||||||||||||||||||||||| OBJECT REMOVAL/DELETION |||||||||||||||||||||||||||||||
    --||||||||||||||||||||||||||||||| OBJECT REMOVAL/DELETION |||||||||||||||||||||||||||||||
    --||||||||||||||||||||||||||||||| OBJECT REMOVAL/DELETION |||||||||||||||||||||||||||||||
    --In here we delete objects "marked" for deletion after a collision test

    for index5 = 1, #agentArray_zombiesToDestroy do
        local agent_zombieToDelete = agentArray_zombiesToDestroy[index5];

        --the index for the main Zombie agent array of the object that we will delete
        local tempIndex = nil;

        --iterate through the current Zombie agent array to make sure that it's the same object we have marked.
        for index6 = 1, #KTBM_Gameplay_Zombies_AgentGroupArray do
            local agent_originalZombieAgent = KTBM_Gameplay_Zombies_AgentGroupArray[index6];

            --when we find it, get the index of it in the original array so we can remove it in a bit.
            if(agent_zombieToDelete == agent_originalZombieAgent) then
                tempIndex = index6;
            end
        end

        --make sure that we assigned an index value, and remove the object from the original array
        if(tempIndex ~= nil) then
            table.remove(KTBM_Gameplay_Zombies_AgentGroupArray, tempIndex);
        end

        local string_zombieGroupAgentName = AgentGetName(agent_zombieToDelete); --ZombieGroup
        local string_timeWhenSpawned =  string_zombieGroupAgentName:sub(12);
        local string_zombieChildAgentName = "Zombie" .. string_timeWhenSpawned;
        local string_zombieLookAtTargetAgentName = "obj_lookAt" .. string_zombieChildAgentName;
        local agent_zombieChild = AgentFindInScene(string_zombieChildAgentName, KTBM_Gameplay_kScene);
        local agent_zombieLookAtTarget = AgentFindInScene(string_zombieLookAtTargetAgentName, KTBM_Gameplay_kScene);

        AgentDestroy(agent_zombieLookAtTarget);
        AgentDestroy(agent_zombieChild);
        AgentDestroy(agent_zombieToDelete);
    end
end

--||||||||||||||||||||||||||||||| PHYSICS DEBUGGING |||||||||||||||||||||||||||||||
--||||||||||||||||||||||||||||||| PHYSICS DEBUGGING |||||||||||||||||||||||||||||||
--||||||||||||||||||||||||||||||| PHYSICS DEBUGGING |||||||||||||||||||||||||||||||
--Below are non-critical functions and logic for debugging collisions within the game.

local agent_debugRockCollisionUIText = nil;

KTBM_Gameplay_PrepareDebugRockCollisionsUI = function()
    agent_debugRockCollisionUIText = KTBM_TextUI_CreateTextAgent("agent_debugRockCollisionUIText", "Collision Debugging", Vector(0, 0, 0), 0, 0);

    --scale note
    --1.0 = default
    --0.5 = half
    --2.0 = double
    TextSetScale(agent_debugRockCollisionUIText, 0.4);

    --color note
    --text colors are additive on the scene
    TextSetColor(agent_debugRockCollisionUIText, Color(1.0, 0.0, 1.0, 1.0));

    --screen pos notes
    --0.0 0.0 0.0 = top left
    --0.5 0.5 0.0 = center
    --0.0 1.0 0.0 = bottom left
    AgentSetWorldPosFromLogicalScreenPos(agent_debugRockCollisionUIText, Vector(0, 0, 0));
end

KTBM_Gameplay_UpdateDebugRockCollisionsUI = function()  
    local string_debugText = "";

    local agent_playerBoat = AgentFindInScene("obj_boatMotorChesapeake", KTBM_Gameplay_kScene);
    local bounds_playerBoat = KTBM_Bounds_GetAgentWorldBounds_AABB(agent_playerBoat);

    string_debugText = "[Collision Debugging]";
    string_debugText = string_debugText .. "\n"; --new line
    
    string_debugText = string_debugText .. "Player Boat | ";
    --string_debugText = string_debugText .. KTBM_VectorToString(bounds_playerBoat["size"]);
    --string_debugText = string_debugText .. KTBM_VectorToString(bounds_playerBoat["extents"]);
    string_debugText = string_debugText .. KTBM_VectorToString(bounds_playerBoat["center"]);
    --string_debugText = string_debugText .. KTBM_VectorToString(bounds_playerBoat["min"]);
    --string_debugText = string_debugText .. KTBM_VectorToString(bounds_playerBoat["max"]);
    --string_debugText = string_debugText .. KTBM_VectorToString(AgentGetWorldPos(boatMeshTest));
    string_debugText = string_debugText .. "\n"; --new line

    for index1 = 1, #KTBM_Gameplay_Rocks_AgentArray do
        local agent_rock = KTBM_Gameplay_Rocks_AgentArray[index1];
        local bounds_rock = KTBM_Bounds_GetAgentWorldBounds_AABB(agent_rock);

        local bool_intersectionTest = KTBM_Bounds_IntersectAABB(bounds_playerBoat, bounds_rock);

        if(bool_intersectionTest == true) then
            string_debugText = string_debugText .. "[INTERSECTING] ";
        end

        string_debugText = string_debugText .. AgentGetName(agent_rock) .. " | ";

        --string_debugText = string_debugText .. KTBM_VectorToString(bounds_rock["size"]);
        --string_debugText = string_debugText .. KTBM_VectorToString(bounds_rock["extents"]);
        string_debugText = string_debugText .. KTBM_VectorToString(bounds_rock["center"]);
        --string_debugText = string_debugText .. KTBM_VectorToString(bounds_rock["min"]);
        --string_debugText = string_debugText .. KTBM_VectorToString(bounds_rock["max"]);
        --string_debugText = string_debugText .. KTBM_VectorToString(AgentGetWorldPos(agent_rock));

        string_debugText = string_debugText .. "\n"; --new line
    end

    TextSet(agent_debugRockCollisionUIText, string_debugText);

    --screen pos notes
    --0.0 0.0 0.0 = top left
    --0.5 0.5 0.0 = center
    --0.0 1.0 0.0 = bottom left
    AgentSetWorldPosFromLogicalScreenPos(agent_debugRockCollisionUIText, Vector(0.0, 0.0, 0.0));
end