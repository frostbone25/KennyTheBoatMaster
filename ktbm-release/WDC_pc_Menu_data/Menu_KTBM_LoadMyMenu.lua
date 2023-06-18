--[[
-------------------------------------------------------------------------
]]--

require("KTBM_Core_Project.lua");

--function that is exectued when the user presses the play cutscene button in the menu
PlayKBTM_Game = function()
    --SubProject_Switch("ProjectSeason2");
    --SubProject_Switch("WalkingDead201");

    --setup KTBM
    KTBM_Core_Project_SetProjectSettings();
    KTBM_Core_Project_EnableGameArchives();

    --note to self: we need to do a scene fade both when opening the scene and exiting the scene.

    OverlayShow("ui_loadingScreen.overlay", true);

    --execute the cutscene level script
    dofile("KTBM_Level_Menu.lua");
    
    SceneRemove("ui_menuMain");
    SceneRemove("adv_clementineHouse400");
end