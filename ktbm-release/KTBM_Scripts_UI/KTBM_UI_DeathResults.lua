require("KTBM_UI_Input.lua");

local agent_deathTextTitle = nil;
local agent_deathTextScoreboard = nil;
local agent_retryText = nil;
local agent_returnToMenuText = nil;
local agent_returnToDefinitiveMenuText = nil;
local agent_quitToDesktopText = nil;

local gameResults_object = nil;
local gameResultsObject_mostDistance = nil;
local gameResultsObject_mostKills = nil;

local controller_sound_uiClick = nil;
local controller_sound_uiRollover = nil;
local string_previousRolloverItem = "";
local string_currentRolloverItem = "";
local bool_cancelRolloverSound = false;

local PlayClickSound = function()
    if(controller_sound_uiClick ~= nil) then
        ControllerKill(controller_sound_uiClick);
    end

    controller_sound_uiClick = SoundPlay("ui_misc_items_6.wav");
    --controller_sound_uiClick = SoundPlay("ui_click_4.wav");

    ControllerSetSoundVolume(controller_sound_uiClick, 1);
end

local PlayRolloverSound = function()
    if not (string_previousRolloverItem == string_currentRolloverItem) then
        string_previousRolloverItem = string_currentRolloverItem;
        bool_cancelRolloverSound = false;
    end

    if(bool_cancelRolloverSound == false) then
        if(controller_sound_uiRollover ~= nil) then
            ControllerKill(controller_sound_uiRollover);
        end

        controller_sound_uiRollover = SoundPlay("ui_magnets_6.wav");
        --controller_sound_uiRollover = SoundPlay("ui_magnets_5.wav");
        --controller_sound_uiRollover = SoundPlay("ui_magnets_4.wav");
        --controller_sound_uiRollover = SoundPlay("ui_click_1.wav");

        ControllerSetSoundVolume(controller_sound_uiRollover, 1);

        bool_cancelRolloverSound = true;
    end
end

KTBM_UI_PrepareDeathResultsUI = function()
    --create our main menu text
    agent_deathTextTitle = KTBM_TextUI_CreateTextAgent("agent_deathTextTitle", "You Died!", Vector(0, 0, 0), 0, 0);
    agent_deathTextScoreboard = KTBM_TextUI_CreateTextAgent("agent_deathTextScoreboard", "Scoreboard", Vector(0, 0, 0), 0, 0);
    agent_retryText = KTBM_TextUI_CreateTextAgent("agent_retryText", "Retry", Vector(0, 0, 0), 0, 0);
    agent_returnToMenuText = KTBM_TextUI_CreateTextAgent("agent_returnToMenuText", "Return To Menu", Vector(0, 0, 0), 0, 0);
    agent_returnToDefinitiveMenuText = KTBM_TextUI_CreateTextAgent("agent_returnToDefinitiveMenuText", "Return To Definitive Menu", Vector(0, 0, 0), 0, 0);
    agent_quitToDesktopText = KTBM_TextUI_CreateTextAgent("agent_quitToDesktopText", "Quit To Desktop", Vector(0, 0, 0), 0, 0);

    --scale note
    --1.0 = default
    --0.5 = half
    --2.0 = double
    TextSetScale(agent_deathTextTitle, 3.0);
    TextSetScale(agent_deathTextScoreboard, 0.75);
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

    KTBM_Data_GetAllGameResultFilePaths();
    gameResults_object = KTBM_Data_GetPreviousGameResults();
    gameResultsObject_mostDistance = KTBM_Data_GetBestGameResultByStatistic("DistanceTraveled");
    gameResultsObject_mostKills = KTBM_Data_GetBestGameResultByStatistic("ZombiesKilled");
end

KTBM_UI_UpdateDeathResultsUI = function()  
    KTBM_UI_Input_IMAP_Update();
    PlayRolloverSound();

    local string_scoreboardText = "";

    if(gameResults_object ~= nil) then
        string_scoreboardText = string_scoreboardText .. KTBM_Data_GameResultsObjectDataToString(gameResults_object);
        string_scoreboardText = string_scoreboardText .. "\n"; --new line
    else
        string_scoreboardText = string_scoreboardText .. "ERROR! Most recent game results data was not saved!";
        string_scoreboardText = string_scoreboardText .. "\n"; --new line
    end

    string_scoreboardText = string_scoreboardText .. "\n"; --new line
    string_scoreboardText = string_scoreboardText .. "[Best Statistics]";
    string_scoreboardText = string_scoreboardText .. "\n"; --new line

    if(gameResultsObject_mostDistance ~= nil) then
        string_scoreboardText = string_scoreboardText .. "Best Distance: " .. tostring(KTBM_Data_GameResultsObject_GetDistanceTraveled(gameResultsObject_mostDistance));
        string_scoreboardText = string_scoreboardText .. "\n"; --new line
    else
        string_scoreboardText = string_scoreboardText .. "ERROR! Wasn't able to load the run with the best distance.";
        string_scoreboardText = string_scoreboardText .. "\n"; --new line
    end

    if(gameResultsObject_mostKills ~= nil) then
        string_scoreboardText = string_scoreboardText .. "Most Zombies Killed: " .. tostring(KTBM_Data_GameResultsObject_GetZombiesKilled(gameResultsObject_mostDistance));
        string_scoreboardText = string_scoreboardText .. "\n"; --new line
    else
        string_scoreboardText = string_scoreboardText .. "ERROR! Wasn't able to load the run with the best distance.";
        string_scoreboardText = string_scoreboardText .. "\n"; --new line
    end

    TextSet(agent_deathTextScoreboard, string_scoreboardText);

    KTBM_PropertySet(agent_deathTextTitle, "Runtime: Visible", KTBM_Cutscene_DeathResults_ShowUI);
    KTBM_PropertySet(agent_deathTextScoreboard, "Runtime: Visible", KTBM_Cutscene_DeathResults_ShowUI);
    KTBM_PropertySet(agent_retryText, "Runtime: Visible", KTBM_Cutscene_DeathResults_ShowUI);
    KTBM_PropertySet(agent_returnToMenuText, "Runtime: Visible", KTBM_Cutscene_DeathResults_ShowUI);
    KTBM_PropertySet(agent_returnToDefinitiveMenuText, "Runtime: Visible", KTBM_Cutscene_DeathResults_ShowUI);
    KTBM_PropertySet(agent_quitToDesktopText, "Runtime: Visible", KTBM_Cutscene_DeathResults_ShowUI);

    KTBM_SetExtents(agent_retryText, Vector(0, 0, 0), Vector(0, 0, 0));
    KTBM_SetExtents(agent_returnToMenuText, Vector(0, 0, 0), Vector(0, 0, 0));
    KTBM_SetExtents(agent_returnToDefinitiveMenuText, Vector(0, 0, 0), Vector(0, 0, 0));
    KTBM_SetExtents(agent_quitToDesktopText, Vector(0, 0, 0), Vector(0, 0, 0));

    local defaultColor = Color(1.0, 1.0, 1.0, 1.0);
    local rolloverColor = Color(0.25, 0.25, 0.25, 1.0);
    local pressedColor = Color(0.1, 0.0, 0.0, 1.0);

    --option 1 (retry)
    if (KTBM_TextUI_IsCursorOverTextAgentFix(agent_retryText)) then
        if (KTBM_UI_Input_Clicked == true) then
            TextSetColor(agent_retryText, pressedColor);
            PlayClickSound();

            --OverlayShow("ui_loadingScreen.overlay", true);
            --dofile("KTBM_Level_Game.lua");
            --SubProject_Switch("Menu", "KTBM_Level_Game.lua");
            SubProject_Switch("Menu", "KTBM_Level_OpeningCutscene.lua");

            KTBM_UI_Input_Clicked = false;
        else
            TextSetColor(agent_retryText, rolloverColor);
            string_currentRolloverItem = "page0_retry";
        end
    else
        TextSetColor(agent_retryText, defaultColor);
    end

    --option 2 (return to menu)
    if (KTBM_TextUI_IsCursorOverTextAgentFix(agent_returnToMenuText)) then
        if (KTBM_UI_Input_Clicked == true) then
            TextSetColor(agent_returnToMenuText, pressedColor);
            PlayClickSound();

            --OverlayShow("ui_loadingScreen.overlay", true);
            --dofile("KTBM_Level_Menu.lua");
            SubProject_Switch("Menu", "KTBM_Level_Menu.lua");

            KTBM_UI_Input_Clicked = false;
        else
            TextSetColor(agent_returnToMenuText, rolloverColor);
            string_currentRolloverItem = "page0_returnToMenu";
        end
    else
        TextSetColor(agent_returnToMenuText, defaultColor);
    end

    --option 3 (return to definitive menu)
    if (KTBM_TextUI_IsCursorOverTextAgentFix(agent_returnToDefinitiveMenuText)) then
        if (KTBM_UI_Input_Clicked == true) then
            TextSetColor(agent_returnToDefinitiveMenuText, pressedColor);
            PlayClickSound();

            RenderDelay(1);
            dofile("Menu_KTBM_QuitToDE.lua");

            KTBM_UI_Input_Clicked = false;
        else
            TextSetColor(agent_returnToDefinitiveMenuText, rolloverColor);
            string_currentRolloverItem = "page0_returnToDE";
        end
    else
        TextSetColor(agent_returnToDefinitiveMenuText, defaultColor);
    end

    --option 4 (quit to desktop)
    if (KTBM_TextUI_IsCursorOverTextAgentFix(agent_quitToDesktopText)) then
        if (KTBM_UI_Input_Clicked == true) then
            TextSetColor(agent_quitToDesktopText, pressedColor);
            PlayClickSound();

            EngineQuit();

            KTBM_UI_Input_Clicked = false;
        else
            TextSetColor(agent_quitToDesktopText, rolloverColor);
            string_currentRolloverItem = "page0_quit";
        end
    else
        TextSetColor(agent_quitToDesktopText, defaultColor);
    end

    --screen pos notes
    --0.0 0.0 0.0 = top left
    --0.5 0.5 0.0 = center
    --0.0 1.0 0.0 = bottom left
    AgentSetWorldPosFromLogicalScreenPos(agent_deathTextTitle, Vector(0.05, 0.1, 0.0));
    AgentSetWorldPosFromLogicalScreenPos(agent_deathTextScoreboard, Vector(0.05, 0.2, 0.0));
    AgentSetWorldPosFromLogicalScreenPos(agent_retryText, Vector(0.05, 0.75, 0.0));
    AgentSetWorldPosFromLogicalScreenPos(agent_returnToMenuText, Vector(0.05, 0.8, 0.0));
    AgentSetWorldPosFromLogicalScreenPos(agent_returnToDefinitiveMenuText, Vector(0.05, 0.85, 0.0));
    AgentSetWorldPosFromLogicalScreenPos(agent_quitToDesktopText, Vector(0.05, 0.9, 0.0));
end