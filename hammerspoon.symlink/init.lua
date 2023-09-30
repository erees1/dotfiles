hs.window.animationDuration = 0;
local modifiers = { "ctrl", "cmd" } -- all shortcuts use this
local window_margin = 5             -- border to have around windows, set to 0 if you don't want any

local function launchApp(App)
    return function()
        hs.application.launchOrFocus(App)
    end
end


local function baseMove(x, y, w, h)
    return function()
        local win = hs.window.focusedWindow()
        local f = win:frame()
        local screen = win:screen()
        local max = screen:frame()

        -- add max.x so it stays on the same screen, works with my second screen
        f.x = max.w * x + max.x + window_margin
        f.y = max.h * y + window_margin + max.y
        f.w = max.w * w - window_margin / 2
        f.h = max.h * h - window_margin
        print('setting frame', f.x, f.y, f.w, f.h)
        win:setFrame(f, 0)
    end
end

local snapLeft = baseMove(0, 0, 0.5, 1)
local snapRight = baseMove(0.5, 0, 0.5, 1)
local snapTop = baseMove(0, 0, 1, 0.5)
local snapBottom = baseMove(0, 0.5, 1, 0.5)
local snapMax = baseMove(0, 0, 1, 1)

local stashed_windows = {}


local function moveWindow(direction)
    return function()
        local win = hs.window.focusedWindow()
        local screen = win:screen()
        local max = screen:frame()


        -- work out if we are already on the left or right by moving it and
        -- checking if the x position or width has changed
        local curFrame = win:frame()
        if (direction == "left") then
            snapLeft()
        else
            snapRight()
        end
        local didNotMove = (curFrame.x == win:frame().x and curFrame.w == win:frame().w and curFrame.y == win:frame().y and curFrame.h == win:frame().h)

        if not didNotMove then
            -- if we did move then we are done so return
            return
        end

        -- if we didn't move then we are already on the left or right so need to move to the next screen
        local win = hs.window.focusedWindow()
        if (direction == "right") then
            local nextScreen = win:screen():next()
            win:moveToScreen(nextScreen)
            snapLeft()
        else
            local nextScreen = win:screen():previous()
            win:moveToScreen(nextScreen)
            snapRight()
        end
    end
end


local function maximizeWindow()
    -- maximize window and remember original size
    -- if already maximized, restore to original size
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()

    -- if stashed window and currently maximized, restore
    local curFrame = win:frame()
    print("calling maximize")
    snapMax()
    local didNotMove = (curFrame.x == win:frame().x and curFrame.w == win:frame().w and curFrame.y == win:frame().y and curFrame.h == win:frame().h)
    if didNotMove then
        -- then restore
        frame = stashed_windows[win:id()]
        if frame then
            f.x = frame.x
            f.y = frame.y
            f.w = frame.w
            f.h = frame.h
            stashed_windows[win:id()] = nil
            win:setFrame(f, 0)
        end
    else
        -- then stash
        stashed_windows[win:id()] = curFrame
    end
end

-- Layouts
local windowLayout = {
    { "Visual Studio Code", nil, laptopScreen, hs.layout.left50,  nil, nil },
    { "iTerm",              nil, laptopScreen, hs.layout.right50, nil, nil },
    { "Google Chrome",      nil, laptopScreen, hs.layout.right50, nil, nil },
    { "Code",               nil, laptopScreen, hs.layout.left50,  nil, nil },
    { "Obsidian",           nil, laptopScreen, hs.layout.left50,  nil, nil },
}

function applyLayout(layout)
    return function()
        hs.layout.apply(layout)
    end
end

-- Execute last  command in iterm
local function executeLastCommand()
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
end


local function reloadConfig()
    hs.reload()
end

-- Keybindings
local keybindings = {
    -- Apps
    { key = 'i',      fn = launchApp("iTerm") },
    { key = 'e',      fn = launchApp("Google Chrome") },
    { key = 'a',      fn = launchApp("Visual Studio Code") },
    { key = 'm',      fn = launchApp("Spark Desktop") },
    { key = 's',      fn = launchApp("Slack") },
    { key = 'o',      fn = launchApp("Obsidian") },

    -- Windows
    { key = 'h',      fn = moveWindow("left") },
    { key = 'l',      fn = moveWindow("right") },
    { key = 'j',      fn = snapBottom },
    { key = 'k',      fn = snapTop },
    { key = "1",      fn = baseMove(0, 0, 0.5, 0.5) },
    { key = "2",      fn = baseMove(0.5, 0, 0.5, 0.5) },
    { key = "3",      fn = baseMove(0, 0.5, 0.5, 0.5) },
    { key = "4",      fn = baseMove(0.5, 0.5, 0.5, 0.5) },
    { key = 'return', fn = maximizeWindow },
    { key = 'r',      fn = applyLayout },

    -- misc
    { key = 'p',  fn = executeLastCommand },
    { key = '0', fn = reloadConfig}
}

-- Bind the hotkeys
for _, binding in pairs(keybindings) do
    hs.hotkey.bind(modifiers, binding.key, binding.fn)
end

hs.alert.show("Config loaded")