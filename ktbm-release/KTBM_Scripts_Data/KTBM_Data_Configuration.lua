--current config version
local CurrentConfigurationVersion = 100;

--disk path
local string_directoryName = "KennyTheBoatMaster";
local string_configurationFilePath = string_directoryName .. "/KTBM_PlayerSettings.ini";

--config file data
KTBM_Data_PlayerSettings = nil;

--generates a new ini file
local GenerateNewINI_PlayerSettings = function()
    local data = 
    {
        Version = 
        {
            ConfigurationVersion = CurrentConfigurationVersion,
        },
        Gameplay = 
        {
            KennyOutfitProfile = "202",
            ForceSkipCutscenes = false
        },
        Video = 
        {
            RenderScale = 1.0,
            DisableDOF = false,
            DisableBloom = false
        }
    };
        
    return data;
end

KTBM_Data_Configuration_Save = function()
    if(KTBM_FileExists(string_configurationFilePath) == true) then
        KTBM_FileDelete(string_configurationFilePath);
    else
        KTBM_DirectoryCreate(string_directoryName);
    end

    KTBM_INI_SaveINIFile(string_configurationFilePath, KTBM_Data_PlayerSettings);
end

--||||||||||||||||||||||||||||||||||||||| LOAD IN OR GENERATE CONFIG FILES |||||||||||||||||||||||||||||||||||||||
--||||||||||||||||||||||||||||||||||||||| LOAD IN OR GENERATE CONFIG FILES |||||||||||||||||||||||||||||||||||||||
--||||||||||||||||||||||||||||||||||||||| LOAD IN OR GENERATE CONFIG FILES |||||||||||||||||||||||||||||||||||||||

--main
do
    ----------------------------------- GENERATE NEW INI FILES (IF THEY DON'T EXIST) -----------------------------------
    --checks if the ini files relight requires exists.
    --if they don't exist then generate a new ini object and write that to the disk

    if (KTBM_FileExists(string_configurationFilePath) == false) then
        KTBM_DirectoryCreate(string_directoryName);

        KTBM_INI_SaveINIFile(string_configurationFilePath, GenerateNewINI_PlayerSettings());
    end

    ----------------------------------- LOAD INI FILE DATA -----------------------------------
    --load in the ini files so we can pull data from them

    KTBM_Data_PlayerSettings = KTBM_INI_LoadINIFile(string_configurationFilePath);

    ----------------------------------- REGENERATE INI FILES (IF THEY ARE A DIFFERENT VERSION) -----------------------------------
    --do a version check, and if the version number doesn't match, rebuild the ini file
    --unfortunately this will revert user changes to the original ini file

    if not (KTBM_Data_PlayerSettings.Version.ConfigurationVersion == CurrentConfigurationVersion) then
        KTBM_FileDelete(string_configurationFilePath);

        KTBM_INI_SaveINIFile(string_configurationFilePath, GenerateNewINI_PlayerSettings());
    end
end