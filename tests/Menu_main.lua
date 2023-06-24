require("RichPresence.lua")
require("Utilities.lua")
require("AspectRatio.lua")
require("MenuUtils.lua")
require("Menu_JumpScrollList.lua")
require("Menu_Characters.lua")
require("Menu_ConceptGallery.lua")
require("Menu_Music.lua")
require("Menu_Options.lua")
require("Menu_Seasons.lua")
require("Menu_VideoMenu.lua")
require("UI_ListButton.lua")
require("UI_ListButtonLite.lua")
require("UI_Legend.lua")
require("UI_Popup.lua")
if ResourceExists("DebugLoader.lua") then
  require("DebugLoader.lua")
  require("MenuBootUtils.lua")
end
local kScene = "ui_menuMain.scene"
local kKeyArtScene = "adv_clementineHouse400.scene"
local mControllerAmbient, mControllerIdle, mControllerNowPlaying, mRefCounterAmbient
local bgMain = {isMenuMain = true}
function bgMain:transitionTo(otherBG)
  if not otherBG then
    ChorePlay("ui_menuMain_show")
    Menu_Main_EnableAmbient(true)
    Sleep(1.5)
  elseif otherBG.sharesBGWithMain then
    SceneHide(kScene, false)
  end
end
function bgMain:transitionFrom(otherBG)
  if not otherBG then
    ChorePlayAndWait("ui_menuMain_hide")
  elseif otherBG.sharesBGWithMain then
    SceneHide(kScene, true)
  end
end
local EnableAmbient = function(bEnable)
  if bEnable then
    mControllerAmbient = ChorePlayAndSync("ui_menu_ambientFadeIn", mControllerAmbient)
  else
    mControllerAmbient = ChorePlayAndSync("ui_menu_ambientFadeOut", mControllerAmbient)
  end
end
mRefCounterAmbient = ReferenceCounter(EnableAmbient)
local OpenDebugMenu = function()
  if SceneIsActive(kScene) then
    WidgetInputHandler_EnableInput(false)
    MenuBoot_CreateDebugMenu()
  end
end
local UpdateLegend = function()
  Legend_Clear()
  Legend_Add("faceButtonDown", "legend_select")
  if IsPlatformXboxOne() then
    Legend_Add("faceButtonUp", MenuUtils_LegendStringForProfileUser(Menu_Text("legend_changeProfile")), "PlatformOpenAccountPickerUI()")
  end
end
function Menu_Main()
  if not SceneIsActive(kKeyArtScene) then
    MenuUtils_AddScene(kKeyArtScene)
  end
  SceneHide(kKeyArtScene, false)
  SceneHide("ui_menuMain", false)
  local menu = Menu_Create(ListMenu, "ui_menuMain", kScene)
  menu.align = "left"
  menu.background = bgMain
  function menu:Show(direction)
    Menu_Main_SetIdle("env_clementineHouse400_mainMenu")
    if direction and direction < 0 then
      ChorePlay("ui_alphaGradient_show")
    end
    Menu.Show(self)
    RichPresence_Set("richPresence_mainMenu", false)
    UpdateLegend()
  end
  function menu:Hide(direction)
    ChorePlay("ui_alphaGradient_hide")
    Menu.Hide(self)
  end
  function menu:Populate()
    local buttonSeasons = Menu_Add(ListButtonLite, "seasons", "label_seasonSelect", "Menu_Seasons()")
    AgentSetProperty(buttonSeasons.agent, "Text Glyph Scale", 1.5)
    if Menu_VideoPlayer_CanSupportVideo() then
      Menu_Add(ListButtonLite, "videos", "label_videos", "Menu_VideoMenu()")
    end
    Menu_Add(ListButtonLite, "characters", "label_characters", "Menu_Characters()")
    Menu_Add(ListButtonLite, "art", "label_art", "Menu_ConceptGallery()")
    Menu_Add(ListButtonLite, "music", "label_music", "Menu_Music()")
    Menu_Add(ListButtonLite, "settings", "label_settings", "Menu_Options()")
    Menu_Add(ListButtonLite, "credits", "label_credits", "Menu_ShowCredits( 0 )")
    if IsPlatformPC() or IsPlatformMac() then
      Menu_Add(ListButtonLite, "exit", "label_exitGame", "UI_Confirm( \"popup_quit_header\", \"popup_quit_message\", \"EngineQuit()\" )")
    end
    local legendWidget = Menu_Add(Legend)
    function legendWidget:Place()
      self:AnchorToAgent(menu.agent, "left", "bottom")
    end
    UpdateLegend()
  end
  function menu:onModalPopped()
    Menu.onModalPopped(self)
    UpdateLegend()
  end
  Menu_Show(menu)
end
function Menu_Main_Start()
  if Input_UseTouch() then
    ClickText_Enable(true)
  end
  local prefs = GetPreferences()
  if PropertyIsLocal(prefs, "Menu - User Gamma Setting") then
    RenderSetIntensity(PropertyGet(prefs, "Menu - User Gamma Setting"))
    PropertyRemove(prefs, "Menu - User Gamma Setting")
    SavePrefs()
  end
  RenderForce_16_by_9_AspectRatio(true)
  RenderDelay(1)
  WaitForNextFrame()
  Menu_Main()
end
function Menu_Main_GetKeyArtScene()
  return kKeyArtScene
end
function Menu_Main_SetIdle(chore)
  if mControllerIdle then
    ControllerKill(mControllerIdle)
  end
  if chore then
    mControllerIdle = ChorePlay(chore, 10)
    if mControllerIdle then
      ControllerSetLooping(mControllerIdle, true)
    end
  end
end
function Menu_Main_EnableAmbient(bEnable)
  mRefCounterAmbient:Enable(bEnable)
end
function Menu_Main_SetNowPlaying(text)
  local chore
  if text then
    local nowPlaying = AgentFind("ui_menuMain_nowPlaying")
    AgentSetProperty(nowPlaying, kText, text)
    chore = "ui_nowPlaying_show"
  else
    chore = "ui_nowPlaying_hide"
  end
  mControllerNowPlaying = ChorePlayAndSync(chore, mControllerNowPlaying)
end
if IsToolBuild() then
  Preload_SetSubProjectShaderPack("Menu", FileStripExtension(kScene))
end
if ResourceExists("DebugLoader.lua") then
  Callback_OnLoadDebugMenu:Add(OpenDebugMenu)
end
SceneOpen(kScene, "Menu_Main_Start")
