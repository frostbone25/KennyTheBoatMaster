--[[

]]--

local agent_pausedText = nil;

KTBM_UI_Pause_Start = function()
    KTBM_UI_PreparePauseText();
end

KTBM_UI_PreparePauseText = function()
    --create our main menu text
    agent_pausedText = KTBM_TextUI_CreateTextAgent("agent_pausedText", "PAUSED", Vector(0, 0, 0), 2, 0);

    --scale note
    --1.0 = default
    --0.5 = half
    --2.0 = double
    TextSetScale(agent_pausedText, 2.0);

    --color note
    --text colors are additive on the scene
    TextSetColor(agent_pausedText, Color(1.0, 1.0, 1.0, 1.0));

    --screen pos notes
    --0.0 0.0 0.0 = top left
    --0.5 0.5 0.0 = center
    --0.0 1.0 0.0 = bottom left
    AgentSetWorldPosFromLogicalScreenPos(agent_pausedText, Vector(0.5, 0.5, 0));
end

KTBM_UI_Pause_Update = function()  
    KTBM_PropertySet(agent_pausedText, "Runtime: Visible", KTBM_Gameplay_State_Paused);

    --screen pos notes
    --0.0 0.0 0.0 = top left
    --0.5 0.5 0.0 = center
    --0.0 1.0 0.0 = bottom left
    AgentSetWorldPosFromLogicalScreenPos(agent_pausedText, Vector(0.5, 0.5, 0));
end