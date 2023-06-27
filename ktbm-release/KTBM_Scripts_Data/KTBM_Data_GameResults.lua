--disk path
local string_mainDirectoryName = "KennyTheBoatMaster";
local string_baseFilePath = string_mainDirectoryName .. "/GameResults";
local strings_gameResultFilePaths = {};

--config file data
KTBM_Data_CurrentGameResults = nil;

KTBM_Data_BuildGameResultsObject = function(number_distanceTraveled, number_zombiesKilled, number_totalTime)
    local gameResults_object = {
        FileName = "",
        DistanceTraveled = KTBM_NumberRound(number_distanceTraveled, 0),
        ZombiesKilled = number_zombiesKilled,
        TotalTime = number_totalTime
    };

    return gameResults_object;
end

KTBM_Data_GameResultsObject_GetFileName = function(gameResults_object)
    return gameResults_object["FileName"];
end

KTBM_Data_GameResultsObject_GetDistanceTraveled = function(gameResults_object)
    return gameResults_object["DistanceTraveled"];
end

KTBM_Data_GameResultsObject_GetZombiesKilled = function(gameResults_object)
    return gameResults_object["ZombiesKilled"];
end

KTBM_Data_GameResultsObject_GetTotalTime = function(gameResults_object)
    return gameResults_object["TotalTime"];
end

KTBM_Data_GameResults_GetDateTimeFromFileName = function(string_gameResultFileName)
    local string_monthNames = { "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December" };

    local _, _, string_hours, string_minutes, string_seconds, string_month, string_day, string_year = string.find(string_gameResultFileName, "GameResults_(%d+)-(%d+)-(%d+)_(%d+)-(%d+)-(%d+)");
    local number_month = tonumber(string_month);
    local number_hours = tonumber(string_hours);
    local number_formattedHours = number_hours;

    local string_timePeriod = "AM";

    if(number_hours >= 12) then
        string_timePeriod = "PM";
        number_formattedHours = number_formattedHours - 12;
    end

    local string_monthName = string_monthNames[number_month];

    local string_formattedDate = string_monthName .. " " .. string_day .. ", " .. string_year;
    local string_formattedTime = string.format("%02d:%02d:%02d %s", number_formattedHours, string_minutes, string_seconds, string_timePeriod);
    local string_finalFormattedString = string_formattedDate .. " at " .. string_formattedTime;

    return string_finalFormattedString;
end

KTBM_Data_GameResultsObjectToString = function(gameResults_object)
    local string_fileName = KTBM_Data_GameResults_GetDateTimeFromFileName(gameResults_object["FileName"]);
    local string_distanceTraveled = tostring(gameResults_object["DistanceTraveled"]);
    local string_zombiesKilled = tostring(gameResults_object["ZombiesKilled"]);
    local string_totalTime = KTBM_TimeSecondsFormatted(gameResults_object["TotalTime"]);

    local string_final = "";

    string_final = string_final .. "Date: " .. string_fileName;
    string_final = string_final .. "\n"; --new line
    string_final = string_final .. "Distance Traveled: " .. string_distanceTraveled .. " meters";
    string_final = string_final .. "\n"; --new line
    string_final = string_final .. "Zombies Killed: " .. string_zombiesKilled;
    string_final = string_final .. "\n"; --new line
    string_final = string_final .. "Total Time: " .. string_totalTime;
    string_final = string_final .. "\n"; --new line

    return string_final;
end

KTBM_Data_GameResultsObjectDataToString = function(gameResults_object)
    local string_distanceTraveled = tostring(gameResults_object["DistanceTraveled"]);
    local string_zombiesKilled = tostring(gameResults_object["ZombiesKilled"]);
    local string_totalTime = KTBM_TimeSecondsFormatted(gameResults_object["TotalTime"]);

    local string_final = "";

    string_final = string_final .. "Distance Traveled: " .. string_distanceTraveled .. " meters";
    string_final = string_final .. "\n"; --new line
    string_final = string_final .. "Zombies Killed: " .. string_zombiesKilled;
    string_final = string_final .. "\n"; --new line
    string_final = string_final .. "Total Time: " .. string_totalTime;
    string_final = string_final .. "\n"; --new line

    return string_final;
end

--|||||||||||||||||||||||||||||||||||||||||||| SERIALIZATION - TEXT ||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||| SERIALIZATION - TEXT ||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||| SERIALIZATION - TEXT ||||||||||||||||||||||||||||||||||||||||||||
--[[
    This handles both serialization (writing), and deserialization (reading) the 'gameResults_object' to the disk.
    This will handle the data in a human readable text form.

    Advantages with this format are...
        1. Easy to read and understand.
        2. Easy to edit with external programs (it's just a text file).

    Disadvantages with this format are...
        1. It's really easy to modify the data. So in this instance for example if users wanted to 'cheat', they can simply write their own data.
        2. It's inefficent with how it's stored for disk space and memory (37 bytes or more).
]]

--This writes the 'gameResults_object' into a text file to the disk for saving.
KTBM_Data_SerializeGameResultsObject_Text = function(gameResults_object, string_resultsFilePath)
    KTBM_DirectoryCreate(string_mainDirectoryName);

    local string_distanceTraveled = tostring(gameResults_object["DistanceTraveled"]);
    local string_zombiesKilled = tostring(gameResults_object["ZombiesKilled"]);
    local string_totalTime = tostring(gameResults_object["TotalTime"]);

    --local file = io.open(string_resultsFilePath, "a");
    local file = io.open(string_resultsFilePath, "w");
    file:write(string_distanceTraveled, "\n");
    file:write(string_zombiesKilled, "\n");
    file:write(string_totalTime, "\n");
    file:close();
end

--This reads in a text file from the disk and returns a 'gameResults_object'.
KTBM_Data_DeserializeGameResultsObject_Text = function(string_resultsFilePath)
    local file = io.open(string_resultsFilePath, 'r');

    local string_extractedFileName = string_resultsFilePath:sub(#string_mainDirectoryName + 1);

    local gameResults_parsedObject = {
        FileName = string_extractedFileName,
        DistanceTraveled = 0,
        ZombiesKilled = 0,
        TotalTime = 0
    };

    local number_index = 0;

    for line in file:lines() do

        if(number_index == 0) then
            gameResults_parsedObject["DistanceTraveled"] = tonumber(line);
        elseif(number_index == 1) then
            gameResults_parsedObject["ZombiesKilled"] = tonumber(line);
        elseif(number_index == 2) then
            gameResults_parsedObject["TotalTime"] = tonumber(line);
        end

        number_index = number_index + 1;
    end

    file:close();

    return gameResults_parsedObject;
end

--|||||||||||||||||||||||||||||||||||||||||||| SERIALIZATION - BINARY ||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||| SERIALIZATION - BINARY ||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||| SERIALIZATION - BINARY ||||||||||||||||||||||||||||||||||||||||||||
--[[
    This handles both serialization (writing), and deserialization (reading) the 'gameResults_object' to the disk.
    This will handle the data in a binary format.

    Advantages with this format are...
        1. Data is stored very efficently (always 12 bytes, 4 for each value that is stored) 
        2. Data can't be easily modified externally since it is stored in binary form, making it more secure compared to text.

        NOTE: It can even be encoded down smaller if you wanted, but depending on the values you'll need to be
        aware of precison issues that will come with that, and the maximum number values that you can represent with fewer bits.

    Disadvantages with this format are...
        1. Non-human readable. You won't be able to open the file in a text editor and understand it.
        2. Not as easy to edit externally, you will need a hex editor to help you edit the data properly.

    NOTE FOR PEOPLE: I think it's important to mention that if you are deliberatly trying to avoid cheating in your game/mod
    and not allowing external data modification then your efforts unfortunately will be futile and worthless. 

    This applies to any project outside of game mods, but in this case, Lua Scripts can be 
    decompiled EASILY, and it'll be easy to modify the files anyway regardless how many roadblocks 
    you put up along way (i.e. through encrpytion/obfuscation). When there is a will, there is a way... So just let it be.

    While those methods can certainly make it harder for the average user, it's still possible for someone to go through
    and modify the data especially if they are skilled. The only reason this is done and included in this project is
    both for educational purposes, but also because binary serialization is very efficent compared to regular text formats.
]]

--This writes the 'gameResults_object' into a binary file to the disk for saving.
KTBM_Data_SerializeGameResultsObject_Binary = function(gameResults_object, string_resultsFilePath)
    --Create a custom local directory for our mod (NOTE: This isn't necessary but is in here for saftey)
    KTBM_DirectoryCreate(string_mainDirectoryName);

    --The variable that will store all of the binary data of the file encoded in a string
    local string_binaryData = "";

    --Pack the Distance Traveled variable into 4 bytes, and as a float format since it's usually a decimal value.
    string_binaryData = string_binaryData .. KTBM_Binary_PackInt32(gameResults_object["DistanceTraveled"]);

    --Pack the Zombies Killed variable into 4 bytes, and as a regular integer since this value is always a whole number.
    string_binaryData = string_binaryData .. KTBM_Binary_PackInt32(gameResults_object["ZombiesKilled"]);

    --Pack the Distance Traveled variable into 4 bytes, and as a float format since it's usually a decimal value.
    string_binaryData = string_binaryData .. KTBM_Binary_PackFloat(gameResults_object["TotalTime"]);

    --create our file and write the binary string data.
    local file = io.open(string_resultsFilePath, "wb");
    file:write(string_binaryData);
    file:close();
end

--This reads in a binary file from the disk and returns a 'gameResults_object'.
KTBM_Data_DeserializeGameResultsObject_Binary = function(string_resultsFilePath)
    if(string_resultsFilePath == nil) then
        print("[KTBM_Data_DeserializeGameResultsObject_Binary] string_resultsFilePath was nil!");
        return;
    end

    local file = io.open(string_resultsFilePath, "rb");
    local string_binaryData = file:read("*all");
    file:close();

    local string_extractedFileName = string_resultsFilePath:sub(#string_mainDirectoryName + 1);

    local gameResults_parsedObject = {
        FileName = string_extractedFileName,
        DistanceTraveled = 0,
        ZombiesKilled = 0,
        TotalTime = 0
    };

    local number_pointerPosition = 1
    local number_index = 0;

    while(number_pointerPosition <= #string_binaryData) do
        if(number_index == 0) then
            local string_bytes = string_binaryData:sub(number_pointerPosition, number_pointerPosition + 4);
            number_pointerPosition = number_pointerPosition + 4; --4 bytes for a 32-bit float

            local number_parsedValue = KTBM_Binary_UnpackInt32(string_bytes);

            gameResults_parsedObject["DistanceTraveled"] = number_parsedValue;
        elseif(number_index == 1) then
            local string_bytes = string_binaryData:sub(number_pointerPosition, number_pointerPosition + 4);
            number_pointerPosition = number_pointerPosition + 4; --4 bytes for a 32-bit integer

            local number_parsedValue = KTBM_Binary_UnpackInt32(string_bytes);

            gameResults_parsedObject["ZombiesKilled"] = number_parsedValue;
        elseif(number_index == 2) then
            local string_bytes = string_binaryData:sub(number_pointerPosition, number_pointerPosition + 4);
            number_pointerPosition = number_pointerPosition + 4; --4 bytes for a 32-bit float

            local number_parsedValue = KTBM_Binary_UnpackFloat(string_bytes);

            gameResults_parsedObject["TotalTime"] = number_parsedValue;
        end

        number_index = number_index + 1;
    end

    return gameResults_parsedObject;
end

--|||||||||||||||||||||||||||||||||||||||||||| GET/SAVE GAME RESULTS ||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||| GET/SAVE GAME RESULTS ||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||| GET/SAVE GAME RESULTS ||||||||||||||||||||||||||||||||||||||||||||

KTBM_Data_SaveGameResults = function(gameResults_object)
    local table_osTime = os.date("*t");

    local string_resultsFilePath = string_baseFilePath;
    string_resultsFilePath = string_resultsFilePath .. "_" .. table_osTime["hour"];
    string_resultsFilePath = string_resultsFilePath .. "-" .. table_osTime["min"];
    string_resultsFilePath = string_resultsFilePath .. "-" .. table_osTime["sec"];
    string_resultsFilePath = string_resultsFilePath .. "_" .. table_osTime["month"];
    string_resultsFilePath = string_resultsFilePath .. "-" .. table_osTime["day"];
    string_resultsFilePath = string_resultsFilePath .. "-" .. table_osTime["year"];

    print("[KTBM_Data_SaveGameResults] ");
    print("[KTBM_Data_SaveGameResults] ---SAVING GAME RESULTS---");

    if(KTBM_Core_Project_GameResultsBinaryFormat == true) then
        print("[KTBM_Data_SaveGameResults] Saving Results in Binary Format...");
        print("[KTBM_Data_SaveGameResults] " .. string_resultsFilePath .. ".bin");

        KTBM_Data_SerializeGameResultsObject_Binary(gameResults_object, string_resultsFilePath .. ".bin");
    else
        print("[KTBM_Data_SaveGameResults] Saving Results in Text Format...");
        print("[KTBM_Data_SaveGameResults] " .. string_resultsFilePath .. ".txt");

        KTBM_Data_SerializeGameResultsObject_Text(gameResults_object, string_resultsFilePath .. ".txt");
    end

    print("[KTBM_Data_SaveGameResults] ---FINISHED SAVING GAME RESULTS---");
    print("[KTBM_Data_SaveGameResults] ");
end

KTBM_Data_GetAllGameResultFilePaths = function()
    strings_gameResultFilePaths = {};

    local string_fileExtension = ".txt";

    if(KTBM_Core_Project_GameResultsBinaryFormat == true) then
        string_fileExtension = ".bin";
    end

    ---------------------------------------------------
    --Get all files in the directory sorted by creation date

    --NOTE: This does briefly tab out and back to the game unfortunately.
    local handle = io.popen('dir "'.. string_mainDirectoryName .. '" /b /a-d /o:d'); --sorts files by creation date
    local output = handle:read("*a");
    handle:close();

    for file in output:gmatch("[^\r\n]+") do
        local string_filePath = string_mainDirectoryName .. '\\' ..file;

        if(string.match(string_filePath, string_fileExtension)) then
            table.insert(strings_gameResultFilePaths, string_filePath);
        end
    end
end

KTBM_Data_GetPreviousGameResults = function()
    print("[KTBM_Data_GetPreviousGameResults] ");
    print("[KTBM_Data_GetPreviousGameResults] ---GETTING MOST RECENT GAME RESULTS---");

    if(strings_gameResultFilePaths == nil) then
        print("[KTBM_Data_GetPreviousGameResults] strings_gameResultFilePaths was nil!");
        return;
    end

    if(#strings_gameResultFilePaths < 1) then
        print("[KTBM_Data_GetPreviousGameResults] strings_gameResultFilePaths count is less than 1, returning nil.");
        return nil;
    end
    
    local string_mostRecentFilePath = strings_gameResultFilePaths[#strings_gameResultFilePaths];

    if(string_mostRecentFilePath == nil) then
        print("[KTBM_Data_GetPreviousGameResults] string_mostRecentFilePath was nil!");
        return nil;
    end

    ---------------------------------------------------
    --After getting the most recent file, get the data from it.

    local gameResults_parsedObject = nil;

    if(KTBM_Core_Project_GameResultsBinaryFormat == true) then
        print("[KTBM_Data_GetPreviousGameResults] Getting most recent 'Game Results' in binary from the following file path...");
        print("[KTBM_Data_GetPreviousGameResults] " .. string_mostRecentFilePath);

        gameResults_parsedObject = KTBM_Data_DeserializeGameResultsObject_Binary(string_mostRecentFilePath);
    else
        print("[KTBM_Data_GetPreviousGameResults] Getting most recent 'Game Results' in text from the following file path...");
        print(string_mostRecentFilePath);

        gameResults_parsedObject = KTBM_Data_DeserializeGameResultsObject_Text(string_mostRecentFilePath);
    end

    print("[KTBM_Data_GetPreviousGameResults] ---FINISHED GETTING MOST RECENT GAME RESULTS---");
    print("[KTBM_Data_GetPreviousGameResults] ");

    return gameResults_parsedObject;
end

KTBM_Data_GetAllGameResults = function()
    print("[KTBM_Data_GetAllGameResults] ");
    print("[KTBM_Data_GetAllGameResults] ---GETTING ALL GAME RESULTS---");

    if(strings_gameResultFilePaths == nil) then
        print("[KTBM_Data_GetAllGameResults] strings_gameResultFilePaths was nil!");
        return nil;
    end

    if(#strings_gameResultFilePaths < 1) then
        print("[KTBM_Data_GetAllGameResults] strings_gameResultFilePaths count is less than 1, returning nil.");
        return nil;
    end

    ---------------------------------------------------
    --Create a table to store all of the parsed files in the directory

    local gameResults_array = {};

    for index, string_filePath in ipairs(strings_gameResultFilePaths) do
        local gameResults_parsedObject = nil;

        if(KTBM_Core_Project_GameResultsBinaryFormat == true) then
            gameResults_parsedObject = KTBM_Data_DeserializeGameResultsObject_Binary(string_filePath);
        else
            gameResults_parsedObject = KTBM_Data_DeserializeGameResultsObject_Text(string_filePath);
        end

        table.insert(gameResults_array, gameResults_parsedObject);
    end

    print("[KTBM_Data_GetAllGameResults] ---FINISHED GETTING ALL GAME RESULTS---");
    print("[KTBM_Data_GetAllGameResults] ");

    return gameResults_array;
end

KTBM_Data_GetBestGameResultByStatistic = function(string_variableName)
    print("[KTBM_Data_GetBestGameResultByStatistic] ");
    print("[KTBM_Data_GetBestGameResultByStatistic] ---GETTING BEST GAME RESULT---");

    ---------------------------------------------------
    --Get all files in the directory sorted by creation date

    if(strings_gameResultFilePaths == nil) then
        print("[KTBM_Data_GetAllGameResults] strings_gameResultFilePaths was nil!");
        return nil;
    end

    if(#strings_gameResultFilePaths < 1) then
        print("[KTBM_Data_GetAllGameResults] strings_gameResultFilePaths count is less than 1, returning nil.");
        return nil;
    end

    ---------------------------------------------------
    --Create a table to store all of the parsed files in the directory

    local gameResultsObject_bestResults = nil;

    for index, string_filePath in ipairs(strings_gameResultFilePaths) do
        local gameResults_parsedObject = {};

        if(KTBM_Core_Project_GameResultsBinaryFormat == true) then
            gameResults_parsedObject = KTBM_Data_DeserializeGameResultsObject_Binary(string_filePath);
        else
            gameResults_parsedObject = KTBM_Data_DeserializeGameResultsObject_Text(string_filePath);
        end

        if(gameResultsObject_bestResults == nil) then
            gameResultsObject_bestResults = gameResults_parsedObject;
        else
            local number_variableValue = gameResults_parsedObject[string_variableName];
            local number_currentBestVariableValue = gameResultsObject_bestResults[string_variableName];

            if(number_variableValue > number_currentBestVariableValue) then
                gameResultsObject_bestResults = gameResults_parsedObject;
            end
        end
    end

    print("[KTBM_Data_GetBestGameResultByStatistic] ---FINISHED GETTING BEST GAME RESULT---");
    print("[KTBM_Data_GetBestGameResultByStatistic] ");

    return gameResultsObject_bestResults;
end