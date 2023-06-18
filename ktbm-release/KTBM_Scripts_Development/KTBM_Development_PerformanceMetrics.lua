--[[

]]--

--(public) relight dev variables (public because these values need to be persistent)
KTBM_Development_PerformanceMetrics_Text = nil;
KTBM_Development_PerformanceMetrics_TextTitle = "[Performance Metrics]";
KTBM_Development_PerformanceMetrics_ShowCommonMetrics = true;
KTBM_Development_PerformanceMetrics_ShowTimeMetrics = true;
KTBM_Development_PerformanceMetrics_ShowVramMetrics = true;
KTBM_Development_PerformanceMetrics_ShowHeapMetrics = true;

KTBM_Development_PerformanceMetrics_Initalize = function()
    -------------------------------------------------------------
    --initalize menu text

    --create our menu text
    KTBM_Development_PerformanceMetrics_Text = KTBM_TextUI_CreateTextAgent("PerformanceMetricsText", "Performance Metrics Text Initalized", Vector(0, 0, 0), 0, 0);

    --set the text color
    TextSetColor(KTBM_Development_PerformanceMetrics_Text, Color(0.5, 1.0, 0.5, 1.0));

    --scale note
    --1.0 = default
    --0.5 = half
    --2.0 = double
    TextSetScale(KTBM_Development_PerformanceMetrics_Text, 0.5);
end

KTBM_Development_PerformanceMetrics_Update = function()  
    -------------------------------------------------------------
    --screen pos notes
    --0.0 0.0 0.0 = top left
    --0.5 0.5 0.0 = center
    --0.0 1.0 0.0 = bottom left
    local screenPos = Vector(0.0, 0.75, 0.0);
    AgentSetWorldPosFromLogicalScreenPos(KTBM_Development_PerformanceMetrics_Text, screenPos);

    -------------------------------------------------------------
    local finalText = KTBM_Development_PerformanceMetrics_TextTitle;

    -------------------------------------------------------------------------
    --common metrics

    if(KTBM_Development_PerformanceMetrics_ShowCommonMetrics) then
        local averageFrameTime = GetAverageFrameTime();
        local fpsValue = 1.0 / GetAverageFrameTime();

        finalText = finalText .. "\n"; --new line
        finalText = finalText .. "FPS: " .. fpsValue;

        finalText = finalText .. "\n"; --new line
        finalText = finalText .. "Average Frame Time: " .. averageFrameTime;

        finalText = finalText .. "\n"; --new line
        finalText = finalText .. "--------------------------";
    end

    -------------------------------------------------------------------------
    --time metrics

    if(KTBM_Development_PerformanceMetrics_ShowTimeMetrics) then
        local frameTime = GetFrameTime();
        local frameNumber = GetFrameNumber();
        local totalTime = GetTotalTime();

        finalText = finalText .. "\n"; --new line
        finalText = finalText .. "Frame Time: " .. frameTime;

        finalText = finalText .. "\n"; --new line
        finalText = finalText .. "Frame Number: " .. frameNumber;

        finalText = finalText .. "\n"; --new line
        finalText = finalText .. "Total Time: " .. totalTime;

        finalText = finalText .. "\n"; --new line
        finalText = finalText .. "--------------------------";
    end

    -------------------------------------------------------------------------
    --vram metrics

    if(KTBM_Development_PerformanceMetrics_ShowVramMetrics) then
        local vramSize = GetVramSize();
        local vramSize_MB = math.floor(vramSize * 1e-6);
        local vramAllocated = GetVramAllocated();
        local vramAllocated_MB = math.floor(vramAllocated * 1e-6);
        local vramUsagePercent = (vramAllocated / vramSize) * 100;

        finalText = finalText .. "\n"; --new line
        finalText = finalText .. "Vram Size: " .. vramSize .. " (" .. vramSize_MB .. " MB)";

        finalText = finalText .. "\n"; --new line
        finalText = finalText .. "Vram Allocated: " .. vramAllocated .. " (" .. vramAllocated_MB .. " MB)";

        finalText = finalText .. "\n"; --new line
        finalText = finalText .. "Vram Usage: " .. vramUsagePercent .. "%";

        finalText = finalText .. "\n"; --new line
        finalText = finalText .. "--------------------------";
    end

    -------------------------------------------------------------------------
    --heap metrics

    if(KTBM_Development_PerformanceMetrics_ShowHeapMetrics) then
        local heapSize_MB = GetHeapSizeMB();
        local heapSizeAllocated = GetHeapAllocated();
        local heapSizeAllocated_MB = math.floor(GetHeapAllocated() * 1e-6);
        local heapUsagePercent = (heapSizeAllocated_MB / heapSize_MB) * 100;

        finalText = finalText .. "\n"; --new line
        finalText = finalText .. "Heap Size MB: " .. heapSize_MB .. " MB";

        finalText = finalText .. "\n"; --new line
        finalText = finalText .. "Heap Allocated: " .. heapSizeAllocated .. " (" .. heapSizeAllocated_MB .. " MB)";

        finalText = finalText .. "\n"; --new line
        finalText = finalText .. "Heap Usage: " .. heapUsagePercent .. "%";
    end

    TextSet(KTBM_Development_PerformanceMetrics_Text, finalText);
end