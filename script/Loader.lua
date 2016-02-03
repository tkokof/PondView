-- desc simple game path loader
-- maintainer hugoyu

Loader = {}
setmetatable(Loader, { __index = _G })
local _ENV = Loader

function LoadFile(path)
    package.loaded[path] = nil
    local status, error = pcall(require, path)
    if not status then
        Print("[Loader]Error to load file : " .. tostring(path))
    end
end

local function load_files_recur(pre_path_str, path)
    local pre_path = pre_path_str
    if path.name then
        pre_path = pre_path .. "." .. path.name
    end
    
    for index, element in ipairs(path) do
        if type(element) == "string" then
            LoadFile(pre_path .. "." .. element)
        elseif type(element) == "table" then
            load_files_recur(pre_path, element)
        else
            Print("[Loader]Error to load file : " .. pre_path .. "." .. tostring(element))
        end
    end
end

function LoadFiles(pre_path, paths)
    load_files_recur(pre_path, paths)
end

function LoadGameFiles()
    local pre_path = "script"
    local paths = GamePath
    LoadFiles(pre_path, paths)
end

