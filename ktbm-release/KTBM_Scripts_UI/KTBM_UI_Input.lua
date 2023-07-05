KTBM_UI_Input_Clicked = false;
KTBM_UI_IMAP_File = "KTBM_UI_Input.imap";

local bool_inputClickedOnce = false;

KTBM_UI_Input_IMAP_Click_Begin = function()
    KTBM_UI_Input_Clicked = true;
end

KTBM_UI_Input_IMAP_Click_End = function()

end

KTBM_UI_Input_IMAP_Update = function()


    if (Input_IsVKeyPressed(KTBM_Core_Keycodes_LeftMouse)) then
    
        if(bool_inputClickedOnce == false) then
            KTBM_UI_Input_Clicked = true;
            bool_inputClickedOnce = true;
        else
            KTBM_UI_Input_Clicked = false;
        end
        
    else
        KTBM_UI_Input_Clicked = false;
        bool_inputClickedOnce = false;
    end
    
end