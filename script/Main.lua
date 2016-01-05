-- desc lua main
-- maintainer hugoyu

local script_files_to_load = 
{
    "script/Updater",
    "script/Timer",
    "script/Toucher",
}

-- load files
for i = 1, #script_files_to_load do
    require(script_files_to_load[i])
end

local function test_timer()
    --[[
    local function test_1()
        local timer = Timer.CreateInterval(2, SwitchBG)
        Timer.CreateOnce(10, function() Timer.KillTimer(timer) end)
    end

    Timer.CreateOnce(2, SwitchBG)
    Timer.CreateOnce(4, test_1)
    
    Timer.CreateInterval(1, function() Print("HolyShit") end)
    --]]
    
    --Timer.CreateOnce(0.5, function() SetWave(0.005, 1) end)
    Timer.CreateOnce(0.5, function() SetWaveCenter(0, 0) end)
    Timer.CreateOnce(0.5, function() SetWave(0.005, 2) end)
--    Timer.CreateOnce(6, function() SetWave(0.0125, 2) end)
--    Timer.CreateOnce(8, function() SetWave(0.01, 2) end)

    Timer.CreateOnce(0.5, function() SetPond("FishIndex:-1;SetDestRand:160,293,10,0;SetSpeed:70") end)
    Timer.CreateOnce(2, function() SetPond("SetLight:0") end)
    
    Timer.CreateOnce(2, function() AddRipple(300, 300, 0.8) end)
    Timer.CreateOnce(4, function() AddRipple(220, 650, 0.8) end)
    Timer.CreateOnce(6, function() AddRipple(650, 340, 0.8) end)
    Timer.CreateOnce(8, function() AddRipple(430, 200, 0.8) end)
end

local function get_random_pos(width, height)
    local x, y = width, height
    local randAxis = math.random(0, 1)
    if randAxis == 0 then
        x = math.random(width)
        if math.random(0, 1) == 0 then
            y = 0
        else
            y = height
        end
    else
        y = math.random(height)
        if math.random(0, 1) == 0 then
            x = 0
        else
            x = width
        end
    end
    
    return x, y
end

local function test_create()
    math.randomseed(os.time())
    
    local sprite = "Sprite/PondView/Elements/stone_1.png"
    local width, height = GameScript.GetWinSize()
    
    local stone_count = 3
    for i = 1, stone_count do
        local x, y = get_random_pos(width, height)
        local rot = math.random(-10, 10)
        local scale = math.random() * 0.4 + 0.8
        local order = -1
        
        GameScript.AddDrawElement(sprite, x, y, rot, scale, order)
    end
end

local function create_ripple()
    local width, height = GameScript.GetWinSize()
    local possible = 0.5
    
    if math.random() >= possible then
        local x, y = math.random(width), math.random(height)
        local strength = math.random() * 0.5 + 0.5
        GameScript.AddRipple(x, y, strength)
    end
end

local function main()
    Timer.CreateOnce(0.1, function() SetWaveCenter(0, 0) end)
    Timer.CreateOnce(0.1, function() SetWave(0.005, 2) end)
    Timer.CreateOnce(0.1, function() SetPond("FishIndex:-1;SetDestRand:160,293,10,0;SetSpeed:70") end)
    Timer.CreateOnce(2, function() SetPond("SetLight:0") end)
    
    Timer.CreateInterval(2, create_ripple)
    
    Timer.CreateOnce(0.1, test_create)
end

function Reload()
    for i = 1, #script_files_to_load do
        package.loaded[script_files_to_load[i]] = nil
    end
    LoadScript()
end

main()