--[[
-----------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------
]]--

--main function that cleans up the original scene
KTBM_LevelCleanup_M101_FlagshipExteriorDeck_Purge = function(kScene)
   --in here we will remove everything that we won't need
   --the reason being that the base scene is a michonne scene,
   --however we are only borrowing the enviorment, so all of the other stuff needs to be taken out.
   --we will be keeping some objects.

   --adv agents
   --KTBM_RemoveAgent("adv_flagshipExteriorDeck.scene", kScene);
   KTBM_RemoveAgent("adv_flagshipExteriorDeck_meshesA", kScene);
   KTBM_RemoveAgent("adv_flagshipExteriorDeck_meshesA_decals", kScene);
   KTBM_RemoveAgent("adv_flagshipExteriorDeck_meshesA_extra1", kScene);

   --obj agents
   KTBM_RemoveAgent("obj_skydomeCloudsFullFlagshipInterior", kScene);
   KTBM_RemoveAgent("obj_skydomeCloudsHorizonFlagshipInterior", kScene);
   KTBM_RemoveAgent("obj_skydomeCloudsPainterlyBHorizonFlagshipInterior", kScene);
   KTBM_RemoveAgent("obj_skydomeHazeEvenFlagshipInterior", kScene);
   KTBM_RemoveAgent("obj_skydomeOuterDayFlagshipInterior", kScene);
   KTBM_RemoveAgent("obj_boatCrabbingFlagshipExteriorDeckA", kScene);
   KTBM_RemoveAgent("obj_boatCrabbingFlagshipExteriorDeckB", kScene);
   KTBM_RemoveAgent("obj_boatDinghyFlagshipExteriorDeckA", kScene);
   KTBM_RemoveAgent("obj_boatDinghyFlagshipExteriorDeckB", kScene);
   KTBM_RemoveAgent("obj_boatDinghyFlagshipExteriorDeckC", kScene);
   KTBM_RemoveAgent("obj_boatFishingLargeFlagshipExteriorDeckA", kScene);
   KTBM_RemoveAgent("obj_boatFishingLargeFlagshipExteriorDeckB", kScene);
   KTBM_RemoveAgent("obj_boatFishingLargeFlagshipExteriorDeckC", kScene);
   KTBM_RemoveAgent("obj_boatFishingLargeFlagshipExteriorDeckD", kScene);
   KTBM_RemoveAgent("obj_boatFlatbottomFlagshipExteriorDeckA", kScene);
   KTBM_RemoveAgent("obj_boatFlatbottomFlagshipExteriorDeckB", kScene);
   KTBM_RemoveAgent("obj_boatFlatbottomFlagshipExteriorDeckC", kScene);
   KTBM_RemoveAgent("obj_boatJunkFlagshipExteriorDeckA", kScene);
   KTBM_RemoveAgent("obj_boatJunkFlagshipExteriorDeckB", kScene);
   KTBM_RemoveAgent("obj_boatJunkFlagshipExteriorDeckC", kScene);
   KTBM_RemoveAgent("obj_boatJunkFlagshipExteriorDeckD", kScene);
   KTBM_RemoveAgent("obj_boatJunkFlagshipExteriorDeckE", kScene);
   KTBM_RemoveAgent("obj_boatSailFlagshipExteriorDeckA", kScene);
   KTBM_RemoveAgent("obj_boatSailFlagshipExteriorDeckB", kScene);
   KTBM_RemoveAgent("obj_boatSailFlagshipExteriorDeckC", kScene);
   KTBM_RemoveAgent("obj_boatSailFlagshipExteriorDeckD", kScene);
   KTBM_RemoveAgent("obj_boatSailFlagshipExteriorDeckF", kScene);
   KTBM_RemoveAgent("obj_boatTrawlerFlagshipExteriorDeckA", kScene);
   KTBM_RemoveAgent("obj_boatTrawlerFlagshipExteriorDeckB", kScene);
   KTBM_RemoveAgent("obj_boatTrawlerFlagshipExteriorDeckC", kScene);
   KTBM_RemoveAgent("obj_boatTrawlerFlagshipExteriorDeckD", kScene);
   KTBM_RemoveAgent("obj_boatTrawlerFlagshipExteriorDeckE", kScene);
   KTBM_RemoveAgent("obj_boatTrawlerFlagshipExteriorDeckF", kScene);
   KTBM_RemoveAgent("obj_boatTrawlerFlagshipExteriorDeckG", kScene);
   KTBM_RemoveAgent("obj_boatTrawlerFlagshipExteriorDeckH", kScene);
   --KTBM_RemoveAgent("obj_flagshipExteriorDeckLandA", kScene);
   --KTBM_RemoveAgent("obj_flagshipExteriorDeckLandB", kScene);
   --KTBM_RemoveAgent("obj_flagshipExteriorDeckLandC", kScene);
   --KTBM_RemoveAgent("obj_flagshipExteriorDeckLandD", kScene);
   --KTBM_RemoveAgent("obj_flagshipExteriorDeckLandE", kScene);
   KTBM_RemoveAgent("obj_boatTugNormaFlagshipExteriorDeckA", kScene);
   KTBM_RemoveAgent("obj_boatTugNormaFlagshipExteriorDeckB", kScene);
   KTBM_RemoveAgent("obj_boatTugNormaFlagshipExteriorDeckC", kScene);
   KTBM_RemoveAgent("obj_buoyFlagshipExteriorDeckA", kScene);
   KTBM_RemoveAgent("obj_buoyFlagshipExteriorDeckB", kScene);
   KTBM_RemoveAgent("obj_buoyFlagshipExteriorDeckC", kScene);
   KTBM_RemoveAgent("obj_dockFlagshipExteriorDeckA", kScene);
   KTBM_RemoveAgent("obj_dockFlagshipExteriorDeckB", kScene);
   KTBM_RemoveAgent("obj_dockFlagshipExteriorDeckC", kScene);
   KTBM_RemoveAgent("obj_dockFlagshipExteriorDeckD", kScene);
   KTBM_RemoveAgent("obj_flatsFlagshipExteriorDeckA", kScene);
   KTBM_RemoveAgent("obj_flatsFlagshipExteriorDeckB", kScene);
   KTBM_RemoveAgent("obj_flotsamFlagshipExteriorDeckA", kScene);
   KTBM_RemoveAgent("obj_flotsamFlagshipExteriorDeckB", kScene);
   KTBM_RemoveAgent("obj_gangwayFlagshipExteriorDeckA", kScene);
   KTBM_RemoveAgent("obj_chairPlasticFlagshipExteriorDeckA", kScene);
   KTBM_RemoveAgent("obj_chairPlasticFlagshipExteriorDeckB", kScene);
   KTBM_RemoveAgent("obj_beerCanFlagshipExteriorDeck", kScene);
   KTBM_RemoveAgent("obj_beerCanOpenFlagshipExteriorDeck", kScene);
   --KTBM_RemoveAgent("obj_coolerFlagshipExteriorDeck", kScene);
   --KTBM_RemoveAgent("obj_coolerLidFlagshipExteriorDeck", kScene);
   KTBM_RemoveAgent("obj_ashtrayFlagshipExteriorDeck", kScene);
   KTBM_RemoveAgent("obj_chairPlasticFlagshipExteriorDeckC", kScene);
   KTBM_RemoveAgent("obj_strawFlagshipExteriorDeck", kScene);
   --KTBM_RemoveAgent("obj_bagDuffelB", kScene);
   --KTBM_RemoveAgent("obj_boatMotorChesapeake", kScene);
   KTBM_RemoveAgent("obj_boatTugNormaFlagshipExteriorDeckD", kScene);
   KTBM_RemoveAgent("obj_chairRigidExteriorDeck", kScene);
   KTBM_RemoveAgent("obj_tiesZipHandsWD", kScene);
   KTBM_RemoveAgent("obj_gunPistol106", kScene);
   KTBM_RemoveAgent("obj_flatsFlagshipExteriorDeckB01", kScene);
   KTBM_RemoveAgent("obj_flatsFlagshipExteriorDeckB02", kScene);
   KTBM_RemoveAgent("obj_flatsFlagshipExteriorDeckB03", kScene);
   KTBM_RemoveAgent("obj_flatsFlagshipExteriorDeckA01", kScene);
   --KTBM_RemoveAgent("obj_matteSkydomeOvercastHorizon", kScene);
   KTBM_RemoveAgent("obj_matteSkydomeOvercastPainted", kScene);
   --KTBM_RemoveAgent("obj_matteSkydomeOvercastSkyGrad", kScene);
   KTBM_RemoveAgent("obj_matteSkydomeOvercastTile", kScene);
   KTBM_RemoveAgent("obj_matteSkydomeOvercastTop", kScene);
   KTBM_RemoveAgent("obj_skydomeCloudsFullFlagshipExteriorDeck", kScene);
   KTBM_RemoveAgent("obj_skydomeCloudsHorizonFlagshipExteriorDeck", kScene);
   KTBM_RemoveAgent("obj_skydomeCloudsPainterlyBHorizonFlagshipExteriorDeck", kScene);
   KTBM_RemoveAgent("obj_skydomeHazeEvenFlagshipExteriorDeck", kScene);
   KTBM_RemoveAgent("obj_skydomeOuterDayFlagshipExteriorDeck", kScene);
   KTBM_RemoveAgent("obj_sideTableFlagshipExteriorDeck", kScene);
   KTBM_RemoveAgent("obj_boatTugNormaFlagshipExteriorDeckA_decals", kScene);
   KTBM_RemoveAgent("obj_lookAtMichonne", kScene);
   KTBM_RemoveAgent("obj_lookAtGreg", kScene);
   KTBM_RemoveAgent("obj_lookAtNorma", kScene);
   KTBM_RemoveAgent("obj_lookAtRandall", kScene);
   KTBM_RemoveAgent("obj_lookAtZachary", kScene);
   KTBM_RemoveAgent("obj_lookAtPete", kScene);
   KTBM_RemoveAgent("obj_lookAtJonas", kScene);
   KTBM_RemoveAgent("obj_lookAtGabby", kScene);
   KTBM_RemoveAgent("obj_lookAtSamantha", kScene);
   KTBM_RemoveAgent("obj_lookAtCrabberMale01", kScene);
   KTBM_RemoveAgent("obj_lookAtCrabberMale02", kScene);
   KTBM_RemoveAgent("obj_lookAtCrabberMale03", kScene);
   KTBM_RemoveAgent("obj_lookAtCrabberFemale01", kScene);
   KTBM_RemoveAgent("obj_lookAtCrabberFemale02", kScene);
   KTBM_RemoveAgent("obj_lookAtCrabberFemale03", kScene);
   KTBM_RemoveAgent("obj_lookAtCrabberFemale04", kScene);

   --cam agents
   KTBM_RemoveAgent("cam_michonne_CU", kScene);
   KTBM_RemoveAgent("cam_michonne_MED", kScene);
   KTBM_RemoveAgent("cam_michonne_OTS", kScene);
   KTBM_RemoveAgent("cam_greg_CU", kScene);
   KTBM_RemoveAgent("cam_greg_MED", kScene);
   KTBM_RemoveAgent("cam_greg_OTS", kScene);
   KTBM_RemoveAgent("cam_norma_CU", kScene);
   KTBM_RemoveAgent("cam_norma_MED", kScene);
   KTBM_RemoveAgent("cam_norma_OTS", kScene);
   KTBM_RemoveAgent("cam_randall_CU", kScene);
   KTBM_RemoveAgent("cam_randall_MED", kScene);
   KTBM_RemoveAgent("cam_randall_OTS", kScene);
   KTBM_RemoveAgent("cam_zachary_CU", kScene);
   KTBM_RemoveAgent("cam_zachary_MED", kScene);
   KTBM_RemoveAgent("cam_zachary_OTS", kScene);
   KTBM_RemoveAgent("cam_cutscene", kScene);
   KTBM_RemoveAgent("cam_cutsceneChore", kScene);
   KTBM_RemoveAgent("cam_norma_walk_CU", kScene);
   KTBM_RemoveAgent("cam_michonne_walk_CU", kScene);
   KTBM_RemoveAgent("cam_michonne_walk_OTS", kScene);
   KTBM_RemoveAgent("cam_cs_exit_timer", kScene);
   KTBM_RemoveAgent("cam_pete_OTS", kScene);
   KTBM_RemoveAgent("cam_samantha_CU", kScene);
   KTBM_RemoveAgent("cam_samantha_OTS", kScene);
   KTBM_RemoveAgent("cam_samantha_MED", kScene);
   KTBM_RemoveAgent("cam_cs_enter_timer", kScene);
   
   --ui agents
   
   --fx agents
   KTBM_RemoveAgent("fx_bloodBleedDirNrwDPlane", kScene);
   KTBM_RemoveAgent("fx_waterRippleRingEmitter_tire", kScene);
   KTBM_RemoveAgent("fx_waterRippleRingEmitter_tire01", kScene);
   KTBM_RemoveAgent("fx_waterRippleRingEmitter_tire02", kScene);
   KTBM_RemoveAgent("fx_waterRippleRingEmitter_tire03", kScene);
   KTBM_RemoveAgent("fx_waterRippleRingEmitter_tire04", kScene);
   KTBM_RemoveAgent("fx_waterRippleRingEmitter_tire05", kScene);
   KTBM_RemoveAgent("fx_waterRippleRingEmitter_tire06", kScene);
   KTBM_RemoveAgent("fx_waterRippleRingEmitter_tire07", kScene);
   KTBM_RemoveAgent("fx_waterRippleBoatEmitter", kScene);
   KTBM_RemoveAgent("fx_waterRippleBoatEmitter01", kScene);
   KTBM_RemoveAgent("fx_waterRippleBoatEmitter02", kScene);
   KTBM_RemoveAgent("fx_waterRippleBoatEmitter03", kScene);
   KTBM_RemoveAgent("fx_waterRippleBoatEmitter04", kScene);
   KTBM_RemoveAgent("fx_waterRippleBoatEmitter05", kScene);
   KTBM_RemoveAgent("fx_waterRippleBoatEmitter06", kScene);
   KTBM_RemoveAgent("fx_waterRippleBoatEmitter07", kScene);
   KTBM_RemoveAgent("fx_waterRippleBoatEmitter08", kScene);
   KTBM_RemoveAgent("fx_waterRippleBoatEmitter09", kScene);
   KTBM_RemoveAgent("fx_waterRippleBoatEmitter10", kScene);
   KTBM_RemoveAgent("fx_waterRippleBoatEmitter11", kScene);
   KTBM_RemoveAgent("fx_waterRippleBoatEmitter12", kScene);
   KTBM_RemoveAgent("fx_waterRippleBoatEmitter13", kScene);
   KTBM_RemoveAgent("fx_waterRippleBoatEmitter14", kScene);
   KTBM_RemoveAgent("fx_waterRippleBoatEmitter15", kScene);
   KTBM_RemoveAgent("fx_waterRippleBoatEmitter16", kScene);
   KTBM_RemoveAgent("fx_waterRippleBoatEmitter17", kScene);
   KTBM_RemoveAgent("fx_waterRippleBoatEmitter18", kScene);
   KTBM_RemoveAgent("fx_waterRippleBoatEmitter19", kScene);
   KTBM_RemoveAgent("fx_waterRippleBoatEmitter20", kScene);
   KTBM_RemoveAgent("fx_waterRippleBoatEmitter21", kScene);
   KTBM_RemoveAgent("fx_waterRippleBoatEmitter22", kScene);
   KTBM_RemoveAgent("fx_waterRippleBoatEmitter23", kScene);
   KTBM_RemoveAgent("fx_waterRippleBoatEmitter24", kScene);
   KTBM_RemoveAgent("fx_waterRippleBoatEmitter25", kScene);
   KTBM_RemoveAgent("fx_waterRippleBoatEmitter26", kScene);
   KTBM_RemoveAgent("fx_waterRippleBoatEmitter27", kScene);
   KTBM_RemoveAgent("fx_waterRippleBoatEmitter28", kScene);
   KTBM_RemoveAgent("fx_waterRippleBoatEmitter29", kScene);
   KTBM_RemoveAgent("fx_waterRippleBoatEmitter30", kScene);
   KTBM_RemoveAgent("fx_waterOceanFlagshipExteriorDeck", kScene);
   KTBM_RemoveAgent("fx_seagullsDistanceA", kScene);
   KTBM_RemoveAgent("fx_seagullsDistanceB", kScene);
   KTBM_RemoveAgent("fx_seagullsDistanceA01", kScene);
   KTBM_RemoveAgent("fx_seagullsDistanceB01", kScene);
   KTBM_RemoveAgent("fx_seagullDistanceC", kScene);
   KTBM_RemoveAgent("fx_seagullsDistanceA02", kScene);
   KTBM_RemoveAgent("fx_seagullDistanceC01", kScene);
   
   --fxGroup agents
   
   --module agents
   KTBM_RemoveAgent("module_enlightensystem", kScene);
   --KTBM_RemoveAgent("module_environment", kScene);
   --KTBM_RemoveAgent("module_lightprobe", kScene);
   KTBM_RemoveAgent("module_post_effect", kScene);
   
   --group agents
   
   --light agents
   KTBM_RemoveAgent("light_CHAR_shadow", kScene); --Light Type:  ( nil )
   KTBM_RemoveAgent("light_OBJ_Main_Key", kScene); --Light Type:  ( nil )
   KTBM_RemoveAgent("light_OBJ_Main_FILL", kScene); --Light Type:  ( nil )
   KTBM_RemoveAgent("light_FX_waterSpec", kScene); --Light Type:  ( nil )
   KTBM_RemoveAgent("light_FX_waterSpec01", kScene); --Light Type:  ( nil )
   KTBM_RemoveAgent("light_FX_waterDir", kScene); --Light Type:  ( nil )
   --KTBM_RemoveAgent("light_D", kScene); --Light Type: eLightEnvType_DirectionalKey ( 2 )
   --KTBM_RemoveAgent("light_amb", kScene); --Light Type: eLightEnvType_Ambient ( 3 )
   KTBM_RemoveAgent("light_a02", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a03", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a04", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a06", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a07", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a09", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a10", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a11", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a12", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a13", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a20", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a21", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   --KTBM_RemoveAgent("light_amb sky", kScene); --Light Type: eLightEnvType_Ambient ( 3 )
   KTBM_RemoveAgent("light_a25", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a26", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a27", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a28", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a33", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a40", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a41", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a44", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a45", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a49", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a46", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a47", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a48", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a42", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a50", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a51", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a52", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a53", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a54", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a55", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a56", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a57", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a58", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a59", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a60", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a61", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a62", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a36", kScene); --Light Type: eLightEnvType_Point ( 0 )
   KTBM_RemoveAgent("light_a34", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a37", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a38", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a39", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a63", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a64", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a65", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a66", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a67", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a68", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a69", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a70", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a71", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a72", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a73", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a74", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a75", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a79", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a80", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a81", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a82", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a84", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a86", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a87", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a90", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a93", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a95", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a96", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a97", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a98", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a99", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a100", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a103", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a104", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a106", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a107", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a108", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a111", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a112", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a113", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a114", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a115", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a116", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a117", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a118", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a120", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a121", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a122", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a123", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a124", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a126", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a127", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a128", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a129", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a130", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a131", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a136", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a137", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a138", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a139", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a140", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a141", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a144", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a145", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a146", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a152", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a153", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a154", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a155", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a156", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a157", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a158", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a161", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a162", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a163", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a164", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a109", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a08", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a150", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a125", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a151", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a76", kScene); --Light Type: eLightEnvType_Point ( 0 )
   KTBM_RemoveAgent("light_a43", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a85", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a77", kScene); --Light Type: eLightEnvType_Point ( 0 )
   KTBM_RemoveAgent("light_a78", kScene); --Light Type: eLightEnvType_Point ( 0 )
   KTBM_RemoveAgent("light_a83", kScene); --Light Type: eLightEnvType_Point ( 0 )
   KTBM_RemoveAgent("light_a88", kScene); --Light Type: eLightEnvType_Point ( 0 )
   KTBM_RemoveAgent("light_Dir_Amb_Char", kScene); --Light Type: eLightEnvType_DirectionalAmbient ( 4 )
   
   --light_CHAR_CC agents
   KTBM_RemoveAgent("light_CHAR_CC_Michonne_Fill", kScene);
   KTBM_RemoveAgent("light_CHAR_CC_Michonne_Rim", kScene);
   KTBM_RemoveAgent("light_CHAR_CC_Michonne_Key", kScene);
   KTBM_RemoveAgent("light_CHAR_CC_Zachary_Fill", kScene);
   KTBM_RemoveAgent("light_CHAR_CC_Zachary_Rim", kScene);
   KTBM_RemoveAgent("light_CHAR_CC_Zachary_Key", kScene);
   KTBM_RemoveAgent("light_CHAR_CC_Randall_Fill", kScene);
   KTBM_RemoveAgent("light_CHAR_CC_Randall_Rim", kScene);
   KTBM_RemoveAgent("light_CHAR_CC_Randall_Key", kScene);
   KTBM_RemoveAgent("light_CHAR_CC_Pete_Fill", kScene);
   KTBM_RemoveAgent("light_CHAR_CC_Pete_Rim", kScene);
   KTBM_RemoveAgent("light_CHAR_CC_Pete_Key", kScene);
   KTBM_RemoveAgent("light_CHAR_CC_Norma_Fill", kScene);
   KTBM_RemoveAgent("light_CHAR_CC_Norma_Rim", kScene);
   KTBM_RemoveAgent("light_CHAR_CC_Norma_Key", kScene);
   KTBM_RemoveAgent("light_CHAR_CC_Jonas_Fill", kScene);
   KTBM_RemoveAgent("light_CHAR_CC_Jonas_Rim", kScene);
   KTBM_RemoveAgent("light_CHAR_CC_Jonas_Key", kScene);
   KTBM_RemoveAgent("light_CHAR_CC_Greg_Fill", kScene);
   KTBM_RemoveAgent("light_CHAR_CC_Greg_Rim", kScene);
   KTBM_RemoveAgent("light_CHAR_CC_Greg_Key", kScene);
   KTBM_RemoveAgent("light_CHAR_CC_Gabby_Fill", kScene);
   KTBM_RemoveAgent("light_CHAR_CC_Gabby_Rim", kScene);
   KTBM_RemoveAgent("light_CHAR_CC_Gabby_Key", kScene);
   KTBM_RemoveAgent("light_CHAR_CC_CrabberMale03_Fill", kScene);
   KTBM_RemoveAgent("light_CHAR_CC_CrabberMale03_Rim", kScene);
   KTBM_RemoveAgent("light_CHAR_CC_CrabberMale03_Key", kScene);
   KTBM_RemoveAgent("light_CHAR_CC_CrabberMale02_Fill", kScene);
   KTBM_RemoveAgent("light_CHAR_CC_CrabberMale02_Rim", kScene);
   KTBM_RemoveAgent("light_CHAR_CC_CrabberMale02_Key", kScene);
   KTBM_RemoveAgent("light_CHAR_CC_CrabberMale01_Fill", kScene);
   KTBM_RemoveAgent("light_CHAR_CC_CrabberMale01_Rim", kScene);
   KTBM_RemoveAgent("light_CHAR_CC_CrabberMale01_Key", kScene);
   KTBM_RemoveAgent("light_CHAR_CC_CrabberFemale04_Fill", kScene);
   KTBM_RemoveAgent("light_CHAR_CC_CrabberFemale04_Rim", kScene);
   KTBM_RemoveAgent("light_CHAR_CC_CrabberFemale04_Key", kScene);
   KTBM_RemoveAgent("light_CHAR_CC_CrabberFemale03_Fill", kScene);
   KTBM_RemoveAgent("light_CHAR_CC_CrabberFemale03_Rim", kScene);
   KTBM_RemoveAgent("light_CHAR_CC_CrabberFemale03_Key", kScene);
   KTBM_RemoveAgent("light_CHAR_CC_CrabberFemale02_Fill", kScene);
   KTBM_RemoveAgent("light_CHAR_CC_CrabberFemale02_Rim", kScene);
   KTBM_RemoveAgent("light_CHAR_CC_CrabberFemale02_Key", kScene);
   KTBM_RemoveAgent("light_CHAR_CC_CrabberFemale01_Fill", kScene);
   KTBM_RemoveAgent("light_CHAR_CC_CrabberFemale01_Rim", kScene);
   KTBM_RemoveAgent("light_CHAR_CC_CrabberFemale01_Key", kScene);
   
   --lightrig_CC agents
   KTBM_RemoveAgent("lightrig_CC_michonne", kScene);
   KTBM_RemoveAgent("lightrig_CC_zachary", kScene);
   KTBM_RemoveAgent("lightrig_CC_randall", kScene);
   KTBM_RemoveAgent("lightrig_CC_pete", kScene);
   KTBM_RemoveAgent("lightrig_CC_norma", kScene);
   KTBM_RemoveAgent("lightrig_CC_jonas", kScene);
   KTBM_RemoveAgent("lightrig_CC_greg", kScene);
   KTBM_RemoveAgent("lightrig_CC_gabby", kScene);
   KTBM_RemoveAgent("lightrig_CC_crabbermale03", kScene);
   KTBM_RemoveAgent("lightrig_CC_crabbermale02", kScene);
   KTBM_RemoveAgent("lightrig_CC_crabbermale01", kScene);
   KTBM_RemoveAgent("lightrig_CC_crabberfemale04", kScene);
   KTBM_RemoveAgent("lightrig_CC_crabberfemale03", kScene);
   KTBM_RemoveAgent("lightrig_CC_crabberfemale02", kScene);
   KTBM_RemoveAgent("lightrig_CC_crabberfemale01", kScene);
   
   --lightrotation_CC agents
   KTBM_RemoveAgent("lightrotation_CC_template_3point", kScene);
   KTBM_RemoveAgent("lightrotation_CC_template_day", kScene);
   KTBM_RemoveAgent("lightrotation_CC_template_night", kScene);
   KTBM_RemoveAgent("lightrotation_CC_template_top", kScene);
   
   --charLightComposer agents
   KTBM_RemoveAgent("charLightComposer_keylight_moon", kScene);
   
   --unsorted agents
   KTBM_RemoveAgent("lightENV_skydomeCloudsFullFlagshipExteriorDeck", kScene);
   KTBM_RemoveAgent("lightENV_skydomeCloudsPainterlyBHorizonFlagshipExteriorDeck", kScene);
   KTBM_RemoveAgent("lightENV_skydomeHazeEvenFlagshipExteriorDeck", kScene);
   KTBM_RemoveAgent("lightENV_skydomeOuterDayFlagshipExteriorDeck", kScene);
   KTBM_RemoveAgent("lightENV_grass", kScene);
   KTBM_RemoveAgent("lightENV_treeBranches_amb", kScene);
   KTBM_RemoveAgent("lightENV_treeBranches_key", kScene);
   KTBM_RemoveAgent("lightENV_treeRim", kScene);
   KTBM_RemoveAgent("lightENV_brush", kScene);
   KTBM_RemoveAgent("lightENV_groundCover", kScene);
   KTBM_RemoveAgent("lightENV_skydomeCloudsHorizonFlagshipExteriorDeck", kScene);
   KTBM_RemoveAgent("Michonne", kScene);
   KTBM_RemoveAgent("Greg", kScene);
   KTBM_RemoveAgent("Norma", kScene);
   KTBM_RemoveAgent("Randall", kScene);
   KTBM_RemoveAgent("Zachary", kScene);
   KTBM_RemoveAgent("Pete", kScene);
   KTBM_RemoveAgent("Jonas", kScene);
   KTBM_RemoveAgent("Gabby", kScene);
   KTBM_RemoveAgent("Samantha", kScene);
   KTBM_RemoveAgent("audio_music_interface_adv_flagshipExteriorDeck", kScene);
   KTBM_RemoveAgent("audio_event_emitter_lapping water", kScene);
   KTBM_RemoveAgent("audio_sfx_interface_adv_flagshipExteriorDeck", kScene);
   KTBM_RemoveAgent("audio_reverb_interface_adv_flagshipExteriorDeck", kScene);
   KTBM_RemoveAgent("audio_listener_interface_adv_flagshipExteriorDeck", kScene);
   KTBM_RemoveAgent("audio_ambience_interface_adv_flagshipExteriorDeck", kScene);
   KTBM_RemoveAgent("audio_event_emitter_amb_ext_ship_deck", kScene);
   KTBM_RemoveAgent("dummy_world", kScene);
   KTBM_RemoveAgent("lightENV_skydome_fillA", kScene);
   KTBM_RemoveAgent("lightENV_skydome_sun", kScene);
   KTBM_RemoveAgent("lightENV_skydome_rim", kScene);
   KTBM_RemoveAgent("lightENV_skydome_negative", kScene);
   KTBM_RemoveAgent("lightENV_skydome_amb", kScene);
   KTBM_RemoveAgent("audio_event preload_interface_adv_flagshipExteriorDeck", kScene);
   KTBM_RemoveAgent("fxg_bloodBleedRadDir", kScene);
   KTBM_RemoveAgent("fxg_bloodBleedDirRnd", kScene);
   KTBM_RemoveAgent("audio_event_emitter_motorboat", kScene);
   KTBM_RemoveAgent("lightENV_flagshipLights", kScene);
   KTBM_RemoveAgent("fxg_bloodBleedRadRnd", kScene);
   KTBM_RemoveAgent("fxg_bloodBleedRadDir01", kScene);
   KTBM_RemoveAgent("lightENV_water", kScene);
   KTBM_RemoveAgent("lightENV_waterSpec", kScene);
   KTBM_RemoveAgent("CrabberMale01", kScene);
   KTBM_RemoveAgent("CrabberMale02", kScene);
   KTBM_RemoveAgent("CrabberMale03", kScene);
   KTBM_RemoveAgent("CrabberFemale01", kScene);
   KTBM_RemoveAgent("CrabberFemale02", kScene);
   KTBM_RemoveAgent("CrabberFemale03", kScene);
   KTBM_RemoveAgent("CrabberFemale04", kScene);

   --local agent_enviormentGroup = AgentCreate("group_enviorment", "group.prop", Vector(0, 0, 0), Vector(0, 0, 0), kScene, false, false);

   --local agents_sceneAgents = SceneGetAgents(kScene);

   --for i, agent_sceneAgent in ipairs(agents_sceneAgents) do
      --AgentAttach(agent_sceneAgent, agent_enviormentGroup);
   --end
end

--main function that cleans up the original scene
KTBM_LevelCleanup_M101_FlagshipExteriorDeck_FullPurge = function(kScene)

   --adv agents
   --KTBM_RemoveAgent("adv_flagshipExteriorDeck.scene", kScene);
   KTBM_RemoveAgent("adv_flagshipExteriorDeck_meshesA", kScene);
   KTBM_RemoveAgent("adv_flagshipExteriorDeck_meshesA_decals", kScene);
   KTBM_RemoveAgent("adv_flagshipExteriorDeck_meshesA_extra1", kScene);
   
   --obj agents
   KTBM_RemoveAgent("obj_skydomeCloudsFullFlagshipInterior", kScene);
   KTBM_RemoveAgent("obj_skydomeCloudsHorizonFlagshipInterior", kScene);
   KTBM_RemoveAgent("obj_skydomeCloudsPainterlyBHorizonFlagshipInterior", kScene);
   KTBM_RemoveAgent("obj_skydomeHazeEvenFlagshipInterior", kScene);
   KTBM_RemoveAgent("obj_skydomeOuterDayFlagshipInterior", kScene);
   KTBM_RemoveAgent("obj_boatCrabbingFlagshipExteriorDeckA", kScene);
   KTBM_RemoveAgent("obj_boatCrabbingFlagshipExteriorDeckB", kScene);
   KTBM_RemoveAgent("obj_boatDinghyFlagshipExteriorDeckA", kScene);
   KTBM_RemoveAgent("obj_boatDinghyFlagshipExteriorDeckB", kScene);
   KTBM_RemoveAgent("obj_boatDinghyFlagshipExteriorDeckC", kScene);
   KTBM_RemoveAgent("obj_boatFishingLargeFlagshipExteriorDeckA", kScene);
   KTBM_RemoveAgent("obj_boatFishingLargeFlagshipExteriorDeckB", kScene);
   KTBM_RemoveAgent("obj_boatFishingLargeFlagshipExteriorDeckC", kScene);
   KTBM_RemoveAgent("obj_boatFishingLargeFlagshipExteriorDeckD", kScene);
   KTBM_RemoveAgent("obj_boatFlatbottomFlagshipExteriorDeckA", kScene);
   KTBM_RemoveAgent("obj_boatFlatbottomFlagshipExteriorDeckB", kScene);
   KTBM_RemoveAgent("obj_boatFlatbottomFlagshipExteriorDeckC", kScene);
   KTBM_RemoveAgent("obj_boatJunkFlagshipExteriorDeckA", kScene);
   KTBM_RemoveAgent("obj_boatJunkFlagshipExteriorDeckB", kScene);
   KTBM_RemoveAgent("obj_boatJunkFlagshipExteriorDeckC", kScene);
   KTBM_RemoveAgent("obj_boatJunkFlagshipExteriorDeckD", kScene);
   KTBM_RemoveAgent("obj_boatJunkFlagshipExteriorDeckE", kScene);
   KTBM_RemoveAgent("obj_boatSailFlagshipExteriorDeckA", kScene);
   KTBM_RemoveAgent("obj_boatSailFlagshipExteriorDeckB", kScene);
   KTBM_RemoveAgent("obj_boatSailFlagshipExteriorDeckC", kScene);
   KTBM_RemoveAgent("obj_boatSailFlagshipExteriorDeckD", kScene);
   KTBM_RemoveAgent("obj_boatSailFlagshipExteriorDeckF", kScene);
   KTBM_RemoveAgent("obj_boatTrawlerFlagshipExteriorDeckA", kScene);
   KTBM_RemoveAgent("obj_boatTrawlerFlagshipExteriorDeckB", kScene);
   KTBM_RemoveAgent("obj_boatTrawlerFlagshipExteriorDeckC", kScene);
   KTBM_RemoveAgent("obj_boatTrawlerFlagshipExteriorDeckD", kScene);
   KTBM_RemoveAgent("obj_boatTrawlerFlagshipExteriorDeckE", kScene);
   KTBM_RemoveAgent("obj_boatTrawlerFlagshipExteriorDeckF", kScene);
   KTBM_RemoveAgent("obj_boatTrawlerFlagshipExteriorDeckG", kScene);
   KTBM_RemoveAgent("obj_boatTrawlerFlagshipExteriorDeckH", kScene);
   KTBM_RemoveAgent("obj_flagshipExteriorDeckLandA", kScene);
   KTBM_RemoveAgent("obj_flagshipExteriorDeckLandB", kScene);
   KTBM_RemoveAgent("obj_flagshipExteriorDeckLandC", kScene);
   KTBM_RemoveAgent("obj_flagshipExteriorDeckLandD", kScene);
   KTBM_RemoveAgent("obj_flagshipExteriorDeckLandE", kScene);
   KTBM_RemoveAgent("obj_boatTugNormaFlagshipExteriorDeckA", kScene);
   KTBM_RemoveAgent("obj_boatTugNormaFlagshipExteriorDeckB", kScene);
   KTBM_RemoveAgent("obj_boatTugNormaFlagshipExteriorDeckC", kScene);
   KTBM_RemoveAgent("obj_buoyFlagshipExteriorDeckA", kScene);
   KTBM_RemoveAgent("obj_buoyFlagshipExteriorDeckB", kScene);
   KTBM_RemoveAgent("obj_buoyFlagshipExteriorDeckC", kScene);
   KTBM_RemoveAgent("obj_dockFlagshipExteriorDeckA", kScene);
   KTBM_RemoveAgent("obj_dockFlagshipExteriorDeckB", kScene);
   KTBM_RemoveAgent("obj_dockFlagshipExteriorDeckC", kScene);
   KTBM_RemoveAgent("obj_dockFlagshipExteriorDeckD", kScene);
   KTBM_RemoveAgent("obj_flatsFlagshipExteriorDeckA", kScene);
   KTBM_RemoveAgent("obj_flatsFlagshipExteriorDeckB", kScene);
   KTBM_RemoveAgent("obj_flotsamFlagshipExteriorDeckA", kScene);
   KTBM_RemoveAgent("obj_flotsamFlagshipExteriorDeckB", kScene);
   KTBM_RemoveAgent("obj_gangwayFlagshipExteriorDeckA", kScene);
   KTBM_RemoveAgent("obj_chairPlasticFlagshipExteriorDeckA", kScene);
   KTBM_RemoveAgent("obj_chairPlasticFlagshipExteriorDeckB", kScene);
   KTBM_RemoveAgent("obj_beerCanFlagshipExteriorDeck", kScene);
   KTBM_RemoveAgent("obj_beerCanOpenFlagshipExteriorDeck", kScene);
   KTBM_RemoveAgent("obj_coolerFlagshipExteriorDeck", kScene);
   KTBM_RemoveAgent("obj_coolerLidFlagshipExteriorDeck", kScene);
   KTBM_RemoveAgent("obj_ashtrayFlagshipExteriorDeck", kScene);
   KTBM_RemoveAgent("obj_chairPlasticFlagshipExteriorDeckC", kScene);
   KTBM_RemoveAgent("obj_strawFlagshipExteriorDeck", kScene);
   KTBM_RemoveAgent("obj_bagDuffelB", kScene);
   KTBM_RemoveAgent("obj_boatMotorChesapeake", kScene);
   KTBM_RemoveAgent("obj_boatTugNormaFlagshipExteriorDeckD", kScene);
   KTBM_RemoveAgent("obj_chairRigidExteriorDeck", kScene);
   KTBM_RemoveAgent("obj_tiesZipHandsWD", kScene);
   KTBM_RemoveAgent("obj_gunPistol106", kScene);
   KTBM_RemoveAgent("obj_flatsFlagshipExteriorDeckB01", kScene);
   KTBM_RemoveAgent("obj_flatsFlagshipExteriorDeckB02", kScene);
   KTBM_RemoveAgent("obj_flatsFlagshipExteriorDeckB03", kScene);
   KTBM_RemoveAgent("obj_flatsFlagshipExteriorDeckA01", kScene);
   KTBM_RemoveAgent("obj_matteSkydomeOvercastHorizon", kScene);
   KTBM_RemoveAgent("obj_matteSkydomeOvercastPainted", kScene);
   KTBM_RemoveAgent("obj_matteSkydomeOvercastSkyGrad", kScene);
   KTBM_RemoveAgent("obj_matteSkydomeOvercastTile", kScene);
   KTBM_RemoveAgent("obj_matteSkydomeOvercastTop", kScene);
   KTBM_RemoveAgent("obj_skydomeCloudsFullFlagshipExteriorDeck", kScene);
   KTBM_RemoveAgent("obj_skydomeCloudsHorizonFlagshipExteriorDeck", kScene);
   KTBM_RemoveAgent("obj_skydomeCloudsPainterlyBHorizonFlagshipExteriorDeck", kScene);
   KTBM_RemoveAgent("obj_skydomeHazeEvenFlagshipExteriorDeck", kScene);
   KTBM_RemoveAgent("obj_skydomeOuterDayFlagshipExteriorDeck", kScene);
   KTBM_RemoveAgent("obj_sideTableFlagshipExteriorDeck", kScene);
   KTBM_RemoveAgent("obj_boatTugNormaFlagshipExteriorDeckA_decals", kScene);
   KTBM_RemoveAgent("obj_lookAtMichonne", kScene);
   KTBM_RemoveAgent("obj_lookAtGreg", kScene);
   KTBM_RemoveAgent("obj_lookAtNorma", kScene);
   KTBM_RemoveAgent("obj_lookAtRandall", kScene);
   KTBM_RemoveAgent("obj_lookAtZachary", kScene);
   KTBM_RemoveAgent("obj_lookAtPete", kScene);
   KTBM_RemoveAgent("obj_lookAtJonas", kScene);
   KTBM_RemoveAgent("obj_lookAtGabby", kScene);
   KTBM_RemoveAgent("obj_lookAtSamantha", kScene);
   KTBM_RemoveAgent("obj_lookAtCrabberMale01", kScene);
   KTBM_RemoveAgent("obj_lookAtCrabberMale02", kScene);
   KTBM_RemoveAgent("obj_lookAtCrabberMale03", kScene);
   KTBM_RemoveAgent("obj_lookAtCrabberFemale01", kScene);
   KTBM_RemoveAgent("obj_lookAtCrabberFemale02", kScene);
   KTBM_RemoveAgent("obj_lookAtCrabberFemale03", kScene);
   KTBM_RemoveAgent("obj_lookAtCrabberFemale04", kScene);

   --cam agents
   KTBM_RemoveAgent("cam_michonne_CU", kScene);
   KTBM_RemoveAgent("cam_michonne_MED", kScene);
   KTBM_RemoveAgent("cam_michonne_OTS", kScene);
   KTBM_RemoveAgent("cam_greg_CU", kScene);
   KTBM_RemoveAgent("cam_greg_MED", kScene);
   KTBM_RemoveAgent("cam_greg_OTS", kScene);
   KTBM_RemoveAgent("cam_norma_CU", kScene);
   KTBM_RemoveAgent("cam_norma_MED", kScene);
   KTBM_RemoveAgent("cam_norma_OTS", kScene);
   KTBM_RemoveAgent("cam_randall_CU", kScene);
   KTBM_RemoveAgent("cam_randall_MED", kScene);
   KTBM_RemoveAgent("cam_randall_OTS", kScene);
   KTBM_RemoveAgent("cam_zachary_CU", kScene);
   KTBM_RemoveAgent("cam_zachary_MED", kScene);
   KTBM_RemoveAgent("cam_zachary_OTS", kScene);
   KTBM_RemoveAgent("cam_cutscene", kScene);
   KTBM_RemoveAgent("cam_cutsceneChore", kScene);
   KTBM_RemoveAgent("cam_norma_walk_CU", kScene);
   KTBM_RemoveAgent("cam_michonne_walk_CU", kScene);
   KTBM_RemoveAgent("cam_michonne_walk_OTS", kScene);
   KTBM_RemoveAgent("cam_cs_exit_timer", kScene);
   KTBM_RemoveAgent("cam_pete_OTS", kScene);
   KTBM_RemoveAgent("cam_samantha_CU", kScene);
   KTBM_RemoveAgent("cam_samantha_OTS", kScene);
   KTBM_RemoveAgent("cam_samantha_MED", kScene);
   KTBM_RemoveAgent("cam_cs_enter_timer", kScene);
   
   --ui agents
   
   --fx agents
   KTBM_RemoveAgent("fx_bloodBleedDirNrwDPlane", kScene);
   KTBM_RemoveAgent("fx_waterRippleRingEmitter_tire", kScene);
   KTBM_RemoveAgent("fx_waterRippleRingEmitter_tire01", kScene);
   KTBM_RemoveAgent("fx_waterRippleRingEmitter_tire02", kScene);
   KTBM_RemoveAgent("fx_waterRippleRingEmitter_tire03", kScene);
   KTBM_RemoveAgent("fx_waterRippleRingEmitter_tire04", kScene);
   KTBM_RemoveAgent("fx_waterRippleRingEmitter_tire05", kScene);
   KTBM_RemoveAgent("fx_waterRippleRingEmitter_tire06", kScene);
   KTBM_RemoveAgent("fx_waterRippleRingEmitter_tire07", kScene);
   KTBM_RemoveAgent("fx_waterRippleBoatEmitter", kScene);
   KTBM_RemoveAgent("fx_waterRippleBoatEmitter01", kScene);
   KTBM_RemoveAgent("fx_waterRippleBoatEmitter02", kScene);
   KTBM_RemoveAgent("fx_waterRippleBoatEmitter03", kScene);
   KTBM_RemoveAgent("fx_waterRippleBoatEmitter04", kScene);
   KTBM_RemoveAgent("fx_waterRippleBoatEmitter05", kScene);
   KTBM_RemoveAgent("fx_waterRippleBoatEmitter06", kScene);
   KTBM_RemoveAgent("fx_waterRippleBoatEmitter07", kScene);
   KTBM_RemoveAgent("fx_waterRippleBoatEmitter08", kScene);
   KTBM_RemoveAgent("fx_waterRippleBoatEmitter09", kScene);
   KTBM_RemoveAgent("fx_waterRippleBoatEmitter10", kScene);
   KTBM_RemoveAgent("fx_waterRippleBoatEmitter11", kScene);
   KTBM_RemoveAgent("fx_waterRippleBoatEmitter12", kScene);
   KTBM_RemoveAgent("fx_waterRippleBoatEmitter13", kScene);
   KTBM_RemoveAgent("fx_waterRippleBoatEmitter14", kScene);
   KTBM_RemoveAgent("fx_waterRippleBoatEmitter15", kScene);
   KTBM_RemoveAgent("fx_waterRippleBoatEmitter16", kScene);
   KTBM_RemoveAgent("fx_waterRippleBoatEmitter17", kScene);
   KTBM_RemoveAgent("fx_waterRippleBoatEmitter18", kScene);
   KTBM_RemoveAgent("fx_waterRippleBoatEmitter19", kScene);
   KTBM_RemoveAgent("fx_waterRippleBoatEmitter20", kScene);
   KTBM_RemoveAgent("fx_waterRippleBoatEmitter21", kScene);
   KTBM_RemoveAgent("fx_waterRippleBoatEmitter22", kScene);
   KTBM_RemoveAgent("fx_waterRippleBoatEmitter23", kScene);
   KTBM_RemoveAgent("fx_waterRippleBoatEmitter24", kScene);
   KTBM_RemoveAgent("fx_waterRippleBoatEmitter25", kScene);
   KTBM_RemoveAgent("fx_waterRippleBoatEmitter26", kScene);
   KTBM_RemoveAgent("fx_waterRippleBoatEmitter27", kScene);
   KTBM_RemoveAgent("fx_waterRippleBoatEmitter28", kScene);
   KTBM_RemoveAgent("fx_waterRippleBoatEmitter29", kScene);
   KTBM_RemoveAgent("fx_waterRippleBoatEmitter30", kScene);
   KTBM_RemoveAgent("fx_waterOceanFlagshipExteriorDeck", kScene);
   KTBM_RemoveAgent("fx_seagullsDistanceA", kScene);
   KTBM_RemoveAgent("fx_seagullsDistanceB", kScene);
   KTBM_RemoveAgent("fx_seagullsDistanceA01", kScene);
   KTBM_RemoveAgent("fx_seagullsDistanceB01", kScene);
   KTBM_RemoveAgent("fx_seagullDistanceC", kScene);
   KTBM_RemoveAgent("fx_seagullsDistanceA02", kScene);
   KTBM_RemoveAgent("fx_seagullDistanceC01", kScene);
   
   --fxGroup agents
   
   --module agents
   KTBM_RemoveAgent("module_enlightensystem", kScene);
   KTBM_RemoveAgent("module_environment", kScene);
   KTBM_RemoveAgent("module_lightprobe", kScene);
   KTBM_RemoveAgent("module_post_effect", kScene);
   
   --group agents
   
   --light agents
   KTBM_RemoveAgent("light_CHAR_shadow", kScene); --Light Type:  ( nil )
   KTBM_RemoveAgent("light_OBJ_Main_Key", kScene); --Light Type:  ( nil )
   KTBM_RemoveAgent("light_OBJ_Main_FILL", kScene); --Light Type:  ( nil )
   KTBM_RemoveAgent("light_FX_waterSpec", kScene); --Light Type:  ( nil )
   KTBM_RemoveAgent("light_FX_waterSpec01", kScene); --Light Type:  ( nil )
   KTBM_RemoveAgent("light_FX_waterDir", kScene); --Light Type:  ( nil )
   --KTBM_RemoveAgent("light_D", kScene); --Light Type: eLightEnvType_DirectionalKey ( 2 )
   KTBM_RemoveAgent("light_a02", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a03", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a04", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a06", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a07", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a09", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a10", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a11", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a12", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a13", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a20", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a21", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_amb", kScene); --Light Type: eLightEnvType_Ambient ( 3 )
   KTBM_RemoveAgent("light_amb sky", kScene); --Light Type: eLightEnvType_Ambient ( 3 )
   KTBM_RemoveAgent("light_a25", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a26", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a27", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a28", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a33", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a40", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a41", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a44", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a45", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a49", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a46", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a47", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a48", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a42", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a50", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a51", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a52", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a53", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a54", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a55", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a56", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a57", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a58", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a59", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a60", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a61", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a62", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a36", kScene); --Light Type: eLightEnvType_Point ( 0 )
   KTBM_RemoveAgent("light_a34", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a37", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a38", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a39", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a63", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a64", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a65", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a66", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a67", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a68", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a69", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a70", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a71", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a72", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a73", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a74", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a75", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a79", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a80", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a81", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a82", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a84", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a86", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a87", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a90", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a93", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a95", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a96", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a97", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a98", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a99", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a100", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a103", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a104", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a106", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a107", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a108", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a111", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a112", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a113", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a114", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a115", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a116", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a117", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a118", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a120", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a121", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a122", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a123", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a124", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a126", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a127", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a128", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a129", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a130", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a131", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a136", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a137", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a138", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a139", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a140", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a141", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a144", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a145", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a146", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a152", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a153", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a154", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a155", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a156", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a157", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a158", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a161", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a162", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a163", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a164", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a109", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a08", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a150", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a125", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a151", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a76", kScene); --Light Type: eLightEnvType_Point ( 0 )
   KTBM_RemoveAgent("light_a43", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a85", kScene); --Light Type: eLightEnvType_Spot ( 1 )
   KTBM_RemoveAgent("light_a77", kScene); --Light Type: eLightEnvType_Point ( 0 )
   KTBM_RemoveAgent("light_a78", kScene); --Light Type: eLightEnvType_Point ( 0 )
   KTBM_RemoveAgent("light_a83", kScene); --Light Type: eLightEnvType_Point ( 0 )
   KTBM_RemoveAgent("light_a88", kScene); --Light Type: eLightEnvType_Point ( 0 )
   KTBM_RemoveAgent("light_Dir_Amb_Char", kScene); --Light Type: eLightEnvType_DirectionalAmbient ( 4 )
   
   --light_CHAR_CC agents
   KTBM_RemoveAgent("light_CHAR_CC_Michonne_Fill", kScene);
   KTBM_RemoveAgent("light_CHAR_CC_Michonne_Rim", kScene);
   KTBM_RemoveAgent("light_CHAR_CC_Michonne_Key", kScene);
   KTBM_RemoveAgent("light_CHAR_CC_Zachary_Fill", kScene);
   KTBM_RemoveAgent("light_CHAR_CC_Zachary_Rim", kScene);
   KTBM_RemoveAgent("light_CHAR_CC_Zachary_Key", kScene);
   KTBM_RemoveAgent("light_CHAR_CC_Randall_Fill", kScene);
   KTBM_RemoveAgent("light_CHAR_CC_Randall_Rim", kScene);
   KTBM_RemoveAgent("light_CHAR_CC_Randall_Key", kScene);
   KTBM_RemoveAgent("light_CHAR_CC_Pete_Fill", kScene);
   KTBM_RemoveAgent("light_CHAR_CC_Pete_Rim", kScene);
   KTBM_RemoveAgent("light_CHAR_CC_Pete_Key", kScene);
   KTBM_RemoveAgent("light_CHAR_CC_Norma_Fill", kScene);
   KTBM_RemoveAgent("light_CHAR_CC_Norma_Rim", kScene);
   KTBM_RemoveAgent("light_CHAR_CC_Norma_Key", kScene);
   KTBM_RemoveAgent("light_CHAR_CC_Jonas_Fill", kScene);
   KTBM_RemoveAgent("light_CHAR_CC_Jonas_Rim", kScene);
   KTBM_RemoveAgent("light_CHAR_CC_Jonas_Key", kScene);
   KTBM_RemoveAgent("light_CHAR_CC_Greg_Fill", kScene);
   KTBM_RemoveAgent("light_CHAR_CC_Greg_Rim", kScene);
   KTBM_RemoveAgent("light_CHAR_CC_Greg_Key", kScene);
   KTBM_RemoveAgent("light_CHAR_CC_Gabby_Fill", kScene);
   KTBM_RemoveAgent("light_CHAR_CC_Gabby_Rim", kScene);
   KTBM_RemoveAgent("light_CHAR_CC_Gabby_Key", kScene);
   KTBM_RemoveAgent("light_CHAR_CC_CrabberMale03_Fill", kScene);
   KTBM_RemoveAgent("light_CHAR_CC_CrabberMale03_Rim", kScene);
   KTBM_RemoveAgent("light_CHAR_CC_CrabberMale03_Key", kScene);
   KTBM_RemoveAgent("light_CHAR_CC_CrabberMale02_Fill", kScene);
   KTBM_RemoveAgent("light_CHAR_CC_CrabberMale02_Rim", kScene);
   KTBM_RemoveAgent("light_CHAR_CC_CrabberMale02_Key", kScene);
   KTBM_RemoveAgent("light_CHAR_CC_CrabberMale01_Fill", kScene);
   KTBM_RemoveAgent("light_CHAR_CC_CrabberMale01_Rim", kScene);
   KTBM_RemoveAgent("light_CHAR_CC_CrabberMale01_Key", kScene);
   KTBM_RemoveAgent("light_CHAR_CC_CrabberFemale04_Fill", kScene);
   KTBM_RemoveAgent("light_CHAR_CC_CrabberFemale04_Rim", kScene);
   KTBM_RemoveAgent("light_CHAR_CC_CrabberFemale04_Key", kScene);
   KTBM_RemoveAgent("light_CHAR_CC_CrabberFemale03_Fill", kScene);
   KTBM_RemoveAgent("light_CHAR_CC_CrabberFemale03_Rim", kScene);
   KTBM_RemoveAgent("light_CHAR_CC_CrabberFemale03_Key", kScene);
   KTBM_RemoveAgent("light_CHAR_CC_CrabberFemale02_Fill", kScene);
   KTBM_RemoveAgent("light_CHAR_CC_CrabberFemale02_Rim", kScene);
   KTBM_RemoveAgent("light_CHAR_CC_CrabberFemale02_Key", kScene);
   KTBM_RemoveAgent("light_CHAR_CC_CrabberFemale01_Fill", kScene);
   KTBM_RemoveAgent("light_CHAR_CC_CrabberFemale01_Rim", kScene);
   KTBM_RemoveAgent("light_CHAR_CC_CrabberFemale01_Key", kScene);
   
   --lightrig_CC agents
   KTBM_RemoveAgent("lightrig_CC_michonne", kScene);
   KTBM_RemoveAgent("lightrig_CC_zachary", kScene);
   KTBM_RemoveAgent("lightrig_CC_randall", kScene);
   KTBM_RemoveAgent("lightrig_CC_pete", kScene);
   KTBM_RemoveAgent("lightrig_CC_norma", kScene);
   KTBM_RemoveAgent("lightrig_CC_jonas", kScene);
   KTBM_RemoveAgent("lightrig_CC_greg", kScene);
   KTBM_RemoveAgent("lightrig_CC_gabby", kScene);
   KTBM_RemoveAgent("lightrig_CC_crabbermale03", kScene);
   KTBM_RemoveAgent("lightrig_CC_crabbermale02", kScene);
   KTBM_RemoveAgent("lightrig_CC_crabbermale01", kScene);
   KTBM_RemoveAgent("lightrig_CC_crabberfemale04", kScene);
   KTBM_RemoveAgent("lightrig_CC_crabberfemale03", kScene);
   KTBM_RemoveAgent("lightrig_CC_crabberfemale02", kScene);
   KTBM_RemoveAgent("lightrig_CC_crabberfemale01", kScene);
   
   --lightrotation_CC agents
   KTBM_RemoveAgent("lightrotation_CC_template_3point", kScene);
   KTBM_RemoveAgent("lightrotation_CC_template_day", kScene);
   KTBM_RemoveAgent("lightrotation_CC_template_night", kScene);
   KTBM_RemoveAgent("lightrotation_CC_template_top", kScene);
   
   --charLightComposer agents
   KTBM_RemoveAgent("charLightComposer_keylight_moon", kScene);
   
   --unsorted agents
   KTBM_RemoveAgent("lightENV_skydomeCloudsFullFlagshipExteriorDeck", kScene);
   KTBM_RemoveAgent("lightENV_skydomeCloudsPainterlyBHorizonFlagshipExteriorDeck", kScene);
   KTBM_RemoveAgent("lightENV_skydomeHazeEvenFlagshipExteriorDeck", kScene);
   KTBM_RemoveAgent("lightENV_skydomeOuterDayFlagshipExteriorDeck", kScene);
   KTBM_RemoveAgent("lightENV_grass", kScene);
   KTBM_RemoveAgent("lightENV_treeBranches_amb", kScene);
   KTBM_RemoveAgent("lightENV_treeBranches_key", kScene);
   KTBM_RemoveAgent("lightENV_treeRim", kScene);
   KTBM_RemoveAgent("lightENV_brush", kScene);
   KTBM_RemoveAgent("lightENV_groundCover", kScene);
   KTBM_RemoveAgent("lightENV_skydomeCloudsHorizonFlagshipExteriorDeck", kScene);
   KTBM_RemoveAgent("Michonne", kScene);
   KTBM_RemoveAgent("Greg", kScene);
   KTBM_RemoveAgent("Norma", kScene);
   KTBM_RemoveAgent("Randall", kScene);
   KTBM_RemoveAgent("Zachary", kScene);
   KTBM_RemoveAgent("Pete", kScene);
   KTBM_RemoveAgent("Jonas", kScene);
   KTBM_RemoveAgent("Gabby", kScene);
   KTBM_RemoveAgent("Samantha", kScene);
   KTBM_RemoveAgent("audio_music_interface_adv_flagshipExteriorDeck", kScene);
   KTBM_RemoveAgent("audio_event_emitter_lapping water", kScene);
   KTBM_RemoveAgent("audio_sfx_interface_adv_flagshipExteriorDeck", kScene);
   KTBM_RemoveAgent("audio_reverb_interface_adv_flagshipExteriorDeck", kScene);
   KTBM_RemoveAgent("audio_listener_interface_adv_flagshipExteriorDeck", kScene);
   KTBM_RemoveAgent("audio_ambience_interface_adv_flagshipExteriorDeck", kScene);
   KTBM_RemoveAgent("audio_event_emitter_amb_ext_ship_deck", kScene);
   KTBM_RemoveAgent("dummy_world", kScene);
   KTBM_RemoveAgent("lightENV_skydome_fillA", kScene);
   KTBM_RemoveAgent("lightENV_skydome_sun", kScene);
   KTBM_RemoveAgent("lightENV_skydome_rim", kScene);
   KTBM_RemoveAgent("lightENV_skydome_negative", kScene);
   KTBM_RemoveAgent("lightENV_skydome_amb", kScene);
   KTBM_RemoveAgent("audio_event preload_interface_adv_flagshipExteriorDeck", kScene);
   KTBM_RemoveAgent("fxg_bloodBleedRadDir", kScene);
   KTBM_RemoveAgent("fxg_bloodBleedDirRnd", kScene);
   KTBM_RemoveAgent("audio_event_emitter_motorboat", kScene);
   KTBM_RemoveAgent("lightENV_flagshipLights", kScene);
   KTBM_RemoveAgent("fxg_bloodBleedRadRnd", kScene);
   KTBM_RemoveAgent("fxg_bloodBleedRadDir01", kScene);
   KTBM_RemoveAgent("lightENV_water", kScene);
   KTBM_RemoveAgent("lightENV_waterSpec", kScene);
   KTBM_RemoveAgent("CrabberMale01", kScene);
   KTBM_RemoveAgent("CrabberMale02", kScene);
   KTBM_RemoveAgent("CrabberMale03", kScene);
   KTBM_RemoveAgent("CrabberFemale01", kScene);
   KTBM_RemoveAgent("CrabberFemale02", kScene);
   KTBM_RemoveAgent("CrabberFemale03", kScene);
   KTBM_RemoveAgent("CrabberFemale04", kScene);

   
end