--KTBM_Development_SceneObject
--KTBM_Development_SceneObjectAgentName
--KTBM_Development_UseSeasonOneAPI
--KTBM_Development_SceneCameraUseFOVScale

KTBM_Development_SceneCamera_InputHorizontalValue = 0;
KTBM_Development_SceneCamera_InputVerticalValue = 0;
KTBM_Development_SceneCamera_InputHeightValue = 0;
KTBM_Development_SceneCamera_PrevCamPos = Vector(0,0,0);
KTBM_Development_SceneCamera_PrevCamRot = Vector(0,0,0);
KTBM_Development_SceneCamera_PrevCursorPos = Vector(0,0,0);
KTBM_Development_SceneCamera_InputMouseAmountX = 0;
KTBM_Development_SceneCamera_InputMouseAmountY = 0;
KTBM_Development_SceneCamera_InputFieldOfViewAmount = 100;
KTBM_Development_SceneCamera_PrevTime = 0;
KTBM_Development_SceneCamera_Frozen = false;
KTBM_Development_SceneCamera_CameraName = "DevelopmentSceneCamera";
KTBM_Development_SceneCamera_Camera = nil;

--user configruable
KTBM_Development_SceneCamera_SnappyMovement = false;
KTBM_Development_SceneCamera_SnappyRotation = true;
KTBM_Development_SceneCamera_PositionLerpFactor = 5.0;
KTBM_Development_SceneCamera_RotationLerpFactor = 7.5;
KTBM_Development_SceneCamera_PositionIncrementDefault = 0.025;
KTBM_Development_SceneCamera_PositionIncrementShift = 0.25;
KTBM_Development_SceneCamera_FovIncrement = 0.5;

--input workaround because S1 has different API
local KTBM_InputKeyPress = function(keyCode)
    if(KTBM_Development_UseSeasonOneAPI == true) then
        return Input_IsPressed(keyCode);
    else
        return Input_IsVKeyPressed(keyCode);
    end
end

KTBM_Development_CreateSceneCamera = function()
    KTBM_Development_SceneCamera_Camera = AgentCreate(KTBM_Development_SceneCamera_CameraName, "module_camera.prop", Vector(0,0,0), Vector(90,0,0), KTBM_Development_SceneObject, false, false)
    KTBM_PropertySet(KTBM_Development_SceneCamera_Camera, "Clip Plane - Far", 2500);
    KTBM_PropertySet(KTBM_Development_SceneCamera_Camera, "Clip Plane - Near", 0.05);
    KTBM_PropertySet(KTBM_Development_SceneCamera_Camera, "Lens - Current Lens", nil);

    KTBM_RemovingAgentsWithPrefix(KTBM_Development_SceneObject, "cam_");

    CameraPush(KTBM_Development_SceneCamera_CameraName);
end

KTBM_Development_UpdateSceneCamera = function()
    local number_frameTime = GetFrameTime();

    --freecamera freezing
    if(KTBM_InputKeyPress(KTBM_Keycodes_RightMouse)) then
        KTBM_Development_SceneCamera_Frozen = false;
    else
        KTBM_Development_SceneCamera_Frozen = true;
    end

    --hide/show the cursor
    if(KTBM_Development_SceneCamera_Frozen == true) then
        CursorHide(false);
        CursorEnable(true);

        KTBM_Development_SceneCamera_InputHeightValue = 0;
        KTBM_Development_SceneCamera_InputVerticalValue = 0;

        return
    else
        CursorHide(true);
        CursorEnable(true);
    end

    ------------------------------MOVEMENT------------------------------
    local number_positionIncrement = KTBM_Development_SceneCamera_PositionIncrementDefault;
    
    if(KTBM_InputKeyPress(KTBM_Keycodes_LeftShift)) then
        number_positionIncrement = KTBM_Development_SceneCamera_PositionIncrementShift;
    end
    
    if(KTBM_InputKeyPress(KTBM_Keycodes_Q)) then
        KTBM_Development_SceneCamera_InputHeightValue = -number_positionIncrement;
    elseif(KTBM_InputKeyPress(KTBM_Keycodes_E)) then
        KTBM_Development_SceneCamera_InputHeightValue = number_positionIncrement;
    else
        KTBM_Development_SceneCamera_InputHeightValue = 0;
    end
    
    if(KTBM_InputKeyPress(KTBM_Keycodes_W)) then
        KTBM_Development_SceneCamera_InputVerticalValue = number_positionIncrement;
    elseif(KTBM_InputKeyPress(KTBM_Keycodes_S)) then
        KTBM_Development_SceneCamera_InputVerticalValue = -number_positionIncrement;
    else
        KTBM_Development_SceneCamera_InputVerticalValue = 0;
    end
    
    if(KTBM_InputKeyPress(KTBM_Keycodes_A)) then
        KTBM_Development_SceneCamera_InputHorizontalValue = number_positionIncrement;
    elseif(KTBM_InputKeyPress(KTBM_Keycodes_D)) then
        KTBM_Development_SceneCamera_InputHorizontalValue = -number_positionIncrement;
    else
        KTBM_Development_SceneCamera_InputHorizontalValue = 0;
    end

    ------------------------------MOUSELOOK------------------------------
    local vector_cursorPos = CursorGetPos();
    
    local number_minThreshold = 0.01;
    local number_maxThreshold = 0.99;
    
    --reset the cursor pos to the center of the screen when they get near the edges of the screen
    if(vector_cursorPos.x > number_maxThreshold) or (vector_cursorPos.x < number_minThreshold) or (vector_cursorPos.y > number_maxThreshold) or (vector_cursorPos.y < number_minThreshold) then
        CursorSetPos(Vector(0.5, 0.5, 0));
    end
    
    local vector_cursorDifference = Vector(vector_cursorPos.x - KTBM_Development_SceneCamera_PrevCursorPos.x, vector_cursorPos.y - KTBM_Development_SceneCamera_PrevCursorPos.y, 0);
    
    local number_sensitivity = 180.0;
    KTBM_Development_SceneCamera_InputMouseAmountX = KTBM_Development_SceneCamera_InputMouseAmountX - (vector_cursorDifference.x * number_sensitivity);
    KTBM_Development_SceneCamera_InputMouseAmountY = KTBM_Development_SceneCamera_InputMouseAmountY + (vector_cursorDifference.y * number_sensitivity);

    local vector_newRotation = Vector(KTBM_Development_SceneCamera_InputMouseAmountY - 90, KTBM_Development_SceneCamera_InputMouseAmountX, 0);
    
    if(vector_newRotation.x > 90) then
        vector_newRotation.x = 90;
    elseif(vector_newRotation.x < -90) then
        vector_newRotation.x = -90;
    end
    
    ------------------------------BUILD FINAL MOVEMENT/ROTATION------------------------------
    local vector_newPosition = Vector(KTBM_Development_SceneCamera_InputHorizontalValue, KTBM_Development_SceneCamera_InputHeightValue, KTBM_Development_SceneCamera_InputVerticalValue);

    if(KTBM_Development_SceneCamera_SnappyMovement == true) then
        KTBM_Development_SceneCamera_PrevCamPos = vector_newPosition;
    else
        KTBM_Development_SceneCamera_PrevCamPos = KTBM_VectorLerp(KTBM_Development_SceneCamera_PrevCamPos, vector_newPosition, number_frameTime * KTBM_Development_SceneCamera_PositionLerpFactor);
    end
    
    if(KTBM_Development_SceneCamera_SnappyRotation == true) then
        KTBM_Development_SceneCamera_PrevCamRot = vector_newRotation;
    else
        KTBM_Development_SceneCamera_PrevCamRot = KTBM_VectorLerp(KTBM_Development_SceneCamera_PrevCamRot, vector_newRotation, number_frameTime * KTBM_Development_SceneCamera_RotationLerpFactor);
    end
    
    ------------------------------ASSIGNMENT------------------------------
    local vector_cameraPosition = AgentLocalToWorld(KTBM_Development_SceneCamera_Camera, KTBM_Development_SceneCamera_PrevCamPos);
    
    AgentSetWorldPos(KTBM_Development_SceneCamera_Camera, vector_cameraPosition);
    AgentSetWorldRot(KTBM_Development_SceneCamera_Camera, KTBM_Development_SceneCamera_PrevCamRot);

    if(KTBM_Development_SceneCameraUseFOVScale == true) then
        local number_fovScale = KTBM_Development_SceneCamera_InputFieldOfViewAmount / 50.0;

        KTBM_PropertySet(KTBM_Development_SceneCamera_Camera, "Field of View Scale", number_fovScale);
    else
        KTBM_PropertySet(KTBM_Development_SceneCamera_Camera, "Field of View", KTBM_Development_SceneCamera_InputFieldOfViewAmount);
    end

    KTBM_Development_SceneCamera_PrevCursorPos = CursorGetPos();
    KTBM_Development_SceneCamera_PrevTime = GetFrameTime();
end