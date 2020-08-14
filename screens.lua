

ALL_SCREENS = hs.screen.allScreens()

SCREENS = {
    LAPTOP = ALL_SCREENS[1],
    CENTER = ALL_SCREENS[2],
    LEFT = ALL_SCREENS[3],
}

local screens = {}
screens.ALL_SCREENS = ALL_SCREENS
screens.SCREENS = SCREENS

function screens.placeWindow(window, screen, t_ratio, l_ratio, h_ratio, w_ratio)
    screen = screens.SCREENS[screen]
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

return screens
