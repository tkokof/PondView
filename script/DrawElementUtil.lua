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