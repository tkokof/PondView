-- desc lua main
-- maintainer hugoyu

local script_files_to_load = 
{
    "script/Updater",
    "script/Timer",
    "script/Toucher",
    "script/DrawElementUtil",
    "script/Util/MathUtil",
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

local function create_ripple()
    local width, height = GameScript.GetWinSize()
    local possible = 0.5
    
    if math.random() >= possible then
        local x, y = math.random(width), math.random(height)
        local strength = math.random() * 0.5 + 0.5
        GameScript.AddRipple(x, y, strength)
    end
end

local function get_dir_local(angle, width, height)
    local a = width / 2
    local b = height / 2
    local v = MathUtil.RotateVector({ x = 1, y = 0 }, angle)
    local t = 1 / ((v.x * v.x) / (a * a) + (v.y * v.y) / (b * b))
    t = math.sqrt(t)
    
    return MathUtil.MultiplyVector(v, t)
end

local function create_flower(node_id, flower_count)
    local sprite = "Sprite/PondView/Element/Flower/flower_1.png"
    local width, height = DrawElementUtil.GetSize(node_id)
    local x, y = DrawElementUtil.GetPosition(node_id)
    local rot = DrawElementUtil.GetRotation(node_id)
    local scale = DrawElementUtil.GetScale(node_id)
    
    local angle_delta = 30
    for i = 1, flower_count do
        local angle = math.random() * angle_delta
        local dir = get_dir_local(angle, width, height)
        Print(dir.x .. " " .. dir.y)
        local f_x, f_y = x + scale * dir.x, y + scale * dir.y
        local f_rot = angle
        local f_scale = math.random() * 0.2 + 0.2
        local order = -1
        
        local node_id = GameScript.AddDrawElement("f", sprite, f_x, f_y, f_rot, f_scale, order)
        
        DrawElementUtil.SetSwing(node_id, 3, 1.25)
    end
end

local function create_stones(stone_count, scale_speed, rotate_speed)
    local sprite = "Sprite/PondView/Element/Stone/stone_1.png"
    local width, height = GameScript.GetWinSize()
    
    local node_ids = {}
    
    stone_count = stone_count or 6
    for i = 1, stone_count do
        local x, y = get_random_pos(width, height)
        
        -- for debug
        --local rot = math.random(-10, 10)
        --local scale = math.random() * 0.4 + 0.8
        local rot = 0
        local scale = 1
        
        local order = -1
        
        local node_id = GameScript.AddDrawElement("s", sprite, x, y, rot, scale, order)
        
        DrawElementUtil.SetAlpha(node_id, math.random() * 0.4 + 0.2)
        table.insert(node_ids, node_id)
        
        -- create flower here
        local flower_count = 3
        create_flower(node_id, flower_count)
    end
    
    --[[
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
    --]]
end

function OnInit()
    math.randomseed(os.time())
    
    GameScript.SetWaveCenter(0, 0)
    GameScript.SetWave(0.005, 2)
    -- TODO improve this interface
    GameScript.SetPond("FishIndex:-1;SetDestRand:160,293,10,0;SetSpeed:70")
    
    Timer.CreateInterval(2, create_ripple)
    
    create_stones(4, 0, 0)
end

function OnRelease()
end