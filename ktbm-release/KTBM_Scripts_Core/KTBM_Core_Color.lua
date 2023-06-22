--[[
    This script has functions to help with colors
    
    These functions include artistic functions for controlling and managing colors.
]]

--||||||||||||||||||||| CUSTOM COLOR FUNCTIONS |||||||||||||||||||||
--||||||||||||||||||||| CUSTOM COLOR FUNCTIONS |||||||||||||||||||||
--||||||||||||||||||||| CUSTOM COLOR FUNCTIONS |||||||||||||||||||||
--I use this to get a little more control in regards to creating/modifying colors.
--There is no visual color picker within the telltale tool that we have access to...
--so these are here to help in regards to geussing and getting the right color easily

--desaturates a regular color
--color = Color(r,g,b,a) object
--amount = number (desaturation amount)
--RETURNS: Color
Desaturate_RGBColor = function(color_input, number_amount)
    local number_lumanince = 0.3 * color_input.r + 0.6 * color_input.g + 0.1 * color_input.b;
    
    color_input.r = color_input.r + number_amount * (number_lumanince - color_input.r);
    color_input.g = color_input.g + number_amount * (number_lumanince - color_input.g);
    color_input.b = color_input.b + number_amount * (number_lumanince - color_input.b);
    
    return color_input;
end

--multiplies a regular color (can be used to brighten or darken)
--color = Color(r,g,b,a) object
--amount = number (multipler amount)
--RETURNS: Color
Multiplier_RGBColor = function(color_input, number_amount)
    local number_multiplier = 1.0 * number_amount;
    
    color_input.r = color_input.r * number_multiplier;
    color_input.g = color_input.g * number_multiplier;
    color_input.b = color_input.b * number_multiplier;
    
    return color_input;
end

--a regular telltale color wrapper, but these values take in numbers from (0 - 255) and scale it down to (0 - 1) 
--r = (RED) number (0 - 255)
--g = (GREEN) number (0 - 255)
--b = (BLUE) number (0 - 255)
--a = (ALPHA) number (0 - 255)
--RETURNS: Color
RGBColor = function(number_r, number_g, number_b, number_a)
    local number_scalar  = 1 / 255;
    
    local number_scaledR = number_r * number_scalar;
    local number_scaledG = number_g * number_scalar;
    local number_scaledB = number_b * number_scalar;
    local number_scaledA = number_a * number_scalar;
    
    return Color(number_scaledR, number_scaledG, number_scaledB, number_scaledA);
end