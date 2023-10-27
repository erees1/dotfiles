-- add slight gap to the left and right
hs.window.animationDuration = 0
local modifiers = { "ctrl", "cmd" } -- all shortcuts use this
local launchOrFocus = hs.application.launchOrFocus
local keyStroke = hs.eventtap.keyStroke

local function makeLayout(x, y, w, h)
    -- add slight gap to the left and right
    w = w - 0.002
    x = x + 0.001
    h = h - 0.002
    y = y + 0.001

    return hs.geometry.rect(x, y, w, h)
end

local layoutLeft = makeLayout(0, 0, 0.5, 1)
local layoutLeft65 = makeLayout(0, 0, 0.65, 1)
local layoutRight35 = makeLayout(0.65, 0, 0.35, 1)
local layoutRight = makeLayout(0.5, 0, 0.5, 1)
local layoutTop = makeLayout(0, 0, 1, 0.5)
local layoutBottom = makeLayout(0, 0.5, 1, 0.5)
local layoutMax = makeLayout(0, 0, 1, 1)
local layoutTopLeft = makeLayout(0, 0, 0.5, 0.5)
local layoutTopRight = makeLayout(0.5, 0, 0.5, 0.5)
local layoutBottomLeft = makeLayout(0, 0.5, 0.5, 0.5)
local layoutBottomRight = makeLayout(0.5, 0.5, 0.5, 0.5)

local stashed_windows = {}

local function moveWindow(direction, win)
    -- work out if we are already on the left or right by moving it and
    -- checking if the x position or width has changed
    local curFrame = win:frame()
    win:move(direction)
    local didNotMove = (
        curFrame.x == win:frame().x
        and curFrame.w == win:frame().w
        and curFrame.y == win:frame().y
        and curFrame.h == win:frame().h
    )

    if not didNotMove then
        -- if we did move then we are done so return
        return
    end

    -- if we didn't move then we are already on the left or right so need to move to the next screen
    if direction == layoutRight then
        local nextScreen = win:screen():next()
        win:moveToScreen(nextScreen)
        win:move(layoutLeft)
    elseif direction == layoutLeft then
        local nextScreen = win:screen():previous()
        win:moveToScreen(nextScreen)
        win:move(layoutRight)
    end
end

local function moveCurWindow(direction)
    local win = hs.window.focusedWindow()
    moveWindow(direction, win)
end

local function maxCurWindow()
    -- maximize window and remember original size
    -- if already maximized, restore to original size
    local win = hs.window.focusedWindow()
    local f = win:frame()

    -- if stashed window and currently maximized, restore
    local curFrame = win:frame()
    win:move(layoutMax)
    local didNotMove = (
        curFrame.x == win:frame().x
        and curFrame.w == win:frame().w
        and curFrame.y == win:frame().y
        and curFrame.h == win:frame().h
    )
    if didNotMove then
        -- then restore
        local frame = stashed_windows[win:id()]
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
local defaultLayout = {
    { "Google Chrome", nil, nil, layoutLeft65 },
    { "Code", nil, nil, layoutLeft65 },
    { "kitty", nil, nil, layoutRight35 },
    { "Visual Studio Code", nil, nil, layoutLeft },
    { "Spark Desktop", nil, hs.screen:primaryScreen():toWest(), layoutMax },
    { "Slack", nil, hs.screen:primaryScreen():toWest(), layoutMax },
    { "Dash", nil, hs.screen:primaryScreen():toWest(), layoutMax },
    { "Timing", nil, hs.screen:primaryScreen():toWest(), layoutMax },
    { "Obsidian", nil, hs.screen:primaryScreen():toWest(), layoutMax },
    { "Anki", nil, hs.screen:primaryScreen():toWest(), layoutMax },
    { "Zotero", nil, hs.screen:primaryScreen():toWest(), layoutMax },
}

-- Execute last  command in iterm
local function executeLastCommand()
    -- Save the current focused window
    local currentWindow = hs.window.focusedWindow()

    -- Focus iTerm
    hs.application.launchOrFocus("kitty")

    -- Give iTerm some time to focus before sending the keys
    hs.timer.doAfter(0.01, function()
        -- Send up arrow to get the last command
        hs.eventtap.keyStroke({}, "up")

        -- Send return to run the last command
        hs.eventtap.keyStroke({}, "return")

        -- Give iTerm some time to execute the command before switching back
        hs.timer.doAfter(0.01, function()
            -- Focus back to the previous window
            if currentWindow then currentWindow:focus() end
        end)
    end)
end

local function reloadConfig() hs.reload() end

-- Keybindings
local keybindings = {
    -- Apps
    { key = "i", fn = function() launchOrFocus("kitty") end },
    { key = "e", fn = function() launchOrFocus("Google Chrome") end },
    { key = "a", fn = function() launchOrFocus("Visual Studio Code") end },
    { key = "m", fn = function() launchOrFocus("Spark Desktop") end },
    { key = "s", fn = function() launchOrFocus("Slack") end },
    { key = "z", fn = function() launchOrFocus("Zotero") end },
    { key = "o", fn = function() launchOrFocus("Obsidian") end },
    { key = "t", fn = function() launchOrFocus("Timing") end },
    {
        key = "n",
        fn = function()
            launchOrFocus("Obsidian")
            keyStroke({ "cmd" }, "D")
        end,
    },
    {
        key = "d",
        fn = function()
            launchOrFocus("Dash")
            keyStroke({ "cmd" }, "L")
        end,
    },
    { key = "x", fn = function() launchOrFocus("Anki") end },
    -- Windows
    { key = "h", fn = function() moveCurWindow(layoutLeft) end },
    { key = "l", fn = function() moveCurWindow(layoutRight) end },
    { key = "j", fn = function() moveCurWindow(layoutTop) end },
    { key = "k", fn = function() moveCurWindow(layoutBottom) end },
    { key = "1", fn = function() moveCurWindow(layoutTopLeft) end },
    { key = "2", fn = function() moveCurWindow(layoutTopRight) end },
    { key = "3", fn = function() moveCurWindow(layoutBottomLeft) end },
    { key = "4", fn = function() moveCurWindow(layoutBottomRight) end },
    { key = "return", fn = maxCurWindow },
    { key = "r", fn = function() hs.layout.apply(defaultLayout) end },
    -- terminal
    { key = "p", fn = executeLastCommand },
    -- misc
    { key = "0", fn = reloadConfig },
}

-- Bind the hotkeys
for _, binding in pairs(keybindings) do
    hs.hotkey.bind(modifiers, binding.key, binding.fn)
end

hs.alert.show("Config loaded")
