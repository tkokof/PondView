-- simple touch handler
-- maintainer hugoyu

local function add_touch_ripple(x, y, min, max)
    min, max = min or 0.5, max or 1.2
    
    -- NOTE below codes will cause a error
    -- TODO figure it out ...
    --min, max = min or 0.25, max or 0.5
    
    local rand = min + math.random() * (max - min)
    
    GameScript.AddRipple(x, y, rand)
end

function OnTouchBegan(x, y)
    add_touch_ripple(x, y)
end

function OnTouchMoved(x, y)
    -- TODO figure this out
    --add_touch_ripple(x, y)
end

function OnTouchEnded(x, y)
    --add_touch_ripple(x, y)
end