-- desc simple Updater implementation
-- maintainer hugoyu

Updater = {}

function Updater.AddUpdater(updater)
    Updater.updaters = Updater.updaters or {}
	  assert(type(updater) == "function")
	  table.insert(Updater.updaters, updater)
end

function Updater.RemoveUpdater(updater)
    Updater.updaters = Updater.updaters or {}
    table.remove(Updater.updaters, updater)
end

function Updater.ClearUpdaters()
    Updater.updaters = {}
end

-- global function

function OnUpdate()
    Updater.updaters = Updater.updaters or {}
    for i = 1, #(Updater.updaters) do
        --Print(type((Updater.updaters[i])))
	      Updater.updaters[i]()
	  end
end