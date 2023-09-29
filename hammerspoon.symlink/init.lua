hs.window.animationDuration = 0;
local modifiers = { "ctrl", "cmd" } -- all shortcuts use this

local function bindHotkeys(mapping)
    for key, app in pairs(mapping) do
        hs.hotkey.bind(modifiers, key, function()
            hs.application.launchOrFocus(app)
        end)
    end
end

local app_open_mapping = {
    i = "iTerm",
    e = "Google Chrome",
    m = "Spark Desktop",
    a = "Visual Studio Code",
    s = "Slack",
    o = "Obsidian",
    s = "Finder",
}

bindHotkeys(app_open_mapping)

local function baseMove(x, y, w, h)
    return function()
        local win = hs.window.focusedWindow()
        local f = win:frame()
        local screen = win:screen()
        local max = screen:frame()

        -- add max.x so it stays on the same screen, works with my second screen
        f.x = max.w * x + max.x
        f.y = max.h * y
        f.w = max.w * w
        f.h = max.h * h
        win:setFrame(f, 0)
    end
end

local stashed_windows = {}

local function maximizeWindow()
    -- maximize window and remember original size
    -- if already maximized, restore to original size
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()

    -- if stashed window and currently maximized, restore
    if stashed_windows[win:id()] and f.x == max.x and f.y == max.y and f.w == max.w and f.h == max.h then
        f.x = stashed_windows[win:id()].x
        f.y = stashed_windows[win:id()].y
        f.w = stashed_windows[win:id()].w
        f.h = stashed_windows[win:id()].h
        stashed_windows[win:id()] = nil
    else
        stashed_windows[win:id()] = {
            x = f.x,
            y = f.y,
            w = f.w,
            h = f.h,
        }
        f.x = max.x
        f.y = max.y
        f.w = max.w
        f.h = max.h
    end
    win:setFrame(f, 0)
end


-- feature spectacle/another window sizing apps
hs.hotkey.bind(modifiers, 'h', baseMove(0, 0, 0.5, 1))
hs.hotkey.bind(modifiers, 'l', baseMove(0.5, 0, 0.5, 1))
hs.hotkey.bind(modifiers, 'j', baseMove(0, 0.5, 1, 0.5))
hs.hotkey.bind(modifiers, 'k', baseMove(0, 0, 1, 0.5))
hs.hotkey.bind(modifiers, '1', baseMove(0, 0, 0.5, 0.5))
hs.hotkey.bind(modifiers, '2', baseMove(0.5, 0, 0.5, 0.5))
hs.hotkey.bind(modifiers, '3', baseMove(0, 0.5, 0.5, 0.5))
hs.hotkey.bind(modifiers, '4', baseMove(0.5, 0.5, 0.5, 0.5))
hs.hotkey.bind(modifiers, 'return', maximizeWindow)


-- Move window to next screen
hs.hotkey.bind(modifiers, ";", function()
    local win = hs.window.focusedWindow()
    win:moveToScreen(win:screen():next())
    -- set height to full (otherwise after moving it gets truncated vertically)
    -- may not want this if you are every splitting vertically (I don't atm)
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()
    f.h = max.h
    win:setFrame(f)
    -- clear stashed window when moving screen
    stashed_windows[win:id()] = nil
end)


-- Layouts
local windowLayout = {
    { "Visual Studio Code", nil, laptopScreen, hs.layout.left50,  nil, nil },
    { "iTerm",              nil, laptopScreen, hs.layout.right50, nil, nil },
    { "Google Chrome",      nil, laptopScreen, hs.layout.right50, nil, nil },
    { "Code",               nil, laptopScreen, hs.layout.left50,  nil, nil },
}
hs.hotkey.bind(modifiers, "r", function()
    hs.layout.apply(windowLayout)
end)


-- Execute last  command in iterm
hs.hotkey.bind(modifiers, "p", function()
    -- Save the current focused window
    local currentWindow = hs.window.focusedWindow()

    -- Focus iTerm
    hs.application.launchOrFocus("iTerm")
    
    -- Give iTerm some time to focus before sending the keys
    hs.timer.doAfter(0.01, function()
        -- Send up arrow to get the last command
        hs.eventtap.keyStroke({}, "up")
        
        -- Send return to run the last command
        hs.eventtap.keyStroke({}, "return")

        -- Give iTerm some time to execute the command before switching back
        hs.timer.doAfter(0.01, function()
            -- Focus back to the previous window
            if currentWindow then
                currentWindow:focus()
            end
        end)
    end)
end)




-- Automatically reload config
local function reloadConfig(files)
    doReload = false
    for _, file in pairs(files) do
        if file:sub(-4) == ".lua" then
            doReload = true
        end
    end
    if doReload then
        hs.reload()
    end
end

myWatcher = hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()
hs.alert.show("Config loaded")
