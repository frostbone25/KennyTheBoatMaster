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

    --return AgentIsUnderCursor(textAgent); --NOTE: Kept in here for archival purposes, this doesnt not work
    --return AgentContainingPos(textAgent, vector_cursorPos); --NOTE: Kept in here for archival purposes, this doesnt not work
end