-- desc lua main
-- maintainer hugoyu

local script_files_to_load = 
{
    "script/Updater",
    "script/Timer",
}

-- load files
for i = 1, #script_files_to_load do
    require(script_files_to_load[i])
end 

local function test_timer()
    local function test_1()
        local timer = Timer.CreateInterval(2, SwitchBG)
        Timer.CreateOnce(10, function() Timer.KillTimer(timer) end)
    end

    Timer.CreateOnce(2, SwitchBG)
    Timer.CreateOnce(4, test_1)
    
    Timer.CreateInterval(1, function() Print("HolyShit") end)
end

local function main()
    test_timer()
end

function Reload()
    for i = 1, #script_files_to_load do
        package.loaded[script_files_to_load[i]] = nil
    end
    LoadScript()
end

main()