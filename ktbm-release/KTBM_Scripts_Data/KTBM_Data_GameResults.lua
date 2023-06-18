--disk path
local string_mainDirectoryName = "KennyTheBoatMaster";
local string_baseFilePath = string_mainDirectoryName .. "/GameResults";

--config file data
KTBM_Data_CurrentGameResults = nil;

KTBM_Data_BuildGameResultsObject = function(number_distanceTraveled, number_zombiesKilled, number_totalTime)
    local gameResults_object = {
        DistanceTraveled = number_distanceTraveled,
        ZombiesKilled = number_zombiesKilled,
        TotalTime = number_totalTime
    };

    return gameResults_object;
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

    local gameResults_parsedObject = {
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

    local gameResults_parsedObject = {
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

    local mostRecentFilePath = nil
    local fileExtension = ".txt";

    if(KTBM_Core_Project_GameResultsBinaryFormat == true) then
        fileExtension = ".bin";
    end

    --local handle = io.popen('dir "'.. string_mainDirectoryName ..'" /b /a-d');
    local handle = io.popen('dir "'.. string_mainDirectoryName .. '" /b /a-d /o:d'); --sorts files by creation date
    local output = handle:read("*a");
    handle:close();

    for file in output:gmatch("[^\r\n]+") do
        local filePath = string_mainDirectoryName .. '\\' ..file;

        if(string.match(filePath, fileExtension)) then
            mostRecentFilePath = filePath;
        end
    end

    local gameResults_parsedObject = {};

    if(KTBM_Core_Project_GameResultsBinaryFormat == true) then
        print("Getting most recent 'Game Results' in binary from the following file path...");
        print(mostRecentFilePath);

        gameResults_parsedObject = KTBM_Data_DeserializeGameResultsObject_Binary(mostRecentFilePath);
    else
        print("Getting most recent 'Game Results' in text from the following file path...");
        print(mostRecentFilePath);

        gameResults_parsedObject = KTBM_Data_DeserializeGameResultsObject_Text(mostRecentFilePath);
    end

    print("---FINISHED GETTING MOST RECENT GAME RESULTS---");
    print(" ");

    return gameResults_parsedObject;
end