--checks if a file exists
KTBM_FileExists = function(filePathRelativeToGameExe)
    --read the given file as a test
    local f = (io.open)(filePathRelativeToGameExe, "r");
    
    --if the file was opened, then it exists
    if f ~= nil then
        (io.close)(f);
        return true;
    else
        return false;
    end
end

KTBM_FileDelete = function(filePathRelativeToGameExe)
    os.remove(filePathRelativeToGameExe);
end

KTBM_DirectoryCreate = function(directoryPathRelativeToGameExe)
    --reference command: mkdir filterscripts\\account

    os.execute("mkdir " .. directoryPathRelativeToGameExe);
end

KTBM_DirectoryDelete = function(directoryPathRelativeToGameExe)
    os.remove(directoryPathRelativeToGameExe);
end