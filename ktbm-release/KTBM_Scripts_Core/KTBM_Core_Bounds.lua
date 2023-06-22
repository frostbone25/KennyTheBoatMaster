--[[
    This script has functions to help with object bounding boxes.

    What are object bounding boxes? You can think of them as
    boxes that fully encompass whatever object you are messing with.

    Bounding Boxes are used to do MANY different things.
        1. Render Culling: 
            Rather than checking every polygon/vertex of the model,
            the bounds of the object is used as a simplified representation of the model.
            The bounds of that object is then checked against the camera frustum.
            If the bounds of the object is not inside the camera frustum then
            it is not in view and therefore culled (or hidden).
        2. Collision Detection: 
            For physics detection to check if two objects are intersecting eachothers bounds.
            If they are then that means a collision has occured.
        3. Trigger Detection:
            Similar to collision detection (though simpler), we can check if two objects are
            intersecting eachothers bounds, and from there we can trigger an event.
        4. Position Detection: 
            Similar to Trigger/Collision detection except we can check if a single point
            in space is inside the bounds of an object.

    There are more use cases for bounding boxes than I've listed here but that
    should give an idea on how useful bounding boxes are in development.
    They are a simplified representation of the object, which also makes
    them very fast especially when usually these operations need to be done
    multiple times over many frames.
]]

--references
--Unity3d Bounds C# - https://github.com/Unity-Technologies/UnityCsReference/blob/master/Runtime/Export/Geometry/Bounds.cs
--should note that this isnt a 1:1 implementation of the bounds class from unity, but it is very inspired by it.
--reason being that there are some things here in telltale that are done differently and need to be accounted for.

--|||||||||||||||||||||||||||||||||||||||||||||| TELLTALE BOUNDS ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| TELLTALE BOUNDS ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| TELLTALE BOUNDS ||||||||||||||||||||||||||||||||||||||||||||||
--The telltale tool appears to have a proper OBB implementation native within the engine that works well.
--In here are methods that help extend it.

--does an intersection test between two bounding boxes
--AgentCollide(agent1, agent2) returns bool

--AgentGetCorner(agent1, index) returns vector3
--if ( v2 & 1 )
--v5 = v4->mBoundingBox.mMin.x;
--else
--v5 = v4->mBoundingBox.mMax.x;
--vec.x = v5;
--if ( v2 & 2 )
--v6 = v4->mBoundingBox.mMin.y;
--else
--v6 = v4->mBoundingBox.mMax.y;
--vec.y = v6;
--if ( v2 & 4 )
--v7 = v4->mBoundingBox.mMin.z;
--else
--v7 = v4->mBoundingBox.mMax.z;

--Corrects the bounding box on an agent to factor in the objects scale.
KTBM_Bounds_AgentSetCorrectBounds = function(agent_object)
    --we need to access the agent properties to get what we need
    local props_agentProperties = AgentGetRuntimeProperties(agent_object);

    --get the native extents values that are already defined on these objects
    local vector_extentsMin = PropertyGet(props_agentProperties, "Extents Min");
    local vector_extentsMax = PropertyGet(props_agentProperties, "Extents Max");

    --now it's important to note that after some testing its apparent that these extents do not factor in scaling.
    --so we have to modify them to factor in scaling to ensure that they will work correctly for objects even if their scale changes.

    --store these in a new variable so we don't override the original value
    local vector_adjustedExtentsMin = vector_extentsMin;
    local vector_adjustedExtentsMax = vector_extentsMax;

    ---------------------------------------------------------
    --first step is to apply the object scaling, which is thankfully very simple to do
    
    --get the render scaling values
    local number_renderGlobalScale = PropertyGet(props_agentProperties, "Render Global Scale"); --single scalar value
    local vector_renderAxisScale = PropertyGet(props_agentProperties, "Render Axis Scale"); --vector scale value

    --apply the render scalar value
    vector_adjustedExtentsMin = VectorScale(vector_adjustedExtentsMin, number_renderGlobalScale);
    vector_adjustedExtentsMax = VectorScale(vector_adjustedExtentsMax, number_renderGlobalScale);

    --apply the render axis scale vector
    vector_adjustedExtentsMin = KTBM_VectorMultiply(vector_adjustedExtentsMin, vector_renderAxisScale);
    vector_adjustedExtentsMax = KTBM_VectorMultiply(vector_adjustedExtentsMax, vector_renderAxisScale);

    --now apply the modified extents
    PropertySet(props_agentProperties, "Extents Min", vector_adjustedExtentsMin);
    PropertySet(props_agentProperties, "Extents Max", vector_adjustedExtentsMax);
end

--|||||||||||||||||||||||||||||||||||||||||||||| AXIS-ALIGNED BOUNDING BOX (AABB) ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| AXIS-ALIGNED BOUNDING BOX (AABB) ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| AXIS-ALIGNED BOUNDING BOX (AABB) ||||||||||||||||||||||||||||||||||||||||||||||
--Soooooooo to cut a long story short, this is a manual implemntation of AABB.
--This was done before discovering that telltale actually had a proper in-engine implementation for it with AgentCollide.
--However I am keeping this for archival and future purposes in a rare case where one needs to do custom bounds.

--[[
BoundsAABB Object Reference

local BoundsAABB_Object = {
    size = Vector,
    extents = Vector,
    center = Vector,
    min = Vector,
    max = Vector
};
--]]

--This is a function for getting a box collider of a given object, which can be used to test against other colliders for collisions
KTBM_Bounds_GetAgentWorldBounds_AABB = function(agent_object)
    --we need to access the agent properties to get what we need
    local props_agentProperties = AgentGetRuntimeProperties(agent_object);

    --get the native extents values that are already defined on these objects
    local vector_extentsMin = PropertyGet(props_agentProperties, "Extents Min");
    local vector_extentsMax = PropertyGet(props_agentProperties, "Extents Max");

    --now it's important to note that after some testing its apparent that these extents are only in "local" object space.
    --when any transformations are applied on the object (position, rotation, scale) these values are unaffected.
    --so in order to use them we need to adjust these values to work for world space.

    --store these in a new variable so we don't override the original value
    local vector_adjustedExtentsMin = vector_extentsMin;
    local vector_adjustedExtentsMax = vector_extentsMax;

    ---------------------------------------------------------
    --first step is to apply the object scaling, which is thankfully very simple to do
    
    --get the render scaling values
    local number_renderGlobalScale = PropertyGet(props_agentProperties, "Render Global Scale"); --single scalar value
    local vector_renderAxisScale = PropertyGet(props_agentProperties, "Render Axis Scale"); --vector scale value

    --apply the render scalar value
    vector_adjustedExtentsMin = VectorScale(vector_adjustedExtentsMin, number_renderGlobalScale);
    vector_adjustedExtentsMax = VectorScale(vector_adjustedExtentsMax, number_renderGlobalScale);

    --apply the render axis scale vector
    vector_adjustedExtentsMin = KTBM_VectorMultiply(vector_adjustedExtentsMin, vector_renderAxisScale);
    vector_adjustedExtentsMax = KTBM_VectorMultiply(vector_adjustedExtentsMax, vector_renderAxisScale);

    ---------------------------------------------------------
    --second step, apply object position and rotation

    --transform these local space vectors into world space (this will natrually apply position and rotation transformations)
    vector_adjustedExtentsMin = AgentLocalToWorld(agent_object, vector_adjustedExtentsMin);
    vector_adjustedExtentsMax = AgentLocalToWorld(agent_object, vector_adjustedExtentsMax);

    ---------------------------------------------------------
    --calculate the following values that we can store in our new "Bounds" object.

    --calculate extents from min and max
    local vector_extents = VectorSubtract(vector_adjustedExtentsMax, vector_adjustedExtentsMin);
    vector_extents = VectorScale(vector_extents, 0.5);

    --calculate scale, which is just extents * 2
    local vector_scale = VectorScale(vector_extents, 2.0);

    --calculate the origin point of this bounds object
    local vector_center = VectorAdd(vector_adjustedExtentsMin, vector_extents);

    --build our bounds object and store the computed values
    local boundsAABB_newBoundsObject = {
        size = vector_scale,
        extents = vector_extents,
        center = vector_center,
        min = vector_adjustedExtentsMin,
        max = vector_adjustedExtentsMax
    };

    return boundsAABB_newBoundsObject;
end

--Sets the bounds to the vector_min and vector_max value and returns a new AABB bounds object
KTBM_Bounds_AABB_SetMinMax = function(vector_min, vector_max)
    --recalculate extents
    local vector_adjustedExtents = VectorSubtract(vector_max, vector_min);
    vector_adjustedExtents = VectorScale(vector_adjustedExtents, 0.5);

    --recalculate scale, which is just extents * 2
    local vector_adjustedScale = VectorScale(vector_adjustedExtents, 2.0);

    --recalculate the center
    local vector_adjustedCenter = VectorAdd(vector_min, vector_adjustedExtents);

    local bounds_newAABB = {
        size = vector_adjustedScale,
        extents = vector_adjustedExtents,
        center = vector_adjustedCenter,
        min = vector_min,
        max = vector_max
    };

    return bounds_newAABB;
end

--Grows the AABB Bounds to include the vector_point and returns a new AABB bounds object
KTBM_Bounds_AABB_Encapsulate = function(boundsAABB, vector_point)
    local vector_newMin = KTBM_VectorMin(boundsAABB["min"], vector_point);
    local vector_newMax = KTBM_VectorMax(boundsAABB["max"], vector_point);

    return KTBM_Bounds_AABB_SetMinMax(vector_newMin, vector_newMax);
end

--This is an extended version of the original AABB function.
--The difference is that this accounts for object orentation.
--This is achieved by reconstructing the 8 corners of this bounding box (which would be already rotated),
--and using the encapsulation method, grow the bounds to these 8 points.
--the downside is that sometimes when the object is rotated, their bounding box will become very large,
--(which can make a collision happen seemingly a distance away from the original object)
KTBM_Bounds_GetAgentWorldBounds_AABB_Orientation = function(agent_object)
    local boundsAABB_objectBounds = KTBM_Bounds_GetAgentWorldBounds_AABB(agent_object);

    local vector_currentBoundsMin = boundsAABB_objectBounds["min"];
    local vector_currentBoundsMax = boundsAABB_objectBounds["max"];

    local vector_boundPoint1 = vector_currentBoundsMin;
    local vector_boundPoint2 = vector_currentBoundsMax;
    local vector_boundPoint3 = Vector(vector_boundPoint1.x, vector_boundPoint1.y, vector_boundPoint2.z);
    local vector_boundPoint4 = Vector(vector_boundPoint1.x, vector_boundPoint2.y, vector_boundPoint1.z);
    local vector_boundPoint5 = Vector(vector_boundPoint2.x, vector_boundPoint1.y, vector_boundPoint1.z);
    local vector_boundPoint6 = Vector(vector_boundPoint1.x, vector_boundPoint2.y, vector_boundPoint2.z);
    local vector_boundPoint7 = Vector(vector_boundPoint2.x, vector_boundPoint1.y, vector_boundPoint2.z);
    local vector_boundPoint8 = Vector(vector_boundPoint2.x, vector_boundPoint2.y, vector_boundPoint1.z);

    boundsAABB_objectBounds = KTBM_Bounds_AABB_Encapsulate(boundsAABB_objectBounds, vector_boundPoint3);
    boundsAABB_objectBounds = KTBM_Bounds_AABB_Encapsulate(boundsAABB_objectBounds, vector_boundPoint4);
    boundsAABB_objectBounds = KTBM_Bounds_AABB_Encapsulate(boundsAABB_objectBounds, vector_boundPoint5);
    boundsAABB_objectBounds = KTBM_Bounds_AABB_Encapsulate(boundsAABB_objectBounds, vector_boundPoint6);
    boundsAABB_objectBounds = KTBM_Bounds_AABB_Encapsulate(boundsAABB_objectBounds, vector_boundPoint7);
    boundsAABB_objectBounds = KTBM_Bounds_AABB_Encapsulate(boundsAABB_objectBounds, vector_boundPoint8);

    return boundsAABB_objectBounds;
end

--Do an intersection test between two AABB objects
KTBM_Bounds_IntersectAABB = function(boundsAABB_1, boundsAABB_2)
    local bool_case1 = boundsAABB_1["min"].x <= boundsAABB_2["max"].x;
    local bool_case2 = boundsAABB_1["max"].x >= boundsAABB_2["min"].x;
    local bool_case3 = boundsAABB_1["min"].y <= boundsAABB_2["max"].y;
    local bool_case4 = boundsAABB_1["max"].y >= boundsAABB_2["min"].y;
    local bool_case5 = boundsAABB_1["min"].z <= boundsAABB_2["max"].z;
    local bool_case6 = boundsAABB_1["max"].z >= boundsAABB_2["min"].z;
    
    return bool_case1 and bool_case2 and bool_case3 and bool_case4 and bool_case5 and bool_case6;
end

--|||||||||||||||||||||||||||||||||||||||||||||| ORIENTED BOUNDING BOX (OBB) ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| ORIENTED BOUNDING BOX (OBB) ||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||| ORIENTED BOUNDING BOX (OBB) ||||||||||||||||||||||||||||||||||||||||||||||
--this comes from - https://stackoverflow.com/questions/47866571/simple-oriented-bounding-box-obb-collision-detection-explaining
--NOTE: This is incomplete and doesn't work

--potential new refernece? - https://github.com/mrdoob/three.js/blob/master/examples/jsm/math/OBB.js

--[[
local BoundsOBB_Object = {
    center = Vector,
    size = Vector,
    extents = Vector,
    axisX = Vector,
    axisY = Vector,
    axisZ = Vector
};
--]]

KTBM_Bounds_GetAgentWorldBounds_OBB = function(agent_object)
    --we need to access the agent properties to get what we need
    local props_agentProperties = AgentGetRuntimeProperties(agent_object);

    --get the native extents values that are already defined on these objects
    local vector_extentsMin = PropertyGet(props_agentProperties, "Extents Min");
    local vector_extentsMax = PropertyGet(props_agentProperties, "Extents Max");

    --now it's important to note that after some testing its apparent that these extents are only in "local" object space.
    --when any transformations are applied on the object (position, rotation, scale) these values are unaffected.
    --so in order to use them we need to adjust these values to work for world space.

    --store these in a new variable so we don't override the original value
    local vector_adjustedExtentsMin = vector_extentsMin;
    local vector_adjustedExtentsMax = vector_extentsMax;

    ---------------------------------------------------------
    --first step is to apply the object scaling, which is thankfully very simple to do
    
    --get the render scaling values
    local number_renderGlobalScale = PropertyGet(props_agentProperties, "Render Global Scale"); --single scalar value
    local vector_renderAxisScale = PropertyGet(props_agentProperties, "Render Axis Scale"); --vector scale value

    --apply the render scalar value
    vector_adjustedExtentsMin = VectorScale(vector_adjustedExtentsMin, number_renderGlobalScale);
    vector_adjustedExtentsMax = VectorScale(vector_adjustedExtentsMax, number_renderGlobalScale);

    --apply the render axis scale vector
    vector_adjustedExtentsMin = KTBM_VectorMultiply(vector_adjustedExtentsMin, vector_renderAxisScale);
    vector_adjustedExtentsMax = KTBM_VectorMultiply(vector_adjustedExtentsMax, vector_renderAxisScale);

    ---------------------------------------------------------
    --second step, apply object position and rotation

    --transform these local space vectors into world space (this will natrually apply position and rotation transformations)
    vector_adjustedExtentsMin = AgentLocalToWorld(agent_object, vector_adjustedExtentsMin);
    vector_adjustedExtentsMax = AgentLocalToWorld(agent_object, vector_adjustedExtentsMax);

    ---------------------------------------------------------
    --third step, get object axis

    --transform these local space vectors into world space (this will natrually apply position and rotation transformations)
    local vector_objectX = AgentLocalToWorld(agent_object, Vector(1, 0, 0));
    local vector_objectY = AgentLocalToWorld(agent_object, Vector(0, 1, 0));
    local vector_objectZ = AgentLocalToWorld(agent_object, Vector(0, 0, 1));

    ---------------------------------------------------------
    --calculate the following values that we can store in our new "Bounds" object.

    --calculate extents from min and max
    local vector_extents = VectorSubtract(vector_adjustedExtentsMax, vector_adjustedExtentsMin);
    vector_extents = VectorScale(vector_extents, 0.5);

    --calculate scale, which is just extents * 2
    local vector_scale = VectorScale(vector_extents, 2.0);

    --calculate the origin point of this bounds object
    local vector_center = VectorAdd(vector_adjustedExtentsMin, vector_extents);

    --build our bounds object and store the computed values
    local boundsOBB_newBoundsObject = {
        center = vector_center,
        size = vector_scale,
        extents = vector_extents,
        axisX = vector_objectX,
        axisY = vector_objectY,
        axisZ = vector_objectZ,
    };

    return boundsOBB_newBoundsObject;
end

-- check if there's a separating plane in between the selected axes
KTBM_Bounds_OBB_GetSeparatingPlane = function(vector_rpos, vector_plane, boundsOBB_1, boundsOBB_2)
    local term1 = math.abs(VectorDot(vector_rpos, vector_plane));
    local term2 = math.abs(VectorDot(boundsOBB_1["axisX"] * boundsOBB_1["extents"].x, vector_plane));
    local term3 = math.abs(VectorDot(boundsOBB_1["axisY"] * boundsOBB_1["extents"].y, vector_plane));
    local term4 = math.abs(VectorDot(boundsOBB_1["axisZ"] * boundsOBB_1["extents"].z, vector_plane));
    local term5 = math.abs(VectorDot(boundsOBB_2["axisX"] * boundsOBB_2["extents"].x, vector_plane));
    local term6 = math.abs(VectorDot(boundsOBB_2["axisY"] * boundsOBB_2["extents"].y, vector_plane));
    local term7 = math.abs(VectorDot(boundsOBB_2["axisZ"] * boundsOBB_2["extents"].z, vector_plane));

    return (term1 > (term2 + term3 + term4 + term5 + term6 + term7));
end

-- test for separating planes in all 15 axes
KTBM_Bounds_OBB_IntersectTest = function(boundsOBB_1, boundsOBB_2)
    local vector_rpos = VectorSubtract(boundsOBB_2["center"], boundsOBB_1["center"]);

    return (KTBM_Bounds_OBB_GetSeparatingPlane(vector_rpos, boundsOBB_1["axisX"], boundsOBB_1, boundsOBB_2) or
        KTBM_Bounds_OBB_GetSeparatingPlane(vector_rpos, boundsOBB_1["axisY"], boundsOBB_1, boundsOBB_2) or
        KTBM_Bounds_OBB_GetSeparatingPlane(vector_rpos, boundsOBB_1["axisZ"], boundsOBB_1, boundsOBB_2) or
        KTBM_Bounds_OBB_GetSeparatingPlane(vector_rpos, boundsOBB_2["axisX"], boundsOBB_1, boundsOBB_2) or
        KTBM_Bounds_OBB_GetSeparatingPlane(vector_rpos, boundsOBB_2["axisY"], boundsOBB_1, boundsOBB_2) or
        KTBM_Bounds_OBB_GetSeparatingPlane(vector_rpos, boundsOBB_2["axisZ"], boundsOBB_1, boundsOBB_2) or
        KTBM_Bounds_OBB_GetSeparatingPlane(vector_rpos, VectorCross(boundsOBB_1["axisX"], boundsOBB_2["axisX"]), boundsOBB_1, boundsOBB_2) or
        KTBM_Bounds_OBB_GetSeparatingPlane(vector_rpos, VectorCross(boundsOBB_1["axisX"], boundsOBB_2["axisY"]), boundsOBB_1, boundsOBB_2) or
        KTBM_Bounds_OBB_GetSeparatingPlane(vector_rpos, VectorCross(boundsOBB_1["axisX"], boundsOBB_2["axisZ"]), boundsOBB_1, boundsOBB_2) or
        KTBM_Bounds_OBB_GetSeparatingPlane(vector_rpos, VectorCross(boundsOBB_1["axisY"], boundsOBB_2["axisX"]), boundsOBB_1, boundsOBB_2) or
        KTBM_Bounds_OBB_GetSeparatingPlane(vector_rpos, VectorCross(boundsOBB_1["axisY"], boundsOBB_2["axisY"]), boundsOBB_1, boundsOBB_2) or
        KTBM_Bounds_OBB_GetSeparatingPlane(vector_rpos, VectorCross(boundsOBB_1["axisY"], boundsOBB_2["axisZ"]), boundsOBB_1, boundsOBB_2) or
        KTBM_Bounds_OBB_GetSeparatingPlane(vector_rpos, VectorCross(boundsOBB_1["axisZ"], boundsOBB_2["axisX"]), boundsOBB_1, boundsOBB_2) or
        KTBM_Bounds_OBB_GetSeparatingPlane(vector_rpos, VectorCross(boundsOBB_1["axisZ"], boundsOBB_2["axisY"]), boundsOBB_1, boundsOBB_2) or
        KTBM_Bounds_OBB_GetSeparatingPlane(vector_rpos, VectorCross(boundsOBB_1["axisZ"], boundsOBB_2["axisZ"]), boundsOBB_1, boundsOBB_2));
end