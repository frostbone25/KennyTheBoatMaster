--[[

]]--

require("KTBM_UI_Input.lua");

local string_currentPage = "main";

local agent_menuTitle1 = nil;
local agent_menuTitle2 = nil;
local agent_page0_play = nil;
local agent_page0_costumes = nil;
local agent_page0_scoreboard = nil;
local agent_page0_options = nil;
local agent_page0_help = nil;
local agent_page0_credits = nil;
local agent_page0_returnToDE = nil;
local agent_page0_quit = nil;

local agent_pageCostumes_goBack = nil;
local agent_pageCostumes_kenny101 = nil;
local agent_pageCostumes_kenny102 = nil;
local agent_pageCostumes_kenny103 = nil;
local agent_pageCostumes_kenny103Backpack = nil;
local agent_pageCostumes_kenny202 = nil;

local agent_pageHelp_goBack = nil;
local agent_pageHelp_help = nil;

local agent_pageCredits_goBack = nil;
local agent_pageCredits_credits = nil;

local agent_pageScoreboard_goBack = nil;
local agent_pageScoreboard_main = nil;
local agent_pageScoreboard_leftArrow = nil;
local agent_pageScoreboard_pageNumber = nil;
local agent_pageScoreboard_rightArrow = nil;

local number_gameResultsDataArraySize = 0;
local number_gameResultsIndex = 1;
local gameResultsDataArray = nil;
local gameResultsObject_mostDistance = nil;
local gameResultsObject_mostKills = nil;

local SetMenuTitleProperties = function(agentName)
    KTBM_AgentSetProperty(agentName, "Text Extrude X", 5, kScene);
    KTBM_AgentSetProperty(agentName, "Text Extrude Y", 5, kScene);
    KTBM_AgentSetProperty(agentName, "Text Shadow Height", 1, kScene);
end

local SetMenuOptionProperties = function(agentName)
    KTBM_AgentSetProperty(agentName, "Text Extrude X", 5, kScene);
    KTBM_AgentSetProperty(agentName, "Text Extrude Y", 5, kScene);
    KTBM_AgentSetProperty(agentName, "Text Shadow Height", 0, kScene);
end

local GetCreditsText = function()
    local string_credits = "";

    string_credits = string_credits .. "\n"; --new line

    string_credits = string_credits .. "[Creator]";
    string_credits = string_credits .. "\n"; --new line
    string_credits = string_credits .. "David Matos";
    string_credits = string_credits .. "\n"; --new line
    string_credits = string_credits .. "\n"; --new line

    string_credits = string_credits .. "[Graphic Artists]";
    string_credits = string_credits .. "\n"; --new line
    string_credits = string_credits .. "FrankDP1";
    string_credits = string_credits .. "\n"; --new line
    string_credits = string_credits .. "\n"; --new line

    string_credits = string_credits .. "[Special Thanks]";
    string_credits = string_credits .. "\n"; --new line
    string_credits = string_credits .. "Mawrak";
    string_credits = string_credits .. "\n"; --new line
    string_credits = string_credits .. "Denymeister";
    string_credits = string_credits .. "\n"; --new line
    string_credits = string_credits .. "Violet";
    string_credits = string_credits .. "\n"; --new line
    string_credits = string_credits .. "Telltale Games & Skybound";
    string_credits = string_credits .. "\n"; --new line

    return string_credits;
end

local GetHelpText = function()
    local string_help = "";

    string_help = string_help .. "\n"; --new line
    
    string_help = string_help .. "[Keys]";
    string_help = string_help .. "\n"; --new line
    string_help = string_help .. "[A] or [Left Arrow] - Steer Left";
    string_help = string_help .. "\n"; --new line
    string_help = string_help .. "[D] or [Right Arrow] - Steer Right";

    string_help = string_help .. "\n"; --new line
    string_help = string_help .. "\n"; --new line
    string_help = string_help .. "Steer the boat away from any rocks on the water.";
    string_help = string_help .. "\n"; --new line
    string_help = string_help .. "Kill as many zombies as you can on the water.";
    string_help = string_help .. "\n"; --new line
    string_help = string_help .. "The longer distance you travel, and the more zombies you kill, the better.";
    string_help = string_help .. "\n"; --new line

    return string_help;
end

KTBM_UI_MainMenu_Start = function()
    KTBM_UI_PrepareMainMenuText();
    KTBM_UI_PrepareCostumeMenuText();
    KTBM_UI_PrepareHelpMenuText();
    KTBM_UI_PrepareCreditsMenuText();
    KTBM_UI_PrepareScoreboardMenuText();

    CursorHide(false);
    CursorEnable(true);

    gameResultsDataArray = KTBM_Data_GetAllGameResults();
    number_gameResultsDataArraySize = KTBM_GetTableSize(gameResultsDataArray);
    gameResultsObject_mostDistance = KTBM_Data_GetBestGameResultByStatistic("DistanceTraveled");
    gameResultsObject_mostKills = KTBM_Data_GetBestGameResultByStatistic("ZombiesKilled");

    --InputMapperActivate(KTBM_UI_IMAP_File);
end

KTBM_UI_PrepareMainMenuText = function()
    --create our main menu text
    agent_menuTitle1 = KTBM_TextUI_CreateTextAgent("MenuTitle1", "KENNY", Vector(0, 0, 0), 0, 0);
    agent_menuTitle2 = KTBM_TextUI_CreateTextAgent("MenuTitle2", "THE BOATMASTER", Vector(0, 0, 0), 0, 0);
    agent_page0_play = KTBM_TextUI_CreateTextAgent("Page0_Play", "Play", Vector(0, 0, 0), 0, 0);
    agent_page0_costumes = KTBM_TextUI_CreateTextAgent("Page0_Costumes", "Costumes", Vector(0, 0, 0), 0, 0);
    agent_page0_scoreboard = KTBM_TextUI_CreateTextAgent("Page0_Scoreboard", "Scoreboard", Vector(0, 0, 0), 0, 0);
    agent_page0_options = KTBM_TextUI_CreateTextAgent("Page0_Options", "Options", Vector(0, 0, 0), 0, 0);
    agent_page0_help = KTBM_TextUI_CreateTextAgent("Page0_Help", "Help", Vector(0, 0, 0), 0, 0);
    agent_page0_credits = KTBM_TextUI_CreateTextAgent("Page0_Credits", "Credits", Vector(0, 0, 0), 0, 0);
    agent_page0_returnToDE = KTBM_TextUI_CreateTextAgent("Page0_ReturnToDE", "Return To Definitive Menu", Vector(0, 0, 0), 0, 0);
    agent_page0_quit = KTBM_TextUI_CreateTextAgent("Page0_Quit", "Quit To Desktop", Vector(0, 0, 0), 0, 0);

    --scale note
    --1.0 = default
    --0.5 = half
    --2.0 = double
    TextSetScale(agent_menuTitle1, 4.25);
    TextSetScale(agent_menuTitle2, 1.5);
    TextSetScale(agent_page0_play, 1.0);
    TextSetScale(agent_page0_costumes, 1.0);
    TextSetScale(agent_page0_scoreboard, 1.0);
    TextSetScale(agent_page0_options, 1.0);
    TextSetScale(agent_page0_help, 1.0);
    TextSetScale(agent_page0_credits, 1.0);
    TextSetScale(agent_page0_returnToDE, 1.0);
    TextSetScale(agent_page0_quit, 1.0);

    --color note
    --text colors are additive on the scene
    TextSetColor(agent_menuTitle1, Color(1.0, 1.0, 1.0, 1.0));
    TextSetColor(agent_menuTitle2, Color(1.0, 0.0, 0.0, 1.0));
    TextSetColor(agent_page0_play, Color(1.0, 1.0, 1.0, 1.0));
    TextSetColor(agent_page0_costumes, Color(1.0, 1.0, 1.0, 1.0));
    TextSetColor(agent_page0_scoreboard, Color(1.0, 1.0, 1.0, 1.0));
    TextSetColor(agent_page0_options, Color(1.0, 1.0, 1.0, 1.0));
    TextSetColor(agent_page0_help, Color(1.0, 1.0, 1.0, 1.0));
    TextSetColor(agent_page0_credits, Color(1.0, 1.0, 1.0, 1.0));
    TextSetColor(agent_page0_returnToDE, Color(1.0, 1.0, 1.0, 1.0));
    TextSetColor(agent_page0_quit, Color(1.0, 1.0, 1.0, 1.0));

    --set properties on menu texts
    SetMenuTitleProperties("MenuTitle1");
    SetMenuTitleProperties("MenuTitle2");
    SetMenuOptionProperties("Page0_Play");
    SetMenuOptionProperties("Page0_Costumes");
    SetMenuOptionProperties("Page0_Scoreboard");
    SetMenuOptionProperties("Page0_Options");
    SetMenuOptionProperties("Page0_Help");
    SetMenuOptionProperties("Page0_Credits");
    SetMenuOptionProperties("Page0_ReturnToDE");
    SetMenuOptionProperties("Page0_Quit");

    --screen pos notes
    --0.0 0.0 0.0 = top left
    --0.5 0.5 0.0 = center
    --0.0 1.0 0.0 = bottom left
    local menuOffsetX = 0.0;
    local menuOffsetY = 0.1;
    AgentSetWorldPosFromLogicalScreenPos(agent_menuTitle1, Vector(0.1 + menuOffsetX, 0.1 + menuOffsetY, 0.0));
    AgentSetWorldPosFromLogicalScreenPos(agent_menuTitle2, Vector(0.105 + menuOffsetX, 0.2 + menuOffsetY, 0.0));
    AgentSetWorldPosFromLogicalScreenPos(agent_page0_play, Vector(0.105 + menuOffsetX, 0.3 + menuOffsetY, 0.0));
    AgentSetWorldPosFromLogicalScreenPos(agent_page0_costumes, Vector(0.105 + menuOffsetX, 0.35 + menuOffsetY, 0.0));
    AgentSetWorldPosFromLogicalScreenPos(agent_page0_scoreboard, Vector(0.105 + menuOffsetX, 0.4 + menuOffsetY, 0.0));
    AgentSetWorldPosFromLogicalScreenPos(agent_page0_options, Vector(0.105 + menuOffsetX, 0.45 + menuOffsetY, 0.0));
    AgentSetWorldPosFromLogicalScreenPos(agent_page0_help, Vector(0.105 + menuOffsetX, 0.5 + menuOffsetY, 0.0));
    AgentSetWorldPosFromLogicalScreenPos(agent_page0_credits, Vector(0.105 + menuOffsetX, 0.55 + menuOffsetY, 0.0));
    AgentSetWorldPosFromLogicalScreenPos(agent_page0_returnToDE, Vector(0.105 + menuOffsetX, 0.6 + menuOffsetY, 0.0));
    AgentSetWorldPosFromLogicalScreenPos(agent_page0_quit, Vector(0.105 + menuOffsetX, 0.65 + menuOffsetY, 0.0));
end

KTBM_UI_PrepareCostumeMenuText = function()
    --costumes options
    agent_pageCostumes_goBack = KTBM_TextUI_CreateTextAgent("PageCostumes_GoBack", "Go Back", Vector(0, 0, 0), 0, 0);
    agent_pageCostumes_kenny101 = KTBM_TextUI_CreateTextAgent("PageCostumes_101", "101 Outfit", Vector(0, 0, 0), 0, 0);
    agent_pageCostumes_kenny102 = KTBM_TextUI_CreateTextAgent("PageCostumes_102", "102 Outfit", Vector(0, 0, 0), 0, 0);
    agent_pageCostumes_kenny103 = KTBM_TextUI_CreateTextAgent("PageCostumes_103", "103 Outfit", Vector(0, 0, 0), 0, 0);
    agent_pageCostumes_kenny103Backpack = KTBM_TextUI_CreateTextAgent("PageCostumes_103Pack", "103 Backpack Outfit", Vector(0, 0, 0), 0, 0);
    agent_pageCostumes_kenny202 = KTBM_TextUI_CreateTextAgent("PageCostumes_202", "202 Outfit", Vector(0, 0, 0), 0, 0);

    --scale note
    --1.0 = default
    --0.5 = half
    --2.0 = double
    TextSetScale(agent_pageCostumes_goBack, 1.0);
    TextSetScale(agent_pageCostumes_kenny101, 1.0);
    TextSetScale(agent_pageCostumes_kenny102, 1.0);
    TextSetScale(agent_pageCostumes_kenny103, 1.0);
    TextSetScale(agent_pageCostumes_kenny103Backpack, 1.0);
    TextSetScale(agent_pageCostumes_kenny202, 1.0);

    --color note
    --text colors are additive on the scene
    TextSetColor(agent_pageCostumes_goBack, Color(1.0, 1.0, 1.0, 1.0));
    TextSetColor(agent_pageCostumes_kenny101, Color(1.0, 1.0, 1.0, 1.0));
    TextSetColor(agent_pageCostumes_kenny102, Color(1.0, 1.0, 1.0, 1.0));
    TextSetColor(agent_pageCostumes_kenny103, Color(1.0, 1.0, 1.0, 1.0));
    TextSetColor(agent_pageCostumes_kenny103Backpack, Color(1.0, 1.0, 1.0, 1.0));
    TextSetColor(agent_pageCostumes_kenny202, Color(1.0, 1.0, 1.0, 1.0));
    
    --set properties on menu texts
    SetMenuOptionProperties("PageCostumes_GoBack");
    SetMenuOptionProperties("PageCostumes_101");
    SetMenuOptionProperties("PageCostumes_102");
    SetMenuOptionProperties("PageCostumes_103");
    SetMenuOptionProperties("PageCostumes_103Pack");
    SetMenuOptionProperties("PageCostumes_202");
    
    --screen pos notes
    --0.0 0.0 0.0 = top left
    --0.5 0.5 0.0 = center
    --0.0 1.0 0.0 = bottom left
    local menuOffsetX = 0.0;
    local menuOffsetY = 0.1;
    AgentSetWorldPosFromLogicalScreenPos(agent_pageCostumes_goBack, Vector(0.105 + menuOffsetX, 0.3 + menuOffsetY, 0.0));
    AgentSetWorldPosFromLogicalScreenPos(agent_pageCostumes_kenny101, Vector(0.105 + menuOffsetX, 0.35 + menuOffsetY, 0.0));
    AgentSetWorldPosFromLogicalScreenPos(agent_pageCostumes_kenny102, Vector(0.105 + menuOffsetX, 0.4 + menuOffsetY, 0.0));
    AgentSetWorldPosFromLogicalScreenPos(agent_pageCostumes_kenny103, Vector(0.105 + menuOffsetX, 0.45 + menuOffsetY, 0.0));
    AgentSetWorldPosFromLogicalScreenPos(agent_pageCostumes_kenny103Backpack, Vector(0.105 + menuOffsetX, 0.5 + menuOffsetY, 0.0));
    AgentSetWorldPosFromLogicalScreenPos(agent_pageCostumes_kenny202, Vector(0.105 + menuOffsetX, 0.55 + menuOffsetY, 0.0));
end

KTBM_UI_PrepareCreditsMenuText = function()
    --costumes options
    agent_pageCredits_goBack = KTBM_TextUI_CreateTextAgent("PageCredits_GoBack", "Go Back", Vector(0, 0, 0), 0, 0);
    agent_pageCredits_credits = KTBM_TextUI_CreateTextAgent("PageCredits_Credits", GetCreditsText(), Vector(0, 0, 0), 0, 0);

    --scale note
    --1.0 = default
    --0.5 = half
    --2.0 = double
    TextSetScale(agent_pageCredits_goBack, 1.0);
    TextSetScale(agent_pageCredits_credits, 0.75);

    --color note
    --text colors are additive on the scene
    TextSetColor(agent_pageCredits_goBack, Color(1.0, 1.0, 1.0, 1.0));
    TextSetColor(agent_pageCredits_credits, Color(1.0, 1.0, 1.0, 1.0));
    
    --set properties on menu texts
    SetMenuOptionProperties("PageCredits_GoBack");
    SetMenuOptionProperties("PageCredits_Credits");

    --screen pos notes
    --0.0 0.0 0.0 = top left
    --0.5 0.5 0.0 = center
    --0.0 1.0 0.0 = bottom left
    local menuOffsetX = 0.0;
    local menuOffsetY = 0.1;
    AgentSetWorldPosFromLogicalScreenPos(agent_pageCredits_goBack, Vector(0.105 + menuOffsetX, 0.3 + menuOffsetY, 0.0));
    AgentSetWorldPosFromLogicalScreenPos(agent_pageCredits_credits, Vector(0.105 + menuOffsetX, 0.35 + menuOffsetY, 0.0));
end

KTBM_UI_PrepareHelpMenuText = function()
    --costumes options
    agent_pageHelp_goBack = KTBM_TextUI_CreateTextAgent("PageHelp_GoBack", "Go Back", Vector(0, 0, 0), 0, 0);
    agent_pageHelp_help = KTBM_TextUI_CreateTextAgent("PageHelp_Credits", GetHelpText(), Vector(0, 0, 0), 0, 0);

    --scale note
    --1.0 = default
    --0.5 = half
    --2.0 = double
    TextSetScale(agent_pageHelp_goBack, 1.0);
    TextSetScale(agent_pageHelp_help, 0.75);

    --color note
    --text colors are additive on the scene
    TextSetColor(agent_pageHelp_goBack, Color(1.0, 1.0, 1.0, 1.0));
    TextSetColor(agent_pageHelp_help, Color(1.0, 1.0, 1.0, 1.0));
    
    --set properties on menu texts
    SetMenuOptionProperties("PageHelp_GoBack");
    SetMenuOptionProperties("PageHelp_Credits");

    --screen pos notes
    --0.0 0.0 0.0 = top left
    --0.5 0.5 0.0 = center
    --0.0 1.0 0.0 = bottom left
    local menuOffsetX = 0.0;
    local menuOffsetY = 0.1;
    AgentSetWorldPosFromLogicalScreenPos(agent_pageHelp_goBack, Vector(0.105 + menuOffsetX, 0.3 + menuOffsetY, 0.0));
    AgentSetWorldPosFromLogicalScreenPos(agent_pageHelp_help, Vector(0.105 + menuOffsetX, 0.35 + menuOffsetY, 0.0));
end

KTBM_UI_PrepareScoreboardMenuText = function()
    --costumes options
    agent_pageScoreboard_goBack = KTBM_TextUI_CreateTextAgent("PageScoreboard_GoBack", "Go Back", Vector(0, 0, 0), 0, 0);
    agent_pageScoreboard_main = KTBM_TextUI_CreateTextAgent("PageScoreboard_Main", "Scoreboard Main", Vector(0, 0, 0), 0, 0);
    agent_pageScoreboard_leftArrow = KTBM_TextUI_CreateTextAgent("PageScoreboard_LeftArrow", "Previous", Vector(0, 0, 0), 1, 0); --this '<' character does not work for whatever reason
    agent_pageScoreboard_pageNumber = KTBM_TextUI_CreateTextAgent("PageScoreboard_PageNumber", "0/0", Vector(0, 0, 0), 2, 0);
    agent_pageScoreboard_rightArrow = KTBM_TextUI_CreateTextAgent("PageScoreboard_RightArrow", "Next", Vector(0, 0, 0), 3, 0);

    --scale note
    --1.0 = default
    --0.5 = half
    --2.0 = double
    TextSetScale(agent_pageScoreboard_goBack, 1.0);
    TextSetScale(agent_pageScoreboard_main, 0.75);
    TextSetScale(agent_pageScoreboard_leftArrow, 1.0);
    TextSetScale(agent_pageScoreboard_pageNumber, 1.0);
    TextSetScale(agent_pageScoreboard_rightArrow, 1.0);

    --color note
    --text colors are additive on the scene
    TextSetColor(agent_pageScoreboard_goBack, Color(1.0, 1.0, 1.0, 1.0));
    TextSetColor(agent_pageScoreboard_main, Color(1.0, 1.0, 1.0, 1.0));
    TextSetColor(agent_pageScoreboard_leftArrow, Color(1.0, 1.0, 1.0, 1.0));
    TextSetColor(agent_pageScoreboard_pageNumber, Color(1.0, 1.0, 1.0, 1.0));
    TextSetColor(agent_pageScoreboard_rightArrow, Color(1.0, 1.0, 1.0, 1.0));
    
    --set properties on menu texts
    SetMenuOptionProperties("PageScoreboard_GoBack");
    SetMenuOptionProperties("PageScoreboard_Main");
    SetMenuOptionProperties("PageScoreboard_LeftArrow");
    SetMenuOptionProperties("PageScoreboard_PageNumber");
    SetMenuOptionProperties("PageScoreboard_RightArrow");

    --screen pos notes
    --0.0 0.0 0.0 = top left
    --0.5 0.5 0.0 = center
    --0.0 1.0 0.0 = bottom left
    local menuOffsetX = 0.0;
    local menuOffsetY = 0.1;
    AgentSetWorldPosFromLogicalScreenPos(agent_pageScoreboard_goBack, Vector(0.105 + menuOffsetX, 0.3 + menuOffsetY, 0.0));
    AgentSetWorldPosFromLogicalScreenPos(agent_pageScoreboard_main, Vector(0.105 + menuOffsetX, 0.35 + menuOffsetY, 0.0));
    AgentSetWorldPosFromLogicalScreenPos(agent_pageScoreboard_leftArrow, Vector(0.105 + menuOffsetX, 0.77 + menuOffsetY, 0.0));
    AgentSetWorldPosFromLogicalScreenPos(agent_pageScoreboard_pageNumber, Vector(0.25 + menuOffsetX, 0.77 + menuOffsetY, 0.0));
    AgentSetWorldPosFromLogicalScreenPos(agent_pageScoreboard_rightArrow, Vector(0.35 + menuOffsetX, 0.77 + menuOffsetY, 0.0));
end

KTBM_UI_Update = function()  
    KTBM_UI_Input_IMAP_Update();

    local defaultColor = Color(1.0, 1.0, 1.0, 1.0);
    local rolloverColor = Color(0.25, 0.25, 0.25, 1.0);
    local pressedColor = Color(0.1, 0.0, 0.0, 1.0);
    
    --||||||||||||||||||||||||||||| BUTTON VISIBILITY |||||||||||||||||||||||||||||
    --||||||||||||||||||||||||||||| BUTTON VISIBILITY |||||||||||||||||||||||||||||
    --||||||||||||||||||||||||||||| BUTTON VISIBILITY |||||||||||||||||||||||||||||

    local bool_onMainMenuPage = string_currentPage == "main";
    local bool_onCostumePage = string_currentPage == "costumes";
    local bool_onHelpPage = string_currentPage == "help";
    local bool_onCreditsPage = string_currentPage == "credits";
    local bool_onScoreboardPage = string_currentPage == "scoreboard";

    KTBM_PropertySet(agent_page0_play, "Runtime: Visible", bool_onMainMenuPage);
    KTBM_PropertySet(agent_page0_costumes, "Runtime: Visible", bool_onMainMenuPage);
    KTBM_PropertySet(agent_page0_scoreboard, "Runtime: Visible", bool_onMainMenuPage);
    KTBM_PropertySet(agent_page0_options, "Runtime: Visible", bool_onMainMenuPage);
    KTBM_PropertySet(agent_page0_help, "Runtime: Visible", bool_onMainMenuPage);
    KTBM_PropertySet(agent_page0_credits, "Runtime: Visible", bool_onMainMenuPage);
    KTBM_PropertySet(agent_page0_returnToDE, "Runtime: Visible", bool_onMainMenuPage);
    KTBM_PropertySet(agent_page0_quit, "Runtime: Visible", bool_onMainMenuPage);

    KTBM_PropertySet(agent_pageCostumes_goBack, "Runtime: Visible", bool_onCostumePage);
    KTBM_PropertySet(agent_pageCostumes_kenny101, "Runtime: Visible", bool_onCostumePage);
    KTBM_PropertySet(agent_pageCostumes_kenny102, "Runtime: Visible", bool_onCostumePage);
    KTBM_PropertySet(agent_pageCostumes_kenny103, "Runtime: Visible", bool_onCostumePage);
    KTBM_PropertySet(agent_pageCostumes_kenny103Backpack, "Runtime: Visible", bool_onCostumePage);
    KTBM_PropertySet(agent_pageCostumes_kenny202, "Runtime: Visible", bool_onCostumePage);

    KTBM_PropertySet(agent_pageHelp_goBack, "Runtime: Visible", bool_onHelpPage);
    KTBM_PropertySet(agent_pageHelp_help, "Runtime: Visible", bool_onHelpPage);

    KTBM_PropertySet(agent_pageCredits_goBack, "Runtime: Visible", bool_onCreditsPage);
    KTBM_PropertySet(agent_pageCredits_credits, "Runtime: Visible", bool_onCreditsPage);

    KTBM_PropertySet(agent_pageScoreboard_goBack, "Runtime: Visible", bool_onScoreboardPage);
    KTBM_PropertySet(agent_pageScoreboard_main, "Runtime: Visible", bool_onScoreboardPage);
    KTBM_PropertySet(agent_pageScoreboard_leftArrow, "Runtime: Visible", bool_onScoreboardPage);
    KTBM_PropertySet(agent_pageScoreboard_pageNumber, "Runtime: Visible", bool_onScoreboardPage);
    KTBM_PropertySet(agent_pageScoreboard_rightArrow, "Runtime: Visible", bool_onScoreboardPage);

    --||||||||||||||||||||||||||||| MAIN MENU |||||||||||||||||||||||||||||
    --||||||||||||||||||||||||||||| MAIN MENU |||||||||||||||||||||||||||||
    --||||||||||||||||||||||||||||| MAIN MENU |||||||||||||||||||||||||||||

    if(bool_onMainMenuPage) then

        --option 1 (play)
        if (KTBM_TextUI_IsCursorOverTextAgent(agent_page0_play)) then
            if (KTBM_UI_Input_Clicked == true) then
                TextSetColor(agent_page0_play, pressedColor);
            
                --OverlayShow("ui_loadingScreen.overlay", true);
                --dofile("KTBM_Level_Game.lua");
                SubProject_Switch("Menu", "KTBM_Level_Game.lua");

                KTBM_UI_Input_Clicked = false;
            else
                TextSetColor(agent_page0_play, rolloverColor);
            end
        else
            TextSetColor(agent_page0_play, defaultColor);
        end
    
        --option 2 (costumes)
        if (KTBM_TextUI_IsCursorOverTextAgent(agent_page0_costumes)) then
            if (KTBM_UI_Input_Clicked == true) then
                TextSetColor(agent_page0_costumes, pressedColor);

                string_currentPage = "costumes";

                KTBM_UI_Input_Clicked = false;
            else
                TextSetColor(agent_page0_costumes, rolloverColor);
            end
        else
            TextSetColor(agent_page0_costumes, defaultColor);
        end

        --option 3 (scoreboard)
        if (KTBM_TextUI_IsCursorOverTextAgent(agent_page0_scoreboard)) then
            if (KTBM_UI_Input_Clicked == true) then
                TextSetColor(agent_page0_scoreboard, pressedColor);

                string_currentPage = "scoreboard";

                KTBM_UI_Input_Clicked = false;
            else
                TextSetColor(agent_page0_scoreboard, rolloverColor);
            end
        else
            TextSetColor(agent_page0_scoreboard, defaultColor);
        end

        --option 4 (options)
        if (KTBM_TextUI_IsCursorOverTextAgent(agent_page0_options)) then
            if (KTBM_UI_Input_Clicked == true) then
                TextSetColor(agent_page0_options, pressedColor);
                KTBM_UI_Input_Clicked = false;
            else
                TextSetColor(agent_page0_options, rolloverColor);
            end
        else
            TextSetColor(agent_page0_options, defaultColor);
        end

        --option 5 (help)
        if (KTBM_TextUI_IsCursorOverTextAgent(agent_page0_help)) then
            if (KTBM_UI_Input_Clicked == true) then
                TextSetColor(agent_page0_help, pressedColor);

                string_currentPage = "help";

                KTBM_UI_Input_Clicked = false;
            else
                TextSetColor(agent_page0_help, rolloverColor);
            end
        else
            TextSetColor(agent_page0_help, defaultColor);
        end

        --option 6 (credits)
        if (KTBM_TextUI_IsCursorOverTextAgent(agent_page0_credits)) then
            if (KTBM_UI_Input_Clicked == true) then
                TextSetColor(agent_page0_credits, pressedColor);

                string_currentPage = "credits";

                KTBM_UI_Input_Clicked = false;
            else
                TextSetColor(agent_page0_credits, rolloverColor);
            end
        else
            TextSetColor(agent_page0_credits, defaultColor);
        end

        --option 7 (return to definitive menu)
        if (KTBM_TextUI_IsCursorOverTextAgent(agent_page0_returnToDE)) then
            if (KTBM_UI_Input_Clicked == true) then
                TextSetColor(agent_page0_returnToDE, pressedColor);
            
                dofile("Menu_KTBM_QuitToDE.lua");
                
                KTBM_UI_Input_Clicked = false;
            else
                TextSetColor(agent_page0_returnToDE, rolloverColor);
            end
        else
            TextSetColor(agent_page0_returnToDE, defaultColor);
        end
    
        --option 8 (quit to desktop)
        if (KTBM_TextUI_IsCursorOverTextAgent(agent_page0_quit)) then
            if (KTBM_UI_Input_Clicked == true) then
                TextSetColor(agent_page0_quit, pressedColor);

                EngineQuit();
                KTBM_UI_Input_Clicked = false;
            else
                TextSetColor(agent_page0_quit, rolloverColor);
            end
        else
            TextSetColor(agent_page0_quit, defaultColor);
        end
    end

    --||||||||||||||||||||||||||||| COSTUMES MENU |||||||||||||||||||||||||||||
    --||||||||||||||||||||||||||||| COSTUMES MENU |||||||||||||||||||||||||||||
    --||||||||||||||||||||||||||||| COSTUMES MENU |||||||||||||||||||||||||||||

    if(bool_onCostumePage) then

        --option 1 (go back)
        if (KTBM_TextUI_IsCursorOverTextAgent(agent_pageCostumes_goBack)) then
            if (KTBM_UI_Input_Clicked == true) then
                TextSetColor(agent_pageCostumes_goBack, pressedColor);
            
                string_currentPage = "main";

                KTBM_UI_Input_Clicked = false;
            else
                TextSetColor(agent_pageCostumes_goBack, rolloverColor);
            end
        else
            TextSetColor(agent_pageCostumes_goBack, defaultColor);
        end

        --option 2 (101 costume)
        if (KTBM_TextUI_IsCursorOverTextAgent(agent_pageCostumes_kenny101)) then
            if (KTBM_UI_Input_Clicked == true) then
                TextSetColor(agent_pageCostumes_kenny101, pressedColor);

                KTBM_Costumes_Kenny_SetCostume_To101(KTBM_Cutscene_Menu_kScene);
                KTBM_UI_Input_Clicked = false;
            else
                TextSetColor(agent_pageCostumes_kenny101, rolloverColor);
            end
        else
            TextSetColor(agent_pageCostumes_kenny101, defaultColor);
        end

        --option 3 (102 costume)
        if (KTBM_TextUI_IsCursorOverTextAgent(agent_pageCostumes_kenny102)) then
            if (KTBM_UI_Input_Clicked == true) then
                TextSetColor(agent_pageCostumes_kenny102, pressedColor);

                KTBM_Costumes_Kenny_SetCostume_To102(KTBM_Cutscene_Menu_kScene);
                KTBM_UI_Input_Clicked = false;
            else
                TextSetColor(agent_pageCostumes_kenny102, rolloverColor);
            end
        else
            TextSetColor(agent_pageCostumes_kenny102, defaultColor);
        end

        --option 4 (103 costume)
        if (KTBM_TextUI_IsCursorOverTextAgent(agent_pageCostumes_kenny103)) then
            if (KTBM_UI_Input_Clicked == true) then
                TextSetColor(agent_pageCostumes_kenny103, pressedColor);

                KTBM_Costumes_Kenny_SetCostume_To103(KTBM_Cutscene_Menu_kScene);
                KTBM_UI_Input_Clicked = false;
            else
                TextSetColor(agent_pageCostumes_kenny103, rolloverColor);
            end
        else
            TextSetColor(agent_pageCostumes_kenny103, defaultColor);
        end

        --option 5 (103 pack costume)
        if (KTBM_TextUI_IsCursorOverTextAgent(agent_pageCostumes_kenny103Backpack)) then
            if (KTBM_UI_Input_Clicked == true) then
                TextSetColor(agent_pageCostumes_kenny103Backpack, pressedColor);

                KTBM_Costumes_Kenny_SetCostume_To103Pack(KTBM_Cutscene_Menu_kScene);
                KTBM_UI_Input_Clicked = false;
            else
                TextSetColor(agent_pageCostumes_kenny103Backpack, rolloverColor);
            end
        else
            TextSetColor(agent_pageCostumes_kenny103Backpack, defaultColor);
        end

        --option 6 (202 costume)
        if (KTBM_TextUI_IsCursorOverTextAgent(agent_pageCostumes_kenny202)) then
            if (KTBM_UI_Input_Clicked == true) then
                TextSetColor(agent_pageCostumes_kenny202, pressedColor);

                KTBM_Costumes_Kenny_SetCostume_To202(KTBM_Cutscene_Menu_kScene);
                KTBM_UI_Input_Clicked = false;
            else
                TextSetColor(agent_pageCostumes_kenny202, rolloverColor);
            end
        else
            TextSetColor(agent_pageCostumes_kenny202, defaultColor);
        end

    end

    --||||||||||||||||||||||||||||| HELP MENU |||||||||||||||||||||||||||||
    --||||||||||||||||||||||||||||| HELP MENU |||||||||||||||||||||||||||||
    --||||||||||||||||||||||||||||| HELP MENU |||||||||||||||||||||||||||||

    if(bool_onHelpPage) then

        --option 1 (go back)
        if (KTBM_TextUI_IsCursorOverTextAgent(agent_pageHelp_goBack)) then
            if (KTBM_UI_Input_Clicked == true) then
                TextSetColor(agent_pageHelp_goBack, pressedColor);
            
                string_currentPage = "main";

                KTBM_UI_Input_Clicked = false;
            else
                TextSetColor(agent_pageHelp_goBack, rolloverColor);
            end
        else
            TextSetColor(agent_pageHelp_goBack, defaultColor);
        end

    end

    --||||||||||||||||||||||||||||| CREDITS MENU |||||||||||||||||||||||||||||
    --||||||||||||||||||||||||||||| CREDITS MENU |||||||||||||||||||||||||||||
    --||||||||||||||||||||||||||||| CREDITS MENU |||||||||||||||||||||||||||||

    if(bool_onCreditsPage) then

        --option 1 (go back)
        if (KTBM_TextUI_IsCursorOverTextAgent(agent_pageCredits_goBack)) then
            if (KTBM_UI_Input_Clicked == true) then
                TextSetColor(agent_pageCredits_goBack, pressedColor);
            
                string_currentPage = "main";

                KTBM_UI_Input_Clicked = false;
            else
                TextSetColor(agent_pageCredits_goBack, rolloverColor);
            end
        else
            TextSetColor(agent_pageCredits_goBack, defaultColor);
        end

    end

    --||||||||||||||||||||||||||||| SCOREBOARD MENU |||||||||||||||||||||||||||||
    --||||||||||||||||||||||||||||| SCOREBOARD MENU |||||||||||||||||||||||||||||
    --||||||||||||||||||||||||||||| SCOREBOARD MENU |||||||||||||||||||||||||||||

    if(bool_onScoreboardPage) then

        number_gameResultsIndex = KTBM_Clamp(number_gameResultsIndex, 1, number_gameResultsDataArraySize - 1);
        
        local string_pageNumberText = "(" .. tostring(number_gameResultsIndex) .. "/" .. tostring(number_gameResultsDataArraySize - 1) .. ")";

        local gameResultsObject_selectedObject = gameResultsDataArray[number_gameResultsIndex];

        local string_scoreboardMainText = "";

        string_scoreboardMainText = string_scoreboardMainText .. KTBM_Data_GameResultsObjectToString(gameResultsObject_selectedObject);
        string_scoreboardMainText = string_scoreboardMainText .. "\n"; --new line

        string_scoreboardMainText = string_scoreboardMainText .. "-------[BEST DISTANCE]-------";
        string_scoreboardMainText = string_scoreboardMainText .. "\n"; --new line
        string_scoreboardMainText = string_scoreboardMainText .. KTBM_Data_GameResultsObjectToString(gameResultsObject_mostDistance);
        string_scoreboardMainText = string_scoreboardMainText .. "\n"; --new line

        string_scoreboardMainText = string_scoreboardMainText .. "-------[BEST ZOMBIES KILLED]-------";
        string_scoreboardMainText = string_scoreboardMainText .. "\n"; --new line
        string_scoreboardMainText = string_scoreboardMainText .. KTBM_Data_GameResultsObjectToString(gameResultsObject_mostKills);
        string_scoreboardMainText = string_scoreboardMainText .. "\n"; --new line

        TextSet(agent_pageScoreboard_pageNumber, string_pageNumberText);
        TextSet(agent_pageScoreboard_main, string_scoreboardMainText);

        --option 1 (go back)
        if (KTBM_TextUI_IsCursorOverTextAgent(agent_pageScoreboard_goBack)) then
            if (KTBM_UI_Input_Clicked == true) then
                TextSetColor(agent_pageScoreboard_goBack, pressedColor);
            
                string_currentPage = "main";

                KTBM_UI_Input_Clicked = false;
            else
                TextSetColor(agent_pageScoreboard_goBack, rolloverColor);
            end
        else
            TextSetColor(agent_pageScoreboard_goBack, defaultColor);
        end

        --(previous)
        if (KTBM_TextUI_IsCursorOverTextAgent(agent_pageScoreboard_leftArrow)) then
            if (KTBM_UI_Input_Clicked == true) then
                TextSetColor(agent_pageScoreboard_leftArrow, pressedColor);

                number_gameResultsIndex = number_gameResultsIndex - 1;

                KTBM_UI_Input_Clicked = false;
            else
                TextSetColor(agent_pageScoreboard_leftArrow, rolloverColor);
            end
        else
            TextSetColor(agent_pageScoreboard_leftArrow, defaultColor);
        end

        --(next)
        if (KTBM_TextUI_IsCursorOverTextAgent(agent_pageScoreboard_rightArrow)) then
            if (KTBM_UI_Input_Clicked == true) then
                TextSetColor(agent_pageScoreboard_rightArrow, pressedColor);

                number_gameResultsIndex = number_gameResultsIndex + 1;

                KTBM_UI_Input_Clicked = false;
            else
                TextSetColor(agent_pageScoreboard_rightArrow, rolloverColor);
            end
        else
            TextSetColor(agent_pageScoreboard_rightArrow, defaultColor);
        end

    end
end