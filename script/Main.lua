-- simple lua test
require "script/Updater"
require "script/Timer"

local function test_1()
    Timer.CreateInterval(2, SwitchBG)
end

local function main()
    test_1()
end

Print(tostring(Updater))
Print(tostring(Timer))

main()