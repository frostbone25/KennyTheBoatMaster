KTBM_Cutscene_PlayVoiceLine = function(agent_character, string_lineID, number_intensity, number_volume)
    if (not agent_character) then
        do return end
    end

    --local controller_voiceLineAnimation = PlayAnimation(agent_character, string_lineID .. ".anm");
    local controller_voiceLineAnimation = PlayAnimation(agent_character, string_lineID);
    local controller_voiceLineSound = SoundPlay(string_lineID .. ".wav");
    
    ControllerSetContribution(controller_voiceLineAnimation, number_intensity);
    ControllerSetLooping(controller_voiceLineAnimation, false);
    ControllerSetLooping(controller_voiceLineSound, false);
    ControllerSetSoundVolume(controller_voiceLineSound, number_volume);
end