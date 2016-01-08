-- desc lua main
-- maintainer hugoyu

local script_files_to_load = 
{
    "script/Updater",
    "script/Timer",
    "script/Toucher",
    "script/DrawElementUtil",
}

-- load files
for i = 1, #script_files_to_load do
    require(script_files_to_load[i])
end

function Reload()
    GameScript.ResetScene()
    
    for i = 1, #script_files_to_load do
        package.loaded[script_files_to_load[i]] = nil
    end
    GameScript.LoadScript()
    
    OnInit()
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

local function create_stones(stone_count, scale_speed, rotate_speed)
    math.randomseed(os.time())
    
    local sprite = "Sprite/PondView/Element/Stone/stone_1.png"
    local width, height = GameScript.GetWinSize()
    
    local nodeIds = {}
    
    stone_count = stone_count or 6
    for i = 1, stone_count do
        local x, y = get_random_pos(width, height)
        local rot = math.random(-10, 10)
        local scale = math.random() * 0.4 + 0.8
        local order = -1
        
        local nodeId = GameScript.AddDrawElement(sprite, x, y, rot, scale, order)
        
        DrawElementUtil.SetAlpha(nodeId, math.random() * 0.4 + 0.2)
        table.insert(nodeIds, nodeId)
    end
    
    scale_speed = scale_speed or 0.05
    local scale_min = 0.8
    local scale_max = 1.2
    
    local function scale_nodes()
        for i = 1, #nodeIds do
            local cur_scale = DrawElementUtil.GetScale(nodeIds[i])
            if (cur_scale >= scale_max and scale_speed > 0) or
               (cur_scale <= scale_min and scale_speed < 0) then
                scale_speed = -scale_speed
            end
            
            local scale_delta = scale_speed * GameScript.GetFrameTime()
            DrawElementUtil.SetScale(nodeIds[i], scale_delta + cur_scale)
        end
    end
    
    rotate_speed = rotate_speed or 1
    
    local function rotate_nodes()
        for i = 1, #nodeIds do
            local cur_rotate = DrawElementUtil.GetRotation(nodeIds[i])
            
            local rotate_delta = rotate_speed * GameScript.GetFrameTime()
            DrawElementUtil.SetRotation(nodeIds[i], rotate_delta + cur_rotate)
        end
    end
    
    Timer.CreateOnce(2,
                     function() Timer.CreateInterval(0, scale_nodes) end)
    Timer.CreateOnce(2,
                     function() Timer.CreateInterval(0, rotate_nodes) end)
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

function OnInit()
    GameScript.SetWaveCenter(0, 0)
    GameScript.SetWave(0.005, 2)
    -- TODO improve this interface
    GameScript.SetPond("FishIndex:-1;SetDestRand:160,293,10,0;SetSpeed:70")
    
    Timer.CreateInterval(2, create_ripple)
    
    create_stones(4, 0, 0)
end

function OnRelease()
end