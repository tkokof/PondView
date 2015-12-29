-- desc simple timer implementation
-- maintainer hugoyu

-- timer interval

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
  	
  	return false
end

-- timer once

local timer_once = {}

function timer_once.create(delay, func)
    local timer = { elapsed = 0, delay = delay, func = func }
    setmetatable(timer, { __index = timer_once })
    return timer
end

function timer_once:update()
    self.elapsed = self.elapsed or 0
    self.delay = self.delay or 0
    
    if self.elapsed >= self.delay then
        if self.func then
            self.func()
        end
        
        return true
    else
        self.elapsed = self.elapsed + GetFrameTime()
    end
    
    return false
end

-- timer factory

Timer = {}

function Timer.CreateInterval(interval, func)
    local timer = timer_interval.create(interval, func)
	  return Updater.AddUpdater(timer.update, timer)
end

function Timer.CreateOnce(delay, func)
    local timer = timer_once.create(delay, func)
    return Updater.AddUpdater(timer.update, timer)
end

function Timer.KillTimer(timer)
    Updater.RemoveUpdater(timer)
end