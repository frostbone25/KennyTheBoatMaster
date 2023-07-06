local bool_inputClickedOnce = false;

KTBM_Development_Editor_Input_LeftMouseClicked = false;
KTBM_Development_Editor_Input_LeftMouseHold = false;
KTBM_Development_Editor_Input_IMAP_File = "KTBM_Development_Editor.imap";

KTBM_Development_Editor_Input_LeftMouseBegin = function()
    --KTBM_Development_Editor_Input_LeftMouseClicked = true;
end

KTBM_Development_Editor_Input_LeftMouseEnd = function()

end

KTBM_Development_Editor_Input_Update = function()
    KTBM_Development_Editor_Input_LeftMouseHold = Input_IsVKeyPressed(KTBM_Keycodes_LeftMouse);

    if (KTBM_Development_Editor_Input_LeftMouseHold == true) then
    
        if(bool_inputClickedOnce == false) then
            KTBM_Development_Editor_Input_LeftMouseClicked = true;
            bool_inputClickedOnce = true;
        else
            KTBM_Development_Editor_Input_LeftMouseClicked = false;
        end
        
    else
        KTBM_Development_Editor_Input_LeftMouseClicked = false;
        bool_inputClickedOnce = false;
    end
end