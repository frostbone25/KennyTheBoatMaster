--disk path
local string_mainDirectoryName = "KennyTheBoatMaster";
local string_baseFilePath = string_mainDirectoryName .. "/GameResults";

--config file data
KTBM_Data_CurrentGameResults = nil;

KTBM_Data_BuildGameResultsObject = function(number_distanceTraveled, number_zombiesKilled, number_totalTime)
    local gameResults_object = {
        FileName = "",
        DistanceTraveled = number_distanceTraveled,
        ZombiesKilled = number_zombiesKilled,
        TotalTime = number_totalTime
    };

    return gameResults_object;
end

KTBM_Data_GameResultsObjectToString = function(gameResults_object)
    local string_fileName = tostring(gameResults_object["FileName"]);
    local string_distanceTraveled = tostring(gameResults_object["DistanceTraveled"]);
    local string_zombiesKilled = tostring(gameResults_object["ZombiesKilled"]);
    local string_totalTime = tostring(gameResults_object["TotalTime"]);

    local string_final = "";

    string_final = string_final .. string_fileName;
    string_final = string_final .. "\n"; --new line
    string_final = string_final .. "Distance Traveled: " .. string_distanceTraveled;
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
    local string_totalTime = tostring(gameResults_object["TotalTime"]);

    local string_final = "";

    string_final = string_final .. "Distance Traveled: " .. string_distanceTraveled;
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
--This handles both serialization (writing), and deserialization (reading) the 'gameResults_object' to the disk.
--This will handle the data in a human readable text form.
--Advantages with this format are...
--  1. Easy to read and understand.
--  2. Easy to edit with external programs (it's just a text file).
--Disadvantages with this format are...
--  1. It's really easy to modify the data (so in this instance for example if you wanted to 'cheat' you can simply write your own data)
--  2. It's inefficent with how it's stored (37 bytes or more).

--This writes the 'gameResults_object' into a text file to the disk for saving.
KTBM_Data_SerializeGameResultsObject_Text = function(gameResults_object, string_resultsFilePath)
    KTBM_DirectoryCreate(string_mainDirectoryName);

    local string_distanceTraveled = tostring(gameResults_object["DistanceTraveled"]);
    local string_zombiesKilled = tostring(gameResults_object["ZombiesKilled"]);
    local string_totalTime = tostring(gameResults_object["TotalTime"]);

    local file = io.open(string_resultsFilePath, "a");
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
--This handles both serialization (writing), and deserialization (reading) the 'gameResults_object' to the disk.
--This will handle the data in a binary format.
--Advantages with this format are...
--  1. Data is stored efficently (always 12 bytes, 4 for each value that is stored) NOTE: It can be encoded down even smaller.
--  2. Data can't be that easily modified since it is stored in binary form which makes it secure compared to text.
--Disadvantages with this format are...
--  1. Non-human readable. You won't be able to open the file in a text editor and understand it.
--  2. Not as easy to edit, you will need a hex editor to help you edit the data properly.

--This writes the 'gameResults_object' into a binary file to the disk for saving.
KTBM_Data_SerializeGameResultsObject_Binary = function(gameResults_object, string_resultsFilePath)
    KTBM_DirectoryCreate(string_mainDirectoryName);

    local string_binaryData = "";

    string_binaryData = string_binaryData .. KTBM_Binary_PackFloat(gameResults_object["DistanceTraveled"]);
    string_binaryData = string_binaryData .. KTBM_Binary_PackInt32(gameResults_object["ZombiesKilled"]);
    string_binaryData = string_binaryData .. KTBM_Binary_PackFloat(gameResults_object["TotalTime"]);

    local file = io.open(string_resultsFilePath, "wb");
    file:write(string_binaryData);
    file:close();
end

--This reads in a binary file from the disk and returns a 'gameResults_object'.
KTBM_Data_DeserializeGameResultsObject_Binary = function(string_resultsFilePath)
    local file = io.open(string_resultsFilePath, "rb");
    local string_binaryData = file:read("*a");
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

            local number_parsedValue = KTBM_Binary_UnpackFloat(string_bytes);

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

    print(" ");
    print("---SAVING GAME RESULTS---");

    if(KTBM_Core_Project_GameResultsBinaryFormat == true) then
        print("Saving Results in Binary Format...");
        print(string_resultsFilePath .. ".bin");

        KTBM_Data_SerializeGameResultsObject_Binary(gameResults_object, string_resultsFilePath .. ".bin");
    else
        print("Saving Results in Text Format...");
        print(string_resultsFilePath .. ".txt");

        KTBM_Data_SerializeGameResultsObject_Text(gameResults_object, string_resultsFilePath .. ".txt");
    end

    print("---FINISHED SAVING GAME RESULTS---");
    print(" ");
end

KTBM_Data_GetPreviousGameResults = function()
    print(" ");
    print("---GETTING MOST RECENT GAME RESULTS---");

    local string_mostRecentFilePath = nil
    local string_fileExtension = ".txt";

    if(KTBM_Core_Project_GameResultsBinaryFormat == true) then
        string_fileExtension = ".bin";
    end

    ---------------------------------------------------
    --Get the most recently created file in the directory.

    --local handle = io.popen('dir "'.. string_mainDirectoryName ..'" /b /a-d');
    local handle = io.popen('dir "'.. string_mainDirectoryName .. '" /b /a-d /o:d'); --sorts files by creation date
    local output = handle:read("*a");
    handle:close();

    for file in output:gmatch("[^\r\n]+") do
        local filePath = string_mainDirectoryName .. '\\' ..file;

        if(string.match(filePath, string_fileExtension)) then
            string_mostRecentFilePath = filePath;
        end
    end

    ---------------------------------------------------
    --After getting the most recent file, get the data from it.

    local gameResults_parsedObject = {};

    if(KTBM_Core_Project_GameResultsBinaryFormat == true) then
        print("Getting most recent 'Game Results' in binary from the following file path...");
        print(string_mostRecentFilePath);

        gameResults_parsedObject = KTBM_Data_DeserializeGameResultsObject_Binary(string_mostRecentFilePath);
    else
        print("Getting most recent 'Game Results' in text from the following file path...");
        print(string_mostRecentFilePath);

        gameResults_parsedObject = KTBM_Data_DeserializeGameResultsObject_Text(string_mostRecentFilePath);
    end

    print("---FINISHED GETTING MOST RECENT GAME RESULTS---");
    print(" ");

    return gameResults_parsedObject;
end

KTBM_Data_GetAllGameResults = function()
    print(" ");
    print("---GETTING ALL GAME RESULTS---");

    local strings_gameResultFilePaths = {};
    local string_fileExtension = ".txt";

    if(KTBM_Core_Project_GameResultsBinaryFormat == true) then
        string_fileExtension = ".bin";
    end

    ---------------------------------------------------
    --Get all files in the directory sorted by creation date

    local handle = io.popen('dir "'.. string_mainDirectoryName .. '" /b /a-d /o:d'); --sorts files by creation date
    local output = handle:read("*a");
    handle:close();

    for file in output:gmatch("[^\r\n]+") do
        local string_filePath = string_mainDirectoryName .. '\\' ..file;

        if(string.match(string_filePath, string_fileExtension)) then
            table.insert(strings_gameResultFilePaths, string_filePath);
        end
    end

    ---------------------------------------------------
    --Create a table to store all of the parsed files in the directory

    local gameResults_array = {};

    for index, string_filePath in ipairs(strings_gameResultFilePaths) do
        local gameResults_parsedObject = {};

        if(KTBM_Core_Project_GameResultsBinaryFormat == true) then
            gameResults_parsedObject = KTBM_Data_DeserializeGameResultsObject_Binary(string_filePath);
        else
            gameResults_parsedObject = KTBM_Data_DeserializeGameResultsObject_Text(string_filePath);
        end

        table.insert(gameResults_array, gameResults_parsedObject);
    end

    print("---FINISHED GETTING ALL GAME RESULTS---");
    print(" ");

    return gameResults_array;
end

KTBM_Data_GetBestGameResultByStatistic = function(string_variableName)
    print(" ");
    print("---GETTING BEST GAME RESULT---");

    local strings_gameResultFilePaths = {};
    local string_fileExtension = ".txt";

    if(KTBM_Core_Project_GameResultsBinaryFormat == true) then
        string_fileExtension = ".bin";
    end

    ---------------------------------------------------
    --Get all files in the directory sorted by creation date

    local handle = io.popen('dir "'.. string_mainDirectoryName .. '" /b /a-d /o:d'); --sorts files by creation date
    local output = handle:read("*a");
    handle:close();

    for file in output:gmatch("[^\r\n]+") do
        local string_filePath = string_mainDirectoryName .. '\\' ..file;

        if(string.match(string_filePath, string_fileExtension)) then
            table.insert(strings_gameResultFilePaths, string_filePath);
        end
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

    print("---FINISHED GETTING BEST GAME RESULT---");
    print(" ");

    return gameResultsObject_bestResults;
end