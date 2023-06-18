local agent_barrierTextUI = nil;
local agent_statsTextUI = nil;

KTBM_UI_GamePrepare = function()
    --create our main menu text
    agent_barrierTextUI = KTBM_TextUI_CreateTextAgent("agent_barrierTextUI", "(-------------- O --------------)", Vector(0, 0, 0), 0, 0);
    agent_statsTextUI = KTBM_TextUI_CreateTextAgent("agent_statsTextUI", "[Stats]", Vector(0, 0, 0), 0, 0);

    --scale note
    --1.0 = default
    --0.5 = half
    --2.0 = double
    TextSetScale(agent_barrierTextUI, 1.25);
    TextSetScale(agent_statsTextUI, 1.0);

    --color note
    --text colors are additive on the scene
    TextSetColor(agent_barrierTextUI, Color(1.0, 1.0, 1.0, 1.0));
    TextSetColor(agent_statsTextUI, Color(1.0, 1.0, 1.0, 1.0));

    CursorHide(true);
    CursorEnable(true);
end

KTBM_UI_GameUpdate = function()  
    local number_textDashesCount = 60;

    local number_playerCurrentHorizontalPosition = (KTBM_Gameplay_Boat_DesiredPosition.x + KTBM_Gameplay_BoatHorizontalBoundarySize) / KTBM_Gameplay_BoatHorizontalBoundarySize * 0.5;

    local string_barrierText = "";
    local string_statsText = "";

    string_barrierText = string_barrierText .. "(";

    --local scaledIndex = KTBM_NumberRound(number_playerCurrentHorizontalPosition * number_textDashesCount, 0);
    local scaledIndex = number_textDashesCount - KTBM_NumberRound(number_playerCurrentHorizontalPosition * number_textDashesCount, 0);

    for i = 0, number_textDashesCount do

        if(i == scaledIndex) then
            string_barrierText = string_barrierText .. "O";
        else
            string_barrierText = string_barrierText .. "-";
        end

    end

    string_barrierText = string_barrierText .. ")";

    TextSet(agent_barrierTextUI, string_barrierText);

    local number_distanceTraveledRounded = KTBM_NumberRound(KTBM_Gameplay_Stats_DistanceTraveled, 0);
    string_statsText = string_statsText .. "[Distance Traveled]: " .. tostring(number_distanceTraveledRounded);
    string_statsText = string_statsText .. "\n"; --new line

    string_statsText = string_statsText .. "[Zombies Killed]: " .. tostring(KTBM_Gameplay_Stats_ZombiesKilled);
    string_statsText = string_statsText .. "\n"; --new line

    local string_gameTimeFormatted = KTBM_TimeSecondsFormatted(KTBM_Gameplay_Stats_TotalTime);
    string_statsText = string_statsText .. "[Time]: " .. string_gameTimeFormatted;
    string_statsText = string_statsText .. "\n"; --new line

    --string_statsText = string_statsText .. "[Rocks Count]: " .. tostring(#KTBM_Gameplay_Rocks_AgentArray);
    --string_statsText = string_statsText .. "\n"; --new line

    --string_statsText = string_statsText .. "[Zombie Group Agent Count]: " .. tostring(#KTBM_Gameplay_Zombies_AgentGroupArray);
    --string_statsText = string_statsText .. "\n"; --new line

    --local agents_sceneAgents = SceneGetAgents(KTBM_Gameplay_kScene);
    --string_statsText = string_statsText .. "[Scene Agent Count]: " .. tostring(#agents_sceneAgents);
    --string_statsText = string_statsText .. "\n"; --new line

    --for index1 = #agents_sceneAgents, 1, -1 do
        --if(index1 > #agents_sceneAgents - 10) then
            --string_statsText = string_statsText .. AgentGetName(agents_sceneAgents[index1]);
            --string_statsText = string_statsText .. "\n"; --new line
        --end
    --end

    TextSet(agent_statsTextUI, string_statsText);

    --screen pos notes
    --0.0 0.0 0.0 = top left
    --0.5 0.5 0.0 = center
    --0.0 1.0 0.0 = bottom left
    AgentSetWorldPosFromLogicalScreenPos(agent_barrierTextUI, Vector(0.25, 0.9, 0.0));
    AgentSetWorldPosFromLogicalScreenPos(agent_statsTextUI, Vector(0.05, 0.05, 0.0));
end