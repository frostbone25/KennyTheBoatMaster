require("KTBM_UI_Input.lua");

local agent_deathTextTitle = nil;
local agent_deathTextScoreboard = nil;
local agent_retryText = nil;
local agent_returnToMenuText = nil;
local agent_returnToDefinitiveMenuText = nil;
local agent_quitToDesktopText = nil;

local gameResults_object = nil;

KTBM_UI_PrepareDeathResultsUI = function()
    --create our main menu text
    agent_deathTextTitle = KTBM_TextUI_CreateTextAgent("agent_deathTextTitle", "You Died!", Vector(0, 0, 0), 0, 0);
    agent_deathTextScoreboard = KTBM_TextUI_CreateTextAgent("agent_deathTextScoreboard", "Scoreboard", Vector(0, 0, 0), 0, 0);
    agent_retryText = KTBM_TextUI_CreateTextAgent("agent_retryText", "Retry", Vector(0, 0, 0), 1, 0);
    agent_returnToMenuText = KTBM_TextUI_CreateTextAgent("agent_returnToMenuText", "Return To Menu", Vector(0, 0, 0), 1, 0);
    agent_returnToDefinitiveMenuText = KTBM_TextUI_CreateTextAgent("agent_returnToDefinitiveMenuText", "Return To Definitive Menu", Vector(0, 0, 0), 1, 0);
    agent_quitToDesktopText = KTBM_TextUI_CreateTextAgent("agent_quitToDesktopText", "Quit To Desktop", Vector(0, 0, 0), 1, 0);

    --scale note
    --1.0 = default
    --0.5 = half
    --2.0 = double
    TextSetScale(agent_deathTextTitle, 3.0);
    TextSetScale(agent_deathTextScoreboard, 1.0);
    TextSetScale(agent_retryText, 1.0);
    TextSetScale(agent_returnToMenuText, 1.0);
    TextSetScale(agent_returnToDefinitiveMenuText, 1.0);
    TextSetScale(agent_quitToDesktopText, 1.0);

    --color note
    --text colors are additive on the scene
    TextSetColor(agent_deathTextTitle, Color(1.0, 0.0, 0.0, 1.0));
    TextSetColor(agent_deathTextScoreboard, Color(1.0, 1.0, 1.0, 1.0));
    TextSetColor(agent_retryText, Color(1.0, 1.0, 1.0, 1.0));
    TextSetColor(agent_returnToMenuText, Color(1.0, 1.0, 1.0, 1.0));
    TextSetColor(agent_returnToDefinitiveMenuText, Color(1.0, 1.0, 1.0, 1.0));
    TextSetColor(agent_quitToDesktopText, Color(1.0, 1.0, 1.0, 1.0));

    gameResults_object = KTBM_Data_GetPreviousGameResults();
end

KTBM_UI_UpdateDeathResultsUI = function()  
    local string_scoreboardText = "";

    string_scoreboardText = "[Game Results]";
    string_scoreboardText = string_scoreboardText .. "\n"; --new line

    if(gameResults_object ~= nil) then
        local string_distanceTraveled = tostring(KTBM_NumberRound(gameResults_object["DistanceTraveled"]));
        string_scoreboardText = string_scoreboardText .. "Distance: " .. string_distanceTraveled .. " units";
        string_scoreboardText = string_scoreboardText .. "\n"; --new line

        local string_zombiesKilled = tostring(gameResults_object["ZombiesKilled"]);
        string_scoreboardText = string_scoreboardText .. "Zombies Killed: " .. string_zombiesKilled;
        string_scoreboardText = string_scoreboardText .. "\n"; --new line

        local string_totalTime = KTBM_TimeSecondsFormatted(gameResults_object["TotalTime"]);
        string_scoreboardText = string_scoreboardText .. "Time: " .. string_totalTime;
        string_scoreboardText = string_scoreboardText .. "\n"; --new line
    end

    TextSet(agent_deathTextScoreboard, string_scoreboardText);

    KTBM_PropertySet(agent_deathTextTitle, "Runtime: Visible", KTBM_Cutscene_DeathResults_ShowUI);
    KTBM_PropertySet(agent_deathTextScoreboard, "Runtime: Visible", KTBM_Cutscene_DeathResults_ShowUI);
    KTBM_PropertySet(agent_retryText, "Runtime: Visible", KTBM_Cutscene_DeathResults_ShowUI);
    KTBM_PropertySet(agent_returnToMenuText, "Runtime: Visible", KTBM_Cutscene_DeathResults_ShowUI);
    KTBM_PropertySet(agent_returnToDefinitiveMenuText, "Runtime: Visible", KTBM_Cutscene_DeathResults_ShowUI);
    KTBM_PropertySet(agent_quitToDesktopText, "Runtime: Visible", KTBM_Cutscene_DeathResults_ShowUI);

    local defaultColor = Color(1.0, 1.0, 1.0, 1.0);
    local rolloverColor = Color(0.25, 0.25, 0.25, 1.0);
    local pressedColor = Color(0.1, 0.0, 0.0, 1.0);

    --option 1 (retry)
    if (KTBM_TextUI_IsCursorOverTextAgent(agent_retryText)) then
        --if (KTBM_UI_Input_Clicked == true) then
            --TextSetColor(agent_retryText, pressedColor);

            --KTBM_UI_Input_Clicked = false;
        --else
            TextSetColor(agent_retryText, rolloverColor);
        --end
    else
        TextSetColor(agent_retryText, defaultColor);
    end

    --option 2 (return to menu)
    if (KTBM_TextUI_IsCursorOverTextAgent(agent_returnToMenuText)) then
        --if (KTBM_UI_Input_Clicked == true) then
            --TextSetColor(agent_returnToMenuText, pressedColor);

            --KTBM_UI_Input_Clicked = false;
        --else
            TextSetColor(agent_returnToMenuText, rolloverColor);
        --end
    else
        TextSetColor(agent_returnToMenuText, defaultColor);
    end

    --option 3 (return to definitive menu)
    if (KTBM_TextUI_IsCursorOverTextAgent(agent_returnToDefinitiveMenuText)) then
        --if (KTBM_UI_Input_Clicked == true) then
            --TextSetColor(agent_returnToDefinitiveMenuText, pressedColor);

            --KTBM_UI_Input_Clicked = false;
        --else
            TextSetColor(agent_returnToDefinitiveMenuText, rolloverColor);
        --end
    else
        TextSetColor(agent_returnToDefinitiveMenuText, defaultColor);
    end

    --option 4 (quit to desktop)
    if (KTBM_TextUI_IsCursorOverTextAgent(agent_quitToDesktopText)) then
        --if (KTBM_UI_Input_Clicked == true) then
            --TextSetColor(agent_quitToDesktopText, pressedColor);

            --KTBM_UI_Input_Clicked = false;
        --else
            TextSetColor(agent_quitToDesktopText, rolloverColor);
        --end
    else
        TextSetColor(agent_quitToDesktopText, defaultColor);
    end

    --screen pos notes
    --0.0 0.0 0.0 = top left
    --0.5 0.5 0.0 = center
    --0.0 1.0 0.0 = bottom left
    --AgentSetWorldPosFromLogicalScreenPos(agent_deathTextTitle, Vector(0.36, 0.2, 0.0));
    AgentSetWorldPosFromLogicalScreenPos(agent_deathTextTitle, Vector(0.05, 0.1, 0.0));
    AgentSetWorldPosFromLogicalScreenPos(agent_deathTextScoreboard, Vector(0.05, 0.2, 0.0));
    AgentSetWorldPosFromLogicalScreenPos(agent_retryText, Vector(0.05, 0.75, 0.0));
    AgentSetWorldPosFromLogicalScreenPos(agent_returnToMenuText, Vector(0.05, 0.8, 0.0));
    AgentSetWorldPosFromLogicalScreenPos(agent_returnToDefinitiveMenuText, Vector(0.05, 0.85, 0.0));
    AgentSetWorldPosFromLogicalScreenPos(agent_quitToDesktopText, Vector(0.05, 0.9, 0.0));
end