--main function that prepares the level enviorment
KTBM_Costumes_Boat_Build = function(kScene)
    --get the existing boat object in the scene and reset the position and rotation
    local boat_agent = AgentFindInScene("obj_boatMotorChesapeake", kScene);
    KTBM_SetAgentWorldPosition("obj_boatMotorChesapeake", Vector(0,0,0), kScene);
    KTBM_SetAgentWorldRotation("obj_boatMotorChesapeake", Vector(0,0,0), kScene);
    
    --get the existing bag object in the scene and stick it somewhere in the boat
    local bag_agent = AgentFindInScene("obj_bagDuffelB", kScene);
    KTBM_SetAgentWorldPosition("obj_bagDuffelB", Vector(0.693793, 0.922282, -1.742433), kScene);
    KTBM_SetAgentWorldRotation("obj_bagDuffelB", Vector(0,0,0), kScene);
    
    --get the existing cooler lid in the scene and stick it somewhere in the boat
    local coolerLid_agent = AgentFindInScene("obj_coolerLidFlagshipExteriorDeck", kScene);
    KTBM_SetAgentWorldPosition("obj_coolerLidFlagshipExteriorDeck", Vector(0.047424, 0.397186, 0.418999), kScene);
    KTBM_SetAgentWorldRotation("obj_coolerLidFlagshipExteriorDeck", Vector(0,180,0), kScene);

    --get the existing cooler base in the scene and stick it somewhere in the boat
    local coolerBase_agent = AgentFindInScene("obj_coolerFlagshipExteriorDeck", kScene);
    KTBM_SetAgentWorldPosition("obj_coolerFlagshipExteriorDeck", Vector(0.047424, 0.117186, 0.178999), kScene);
    KTBM_SetAgentWorldRotation("obj_coolerFlagshipExteriorDeck", Vector(0,180,0), kScene);

    --------------------------------------------------------
    --here we are adding some original props to the boat itself

    local saltLick_agent = AgentCreate("obj_saltLick", "obj_saltLick.prop", Vector(0,0,0), Vector(0,0,0), kScene, false, false);
    --KTBM_SetAgentWorldPosition("obj_saltLick", Vector(0.153338, 0.253860, -2.431206), kScene); --proper position
    KTBM_SetAgentWorldPosition("obj_saltLick", Vector(0.053338, 0.353860, -2.431206), kScene);
    KTBM_SetAgentWorldRotation("obj_saltLick", Vector(0,-41,0), kScene);

    --obj_gunGlock - glock
    --obj_pistolColtPython --revolver
    --obj_shotgunHershel --shotgun with wood stock
    --obj_shotgunIntruder --double barrel
    --obj_shotgunWD --tactical shotgun
    local doubleBarrelShotgun_agent = AgentCreate("obj_doubleBarrelShotgun", "obj_shotgunIntruder.prop", Vector(0,0,0), Vector(0,0,0), kScene, false, false);
    KTBM_SetAgentWorldPosition("obj_doubleBarrelShotgun", Vector(-0.683338, 0.453860, -1.931206), kScene);
    KTBM_SetAgentWorldRotation("obj_doubleBarrelShotgun", Vector(-40,190,0), kScene);

    local spear1_agent = AgentCreate("obj_spear1", "obj_spearClearingCampfire.prop", Vector(0,0,0), Vector(0,0,0), kScene, false, false);
    KTBM_SetAgentWorldPosition("obj_spear1", Vector(0.613338, 0.503860, 2.131206), kScene);
    KTBM_SetAgentWorldRotation("obj_spear1", Vector(-21,-1,0), kScene);

    local spear2_agent = AgentCreate("obj_spear2", "obj_spearClearingCampfire.prop", Vector(0,0,0), Vector(0,0,0), kScene, false, false);
    KTBM_SetAgentWorldPosition("obj_spear2", Vector(0.553338, 0.503860, 2.131206), kScene);
    KTBM_SetAgentWorldRotation("obj_spear2", Vector(-21,0,0), kScene);

    local spear3_agent = AgentCreate("obj_spear3", "obj_spearClearingCampfire.prop", Vector(0,0,0), Vector(0,0,0), kScene, false, false);
    KTBM_SetAgentWorldPosition("obj_spear3", Vector(0.503338, 0.503860, 2.131206), kScene);
    KTBM_SetAgentWorldRotation("obj_spear3", Vector(-21,1,1), kScene);

    local spear4_agent = AgentCreate("obj_spear4", "obj_spearClearingCampfire.prop", Vector(0,0,0), Vector(0,0,0), kScene, false, false);
    KTBM_SetAgentWorldPosition("obj_spear4", Vector(0.443338, 0.503860, 2.131206), kScene);
    KTBM_SetAgentWorldRotation("obj_spear4", Vector(-21,0,-2), kScene);

    local spear5_agent = AgentCreate("obj_spear5", "obj_spearClearingCampfire.prop", Vector(0,0,0), Vector(0,0,0), kScene, false, false);
    KTBM_SetAgentWorldPosition("obj_spear5", Vector(-0.733338, 0.723860, -1.931206), kScene);
    KTBM_SetAgentWorldRotation("obj_spear5", Vector(-11,190,0), kScene);

    local bucket_agent = AgentCreate("obj_bucket", "obj_bucketBathroomDairyHouse.prop", Vector(0,0,0), Vector(0,0,0), kScene, false, false);
    KTBM_SetAgentWorldPosition("obj_bucket", Vector(-0.633338, 0.323860, -0.811206), kScene);
    KTBM_SetAgentWorldRotation("obj_bucket", Vector(0,190,0), kScene);

    local binoculars_agent = AgentCreate("obj_binoculars", "obj_binocularsWD.prop", Vector(0,0,0), Vector(0,0,0), kScene, false, false);
    KTBM_SetAgentWorldPosition("obj_binoculars", Vector(-0.733338, 0.553860, -1.21206), kScene);
    KTBM_SetAgentWorldRotation("obj_binoculars", Vector(0,40,0), kScene);

    --obj_gunGlock - glock
    --obj_pistolColtPython --revolver
    --obj_shotgunHershel --shotgun with wood stock
    --obj_shotgunIntruder --double barrel
    --obj_shotgunWD --tactical shotgun
    local glock_agent = AgentCreate("obj_gunGlock", "obj_gunGlock.prop", Vector(0,0,0), Vector(0,0,0), kScene, false, false);
    KTBM_SetAgentWorldPosition("obj_gunGlock", Vector(0.683338, 0.483860, -2.431206), kScene);
    KTBM_SetAgentWorldRotation("obj_gunGlock", Vector(0,190,90), kScene);

    local rope_agent = AgentCreate("obj_ropeCoil", "obj_ropeCoil.prop", Vector(0,0,0), Vector(0,0,0), kScene, false, false);
    KTBM_SetAgentWorldPosition("obj_ropeCoil", Vector(0.183338, 0.183860, -2.131206), kScene);
    KTBM_SetAgentWorldRotation("obj_ropeCoil", Vector(90,45,0), kScene);

    --local bucket_agent = AgentCreate("obj_bucket", "obj_fishingRodsCabinInterior202.prop", Vector(0,0,0), Vector(0,0,0), kScene, false, false);
    --KTBM_SetAgentWorldPosition("obj_bucket", Vector(-0.633338, 0.323860, -0.811206), kScene);
    --KTBM_SetAgentWorldRotation("obj_bucket", Vector(0,190,0), kScene);

    --------------------------------------------------------
    --were going to create a (group) and have both kenny and the boat attached to it
    --this will make it easier to move both around, but also being able to do bouyancy animation
    
    --create the group agent
    local boat_group1_agent = AgentCreate("BoatGroup", "group.prop", Vector(0,0,0), Vector(0,0,0), kScene, false, false);
    local boat_group2_agent = AgentCreate("BoatAnimGroup", "group.prop", Vector(0,0,0), Vector(0,0,0), kScene, false, false);

    --attach both kenny and the boat itself to this group, effectively combining it into one
    --and attach it to the anim group first so we can do bouy/boat animations and have everything in the boat be affected.
    AgentAttach(boat_agent, boat_group2_agent);
    AgentAttach(bag_agent, boat_group2_agent);
    AgentAttach(coolerBase_agent, boat_group2_agent);
    AgentAttach(coolerLid_agent, boat_group2_agent);
    AgentAttach(saltLick_agent, boat_group2_agent);
    AgentAttach(doubleBarrelShotgun_agent, boat_group2_agent);
    AgentAttach(spear1_agent, boat_group2_agent);
    AgentAttach(spear2_agent, boat_group2_agent);
    AgentAttach(spear3_agent, boat_group2_agent);
    AgentAttach(spear4_agent, boat_group2_agent);
    AgentAttach(spear5_agent, boat_group2_agent);
    AgentAttach(bucket_agent, boat_group2_agent);
    AgentAttach(binoculars_agent, boat_group2_agent);
    AgentAttach(glock_agent, boat_group2_agent);
    AgentAttach(rope_agent, boat_group2_agent);
    
    --attach the boat anim group to the main boat group parent for gameplay/cutscene moving
    AgentAttach(boat_group2_agent, boat_group1_agent);
end