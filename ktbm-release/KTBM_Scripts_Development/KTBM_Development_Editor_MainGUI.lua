local string_texture_editorColor = "KTBM_Development_EditorGUIGrey.d3dtx";

local string_texture_iconTransformHand = "KTBM_Texture_IconTransformHand.d3dtx";
local string_texture_iconTransformHandHover = "KTBM_Texture_IconTransformHandHover.d3dtx";
local string_texture_iconTransformHandSelect = "KTBM_Texture_IconTransformHandSelect.d3dtx";

local string_texture_iconTransformMove = "KTBM_Texture_IconTransformMove.d3dtx";
local string_texture_iconTransformMoveHover = "KTBM_Texture_IconTransformMoveHover.d3dtx";
local string_texture_iconTransformMoveSelect = "KTBM_Texture_IconTransformMoveSelect.d3dtx";

local string_texture_iconTransformRotate = "KTBM_Texture_IconTransformRotate.d3dtx";
local string_texture_iconTransformRotateHover = "KTBM_Texture_IconTransformRotateHover.d3dtx";
local string_texture_iconTransformRotateSelect = "KTBM_Texture_IconTransformRotateSelect.d3dtx";

local string_texture_iconTransformScale = "KTBM_Texture_IconTransformScale.d3dtx";
local string_texture_iconTransformScaleHover = "KTBM_Texture_IconTransformScaleHover.d3dtx";
local string_texture_iconTransformScaleSelect = "KTBM_Texture_IconTransformScaleSelect.d3dtx";

--color_fFFFFF

local agent_guiGroup = nil;
local agent_bg_transformTools = nil;
local agent_bg_rightSide = nil;
local agent_bg_inspectorArea = nil;
local agent_bg_hierarchyArea = nil;
local agent_icon_transformHand = nil;
local agent_icon_transformMove = nil;
local agent_icon_transformRotate = nil;
local agent_icon_transformScale = nil;
local agent_text_inspectorMain = nil;

local agent_text_hierarchyTitle = nil;
local agent_text_hierarchyItemCount = 30;
local agent_text_hierarchyItems = {};
local agent_text_agent_text_hierarchyItemPageIndex = 0;

local agentTable_sceneAgents = {};

KTBM_Development_MainGUI_CursorOverGUI = false;
KTBM_Development_MainGUI_AgentsTable = {};

KTBM_Development_MainGUI_Initalize = function()
    agent_icon_transformHand = AgentCreate("agent_icon_transformHand", "ui_boot_title.prop", Vector(0, 0, 0), Vector(0, 0, 0), KTBM_Development_SceneObject, false, false);
    agent_icon_transformMove = AgentCreate("agent_icon_transformMove", "ui_boot_title.prop", Vector(0, 0, 0), Vector(0, 0, 0), KTBM_Development_SceneObject, false, false);
    agent_icon_transformRotate = AgentCreate("agent_icon_transformRotate", "ui_boot_title.prop", Vector(0, 0, 0), Vector(0, 0, 0), KTBM_Development_SceneObject, false, false);
    agent_icon_transformScale = AgentCreate("agent_icon_transformScale", "ui_boot_title.prop", Vector(0, 0, 0), Vector(0, 0, 0), KTBM_Development_SceneObject, false, false);
    agent_bg_transformTools = AgentCreate("agent_bg_transformTools", "ui_boot_title.prop", Vector(0, 0, 0), Vector(0, 0, 0), KTBM_Development_SceneObject, false, false);
    agent_bg_rightSide = AgentCreate("agent_bg_rightSide", "ui_boot_title.prop", Vector(0, 0, 0), Vector(0, 0, 0), KTBM_Development_SceneObject, false, false);
    agent_bg_inspectorArea = AgentCreate("agent_bg_inspectorArea", "ui_boot_title.prop", Vector(0, 0, 0), Vector(0, 0, 0), KTBM_Development_SceneObject, false, false);
    agent_bg_hierarchyArea = AgentCreate("agent_bg_hierarchyArea", "ui_boot_title.prop", Vector(0, 0, 0), Vector(0, 0, 0), KTBM_Development_SceneObject, false, false);

    agent_text_inspectorMain = KTBM_TextUI_CreateTextAgent("agent_text_inspectorMain", "[INSPECTOR]", Vector(0, 0, 0), 0, 0);
    TextSetColor(agent_text_inspectorMain, Color(1.0, 1.0, 1.0, 1.0));
    TextSetScale(agent_text_inspectorMain, 0.4);

    agent_text_hierarchyTitle = KTBM_TextUI_CreateTextAgent("agent_text_hierarchyTitle", "[SCENE HIERARCHY]", Vector(0, 0, 0), 0, 0);
    TextSetColor(agent_text_hierarchyTitle, Color(1.0, 1.0, 1.0, 1.0));
    TextSetScale(agent_text_hierarchyTitle, 0.4);

    for index1 = 1, agent_text_hierarchyItemCount do
        local string_hierarchyItemName = "agent_text_hierarchyItem" .. tostring(index1);
        local string_hierarchyItemContent = "Item" .. tostring(index1);
        local agent_text_hierarchyItem = KTBM_TextUI_CreateTextAgent(string_hierarchyItemName, string_hierarchyItemContent, Vector(0, 0, 0), 0, 0);

        TextSetColor(agent_text_hierarchyItem, Color(0.75, 0.75, 0.75, 1.0));
        TextSetScale(agent_text_hierarchyItem, 0.4);

        table.insert(agent_text_hierarchyItems, agent_text_hierarchyItem);
    end

    table.insert(KTBM_Development_MainGUI_AgentsTable, agent_icon_transformHand);
    table.insert(KTBM_Development_MainGUI_AgentsTable, agent_icon_transformMove);
    table.insert(KTBM_Development_MainGUI_AgentsTable, agent_icon_transformRotate);
    table.insert(KTBM_Development_MainGUI_AgentsTable, agent_icon_transformScale);
    table.insert(KTBM_Development_MainGUI_AgentsTable, agent_bg_transformTools);
    table.insert(KTBM_Development_MainGUI_AgentsTable, agent_bg_rightSide);
    table.insert(KTBM_Development_MainGUI_AgentsTable, agent_bg_inspectorArea);
    table.insert(KTBM_Development_MainGUI_AgentsTable, agent_bg_hierarchyArea);

    ShaderSwapTexture(agent_icon_transformHand, "ui_boot_title.d3dtx", string_texture_iconTransformHand);
    ShaderSwapTexture(agent_icon_transformMove, "ui_boot_title.d3dtx", string_texture_iconTransformMove);
    ShaderSwapTexture(agent_icon_transformRotate, "ui_boot_title.d3dtx", string_texture_iconTransformRotate);
    ShaderSwapTexture(agent_icon_transformScale, "ui_boot_title.d3dtx", string_texture_iconTransformScale);

    ShaderSwapTexture(agent_bg_transformTools, "ui_boot_title.d3dtx", string_texture_editorColor);
    --ShaderSwapTexture(agent_bg_rightSide, "ui_boot_title.d3dtx", "color_fFFFFF.d3dtx");
    ShaderSwapTexture(agent_bg_rightSide, "ui_boot_title.d3dtx", "color_000.d3dtx");
    ShaderSwapTexture(agent_bg_inspectorArea, "ui_boot_title.d3dtx", string_texture_editorColor);
    ShaderSwapTexture(agent_bg_hierarchyArea, "ui_boot_title.d3dtx", string_texture_editorColor);

    local number_iconButtonSize = 0.01;

    KTBM_PropertySet(agent_icon_transformHand, "Render Axis Scale", Vector(-1, 1, 1));
    KTBM_PropertySet(agent_icon_transformHand, "Render Global Scale", number_iconButtonSize);
    KTBM_PropertySet(agent_icon_transformHand, "Render After Anti-Aliasing", true);
    KTBM_PropertySet(agent_icon_transformHand, "Render Depth Test", false);
    KTBM_PropertySet(agent_icon_transformHand, "Render Depth Write", false);
    KTBM_PropertySet(agent_icon_transformHand, "Render Depth Write Alpha", false);
    KTBM_PropertySet(agent_icon_transformHand, "Render Layer", 95);

    KTBM_PropertySet(agent_icon_transformMove, "Render Axis Scale", Vector(-1, 1, 1));
    KTBM_PropertySet(agent_icon_transformMove, "Render Global Scale", number_iconButtonSize);
    KTBM_PropertySet(agent_icon_transformMove, "Render After Anti-Aliasing", true);
    KTBM_PropertySet(agent_icon_transformMove, "Render Depth Test", false);
    KTBM_PropertySet(agent_icon_transformMove, "Render Depth Write", false);
    KTBM_PropertySet(agent_icon_transformMove, "Render Depth Write Alpha", false);
    KTBM_PropertySet(agent_icon_transformMove, "Render Layer", 95);

    KTBM_PropertySet(agent_icon_transformRotate, "Render Axis Scale", Vector(-1, 1, 1));
    KTBM_PropertySet(agent_icon_transformRotate, "Render Global Scale", number_iconButtonSize);
    KTBM_PropertySet(agent_icon_transformRotate, "Render After Anti-Aliasing", true);
    KTBM_PropertySet(agent_icon_transformRotate, "Render Depth Test", false);
    KTBM_PropertySet(agent_icon_transformRotate, "Render Depth Write", false);
    KTBM_PropertySet(agent_icon_transformRotate, "Render Depth Write Alpha", false);
    KTBM_PropertySet(agent_icon_transformRotate, "Render Layer", 95);

    KTBM_PropertySet(agent_icon_transformScale, "Render Axis Scale", Vector(-1, 1, 1));
    KTBM_PropertySet(agent_icon_transformScale, "Render Global Scale", number_iconButtonSize);
    KTBM_PropertySet(agent_icon_transformScale, "Render After Anti-Aliasing", true);
    KTBM_PropertySet(agent_icon_transformScale, "Render Depth Test", false);
    KTBM_PropertySet(agent_icon_transformScale, "Render Depth Write", false);
    KTBM_PropertySet(agent_icon_transformScale, "Render Depth Write Alpha", false);
    KTBM_PropertySet(agent_icon_transformScale, "Render Layer", 95);

    KTBM_PropertySet(agent_bg_transformTools, "Render Axis Scale", Vector(0.06, 0.015, 1));
    KTBM_PropertySet(agent_bg_transformTools, "Render After Anti-Aliasing", true);
    KTBM_PropertySet(agent_bg_transformTools, "Render Depth Test", false);
    KTBM_PropertySet(agent_bg_transformTools, "Render Depth Write", false);
    KTBM_PropertySet(agent_bg_transformTools, "Render Depth Write Alpha", false);
    KTBM_PropertySet(agent_bg_transformTools, "Render Layer", 94);

    KTBM_PropertySet(agent_bg_rightSide, "Render Axis Scale", Vector(0.1, 0.5, 1));
    KTBM_PropertySet(agent_bg_rightSide, "Render After Anti-Aliasing", true);
    KTBM_PropertySet(agent_bg_rightSide, "Render Depth Test", false);
    KTBM_PropertySet(agent_bg_rightSide, "Render Depth Write", false);
    KTBM_PropertySet(agent_bg_rightSide, "Render Depth Write Alpha", false);
    KTBM_PropertySet(agent_bg_rightSide, "Render Layer", 93);

    KTBM_PropertySet(agent_bg_inspectorArea, "Render Axis Scale", Vector(0.1, 0.081, 1));
    KTBM_PropertySet(agent_bg_inspectorArea, "Render After Anti-Aliasing", true);
    KTBM_PropertySet(agent_bg_inspectorArea, "Render Depth Test", false);
    KTBM_PropertySet(agent_bg_inspectorArea, "Render Depth Write", false);
    KTBM_PropertySet(agent_bg_inspectorArea, "Render Depth Write Alpha", false);
    KTBM_PropertySet(agent_bg_inspectorArea, "Render Layer", 94);

    KTBM_PropertySet(agent_bg_hierarchyArea, "Render Axis Scale", Vector(0.1, 0.081, 1));
    KTBM_PropertySet(agent_bg_hierarchyArea, "Render After Anti-Aliasing", true);
    KTBM_PropertySet(agent_bg_hierarchyArea, "Render Depth Test", false);
    KTBM_PropertySet(agent_bg_hierarchyArea, "Render Depth Write", false);
    KTBM_PropertySet(agent_bg_hierarchyArea, "Render Depth Write Alpha", false);
    KTBM_PropertySet(agent_bg_hierarchyArea, "Render Layer", 94);
end

KTBM_Development_MainGUI_Update = function()  
    local agent_sceneCamera = SceneGetCamera(KTBM_Development_SceneObject);
    local vector_sceneCameraPosition = AgentGetWorldPos(agent_sceneCamera);
    local vector_sceneCameraRotation = AgentGetWorldRot(agent_sceneCamera);
    local vector_sceneCameraForward = AgentGetForwardVec(agent_sceneCamera);

    local number_buttonVerticalSize = 0.04;
    local number_buttonHorizontalSize = 0.04 / RenderGetAspectRatio();
    local vector_buttonExtentsMin = Vector(-number_buttonHorizontalSize, -number_buttonVerticalSize, 1);
    local vector_buttonExtentsMax = Vector(number_buttonHorizontalSize, number_buttonVerticalSize, 1);

    local bool_isOverTransformHand = KTBM_TextUI_IsCursorOverBounds(AgentGetScreenPos(agent_icon_transformHand), vector_buttonExtentsMin, vector_buttonExtentsMax);
    local bool_isOverTransformMove = KTBM_TextUI_IsCursorOverBounds(AgentGetScreenPos(agent_icon_transformMove), vector_buttonExtentsMin, vector_buttonExtentsMax);
    local bool_isOverTransformRotate = KTBM_TextUI_IsCursorOverBounds(AgentGetScreenPos(agent_icon_transformRotate), vector_buttonExtentsMin, vector_buttonExtentsMax);
    local bool_isOverTransformScale = KTBM_TextUI_IsCursorOverBounds(AgentGetScreenPos(agent_icon_transformScale), vector_buttonExtentsMin, vector_buttonExtentsMax);
    local bool_isOverRightSideGUI = KTBM_TextUI_IsCursorOverBounds(Vector(1, 0, 0), Vector(-0.6 / RenderGetAspectRatio(), -2, 0), Vector(0.6 / RenderGetAspectRatio(), 2, 0));

    --screen pos notes
    --0.0 0.0 0.0 = top left
    --0.5 0.5 0.0 = center
    --0.0 1.0 0.0 = bottom left
    local bool_isOverTransformToolbar = KTBM_TextUI_IsCursorOverBounds(Vector(0, 1, 0), Vector(-0.2, -0.2, 0), Vector(0.2, 0.2, 0));
    KTBM_Development_MainGUI_CursorOverGUI = bool_isOverTransformToolbar or bool_isOverRightSideGUI;

    if(bool_isOverTransformHand) and (KTBM_Development_Editor_Input_LeftMouseClicked) then
        KTBM_Development_TransformTool_GizmoMode = "hand";
    end

    if(bool_isOverTransformMove) and (KTBM_Development_Editor_Input_LeftMouseClicked) then
        KTBM_Development_TransformTool_GizmoMode = "position";
    end

    if(bool_isOverTransformRotate) and (KTBM_Development_Editor_Input_LeftMouseClicked) then
        KTBM_Development_TransformTool_GizmoMode = "rotation";
    end

    if(bool_isOverTransformScale) and (KTBM_Development_Editor_Input_LeftMouseClicked) then
        KTBM_Development_TransformTool_GizmoMode = "scale";
    end

    --------------------------------
    if(KTBM_Development_TransformTool_GizmoMode == "hand") then
        ShaderSwapTexture(agent_icon_transformHand, "ui_boot_title.d3dtx", string_texture_iconTransformHandSelect);
    else
        if(bool_isOverTransformHand) then
            ShaderSwapTexture(agent_icon_transformHand, "ui_boot_title.d3dtx", string_texture_iconTransformHandHover);
        else
            ShaderSwapTexture(agent_icon_transformHand, "ui_boot_title.d3dtx", string_texture_iconTransformHand);
        end
    end

    if(KTBM_Development_TransformTool_GizmoMode == "position") then
        ShaderSwapTexture(agent_icon_transformMove, "ui_boot_title.d3dtx", string_texture_iconTransformMoveSelect);
    else
        if(bool_isOverTransformMove) then
            ShaderSwapTexture(agent_icon_transformMove, "ui_boot_title.d3dtx", string_texture_iconTransformMoveHover);
        else
            ShaderSwapTexture(agent_icon_transformMove, "ui_boot_title.d3dtx", string_texture_iconTransformMove);
        end
    end

    if(KTBM_Development_TransformTool_GizmoMode == "rotation") then
        ShaderSwapTexture(agent_icon_transformRotate, "ui_boot_title.d3dtx", string_texture_iconTransformRotateSelect);
    else
        if(bool_isOverTransformRotate) then
            ShaderSwapTexture(agent_icon_transformRotate, "ui_boot_title.d3dtx", string_texture_iconTransformRotateHover);
        else
            ShaderSwapTexture(agent_icon_transformRotate, "ui_boot_title.d3dtx", string_texture_iconTransformRotate);
        end
    end

    if(KTBM_Development_TransformTool_GizmoMode == "scale") then
        ShaderSwapTexture(agent_icon_transformScale, "ui_boot_title.d3dtx", string_texture_iconTransformScaleSelect);
    else
        if(bool_isOverTransformScale) then
            ShaderSwapTexture(agent_icon_transformScale, "ui_boot_title.d3dtx", string_texture_iconTransformScaleHover);
        else
            ShaderSwapTexture(agent_icon_transformScale, "ui_boot_title.d3dtx", string_texture_iconTransformScale);
        end
    end

    --screen pos notes
    --0.0 0.0 0.0 = top left
    --0.5 0.5 0.0 = center
    --0.0 1.0 0.0 = bottom left
    AgentSetWorldPos(agent_icon_transformHand, VectorAdd(vector_sceneCameraForward, CameraGetWorldPosFromLogicalScreenPos(agent_sceneCamera, Vector(-9.333, 10, 0))));
    AgentSetWorldPos(agent_icon_transformMove, VectorAdd(vector_sceneCameraForward, CameraGetWorldPosFromLogicalScreenPos(agent_sceneCamera, Vector(-8.333, 10, 0))));
    AgentSetWorldPos(agent_icon_transformRotate, VectorAdd(vector_sceneCameraForward, CameraGetWorldPosFromLogicalScreenPos(agent_sceneCamera, Vector(-7.333, 10, 0))));
    AgentSetWorldPos(agent_icon_transformScale, VectorAdd(vector_sceneCameraForward, CameraGetWorldPosFromLogicalScreenPos(agent_sceneCamera, Vector(-6.333, 10, 0))));
    
    AgentSetWorldPos(agent_bg_transformTools, VectorAdd(vector_sceneCameraForward, CameraGetWorldPosFromLogicalScreenPos(agent_sceneCamera, Vector(-8, 10, 0))));
    AgentSetWorldPos(agent_bg_rightSide, VectorAdd(vector_sceneCameraForward, CameraGetWorldPosFromLogicalScreenPos(agent_sceneCamera, Vector(8, 0, 0))));
    AgentSetWorldPos(agent_bg_hierarchyArea, VectorAdd(vector_sceneCameraForward, CameraGetWorldPosFromLogicalScreenPos(agent_sceneCamera, Vector(8.05, -5.25, 0))));
    AgentSetWorldPos(agent_bg_inspectorArea, VectorAdd(vector_sceneCameraForward, CameraGetWorldPosFromLogicalScreenPos(agent_sceneCamera, Vector(8.05, 5.75, 0))));

    AgentSetWorldRot(agent_icon_transformHand, vector_sceneCameraRotation);
    AgentSetWorldRot(agent_icon_transformMove, vector_sceneCameraRotation);
    AgentSetWorldRot(agent_icon_transformRotate, vector_sceneCameraRotation);
    AgentSetWorldRot(agent_icon_transformScale, vector_sceneCameraRotation);

    AgentSetWorldRot(agent_bg_transformTools, vector_sceneCameraRotation);
    AgentSetWorldRot(agent_bg_rightSide, vector_sceneCameraRotation);
    AgentSetWorldRot(agent_bg_inspectorArea, vector_sceneCameraRotation);
    AgentSetWorldRot(agent_bg_hierarchyArea, vector_sceneCameraRotation);










    local string_inspectorMainText = "";

    string_inspectorMainText = string_inspectorMainText .. "[INSPECTOR]";
    string_inspectorMainText = string_inspectorMainText .. "\n"; --new line

    if(agent_currentSelectedAgent ~= nil) then
        string_inspectorMainText = string_inspectorMainText .. "Name: " .. AgentGetName(agent_currentSelectedAgent);
        string_inspectorMainText = string_inspectorMainText .. "\n"; --new line

        string_inspectorMainText = string_inspectorMainText .. "Position: " .. KTBM_VectorToString(AgentGetPos(agent_currentSelectedAgent));
        string_inspectorMainText = string_inspectorMainText .. "\n"; --new line

        string_inspectorMainText = string_inspectorMainText .. "Rotation: " .. KTBM_VectorToString(AgentGetRot(agent_currentSelectedAgent));
        string_inspectorMainText = string_inspectorMainText .. "\n"; --new line

        string_inspectorMainText = string_inspectorMainText .. "World Position: " .. KTBM_VectorToString(AgentGetWorldPos(agent_currentSelectedAgent));
        string_inspectorMainText = string_inspectorMainText .. "\n"; --new line

        string_inspectorMainText = string_inspectorMainText .. "World Rotation: " .. KTBM_VectorToString(AgentGetWorldRot(agent_currentSelectedAgent));
        string_inspectorMainText = string_inspectorMainText .. "\n"; --new line
    end

    TextSet(agent_text_inspectorMain, string_inspectorMainText);

    --screen pos notes
    --0.0 0.0 0.0 = top left
    --0.5 0.5 0.0 = center
    --0.0 1.0 0.0 = bottom left
    AgentSetWorldPosFromLogicalScreenPos(agent_text_inspectorMain, Vector(0.685, 0.5, 0.0));















    local string_hierarchyTitleText = "";

    string_hierarchyTitleText = string_hierarchyTitleText .. "[SCENE HIERARCHY]";
    string_hierarchyTitleText = string_hierarchyTitleText .. "\n"; --new line

    TextSet(agent_text_hierarchyTitle, string_hierarchyTitleText);

    --screen pos notes
    --0.0 0.0 0.0 = top left
    --0.5 0.5 0.0 = center
    --0.0 1.0 0.0 = bottom left
    AgentSetWorldPosFromLogicalScreenPos(agent_text_hierarchyTitle, Vector(0.685, 0.005, 0.0));

    local agentTable_sceneAgents = SceneGetAgents(KTBM_Development_SceneObject);

    for index1, agent_text_hierarchyItem in ipairs(agent_text_hierarchyItems) do
        local number_yOffset = index1 * 0.015;

        local agent_sceneAgent = nil;

        if(index1 < #agentTable_sceneAgents) then
            agent_sceneAgent = agentTable_sceneAgents[index1];
        end

        if(agent_sceneAgent == nil) then
            TextSet(agent_text_hierarchyItem, "");
        else
            TextSet(agent_text_hierarchyItem, AgentGetName(agent_sceneAgent));
        end

        AgentSetWorldPosFromLogicalScreenPos(agent_text_hierarchyItem, Vector(0.685, 0.006 + number_yOffset, 0.0));
    end
end