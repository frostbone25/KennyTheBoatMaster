--[[
    This script has functions to help deal with transformations on agents.

    Transformations on agents involve simply moving and rotating objects
    in a scene. It's worth mentioning that there are two kinds of transformations.

    Local - Means it's relative to the objects parent, usually by default
    objects that are not parented or grouped to another agent, local transformations
    are basically identical to world transformations. However when an object
    is parented/grouped to another agent then it's transformations will be
    relative to the parent.

    World - Means that you are always treating the transformations of the object
    in world space regardless if it's parented or grouped to another object.
    Whatever position/rotation you set an agent to will always be that
    position/rotation.

    NOTE: AgentFindInScene calls especially in a large bulk can be expensive.
]]

--||||||||||||||||||||||||| TRANSFORMATION - SET |||||||||||||||||||||||||
--||||||||||||||||||||||||| TRANSFORMATION - SET |||||||||||||||||||||||||
--||||||||||||||||||||||||| TRANSFORMATION - SET |||||||||||||||||||||||||
--for moving and rotating agents

--Finds an agent in a scene by it's name and rotates it (locally if it's parented to an object).
--RETURNS: Nothing
KTBM_SetAgentRotation = function(string_agentName, vector_rotation, string_scene)
    local agent_object = AgentFindInScene(string_agentName, string_scene);
    AgentSetRot(agent_object, vector_rotation);
end

--Finds an agent in a scene by it's name and moves it (locally if it's parented to an object).
--RETURNS: Nothing
KTBM_SetAgentPosition = function(string_agentName, vector_position, string_scene)
    local agent_object = AgentFindInScene(string_agentName, string_scene);
    AgentSetPos(agent_object, vector_position);
end

--Finds an agent in a scene by it's name and rotates it in world space.
--RETURNS: Nothing
KTBM_SetAgentWorldRotation = function(string_agentName, vector_rotation, string_scene)
    local agent_object = AgentFindInScene(string_agentName, string_scene);
    AgentSetWorldRot(agent_object, vector_rotation);
end

--Finds an agent in a scene by it's name and moves it in world space.
--RETURNS: Nothing
KTBM_SetAgentWorldPosition = function(string_agentName, vector_position, string_scene)
    local agent_object = AgentFindInScene(string_agentName, string_scene);
    AgentSetWorldPos(agent_object, vector_position);
end

--||||||||||||||||||||||||| TRANSFORMATION - GET |||||||||||||||||||||||||
--||||||||||||||||||||||||| TRANSFORMATION - GET |||||||||||||||||||||||||
--||||||||||||||||||||||||| TRANSFORMATION - GET |||||||||||||||||||||||||
--for getting rotation/position of agents

--Finds an agent in a scene by it's name and gets it's rotation (locally if it's parented to an object).
--RETURNS: Vector
KTBM_GetAgentRotation = function(string_agentName, string_scene)
    local agent_object = AgentFindInScene(string_agentName, string_scene);
    return AgentGetRot(agent_object);
end

--Finds an agent in a scene by it's name and gets it's position (locally if it's parented to an object).
--RETURNS: Vector
KTBM_GetAgentPosition = function(string_agentName, string_scene)
    local agent_object = AgentFindInScene(string_agentName, string_scene);
    return AgentGetPos(agent_object);
end

--Finds an agent in a scene by it's name and gets its rotation in world space.
--RETURNS: Vector
KTBM_GetAgentWorldRotation = function(string_agentName, string_scene)
    local agent_object = AgentFindInScene(string_agentName, string_scene);
    return AgentGetWorldRot(agent_object);
end

--Finds an agent in a scene by it's name and gets its position in world space.
--RETURNS: Vector
KTBM_GetAgentWorldPosition = function(string_agentName, string_scene)
    local agent_object = AgentFindInScene(string_agentName, string_scene);
    return AgentGetWorldPos(agent_object);
end