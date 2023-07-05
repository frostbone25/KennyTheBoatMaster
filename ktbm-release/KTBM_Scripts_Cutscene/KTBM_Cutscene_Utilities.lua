local controller_previousVoiceLineAnimation = nil;
local controller_previousVoiceLineSound = nil;

KTBM_Cutscene_PlayVoiceLine = function(agent_character, string_lineID, number_intensity, number_volume)
    if (not agent_character) then
        do return end
    end

    if(controller_previousVoiceLineAnimation ~= nil) then
        ControllerKill(controller_previousVoiceLineAnimation);
        controller_previousVoiceLineAnimation = nil;
    end

    if(controller_previousVoiceLineSound ~= nil) then
        ControllerKill(controller_previousVoiceLineSound);
        controller_previousVoiceLineSound = nil;
    end

    --local controller_newVoiceLineAnimation = PlayAnimation(agent_character, string_lineID .. ".anm");
    local controller_newVoiceLineAnimation = PlayAnimation(agent_character, string_lineID);
    local controller_newVoiceLineSound = SoundPlay(string_lineID .. ".wav");
    
    ControllerSetContribution(controller_newVoiceLineAnimation, number_intensity);
    ControllerSetPriority(controller_newVoiceLineSound, 1000);
    ControllerSetLooping(controller_newVoiceLineAnimation, false);
    ControllerSetLooping(controller_newVoiceLineSound, false);
    ControllerSetSoundVolume(controller_newVoiceLineSound, number_volume);

    controller_previousVoiceLineAnimation = controller_newVoiceLineAnimation;
    controller_previousVoiceLineSound = controller_newVoiceLineSound;
end