--[[

]]--

require("KTBM_UI_Input.lua");
require("KTBM_UI_YesNoDialogBox.lua");

local string_currentPage = "main";

local agent_mainMenuGroup = nil;
local agent_mainTitleGraphic = nil;
local agent_mainTitleOverlayGraphic = nil;
local agent_page0_play = nil;
local agent_page0_costumes = nil;
local agent_page0_scoreboard = nil;
local agent_page0_options = nil;
local agent_page0_help = nil;
local agent_page0_credits = nil;
local agent_page0_returnToDE = nil;
local agent_page0_quit = nil;

local agent_pageCostumes_goBack = nil;
local agent_pageCostumes_kenny = nil;
local agent_pageCostumes_boat = nil;

local agent_pageCostumesKenny_goBack = nil;
local agent_pageCostumesKenny_kenny101 = nil;
local agent_pageCostumesKenny_kenny102 = nil;
local agent_pageCostumesKenny_kenny103 = nil;
local agent_pageCostumesKenny_kenny202 = nil;

local agent_pageCostumesBoat_goBack = nil;
local agent_pageCostumesBoat_skinDefault = nil;
local agent_pageCostumesBoat_skin1 = nil;
local agent_pageCostumesBoat_skin2 = nil;
local agent_pageCostumesBoat_skin3 = nil;
local agent_pageCostumesBoat_skin4 = nil;
local agent_pageCostumesBoat_skin5 = nil;

local agent_pageOptions_goBack = nil;
local agent_pageOptions_temp = nil;

local agent_pageHelp_goBack = nil;
local agent_pageHelp_help = nil;
local agent_pageHelpInputGraphic = nil;

local agent_pageCredits_goBack = nil;
local agent_pageCredits_credits = nil;

local agent_pageScoreboard_goBack = nil;
local agent_pageScoreboard_item1 = nil;
local agent_pageScoreboard_item2 = nil;
local agent_pageScoreboard_item3 = nil;
local agent_pageScoreboard_leftArrow = nil;
local agent_pageScoreboard_pageNumber = nil;
local agent_pageScoreboard_rightArrow = nil;

local number_gameResultsDataArraySize = 0;
local number_gameResultsPages = 0;
local number_gameResultsIndex = 1;
local number_gameResultsPageIndex = 1;
local gameResultsDataArray = nil;
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

    --Crediting myself... because I'm me.
    string_credits = string_credits .. "[Creator]";
    string_credits = string_credits .. "\n"; --new line
    string_credits = string_credits .. "David Matos";
    string_credits = string_credits .. "\n"; --new line
    string_credits = string_credits .. "\n"; --new line

    --Thanks frank and kasumiruuu for the graphics!
    string_credits = string_credits .. "[Graphic Artists]";
    string_credits = string_credits .. "\n"; --new line
    string_credits = string_credits .. "FrankDP1";
    string_credits = string_credits .. "\n"; --new line
    string_credits = string_credits .. "Kasumiruuu";
    string_credits = string_credits .. "\n"; --new line
    string_credits = string_credits .. "\n"; --new line

    --Special thanks to many of these peeps!
    --Most of which who have assisted through playtesting/suggestions/problem solving.
    --And others have been absolutely instrumental in the development of the project ( and modding in general, you know who you are :P ).
    string_credits = string_credits .. "[Special Thanks]";
    string_credits = string_credits .. "\n"; --new line
    string_credits = string_credits .. "Mawrak";
    string_credits = string_credits .. "\n"; --new line
    string_credits = string_credits .. "Denymeister";
    string_credits = string_credits .. "\n"; --new line
    string_credits = string_credits .. "Aizzble";
    string_credits = string_credits .. "\n"; --new line
    string_credits = string_credits .. "Klauner";
    string_credits = string_credits .. "\n"; --new line
    string_credits = string_credits .. "Pi";
    string_credits = string_credits .. "\n"; --new line
    string_credits = string_credits .. "StevieRival";
    string_credits = string_credits .. "\n"; --new line
    string_credits = string_credits .. "Violet (droyti)";
    string_credits = string_credits .. "\n"; --new line
    string_credits = string_credits .. "ThirdComingOfKenny";
    string_credits = string_credits .. "\n"; --new line

    return string_credits;
end

local GetHelpText = function()
    local string_help = "";

    --string_help = string_help .. "\n"; --new line
    
    --string_help = string_help .. "[What to do]";
    --string_help = string_help .. "\n"; --new line
    --string_help = string_help .. "Avoid crashing by steering your boat away";
    --string_help = string_help .. "\n"; --new line
    --string_help = string_help .. "from any rocks in the water. Kill as many";
    --string_help = string_help .. "\n"; --new line
    --string_help = string_help .. "zombies as you can by running them over";
    --string_help = string_help .. "\n"; --new line
    --string_help = string_help .. "with your boat. The longer distance you";
    --string_help = string_help .. "\n"; --new line
    --string_help = string_help .. "travel without crashing, the better.";
    --string_help = string_help .. "\n"; --new line

    string_help = string_help .. "[What to do]";
    string_help = string_help .. "\n"; --new line
    string_help = string_help .. "Don't crash into rocks on the water.";
    string_help = string_help .. "\n"; --new line
    string_help = string_help .. "Kill zombies with your boat.";
    string_help = string_help .. "\n"; --new line
    string_help = string_help .. "The more the distance/kills the better.";
    string_help = string_help .. "\n"; --new line

    return string_help;
end

KTBM_UI_MainMenu_Start = function()
    agent_mainMenuGroup = AgentCreate("agent_mainMenuGroup", "group.prop", Vector(0,0,0), Vector(0,0,0), KTBM_Gameplay_kScene, false, false);

    KTBM_UI_PrepareMainMenuText();

    KTBM_UI_PrepareCostumeMenuText();
    KTBM_UI_PrepareKennyCostumeMenuText();
    KTBM_UI_PrepareBoatCostumeMenuText();

    KTBM_UI_PrepareOptionsMenuText();
    KTBM_UI_PrepareHelpMenuText();
    KTBM_UI_PrepareCreditsMenuText();
    KTBM_UI_PrepareScoreboardMenuText();

    KTBM_UI_YesNoDialogBox_Start(0.075);

    CursorHide(false);
    CursorEnable(true);

    KTBM_Data_GetAllGameResultFilePaths();
    gameResultsDataArray = KTBM_Data_GetAllGameResults();

    if(gameResultsDataArray ~= nil) then
        number_gameResultsDataArraySize = KTBM_GetTableSize(gameResultsDataArray);
        gameResultsObject_mostDistance = KTBM_Data_GetBestGameResultByStatistic("DistanceTraveled");
        gameResultsObject_mostKills = KTBM_Data_GetBestGameResultByStatistic("ZombiesKilled");

        number_gameResultsPages = number_gameResultsDataArraySize / 3;
        number_gameResultsPages = KTBM_NumberRound(number_gameResultsPages, 0);
    end
end

KTBM_UI_PrepareMainMenuText = function()
    --ui_boot_title.prop
    --ui_boot_titleBackground.prop
    agent_mainTitleGraphic = AgentCreate("agent_mainTitleGraphic", "ui_boot_title.prop", Vector(0, 1, 0), Vector(0, 0, 0), KTBM_Gameplay_kScene, false, false);
    KTBM_PropertySet(agent_mainTitleGraphic, "Render Axis Scale", Vector(1.7777777778, 1.0, 1.0));
    KTBM_PropertySet(agent_mainTitleGraphic, "Render Global Scale", 0.0375);
    KTBM_PropertySet(agent_mainTitleGraphic, "Render After Anti-Aliasing", true);
    KTBM_PropertySet(agent_mainTitleGraphic, "Render Depth Test", false);
    KTBM_PropertySet(agent_mainTitleGraphic, "Render Depth Write", false);
    KTBM_PropertySet(agent_mainTitleGraphic, "Render Depth Write Alpha", false);
    ShaderSwapTexture(agent_mainTitleGraphic, "ui_boot_title.d3dtx", "KTBM_Texture_TitleGraphicV6.d3dtx");

    agent_mainTitleOverlayGraphic = AgentCreate("agent_mainTitleOverlayGraphic", "ui_boot_title.prop", Vector(0, 1, 0), Vector(0, 0, 0), KTBM_Gameplay_kScene, false, false);
    KTBM_PropertySet(agent_mainTitleOverlayGraphic, "Render Axis Scale", Vector(3, 5.0, 1.0));
    KTBM_PropertySet(agent_mainTitleOverlayGraphic, "Render Global Scale", 0.0375);
    KTBM_PropertySet(agent_mainTitleOverlayGraphic, "Render After Anti-Aliasing", true);
    KTBM_PropertySet(agent_mainTitleOverlayGraphic, "Render Depth Test", false);
    KTBM_PropertySet(agent_mainTitleOverlayGraphic, "Render Depth Write", false);
    KTBM_PropertySet(agent_mainTitleOverlayGraphic, "Render Depth Write Alpha", false);
    KTBM_PropertySet(agent_mainTitleOverlayGraphic, "Render Layer", -5);
    ShaderSwapTexture(agent_mainTitleOverlayGraphic, "ui_boot_title.d3dtx", "KTBM_Texture_BlackFadedEdges38.d3dtx");

    --create our main menu text
    agent_page0_play = KTBM_TextUI_CreateTextAgent("Page0_Play", "Play", Vector(0, 0, 0), 0, 0);
    agent_page0_costumes = KTBM_TextUI_CreateTextAgent("Page0_Costumes", "Costumes", Vector(0, 0, 0), 0, 0);
    agent_page0_scoreboard = KTBM_TextUI_CreateTextAgent("Page0_Scoreboard", "Scoreboard", Vector(0, 0, 0), 0, 0);
    agent_page0_options = KTBM_TextUI_CreateTextAgent("Page0_Options", "Options", Vector(0, 0, 0), 0, 0);
    agent_page0_help = KTBM_TextUI_CreateTextAgent("Page0_Help", "Help", Vector(0, 0, 0), 0, 0);
    agent_page0_credits = KTBM_TextUI_CreateTextAgent("Page0_Credits", "Credits", Vector(0, 0, 0), 0, 0);
    agent_page0_returnToDE = KTBM_TextUI_CreateTextAgent("Page0_ReturnToDE", "Return To Definitive Menu", Vector(0, 0, 0), 0, 0);
    agent_page0_quit = KTBM_TextUI_CreateTextAgent("Page0_Quit", "Quit To Desktop", Vector(0, 0, 0), 0, 0);


    AgentAttach(agent_mainTitleGraphic, agent_mainMenuGroup);
    AgentAttach(agent_mainTitleOverlayGraphic, agent_mainMenuGroup);
    AgentAttach(agent_page0_play, agent_mainMenuGroup);
    AgentAttach(agent_page0_costumes, agent_mainMenuGroup);
    AgentAttach(agent_page0_scoreboard, agent_mainMenuGroup);
    AgentAttach(agent_page0_options, agent_mainMenuGroup);
    AgentAttach(agent_page0_help, agent_mainMenuGroup);
    AgentAttach(agent_page0_credits, agent_mainMenuGroup);
    AgentAttach(agent_page0_returnToDE, agent_mainMenuGroup);
    AgentAttach(agent_page0_quit, agent_mainMenuGroup);

    --scale note
    --1.0 = default
    --0.5 = half
    --2.0 = double
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

    TextSetColor(agent_page0_play, Color(1.0, 1.0, 1.0, 1.0));
    TextSetColor(agent_page0_costumes, Color(1.0, 1.0, 1.0, 1.0));
    TextSetColor(agent_page0_scoreboard, Color(1.0, 1.0, 1.0, 1.0));
    TextSetColor(agent_page0_options, Color(1.0, 1.0, 1.0, 1.0));
    TextSetColor(agent_page0_help, Color(1.0, 1.0, 1.0, 1.0));
    TextSetColor(agent_page0_credits, Color(1.0, 1.0, 1.0, 1.0));
    TextSetColor(agent_page0_returnToDE, Color(1.0, 1.0, 1.0, 1.0));
    TextSetColor(agent_page0_quit, Color(1.0, 1.0, 1.0, 1.0));

    --set properties on menu texts

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
    AgentSetWorldPosFromLogicalScreenPos(agent_mainTitleGraphic, Vector(0.28, 0.265, 0.0));
    AgentSetWorldPosFromLogicalScreenPos(agent_mainTitleOverlayGraphic, Vector(0.175, 0.5, 0.0));
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
    agent_pageCostumes_goBack = KTBM_TextUI_CreateTextAgent("agent_pageCostumes_goBack", "Go Back", Vector(0, 0, 0), 0, 0);
    agent_pageCostumes_kenny = KTBM_TextUI_CreateTextAgent("agent_pageCostumes_kenny", "Kenny", Vector(0, 0, 0), 0, 0);
    agent_pageCostumes_boat = KTBM_TextUI_CreateTextAgent("agent_pageCostumes_boat", "Boat", Vector(0, 0, 0), 0, 0);

    AgentAttach(agent_pageCostumes_goBack, agent_mainMenuGroup);
    AgentAttach(agent_pageCostumes_kenny, agent_mainMenuGroup);
    AgentAttach(agent_pageCostumes_boat, agent_mainMenuGroup);

    --scale note
    --1.0 = default
    --0.5 = half
    --2.0 = double
    TextSetScale(agent_pageCostumes_goBack, 1.0);
    TextSetScale(agent_pageCostumes_kenny, 1.0);
    TextSetScale(agent_pageCostumes_boat, 1.0);

    --color note
    --text colors are additive on the scene
    TextSetColor(agent_pageCostumes_goBack, Color(1.0, 1.0, 1.0, 1.0));
    TextSetColor(agent_pageCostumes_kenny, Color(1.0, 1.0, 1.0, 1.0));
    TextSetColor(agent_pageCostumes_boat, Color(1.0, 1.0, 1.0, 1.0));
    
    --set properties on menu texts
    SetMenuOptionProperties("agent_pageCostumes_goBack");
    SetMenuOptionProperties("agent_pageCostumes_kenny");
    SetMenuOptionProperties("agent_pageCostumes_boat");
    
    --screen pos notes
    --0.0 0.0 0.0 = top left
    --0.5 0.5 0.0 = center
    --0.0 1.0 0.0 = bottom left
    local menuOffsetX = 0.0;
    local menuOffsetY = 0.1;
    AgentSetWorldPosFromLogicalScreenPos(agent_pageCostumes_goBack, Vector(0.105 + menuOffsetX, 0.3 + menuOffsetY, 0.0));
    AgentSetWorldPosFromLogicalScreenPos(agent_pageCostumes_kenny, Vector(0.105 + menuOffsetX, 0.35 + menuOffsetY, 0.0));
    AgentSetWorldPosFromLogicalScreenPos(agent_pageCostumes_boat, Vector(0.105 + menuOffsetX, 0.4 + menuOffsetY, 0.0));
end

KTBM_UI_PrepareKennyCostumeMenuText = function()
    --costumes options
    agent_pageCostumesKenny_goBack = KTBM_TextUI_CreateTextAgent("agent_pageCostumesKenny_goBack", "Go Back", Vector(0, 0, 0), 0, 0);
    agent_pageCostumesKenny_kenny101 = KTBM_TextUI_CreateTextAgent("agent_pageCostumesKenny_kenny101", "101 Outfit", Vector(0, 0, 0), 0, 0);
    agent_pageCostumesKenny_kenny102 = KTBM_TextUI_CreateTextAgent("agent_pageCostumesKenny_kenny102", "102 Outfit", Vector(0, 0, 0), 0, 0);
    agent_pageCostumesKenny_kenny103 = KTBM_TextUI_CreateTextAgent("agent_pageCostumesKenny_kenny103", "103 Outfit", Vector(0, 0, 0), 0, 0);
    agent_pageCostumesKenny_kenny202 = KTBM_TextUI_CreateTextAgent("agent_pageCostumesKenny_kenny202", "202 Outfit", Vector(0, 0, 0), 0, 0);

    AgentAttach(agent_pageCostumesKenny_goBack, agent_mainMenuGroup);
    AgentAttach(agent_pageCostumesKenny_kenny101, agent_mainMenuGroup);
    AgentAttach(agent_pageCostumesKenny_kenny102, agent_mainMenuGroup);
    AgentAttach(agent_pageCostumesKenny_kenny103, agent_mainMenuGroup);
    AgentAttach(agent_pageCostumesKenny_kenny202, agent_mainMenuGroup);

    --scale note
    --1.0 = default
    --0.5 = half
    --2.0 = double
    TextSetScale(agent_pageCostumesKenny_goBack, 1.0);
    TextSetScale(agent_pageCostumesKenny_kenny101, 1.0);
    TextSetScale(agent_pageCostumesKenny_kenny102, 1.0);
    TextSetScale(agent_pageCostumesKenny_kenny103, 1.0);
    TextSetScale(agent_pageCostumesKenny_kenny202, 1.0);

    --color note
    --text colors are additive on the scene
    TextSetColor(agent_pageCostumesKenny_goBack, Color(1.0, 1.0, 1.0, 1.0));
    TextSetColor(agent_pageCostumesKenny_kenny101, Color(1.0, 1.0, 1.0, 1.0));
    TextSetColor(agent_pageCostumesKenny_kenny102, Color(1.0, 1.0, 1.0, 1.0));
    TextSetColor(agent_pageCostumesKenny_kenny103, Color(1.0, 1.0, 1.0, 1.0));
    TextSetColor(agent_pageCostumesKenny_kenny202, Color(1.0, 1.0, 1.0, 1.0));
    
    --set properties on menu texts
    SetMenuOptionProperties("agent_pageCostumesKenny_goBack");
    SetMenuOptionProperties("agent_pageCostumesKenny_kenny101");
    SetMenuOptionProperties("agent_pageCostumesKenny_kenny102");
    SetMenuOptionProperties("agent_pageCostumesKenny_kenny103");
    SetMenuOptionProperties("agent_pageCostumesKenny_kenny202");
    
    --screen pos notes
    --0.0 0.0 0.0 = top left
    --0.5 0.5 0.0 = center
    --0.0 1.0 0.0 = bottom left
    local menuOffsetX = 0.0;
    local menuOffsetY = 0.1;
    AgentSetWorldPosFromLogicalScreenPos(agent_pageCostumesKenny_goBack, Vector(0.105 + menuOffsetX, 0.3 + menuOffsetY, 0.0));
    AgentSetWorldPosFromLogicalScreenPos(agent_pageCostumesKenny_kenny101, Vector(0.105 + menuOffsetX, 0.35 + menuOffsetY, 0.0));
    AgentSetWorldPosFromLogicalScreenPos(agent_pageCostumesKenny_kenny102, Vector(0.105 + menuOffsetX, 0.4 + menuOffsetY, 0.0));
    AgentSetWorldPosFromLogicalScreenPos(agent_pageCostumesKenny_kenny103, Vector(0.105 + menuOffsetX, 0.45 + menuOffsetY, 0.0));
    AgentSetWorldPosFromLogicalScreenPos(agent_pageCostumesKenny_kenny202, Vector(0.105 + menuOffsetX, 0.5 + menuOffsetY, 0.0));
end

KTBM_UI_PrepareBoatCostumeMenuText = function()
    --costumes options
    agent_pageCostumesBoat_goBack = KTBM_TextUI_CreateTextAgent("agent_pageCostumesBoat_goBack", "Go Back", Vector(0, 0, 0), 0, 0);
    agent_pageCostumesBoat_skinDefault = KTBM_TextUI_CreateTextAgent("agent_pageCostumesBoat_skinDefault", "Default", Vector(0, 0, 0), 0, 0);
    agent_pageCostumesBoat_skin1 = KTBM_TextUI_CreateTextAgent("agent_pageCostumesBoat_skin1", "Nautical", Vector(0, 0, 0), 0, 0);
    agent_pageCostumesBoat_skin2 = KTBM_TextUI_CreateTextAgent("agent_pageCostumesBoat_skin2", "Delta Boat", Vector(0, 0, 0), 0, 0);
    agent_pageCostumesBoat_skin3 = KTBM_TextUI_CreateTextAgent("agent_pageCostumesBoat_skin3", "Naughty Boat", Vector(0, 0, 0), 0, 0);
    agent_pageCostumesBoat_skin4 = KTBM_TextUI_CreateTextAgent("agent_pageCostumesBoat_skin4", "Snow", Vector(0, 0, 0), 0, 0);
    agent_pageCostumesBoat_skin5 = KTBM_TextUI_CreateTextAgent("agent_pageCostumesBoat_skin5", "Camo", Vector(0, 0, 0), 0, 0);

    AgentAttach(agent_pageCostumesBoat_goBack, agent_mainMenuGroup);
    AgentAttach(agent_pageCostumesBoat_skinDefault, agent_mainMenuGroup);
    AgentAttach(agent_pageCostumesBoat_skin1, agent_mainMenuGroup);
    AgentAttach(agent_pageCostumesBoat_skin2, agent_mainMenuGroup);
    AgentAttach(agent_pageCostumesBoat_skin3, agent_mainMenuGroup);
    AgentAttach(agent_pageCostumesBoat_skin4, agent_mainMenuGroup);
    AgentAttach(agent_pageCostumesBoat_skin5, agent_mainMenuGroup);

    --scale note
    --1.0 = default
    --0.5 = half
    --2.0 = double
    TextSetScale(agent_pageCostumesBoat_goBack, 1.0);
    TextSetScale(agent_pageCostumesBoat_skinDefault, 1.0);
    TextSetScale(agent_pageCostumesBoat_skin1, 1.0);
    TextSetScale(agent_pageCostumesBoat_skin2, 1.0);
    TextSetScale(agent_pageCostumesBoat_skin3, 1.0);
    TextSetScale(agent_pageCostumesBoat_skin4, 1.0);
    TextSetScale(agent_pageCostumesBoat_skin5, 1.0);

    --color note
    --text colors are additive on the scene
    TextSetColor(agent_pageCostumesBoat_goBack, Color(1.0, 1.0, 1.0, 1.0));
    TextSetColor(agent_pageCostumesBoat_skinDefault, Color(1.0, 1.0, 1.0, 1.0));
    TextSetColor(agent_pageCostumesBoat_skin1, Color(1.0, 1.0, 1.0, 1.0));
    TextSetColor(agent_pageCostumesBoat_skin2, Color(1.0, 1.0, 1.0, 1.0));
    TextSetColor(agent_pageCostumesBoat_skin3, Color(1.0, 1.0, 1.0, 1.0));
    TextSetColor(agent_pageCostumesBoat_skin4, Color(1.0, 1.0, 1.0, 1.0));
    TextSetColor(agent_pageCostumesBoat_skin5, Color(1.0, 1.0, 1.0, 1.0));

    --set properties on menu texts
    SetMenuOptionProperties("agent_pageCostumesBoat_goBack");
    SetMenuOptionProperties("agent_pageCostumesBoat_skinDefault");
    SetMenuOptionProperties("agent_pageCostumesBoat_skin1");
    SetMenuOptionProperties("agent_pageCostumesBoat_skin2");
    SetMenuOptionProperties("agent_pageCostumesBoat_skin3");
    SetMenuOptionProperties("agent_pageCostumesBoat_skin4");
    SetMenuOptionProperties("agent_pageCostumesBoat_skin5");

    --screen pos notes
    --0.0 0.0 0.0 = top left
    --0.5 0.5 0.0 = center
    --0.0 1.0 0.0 = bottom left
    local menuOffsetX = 0.0;
    local menuOffsetY = 0.1;
    AgentSetWorldPosFromLogicalScreenPos(agent_pageCostumesBoat_goBack, Vector(0.105 + menuOffsetX, 0.3 + menuOffsetY, 0.0));
    AgentSetWorldPosFromLogicalScreenPos(agent_pageCostumesBoat_skinDefault, Vector(0.105 + menuOffsetX, 0.35 + menuOffsetY, 0.0));
    AgentSetWorldPosFromLogicalScreenPos(agent_pageCostumesBoat_skin1, Vector(0.105 + menuOffsetX, 0.4 + menuOffsetY, 0.0));
    AgentSetWorldPosFromLogicalScreenPos(agent_pageCostumesBoat_skin2, Vector(0.105 + menuOffsetX, 0.45 + menuOffsetY, 0.0));
    AgentSetWorldPosFromLogicalScreenPos(agent_pageCostumesBoat_skin3, Vector(0.105 + menuOffsetX, 0.5 + menuOffsetY, 0.0));
    AgentSetWorldPosFromLogicalScreenPos(agent_pageCostumesBoat_skin4, Vector(0.105 + menuOffsetX, 0.55 + menuOffsetY, 0.0));
    AgentSetWorldPosFromLogicalScreenPos(agent_pageCostumesBoat_skin5, Vector(0.105 + menuOffsetX, 0.6 + menuOffsetY, 0.0));
end

KTBM_UI_PrepareCreditsMenuText = function()
    --costumes options
    agent_pageCredits_goBack = KTBM_TextUI_CreateTextAgent("PageCredits_GoBack", "Go Back", Vector(0, 0, 0), 0, 0);
    agent_pageCredits_credits = KTBM_TextUI_CreateTextAgent("PageCredits_Credits", GetCreditsText(), Vector(0, 0, 0), 0, 0);

    AgentAttach(agent_pageCredits_goBack, agent_mainMenuGroup);
    AgentAttach(agent_pageCredits_credits, agent_mainMenuGroup);

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

    agent_pageHelpInputGraphic = AgentCreate("agent_pageHelpInputGraphic", "ui_boot_title.prop", Vector(0, 1, 0), Vector(0, 0, 0), KTBM_Gameplay_kScene, false, false);
    KTBM_PropertySet(agent_pageHelpInputGraphic, "Render Axis Scale", Vector(1, 1, 1));
    KTBM_PropertySet(agent_pageHelpInputGraphic, "Render Global Scale", 0.0375);
    KTBM_PropertySet(agent_pageHelpInputGraphic, "Render After Anti-Aliasing", true);
    KTBM_PropertySet(agent_pageHelpInputGraphic, "Render Depth Test", false);
    KTBM_PropertySet(agent_pageHelpInputGraphic, "Render Depth Write", false);
    KTBM_PropertySet(agent_pageHelpInputGraphic, "Render Depth Write Alpha", false);
    KTBM_PropertySet(agent_pageHelpInputGraphic, "Render Layer", 5);
    ShaderSwapTexture(agent_pageHelpInputGraphic, "ui_boot_title.d3dtx", "KTBM_Texture_HelpInputDiagram.d3dtx");

    AgentAttach(agent_pageHelp_goBack, agent_mainMenuGroup);
    AgentAttach(agent_pageHelp_help, agent_mainMenuGroup);
    AgentAttach(agent_pageHelpInputGraphic, agent_mainMenuGroup);

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
    AgentSetWorldPosFromLogicalScreenPos(agent_pageHelpInputGraphic, Vector(0.235 + menuOffsetX, 0.675 + menuOffsetY, 0.0));
end

KTBM_UI_PrepareOptionsMenuText = function()
    --costumes options
    agent_pageOptions_goBack = KTBM_TextUI_CreateTextAgent("agent_pageOptions_goBack", "Go Back", Vector(0, 0, 0), 0, 0);
    agent_pageOptions_temp = KTBM_TextUI_CreateTextAgent("agent_pageOptions_temp", "Not Implemented Yet", Vector(0, 0, 0), 0, 0);

    AgentAttach(agent_pageOptions_goBack, agent_mainMenuGroup);
    AgentAttach(agent_pageOptions_temp, agent_mainMenuGroup);

    --scale note
    --1.0 = default
    --0.5 = half
    --2.0 = double
    TextSetScale(agent_pageOptions_goBack, 1.0);
    TextSetScale(agent_pageOptions_temp, 0.75);

    --color note
    --text colors are additive on the scene
    TextSetColor(agent_pageOptions_goBack, Color(1.0, 1.0, 1.0, 1.0));
    TextSetColor(agent_pageOptions_temp, Color(1.0, 1.0, 1.0, 1.0));
    
    --set properties on menu texts
    SetMenuOptionProperties("agent_pageOptions_goBack");
    SetMenuOptionProperties("agent_pageOptions_temp");

    --screen pos notes
    --0.0 0.0 0.0 = top left
    --0.5 0.5 0.0 = center
    --0.0 1.0 0.0 = bottom left
    local menuOffsetX = 0.0;
    local menuOffsetY = 0.1;
    AgentSetWorldPosFromLogicalScreenPos(agent_pageOptions_goBack, Vector(0.105 + menuOffsetX, 0.3 + menuOffsetY, 0.0));
    AgentSetWorldPosFromLogicalScreenPos(agent_pageOptions_temp, Vector(0.105 + menuOffsetX, 0.35 + menuOffsetY, 0.0));
end

KTBM_UI_PrepareScoreboardMenuText = function()
    --costumes options
    agent_pageScoreboard_goBack = KTBM_TextUI_CreateTextAgent("PageScoreboard_GoBack", "Go Back", Vector(0, 0, 0), 0, 0);
    agent_pageScoreboard_item1 = KTBM_TextUI_CreateTextAgent("agent_pageScoreboard_item1", "Item 1", Vector(0, 0, 0), 0, 0);
    agent_pageScoreboard_item2 = KTBM_TextUI_CreateTextAgent("agent_pageScoreboard_item2", "Item 2", Vector(0, 0, 0), 0, 0);
    agent_pageScoreboard_item3 = KTBM_TextUI_CreateTextAgent("agent_pageScoreboard_item3", "Item 3", Vector(0, 0, 0), 0, 0);
    agent_pageScoreboard_leftArrow = KTBM_TextUI_CreateTextAgent("PageScoreboard_LeftArrow", "Previous", Vector(0, 0, 0), 1, 0); --this '<' character does not work for whatever reason
    agent_pageScoreboard_pageNumber = KTBM_TextUI_CreateTextAgent("PageScoreboard_PageNumber", "0/0", Vector(0, 0, 0), 2, 0);
    agent_pageScoreboard_rightArrow = KTBM_TextUI_CreateTextAgent("PageScoreboard_RightArrow", "Next", Vector(0, 0, 0), 3, 0);

    AgentAttach(agent_pageScoreboard_goBack, agent_mainMenuGroup);
    AgentAttach(agent_pageScoreboard_item1, agent_mainMenuGroup);
    AgentAttach(agent_pageScoreboard_item2, agent_mainMenuGroup);
    AgentAttach(agent_pageScoreboard_item3, agent_mainMenuGroup);
    AgentAttach(agent_pageScoreboard_leftArrow, agent_mainMenuGroup);
    AgentAttach(agent_pageScoreboard_pageNumber, agent_mainMenuGroup);
    AgentAttach(agent_pageScoreboard_rightArrow, agent_mainMenuGroup);

    --scale note
    --1.0 = default
    --0.5 = half
    --2.0 = double
    TextSetScale(agent_pageScoreboard_goBack, 1.0);
    TextSetScale(agent_pageScoreboard_item1, 0.75);
    TextSetScale(agent_pageScoreboard_item2, 0.75);
    TextSetScale(agent_pageScoreboard_item3, 0.75);
    TextSetScale(agent_pageScoreboard_leftArrow, 1.0);
    TextSetScale(agent_pageScoreboard_pageNumber, 1.0);
    TextSetScale(agent_pageScoreboard_rightArrow, 1.0);

    --color note
    --text colors are additive on the scene
    TextSetColor(agent_pageScoreboard_goBack, Color(1.0, 1.0, 1.0, 1.0));
    TextSetColor(agent_pageScoreboard_item1, Color(1.0, 1.0, 1.0, 1.0));
    TextSetColor(agent_pageScoreboard_item2, Color(1.0, 1.0, 1.0, 1.0));
    TextSetColor(agent_pageScoreboard_item3, Color(1.0, 1.0, 1.0, 1.0));
    TextSetColor(agent_pageScoreboard_leftArrow, Color(1.0, 1.0, 1.0, 1.0));
    TextSetColor(agent_pageScoreboard_pageNumber, Color(1.0, 1.0, 1.0, 1.0));
    TextSetColor(agent_pageScoreboard_rightArrow, Color(1.0, 1.0, 1.0, 1.0));
    
    --set properties on menu texts
    SetMenuOptionProperties("PageScoreboard_GoBack");
    SetMenuOptionProperties("agent_pageScoreboard_item1");
    SetMenuOptionProperties("agent_pageScoreboard_item2");
    SetMenuOptionProperties("agent_pageScoreboard_item3");
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

    AgentSetWorldPosFromLogicalScreenPos(agent_pageScoreboard_item1, Vector(0.105 + menuOffsetX, 0.35 + menuOffsetY, 0.0));
    AgentSetWorldPosFromLogicalScreenPos(agent_pageScoreboard_item2, Vector(0.105 + menuOffsetX, 0.49 + menuOffsetY, 0.0));
    AgentSetWorldPosFromLogicalScreenPos(agent_pageScoreboard_item3, Vector(0.105 + menuOffsetX, 0.63 + menuOffsetY, 0.0));

    AgentSetWorldPosFromLogicalScreenPos(agent_pageScoreboard_leftArrow, Vector(0.105 + menuOffsetX, 0.77 + menuOffsetY, 0.0));
    AgentSetWorldPosFromLogicalScreenPos(agent_pageScoreboard_pageNumber, Vector(0.25 + menuOffsetX, 0.77 + menuOffsetY, 0.0));
    AgentSetWorldPosFromLogicalScreenPos(agent_pageScoreboard_rightArrow, Vector(0.35 + menuOffsetX, 0.77 + menuOffsetY, 0.0));
end

KTBM_UI_Update = function()  
    KTBM_UI_Input_IMAP_Update();
    KTBM_UI_YesNoDialogBox_Update();

    PlayRolloverSound();

    local defaultColor = Color(1.0, 1.0, 1.0, 1.0);
    local rolloverColor = Color(0.25, 0.25, 0.25, 1.0);
    local pressedColor = Color(0.1, 0.0, 0.0, 1.0);

    local bestRunColor = Color(0.75, 1.0, 0.75, 1.0);
    local bestDistanceColor = Color(0.75, 0.75, 1.0, 1.0);
    local mostKillsColor = Color(1.0, 0.75, 0.75, 1.0);
    
    --||||||||||||||||||||||||||||| BUTTON VISIBILITY |||||||||||||||||||||||||||||
    --||||||||||||||||||||||||||||| BUTTON VISIBILITY |||||||||||||||||||||||||||||
    --||||||||||||||||||||||||||||| BUTTON VISIBILITY |||||||||||||||||||||||||||||

    local bool_onMainMenuPage = string_currentPage == "main" and (not KTBM_UI_YesNoDialogBox_IsOpen);
    local bool_onCostumePage = string_currentPage == "costumes" and (not KTBM_UI_YesNoDialogBox_IsOpen);
    local bool_onCostumeKennyPage = string_currentPage == "costumesKenny" and (not KTBM_UI_YesNoDialogBox_IsOpen);
    local bool_onCostumeBoatPage = string_currentPage == "costumesBoat" and (not KTBM_UI_YesNoDialogBox_IsOpen);
    local bool_onOptionsPage = string_currentPage == "options" and (not KTBM_UI_YesNoDialogBox_IsOpen);
    local bool_onHelpPage = string_currentPage == "help" and (not KTBM_UI_YesNoDialogBox_IsOpen);
    local bool_onCreditsPage = string_currentPage == "credits" and (not KTBM_UI_YesNoDialogBox_IsOpen);
    local bool_onScoreboardPage = string_currentPage == "scoreboard" and (not KTBM_UI_YesNoDialogBox_IsOpen);

    KTBM_PropertySet(agent_page0_play, "Runtime: Visible", bool_onMainMenuPage);
    KTBM_PropertySet(agent_page0_costumes, "Runtime: Visible", bool_onMainMenuPage);
    KTBM_PropertySet(agent_page0_scoreboard, "Runtime: Visible", bool_onMainMenuPage);
    KTBM_PropertySet(agent_page0_options, "Runtime: Visible", bool_onMainMenuPage);
    KTBM_PropertySet(agent_page0_help, "Runtime: Visible", bool_onMainMenuPage);
    KTBM_PropertySet(agent_page0_credits, "Runtime: Visible", bool_onMainMenuPage);
    KTBM_PropertySet(agent_page0_returnToDE, "Runtime: Visible", bool_onMainMenuPage);
    KTBM_PropertySet(agent_page0_quit, "Runtime: Visible", bool_onMainMenuPage);

    KTBM_PropertySet(agent_pageCostumes_goBack, "Runtime: Visible", bool_onCostumePage);
    KTBM_PropertySet(agent_pageCostumes_kenny, "Runtime: Visible", bool_onCostumePage);
    KTBM_PropertySet(agent_pageCostumes_boat, "Runtime: Visible", bool_onCostumePage);

    KTBM_PropertySet(agent_pageCostumesKenny_goBack, "Runtime: Visible", bool_onCostumeKennyPage);
    KTBM_PropertySet(agent_pageCostumesKenny_kenny101, "Runtime: Visible", bool_onCostumeKennyPage);
    KTBM_PropertySet(agent_pageCostumesKenny_kenny102, "Runtime: Visible", bool_onCostumeKennyPage);
    KTBM_PropertySet(agent_pageCostumesKenny_kenny103, "Runtime: Visible", bool_onCostumeKennyPage);
    KTBM_PropertySet(agent_pageCostumesKenny_kenny202, "Runtime: Visible", bool_onCostumeKennyPage);

    KTBM_PropertySet(agent_pageCostumesBoat_goBack, "Runtime: Visible", bool_onCostumeBoatPage);
    KTBM_PropertySet(agent_pageCostumesBoat_skinDefault, "Runtime: Visible", bool_onCostumeBoatPage);
    KTBM_PropertySet(agent_pageCostumesBoat_skin1, "Runtime: Visible", bool_onCostumeBoatPage);
    KTBM_PropertySet(agent_pageCostumesBoat_skin2, "Runtime: Visible", bool_onCostumeBoatPage);
    KTBM_PropertySet(agent_pageCostumesBoat_skin3, "Runtime: Visible", bool_onCostumeBoatPage);
    KTBM_PropertySet(agent_pageCostumesBoat_skin4, "Runtime: Visible", bool_onCostumeBoatPage);
    KTBM_PropertySet(agent_pageCostumesBoat_skin5, "Runtime: Visible", bool_onCostumeBoatPage);

    KTBM_PropertySet(agent_pageOptions_goBack, "Runtime: Visible", bool_onOptionsPage);
    KTBM_PropertySet(agent_pageOptions_temp, "Runtime: Visible", bool_onOptionsPage);

    KTBM_PropertySet(agent_pageHelp_goBack, "Runtime: Visible", bool_onHelpPage);
    KTBM_PropertySet(agent_pageHelp_help, "Runtime: Visible", bool_onHelpPage);
    KTBM_PropertySet(agent_pageHelpInputGraphic, "Runtime: Visible", bool_onHelpPage);

    KTBM_PropertySet(agent_pageCredits_goBack, "Runtime: Visible", bool_onCreditsPage);
    KTBM_PropertySet(agent_pageCredits_credits, "Runtime: Visible", bool_onCreditsPage);

    KTBM_PropertySet(agent_pageScoreboard_goBack, "Runtime: Visible", bool_onScoreboardPage);
    KTBM_PropertySet(agent_pageScoreboard_item1, "Runtime: Visible", bool_onScoreboardPage);
    KTBM_PropertySet(agent_pageScoreboard_item2, "Runtime: Visible", bool_onScoreboardPage);
    KTBM_PropertySet(agent_pageScoreboard_item3, "Runtime: Visible", bool_onScoreboardPage);
    KTBM_PropertySet(agent_pageScoreboard_leftArrow, "Runtime: Visible", bool_onScoreboardPage);
    KTBM_PropertySet(agent_pageScoreboard_pageNumber, "Runtime: Visible", bool_onScoreboardPage);
    KTBM_PropertySet(agent_pageScoreboard_rightArrow, "Runtime: Visible", bool_onScoreboardPage);

    KTBM_PropertySet(agent_mainMenuGroup, "Group - Visible", not KTBM_UI_YesNoDialogBox_IsOpen);

    --||||||||||||||||||||||||||||| YES NO HANDLING |||||||||||||||||||||||||||||
    --||||||||||||||||||||||||||||| YES NO HANDLING |||||||||||||||||||||||||||||
    --||||||||||||||||||||||||||||| YES NO HANDLING |||||||||||||||||||||||||||||

    local string_dialog_quitToDesktop = "Are you sure you want\n to quit to the desktop?";
    local string_dialog_returnToDE = "Are you sure you want to\n return to the definitive menu?";

    if(KTBM_UI_YesNoDialogBox_CurrentDialog == string_dialog_quitToDesktop) then
        if not (KTBM_UI_YesNoDialogBox_Response == nil) then
            if(KTBM_UI_YesNoDialogBox_Response == true) then
                EngineQuit();
            end

            KTBM_UI_YesNoDialogBox_Response = nil;
            KTBM_UI_YesNoDialogBox_CurrentDialog = "";
            KTBM_UI_YesNoDialogBox_IsOpen = false;
        end
    end

    if(KTBM_UI_YesNoDialogBox_CurrentDialog == string_dialog_returnToDE) then
        if not (KTBM_UI_YesNoDialogBox_Response == nil) then
            if(KTBM_UI_YesNoDialogBox_Response == true) then
                dofile("Menu_KTBM_QuitToDE.lua");
            end

            KTBM_UI_YesNoDialogBox_Response = nil;
            KTBM_UI_YesNoDialogBox_CurrentDialog = "";
            KTBM_UI_YesNoDialogBox_IsOpen = false;
        end
    end

    if(KTBM_UI_YesNoDialogBox_IsOpen == true) then
        return;
    end

    --||||||||||||||||||||||||||||| MAIN MENU |||||||||||||||||||||||||||||
    --||||||||||||||||||||||||||||| MAIN MENU |||||||||||||||||||||||||||||
    --||||||||||||||||||||||||||||| MAIN MENU |||||||||||||||||||||||||||||

    if(bool_onMainMenuPage) then

        --option 1 (play)
        if (KTBM_TextUI_IsCursorOverTextAgent(agent_page0_play)) then
            if (KTBM_UI_Input_Clicked == true) then
                TextSetColor(agent_page0_play, pressedColor);
                PlayClickSound();

                if(KTBM_Data_PlayerSettings ~= nil) then
                    if(KTBM_Data_PlayerSettings.Gameplay.ForceSkipCutscenes == true) then
                        SubProject_Switch("Menu", "KTBM_Level_Game.lua");
                    else
                        SubProject_Switch("Menu", "KTBM_Level_OpeningCutscene.lua");
                    end
                else
                    SubProject_Switch("Menu", "KTBM_Level_OpeningCutscene.lua");
                end


                KTBM_UI_Input_Clicked = false;
            else
                TextSetColor(agent_page0_play, rolloverColor);
                string_currentRolloverItem = "page0_play";
            end
        else
            TextSetColor(agent_page0_play, defaultColor);
        end
    
        --option 2 (costumes)
        if (KTBM_TextUI_IsCursorOverTextAgent(agent_page0_costumes)) then
            if (KTBM_UI_Input_Clicked == true) then
                TextSetColor(agent_page0_costumes, pressedColor);
                PlayClickSound();

                string_currentPage = "costumes";
                KTBM_Cutscene_Menu_PlayVoiceLine_BrowsingKennySkins();

                KTBM_UI_Input_Clicked = false;
            else
                TextSetColor(agent_page0_costumes, rolloverColor);
                string_currentRolloverItem = "page0_costumes";
            end
        else
            TextSetColor(agent_page0_costumes, defaultColor);
        end

        --option 3 (scoreboard)
        if (KTBM_TextUI_IsCursorOverTextAgent(agent_page0_scoreboard)) then
            if (KTBM_UI_Input_Clicked == true) then
                TextSetColor(agent_page0_scoreboard, pressedColor);
                PlayClickSound();

                string_currentPage = "scoreboard";

                KTBM_UI_Input_Clicked = false;
            else
                TextSetColor(agent_page0_scoreboard, rolloverColor);
                string_currentRolloverItem = "page0_scoreboard";
            end
        else
            TextSetColor(agent_page0_scoreboard, defaultColor);
        end

        --option 4 (options)
        if (KTBM_TextUI_IsCursorOverTextAgent(agent_page0_options)) then
            if (KTBM_UI_Input_Clicked == true) then
                TextSetColor(agent_page0_options, pressedColor);
                PlayClickSound();

                string_currentPage = "options";

                KTBM_UI_Input_Clicked = false;
            else
                TextSetColor(agent_page0_options, rolloverColor);
                string_currentRolloverItem = "page0_options";
            end
        else
            TextSetColor(agent_page0_options, defaultColor);
        end

        --option 5 (help)
        if (KTBM_TextUI_IsCursorOverTextAgent(agent_page0_help)) then
            if (KTBM_UI_Input_Clicked == true) then
                TextSetColor(agent_page0_help, pressedColor);
                PlayClickSound();

                string_currentPage = "help";

                KTBM_UI_Input_Clicked = false;
            else
                TextSetColor(agent_page0_help, rolloverColor);
                string_currentRolloverItem = "page0_help";
            end
        else
            TextSetColor(agent_page0_help, defaultColor);
        end

        --option 6 (credits)
        if (KTBM_TextUI_IsCursorOverTextAgent(agent_page0_credits)) then
            if (KTBM_UI_Input_Clicked == true) then
                TextSetColor(agent_page0_credits, pressedColor);
                PlayClickSound();

                string_currentPage = "credits";

                KTBM_UI_Input_Clicked = false;
            else
                TextSetColor(agent_page0_credits, rolloverColor);
                string_currentRolloverItem = "page0_credits";
            end
        else
            TextSetColor(agent_page0_credits, defaultColor);
        end

        --option 7 (return to definitive menu)
        if (KTBM_TextUI_IsCursorOverTextAgent(agent_page0_returnToDE)) then
            if (KTBM_UI_Input_Clicked == true) then
                TextSetColor(agent_page0_returnToDE, pressedColor);
                PlayClickSound();
            
                KTBM_UI_PopYesNoDialogBox(string_dialog_returnToDE);
                
                KTBM_UI_Input_Clicked = false;
            else
                TextSetColor(agent_page0_returnToDE, rolloverColor);
                string_currentRolloverItem = "page0_returnToDE";
            end
        else
            TextSetColor(agent_page0_returnToDE, defaultColor);
        end
    
        --option 8 (quit to desktop)
        if (KTBM_TextUI_IsCursorOverTextAgent(agent_page0_quit)) then
            if (KTBM_UI_Input_Clicked == true) then
                TextSetColor(agent_page0_quit, pressedColor);
                PlayClickSound();

                KTBM_UI_PopYesNoDialogBox(string_dialog_quitToDesktop);

                KTBM_UI_Input_Clicked = false;
            else
                TextSetColor(agent_page0_quit, rolloverColor);
                string_currentRolloverItem = "page0_quit";
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
                PlayClickSound();
            
                string_currentPage = "main";

                KTBM_UI_Input_Clicked = false;
            else
                TextSetColor(agent_pageCostumes_goBack, rolloverColor);
                string_currentRolloverItem = "pageCostume_goBack";
            end
        else
            TextSetColor(agent_pageCostumes_goBack, defaultColor);
        end

        --option 2 (kenny)
        if (KTBM_TextUI_IsCursorOverTextAgent(agent_pageCostumes_kenny)) then
            if (KTBM_UI_Input_Clicked == true) then
                TextSetColor(agent_pageCostumes_kenny, pressedColor);
                PlayClickSound();

                string_currentPage = "costumesKenny";

                KTBM_UI_Input_Clicked = false;
            else
                TextSetColor(agent_pageCostumes_kenny, rolloverColor);
                string_currentRolloverItem = "pageKennyCostumes";
            end
        else
            TextSetColor(agent_pageCostumes_kenny, defaultColor);
        end

        --option 3 (boat)
        if (KTBM_TextUI_IsCursorOverTextAgent(agent_pageCostumes_boat)) then
            if (KTBM_UI_Input_Clicked == true) then
                TextSetColor(agent_pageCostumes_boat, pressedColor);
                PlayClickSound();

                string_currentPage = "costumesBoat";

                KTBM_Cutscene_Menu_PlayVoiceLine_BrowsingBoatSkins();

                KTBM_UI_Input_Clicked = false;
            else
                TextSetColor(agent_pageCostumes_boat, rolloverColor);
                string_currentRolloverItem = "pageBoatCostumes";
            end
        else
            TextSetColor(agent_pageCostumes_boat, defaultColor);
        end

    end

    --||||||||||||||||||||||||||||| COSTUMES KENNY MENU |||||||||||||||||||||||||||||
    --||||||||||||||||||||||||||||| COSTUMES KENNY MENU |||||||||||||||||||||||||||||
    --||||||||||||||||||||||||||||| COSTUMES KENNY MENU |||||||||||||||||||||||||||||

    if(bool_onCostumeKennyPage) then

        --option 1 (go back)
        if (KTBM_TextUI_IsCursorOverTextAgent(agent_pageCostumesKenny_goBack)) then
            if (KTBM_UI_Input_Clicked == true) then
                TextSetColor(agent_pageCostumesKenny_goBack, pressedColor);
                PlayClickSound();
            
                string_currentPage = "costumes";
                KTBM_Cutscene_Menu_PlayVoiceLine_LeavingKennySkins();

                KTBM_UI_Input_Clicked = false;
            else
                TextSetColor(agent_pageCostumesKenny_goBack, rolloverColor);
                string_currentRolloverItem = "pageCostumeKenny_goBack";
            end
        else
            TextSetColor(agent_pageCostumesKenny_goBack, defaultColor);
        end

        --option 2 (kenny 101)
        if (KTBM_TextUI_IsCursorOverTextAgent(agent_pageCostumesKenny_kenny101)) then
            if (KTBM_UI_Input_Clicked == true) then
                TextSetColor(agent_pageCostumesKenny_kenny101, pressedColor);
                PlayClickSound();

                KTBM_Costumes_Kenny_SetCostume_To101(KTBM_Cutscene_Menu_kScene);

                KTBM_UI_Input_Clicked = false;
            else
                TextSetColor(agent_pageCostumesKenny_kenny101, rolloverColor);
                string_currentRolloverItem = "pageCostumeKenny_101";
            end
        else
            TextSetColor(agent_pageCostumesKenny_kenny101, defaultColor);
        end

        --option 3 (kenny 102)
        if (KTBM_TextUI_IsCursorOverTextAgent(agent_pageCostumesKenny_kenny102)) then
            if (KTBM_UI_Input_Clicked == true) then
                TextSetColor(agent_pageCostumesKenny_kenny102, pressedColor);
                PlayClickSound();

                KTBM_Costumes_Kenny_SetCostume_To102(KTBM_Cutscene_Menu_kScene);

                KTBM_UI_Input_Clicked = false;
            else
                TextSetColor(agent_pageCostumesKenny_kenny102, rolloverColor);
                string_currentRolloverItem = "pageCostumeKenny_102";
            end
        else
            TextSetColor(agent_pageCostumesKenny_kenny102, defaultColor);
        end

        --option 4 (kenny 103)
        if (KTBM_TextUI_IsCursorOverTextAgent(agent_pageCostumesKenny_kenny103)) then
            if (KTBM_UI_Input_Clicked == true) then
                TextSetColor(agent_pageCostumesKenny_kenny103, pressedColor);
                PlayClickSound();

                KTBM_Costumes_Kenny_SetCostume_To103(KTBM_Cutscene_Menu_kScene);

                KTBM_UI_Input_Clicked = false;
            else
                TextSetColor(agent_pageCostumesKenny_kenny103, rolloverColor);
                string_currentRolloverItem = "pageCostumeKenny_103";
            end
        else
            TextSetColor(agent_pageCostumesKenny_kenny103, defaultColor);
        end

        --option 5 (kenny 202)
        if (KTBM_TextUI_IsCursorOverTextAgent(agent_pageCostumesKenny_kenny202)) then
            if (KTBM_UI_Input_Clicked == true) then
                TextSetColor(agent_pageCostumesKenny_kenny202, pressedColor);
                PlayClickSound();

                KTBM_Costumes_Kenny_SetCostume_To202(KTBM_Cutscene_Menu_kScene);

                KTBM_UI_Input_Clicked = false;
            else
                TextSetColor(agent_pageCostumesKenny_kenny202, rolloverColor);
                string_currentRolloverItem = "pageCostumeKenny_202";
            end
        else
            TextSetColor(agent_pageCostumesKenny_kenny202, defaultColor);
        end

    end

    --||||||||||||||||||||||||||||| COSTUMES KENNY MENU |||||||||||||||||||||||||||||
    --||||||||||||||||||||||||||||| COSTUMES KENNY MENU |||||||||||||||||||||||||||||
    --||||||||||||||||||||||||||||| COSTUMES KENNY MENU |||||||||||||||||||||||||||||

    if(bool_onCostumeBoatPage) then

        --option 1 (go back)
        if (KTBM_TextUI_IsCursorOverTextAgent(agent_pageCostumesBoat_goBack)) then
            if (KTBM_UI_Input_Clicked == true) then
                TextSetColor(agent_pageCostumesBoat_goBack, pressedColor);
                PlayClickSound();
            
                string_currentPage = "costumes";

                KTBM_UI_Input_Clicked = false;
            else
                TextSetColor(agent_pageCostumesBoat_goBack, rolloverColor);
                string_currentRolloverItem = "pageCostumeBoat_goBack";
            end
        else
            TextSetColor(agent_pageCostumesBoat_goBack, defaultColor);
        end

        --option 2 (boat default)
        if (KTBM_TextUI_IsCursorOverTextAgent(agent_pageCostumesBoat_skinDefault)) then
            if (KTBM_UI_Input_Clicked == true) then
                TextSetColor(agent_pageCostumesBoat_skinDefault, pressedColor);
                PlayClickSound();

                KTBM_Costumes_Boat_ApplySkinDefault(KTBM_Cutscene_Menu_kScene);

                KTBM_UI_Input_Clicked = false;
            else
                TextSetColor(agent_pageCostumesBoat_skinDefault, rolloverColor);
                string_currentRolloverItem = "pageCostumeBoat_default";
            end
        else
            TextSetColor(agent_pageCostumesBoat_skinDefault, defaultColor);
        end

        --option 3 (boat skin 1)
        if (KTBM_TextUI_IsCursorOverTextAgent(agent_pageCostumesBoat_skin1)) then
            if (KTBM_UI_Input_Clicked == true) then
                TextSetColor(agent_pageCostumesBoat_skin1, pressedColor);
                PlayClickSound();

                KTBM_Costumes_Boat_ApplySkin1(KTBM_Cutscene_Menu_kScene);

                KTBM_UI_Input_Clicked = false;
            else
                TextSetColor(agent_pageCostumesBoat_skin1, rolloverColor);
                string_currentRolloverItem = "pageCostumeBoat_skin1";
            end
        else
            TextSetColor(agent_pageCostumesBoat_skin1, defaultColor);
        end

        --option 4 (boat skin 2)
        if (KTBM_TextUI_IsCursorOverTextAgent(agent_pageCostumesBoat_skin2)) then
            if (KTBM_UI_Input_Clicked == true) then
                TextSetColor(agent_pageCostumesBoat_skin2, pressedColor);
                PlayClickSound();

                KTBM_Costumes_Boat_ApplySkin2(KTBM_Cutscene_Menu_kScene);

                KTBM_UI_Input_Clicked = false;
            else
                TextSetColor(agent_pageCostumesBoat_skin2, rolloverColor);
                string_currentRolloverItem = "pageCostumeBoat_skin2";
            end
        else
            TextSetColor(agent_pageCostumesBoat_skin2, defaultColor);
        end

        --option 5 (boat skin 3)
        if (KTBM_TextUI_IsCursorOverTextAgent(agent_pageCostumesBoat_skin3)) then
            if (KTBM_UI_Input_Clicked == true) then
                TextSetColor(agent_pageCostumesBoat_skin3, pressedColor);
                PlayClickSound();

                KTBM_Costumes_Boat_ApplySkin3(KTBM_Cutscene_Menu_kScene);

                KTBM_UI_Input_Clicked = false;
            else
                TextSetColor(agent_pageCostumesBoat_skin3, rolloverColor);
                string_currentRolloverItem = "pageCostumeBoat_skin3";
            end
        else
            TextSetColor(agent_pageCostumesBoat_skin3, defaultColor);
        end

        --option 6 (boat skin 4)
        if (KTBM_TextUI_IsCursorOverTextAgent(agent_pageCostumesBoat_skin4)) then
            if (KTBM_UI_Input_Clicked == true) then
                TextSetColor(agent_pageCostumesBoat_skin4, pressedColor);
                PlayClickSound();

                KTBM_Costumes_Boat_ApplySkin4(KTBM_Cutscene_Menu_kScene);

                KTBM_UI_Input_Clicked = false;
            else
                TextSetColor(agent_pageCostumesBoat_skin4, rolloverColor);
                string_currentRolloverItem = "pageCostumeBoat_skin4";
            end
        else
            TextSetColor(agent_pageCostumesBoat_skin4, defaultColor);
        end

        --option 7 (boat skin 5)
        if (KTBM_TextUI_IsCursorOverTextAgent(agent_pageCostumesBoat_skin5)) then
            if (KTBM_UI_Input_Clicked == true) then
                TextSetColor(agent_pageCostumesBoat_skin5, pressedColor);
                PlayClickSound();

                KTBM_Costumes_Boat_ApplySkin5(KTBM_Cutscene_Menu_kScene);

                KTBM_UI_Input_Clicked = false;
            else
                TextSetColor(agent_pageCostumesBoat_skin5, rolloverColor);
                string_currentRolloverItem = "pageCostumeBoat_skin5";
            end
        else
            TextSetColor(agent_pageCostumesBoat_skin5, defaultColor);
        end

    end

    --||||||||||||||||||||||||||||| OPTIONS MENU |||||||||||||||||||||||||||||
    --||||||||||||||||||||||||||||| OPTIONS MENU |||||||||||||||||||||||||||||
    --||||||||||||||||||||||||||||| OPTIONS MENU |||||||||||||||||||||||||||||

    if(bool_onOptionsPage) then

        --option 1 (go back)
        if (KTBM_TextUI_IsCursorOverTextAgent(agent_pageOptions_goBack)) then
            if (KTBM_UI_Input_Clicked == true) then
                TextSetColor(agent_pageOptions_goBack, pressedColor);
                PlayClickSound();
            
                string_currentPage = "main";

                KTBM_UI_Input_Clicked = false;
            else
                TextSetColor(agent_pageOptions_goBack, rolloverColor);
                string_currentRolloverItem = "pageOptions_goBack";
            end
        else
            TextSetColor(agent_pageOptions_goBack, defaultColor);
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
                PlayClickSound();
            
                string_currentPage = "main";

                KTBM_UI_Input_Clicked = false;
            else
                TextSetColor(agent_pageHelp_goBack, rolloverColor);
                string_currentRolloverItem = "pageHelp_goBack";
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
                PlayClickSound();
            
                string_currentPage = "main";

                KTBM_UI_Input_Clicked = false;
            else
                TextSetColor(agent_pageCredits_goBack, rolloverColor);
                string_currentRolloverItem = "pageCredits_goBack";
            end
        else
            TextSetColor(agent_pageCredits_goBack, defaultColor);
        end

    end

    --||||||||||||||||||||||||||||| SCOREBOARD MENU |||||||||||||||||||||||||||||
    --||||||||||||||||||||||||||||| SCOREBOARD MENU |||||||||||||||||||||||||||||
    --||||||||||||||||||||||||||||| SCOREBOARD MENU |||||||||||||||||||||||||||||

    if(bool_onScoreboardPage) then

        if(gameResultsDataArray == nil) then
            number_gameResultsIndex = 0;

            TextSet(agent_pageScoreboard_pageNumber, "(0/0)");
            TextSet(agent_pageScoreboard_item1, "");
            TextSet(agent_pageScoreboard_item2, "");
            TextSet(agent_pageScoreboard_item3, "");
        else
            --number_gameResultsIndex = KTBM_Clamp(number_gameResultsIndex, 1, #gameResultsDataArray - 1);
            number_gameResultsIndex = KTBM_Clamp(number_gameResultsIndex, 1, #gameResultsDataArray);
            number_gameResultsPageIndex = KTBM_Clamp(number_gameResultsPageIndex, 1, number_gameResultsPages);
            
            local string_pageNumberText = "(" .. tostring(number_gameResultsPageIndex) .. "/" .. tostring(number_gameResultsPages) .. ")";

            local gameResultsObject_selectedObject1 = gameResultsDataArray[number_gameResultsIndex];
            local gameResultsObject_selectedObject2 = gameResultsDataArray[number_gameResultsIndex + 1];
            local gameResultsObject_selectedObject3 = gameResultsDataArray[number_gameResultsIndex + 2];

            local string_scoreboardItemText1 = "";
            local string_scoreboardItemText2 = "";
            local string_scoreboardItemText3 = "";

            local string_fileNameForBestDistance = KTBM_Data_GameResultsObject_GetFileName(gameResultsObject_mostDistance);
            local string_fileNameForBestKills = KTBM_Data_GameResultsObject_GetFileName(gameResultsObject_mostKills);

            if(gameResultsObject_selectedObject1 ~= nil) then
                local string_fileNameForSelectedObject1 = KTBM_Data_GameResultsObject_GetFileName(gameResultsObject_selectedObject1);
                local bool_case1 = string_fileNameForSelectedObject1 == string_fileNameForBestDistance;
                local bool_case2 = string_fileNameForSelectedObject1 == string_fileNameForBestKills;

                if(bool_case1 and bool_case2) then
                    string_scoreboardItemText1 = string_scoreboardItemText1 .. "[BEST RUN]";
                    string_scoreboardItemText1 = string_scoreboardItemText1 .. "\n"; --new line
                    TextSetColor(agent_pageScoreboard_item1, bestRunColor);
                elseif(bool_case1 and not bool_case2) then
                    string_scoreboardItemText1 = string_scoreboardItemText1 .. "[BEST DISTANCE]";
                    string_scoreboardItemText1 = string_scoreboardItemText1 .. "\n"; --new line
                    TextSetColor(agent_pageScoreboard_item1, bestDistanceColor);
                elseif(not bool_case1 and bool_case2) then
                    string_scoreboardItemText1 = string_scoreboardItemText1 .. "[MOST KILLS]";
                    string_scoreboardItemText1 = string_scoreboardItemText1 .. "\n"; --new line
                    TextSetColor(agent_pageScoreboard_item1, mostKillsColor);
                else
                    TextSetColor(agent_pageScoreboard_item1, defaultColor);
                end

                string_scoreboardItemText1 = string_scoreboardItemText1 .. KTBM_Data_GameResultsObjectToString(gameResultsObject_selectedObject1);
                string_scoreboardItemText1 = string_scoreboardItemText1 .. "\n"; --new line
            end

            if(gameResultsObject_selectedObject2 ~= nil) then
                local string_fileNameForSelectedObject2 = KTBM_Data_GameResultsObject_GetFileName(gameResultsObject_selectedObject2);
                local bool_case1 = string_fileNameForSelectedObject2 == string_fileNameForBestDistance;
                local bool_case2 = string_fileNameForSelectedObject2 == string_fileNameForBestKills;

                if(bool_case1 and bool_case2) then
                    string_scoreboardItemText2 = string_scoreboardItemText2 .. "[BEST RUN]";
                    string_scoreboardItemText2 = string_scoreboardItemText2 .. "\n"; --new line
                    TextSetColor(agent_pageScoreboard_item2, bestRunColor);
                elseif(bool_case1 and not bool_case2) then
                    string_scoreboardItemText2 = string_scoreboardItemText2 .. "[BEST DISTANCE]";
                    string_scoreboardItemText2 = string_scoreboardItemText2 .. "\n"; --new line
                    TextSetColor(agent_pageScoreboard_item2, bestDistanceColor);
                elseif(not bool_case1 and bool_case2) then
                    string_scoreboardItemText2 = string_scoreboardItemText2 .. "[MOST KILLS]";
                    string_scoreboardItemText2 = string_scoreboardItemText2 .. "\n"; --new line
                    TextSetColor(agent_pageScoreboard_item2, mostKillsColor);
                else
                    TextSetColor(agent_pageScoreboard_item2, defaultColor);
                end

                string_scoreboardItemText2 = string_scoreboardItemText2 .. KTBM_Data_GameResultsObjectToString(gameResultsObject_selectedObject2);
                string_scoreboardItemText2 = string_scoreboardItemText2 .. "\n"; --new line
            end

            if(gameResultsObject_selectedObject3 ~= nil) then
                local string_fileNameForSelectedObject3 = KTBM_Data_GameResultsObject_GetFileName(gameResultsObject_selectedObject3);
                local bool_case1 = string_fileNameForSelectedObject3 == string_fileNameForBestDistance;
                local bool_case2 = string_fileNameForSelectedObject3 == string_fileNameForBestKills;

                if(bool_case1 and bool_case2) then
                    string_scoreboardItemText3 = string_scoreboardItemText3 .. "[BEST RUN]";
                    string_scoreboardItemText3 = string_scoreboardItemText3 .. "\n"; --new line
                    TextSetColor(agent_pageScoreboard_item3, bestRunColor);
                elseif(bool_case1 and not bool_case2) then
                    string_scoreboardItemText3 = string_scoreboardItemText3 .. "[BEST DISTANCE]";
                    string_scoreboardItemText3 = string_scoreboardItemText3 .. "\n"; --new line
                    TextSetColor(agent_pageScoreboard_item3, bestDistanceColor);
                elseif(not bool_case1 and bool_case2) then
                    string_scoreboardItemText3 = string_scoreboardItemText3 .. "[MOST KILLS]";
                    string_scoreboardItemText3 = string_scoreboardItemText3 .. "\n"; --new line
                    TextSetColor(agent_pageScoreboard_item3, mostKillsColor);
                else
                    TextSetColor(agent_pageScoreboard_item3, defaultColor);
                end

                string_scoreboardItemText3 = string_scoreboardItemText3 .. KTBM_Data_GameResultsObjectToString(gameResultsObject_selectedObject3);
                string_scoreboardItemText3 = string_scoreboardItemText3 .. "\n"; --new line
            end

            TextSet(agent_pageScoreboard_pageNumber, string_pageNumberText);
            TextSet(agent_pageScoreboard_item1, string_scoreboardItemText1);
            TextSet(agent_pageScoreboard_item2, string_scoreboardItemText2);
            TextSet(agent_pageScoreboard_item3, string_scoreboardItemText3);
        end

        --option 1 (go back)
        if (KTBM_TextUI_IsCursorOverTextAgent(agent_pageScoreboard_goBack)) then
            if (KTBM_UI_Input_Clicked == true) then
                TextSetColor(agent_pageScoreboard_goBack, pressedColor);
                PlayClickSound();
            
                string_currentPage = "main";

                KTBM_UI_Input_Clicked = false;
            else
                TextSetColor(agent_pageScoreboard_goBack, rolloverColor);
                string_currentRolloverItem = "pageScoreboard_goBack";
            end
        else
            TextSetColor(agent_pageScoreboard_goBack, defaultColor);
        end

        --(previous)
        if (KTBM_TextUI_IsCursorOverTextAgent(agent_pageScoreboard_leftArrow)) then
            if (KTBM_UI_Input_Clicked == true) then
                TextSetColor(agent_pageScoreboard_leftArrow, pressedColor);
                PlayClickSound();

                number_gameResultsIndex = number_gameResultsIndex - 3;
                number_gameResultsPageIndex = number_gameResultsPageIndex - 1;

                KTBM_UI_Input_Clicked = false;
            else
                TextSetColor(agent_pageScoreboard_leftArrow, rolloverColor);
                string_currentRolloverItem = "pageScoreboard_previous";
            end
        else
            TextSetColor(agent_pageScoreboard_leftArrow, defaultColor);
        end

        --(next)
        if (KTBM_TextUI_IsCursorOverTextAgent(agent_pageScoreboard_rightArrow)) then
            if (KTBM_UI_Input_Clicked == true) then
                TextSetColor(agent_pageScoreboard_rightArrow, pressedColor);
                PlayClickSound();

                number_gameResultsIndex = number_gameResultsIndex + 3;
                number_gameResultsPageIndex = number_gameResultsPageIndex + 1;

                KTBM_UI_Input_Clicked = false;
            else
                TextSetColor(agent_pageScoreboard_rightArrow, rolloverColor);
                string_currentRolloverItem = "pageScoreboard_next";
            end
        else
            TextSetColor(agent_pageScoreboard_rightArrow, defaultColor);
        end

    end
end