KTBM_Gameplay_Boat_DesiredPosition = Vector(0, KTBM_Gameplay_EnvironmentHeightOffset, 0);
KTBM_Gameplay_Boat_PreviousPosition = Vector(0, KTBM_Gameplay_EnvironmentHeightOffset, 0);

KTBM_Gameplay_Boat_DesiredRotation = Vector(0,0,0);
KTBM_Gameplay_Boat_PreviousRotation = Vector(0,0,0);

KTBM_Gameplay_Boat_PositionLerp = 1.0;
KTBM_Gameplay_Boat_RotationLerp = 1.5;

KTBM_Gameplay_Boat_CurrentBobbingValue = 0.0;
KTBM_Gameplay_Boat_BobbingAmount = 3.0;
KTBM_Gameplay_Boat_BobbingSpeed = 5.0;

KTBM_Gameplay_Camera_DesiredPosition = Vector(0, KTBM_Gameplay_EnvironmentHeightOffset, 0);
KTBM_Gameplay_Camera_PreviousPosition = Vector(0, KTBM_Gameplay_EnvironmentHeightOffset, 0);
KTBM_Gameplay_Camera_LerpFactor = 0.75;

KTBM_Gameplay_Camera_CurrentBobbingRotationValue = 0.0;
KTBM_Gameplay_Camera_BobbingRotationAmount = 0.5;
KTBM_Gameplay_Camera_BobbingRotationSpeed = 2.5;
KTBM_Gameplay_Camera_OriginalPosition = Vector(0.015348, KTBM_Gameplay_EnvironmentHeightOffset + 2.890892, -6.259110);
KTBM_Gameplay_Camera_OriginalRotation = Vector(11.499637, 0, 0);
KTBM_Gameplay_Camera_DesiredRotation = Vector(0, 0, 0);

KTBM_Gameplay_Camera_CurrentBobbingPositionValue = 0.0;
KTBM_Gameplay_Camera_BobbingPositionAmount = 0.25;
KTBM_Gameplay_Camera_BobbingPositionSpeed = 2.5;

KTBM_Gameplay_Input_CurrentHorizontalPositionValue = 0;
KTBM_Gameplay_Input_CurrentHorizontalRotationValue = 0;
KTBM_Gameplay_Input_IMAP_File = "KTBM_Gameplay_Input.imap";
KTBM_Gameplay_Input_MovementAxis = Vector(0, 0, 0);

--[[
Commented these IMAP functions out in favor of using a hardcoded one.
These still work and are bound in the .imap files however
I found that these generally aren't the best when it comes to movement.
They can feel rather sticky versus with the hardcoded movement where
we check for those input presses for every frame.

KTBM_Gameplay_Input_IMAP_Left_Begin = function()
    KTBM_Gameplay_Input_MovementAxis.x = 1;
end

KTBM_Gameplay_Input_IMAP_Left_End = function()
    if(KTBM_Gameplay_Input_MovementAxis > 0) then
        KTBM_Gameplay_Input_MovementAxis.x = 0;
    end
end

KTBM_Gameplay_Input_IMAP_Right_Begin = function()
    KTBM_Gameplay_Input_MovementAxis.x = -1;
end

KTBM_Gameplay_Input_IMAP_Right_End = function()
    if(KTBM_Gameplay_Input_MovementAxis < 0) then
        KTBM_Gameplay_Input_MovementAxis.x = 0;
    end
end

KTBM_Gameplay_Input_IMAP_SpeedBoost_Begin = function()
    KTBM_Gameplay_State_IsSpeeding = true;
end

KTBM_Gameplay_Input_IMAP_SpeedBoost_End = function()
    KTBM_Gameplay_State_IsSpeeding = false;
end
]]

KTBM_Gameplay_Input_IMAP_Pause_Begin = function()
    KTBM_Gameplay_State_Paused = not KTBM_Gameplay_State_Paused;
end

KTBM_Gameplay_PlayerInputUpdate = function()
    --get the frame time
    --when we do any operations we want to multiply them by the frame time so that they are consistent across machines.
    local number_deltaTime = GetFrameTime();

    --Disable player input whenever we have crashed.
    if(KTBM_Gameplay_State_HasCrashed == true) then
        KTBM_Gameplay_Input_CurrentHorizontalPositionValue = 0;
        KTBM_Gameplay_Input_CurrentHorizontalRotationValue = 0;

        return;
    end

    --|||||||||||||||||||||||||||| IMAP INPUT ||||||||||||||||||||||||||||
    --|||||||||||||||||||||||||||| IMAP INPUT ||||||||||||||||||||||||||||
    --|||||||||||||||||||||||||||| IMAP INPUT ||||||||||||||||||||||||||||
    --The older implementation, which uses Telltale's native Input Mapping (IMAP) system to handle input.
    --This does work, however these movement keys are pressed reguarly and on some events the controls
    --Can feel rather sticky and unresponsive, so instead opted for a hardcoded implementation
    --Where we have more control and can actually check for every single frame when a key
    --is active (versus with imap keys only fire events on the frame that they are pressed/released).

    --KTBM_Gameplay_Input_CurrentHorizontalPositionValue = KTBM_Gameplay_Input_MovementAxis.x * KTBM_Gameplay_BoatCurrentMovementSpeed * number_deltaTime;
    --KTBM_Gameplay_Input_CurrentHorizontalRotationValue = KTBM_Gameplay_Input_MovementAxis.x * KTBM_Gameplay_BoatCurrentMaxRotationAngle;

    --|||||||||||||||||||||||||||| HARDCODED INPUT ||||||||||||||||||||||||||||
    --|||||||||||||||||||||||||||| HARDCODED INPUT ||||||||||||||||||||||||||||
    --|||||||||||||||||||||||||||| HARDCODED INPUT ||||||||||||||||||||||||||||

    local bool_moveLeft = Input_IsVKeyPressed(KTBM_Core_Keycodes_A) or Input_IsVKeyPressed(KTBM_Core_Keycodes_LeftArrow);
    local bool_moveRight = Input_IsVKeyPressed(KTBM_Core_Keycodes_D) or Input_IsVKeyPressed(KTBM_Core_Keycodes_RightArrow);

    if bool_moveLeft then
        KTBM_Gameplay_Input_CurrentHorizontalPositionValue = KTBM_Gameplay_BoatCurrentMovementSpeed * number_deltaTime;
        KTBM_Gameplay_Input_CurrentHorizontalRotationValue = KTBM_Gameplay_BoatCurrentMaxRotationAngle;
    elseif bool_moveRight then
        KTBM_Gameplay_Input_CurrentHorizontalPositionValue = -KTBM_Gameplay_BoatCurrentMovementSpeed * number_deltaTime;
        KTBM_Gameplay_Input_CurrentHorizontalRotationValue = -KTBM_Gameplay_BoatCurrentMaxRotationAngle;
    else
        KTBM_Gameplay_Input_CurrentHorizontalPositionValue = 0;
        KTBM_Gameplay_Input_CurrentHorizontalRotationValue = 0;
    end

    KTBM_Gameplay_State_IsSpeeding = Input_IsVKeyPressed(160) or Input_IsVKeyPressed(161);

    if(KTBM_Gameplay_State_IsSpeeding == true) then
        --KTBM_Gameplay_BoatCurrentMovementSpeed = KTBM_Gameplay_SpeedBoostBoatMovementSpeed;
        --KTBM_Gameplay_BoatCurrentMaxRotationAngle = KTBM_Gameplay_BoatSpeedBoostMaxRotationAngle;
        KTBM_Gameplay_BoatCurrentMovementSpeed = KTBM_NumberLerp(KTBM_Gameplay_BoatCurrentMovementSpeed, KTBM_Gameplay_SpeedBoostBoatMovementSpeed, number_deltaTime * KTBM_Gameplay_SpeedBoostTransitionLerpFactor);
        KTBM_Gameplay_BoatCurrentMaxRotationAngle = KTBM_NumberLerp(KTBM_Gameplay_BoatCurrentMaxRotationAngle, KTBM_Gameplay_BoatSpeedBoostMaxRotationAngle, number_deltaTime * KTBM_Gameplay_SpeedBoostTransitionLerpFactor);
    else
        --KTBM_Gameplay_BoatCurrentMovementSpeed = KTBM_Gameplay_DefaultBoatMovementSpeed;
        --KTBM_Gameplay_BoatCurrentMaxRotationAngle = KTBM_Gameplay_BoatDefaultMaxRotationAngle;
        KTBM_Gameplay_BoatCurrentMovementSpeed = KTBM_NumberLerp(KTBM_Gameplay_BoatCurrentMovementSpeed, KTBM_Gameplay_DefaultBoatMovementSpeed, number_deltaTime * KTBM_Gameplay_SpeedBoostTransitionLerpFactor);
        KTBM_Gameplay_BoatCurrentMaxRotationAngle = KTBM_NumberLerp(KTBM_Gameplay_BoatCurrentMaxRotationAngle, KTBM_Gameplay_BoatDefaultMaxRotationAngle, number_deltaTime * KTBM_Gameplay_SpeedBoostTransitionLerpFactor);
    end
end

KTBM_Gameplay_Player_CreateGameCamera = function(kScene)
    local agent_gameCamera = AgentCreate("camera_gameCamera", "module_camera.prop", KTBM_Gameplay_Camera_OriginalPosition, KTBM_Gameplay_Camera_OriginalRotation, kScene, false, false);
    
    KTBM_AgentSetProperty("camera_gameCamera", "Clip Plane - Far", 2500, kScene);
    KTBM_AgentSetProperty("camera_gameCamera", "Clip Plane - Near", 0.05, kScene);
    KTBM_AgentSetProperty("camera_gameCamera", "Field Of View", 90, kScene);
    KTBM_AgentSetProperty("camera_gameCamera", "Lens - Current Lens", nil, kScene);

    CameraPush("camera_gameCamera");
    --CameraActivate("camera_gameCamera");

    --activate the imap file for the game input
    InputMapperActivate(KTBM_Gameplay_Input_IMAP_File);

    local agent_boat = AgentFindInScene("obj_boatMotorChesapeake", kScene);

    --NOTE: IMPORTANT! Corrects the existing bounds on the object to factor in the scaling operations we are doing
    KTBM_Bounds_AgentSetCorrectBounds(agent_boat, KTBM_Gameplay_BoatCollisionScaleFactor);
end

KTBM_Gameplay_PlayerUpdate = function()
    if(KTBM_Gameplay_State_HasCrashed == true) or (KTBM_Gameplay_State_Paused == true) then
        return;
    end

    --get the frame time
    --when we do any operations we want to multiply them by the frame time so that they are consistent across machines.
    local number_deltaTime = GetFrameTime();

    --get the follow agents since we are going to be modifying their position/rotations
    local agent_boatGroup = AgentFindInScene("BoatGroup", KTBM_Gameplay_kScene);
    local agent_gameCamera = AgentFindInScene("camera_gameCamera", KTBM_Gameplay_kScene);

    -----------------------------------------------------------
    --procedual bobbing animation both for the boat
    --this is non critical for gameplay but adds a nice bobbing animation to both the camera and boat so they don't feel so static

    KTBM_Gameplay_Boat_CurrentBobbingValue = KTBM_Gameplay_Boat_CurrentBobbingValue + (number_deltaTime * KTBM_Gameplay_Boat_BobbingSpeed);    
    KTBM_Gameplay_Camera_CurrentBobbingRotationValue = KTBM_Gameplay_Camera_CurrentBobbingRotationValue + (number_deltaTime * KTBM_Gameplay_Camera_BobbingRotationSpeed);
    KTBM_Gameplay_Camera_CurrentBobbingPositionValue = KTBM_Gameplay_Camera_CurrentBobbingPositionValue + (number_deltaTime * KTBM_Gameplay_Camera_BobbingPositionSpeed);
    
    local number_newBoatBobbingValue = math.sin(KTBM_Gameplay_Boat_CurrentBobbingValue) * KTBM_Gameplay_Boat_BobbingAmount;
    local number_newCameraBobbingRotationValue = math.sin(KTBM_Gameplay_Camera_CurrentBobbingRotationValue) * KTBM_Gameplay_Camera_BobbingRotationAmount;
    local number_newCameraBobbingPositionValue = math.sin(KTBM_Gameplay_Camera_CurrentBobbingPositionValue) * KTBM_Gameplay_Camera_BobbingPositionAmount;
    
    --add the bobbing rotation animation to the x axis for the camera
    KTBM_Gameplay_Camera_DesiredRotation.x = KTBM_Gameplay_Camera_OriginalRotation.x + number_newCameraBobbingRotationValue;

    -----------------------------------------------------------
    --boat controller

    KTBM_Gameplay_Boat_DesiredPosition.x = KTBM_Gameplay_Boat_DesiredPosition.x + KTBM_Gameplay_Input_CurrentHorizontalPositionValue;
    KTBM_Gameplay_Boat_DesiredPosition.y = KTBM_Gameplay_EnvironmentHeightOffset;
    KTBM_Gameplay_Boat_DesiredRotation = Vector(number_newBoatBobbingValue, KTBM_Gameplay_Input_CurrentHorizontalRotationValue, 0);

    if(KTBM_Gameplay_State_IsSpeeding == true) then
        KTBM_Gameplay_Boat_DesiredRotation.x = KTBM_Gameplay_Boat_DesiredRotation.x - KTBM_Gameplay_BoatSpeedBoostMaxRotationVerticalAngle;
        KTBM_Gameplay_Boat_DesiredPosition.y = KTBM_Gameplay_Boat_DesiredPosition.y + KTBM_Gameplay_BoatSpeedBoostPositionRiseHeight;
    end

    if (KTBM_Gameplay_Boat_DesiredPosition.x < -KTBM_Gameplay_BoatHorizontalBoundarySize - 0.01) or (KTBM_Gameplay_Boat_DesiredPosition.x > KTBM_Gameplay_BoatHorizontalBoundarySize - 0.01) then
        KTBM_Gameplay_Boat_DesiredRotation = Vector(number_newBoatBobbingValue, 0, 0);
    end

    KTBM_Gameplay_Boat_PreviousPosition = KTBM_VectorLerp(KTBM_Gameplay_Boat_PreviousPosition, KTBM_Gameplay_Boat_DesiredPosition, number_deltaTime * KTBM_Gameplay_Boat_PositionLerp);
    KTBM_Gameplay_Boat_PreviousRotation = KTBM_VectorLerp(KTBM_Gameplay_Boat_PreviousRotation, KTBM_Gameplay_Boat_DesiredRotation, number_deltaTime * KTBM_Gameplay_Boat_RotationLerp);

    --clamp the boat position so we are within game bounds
    KTBM_Gameplay_Boat_DesiredPosition.x = KTBM_Clamp(KTBM_Gameplay_Boat_DesiredPosition.x, -KTBM_Gameplay_BoatHorizontalBoundarySize, KTBM_Gameplay_BoatHorizontalBoundarySize);

    -----------------------------------------------------------
    --player camera
    KTBM_Gameplay_Camera_DesiredPosition = KTBM_Gameplay_Camera_DesiredPosition + Vector(KTBM_Gameplay_Input_CurrentHorizontalPositionValue, 0, 0);
    KTBM_Gameplay_Camera_DesiredPosition = Vector(KTBM_Gameplay_Camera_DesiredPosition.x, KTBM_Gameplay_EnvironmentHeightOffset + 2.890892 + number_newCameraBobbingPositionValue, -6.259110);
    
    KTBM_Gameplay_Camera_PreviousPosition = KTBM_VectorLerp(KTBM_Gameplay_Camera_PreviousPosition, KTBM_Gameplay_Camera_DesiredPosition, number_deltaTime * KTBM_Gameplay_Camera_LerpFactor);
    
    KTBM_Gameplay_Camera_DesiredPosition.x = KTBM_Clamp(KTBM_Gameplay_Camera_DesiredPosition.x, -KTBM_Gameplay_BoatHorizontalBoundarySize, KTBM_Gameplay_BoatHorizontalBoundarySize);
    
    -----------------------------------------------------------
    AgentSetWorldPos(agent_boatGroup, KTBM_Gameplay_Boat_PreviousPosition);
    AgentSetWorldRot(agent_boatGroup, KTBM_Gameplay_Boat_PreviousRotation);
    AgentSetWorldPos(agent_gameCamera, KTBM_Gameplay_Camera_PreviousPosition);
    AgentSetWorldRot(agent_gameCamera, KTBM_Gameplay_Camera_DesiredRotation);
end