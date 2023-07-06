--'horizontalAlign': 1 = left alignment, 2 = center alignment, 3 = right alignment

KTBM_TextUI_CreateTextAgent = function(string_agentName, string_text, vector_position, number_horizontalAlign, number_verticalAlign)
    local agent_text = AgentCreate(string_agentName, "ui_text.prop", vector_position);

    if number_horizontalAlign then
        TextSetHorizAlign(agent_text, number_horizontalAlign);
    end
    
    if number_verticalAlign then
        TextSetVertAlign(agent_text, number_verticalAlign);
    end
    
    TextSet(agent_text, string_text);
    
    AgentSetProperty(agent_text, "Text Render Layer", 99);
    AgentSetProperty(agent_text, "Text Render After Post-Effects", true);
    
    return agent_text;
end

--extents min (bottom left corner)
--extents max (top right corner)
KTBM_TextUI_IsCursorOverBounds = function(vector_originPosition, vector_extentsMin, vector_extentsMax)
    local vector_cursorPos = CursorGetPos();

    local vector_offsetExtentsMin = VectorAdd(vector_originPosition, vector_extentsMin);
    local vector_offsetExtentsMax = VectorAdd(vector_originPosition, vector_extentsMax);
    
    local case1 = vector_cursorPos.x >= vector_offsetExtentsMin.x;
    local case2 = vector_cursorPos.y >= vector_offsetExtentsMin.y;
    local case3 = vector_cursorPos.y <= vector_offsetExtentsMax.y;
    local case4 = vector_cursorPos.x <= vector_offsetExtentsMax.x;
    
    local finalCase = case1 and case2 and case3 and case4;
    
    return finalCase;
end

KTBM_TextUI_TextAgentContains = function(textAgent, screenPos)
    local extentsMin, extentsMax = TextGetWorldExtents(textAgent);
    local viewPortPos = ScreenToViewport(screenPos);
    local cam = AgentGetCamera(textAgent);
    
    extentsMin = CameraGetScreenPosFromWorldPos(cam, AgentLocalToWorld(textAgent, extentsMin));
    extentsMax = CameraGetScreenPosFromWorldPos(cam, AgentLocalToWorld(textAgent, extentsMax));
    
    local case1 = extentsMin.x <= viewPortPos.x;
    local case2 = extentsMax.y <= viewPortPos.y;
    local case3 = viewPortPos.y <= extentsMin.y;
    local case4 = viewPortPos.x <= extentsMax.x;
    
    local finalCase = case1 and case2 and case3 and case4;
    
    return finalCase;
end

KTBM_TextUI_IsCursorOverTextAgent = function(textAgent)
    local vector_cursorPos = CursorGetPos();
    return KTBM_TextUI_TextAgentContains(textAgent, vector_cursorPos);
end

KTBM_TextUI_IsCursorOverTextAgentFix = function(textAgent)
    --NOTE: Bounds Fix
    --TextGetWorldExtents do not properly factor in rotations well, despite the fact that visually text objects are always oriented towards the screen.
    --Their actual agent rotations are not, so the bounds will appear out of whack.
    --To fix this, we just simply match the agent rotations of the text to the camera.
    local string_agentScene = AgentGetScene(textAgent);
    local camera_sceneCamera = SceneGetSceneCamera(string_agentScene);
    local vector_sceneCameraRotation = AgentGetWorldRot(camera_sceneCamera);
    AgentSetWorldRot(textAgent, vector_sceneCameraRotation);

    local vector_cursorPos = CursorGetPos();
    return KTBM_TextUI_TextAgentContains(textAgent, vector_cursorPos);

    --NOTE: Kept in here for archival purposes, these don't not work
    --|||||||||||||||||||||||||||||||||||| AGENT CURSOR CHECKING ATTEMPT 1 ||||||||||||||||||||||||||||||||||||
    --return AgentIsUnderCursor(textAgent);

    --|||||||||||||||||||||||||||||||||||| AGENT CURSOR CHECKING ATTEMPT 2 ||||||||||||||||||||||||||||||||||||
    --return AgentContainingPos(textAgent, vector_cursorPos);

    --|||||||||||||||||||||||||||||||||||| AGENT CURSOR CHECKING ATTEMPT 3 ||||||||||||||||||||||||||||||||||||
    --local string_textAgentName = AgentGetName(textAgent);
    --local agent_agentAtScreenPos = AgentAtScreenPos(vector_cursorPos);

    --if(agent_agentAtScreenPos == nil) then 
        --return false;
    --end

    --local string_agentNameAtScreenPos = AgentGetName(agent_agentAtScreenPos);

    --if(string.match(string_textAgentName, string_agentNameAtScreenPos) == true) then
        --return true;
    --else
        --return false;
    --end

    --|||||||||||||||||||||||||||||||||||| AGENT CURSOR CHECKING ATTEMPT 4 ||||||||||||||||||||||||||||||||||||
    --local string_textAgentName = AgentGetName(textAgent);
    --local agent_agentsAtScreenPos = AgentAtCursorPos();

    --if(agent_agentsAtScreenPos == nil) then 
        --return false;
    --end

    --for index, agent_item in ipairs(agent_agentsAtScreenPos) do
        --local string_agentNameItem = AgentGetName(agent_item);

        --if(string.match(string_textAgentName, string_agentNameItem) == true) then
            --return true;
        --end
    --end

    --return false;

    --|||||||||||||||||||||||||||||||||||| AGENT CURSOR CHECKING ATTEMPT 5 ||||||||||||||||||||||||||||||||||||
    --local string_textAgentName = AgentGetName(textAgent);
    --local agent_agentAtScreenPos = AgentAtLogicalScreenPos(vector_cursorPos);

    --if(agent_agentAtScreenPos == nil) then 
        --return false;
    --end

    --local string_agentNameAtScreenPos = AgentGetName(agent_agentAtScreenPos);

    --if(string.match(string_textAgentName, string_agentNameAtScreenPos) == true) then
        --return true;
    --else
        --return false;
    --end
end