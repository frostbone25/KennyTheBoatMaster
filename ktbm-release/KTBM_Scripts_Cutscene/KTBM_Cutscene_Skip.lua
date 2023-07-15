KTBM_Cutscene_Skip_TextAgent = nil;
KTBM_Cutscene_Skip_CanSkip = false;
KTBM_Cutscene_Skip_CutsceneFinished = false;
KTBM_Cutscene_Skip_Skipped = false;

local number_skipStartTime = 0;

KTBM_Cutscene_Skip_Build = function()
    KTBM_Cutscene_Skip_TextAgent = KTBM_TextUI_CreateTextAgent("KTBM_Cutscene_Skip_TextAgent", "[Left Mouse] or [Space] to skip", Vector(0, 0, 0), 2, 0);

    --scale note
    --1.0 = default
    --0.5 = half
    --2.0 = double
    TextSetScale(KTBM_Cutscene_Skip_TextAgent, 0.5);

    --color note
    --text colors are additive on the scene
    TextSetColor(KTBM_Cutscene_Skip_TextAgent, Color(1.0, 1.0, 1.0, 1.0));

    number_skipStartTime = GetTotalTime();
end

KTBM_Cutscene_Skip_Update = function()
    local number_currentGameTime = GetTotalTime();

    KTBM_Cutscene_Skip_CanSkip = number_currentGameTime > number_skipStartTime + 1.0;
    KTBM_PropertySet(KTBM_Cutscene_Skip_TextAgent, "Runtime: Visible", KTBM_Cutscene_Skip_CanSkip);

    if(KTBM_Cutscene_Skip_CanSkip == true) then
        if (Input_IsVKeyPressed(KTBM_Keycodes_LeftMouse)) then
            KTBM_Cutscene_Skip_Skipped = true;
        end

        if (Input_IsVKeyPressed(KTBM_Keycodes_Space)) then
            KTBM_Cutscene_Skip_Skipped = true;
        end
    end

    if(KTBM_Cutscene_Skip_CanSkip == false) or (KTBM_Cutscene_Skip_CutsceneFinished == true) then
        KTBM_PropertySet(KTBM_Cutscene_Skip_TextAgent, "Runtime: Visible", false);
        return;
    end

    --screen pos notes
    --0.0 0.0 0.0 = top left
    --0.5 0.5 0.0 = center
    --0.0 1.0 0.0 = bottom left
    AgentSetWorldPosFromLogicalScreenPos(KTBM_Cutscene_Skip_TextAgent, Vector(0.5, 0.95, 0.0));
end