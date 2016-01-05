-- simple touch handler
-- maintainer hugoyu

function OnTouch(x, y)
    --Print("Touched : " .. x .. " " .. y)
    local min, max = 0.5, 1.2
    local rand = min + math.random() * (max - min)
    
    GameScript.AddRipple(x, y, rand)
end