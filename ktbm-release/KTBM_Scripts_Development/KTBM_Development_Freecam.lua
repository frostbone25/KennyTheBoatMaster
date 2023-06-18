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
KTBM_Development_Freecam_InputFieldOfViewAmount = 90;
KTBM_Development_Freecam_PrevTime = 0;
KTBM_Development_Freecam_Frozen = false;
KTBM_Development_Freecam_CameraName = "myNewFreecamera";

--user configruable
KTBM_Development_Freecam_SnappyMovement = false;
KTBM_Development_Freecam_SnappyRotation = false;
KTBM_Development_Freecam_PositionLerpFactor = 5.0;
KTBM_Development_Freecam_RotationLerpFactor = 7.5;
KTBM_Development_Freecam_PositionIncrementDefault = 0.025;
KTBM_Development_Freecam_PositionIncrementShift = 0.25;
KTBM_Development_Freecam_FovIncrement = 0.5;

--input workaround because S1 has different API
local KTBM_InputKeyPress = function(keyCode)
    if (KTBM_Development_UseSeasonOneAPI == true) then
        return Input_IsPressed(keyCode);
    else
        return Input_IsVKeyPressed(keyCode);
    end
end

KTBM_Development_CreateFreeCamera = function()
    local cam_prop = "module_camera.prop"
    
    local newPosition = Vector(0,0,0)
    local newRotation = Vector(90,0,0)
    
    local cameraAgent = AgentCreate(KTBM_Development_Freecam_CameraName, cam_prop, newPosition, newRotation, KTBM_Development_SceneObject, false, false)
    
    KTBM_AgentSetProperty(KTBM_Development_Freecam_CameraName, "Clip Plane - Far", 2500, KTBM_Development_SceneObject)
    KTBM_AgentSetProperty(KTBM_Development_Freecam_CameraName, "Clip Plane - Near", 0.05, KTBM_Development_SceneObject)
    KTBM_AgentSetProperty(KTBM_Development_Freecam_CameraName, "Lens - Current Lens", nil, KTBM_Development_SceneObject)

    KTBM_RemovingAgentsWithPrefix(KTBM_Development_SceneObject, "cam_")

    CameraPush(KTBM_Development_Freecam_CameraName);
end

KTBM_Development_UpdateFreeCamera = function()
    local currFrameTime = GetFrameTime();

    --freecamera freezing
    if KTBM_InputKeyPress(82) then
        --R key
        KTBM_Development_Freecam_Frozen = false;
    elseif KTBM_InputKeyPress(70) then
        --F key
        KTBM_Development_Freecam_Frozen = true;
    end

    --hide/show the cursor
    if (KTBM_Development_Freecam_Frozen == true) then
        CursorHide(false);
        CursorEnable(true);
        do return end --don't conitnue with the rest of the function
    else
        CursorHide(true);
        CursorEnable(true);
    end

    ------------------------------MOVEMENT------------------------------
    local positionIncrement = KTBM_Development_Freecam_PositionIncrementDefault;
    
    if KTBM_InputKeyPress(16) then
        --key shift
        positionIncrement = KTBM_Development_Freecam_PositionIncrementShift;
    end
    
    if KTBM_InputKeyPress(81) then
        --key q (decrease)
        KTBM_Development_Freecam_InputHeightValue = -positionIncrement;
    elseif KTBM_InputKeyPress(69) then
        --key e (increase)
        KTBM_Development_Freecam_InputHeightValue = positionIncrement;
    else
        KTBM_Development_Freecam_InputHeightValue = 0;
    end
    
    if KTBM_InputKeyPress(87) then
        --key w (increase)
        KTBM_Development_Freecam_InputVerticalValue = positionIncrement;
    elseif KTBM_InputKeyPress(83) then
        --key s (decrease)
        KTBM_Development_Freecam_InputVerticalValue = -positionIncrement;
    else
        KTBM_Development_Freecam_InputVerticalValue = 0;
    end
    
    if KTBM_InputKeyPress(65) then
        --key a (decrease)
        KTBM_Development_Freecam_InputHorizontalValue = positionIncrement;
    elseif KTBM_InputKeyPress(68) then
        --key d (increase)
        KTBM_Development_Freecam_InputHorizontalValue = -positionIncrement;
    else
        KTBM_Development_Freecam_InputHorizontalValue = 0;
    end
    
    ------------------------------ZOOMING------------------------------
    local fovIncrement = KTBM_Development_Freecam_FovIncrement
    
    if KTBM_InputKeyPress(1) then
        --left mouse (decrease)
        KTBM_Development_Freecam_InputFieldOfViewAmount = KTBM_Development_Freecam_InputFieldOfViewAmount - fovIncrement;
    elseif KTBM_InputKeyPress(2) then
        --right mouse (increase)
        KTBM_Development_Freecam_InputFieldOfViewAmount = KTBM_Development_Freecam_InputFieldOfViewAmount + fovIncrement;
    end
    
    ------------------------------MOUSELOOK------------------------------
    local currCursorPos = CursorGetPos()
    
    local minThreshold = 0.01
    local maxThreshold = 0.99
    
    --reset the cursor pos to the center of the screen when they get near the edges of the screen
    if (currCursorPos.x > maxThreshold) or (currCursorPos.x < minThreshold) or (currCursorPos.y > maxThreshold) or (currCursorPos.y < minThreshold) then
        CursorSetPos(Vector(0.5, 0.5, 0));
    end
    
    local xCursorDifference = currCursorPos.x - KTBM_Development_Freecam_PrevCursorPos.x
    local yCursorDifference = currCursorPos.y - KTBM_Development_Freecam_PrevCursorPos.y
    
    local sensitivity = 180.0
    KTBM_Development_Freecam_InputMouseAmountX = KTBM_Development_Freecam_InputMouseAmountX - (xCursorDifference * sensitivity)
    KTBM_Development_Freecam_InputMouseAmountY = KTBM_Development_Freecam_InputMouseAmountY + (yCursorDifference * sensitivity)

    local newRotation = Vector(KTBM_Development_Freecam_InputMouseAmountY - 90, KTBM_Development_Freecam_InputMouseAmountX, 0);
    
    if newRotation.x > 90 then
        newRotation.x = 90;
    elseif newRotation.x < -90 then
        newRotation.x = -90;
    end
    
    ------------------------------BUILD FINAL MOVEMENT/ROTATION------------------------------
    local newPosition = Vector(KTBM_Development_Freecam_InputHorizontalValue, KTBM_Development_Freecam_InputHeightValue, KTBM_Development_Freecam_InputVerticalValue);

    if (KTBM_Development_Freecam_SnappyMovement == true) then
        KTBM_Development_Freecam_PrevCamPos = newPosition;
    else
        KTBM_Development_Freecam_PrevCamPos = KTBM_VectorLerp(KTBM_Development_Freecam_PrevCamPos, newPosition, currFrameTime * KTBM_Development_Freecam_PositionLerpFactor);
    end
    
    if (KTBM_Development_Freecam_SnappyRotation == true) then
        KTBM_Development_Freecam_PrevCamRot = newRotation;
    else
        KTBM_Development_Freecam_PrevCamRot = KTBM_VectorLerp(KTBM_Development_Freecam_PrevCamRot, newRotation, currFrameTime * KTBM_Development_Freecam_RotationLerpFactor);
    end
    
    ------------------------------ASSIGNMENT------------------------------
    local myCameraAgent = AgentFindInScene(KTBM_Development_Freecam_CameraName, KTBM_Development_SceneObject); --Agent type
    local result = AgentLocalToWorld(myCameraAgent, KTBM_Development_Freecam_PrevCamPos);
    
    KTBM_SetAgentPosition(KTBM_Development_Freecam_CameraName, result, KTBM_Development_SceneObject)
    KTBM_SetAgentRotation(KTBM_Development_Freecam_CameraName, KTBM_Development_Freecam_PrevCamRot, KTBM_Development_SceneObject)

    if (KTBM_Development_FreecamUseFOVScale == true) then
        local fovScale = KTBM_Development_Freecam_InputFieldOfViewAmount / 50.0;

        KTBM_AgentSetProperty(KTBM_Development_Freecam_CameraName, "Field of View Scale", fovScale, KTBM_Development_SceneObject);
    else
        KTBM_AgentSetProperty(KTBM_Development_Freecam_CameraName, "Field of View", KTBM_Development_Freecam_InputFieldOfViewAmount, KTBM_Development_SceneObject);
    end

    KTBM_Development_Freecam_PrevCursorPos = CursorGetPos();
    KTBM_Development_Freecam_PrevTime = GetFrameTime();
end