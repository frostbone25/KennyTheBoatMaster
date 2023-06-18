--[[
-------------------------------------------------------------------------
]]--

require("KTBM_Core_Project.lua");

do
    KTBM_Core_Project_DisableGameArchives();

    --OverlayShow("ui_loadingScreen.overlay", true);

    SubProject_Switch("Menu");
    
    --note to self: we need to do a scene fade both when opening the scene and exiting the scene.

    --dofile("Menu_main.lua");
    
    SceneRemove("adv_flagshipExteriorDeck");
end