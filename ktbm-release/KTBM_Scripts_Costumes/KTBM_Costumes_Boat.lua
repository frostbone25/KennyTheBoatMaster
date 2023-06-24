--main function that prepares the level enviorment
KTBM_Costumes_Boat_Build = function(kScene)
    --get the existing boat object in the scene and reset the position and rotation
    local agent_boat = AgentFindInScene("obj_boatMotorChesapeake", kScene);
    KTBM_SetAgentWorldPosition("obj_boatMotorChesapeake", Vector(0,0,0), kScene);
    KTBM_SetAgentWorldRotation("obj_boatMotorChesapeake", Vector(0,0,0), kScene);





    --ShaderOverrideTexture(agent_boat, "env_drugstoreOfficeCalendar.d3dtx", "color_fFFFFF.d3dtx"); --some papers around the boat
    --ShaderOverrideTexture(agent_boat, "obj_beerCanFlagshipExteriorDeck.d3dtx", "color_fFFFFF.d3dtx"); --beer cans
    --ShaderOverrideTexture(agent_boat, "obj_motorBoatChesapeak.d3dtx", "color_fFFFFF.d3dtx"); --main motor
    --ShaderOverrideTexture(agent_boat, "tile_hullMetalBoatChesapeakeA.d3dtx", "color_fFFFFF.d3dtx"); --trim parts of the boat
    --ShaderOverrideTexture(agent_boat, "tile_hullMetalBoatChesapeakeC.d3dtx", "color_fFFFFF.d3dtx"); --floor/bottom of boat
    --ShaderOverrideTexture(agent_boat, "tile_hullMetalBoatChesapeakeB.d3dtx", "color_fFFFFF.d3dtx"); --side walls of the boat
    --ShaderOverrideTexture(agent_boat, "obj_stickersBoatChesapeake.d3dtx", "color_fFFFFF.d3dtx"); --stickers on the boat


    --ShaderOverrideTexture(agent_boat, "obj_motorBoatChesapeak.d3dtx", "KTBM_Texture_Skin1_obj_motorBoatChesapeak.d3dtx"); --main motor
    --ShaderOverrideTexture(agent_boat, "tile_hullMetalBoatChesapeakeA.d3dtx", "KTBM_Texture_Skin1_tile_hullMetalBoatChesapeakeA.d3dtx"); --trim parts of the boat
    --ShaderOverrideTexture(agent_boat, "tile_hullMetalBoatChesapeakeC.d3dtx", "KTBM_Texture_Skin1_tile_hullMetalBoatChesapeakeC.d3dtx"); --floor/bottom of boat
    --ShaderOverrideTexture(agent_boat, "tile_hullMetalBoatChesapeakeB.d3dtx", "KTBM_Texture_Skin1_tile_hullMetalBoatChesapeakeB.d3dtx"); --side walls of the boat
    --ShaderOverrideTexture(agent_boat, "obj_stickersBoatChesapeake.d3dtx", "KTBM_Texture_Skin1_obj_stickersBoatChesapeake.d3dtx"); --stickers on the boat






    --get the existing bag object in the scene and stick it somewhere in the boat
    local agent_bag = AgentFindInScene("obj_bagDuffelB", kScene);
    KTBM_SetAgentWorldPosition("obj_bagDuffelB", Vector(0.693793, 0.922282, -1.742433), kScene);
    KTBM_SetAgentWorldRotation("obj_bagDuffelB", Vector(0,0,0), kScene);
    
    --get the existing cooler lid in the scene and stick it somewhere in the boat
    local agent_coolerLid = AgentFindInScene("obj_coolerLidFlagshipExteriorDeck", kScene);
    KTBM_SetAgentWorldPosition("obj_coolerLidFlagshipExteriorDeck", Vector(0.047424, 0.397186, 0.418999), kScene);
    KTBM_SetAgentWorldRotation("obj_coolerLidFlagshipExteriorDeck", Vector(0,180,0), kScene);

    --get the existing cooler base in the scene and stick it somewhere in the boat
    local agent_coolerBase = AgentFindInScene("obj_coolerFlagshipExteriorDeck", kScene);
    KTBM_SetAgentWorldPosition("obj_coolerFlagshipExteriorDeck", Vector(0.047424, 0.117186, 0.178999), kScene);
    KTBM_SetAgentWorldRotation("obj_coolerFlagshipExteriorDeck", Vector(0,180,0), kScene);

    --------------------------------------------------------
    --here we are adding some original props to the boat itself

    local agent_saltLick = AgentCreate("obj_saltLick", "obj_saltLick.prop", Vector(0,0,0), Vector(0,0,0), kScene, false, false);
    --KTBM_SetAgentWorldPosition("obj_saltLick", Vector(0.153338, 0.253860, -2.431206), kScene); --proper position
    KTBM_SetAgentWorldPosition("obj_saltLick", Vector(0.053338, 0.353860, -2.431206), kScene);
    KTBM_SetAgentWorldRotation("obj_saltLick", Vector(0,-41,0), kScene);

    --obj_gunGlock - glock
    --obj_pistolColtPython --revolver
    --obj_shotgunHershel --shotgun with wood stock
    --obj_shotgunIntruder --double barrel
    --obj_shotgunWD --tactical shotgun
    local agent_doubleBarrelShotgun = AgentCreate("obj_doubleBarrelShotgun", "obj_shotgunIntruder.prop", Vector(0,0,0), Vector(0,0,0), kScene, false, false);
    KTBM_SetAgentWorldPosition("obj_doubleBarrelShotgun", Vector(-0.683338, 0.453860, -1.931206), kScene);
    KTBM_SetAgentWorldRotation("obj_doubleBarrelShotgun", Vector(-40,190,0), kScene);

    local agent_spear1 = AgentCreate("obj_spear1", "obj_spearClearingCampfire.prop", Vector(0,0,0), Vector(0,0,0), kScene, false, false);
    KTBM_SetAgentWorldPosition("obj_spear1", Vector(0.613338, 0.503860, 2.131206), kScene);
    KTBM_SetAgentWorldRotation("obj_spear1", Vector(-21,-1,0), kScene);

    local agent_spear2 = AgentCreate("obj_spear2", "obj_spearClearingCampfire.prop", Vector(0,0,0), Vector(0,0,0), kScene, false, false);
    KTBM_SetAgentWorldPosition("obj_spear2", Vector(0.553338, 0.503860, 2.131206), kScene);
    KTBM_SetAgentWorldRotation("obj_spear2", Vector(-21,0,0), kScene);

    local agent_spear3 = AgentCreate("obj_spear3", "obj_spearClearingCampfire.prop", Vector(0,0,0), Vector(0,0,0), kScene, false, false);
    KTBM_SetAgentWorldPosition("obj_spear3", Vector(0.503338, 0.503860, 2.131206), kScene);
    KTBM_SetAgentWorldRotation("obj_spear3", Vector(-21,1,1), kScene);

    local agent_spear4 = AgentCreate("obj_spear4", "obj_spearClearingCampfire.prop", Vector(0,0,0), Vector(0,0,0), kScene, false, false);
    KTBM_SetAgentWorldPosition("obj_spear4", Vector(0.443338, 0.503860, 2.131206), kScene);
    KTBM_SetAgentWorldRotation("obj_spear4", Vector(-21,0,-2), kScene);

    local agent_spear5 = AgentCreate("obj_spear5", "obj_spearClearingCampfire.prop", Vector(0,0,0), Vector(0,0,0), kScene, false, false);
    KTBM_SetAgentWorldPosition("obj_spear5", Vector(-0.733338, 0.723860, -1.931206), kScene);
    KTBM_SetAgentWorldRotation("obj_spear5", Vector(-11,190,0), kScene);

    local agent_bucket = AgentCreate("obj_bucket", "obj_bucketBathroomDairyHouse.prop", Vector(0,0,0), Vector(0,0,0), kScene, false, false);
    KTBM_SetAgentWorldPosition("obj_bucket", Vector(-0.633338, 0.323860, -0.811206), kScene);
    KTBM_SetAgentWorldRotation("obj_bucket", Vector(0,190,0), kScene);

    local agent_binoculars = AgentCreate("obj_binoculars", "obj_binocularsWD.prop", Vector(0,0,0), Vector(0,0,0), kScene, false, false);
    KTBM_SetAgentWorldPosition("obj_binoculars", Vector(-0.733338, 0.553860, -1.21206), kScene);
    KTBM_SetAgentWorldRotation("obj_binoculars", Vector(0,40,0), kScene);

    --obj_gunGlock - glock
    --obj_pistolColtPython --revolver
    --obj_shotgunHershel --shotgun with wood stock
    --obj_shotgunIntruder --double barrel
    --obj_shotgunWD --tactical shotgun
    local agent_glock = AgentCreate("obj_gunGlock", "obj_gunGlock.prop", Vector(0,0,0), Vector(0,0,0), kScene, false, false);
    KTBM_SetAgentWorldPosition("obj_gunGlock", Vector(0.683338, 0.483860, -2.431206), kScene);
    KTBM_SetAgentWorldRotation("obj_gunGlock", Vector(0,190,90), kScene);

    local agent_rope = AgentCreate("obj_ropeCoil", "obj_ropeCoil.prop", Vector(0,0,0), Vector(0,0,0), kScene, false, false);
    KTBM_SetAgentWorldPosition("obj_ropeCoil", Vector(0.183338, 0.183860, -2.131206), kScene);
    KTBM_SetAgentWorldRotation("obj_ropeCoil", Vector(90,45,0), kScene);

    --local agent_bucket = AgentCreate("obj_bucket", "obj_fishingRodsCabinInterior202.prop", Vector(0,0,0), Vector(0,0,0), kScene, false, false);
    --KTBM_SetAgentWorldPosition("obj_bucket", Vector(-0.633338, 0.323860, -0.811206), kScene);
    --KTBM_SetAgentWorldRotation("obj_bucket", Vector(0,190,0), kScene);

    --------------------------------------------------------
    --were going to create a (group) and have both kenny and the boat attached to it
    --this will make it easier to move both around, but also being able to do bouyancy animation
    
    --create the group agent
    local agent_boat_group1 = AgentCreate("BoatGroup", "group.prop", Vector(0,0,0), Vector(0,0,0), kScene, false, false);
    local agent_boat_group2 = AgentCreate("BoatAnimGroup", "group.prop", Vector(0,0,0), Vector(0,0,0), kScene, false, false);

    --attach both kenny and the boat itself to this group, effectively combining it into one
    --and attach it to the anim group first so we can do bouy/boat animations and have everything in the boat be affected.
    AgentAttach(agent_boat, agent_boat_group2);
    AgentAttach(agent_bag, agent_boat_group2);
    AgentAttach(agent_coolerBase, agent_boat_group2);
    AgentAttach(agent_coolerLid, agent_boat_group2);
    AgentAttach(agent_saltLick, agent_boat_group2);
    AgentAttach(agent_doubleBarrelShotgun, agent_boat_group2);
    AgentAttach(agent_spear1, agent_boat_group2);
    AgentAttach(agent_spear2, agent_boat_group2);
    AgentAttach(agent_spear3, agent_boat_group2);
    AgentAttach(agent_spear4, agent_boat_group2);
    AgentAttach(agent_spear5, agent_boat_group2);
    AgentAttach(agent_bucket, agent_boat_group2);
    AgentAttach(agent_binoculars, agent_boat_group2);
    AgentAttach(agent_glock, agent_boat_group2);
    AgentAttach(agent_rope, agent_boat_group2);
    
    --attach the boat anim group to the main boat group parent for gameplay/cutscene moving
    AgentAttach(agent_boat_group2, agent_boat_group1);
end