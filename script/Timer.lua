-- desc simple timer implementation
-- maintainer hugoyu

local timer_interval = {}

function timer_interval.create(interval, func)
    local timer = { elapsed = 0, interval = interval, func = func }
	  setmetatable(timer, { __index = timer_interval })
	  return timer
end

function timer_interval:update()
    self.elapsed = self.elapsed or 0
  	self.interval = self.interval or 0
  	if self.elapsed >= self.interval then
  	    if self.func then
  		    self.func()
  		end
  		self.elapsed = 0
      else
  	    self.elapsed = self.elapsed + GetFrameTime()
  	end
end

-- TODO implement
--[[
local timer_once = {}

local function timer_once:update()
end
--]]

Timer = {}

function Timer.CreateInterval(interval, func)
    local timer = timer_interval.create(interval, func)
	  Updater.AddUpdater(function() timer:update() end)
end

function Timer.CreateOnce(delay, func)
    -- TODO implement
end