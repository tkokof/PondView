-- desc draw element util
-- maintainer hugoyu

DrawElementUtil = {}

function DrawElementUtil.GetAlpha(node_id)
    return GameScript.GetDrawElementProperty(node_id, "Alpha")
end

function DrawElementUtil.SetAlpha(node_id, alpha)
    GameScript.SetDrawElementProperty(node_id, "Alpha", alpha)
end

function DrawElementUtil.GetScale(node_id)
    return GameScript.GetDrawElementProperty(node_id, "Scale")
end

function DrawElementUtil.SetScale(node_id, scale)
    GameScript.SetDrawElementProperty(node_id, "Scale", scale)
end

function DrawElementUtil.GetRotation(node_id)
    return GameScript.GetDrawElementProperty(node_id, "Rotation")
end

function DrawElementUtil.SetRotation(node_id, rotation)
    GameScript.SetDrawElementProperty(node_id, "Rotation", rotation)
end

function DrawElementUtil.GetPosition(node_id)
    return GameScript.GetDrawElementProperty(node_id, "Position")
end

function DrawElementUtil.SetPosition(node_id, x, y)
    GameScript.SetDrawElementProperty(node_id, "Position", x, y)
end

function DrawElementUtil.GetSize(node_id)
    return GameScript.GetDrawElementProperty(node_id, "Size")
end

function DrawElementUtil.SetSize(node_id, size)
    -- TODO implement
end

function DrawElementUtil.GetNodeCount(node_id)
    return GameScript.GetDrawElementProperty(node_id, "NodeCount")
end

function DrawElementUtil.SetNodeCount(node_id, node_count)
    GameScript.SetDrawElementProperty(node_id, "NodeCount", node_count)
end

local node_id_to_swing_info = {}

function DrawElementUtil.GetSwing(node_id)
    -- TODO since C++ do not implement this, we just do lua-side implement
    if node_id_to_swing_info[node_id] then
        return node_id_to_swing_info[node_id].factor, node_id_to_swing_info[node_id].duration
    end
end

function DrawElementUtil.SetSwing(node_id, swing_factor, swing_duration)
    GameScript.SetDrawElementProperty(node_id, "Swing", swing_factor, swing_duration)
    -- buffer swing data
    node_id_to_swing_info[node_id] = { factor = swing_factor, duration = swing_duration }
end