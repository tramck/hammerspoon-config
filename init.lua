function reloadConfig(files)
    doReload = false
    for _,file in pairs(files) do
        if file:sub(-4) == ".lua" then
            doReload = true
        end
    end
    if doReload then
        hs.reload()
    end
end
myWatcher = hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()
hs.notify.new({title="Hammerspoon", informativeText="Config loaded"}):send()

ALL_SCREENS = hs.screen.allScreens()

SCREENS = {
    LAPTOP = ALL_SCREENS[1],
    CENTER = ALL_SCREENS[2],
    LEFT = ALL_SCREENS[3],
}

function open(app)
    focused = hs.application.launchOrFocus(app)
    if app == "Code" and not focused then
        -- special logic for code
        -- https://github.com/Hammerspoon/hammerspoon/issues/2075
        focused = hs.application.launchOrFocus("Visual Studio Code")
    end
    return focused
end

function placeWindow(window, screen, t_ratio, l_ratio, h_ratio, w_ratio)
    screen = SCREENS[screen]
    screen_height = screen:frame().h
    screen_width = screen:frame().w

    top = screen_height * t_ratio
    left = screen_width * l_ratio
    height = screen_height * h_ratio
    width = screen_width * w_ratio

    window:setFullScreen(false)
    window:moveToScreen(SCREENS[screen])
    window:setTopLeft(screen:localToAbsolute(hs.geometry.point(left, top)))
    window:setSize(hs.geometry.size(width, height))
end

function openAndMove(app, screen, t_ratio, l_ratio, h_ratio, w_ratio)
    focused = open(app)
    if not focused then return false end
    window = hs.window.focusedWindow()
    placeWindow(window, screen, t_ratio, l_ratio, h_ratio, w_ratio)
    return true
end

function openFullscreen(app, screen)
    focused = open(app)
    if not focused then return false end
    window = hs.window.focusedWindow()
    -- window:setFullScreen(false)
    window:moveToScreen(SCREENS[screen])
    window:setFullScreen(true)
    return true
end

hs.hotkey.bind({"cmd", "ctrl", "alt"}, "W", function()
    -- get to work function
    openAndMove("Slack", "LEFT", 0, 0, 2/3, 1)
    openAndMove("Spotify", "LEFT", 2/3, 0, 1/3, 1)
    openFullscreen("Typora", "LAPTOP")
    openFullscreen("Code", "CENTER")
    -- open vm in code
    local code = hs.appfinder.appFromName("Code")
    code:selectMenuItem({"File", "Open Recent", "/home/vagrant/beeswaxio [SSH: beeswax-vm]"})
    -- ensure vm is running
    hs.execute("cd /Users/travis/beeswax/vms/beeswax-vm; vagrant up;", true)
end)