--[[
    Since the Telltale Tool uses only Lua 5.2, we unfortunately don't have access to the handy
    String.Pack or String.Unpack functions supported in 5.3 which make binary formatting incredibly easy.
    So we have to implement these binary formatting functions ourselves.
]]

--|||||||||||||||||||||||||||||||||||||||||||| INTEGER 32-BIT (4 BYTES) ||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||| INTEGER 32-BIT (4 BYTES) ||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||| INTEGER 32-BIT (4 BYTES) ||||||||||||||||||||||||||||||||||||||||||||

KTBM_Binary_PackInt32 = function(number_value)
    -- Extracting individual bytes of the number
    local number_byte1 = number_value % 256;
    local number_byte2 = math.floor(number_value / 256) % 256;
    local number_byte3 = math.floor(number_value / 65536) % 256;
    local number_byte4 = math.floor(number_value / 16777216) % 256;

    -- Constructing the binary string using the individual bytes
    return string.char(number_byte1, number_byte2, number_byte3, number_byte4);
end

KTBM_Binary_UnpackInt32 = function(encodedString)
    -- Extracting individual bytes from the encoded string
    local number_byte1 = encodedString:byte(1);
    local number_byte2 = encodedString:byte(2);
    local number_byte3 = encodedString:byte(3);
    local number_byte4 = encodedString:byte(4);

    -- Calculating the integer value by combining the bytes
    return number_byte1 + number_byte2 * 256 + number_byte3 * 65536 + number_byte4 * 16777216;
end

--|||||||||||||||||||||||||||||||||||||||||||| FLOAT 32-BIT (4 BYTES) ||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||| FLOAT 32-BIT (4 BYTES) ||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||| FLOAT 32-BIT (4 BYTES) ||||||||||||||||||||||||||||||||||||||||||||

KTBM_Binary_PackFloat = function(number_value)
    -- Bitmask used for handling infinity and NaN values
    local number_infinityBitmask = 2^32 - 2^22
    local string_binaryString = "" -- Resulting binary string
    local number_significand, number_exponent, number_increment = 1, 1, 1 -- Variables for intermediate calculations
    
    if (number_value == number_value) then -- Checking if value is not NaN
        number_infinityBitmask = 2^31 - 2^23 -- Bitmask for positive infinity
        
        if (number_value < 0 or (number_value == 0 and 1/number_value < 0)) then
            number_value, number_infinityBitmask = -number_value, 2^32 - 2^23 -- Bitmask for negative infinity
        end
        
        if (number_value > 0.5 * 2^-149 and number_value < 2^128) then
            -- Rounding 64-bit double to 32-bit float
            number_exponent = math.floor(math.log(number_value) / math.log(2) + 0.5)
            number_exponent = (number_value < 2^number_exponent) and (number_exponent - 1) or number_exponent
            local number_epsilon = 2^((number_exponent < -126) and -149 or (number_exponent - 23)) -- Smallest positive number
            number_value = number_value + 0.5 * number_epsilon
            local number_remainder = number_value % number_epsilon
            number_value = number_value - ((number_remainder == 0) and (number_value % (number_epsilon + number_epsilon)) or number_remainder)
        end
        
        -- Dumping 32-bit image of float
        if (number_value < 2^-149) then
            number_infinityBitmask = number_infinityBitmask - (2^31 - 2^23) -- Bitmask for denormalized numbers
        elseif (number_value <= 2^128 - 2^104) then
            if (number_exponent < -126) then
                number_exponent, number_increment = -126, 0 -- Exponent and increment for denormalized numbers
            end
            number_infinityBitmask = number_infinityBitmask + ((number_value / 2^number_exponent) + ((number_exponent - (-126)) * number_increment) - 255) * 2^23
        end
    end
    
    -- Convert 32-bit image to little-endian binary string
    while (#string_binaryString < 4) do
        local byte = number_infinityBitmask % 256
        string_binaryString = string_binaryString .. string.char(byte)
        number_infinityBitmask = (number_infinityBitmask - byte) / 256
    end
    
    return string_binaryString
end

KTBM_Binary_UnpackFloat = function(string_binaryEncodedString)
    -- Extracting the significand bytes and combining them
    local number_significand = (string_binaryEncodedString:byte(3) % 0x80) * 0x10000 + string_binaryEncodedString:byte(2) * 0x100 + string_binaryEncodedString:byte(1);

    -- Extracting the exponent byte and calculating the exponent value
    local number_exponent = (string_binaryEncodedString:byte(4) % 0x80) * 2 + math.floor(string_binaryEncodedString:byte(3) / 0x80) - 0x7F;

    -- Handling special case: if exponent is 0x7F, the value is 0
    if (number_exponent == 0x7F) then
        return 0;
    end

    -- Calculating the decoded float value
    return math.ldexp(math.ldexp(number_significand, -23) + 1, number_exponent) * (string_binaryEncodedString:byte(4) < 0x80 and 1 or -1);
end