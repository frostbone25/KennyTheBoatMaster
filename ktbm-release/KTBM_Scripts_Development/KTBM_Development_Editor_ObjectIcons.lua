--[[

]]--

local number_gizmoSize = 0.025;

local string_envLightTypePropertyName = "EnvLight - Type";
local string_cameraFOVPropertyName = "Field of View";
local string_fogDensityPropertyName = "Env - Fog Density";

local string_texture_directional = "KTBM_Development_IconLightDirectional.d3dtx";
local string_texture_directionalAmbient = "KTBM_Development_IconLightDirectionalAmbient.d3dtx";
local string_texture_point = "KTBM_Development_IconLightPoint.d3dtx";
local string_texture_spot = "KTBM_Development_IconLightSpot.d3dtx";
local string_texture_ambient = "KTBM_Development_IconLightAmbient.d3dtx";
local string_texture_camera = "KTBM_Development_IconCamera.d3dtx";
local string_texture_fog = "KTBM_Development_IconFog.d3dtx";

local string_iconObject_referenceAgent = "Reference";
local string_iconObject_iconAgent = "Icon";

KTBM_Development_ObjectIcons_IconsCount = 1;
KTBM_Development_ObjectIcons_Icons = {};

local CanCreateIconForAgent = function(agent_referenceAgent)
    local bool_canCreateIconForAgent = false;

    if(AgentHasProperty(agent_referenceAgent, string_envLightTypePropertyName)) then
        bool_canCreateIconForAgent = true;
    end

    if(AgentHasProperty(agent_referenceAgent, string_cameraFOVPropertyName)) then
        bool_canCreateIconForAgent = true;
    end

    if(AgentHasProperty(agent_referenceAgent, string_fogDensityPropertyName)) then
        bool_canCreateIconForAgent = true;
    end

    return bool_canCreateIconForAgent;
end

local GetIconTexture = function(agent_referenceAgent)
    local string_iconTexture = "";
    local propertySet_referenceAgent = AgentGetRuntimeProperties(agent_referenceAgent);

    local number_lightEnvType = PropertyGet(propertySet_referenceAgent, string_envLightTypePropertyName);
    local number_cameraFOV = PropertyGet(propertySet_referenceAgent, string_cameraFOVPropertyName);
    local number_fogDensity = PropertyGet(propertySet_referenceAgent, string_fogDensityPropertyName);

    if(number_lightEnvType ~= nil) then
        if(number_lightEnvType == 0) then --eLightEnvType_Point
            string_iconTexture = string_texture_point;
        elseif(number_lightEnvType == 1) then --eLightEnvType_Spot
            string_iconTexture = string_texture_spot;
        elseif(number_lightEnvType == 2) then --eLightEnvType_DirectionalKey
            string_iconTexture = string_texture_directional;
        elseif(number_lightEnvType == 3) then --eLightEnvType_Ambient
            string_iconTexture = string_texture_ambient;
        elseif(number_lightEnvType == 4) then --eLightEnvType_DirectionalAmbient
            string_iconTexture = string_texture_directionalAmbient;
        end
    end

    if(number_cameraFOV ~= nil) then
        string_iconTexture = string_texture_camera;
    end

    if(number_fogDensity ~= nil) then
        string_iconTexture = string_texture_fog;
    end

    return string_iconTexture;
end

local CreateNewObjectIconAgent = function(agent_referenceAgent)
    local string_referenceAgentName = AgentGetName(agent_referenceAgent);
    local string_iconTexture = GetIconTexture(agent_referenceAgent);

    local string_newIconAgentName = "OBJECT_ICON_" .. string_referenceAgentName;
    local agent_newIconAgent = AgentCreate(string_newIconAgentName, "ui_boot_title.prop", Vector(0, 0, 0), Vector(0, 0, 0), KTBM_Development_SceneObject, false, false);

    KTBM_PropertySet(agent_newIconAgent, "Render Axis Scale", Vector(-1, 1, 1));
    KTBM_PropertySet(agent_newIconAgent, "Render Global Scale", number_gizmoSize);
    KTBM_PropertySet(agent_newIconAgent, "Render After Anti-Aliasing", true);
    KTBM_PropertySet(agent_newIconAgent, "Render Depth Test", false);
    KTBM_PropertySet(agent_newIconAgent, "Render Depth Write", false);
    KTBM_PropertySet(agent_newIconAgent, "Render Depth Write Alpha", false);
    KTBM_PropertySet(agent_newIconAgent, "Render Layer", 75);

    ShaderSwapTexture(agent_newIconAgent, "ui_boot_title.d3dtx", string_iconTexture);

    AgentAttach(agent_newIconAgent, agent_referenceAgent);

    AgentSetPos(agent_newIconAgent, Vector(0, 0, 0));

    table.insert(KTBM_Development_ObjectIcons_Icons, agent_newIconAgent);
end

KTBM_Development_ObjectIcons_Initalize = function()
    local agentTable_sceneAgents = SceneGetAgents(KTBM_Development_SceneObject);

    for index1, agent_sceneAgent in ipairs(agentTable_sceneAgents) do
        if(CanCreateIconForAgent(agent_sceneAgent)) then
            CreateNewObjectIconAgent(agent_sceneAgent);
        end
    end
end

KTBM_Development_ObjectIcons_Update = function()  
    local agent_sceneCamera = SceneGetCamera(KTBM_Development_SceneObject);
    local vector_sceneCameraPosition = AgentGetWorldPos(agent_sceneCamera);
    local vector_sceneCameraRotation = AgentGetWorldRot(agent_sceneCamera);

    for index1 = 1, #KTBM_Development_ObjectIcons_Icons do
        local agent_iconAgent = KTBM_Development_ObjectIcons_Icons[index1];
        local agent_iconParent = AgentGetParent(agent_iconAgent);

        if(agent_iconParent == nil) then
            AgentDestroy(agent_iconAgent);
            table.remove(KTBM_Development_ObjectIcons_Icons, index1);
        end
    end

    for index1, iconObject_currentIcon in ipairs(KTBM_Development_ObjectIcons_Icons) do
        --local agent_iconParent = AgentGetParent(iconObject_currentIcon);
        --local vector_currentIconPosition = AgentWorldPos(agent_iconParent);
        --local number_distanceToCamera = VectorDistance(vector_currentIconPosition, vector_sceneCameraPosition);
        --local number_newGlobalScale = number_distanceToCamera * number_gizmoSize;

        --KTBM_PropertySet(iconObject_currentIcon, "Render Global Scale", number_newGlobalScale);

        AgentSetPos(iconObject_currentIcon, Vector(0, 0, 0));
        AgentSetWorldRot(iconObject_currentIcon, vector_sceneCameraRotation);
    end
end