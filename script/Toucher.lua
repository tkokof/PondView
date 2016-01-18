-- simple touch handler
-- maintainer hugoyu

local function add_touch_ripple(x, y, min, max)
    min, max = min or 0.5, max or 1.2
    
    local rand = min + math.random() * (max - min)
    
    GameScript.AddRipple(x, y, rand)
end

function OnTouchBegan(x, y)
    add_touch_ripple(x, y)
end

function OnTouchMoved(x, y)
    add_touch_ripple(x, y, 0.25, 0.5)
end

function OnTouchEnded(x, y)
    --add_touch_ripple(x, y)
end