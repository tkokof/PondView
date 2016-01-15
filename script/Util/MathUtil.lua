-- desc simple math util
-- maintainer hugoyu

MathUtil = {}

function MathUtil.RotateVector(v, a)
    return { 
               x = v.x * math.cos(math.rad(a)) + v.y * math.sin(math.rad(a)),
               y = v.x * math.sin(math.rad(a)) - v.y * math.cos(math.rad(a)) 
           }
end

function MathUtil.NormalizeVector(v)
    local length = MathUtil.Length(v)
    return { x = v.x / length, y = v.y / length }
end

function MathUtil.MultiplyVector(v, f)
    return { x = v.x * f, y = v.y * f }
end

function MathUtil.DotVector(v1, v2)
    return v1.x * v2.x + v1.y * v2.y
end

function MathUtil.Length(v)
    return math.sqrt(v.x * v.x, v.y * v.y)
end

function MathUtil.LengthSq(v)
    return v.x * v.x, v.y * v.y
end