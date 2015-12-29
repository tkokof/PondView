-- desc simple Updater implementation
-- maintainer hugoyu

Updater = {}

function Updater.AddUpdater(updater, ...)
    local updateData = { func = updater, params = { ... } }
    
    if Updater.isUpdating then
        local toAdd = Updater.toAdd or {}
        assert(type(updater) == "function")
        table.insert(toAdd, updateData)
    else
        -- do normal insert
        Updater.updaters = Updater.updaters or {}
	      assert(type(updater) == "function")
	      table.insert(Updater.updaters, updateData)
	  end
	  
	  return updateData
end

function Updater.RemoveUpdater(updateData)
    if Updater.isUpdating then
        local toRemove = Updater.toRemove or {}
        table.insert(toRemove, updateData)
    else
        -- do normal remove
        Updater.updaters = Updater.updaters or {}
        for i = 1, #Updater.updaters do
            if Updater.updaters[i] == updateData then
                table.remove(Updater.updaters, i)
                break
            end
        end
    end
end

function Updater.ClearUpdaters()
    if Updater.isUpdating then
        -- add all updaters to toRemove
        local toRemove = Updater.toRemove or {}
        for i = 1, #Updater.updaters do
            table.insert(toRemove, Updater.updaters[i])
        end
    else
        -- do normal clear
        Updater.updaters = {}
    end
end

-- global function

local debug_output = false

function OnUpdate()
    Updater.updaters = Updater.updaters or {}
    
    -- clear buffer first
    local toAdd = Updater.toAdd or {}
    for i = 1, #toAdd do
        table.insert(Updater.updaters, toAdd[i])
    end
    Updater.toAdd = {}
    
    local toRemove = Updater.toRemove or {}
    for i = 1, #toRemove do
        for j = 1, #Updater.updaters do
            if Updater.updaters[j] == toRemove[i] then
                table.remove(Updater.updaters, j)
                break
            end
        end
    end
    Updater.toRemove = {}
    
    -- then do update
    Updater.isUpdating = true
    for i = 1, #(Updater.updaters) do
	      local ret = Updater.updaters[i].func(table.unpack(Updater.updaters[i].params))
	      if ret then
	          -- clear update if return true
	          table.insert(Updater.toRemove, Updater.updaters[i])
	      end
	  end
	  Updater.isUpdating = false
end