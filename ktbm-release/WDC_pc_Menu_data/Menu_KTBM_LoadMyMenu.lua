--[[
-------------------------------------------------------------------------
]]--

require("KTBM_Core_Project.lua");

--function that is exectued when the user presses the play cutscene button in the menu
PlayKBTM_Game = function()
    --SubProject_Switch("ProjectSeason2");
    --SubProject_Switch("WalkingDead201");

    --setup KTBM
    KTBM_Project_SetProjectSettings();
    KTBM_Project_EnableGameArchives();

    --note to self: we need to do a scene fade both when opening the scene and exiting the scene.

    SubProject_Switch("Menu", "KTBM_Level_Menu.lua");
end