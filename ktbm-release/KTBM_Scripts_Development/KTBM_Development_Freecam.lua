--[[
Custom Development Tools/Functions script

THIS SCRIPT IS FOR HANDLING FREECAM

This script also uses functions from the following lua scripts...
- KTBM_AgentExtensions.lua
- KTBM_Printing.lua

WHEN IMPLEMENTING THIS INTO A LEVEL, YOU MUST DO THE FOLLOWING...

1. At the top of the script, you must have a variable that is named
- KTBM_Development_SceneObject
This will just simply contain a reference to the kScene variable so the function can reference object from the scene.

2. At the top of the script, you must have a variable that is named
- KTBM_Development_SceneObjectAgentName
This will just simply contain a reference to the scene agent name.

3. In the main function of the level script you call this function before step 2
KTBM_Development_CreateFreeCamera()

4. Lastly, also in the main function of the level script you add the functionality like so...

Callback_OnPostUpdate:Add(KTBM_Development_UpdateFreeCamera)
]]--

--KTBM_Development_SceneObject
--KTBM_Development_SceneObjectAgentName
--KTBM_Development_UseSeasonOneAPI
--KTBM_Development_FreecamUseFOVScale

--(public) cutscene dev freecam variables (public because these values need to be persistent)
KTBM_Development_Freecam_InputHorizontalValue = 0;
KTBM_Development_Freecam_InputVerticalValue = 0;
KTBM_Development_Freecam_InputHeightValue = 0;
KTBM_Development_Freecam_PrevCamPos = Vector(0,0,0);
KTBM_Development_Freecam_PrevCamRot = Vector(0,0,0);
KTBM_Development_Freecam_PrevCursorPos = Vector(0,0,0);
KTBM_Development_Freecam_InputMouseAmountX = 0;
KTBM_Development_Freecam_InputMouseAmountY = 0;
KTBM_Development_Freecam_InputFieldOfViewAmount = 100;
KTBM_Development_Freecam_PrevTime = 0;
KTBM_Development_Freecam_Frozen = false;
KTBM_Development_Freecam_CameraName = "DevelopmentFreecamera";
KTBM_Development_Freecam_Camera = nil;

--user configruable
KTBM_Development_Freecam_SnappyMovement = false;
KTBM_Development_Freecam_SnappyRotation = true;
KTBM_Development_Freecam_PositionLerpFactor = 5.0;
KTBM_Development_Freecam_RotationLerpFactor = 7.5;
KTBM_Development_Freecam_PositionIncrementDefault = 0.025;
KTBM_Development_Freecam_PositionIncrementShift = 0.25;
KTBM_Development_Freecam_FovIncrement = 0.5;

--input workaround because S1 has different API
local KTBM_InputKeyPress = function(keyCode)
    if(KTBM_Development_UseSeasonOneAPI == true) then
        return Input_IsPressed(keyCode);
    else
        return Input_IsVKeyPressed(keyCode);
    end
end

KTBM_Development_CreateFreeCamera = function()
    KTBM_Development_Freecam_Camera = AgentCreate(KTBM_Development_Freecam_CameraName, "module_camera.prop", Vector(0,0,0), Vector(90,0,0), KTBM_Development_SceneObject, false, false);
    KTBM_PropertySet(KTBM_Development_Freecam_Camera, "Clip Plane - Far", 2500);
    KTBM_PropertySet(KTBM_Development_Freecam_Camera, "Clip Plane - Near", 0.05);
    KTBM_PropertySet(KTBM_Development_Freecam_Camera, "Lens - Current Lens", nil);

    KTBM_RemovingAgentsWithPrefix(KTBM_Development_SceneObject, "cam_");

    CameraPush(KTBM_Development_Freecam_CameraName);
end

KTBM_Development_UpdateFreeCamera = function()
    local number_frameTime = GetFrameTime();

    --freecamera freezing
    if(KTBM_InputKeyPress(KTBM_Keycodes_R)) then
        KTBM_Development_Freecam_Frozen = false;
    elseif(KTBM_InputKeyPress(KTBM_Keycodes_F)) then
        KTBM_Development_Freecam_Frozen = true;
    end

    --freecamera freezing
    if(KTBM_InputKeyPress(KTBM_Keycodes_RightMouse)) then
        KTBM_Development_Freecam_Frozen = false;
    else
        KTBM_Development_Freecam_Frozen = true;
    end

    --hide/show the cursor
    if(KTBM_Development_Freecam_Frozen == true) then
        CursorHide(false);
        CursorEnable(true);

        KTBM_Development_Freecam_InputHeightValue = 0;
        KTBM_Development_Freecam_InputVerticalValue = 0;

        return
    else
        CursorHide(true);
        CursorEnable(true);
    end

    ------------------------------MOVEMENT------------------------------
    local number_positionIncrement = KTBM_Development_Freecam_PositionIncrementDefault;
    
    if(KTBM_InputKeyPress(KTBM_Keycodes_LeftShift)) then
        number_positionIncrement = KTBM_Development_Freecam_PositionIncrementShift;
    end
    
    if(KTBM_InputKeyPress(KTBM_Keycodes_Q)) then
        KTBM_Development_Freecam_InputHeightValue = -number_positionIncrement;
    elseif(KTBM_InputKeyPress(KTBM_Keycodes_E)) then
        KTBM_Development_Freecam_InputHeightValue = number_positionIncrement;
    else
        KTBM_Development_Freecam_InputHeightValue = 0;
    end
    
    if(KTBM_InputKeyPress(KTBM_Keycodes_W)) then
        KTBM_Development_Freecam_InputVerticalValue = number_positionIncrement;
    elseif(KTBM_InputKeyPress(KTBM_Keycodes_S)) then
        KTBM_Development_Freecam_InputVerticalValue = -number_positionIncrement;
    else
        KTBM_Development_Freecam_InputVerticalValue = 0;
    end
    
    if(KTBM_InputKeyPress(KTBM_Keycodes_A)) then
        KTBM_Development_Freecam_InputHorizontalValue = number_positionIncrement;
    elseif(KTBM_InputKeyPress(KTBM_Keycodes_D)) then
        KTBM_Development_Freecam_InputHorizontalValue = -number_positionIncrement;
    else
        KTBM_Development_Freecam_InputHorizontalValue = 0;
    end
    
    ------------------------------ZOOMING------------------------------
    local number_fovIncrement = KTBM_Development_Freecam_FovIncrement;
    
    if(KTBM_InputKeyPress(KTBM_Keycodes_LeftMouse)) then
        KTBM_Development_Freecam_InputFieldOfViewAmount = KTBM_Development_Freecam_InputFieldOfViewAmount - number_fovIncrement;
    elseif(KTBM_InputKeyPress(KTBM_Keycodes_RightMouse)) then
        KTBM_Development_Freecam_InputFieldOfViewAmount = KTBM_Development_Freecam_InputFieldOfViewAmount + number_fovIncrement;
    end
    
    ------------------------------MOUSELOOK------------------------------
    local vector_cursorPos = CursorGetPos();
    
    local number_minThreshold = 0.01;
    local number_maxThreshold = 0.99;
    
    --reset the cursor pos to the center of the screen when they get near the edges of the screen
    if(vector_cursorPos.x > number_maxThreshold) or (vector_cursorPos.x < number_minThreshold) or (vector_cursorPos.y > number_maxThreshold) or (vector_cursorPos.y < number_minThreshold) then
        CursorSetPos(Vector(0.5, 0.5, 0));
    end
    
    local vector_cursorDifference = Vector(vector_cursorPos.x - KTBM_Development_Freecam_PrevCursorPos.x, vector_cursorPos.y - KTBM_Development_Freecam_PrevCursorPos.y, 0);
    
    local number_sensitivity = 180.0;
    KTBM_Development_Freecam_InputMouseAmountX = KTBM_Development_Freecam_InputMouseAmountX - (vector_cursorDifference.x * number_sensitivity);
    KTBM_Development_Freecam_InputMouseAmountY = KTBM_Development_Freecam_InputMouseAmountY + (vector_cursorDifference.y * number_sensitivity);

    local vector_newRotation = Vector(KTBM_Development_Freecam_InputMouseAmountY - 90, KTBM_Development_Freecam_InputMouseAmountX, 0);
    
    if(vector_newRotation.x > 90) then
        vector_newRotation.x = 90;
    elseif(vector_newRotation.x < -90) then
        vector_newRotation.x = -90;
    end
    
    ------------------------------BUILD FINAL MOVEMENT/ROTATION------------------------------
    local vector_newPosition = Vector(KTBM_Development_Freecam_InputHorizontalValue, KTBM_Development_Freecam_InputHeightValue, KTBM_Development_Freecam_InputVerticalValue);

    if(KTBM_Development_Freecam_SnappyMovement == true) then
        KTBM_Development_Freecam_PrevCamPos = vector_newPosition;
    else
        KTBM_Development_Freecam_PrevCamPos = KTBM_VectorLerp(KTBM_Development_Freecam_PrevCamPos, vector_newPosition, number_frameTime * KTBM_Development_Freecam_PositionLerpFactor);
    end
    
    if(KTBM_Development_Freecam_SnappyRotation == true) then
        KTBM_Development_Freecam_PrevCamRot = newRotation;
    else
        KTBM_Development_Freecam_PrevCamRot = KTBM_VectorLerp(KTBM_Development_Freecam_PrevCamRot, newRotation, number_frameTime * KTBM_Development_Freecam_RotationLerpFactor);
    end
    
    ------------------------------ASSIGNMENT------------------------------
    local vector_cameraPosition = AgentLocalToWorld(KTBM_Development_Freecam_Camera, KTBM_Development_Freecam_PrevCamPos);
    
    AgentSetWorldPos(KTBM_Development_Freecam_Camera, vector_cameraPosition, KTBM_Development_SceneObject);
    AgentSetWorldRot(KTBM_Development_Freecam_Camera, KTBM_Development_Freecam_PrevCamRot, KTBM_Development_SceneObject);

    if(KTBM_Development_FreecamUseFOVScale == true) then
        local number_fovScale = KTBM_Development_Freecam_InputFieldOfViewAmount / 50.0;

        KTBM_PropertySet(KTBM_Development_Freecam_Camera, "Field of View Scale", number_fovScale);
    else
        KTBM_PropertySet(KTBM_Development_Freecam_Camera, "Field of View", KTBM_Development_Freecam_InputFieldOfViewAmount);
    end

    KTBM_Development_Freecam_PrevCursorPos = CursorGetPos();
    KTBM_Development_Freecam_PrevTime = GetFrameTime();
end