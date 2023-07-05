--[[

]]--

local agent_yesText = nil;
local agent_noText = nil;
local agent_dialogText = nil;
local agent_fullscreenGraphic = nil;
local agent_fullscreenBlackOverlay = nil;

KTBM_UI_YesNoDialogBox_IsOpen = false;
KTBM_UI_YesNoDialogBox_Response = nil;
KTBM_UI_YesNoDialogBox_CurrentDialog = "";

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
    controller_sound_uiClick = SoundPlay("ui_click_4.wav");

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

KTBM_UI_YesNoDialogBox_Start = function(number_globalScale)
    --create our main menu text
    agent_yesText = KTBM_TextUI_CreateTextAgent("agent_yesText", "Yes", Vector(0, 0, 0), 2, 0);
    agent_noText = KTBM_TextUI_CreateTextAgent("agent_noText", "No", Vector(0, 0, 0), 2, 0);
    agent_dialogText = KTBM_TextUI_CreateTextAgent("agent_dialogText", "Yes No Dialog", Vector(0, 0, 0), 2, 0);

    agent_fullscreenGraphic = AgentCreate("agent_fullscreenGraphic", "ui_boot_title.prop", Vector(0, 1, 0), Vector(0, 0, 0), KTBM_Gameplay_kScene, false, false);
    KTBM_PropertySet(agent_fullscreenGraphic, "Render Axis Scale", Vector(1.777777778, 1.0, 1.0));
    KTBM_PropertySet(agent_fullscreenGraphic, "Render Global Scale", number_globalScale);
    KTBM_PropertySet(agent_fullscreenGraphic, "Render After Anti-Aliasing", true);
    KTBM_PropertySet(agent_fullscreenGraphic, "Render Depth Test", false);
    KTBM_PropertySet(agent_fullscreenGraphic, "Render Depth Write", false);
    KTBM_PropertySet(agent_fullscreenGraphic, "Render Depth Write Alpha", false);
    KTBM_PropertySet(agent_fullscreenGraphic, "Render Layer", 50);
    ShaderSwapTexture(agent_fullscreenGraphic, "ui_boot_title.d3dtx", "KTBM_Texture_YesNoDefault.d3dtx");

    agent_fullscreenBlackOverlay = AgentCreate("agent_fullscreenBlackOverlay", "ui_boot_title.prop", Vector(0, 1, 0), Vector(0, 0, 0), KTBM_Gameplay_kScene, false, false);
    KTBM_PropertySet(agent_fullscreenBlackOverlay, "Render Axis Scale", Vector(1.0, 1.0, 1.0));
    KTBM_PropertySet(agent_fullscreenBlackOverlay, "Render Global Scale", 5.0);
    KTBM_PropertySet(agent_fullscreenBlackOverlay, "Render After Anti-Aliasing", true);
    KTBM_PropertySet(agent_fullscreenBlackOverlay, "Render Depth Test", false);
    KTBM_PropertySet(agent_fullscreenBlackOverlay, "Render Depth Write", false);
    KTBM_PropertySet(agent_fullscreenBlackOverlay, "Render Depth Write Alpha", false);
    KTBM_PropertySet(agent_fullscreenBlackOverlay, "Render Layer", 45);
    ShaderSwapTexture(agent_fullscreenBlackOverlay, "ui_boot_title.d3dtx", "KTBM_Texture_BlackOverlay25.d3dtx");

    --scale note
    --1.0 = default
    --0.5 = half
    --2.0 = double
    TextSetScale(agent_yesText, 1.0);
    TextSetScale(agent_noText, 1.0);
    TextSetScale(agent_dialogText, 1.0);

    --color note
    --text colors are additive on the scene
    TextSetColor(agent_yesText, Color(1.0, 1.0, 1.0, 1.0));
    TextSetColor(agent_noText, Color(1.0, 1.0, 1.0, 1.0));
    TextSetColor(agent_dialogText, Color(1.0, 1.0, 1.0, 1.0));
end

KTBM_UI_YesNoDialogBox_Update = function()  
    PlayRolloverSound();

    KTBM_PropertySet(agent_yesText, "Runtime: Visible", KTBM_UI_YesNoDialogBox_IsOpen);
    KTBM_PropertySet(agent_noText, "Runtime: Visible", KTBM_UI_YesNoDialogBox_IsOpen);
    KTBM_PropertySet(agent_dialogText, "Runtime: Visible", KTBM_UI_YesNoDialogBox_IsOpen);
    KTBM_PropertySet(agent_fullscreenGraphic, "Runtime: Visible", KTBM_UI_YesNoDialogBox_IsOpen);
    KTBM_PropertySet(agent_fullscreenBlackOverlay, "Runtime: Visible", KTBM_UI_YesNoDialogBox_IsOpen);

    KTBM_SetExtents(agent_yesText, Vector(0, 0, 0), Vector(0, 0, 0));
    KTBM_SetExtents(agent_noText, Vector(0, 0, 0), Vector(0, 0, 0));

    --AgentGetScene
    --local vector_cameraRotation = AgentGetWorldRot(AgentGetCamera(agent_yesText));
    --local vector_cameraRotation = AgentGetWorldRot(SceneGetSceneCamera(KTBM_Gameplay_kScene));
    --local vector_cameraRotationText = AgentGetWorldRot(SceneGetSceneCamera(KTBM_Gameplay_kScene));
    local vector_cameraRotation = AgentGetWorldRot(SceneGetCamera(AgentGetScene(agent_fullscreenGraphic)));
    local vector_cameraRotationText = vector_cameraRotation;
    --local vector_cameraRotation = AgentGetWorldRot(SceneGetCamera(KTBM_Gameplay_kScene));
    --local vector_cameraRotation = AgentGetWorldRot(AgentFindInScene("myMenuCamera", KTBM_Gameplay_kScene));
    --vector_cameraRotation.x = -vector_cameraRotation.x;
    --vector_cameraRotation.x = vector_cameraRotation.x + 180;
    --vector_cameraRotation.y = vector_cameraRotation.y + 180;

    vector_cameraRotationText.x = -vector_cameraRotationText.x;
    vector_cameraRotationText.y = vector_cameraRotationText.y + 180;


    local defaultColor = Color(1.0, 1.0, 1.0, 1.0);
    local rolloverColor = Color(0.25, 0.25, 0.25, 1.0);
    local pressedColor = Color(0.1, 0.0, 0.0, 1.0);




    if (KTBM_TextUI_IsCursorOverTextAgent(agent_yesText)) then
    --if (KTBM_TextUI_IsCursorOverTextAgentFix(agent_yesText)) then
        if (KTBM_UI_Input_Clicked == true) then
            TextSetColor(agent_yesText, pressedColor);
            PlayClickSound();

            KTBM_UI_YesNoDialogBox_Response = true;

            KTBM_UI_Input_Clicked = false;
        else
            TextSetColor(agent_noText, defaultColor);
            TextSetColor(agent_yesText, rolloverColor);
            string_currentRolloverItem = "yesno_yes";

            ShaderSwapTexture(agent_fullscreenGraphic, "ui_boot_title.d3dtx", "KTBM_Texture_YesNoLeftRollover.d3dtx");
        end
    elseif (KTBM_TextUI_IsCursorOverTextAgent(agent_noText)) then
    --elseif (KTBM_TextUI_IsCursorOverTextAgentFix(agent_noText)) then
        if (KTBM_UI_Input_Clicked == true) then
            TextSetColor(agent_noText, pressedColor);
            PlayClickSound();

            KTBM_UI_YesNoDialogBox_Response = false;

            KTBM_UI_Input_Clicked = false;
        else
            TextSetColor(agent_yesText, defaultColor);
            TextSetColor(agent_noText, rolloverColor);
            string_currentRolloverItem = "yesno_no";

            ShaderSwapTexture(agent_fullscreenGraphic, "ui_boot_title.d3dtx", "KTBM_Texture_YesNoRightRollover.d3dtx");
        end
    else
        TextSetColor(agent_noText, defaultColor);
        TextSetColor(agent_yesText, defaultColor);

        ShaderSwapTexture(agent_fullscreenGraphic, "ui_boot_title.d3dtx", "KTBM_Texture_YesNoDefault.d3dtx");
    end




    --screen pos notes
    --0.0 0.0 0.0 = top left
    --0.5 0.5 0.0 = center
    --0.0 1.0 0.0 = bottom left
    AgentSetWorldPosFromLogicalScreenPos(agent_yesText, Vector(0.405, 0.675, 0));
    AgentSetWorldPosFromLogicalScreenPos(agent_noText, Vector(0.595, 0.675, 0));
    AgentSetWorldPosFromLogicalScreenPos(agent_dialogText, Vector(0.5, 0.4, 0));
    AgentSetWorldPosFromLogicalScreenPos(agent_fullscreenGraphic, Vector(0.5, 0.5, 0));
    AgentSetWorldPosFromLogicalScreenPos(agent_fullscreenBlackOverlay, Vector(0.5, 0.5, 0));

    AgentSetWorldRot(agent_yesText, vector_cameraRotationText);
    AgentSetWorldRot(agent_noText, vector_cameraRotationText);
    AgentSetWorldRot(agent_dialogText, vector_cameraRotationText);
    AgentSetWorldRot(agent_fullscreenGraphic, vector_cameraRotation);
    AgentSetWorldRot(agent_fullscreenBlackOverlay, vector_cameraRotation);
end

KTBM_UI_PopYesNoDialogBox = function(string_dialogText)
    KTBM_UI_YesNoDialogBox_IsOpen = true;

    KTBM_UI_YesNoDialogBox_CurrentDialog = string_dialogText;
    
    TextSet(agent_dialogText, string_dialogText);
end