--[[

]]--

KTBM_Development_BoundsDebug_Agents = {
    "SceneAgentName"
};

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

KTBM_DevelopBoundsDebug_AgentTextObjects_Corners = {};
KTBM_DevelopBoundsDebug_AgentTextObjects_Extents = {};

KTBM_Development_BoundsDebug_Initalize = function()
    --KTBM_Development_SceneObject

    for index, string_agentName in ipairs(KTBM_Development_BoundsDebug_Agents) do

    end

    --KTBM_Development_BoundsDebug_Text = KTBM_TextUI_CreateTextAgent("BoundsDebugText", "Performance Metrics Text Initalized", Vector(0, 0, 0), 0, 0);
    --TextSetColor(KTBM_Development_BoundsDebug_Text, Color(0.5, 1.0, 0.5, 1.0));
    --TextSetScale(KTBM_Development_BoundsDebug_Text, 0.5);
end

KTBM_Development_BoundsDebug_Update = function()  
    -------------------------------------------------------------
    --screen pos notes
    --0.0 0.0 0.0 = top left
    --0.5 0.5 0.0 = center
    --0.0 1.0 0.0 = bottom left
    local screenPos = Vector(0.0, 0.75, 0.0);
    AgentSetWorldPosFromLogicalScreenPos(KTBM_Development_BoundsDebug_Text, screenPos);

    local finalText = "";

    finalText = finalText .. "\n"; --new line
    finalText = finalText .. "--------------------------";

    TextSet(KTBM_Development_BoundsDebug_Text, finalText);
end