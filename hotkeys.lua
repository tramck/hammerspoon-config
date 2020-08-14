local c = require("config")
local o = require("open")


hs.hotkey.bind({"cmd", "ctrl", "alt"}, "W", function()
    -- get to work function
    o.openAndMove("Slack", "LEFT", 0, 0, 2/3, 1)
    o.openAndMove("Spotify", "LEFT", 2/3, 0, 1/3, 1)
    o.openFullscreen("Typora", "LAPTOP")
    o.openFullscreen("Code", "CENTER")
    -- open vm in code
    local code = hs.appfinder.appFromName("Code")
    code:selectMenuItem({"File", "Open Recent", "/home/vagrant/beeswaxio [SSH: beeswax-vm]"})
    -- ensure vm is running
    hs.execute("cd /Users/travis/beeswax/vms/beeswax-vm; vagrant up;", true)
end)


-- open config in vscode right control and h are pressed
hs.hotkey.bind({"rightctrl"}, "H", function()
    hs.execute("code " .. c.HAMMERSPOON_CONFIG, true)
end)
