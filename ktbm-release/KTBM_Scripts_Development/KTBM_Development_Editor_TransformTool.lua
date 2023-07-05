--[[
    AgentAtCursorPos() - Does not work. Always seems to return nil.
    CursorGetAgent() - Does not work. Always seems to return nil.
]]

agent_currentSelectedAgent = nil;
boundsAABB_currentSelectedAgentWorldBounds = nil;
boundsAABB_currentSelectedAgentLocalBounds = nil;

agent_currentHoverAgent = nil;
boundsAABB_currentHoverAgentWorldBounds = nil;
boundsAABB_currentHoverAgentLocalBounds = nil;

KTBM_Development_TransformTool_Text = nil;
KTBM_Development_TransformTool_GizmoSelectedAxis = "";
KTBM_Development_TransformTool_GizmoHoveringOverAxis = false;
KTBM_Development_TransformTool_GizmoMode = "position";
KTBM_Development_TransformTool_GizmoSpace = "world";
KTBM_Development_TransformTool_GizmoGroup = nil;
KTBM_Development_TransformTool_GizmoCenter = nil;
KTBM_Development_TransformTool_GizmoAgentX = nil;
KTBM_Development_TransformTool_GizmoAgentY = nil;
KTBM_Development_TransformTool_GizmoAgentZ = nil;
KTBM_Development_TransformTool_GizmoAgentSelect_Texture = nil;
KTBM_Development_TransformTool_GizmoAgentX_Texture = nil;
KTBM_Development_TransformTool_GizmoAgentY_Texture = nil;
KTBM_Development_TransformTool_GizmoAgentZ_Texture = nil;
KTBM_Development_TransformTool_GizmoAgentAxisDefaultBoundsMin = Vector(0, 0, 0);
KTBM_Development_TransformTool_GizmoAgentAxisDefaultBoundsMax = Vector(0, 0, 0);

KTBM_Development_TransformTool_SelectBoundingBoxGroup = nil;
KTBM_Development_TransformTool_SelectBoundingBoxSide1 = nil;
KTBM_Development_TransformTool_SelectBoundingBoxSide2 = nil;
KTBM_Development_TransformTool_SelectBoundingBoxSide3 = nil;
KTBM_Development_TransformTool_SelectBoundingBoxSide4 = nil;
KTBM_Development_TransformTool_SelectBoundingBoxSide5 = nil;
KTBM_Development_TransformTool_SelectBoundingBoxSide6 = nil;

KTBM_Development_TransformTool_HoverBoundingBoxGroup = nil;
KTBM_Development_TransformTool_HoverBoundingBoxSide1 = nil;
KTBM_Development_TransformTool_HoverBoundingBoxSide2 = nil;
KTBM_Development_TransformTool_HoverBoundingBoxSide3 = nil;
KTBM_Development_TransformTool_HoverBoundingBoxSide4 = nil;
KTBM_Development_TransformTool_HoverBoundingBoxSide5 = nil;
KTBM_Development_TransformTool_HoverBoundingBoxSide6 = nil;

KTBM_Development_TransformTool_DontSelect = {
    "KTBM_Development_TransformTool_GizmoGroup",
    "KTBM_Development_TransformTool_GizmoCenter",
    "KTBM_Development_TransformTool_GizmoAgentX",
    "KTBM_Development_TransformTool_GizmoAgentY",
    "KTBM_Development_TransformTool_GizmoAgentZ",
    "KTBM_Development_TransformTool_SelectBoundingBoxSide1",
    "KTBM_Development_TransformTool_SelectBoundingBoxSide2",
    "KTBM_Development_TransformTool_SelectBoundingBoxSide3",
    "KTBM_Development_TransformTool_SelectBoundingBoxSide4",
    "KTBM_Development_TransformTool_SelectBoundingBoxSide5",
    "KTBM_Development_TransformTool_SelectBoundingBoxSide6",
    "KTBM_Development_TransformTool_SelectBoundingBoxGroup",
    "KTBM_Development_TransformTool_HoverBoundingBoxSide1",
    "KTBM_Development_TransformTool_HoverBoundingBoxSide2",
    "KTBM_Development_TransformTool_HoverBoundingBoxSide3",
    "KTBM_Development_TransformTool_HoverBoundingBoxSide4",
    "KTBM_Development_TransformTool_HoverBoundingBoxSide5",
    "KTBM_Development_TransformTool_HoverBoundingBoxSide6",
    "KTBM_Development_TransformTool_HoverBoundingBoxGroup"
}

KTBM_Development_TransformTool_GizmoAgentNames = {
    "KTBM_Development_TransformTool_GizmoGroup",
    "KTBM_Development_TransformTool_GizmoCenter",
    "KTBM_Development_TransformTool_GizmoAgentX",
    "KTBM_Development_TransformTool_GizmoAgentY",
    "KTBM_Development_TransformTool_GizmoAgentZ"
}

local prevCursorPos = Vector(0, 0, 0);

KTBM_Development_TransformTool_UpdateGizmo = function()
    local agent_sceneCamera = SceneGetCamera(KTBM_Development_SceneObject);
    local vector_sceneCameraPosition = AgentGetWorldPos(agent_sceneCamera);
    local vector_sceneCameraRotation = AgentGetWorldRot(agent_sceneCamera);
    local vector_cursorPosition = CursorGetPos();

    AgentFacePos(KTBM_Development_TransformTool_GizmoCenter, vector_sceneCameraPosition);
    local vector_gizmoCenterRotation = AgentGetWorldRot(KTBM_Development_TransformTool_GizmoCenter);

    local bool_selectedAgent = agent_currentSelectedAgent ~= nil;
    local bool_hoveringAgent = agent_currentHoverAgent ~= nil;
    local bool_selectVisibility = false;
    local bool_hoverVisibility = false;
    local vector_selectObjectPosition = Vector(0, 0, 0);
    local vector_selectObjectRotation = Vector(0, 0, 0);
    local vector_hoverObjectPosition = Vector(0, 0, 0);
    local vector_hoverObjectRotation = Vector(0, 0, 0);
    local number_globalScale = 0.25;
    local number_distanceToSelection = VectorDistance(vector_selectObjectPosition, vector_sceneCameraPosition);

    if(bool_selectedAgent == true) then
        boundsAABB_currentSelectedAgentWorldBounds = KTBM_Bounds_GetAgentWorldBounds_AABB(agent_currentSelectedAgent);
        boundsAABB_currentSelectedAgentLocalBounds = KTBM_Bounds_GetAgentLocalBounds_AABB(agent_currentSelectedAgent);

        vector_selectObjectPosition = boundsAABB_currentSelectedAgentWorldBounds["center"];
        vector_selectObjectRotation = AgentGetWorldRot(agent_currentSelectedAgent);

        number_globalScale = number_distanceToSelection * 0.05;
        bool_selectVisibility = true;
    else
        boundsAABB_currentSelectedAgentWorldBounds = nil;
        boundsAABB_currentSelectedAgentLocalBounds = nil;
    end

    local bool_isMovingObject = bool_selectVisibility and KTBM_Development_Editor_Input_LeftMouseHold and not (KTBM_Development_TransformTool_GizmoSelectedAxis == "");

    if(bool_hoveringAgent == true) then
        boundsAABB_currentHoverAgentWorldBounds = KTBM_Bounds_GetAgentWorldBounds_AABB(agent_currentHoverAgent);
        boundsAABB_currentHoverAgentLocalBounds = KTBM_Bounds_GetAgentLocalBounds_AABB(agent_currentHoverAgent);

        vector_hoverObjectPosition = boundsAABB_currentHoverAgentWorldBounds["center"];
        vector_hoverObjectRotation = AgentGetWorldRot(agent_currentHoverAgent);

        bool_hoverVisibility = true;
    else
        boundsAABB_currentHoverAgentWorldBounds = nil;
        boundsAABB_currentHoverAgentLocalBounds = nil;
    end

    --||||||||||||||||||||||||||||||||||||| TRANSFORM GIZMO |||||||||||||||||||||||||||||||||||||
    --||||||||||||||||||||||||||||||||||||| TRANSFORM GIZMO |||||||||||||||||||||||||||||||||||||
    --||||||||||||||||||||||||||||||||||||| TRANSFORM GIZMO |||||||||||||||||||||||||||||||||||||

    AgentSetWorldPos(KTBM_Development_TransformTool_GizmoGroup, vector_selectObjectPosition);

    if(KTBM_Development_TransformTool_GizmoSpace == "local") then
        AgentSetWorldRot(KTBM_Development_TransformTool_GizmoGroup, vector_selectObjectRotation);
    else
        AgentSetWorldRot(KTBM_Development_TransformTool_GizmoGroup, Vector(0, 0, 0));
    end

    if(KTBM_Development_TransformTool_GizmoMode == "position") then
        KTBM_Development_TransformTool_GizmoAgentSelect_Texture = "TransformPositionGizmo_White.d3dtx";
        KTBM_Development_TransformTool_GizmoAgentX_Texture = "TransformPositionGizmo_Red.d3dtx";
        KTBM_Development_TransformTool_GizmoAgentY_Texture = "TransformPositionGizmo_Green.d3dtx";
        KTBM_Development_TransformTool_GizmoAgentZ_Texture = "TransformPositionGizmo_Blue.d3dtx";
    elseif(KTBM_Development_TransformTool_GizmoMode == "rotation") then
        KTBM_Development_TransformTool_GizmoAgentSelect_Texture = "TransformRotateGizmo_White.d3dtx";
        KTBM_Development_TransformTool_GizmoAgentX_Texture = "TransformRotateGizmo_Red.d3dtx";
        KTBM_Development_TransformTool_GizmoAgentY_Texture = "TransformRotateGizmo_Green.d3dtx";
        KTBM_Development_TransformTool_GizmoAgentZ_Texture = "TransformRotateGizmo_Blue.d3dtx";
    elseif(KTBM_Development_TransformTool_GizmoMode == "scale") then
        KTBM_Development_TransformTool_GizmoAgentSelect_Texture = "TransformScaleGizmo_White.d3dtx";
        KTBM_Development_TransformTool_GizmoAgentX_Texture = "TransformScaleGizmo_Red.d3dtx";
        KTBM_Development_TransformTool_GizmoAgentY_Texture = "TransformScaleGizmo_Green.d3dtx";
        KTBM_Development_TransformTool_GizmoAgentZ_Texture = "TransformScaleGizmo_Blue.d3dtx";
    end

    KTBM_PropertySet(KTBM_Development_TransformTool_GizmoCenter, "Render Global Scale", number_globalScale);
    KTBM_PropertySet(KTBM_Development_TransformTool_GizmoAgentX, "Render Global Scale", number_globalScale);
    KTBM_PropertySet(KTBM_Development_TransformTool_GizmoAgentY, "Render Global Scale", number_globalScale);
    KTBM_PropertySet(KTBM_Development_TransformTool_GizmoAgentZ, "Render Global Scale", number_globalScale);

    if(bool_selectedAgent == true) then
        local vector_worldX = AgentLocalToWorld(KTBM_Development_TransformTool_GizmoGroup, Vector(number_globalScale, 0, 0));
        local vector_worldY = AgentLocalToWorld(KTBM_Development_TransformTool_GizmoGroup, Vector(0, number_globalScale, 0));
        local vector_worldZ = AgentLocalToWorld(KTBM_Development_TransformTool_GizmoGroup, Vector(0, 0, number_globalScale));
        local vector_transformedX = CameraGetScreenPosFromWorldPos(agent_sceneCamera, vector_worldX);
        local vector_transformedY = CameraGetScreenPosFromWorldPos(agent_sceneCamera, vector_worldY);
        local vector_transformedZ = CameraGetScreenPosFromWorldPos(agent_sceneCamera, vector_worldZ);

        vector_transformedX = KTBM_VectorMultiply(vector_transformedX, Vector(1, 1, 0));
        vector_transformedY = KTBM_VectorMultiply(vector_transformedY, Vector(1, 1, 0));
        vector_transformedZ = KTBM_VectorMultiply(vector_transformedZ, Vector(1, 1, 0));

        local vector_transformedCursor = CameraGetScreenPosFromWorldPos(agent_sceneCamera, vector_cursorPosition);
        --local vector_transformedCursor = CameraGetScreenPosFromWorldPos(agent_sceneCamera, Vector(0.5, 0.5, 0));

        local bool_is_X_UnderCursor = VectorDistance(vector_cursorPosition, vector_transformedX) < 0.1;
        local bool_is_Y_UnderCursor = VectorDistance(vector_cursorPosition, vector_transformedY) < 0.1;
        local bool_is_Z_UnderCursor = VectorDistance(vector_cursorPosition, vector_transformedZ) < 0.1;

        KTBM_Development_TransformTool_GizmoHoveringOverAxis = bool_is_X_UnderCursor or bool_is_Y_UnderCursor or bool_is_Z_UnderCursor;

        if(bool_is_X_UnderCursor == true) then
            ShaderSwapTexture(KTBM_Development_TransformTool_GizmoAgentX, "ui_boot_title.d3dtx", KTBM_Development_TransformTool_GizmoAgentSelect_Texture);
            ShaderSwapTexture(KTBM_Development_TransformTool_GizmoAgentY, "ui_boot_title.d3dtx", KTBM_Development_TransformTool_GizmoAgentY_Texture);
            ShaderSwapTexture(KTBM_Development_TransformTool_GizmoAgentZ, "ui_boot_title.d3dtx", KTBM_Development_TransformTool_GizmoAgentZ_Texture);

            if(KTBM_Development_Editor_Input_LeftMouseHold and (KTBM_Development_TransformTool_GizmoSelectedAxis == "")) then
                KTBM_Development_TransformTool_GizmoSelectedAxis = "x";
            end
        elseif(bool_is_Y_UnderCursor == true) then
            ShaderSwapTexture(KTBM_Development_TransformTool_GizmoAgentX, "ui_boot_title.d3dtx", KTBM_Development_TransformTool_GizmoAgentX_Texture);
            ShaderSwapTexture(KTBM_Development_TransformTool_GizmoAgentY, "ui_boot_title.d3dtx", KTBM_Development_TransformTool_GizmoAgentSelect_Texture);
            ShaderSwapTexture(KTBM_Development_TransformTool_GizmoAgentZ, "ui_boot_title.d3dtx", KTBM_Development_TransformTool_GizmoAgentZ_Texture);

            if(KTBM_Development_Editor_Input_LeftMouseHold and (KTBM_Development_TransformTool_GizmoSelectedAxis == "")) then
                KTBM_Development_TransformTool_GizmoSelectedAxis = "y";
            end
        elseif(bool_is_Z_UnderCursor == true) then
            ShaderSwapTexture(KTBM_Development_TransformTool_GizmoAgentX, "ui_boot_title.d3dtx", KTBM_Development_TransformTool_GizmoAgentX_Texture);
            ShaderSwapTexture(KTBM_Development_TransformTool_GizmoAgentY, "ui_boot_title.d3dtx", KTBM_Development_TransformTool_GizmoAgentY_Texture);
            ShaderSwapTexture(KTBM_Development_TransformTool_GizmoAgentZ, "ui_boot_title.d3dtx", KTBM_Development_TransformTool_GizmoAgentSelect_Texture);

            if(KTBM_Development_Editor_Input_LeftMouseHold and (KTBM_Development_TransformTool_GizmoSelectedAxis == "")) then
                KTBM_Development_TransformTool_GizmoSelectedAxis = "z";
            end
        else
            ShaderSwapTexture(KTBM_Development_TransformTool_GizmoAgentX, "ui_boot_title.d3dtx", KTBM_Development_TransformTool_GizmoAgentX_Texture);
            ShaderSwapTexture(KTBM_Development_TransformTool_GizmoAgentY, "ui_boot_title.d3dtx", KTBM_Development_TransformTool_GizmoAgentY_Texture);
            ShaderSwapTexture(KTBM_Development_TransformTool_GizmoAgentZ, "ui_boot_title.d3dtx", KTBM_Development_TransformTool_GizmoAgentZ_Texture);
        end

        if(KTBM_Development_Editor_Input_LeftMouseHold == true) then
            local vector_newPosition = Vector(0, 0, 0);
            local xDifference = vector_cursorPosition.x - prevCursorPos.x;
            local yDifference = vector_cursorPosition.y - prevCursorPos.y;

            if(KTBM_Development_TransformTool_GizmoSelectedAxis == "x") then
                ShaderSwapTexture(KTBM_Development_TransformTool_GizmoAgentX, "ui_boot_title.d3dtx", KTBM_Development_TransformTool_GizmoAgentSelect_Texture);
                KTBM_PropertySet(KTBM_Development_TransformTool_GizmoAgentX, "Runtime: Visible", true);
                KTBM_PropertySet(KTBM_Development_TransformTool_GizmoAgentY, "Runtime: Visible", false);
                KTBM_PropertySet(KTBM_Development_TransformTool_GizmoAgentZ, "Runtime: Visible", false);
                KTBM_PropertySet(KTBM_Development_TransformTool_GizmoCenter, "Runtime: Visible", false);

                vector_newPosition = VectorAdd(AgentGetWorldPos(agent_currentSelectedAgent), Vector((xDifference - yDifference) * number_distanceToSelection, 0, 0));
                AgentSetWorldPos(agent_currentSelectedAgent, vector_newPosition);
            elseif(KTBM_Development_TransformTool_GizmoSelectedAxis == "y") then
                ShaderSwapTexture(KTBM_Development_TransformTool_GizmoAgentY, "ui_boot_title.d3dtx", KTBM_Development_TransformTool_GizmoAgentSelect_Texture);
                KTBM_PropertySet(KTBM_Development_TransformTool_GizmoAgentX, "Runtime: Visible", false);
                KTBM_PropertySet(KTBM_Development_TransformTool_GizmoAgentY, "Runtime: Visible", true);
                KTBM_PropertySet(KTBM_Development_TransformTool_GizmoAgentZ, "Runtime: Visible", false);
                KTBM_PropertySet(KTBM_Development_TransformTool_GizmoCenter, "Runtime: Visible", false);

                vector_newPosition = VectorAdd(AgentGetWorldPos(agent_currentSelectedAgent), Vector(0, (xDifference - yDifference) * number_distanceToSelection, 0));
                AgentSetWorldPos(agent_currentSelectedAgent, vector_newPosition);
            elseif(KTBM_Development_TransformTool_GizmoSelectedAxis == "z") then
                ShaderSwapTexture(KTBM_Development_TransformTool_GizmoAgentZ, "ui_boot_title.d3dtx", KTBM_Development_TransformTool_GizmoAgentSelect_Texture);
                KTBM_PropertySet(KTBM_Development_TransformTool_GizmoAgentX, "Runtime: Visible", false);
                KTBM_PropertySet(KTBM_Development_TransformTool_GizmoAgentY, "Runtime: Visible", false);
                KTBM_PropertySet(KTBM_Development_TransformTool_GizmoAgentZ, "Runtime: Visible", true);
                KTBM_PropertySet(KTBM_Development_TransformTool_GizmoCenter, "Runtime: Visible", false);

                vector_newPosition = VectorAdd(AgentGetWorldPos(agent_currentSelectedAgent), Vector(0, 0, (xDifference - yDifference) * number_distanceToSelection));
                AgentSetWorldPos(agent_currentSelectedAgent, vector_newPosition);
            end

        else
            KTBM_Development_TransformTool_GizmoSelectedAxis = "";
            KTBM_PropertySet(KTBM_Development_TransformTool_GizmoCenter, "Runtime: Visible", true);
            KTBM_PropertySet(KTBM_Development_TransformTool_GizmoAgentX, "Runtime: Visible", true);
            KTBM_PropertySet(KTBM_Development_TransformTool_GizmoAgentY, "Runtime: Visible", true);
            KTBM_PropertySet(KTBM_Development_TransformTool_GizmoAgentZ, "Runtime: Visible", true);
        end
    else
        KTBM_PropertySet(KTBM_Development_TransformTool_GizmoAgentX, "Runtime: Visible", false);
        KTBM_PropertySet(KTBM_Development_TransformTool_GizmoAgentY, "Runtime: Visible", false);
        KTBM_PropertySet(KTBM_Development_TransformTool_GizmoAgentZ, "Runtime: Visible", false);
        KTBM_PropertySet(KTBM_Development_TransformTool_GizmoCenter, "Runtime: Visible", false);
    end

    --||||||||||||||||||||||||||||||||||||| BOUNDS SELECT HIGHLIGHT |||||||||||||||||||||||||||||||||||||
    --||||||||||||||||||||||||||||||||||||| BOUNDS SELECT HIGHLIGHT |||||||||||||||||||||||||||||||||||||
    --||||||||||||||||||||||||||||||||||||| BOUNDS SELECT HIGHLIGHT |||||||||||||||||||||||||||||||||||||

    if(boundsAABB_currentSelectedAgentLocalBounds ~= nil) then
        local vector_extents = boundsAABB_currentSelectedAgentLocalBounds["extents"];
        local vector_size = boundsAABB_currentSelectedAgentLocalBounds["size"];
        local vector_extentsWorldSpace = AgentLocalToWorld(agent_currentSelectedAgent, vector_extents);
        local vector_sizeWorldSpace = AgentLocalToWorld(agent_currentSelectedAgent, vector_size);

        AgentSetWorldPos(KTBM_Development_TransformTool_SelectBoundingBoxGroup, vector_selectObjectPosition);
        AgentSetWorldRot(KTBM_Development_TransformTool_SelectBoundingBoxGroup, vector_selectObjectRotation);
        
        AgentSetPos(KTBM_Development_TransformTool_SelectBoundingBoxSide1, Vector(0, vector_extents.y, 0));
        AgentSetPos(KTBM_Development_TransformTool_SelectBoundingBoxSide2, Vector(0, -vector_extents.y, 0));
        AgentSetPos(KTBM_Development_TransformTool_SelectBoundingBoxSide3, Vector(vector_extents.x, 0, 0));
        AgentSetPos(KTBM_Development_TransformTool_SelectBoundingBoxSide4, Vector(-vector_extents.x, 0, 0));
        AgentSetPos(KTBM_Development_TransformTool_SelectBoundingBoxSide5, Vector(0, 0, vector_extents.z));
        AgentSetPos(KTBM_Development_TransformTool_SelectBoundingBoxSide6, Vector(0, 0, -vector_extents.z));

        AgentSetRot(KTBM_Development_TransformTool_SelectBoundingBoxSide1, Vector(90, 0, 0));
        AgentSetRot(KTBM_Development_TransformTool_SelectBoundingBoxSide2, Vector(90, 0, 0));
        AgentSetRot(KTBM_Development_TransformTool_SelectBoundingBoxSide3, Vector(0, 90, 0));
        AgentSetRot(KTBM_Development_TransformTool_SelectBoundingBoxSide4, Vector(0, 90, 0));
        AgentSetRot(KTBM_Development_TransformTool_SelectBoundingBoxSide5, Vector(0, 0, 0));
        AgentSetRot(KTBM_Development_TransformTool_SelectBoundingBoxSide6, Vector(0, 0, 0));

        KTBM_PropertySet(KTBM_Development_TransformTool_SelectBoundingBoxSide1, "Render Axis Scale", Vector(vector_size.x, vector_size.z, 1));
        KTBM_PropertySet(KTBM_Development_TransformTool_SelectBoundingBoxSide2, "Render Axis Scale", Vector(vector_size.x, vector_size.z, 1));
        KTBM_PropertySet(KTBM_Development_TransformTool_SelectBoundingBoxSide3, "Render Axis Scale", Vector(vector_size.z, vector_size.y, 1));
        KTBM_PropertySet(KTBM_Development_TransformTool_SelectBoundingBoxSide4, "Render Axis Scale", Vector(vector_size.z, vector_size.y, 1));
        KTBM_PropertySet(KTBM_Development_TransformTool_SelectBoundingBoxSide5, "Render Axis Scale", Vector(vector_size.x, vector_size.y, 1));
        KTBM_PropertySet(KTBM_Development_TransformTool_SelectBoundingBoxSide6, "Render Axis Scale", Vector(vector_size.x, vector_size.y, 1));
    end

    KTBM_PropertySet(KTBM_Development_TransformTool_SelectBoundingBoxSide1, "Runtime: Visible", bool_selectVisibility and not bool_isMovingObject);
    KTBM_PropertySet(KTBM_Development_TransformTool_SelectBoundingBoxSide2, "Runtime: Visible", bool_selectVisibility and not bool_isMovingObject);
    KTBM_PropertySet(KTBM_Development_TransformTool_SelectBoundingBoxSide3, "Runtime: Visible", bool_selectVisibility and not bool_isMovingObject);
    KTBM_PropertySet(KTBM_Development_TransformTool_SelectBoundingBoxSide4, "Runtime: Visible", bool_selectVisibility and not bool_isMovingObject);
    KTBM_PropertySet(KTBM_Development_TransformTool_SelectBoundingBoxSide5, "Runtime: Visible", bool_selectVisibility and not bool_isMovingObject);
    KTBM_PropertySet(KTBM_Development_TransformTool_SelectBoundingBoxSide6, "Runtime: Visible", bool_selectVisibility and not bool_isMovingObject);

    --||||||||||||||||||||||||||||||||||||| BOUNDS HOVER HIGHLIGHT |||||||||||||||||||||||||||||||||||||
    --||||||||||||||||||||||||||||||||||||| BOUNDS HOVER HIGHLIGHT |||||||||||||||||||||||||||||||||||||
    --||||||||||||||||||||||||||||||||||||| BOUNDS HOVER HIGHLIGHT |||||||||||||||||||||||||||||||||||||

    if(boundsAABB_currentHoverAgentLocalBounds ~= nil) then
        local vector_extents = boundsAABB_currentHoverAgentLocalBounds["extents"];
        local vector_size = boundsAABB_currentHoverAgentLocalBounds["size"];
        local vector_extentsWorldSpace = AgentLocalToWorld(agent_currentHoverAgent, vector_extents);
        local vector_sizeWorldSpace = AgentLocalToWorld(agent_currentHoverAgent, vector_size);

        AgentSetWorldPos(KTBM_Development_TransformTool_HoverBoundingBoxGroup, vector_hoverObjectPosition);
        AgentSetWorldRot(KTBM_Development_TransformTool_HoverBoundingBoxGroup, vector_hoverObjectRotation);
        
        AgentSetPos(KTBM_Development_TransformTool_HoverBoundingBoxSide1, Vector(0, vector_extents.y, 0));
        AgentSetPos(KTBM_Development_TransformTool_HoverBoundingBoxSide2, Vector(0, -vector_extents.y, 0));
        AgentSetPos(KTBM_Development_TransformTool_HoverBoundingBoxSide3, Vector(vector_extents.x, 0, 0));
        AgentSetPos(KTBM_Development_TransformTool_HoverBoundingBoxSide4, Vector(-vector_extents.x, 0, 0));
        AgentSetPos(KTBM_Development_TransformTool_HoverBoundingBoxSide5, Vector(0, 0, vector_extents.z));
        AgentSetPos(KTBM_Development_TransformTool_HoverBoundingBoxSide6, Vector(0, 0, -vector_extents.z));

        AgentSetRot(KTBM_Development_TransformTool_HoverBoundingBoxSide1, Vector(90, 0, 0));
        AgentSetRot(KTBM_Development_TransformTool_HoverBoundingBoxSide2, Vector(90, 0, 0));
        AgentSetRot(KTBM_Development_TransformTool_HoverBoundingBoxSide3, Vector(0, 90, 0));
        AgentSetRot(KTBM_Development_TransformTool_HoverBoundingBoxSide4, Vector(0, 90, 0));
        AgentSetRot(KTBM_Development_TransformTool_HoverBoundingBoxSide5, Vector(0, 0, 0));
        AgentSetRot(KTBM_Development_TransformTool_HoverBoundingBoxSide6, Vector(0, 0, 0));

        KTBM_PropertySet(KTBM_Development_TransformTool_HoverBoundingBoxSide1, "Render Axis Scale", Vector(vector_size.x, vector_size.z, 1));
        KTBM_PropertySet(KTBM_Development_TransformTool_HoverBoundingBoxSide2, "Render Axis Scale", Vector(vector_size.x, vector_size.z, 1));
        KTBM_PropertySet(KTBM_Development_TransformTool_HoverBoundingBoxSide3, "Render Axis Scale", Vector(vector_size.z, vector_size.y, 1));
        KTBM_PropertySet(KTBM_Development_TransformTool_HoverBoundingBoxSide4, "Render Axis Scale", Vector(vector_size.z, vector_size.y, 1));
        KTBM_PropertySet(KTBM_Development_TransformTool_HoverBoundingBoxSide5, "Render Axis Scale", Vector(vector_size.x, vector_size.y, 1));
        KTBM_PropertySet(KTBM_Development_TransformTool_HoverBoundingBoxSide6, "Render Axis Scale", Vector(vector_size.x, vector_size.y, 1));
    end

    KTBM_PropertySet(KTBM_Development_TransformTool_HoverBoundingBoxSide1, "Runtime: Visible", bool_hoverVisibility and not bool_isMovingObject);
    KTBM_PropertySet(KTBM_Development_TransformTool_HoverBoundingBoxSide2, "Runtime: Visible", bool_hoverVisibility and not bool_isMovingObject);
    KTBM_PropertySet(KTBM_Development_TransformTool_HoverBoundingBoxSide3, "Runtime: Visible", bool_hoverVisibility and not bool_isMovingObject);
    KTBM_PropertySet(KTBM_Development_TransformTool_HoverBoundingBoxSide4, "Runtime: Visible", bool_hoverVisibility and not bool_isMovingObject);
    KTBM_PropertySet(KTBM_Development_TransformTool_HoverBoundingBoxSide5, "Runtime: Visible", bool_hoverVisibility and not bool_isMovingObject);
    KTBM_PropertySet(KTBM_Development_TransformTool_HoverBoundingBoxSide6, "Runtime: Visible", bool_hoverVisibility and not bool_isMovingObject);

    prevCursorPos = vector_cursorPosition;
end

KTBM_Development_TransformTool_Initalize = function()
    -------------------------------------------------------------
    --initalize menu text

    --create our menu text
    KTBM_Development_TransformTool_Text = KTBM_TextUI_CreateTextAgent("KTBM_Development_TransformTool_Text", "Text Initalized", Vector(0, 0, 0), 0, 0);

    --set the text color
    TextSetColor(KTBM_Development_TransformTool_Text, Color(1.0, 0.5, 0.5, 1.0));

    --scale note
    --1.0 = default
    --0.5 = half
    --2.0 = double
    TextSetScale(KTBM_Development_TransformTool_Text, 0.5);

    --||||||||||||||||||||||||||||||||||||| CREATE TRANSFORM POSITION GIZMO |||||||||||||||||||||||||||||||||||||
    --||||||||||||||||||||||||||||||||||||| CREATE TRANSFORM POSITION GIZMO |||||||||||||||||||||||||||||||||||||
    --||||||||||||||||||||||||||||||||||||| CREATE TRANSFORM POSITION GIZMO |||||||||||||||||||||||||||||||||||||

    KTBM_Development_TransformTool_GizmoGroup = AgentCreate("KTBM_Development_TransformTool_GizmoGroup", "group.prop", Vector(0, 0, 0), Vector(0, 0, 0), KTBM_Development_SceneObject, false, false);
    KTBM_Development_TransformTool_GizmoCenter = AgentCreate("KTBM_Development_TransformTool_GizmoCenter", "ui_boot_title.prop", Vector(0, 0, 0), Vector(0, 0, 0), KTBM_Development_SceneObject, false, false);
    KTBM_Development_TransformTool_GizmoAgentX = AgentCreate("KTBM_Development_TransformTool_GizmoAgentX", "ui_boot_title.prop", Vector(0, 0, 0), Vector(0, 0, 0), KTBM_Development_SceneObject, false, false);
    KTBM_Development_TransformTool_GizmoAgentY = AgentCreate("KTBM_Development_TransformTool_GizmoAgentY", "ui_boot_title.prop", Vector(0, 0, 0), Vector(90, 0, 90), KTBM_Development_SceneObject, false, false);
    KTBM_Development_TransformTool_GizmoAgentZ = AgentCreate("KTBM_Development_TransformTool_GizmoAgentZ", "ui_boot_title.prop", Vector(0, 0, 0), Vector(0, -90, 0), KTBM_Development_SceneObject, false, false);
    
    KTBM_PropertySet(KTBM_Development_TransformTool_GizmoCenter, "Render Axis Scale", Vector(1, 1, 1));
    KTBM_PropertySet(KTBM_Development_TransformTool_GizmoCenter, "Render Global Scale", 1);
    KTBM_PropertySet(KTBM_Development_TransformTool_GizmoCenter, "Render After Anti-Aliasing", true);
    KTBM_PropertySet(KTBM_Development_TransformTool_GizmoCenter, "Render Depth Test", false);
    KTBM_PropertySet(KTBM_Development_TransformTool_GizmoCenter, "Render Depth Write", false);
    KTBM_PropertySet(KTBM_Development_TransformTool_GizmoCenter, "Render Depth Write Alpha", false);
    KTBM_PropertySet(KTBM_Development_TransformTool_GizmoCenter, "Render Layer", 55);

    KTBM_PropertySet(KTBM_Development_TransformTool_GizmoAgentX, "Render Axis Scale", Vector(1, 1, 1));
    KTBM_PropertySet(KTBM_Development_TransformTool_GizmoAgentX, "Render Global Scale", 1);
    KTBM_PropertySet(KTBM_Development_TransformTool_GizmoAgentX, "Render After Anti-Aliasing", true);
    KTBM_PropertySet(KTBM_Development_TransformTool_GizmoAgentX, "Render Depth Test", false);
    KTBM_PropertySet(KTBM_Development_TransformTool_GizmoAgentX, "Render Depth Write", false);
    KTBM_PropertySet(KTBM_Development_TransformTool_GizmoAgentX, "Render Depth Write Alpha", false);
    KTBM_PropertySet(KTBM_Development_TransformTool_GizmoAgentX, "Render Layer", 50);

    KTBM_PropertySet(KTBM_Development_TransformTool_GizmoAgentY, "Render Axis Scale", Vector(1, 1, 1));
    KTBM_PropertySet(KTBM_Development_TransformTool_GizmoAgentY, "Render Global Scale", 1);
    KTBM_PropertySet(KTBM_Development_TransformTool_GizmoAgentY, "Render After Anti-Aliasing", true);
    KTBM_PropertySet(KTBM_Development_TransformTool_GizmoAgentY, "Render Depth Test", false);
    KTBM_PropertySet(KTBM_Development_TransformTool_GizmoAgentY, "Render Depth Write", false);
    KTBM_PropertySet(KTBM_Development_TransformTool_GizmoAgentY, "Render Depth Write Alpha", false);
    KTBM_PropertySet(KTBM_Development_TransformTool_GizmoAgentY, "Render Layer", 50);

    KTBM_PropertySet(KTBM_Development_TransformTool_GizmoAgentZ, "Render Axis Scale", Vector(1, 1, 1));
    KTBM_PropertySet(KTBM_Development_TransformTool_GizmoAgentZ, "Render Global Scale", 1);
    KTBM_PropertySet(KTBM_Development_TransformTool_GizmoAgentZ, "Render After Anti-Aliasing", true);
    KTBM_PropertySet(KTBM_Development_TransformTool_GizmoAgentZ, "Render Depth Test", false);
    KTBM_PropertySet(KTBM_Development_TransformTool_GizmoAgentZ, "Render Depth Write", false);
    KTBM_PropertySet(KTBM_Development_TransformTool_GizmoAgentZ, "Render Depth Write Alpha", false);
    KTBM_PropertySet(KTBM_Development_TransformTool_GizmoAgentZ, "Render Layer", 50);

    ShaderSwapTexture(KTBM_Development_TransformTool_GizmoCenter, "ui_boot_title.d3dtx", "SelectionDot_White.d3dtx");
    ShaderSwapTexture(KTBM_Development_TransformTool_GizmoAgentX, "ui_boot_title.d3dtx", "TransformPositionGizmo_Red.d3dtx");
    ShaderSwapTexture(KTBM_Development_TransformTool_GizmoAgentY, "ui_boot_title.d3dtx", "TransformPositionGizmo_Green.d3dtx");
    ShaderSwapTexture(KTBM_Development_TransformTool_GizmoAgentZ, "ui_boot_title.d3dtx", "TransformPositionGizmo_Blue.d3dtx");
    --ShaderSwapTexture(KTBM_Development_TransformTool_GizmoAgentX, "ui_boot_title.d3dtx", "TransformRotateGizmo_Red.d3dtx");
    --ShaderSwapTexture(KTBM_Development_TransformTool_GizmoAgentY, "ui_boot_title.d3dtx", "TransformRotateGizmo_Green.d3dtx");
    --ShaderSwapTexture(KTBM_Development_TransformTool_GizmoAgentZ, "ui_boot_title.d3dtx", "TransformRotateGizmo_Blue.d3dtx");

    AgentAttach(KTBM_Development_TransformTool_GizmoCenter, KTBM_Development_TransformTool_GizmoGroup);
    AgentAttach(KTBM_Development_TransformTool_GizmoAgentX, KTBM_Development_TransformTool_GizmoGroup);
    AgentAttach(KTBM_Development_TransformTool_GizmoAgentY, KTBM_Development_TransformTool_GizmoGroup);
    AgentAttach(KTBM_Development_TransformTool_GizmoAgentZ, KTBM_Development_TransformTool_GizmoGroup);

    KTBM_Development_TransformTool_GizmoAgentAxisDefaultBoundsMin = KTBM_PropertyGet(KTBM_Development_TransformTool_GizmoAgentX, "Extents Min");
    KTBM_Development_TransformTool_GizmoAgentAxisDefaultBoundsMax = KTBM_PropertyGet(KTBM_Development_TransformTool_GizmoAgentX, "Extents Min");

    local number_globalScale = 0.0977;
    local number_renderLayer = 45;
    local bool_depthTest = false;

    --||||||||||||||||||||||||||||||||||||| CREATE BOUNDS SELECT HIGHLIGHT |||||||||||||||||||||||||||||||||||||
    --||||||||||||||||||||||||||||||||||||| CREATE BOUNDS SELECT HIGHLIGHT |||||||||||||||||||||||||||||||||||||
    --||||||||||||||||||||||||||||||||||||| CREATE BOUNDS SELECT HIGHLIGHT |||||||||||||||||||||||||||||||||||||

    KTBM_Development_TransformTool_SelectBoundingBoxGroup = AgentCreate("KTBM_Development_TransformTool_SelectBoundingBoxGroup", "group.prop", Vector(0, 0, 0), Vector(0, 0, 0), KTBM_Development_SceneObject, false, false);
    KTBM_Development_TransformTool_SelectBoundingBoxSide1 = AgentCreate("KTBM_Development_TransformTool_SelectBoundingBoxSide1", "ui_boot_title.prop", Vector(0, 0, 0), Vector(0, 0, 0), KTBM_Development_SceneObject, false, false);
    KTBM_Development_TransformTool_SelectBoundingBoxSide2 = AgentCreate("KTBM_Development_TransformTool_SelectBoundingBoxSide2", "ui_boot_title.prop", Vector(0, 0, 0), Vector(0, 0, 0), KTBM_Development_SceneObject, false, false);
    KTBM_Development_TransformTool_SelectBoundingBoxSide3 = AgentCreate("KTBM_Development_TransformTool_SelectBoundingBoxSide3", "ui_boot_title.prop", Vector(0, 0, 0), Vector(0, 0, 0), KTBM_Development_SceneObject, false, false);
    KTBM_Development_TransformTool_SelectBoundingBoxSide4 = AgentCreate("KTBM_Development_TransformTool_SelectBoundingBoxSide4", "ui_boot_title.prop", Vector(0, 0, 0), Vector(0, 0, 0), KTBM_Development_SceneObject, false, false);
    KTBM_Development_TransformTool_SelectBoundingBoxSide5 = AgentCreate("KTBM_Development_TransformTool_SelectBoundingBoxSide5", "ui_boot_title.prop", Vector(0, 0, 0), Vector(0, 0, 0), KTBM_Development_SceneObject, false, false);
    KTBM_Development_TransformTool_SelectBoundingBoxSide6 = AgentCreate("KTBM_Development_TransformTool_SelectBoundingBoxSide6", "ui_boot_title.prop", Vector(0, 0, 0), Vector(0, 0, 0), KTBM_Development_SceneObject, false, false);
    KTBM_PropertySet(KTBM_Development_TransformTool_SelectBoundingBoxSide1, "Render Global Scale", number_globalScale);
    KTBM_PropertySet(KTBM_Development_TransformTool_SelectBoundingBoxSide1, "Render After Anti-Aliasing", true);
    KTBM_PropertySet(KTBM_Development_TransformTool_SelectBoundingBoxSide1, "Render Depth Test", bool_depthTest);
    KTBM_PropertySet(KTBM_Development_TransformTool_SelectBoundingBoxSide1, "Render Depth Write", false);
    KTBM_PropertySet(KTBM_Development_TransformTool_SelectBoundingBoxSide1, "Render Depth Write Alpha", false);
    KTBM_PropertySet(KTBM_Development_TransformTool_SelectBoundingBoxSide1, "Render Cull", false);
    KTBM_PropertySet(KTBM_Development_TransformTool_SelectBoundingBoxSide1, "Render Layer", number_renderLayer);

    KTBM_PropertySet(KTBM_Development_TransformTool_SelectBoundingBoxSide2, "Render Global Scale", number_globalScale);
    KTBM_PropertySet(KTBM_Development_TransformTool_SelectBoundingBoxSide2, "Render After Anti-Aliasing", true);
    KTBM_PropertySet(KTBM_Development_TransformTool_SelectBoundingBoxSide2, "Render Depth Test", bool_depthTest);
    KTBM_PropertySet(KTBM_Development_TransformTool_SelectBoundingBoxSide2, "Render Depth Write", false);
    KTBM_PropertySet(KTBM_Development_TransformTool_SelectBoundingBoxSide2, "Render Depth Write Alpha", false);
    KTBM_PropertySet(KTBM_Development_TransformTool_SelectBoundingBoxSide2, "Render Cull", false);
    KTBM_PropertySet(KTBM_Development_TransformTool_SelectBoundingBoxSide2, "Render Layer", number_renderLayer);

    KTBM_PropertySet(KTBM_Development_TransformTool_SelectBoundingBoxSide3, "Render Global Scale", number_globalScale);
    KTBM_PropertySet(KTBM_Development_TransformTool_SelectBoundingBoxSide3, "Render After Anti-Aliasing", true);
    KTBM_PropertySet(KTBM_Development_TransformTool_SelectBoundingBoxSide3, "Render Depth Test", bool_depthTest);
    KTBM_PropertySet(KTBM_Development_TransformTool_SelectBoundingBoxSide3, "Render Depth Write", false);
    KTBM_PropertySet(KTBM_Development_TransformTool_SelectBoundingBoxSide3, "Render Depth Write Alpha", false);
    KTBM_PropertySet(KTBM_Development_TransformTool_SelectBoundingBoxSide3, "Render Cull", false);
    KTBM_PropertySet(KTBM_Development_TransformTool_SelectBoundingBoxSide3, "Render Layer", number_renderLayer);

    KTBM_PropertySet(KTBM_Development_TransformTool_SelectBoundingBoxSide4, "Render Global Scale", number_globalScale);
    KTBM_PropertySet(KTBM_Development_TransformTool_SelectBoundingBoxSide4, "Render After Anti-Aliasing", true);
    KTBM_PropertySet(KTBM_Development_TransformTool_SelectBoundingBoxSide4, "Render Depth Test", bool_depthTest);
    KTBM_PropertySet(KTBM_Development_TransformTool_SelectBoundingBoxSide4, "Render Depth Write", false);
    KTBM_PropertySet(KTBM_Development_TransformTool_SelectBoundingBoxSide4, "Render Depth Write Alpha", false);
    KTBM_PropertySet(KTBM_Development_TransformTool_SelectBoundingBoxSide4, "Render Cull", false);
    KTBM_PropertySet(KTBM_Development_TransformTool_SelectBoundingBoxSide4, "Render Layer", number_renderLayer);

    KTBM_PropertySet(KTBM_Development_TransformTool_SelectBoundingBoxSide5, "Render Global Scale", number_globalScale);
    KTBM_PropertySet(KTBM_Development_TransformTool_SelectBoundingBoxSide5, "Render After Anti-Aliasing", true);
    KTBM_PropertySet(KTBM_Development_TransformTool_SelectBoundingBoxSide5, "Render Depth Test", bool_depthTest);
    KTBM_PropertySet(KTBM_Development_TransformTool_SelectBoundingBoxSide5, "Render Depth Write", false);
    KTBM_PropertySet(KTBM_Development_TransformTool_SelectBoundingBoxSide5, "Render Depth Write Alpha", false);
    KTBM_PropertySet(KTBM_Development_TransformTool_SelectBoundingBoxSide5, "Render Cull", false);
    KTBM_PropertySet(KTBM_Development_TransformTool_SelectBoundingBoxSide5, "Render Layer", number_renderLayer);

    KTBM_PropertySet(KTBM_Development_TransformTool_SelectBoundingBoxSide6, "Render Global Scale", number_globalScale);
    KTBM_PropertySet(KTBM_Development_TransformTool_SelectBoundingBoxSide6, "Render After Anti-Aliasing", true);
    KTBM_PropertySet(KTBM_Development_TransformTool_SelectBoundingBoxSide6, "Render Depth Test", bool_depthTest);
    KTBM_PropertySet(KTBM_Development_TransformTool_SelectBoundingBoxSide6, "Render Depth Write", false);
    KTBM_PropertySet(KTBM_Development_TransformTool_SelectBoundingBoxSide6, "Render Depth Write Alpha", false);
    KTBM_PropertySet(KTBM_Development_TransformTool_SelectBoundingBoxSide6, "Render Cull", false);
    KTBM_PropertySet(KTBM_Development_TransformTool_SelectBoundingBoxSide6, "Render Layer", number_renderLayer);

    ShaderSwapTexture(KTBM_Development_TransformTool_SelectBoundingBoxSide1, "ui_boot_title.d3dtx", "BoundsSelectColor.d3dtx");
    ShaderSwapTexture(KTBM_Development_TransformTool_SelectBoundingBoxSide2, "ui_boot_title.d3dtx", "BoundsSelectColor.d3dtx");
    ShaderSwapTexture(KTBM_Development_TransformTool_SelectBoundingBoxSide3, "ui_boot_title.d3dtx", "BoundsSelectColor.d3dtx");
    ShaderSwapTexture(KTBM_Development_TransformTool_SelectBoundingBoxSide4, "ui_boot_title.d3dtx", "BoundsSelectColor.d3dtx");
    ShaderSwapTexture(KTBM_Development_TransformTool_SelectBoundingBoxSide5, "ui_boot_title.d3dtx", "BoundsSelectColor.d3dtx");
    ShaderSwapTexture(KTBM_Development_TransformTool_SelectBoundingBoxSide6, "ui_boot_title.d3dtx", "BoundsSelectColor.d3dtx");

    AgentAttach(KTBM_Development_TransformTool_SelectBoundingBoxSide1, KTBM_Development_TransformTool_SelectBoundingBoxGroup);
    AgentAttach(KTBM_Development_TransformTool_SelectBoundingBoxSide2, KTBM_Development_TransformTool_SelectBoundingBoxGroup);
    AgentAttach(KTBM_Development_TransformTool_SelectBoundingBoxSide3, KTBM_Development_TransformTool_SelectBoundingBoxGroup);
    AgentAttach(KTBM_Development_TransformTool_SelectBoundingBoxSide4, KTBM_Development_TransformTool_SelectBoundingBoxGroup);
    AgentAttach(KTBM_Development_TransformTool_SelectBoundingBoxSide5, KTBM_Development_TransformTool_SelectBoundingBoxGroup);
    AgentAttach(KTBM_Development_TransformTool_SelectBoundingBoxSide6, KTBM_Development_TransformTool_SelectBoundingBoxGroup);

    --||||||||||||||||||||||||||||||||||||| CREATE BOUNDS HOVER HIGHLIGHT |||||||||||||||||||||||||||||||||||||
    --||||||||||||||||||||||||||||||||||||| CREATE BOUNDS HOVER HIGHLIGHT |||||||||||||||||||||||||||||||||||||
    --||||||||||||||||||||||||||||||||||||| CREATE BOUNDS HOVER HIGHLIGHT |||||||||||||||||||||||||||||||||||||

    KTBM_Development_TransformTool_HoverBoundingBoxGroup = AgentCreate("KTBM_Development_TransformTool_HoverBoundingBoxGroup", "group.prop", Vector(0, 0, 0), Vector(0, 0, 0), KTBM_Development_SceneObject, false, false);
    KTBM_Development_TransformTool_HoverBoundingBoxSide1 = AgentCreate("KTBM_Development_TransformTool_HoverBoundingBoxSide1", "ui_boot_title.prop", Vector(0, 0, 0), Vector(0, 0, 0), KTBM_Development_SceneObject, false, false);
    KTBM_Development_TransformTool_HoverBoundingBoxSide2 = AgentCreate("KTBM_Development_TransformTool_HoverBoundingBoxSide2", "ui_boot_title.prop", Vector(0, 0, 0), Vector(0, 0, 0), KTBM_Development_SceneObject, false, false);
    KTBM_Development_TransformTool_HoverBoundingBoxSide3 = AgentCreate("KTBM_Development_TransformTool_HoverBoundingBoxSide3", "ui_boot_title.prop", Vector(0, 0, 0), Vector(0, 0, 0), KTBM_Development_SceneObject, false, false);
    KTBM_Development_TransformTool_HoverBoundingBoxSide4 = AgentCreate("KTBM_Development_TransformTool_HoverBoundingBoxSide4", "ui_boot_title.prop", Vector(0, 0, 0), Vector(0, 0, 0), KTBM_Development_SceneObject, false, false);
    KTBM_Development_TransformTool_HoverBoundingBoxSide5 = AgentCreate("KTBM_Development_TransformTool_HoverBoundingBoxSide5", "ui_boot_title.prop", Vector(0, 0, 0), Vector(0, 0, 0), KTBM_Development_SceneObject, false, false);
    KTBM_Development_TransformTool_HoverBoundingBoxSide6 = AgentCreate("KTBM_Development_TransformTool_HoverBoundingBoxSide6", "ui_boot_title.prop", Vector(0, 0, 0), Vector(0, 0, 0), KTBM_Development_SceneObject, false, false);
    KTBM_PropertySet(KTBM_Development_TransformTool_HoverBoundingBoxSide1, "Render Global Scale", number_globalScale);
    KTBM_PropertySet(KTBM_Development_TransformTool_HoverBoundingBoxSide1, "Render After Anti-Aliasing", true);
    KTBM_PropertySet(KTBM_Development_TransformTool_HoverBoundingBoxSide1, "Render Depth Test", bool_depthTest);
    KTBM_PropertySet(KTBM_Development_TransformTool_HoverBoundingBoxSide1, "Render Depth Write", false);
    KTBM_PropertySet(KTBM_Development_TransformTool_HoverBoundingBoxSide1, "Render Depth Write Alpha", false);
    KTBM_PropertySet(KTBM_Development_TransformTool_HoverBoundingBoxSide1, "Render Cull", false);
    KTBM_PropertySet(KTBM_Development_TransformTool_HoverBoundingBoxSide1, "Render Layer", number_renderLayer);

    KTBM_PropertySet(KTBM_Development_TransformTool_HoverBoundingBoxSide2, "Render Global Scale", number_globalScale);
    KTBM_PropertySet(KTBM_Development_TransformTool_HoverBoundingBoxSide2, "Render After Anti-Aliasing", true);
    KTBM_PropertySet(KTBM_Development_TransformTool_HoverBoundingBoxSide2, "Render Depth Test", bool_depthTest);
    KTBM_PropertySet(KTBM_Development_TransformTool_HoverBoundingBoxSide2, "Render Depth Write", false);
    KTBM_PropertySet(KTBM_Development_TransformTool_HoverBoundingBoxSide2, "Render Depth Write Alpha", false);
    KTBM_PropertySet(KTBM_Development_TransformTool_HoverBoundingBoxSide2, "Render Cull", false);
    KTBM_PropertySet(KTBM_Development_TransformTool_HoverBoundingBoxSide2, "Render Layer", number_renderLayer);

    KTBM_PropertySet(KTBM_Development_TransformTool_HoverBoundingBoxSide3, "Render Global Scale", number_globalScale);
    KTBM_PropertySet(KTBM_Development_TransformTool_HoverBoundingBoxSide3, "Render After Anti-Aliasing", true);
    KTBM_PropertySet(KTBM_Development_TransformTool_HoverBoundingBoxSide3, "Render Depth Test", bool_depthTest);
    KTBM_PropertySet(KTBM_Development_TransformTool_HoverBoundingBoxSide3, "Render Depth Write", false);
    KTBM_PropertySet(KTBM_Development_TransformTool_HoverBoundingBoxSide3, "Render Depth Write Alpha", false);
    KTBM_PropertySet(KTBM_Development_TransformTool_HoverBoundingBoxSide3, "Render Cull", false);
    KTBM_PropertySet(KTBM_Development_TransformTool_HoverBoundingBoxSide3, "Render Layer", number_renderLayer);

    KTBM_PropertySet(KTBM_Development_TransformTool_HoverBoundingBoxSide4, "Render Global Scale", number_globalScale);
    KTBM_PropertySet(KTBM_Development_TransformTool_HoverBoundingBoxSide4, "Render After Anti-Aliasing", true);
    KTBM_PropertySet(KTBM_Development_TransformTool_HoverBoundingBoxSide4, "Render Depth Test", bool_depthTest);
    KTBM_PropertySet(KTBM_Development_TransformTool_HoverBoundingBoxSide4, "Render Depth Write", false);
    KTBM_PropertySet(KTBM_Development_TransformTool_HoverBoundingBoxSide4, "Render Depth Write Alpha", false);
    KTBM_PropertySet(KTBM_Development_TransformTool_HoverBoundingBoxSide4, "Render Cull", false);
    KTBM_PropertySet(KTBM_Development_TransformTool_HoverBoundingBoxSide4, "Render Layer", number_renderLayer);

    KTBM_PropertySet(KTBM_Development_TransformTool_HoverBoundingBoxSide5, "Render Global Scale", number_globalScale);
    KTBM_PropertySet(KTBM_Development_TransformTool_HoverBoundingBoxSide5, "Render After Anti-Aliasing", true);
    KTBM_PropertySet(KTBM_Development_TransformTool_HoverBoundingBoxSide5, "Render Depth Test", bool_depthTest);
    KTBM_PropertySet(KTBM_Development_TransformTool_HoverBoundingBoxSide5, "Render Depth Write", false);
    KTBM_PropertySet(KTBM_Development_TransformTool_HoverBoundingBoxSide5, "Render Depth Write Alpha", false);
    KTBM_PropertySet(KTBM_Development_TransformTool_HoverBoundingBoxSide5, "Render Cull", false);
    KTBM_PropertySet(KTBM_Development_TransformTool_HoverBoundingBoxSide5, "Render Layer", number_renderLayer);

    KTBM_PropertySet(KTBM_Development_TransformTool_HoverBoundingBoxSide6, "Render Global Scale", number_globalScale);
    KTBM_PropertySet(KTBM_Development_TransformTool_HoverBoundingBoxSide6, "Render After Anti-Aliasing", true);
    KTBM_PropertySet(KTBM_Development_TransformTool_HoverBoundingBoxSide6, "Render Depth Test", bool_depthTest);
    KTBM_PropertySet(KTBM_Development_TransformTool_HoverBoundingBoxSide6, "Render Depth Write", false);
    KTBM_PropertySet(KTBM_Development_TransformTool_HoverBoundingBoxSide6, "Render Depth Write Alpha", false);
    KTBM_PropertySet(KTBM_Development_TransformTool_HoverBoundingBoxSide6, "Render Cull", false);
    KTBM_PropertySet(KTBM_Development_TransformTool_HoverBoundingBoxSide6, "Render Layer", number_renderLayer);

    ShaderSwapTexture(KTBM_Development_TransformTool_HoverBoundingBoxSide1, "ui_boot_title.d3dtx", "BoundsHoverColor.d3dtx");
    ShaderSwapTexture(KTBM_Development_TransformTool_HoverBoundingBoxSide2, "ui_boot_title.d3dtx", "BoundsHoverColor.d3dtx");
    ShaderSwapTexture(KTBM_Development_TransformTool_HoverBoundingBoxSide3, "ui_boot_title.d3dtx", "BoundsHoverColor.d3dtx");
    ShaderSwapTexture(KTBM_Development_TransformTool_HoverBoundingBoxSide4, "ui_boot_title.d3dtx", "BoundsHoverColor.d3dtx");
    ShaderSwapTexture(KTBM_Development_TransformTool_HoverBoundingBoxSide5, "ui_boot_title.d3dtx", "BoundsHoverColor.d3dtx");
    ShaderSwapTexture(KTBM_Development_TransformTool_HoverBoundingBoxSide6, "ui_boot_title.d3dtx", "BoundsHoverColor.d3dtx");

    AgentAttach(KTBM_Development_TransformTool_HoverBoundingBoxSide1, KTBM_Development_TransformTool_HoverBoundingBoxGroup);
    AgentAttach(KTBM_Development_TransformTool_HoverBoundingBoxSide2, KTBM_Development_TransformTool_HoverBoundingBoxGroup);
    AgentAttach(KTBM_Development_TransformTool_HoverBoundingBoxSide3, KTBM_Development_TransformTool_HoverBoundingBoxGroup);
    AgentAttach(KTBM_Development_TransformTool_HoverBoundingBoxSide4, KTBM_Development_TransformTool_HoverBoundingBoxGroup);
    AgentAttach(KTBM_Development_TransformTool_HoverBoundingBoxSide5, KTBM_Development_TransformTool_HoverBoundingBoxGroup);
    AgentAttach(KTBM_Development_TransformTool_HoverBoundingBoxSide6, KTBM_Development_TransformTool_HoverBoundingBoxGroup);
end

local SelectSceneAgent = function()
    local agent_sceneCamera = SceneGetCamera(KTBM_Development_SceneObject);
    local vector_cursorPosition = CursorGetPos();

    --VectorDistance

    --Get all of the agents in the scene
    local table_agentsInScene = SceneGetAgents(KTBM_Development_SceneObject);

    --Iterate through all of the agents in the scene to determine which one we will select
    for index1, agent_sceneAgent in ipairs(table_agentsInScene) do
        --get the state of whether or not the agent is under our main cursor
        local bool_isNewAgentUnderCursor = AgentIsUnderCursor(agent_sceneAgent);

        local string_newAgentName = AgentGetName(agent_sceneAgent);
        local bool_isSelectable = true;

        for index2, string_dontSelectAgentName in ipairs(KTBM_Development_TransformTool_DontSelect) do
            if(string_newAgentName == string_dontSelectAgentName) then
                bool_isSelectable = false;
            end
        end

        --check if the agent is actually under our main cursor
        if(bool_isNewAgentUnderCursor == true) and (bool_isSelectable == true) then

            --if we don't have an agent selected then lets select this one.
            if(agent_currentSelectedAgent == nil) then
                agent_currentSelectedAgent = agent_sceneAgent;
                --ShaderOverrideAllTextures(agent_currentSelectedAgent, "color_fFFFFF.d3dtx");

            --if we already have an agent selection...
            elseif(agent_currentSelectedAgent ~= nil) then

                --if our current selected agent is not the same as the current agent element we are checking...
                if(agent_currentSelectedAgent ~= agent_sceneAgent) then

                    --local vector_newAgentSelectionCenter = AgentGetSelectionCenter(agent_sceneAgent);
                    --local vector_currentAgentSelectionCenter = AgentGetSelectionCenter(agent_currentSelectedAgent);
                    --local vector_newAgentSelectionCenter = AgentGetWorldPos(agent_sceneAgent);
                    --local vector_currentAgentSelectionCenter = AgentGetWorldPos(agent_currentSelectedAgent);

                    --local vector_newAgentSelectionCenterScreenPosition = CameraGetScreenPosFromWorldPos(agent_sceneCamera, vector_newAgentSelectionCenter);
                    --local vector_currentAgentSelectionCenterScreenPosition = CameraGetScreenPosFromWorldPos(agent_sceneCamera, vector_currentAgentSelectionCenter);
    
                    --local number_distanceCheckToNewAgent = VectorDistance(vector_cursorPosition, vector_newAgentSelectionCenterScreenPosition);
                    --local number_distanceCheckToCurrentAgent = VectorDistance(vector_cursorPosition, vector_currentAgentSelectionCenterScreenPosition);

                    --if(number_distanceCheckToNewAgent < number_distanceCheckToCurrentAgent) then
                        --ShaderRestoreAllTextures(agent_currentSelectedAgent);
                        agent_currentSelectedAgent = agent_sceneAgent;
                        --ShaderOverrideAllTextures(agent_currentSelectedAgent, "color_fFFFFF.d3dtx");
                    --end
                --else
                    --agent_currentSelectedAgent = agent_sceneAgent;
                    --ShaderOverrideAllTextures(agent_currentSelectedAgent, "color_fFFFFF.d3dtx");
                end

            end
        end
    end

    local bool_isCurrentSelectedAgentUnderCursor = AgentIsUnderCursor(agent_currentSelectedAgent);

    if(bool_isCurrentSelectedAgentUnderCursor == false) then
        --ShaderRestoreAllTextures(agent_currentSelectedAgent);
        agent_currentSelectedAgent = nil;
    end
end

local HoverSceneAgent = function()
    local agent_sceneCamera = SceneGetCamera(KTBM_Development_SceneObject);
    local vector_cursorPosition = CursorGetPos();

    --VectorDistance

    --Get all of the agents in the scene
    local table_agentsInScene = SceneGetAgents(KTBM_Development_SceneObject);

    --Iterate through all of the agents in the scene to determine which one we will select
    for index1, agent_sceneAgent in ipairs(table_agentsInScene) do
        --get the state of whether or not the agent is under our main cursor
        local bool_isNewAgentUnderCursor = AgentIsUnderCursor(agent_sceneAgent);

        local string_newAgentName = AgentGetName(agent_sceneAgent);
        local bool_isSelectable = true;

        for index2, string_dontSelectAgentName in ipairs(KTBM_Development_TransformTool_DontSelect) do
            if(string_newAgentName == string_dontSelectAgentName) then
                bool_isSelectable = false;
            end
        end

        --check if the agent is actually under our main cursor
        if(bool_isNewAgentUnderCursor == true) and (bool_isSelectable == true) then

            --if we don't have an agent selected then lets select this one.
            if(agent_currentHoverAgent == nil) then
                agent_currentHoverAgent = agent_sceneAgent;

            --if we already have an agent selection...
            elseif(agent_currentHoverAgent ~= nil) then

                --if our current selected agent is not the same as the current agent element we are checking...
                if(agent_currentHoverAgent ~= agent_sceneAgent) then

                    --local vector_newAgentSelectionCenter = AgentGetSelectionCenter(agent_sceneAgent);
                    --local vector_currentAgentSelectionCenter = AgentGetSelectionCenter(agent_currentHoverAgent);
                    --local vector_newAgentSelectionCenter = AgentGetWorldPos(agent_sceneAgent);
                    --local vector_currentAgentSelectionCenter = AgentGetWorldPos(agent_currentHoverAgent);

                    --local vector_newAgentSelectionCenterScreenPosition = CameraGetScreenPosFromWorldPos(agent_sceneCamera, vector_newAgentSelectionCenter);
                    --local vector_currentAgentSelectionCenterScreenPosition = CameraGetScreenPosFromWorldPos(agent_sceneCamera, vector_currentAgentSelectionCenter);
    
                    --local number_distanceCheckToNewAgent = VectorDistance(vector_cursorPosition, vector_newAgentSelectionCenterScreenPosition);
                    --local number_distanceCheckToCurrentAgent = VectorDistance(vector_cursorPosition, vector_currentAgentSelectionCenterScreenPosition);

                    --if(number_distanceCheckToNewAgent < number_distanceCheckToCurrentAgent) then
                        agent_currentHoverAgent = agent_sceneAgent;
                    --end
                --else
                    --agent_currentHoverAgent = agent_sceneAgent;
                end

            end
        end
    end

    local bool_isCurrentSelectedAgentUnderCursor = AgentIsUnderCursor(agent_currentHoverAgent);

    if(bool_isCurrentSelectedAgentUnderCursor == false) then
        agent_currentHoverAgent = nil;
    end
end

KTBM_Development_TransformTool_Update = function()  
    --||||||||||||||||||||||||||||||||||||| AGENT SELECTION |||||||||||||||||||||||||||||||||||||
    --||||||||||||||||||||||||||||||||||||| AGENT SELECTION |||||||||||||||||||||||||||||||||||||
    --||||||||||||||||||||||||||||||||||||| AGENT SELECTION |||||||||||||||||||||||||||||||||||||
    --In here is the main logic for finding the agent to be selected in the scene.
    --The telltale lua API does have functions for this, however the most obvious ones don't seem to work.
    --So we have to make our own here.

    if(KTBM_Development_SceneCamera_Frozen == true) and (KTBM_Development_TransformTool_GizmoHoveringOverAxis == false) then
        HoverSceneAgent();

        if(KTBM_Development_Editor_Input_LeftMouseClicked == true) then
            SelectSceneAgent();
        end
    else
        agent_currentHoverAgent = nil;
    end

    --||||||||||||||||||||||||||||||||||||| TEXT HANDLING |||||||||||||||||||||||||||||||||||||
    --||||||||||||||||||||||||||||||||||||| TEXT HANDLING |||||||||||||||||||||||||||||||||||||
    --||||||||||||||||||||||||||||||||||||| TEXT HANDLING |||||||||||||||||||||||||||||||||||||
    KTBM_Development_TransformTool_UpdateGizmo();

    local string_finalText = "";

    if(agent_currentSelectedAgent ~= nil) then
        local vector_agentPosition = AgentGetWorldPos(agent_currentSelectedAgent);
        local vector_agentRotation = AgentGetWorldRot(agent_currentSelectedAgent);

        string_finalText = string_finalText .. AgentGetName(agent_currentSelectedAgent);
        string_finalText = string_finalText .. "\n"; --new line

        string_finalText = string_finalText .. KTBM_VectorToString(vector_agentPosition);
        string_finalText = string_finalText .. "\n"; --new line

        string_finalText = string_finalText .. KTBM_VectorToString(vector_agentRotation);
        string_finalText = string_finalText .. "\n"; --new line

        --string_finalText = string_finalText .. KTBM_VectorToString(CameraGetScreenPosFromWorldPos(SceneGetCamera(KTBM_Development_SceneObject), AgentLocalToWorld(KTBM_Development_TransformTool_GizmoGroup, Vector(0, 0, 0))));
        --string_finalText = string_finalText .. KTBM_VectorToString(CursorGetPos());
        --string_finalText = string_finalText .. tostring(VectorDistance(CameraGetScreenPosFromWorldPos(SceneGetCamera(KTBM_Development_SceneObject), AgentLocalToWorld(KTBM_Development_TransformTool_GizmoGroup, Vector(0, 0, 0))), CursorGetPos()));
        --string_finalText = string_finalText .. tostring(VectorDistance(CameraGetScreenPosFromWorldPos(SceneGetCamera(KTBM_Development_SceneObject), AgentGetWorldPos(KTBM_Development_TransformTool_GizmoGroup)), CursorGetPos()));
        --string_finalText = string_finalText .. "\n"; --new line
        --string_finalText = string_finalText .. tostring(VectorDistance(KTBM_VectorMultiply(CameraGetScreenPosFromWorldPos(SceneGetCamera(KTBM_Development_SceneObject), AgentLocalToWorld(KTBM_Development_TransformTool_GizmoGroup, Vector(0, 0, 0))), CursorGetPos(), Vector(1, 1, 0))));

        AgentSetWorldPos(KTBM_Development_TransformTool_Text, boundsAABB_currentSelectedAgentWorldBounds["center"]);
    else
        string_finalText = "O";

        --screen pos notes
        --0.0 0.0 0.0 = top left
        --0.5 0.5 0.0 = center
        --0.0 1.0 0.0 = bottom left
        local screenPos = Vector(0.5, 0.5, 0.0);
        AgentSetWorldPosFromLogicalScreenPos(KTBM_Development_TransformTool_Text, screenPos);
    end

    TextSet(KTBM_Development_TransformTool_Text, string_finalText);
end