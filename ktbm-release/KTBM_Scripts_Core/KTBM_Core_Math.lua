--references
--Unity3d Vector3 C# - https://github.com/Unity-Technologies/UnityCsReference/blob/master/Runtime/Export/Math/Vector3.cs
--Unity3d Mathf C# - https://github.com/Unity-Technologies/UnityCsReference/blob/master/Runtime/Export/Math/Mathf.cs

--|||||||||||||||||||||||||||||||||||||||||||| MATH VARIABLES ||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||| MATH VARIABLES ||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||| MATH VARIABLES ||||||||||||||||||||||||||||||||||||||||||||

--PI constant
KTBM_Math_PI = math.pi;

--Degrees-to-radians conversion constant (RO).
KTBM_Math_Deg2Rad = KTBM_Math_PI * 2 / 360;

--Radians-to-degrees conversion constant (RO).
KTBM_Math_Rad2Deg = 1 / KTBM_Math_Deg2Rad;

--|||||||||||||||||||||||||||||||||||||||||||| MATH FUNCTIONS - NUMBER ||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||| MATH FUNCTIONS - NUMBER ||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||| MATH FUNCTIONS - NUMBER ||||||||||||||||||||||||||||||||||||||||||||

KTBM_Clamp = function(number_value, number_minimum, number_maximum)
    if (number_value > number_maximum) then
        return number_maximum;
    elseif (number_value < number_minimum) then
        return number_minimum;
    else
        return number_value;
    end
end

KTBM_Repeat = function(number_value, number_length)
    return KTBM_Clamp(number_value - math.floor(number_value / number_length) * number_length, 0.0, number_length);
end

KTBM_PingPong = function(number_value, number_length)
    number_value = KTBM_Repeat(number_value, number_length * 2);
    return number_length - math.abs(number_value - number_length);
end

KTBM_NumberLerp = function(number_valueA, number_valueB, number_transition)
    return number_valueA + (number_valueB - number_valueA) * number_transition;
end

KTBM_Smoothstep = function(number_valueA, number_valueB, number_transition)
    return number_valueA + (number_valueB - number_valueA) * ( (-2 * math.pow(number_transition, 3)) + (3 * math.pow(number_transition, 2)) );
end

KTBM_NumberSign = function(number_value)
    if (number_value >= 0) then
        return 1;
    else
        return -1;
    end
end

KTBM_RandomIntegerValue = function(number_min, number_max)
    local number_randomValue = math.random(number_min, number_max);

    return number_randomValue;
end

KTBM_RandomFloatValue = function(number_min, number_max, number_decimals)
    local number_randomValue = math.random(number_min * number_decimals, number_max * number_decimals);
    local number_randomValueAdjusted = number_randomValue / number_decimals;

    return number_randomValueAdjusted;
end

KTBM_NumberRound = function(number_value, number_decimals)
    local mult = 10^(number_decimals or 0);
    
    return math.floor(number_value * mult + 0.5) / mult;
end

KTBM_NumberModulo = function(number_valueA, number_valueB)
    return number_valueA - math.floor(number_valueA/number_valueB) * number_valueB;
end

--|||||||||||||||||||||||||||||||||||||||||||| MATH FUNCTIONS - VECTOR ||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||| MATH FUNCTIONS - VECTOR ||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||| MATH FUNCTIONS - VECTOR ||||||||||||||||||||||||||||||||||||||||||||

KTBM_VectorMultiply = function(vector_a, vector_b)
    local number_newX = vector_a.x * vector_b.x;
    local number_newY = vector_a.y * vector_b.y;
    local number_newZ = vector_a.z * vector_b.z;

    return Vector(number_newX, number_newY, number_newZ);
end

-- Returns a vector that is made from the smallest components of two vectors.
KTBM_VectorMin = function(vector_a, vector_b)
    local number_newX = math.min(vector_a.x, vector_b.x);
    local number_newY = math.min(vector_a.y, vector_b.y);
    local number_newZ = math.min(vector_a.z, vector_b.z);

    return Vector(number_newX, number_newY, number_newZ);
end

-- Returns a vector that is made from the largest components of two vectors.
KTBM_VectorMax = function(vector_a, vector_b)
    local number_newX = math.max(vector_a.x, vector_b.x);
    local number_newY = math.max(vector_a.y, vector_b.y);
    local number_newZ = math.max(vector_a.z, vector_b.z);

    return Vector(number_newX, number_newY, number_newZ);
end

KTBM_VectorLerp = function(vector_a, vector_b, number_transition)
    local number_newX = KTBM_NumberLerp(vector_a.x, vector_b.x, number_transition);
    local number_newY = KTBM_NumberLerp(vector_a.y, vector_b.y, number_transition);
    local number_newZ = KTBM_NumberLerp(vector_a.z, vector_b.z, number_transition);
    
    return Vector(number_newX, number_newY, number_newZ);
end

KTBM_VectorSmoothstep = function(a, b, t)
    local number_newX = KTBM_Smoothstep(a.x, b.x, t);
    local number_newY = KTBM_Smoothstep(a.y, b.y, t);
    local number_newZ = KTBM_Smoothstep(a.z, b.z, t);
    
    return Vector(number_newX, number_newY, number_newZ);
end

--Reflects a vector off the plane defined by a normal.
KTBM_VectorReflect = function(vector_inDirection, vector_inNormal)
    local number_factor = -2 * VectorDot(vector_inNormal, vector_inDirection);

    local number_result_x = number_factor * vector_inNormal.x + vector_inDirection.x;
    local number_result_y = number_factor * vector_inNormal.y + vector_inDirection.y;
    local number_result_z = number_factor * vector_inNormal.z + vector_inDirection.z;

    return Vector(number_result_x, number_result_y, number_result_z);
end

--Returns the angle in degrees between /from/ and /to/. This is always the smallest
KTBM_VectorAngle = function(vector_from, vector_to)
    local sqrMagnitude_from = VectorLengthSq(vector_from);
    local sqrMagnitude_to = VectorLengthSq(vector_to);

    local denominator = math.sqrt(sqrMagnitude_from * sqrMagnitude_to);

    local vector_dot = VectorDot(vector_from, vector_to);

    local dot_product = KTBM_Clamp(vector_dot / denominator, -1, 1);

    local result = math.acos(dot_product) * KTBM_Math_Rad2Deg;

    return result;
end

--The smaller of the two possible angles between the two vectors is returned, therefore the result will never be greater than 180 degrees or smaller than -180 degrees.
--If you imagine the from and to vectors as lines on a piece of paper, both originating from the same point, then the /axis/ vector would point up out of the paper.
--The measured angle between the two vectors would be positive in a clockwise direction and negative in an anti-clockwise direction.
KTBM_VectorSignedAngle = function(vector_from, vector_to, vector_axis)
    local unsignedAngle = KTBM_VectorAngle(vector_from, vector_to);

    local cross_x = vector_from.y * vector_to.z - vector_from.z * vector_to.y;
    local cross_y = vector_from.z * vector_to.x - vector_from.x * vector_to.z;
    local cross_z = vector_from.x * vector_to.y - vector_from.y * vector_to.x;
    local total_cross = axis.x * cross_x + axis.y * cross_y + axis.z * cross_z;

    local sign = KTBM_NumberSign(total_cross);

    return unsignedAngle * sign;
end

--|||||||||||||||||||||||||||||||||||||||||||| MATH FUNCTIONS - COLOR ||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||| MATH FUNCTIONS - COLOR ||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||| MATH FUNCTIONS - COLOR ||||||||||||||||||||||||||||||||||||||||||||

KTBM_ColorLerp = function(color_a, color_b, number_transition)
    local number_newColorR = KTBM_NumberLerp(color_a.r, color_b.r, number_transition);
    local number_newColorG = KTBM_NumberLerp(color_a.g, color_b.g, number_transition);
    local number_newColorB = KTBM_NumberLerp(color_a.b, color_b.b, number_transition);
    local number_newColorA = KTBM_NumberLerp(color_a.a, color_b.a, number_transition);

    return Color(number_newColorR, number_newColorG, number_newColorB, number_newColorA);
end