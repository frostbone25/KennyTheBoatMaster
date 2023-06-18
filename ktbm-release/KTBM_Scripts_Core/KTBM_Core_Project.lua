KTBM_Core_Project_Version = "1.0.0";

KTBM_Core_Project_DebugPrinting = true;
KTBM_Core_Project_DebugFreecamMode = false;
KTBM_Core_Project_DebugPeformanceMetrics = false;
KTBM_Core_Project_DebugRockCollisionsUI = false;
KTBM_Core_Project_DebugDisableRocks = false;
KTBM_Core_Project_DebugDisableRockCollisions = false;
KTBM_Core_Project_DebugDisableZombies = false;
KTBM_Core_Project_DebugDisableZombieCollisions = false;
KTBM_Core_Project_GameResultsBinaryFormat = true;

--sets some project settings when we load into the game
KTBM_Core_Project_SetProjectSettings = function()
    local prefs = GetPreferences();

    PropertySet(prefs, "Enable Graphic Black", false);
    PropertySet(prefs, "Render - Graphic Black Enabled", false);
    PropertySet(prefs, "Legacy Light Limits", false);
    PropertySet(prefs, "Render - Feature Level", 1);
    PropertySet(prefs, "Use Legacy DOF", true);
    PropertySet(prefs, "Legacy Use Default Lighting Group", true);
    PropertySet(prefs, "Set Default Intensity", true);
    PropertySet(prefs, "Camera Lens Engine", false);
    PropertySet(prefs, "Boot Project on Startup", true);
    PropertySet(prefs, "Enable Dialog System 2.0", true);
    PropertySet(prefs, "Enable LipSync 2.0", true);
    PropertySet(prefs, "Allow Static Node Updates", true);
    PropertySet(prefs, "Animated Lookats Active", false);
    PropertySet(prefs, "Chore End Lipsync Buffer Time", 0);
    PropertySet(prefs, "Enable Callbacks For Unchanged Key Sets", true);
    PropertySet(prefs, "Enable Lipsync Line Buffers", true);
    PropertySet(prefs, "Fix Pop In Additive Idle Transitions", false);
    PropertySet(prefs, "Fix Recursive Animation Contribution (set to false before Thrones)", true);
    PropertySet(prefs, "Language Sync-- Enable New System for Project", false);
    PropertySet(prefs, "Legacy Use Old BGM Idle Behavior", false);
    PropertySet(prefs, "Lipsync Line End Buffer", 0);
    PropertySet(prefs, "Lipsync Line Start Buffer", 1);
    PropertySet(prefs, "Mirror Non-skeletal Animations", false);
    PropertySet(prefs, "No Mover Data in Idles", false);
    PropertySet(prefs, "Project Generates Procedural Look At Targets", false);
    PropertySet(prefs, "Remap bad bones", true);
    PropertySet(prefs, "Remap some Ascii chars to unicode smart chars", true);
    PropertySet(prefs, "Set Default Accent Tags", true);
    PropertySet(prefs, "Strip action lines", false);
    PropertySet(prefs, "Strip Dev Only Content", true);
    PropertySet(prefs, "Style Idle Transition In Time Override", 0);
    PropertySet(prefs, "Style Idle Transition Out Time Override", 0);
    PropertySet(prefs, "Style Idle Transition Time", 0.20000000298023);
    PropertySet(prefs, "Text Leading Fix", true);
    PropertySet(prefs, "Use New Auto Acting", false);
    PropertySet(prefs, "Use New Style Idles", false);
    PropertySet(prefs, "Use New Quaternion Interpolation", false);
    PropertySet(prefs, "Use skeleton LOD", true);
end

--enables some archives that the cutscene uses assets from
KTBM_Core_Project_EnableGameArchives = function()
    --enable michonne because we will use assets from it
    --note to self: for optimization sake we need to figure out a way
    --to load assets from these archives without enabling the whole thing

    --water
    ResourceSetEnable("Menu");
    ResourceSetEnable("ProjectSeason4");
    ResourceSetEnable("WalkingDead401");

    ResourceSetEnable("ProjectSeason1");
    ResourceSetEnable("ProjectSeason2");
    --ResourceSetEnable("ProjectSeason3");
    --ResourceSetEnable("ProjectSeasonM");

    ResourceSetEnable("WalkingDeadM101");
    ResourceSetEnable("WalkingDeadM102");
    --ResourceSetEnable("WalkingDeadM103");

    ResourceSetEnable("WalkingDead102");
    ResourceSetEnable("WalkingDead104");

    ResourceSetEnable("WalkingDead201");
    ResourceSetEnable("WalkingDead202");
    ResourceSetEnable("WalkingDead203");
    ResourceSetEnable("WalkingDead205");

    ResourceSetEnable("WalkingDead301");

    --require("ProjectSettingsManager.lua");
    --ProjectSettingsManager_Apply("Season2");
end

KTBM_Core_Project_DisableGameArchives = function()
    --enable michonne because we will use assets from it
    --note to self: for optimization sake we need to figure out a way
    --to load assets from these archives without enabling the whole thing

    --water
    ResourceSetEnable("Menu");
    ResourceSetEnable("ProjectSeason4");
    ResourceSetDisable("WalkingDead401");

    --ResourceSetDisable("ProjectSeason2");
    --ResourceSetDisable("ProjectSeasonM");
    ResourceSetDisable("WalkingDeadM101");
    ResourceSetDisable("WalkingDeadM102");
    --ResourceSetDisable("WalkingDeadM103");
    ResourceSetDisable("WalkingDead102");
    ResourceSetDisable("WalkingDead104");
    --ResourceSetDisable("WalkingDead201");
    ResourceSetDisable("WalkingDead202");
    ResourceSetDisable("WalkingDead301");

    require("ProjectSettingsManager.lua");
    ProjectSettingsManager_Apply("Season4");
    --WalkAnimatorUsePrioritiesVer2();

end