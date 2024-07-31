-- add slight gap to the left and right
hs.window.animationDuration = 0
local modifiers = { "ctrl", "cmd" } -- most shortcuts use this
local modifier2 = { "ctrl", "cmd", "shift" } -- for some extra window movement
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
local layoutMid = makeLayout(0.16, 0.1, 0.68, 0.8)
local layoutPlus = makeLayout(0.05, 0.025, 0.90, 0.95)
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
    local newFrame = win:frame()
    local didNotMove = (curFrame == newFrame)
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
    local curFrame = win:frame()
    win:move(layoutMax)
    -- if stashed window and currently maximized, restore
    local newFrame = win:frame()
    local didNotMove = (curFrame == newFrame)
    if didNotMove then
        -- then restore
        local frame = stashed_windows[win:id()]
        if frame then
            stashed_windows[win:id()] = nil
            win:setFrame(frame, 0)
        end
    else
        -- then stash
        stashed_windows[win:id()] = curFrame
    end
end

local function midCurWindow()
    local win = hs.window.focusedWindow()
    win:move(layoutMid)
end
local function plusCurWindow()
    local win = hs.window.focusedWindow()
    win:move(layoutPlus)
end


-- Layouts
local defaultLayout = {
    { "Google Chrome", nil, nil, layoutLeft65 },
    { "Code", nil, nil, layoutLeft65 },
    { "kitty", nil, nil, layoutRight35 },
    { "Spark Desktop", nil, hs.screen:primaryScreen():next(), layoutMax },
    { "Spotify", nil, hs.screen:primaryScreen():next(), layoutMax },
    { "Slack", nil, hs.screen:primaryScreen():next(), layoutMax },
    { "Dash", nil, hs.screen:primaryScreen():next(), layoutMax },
    { "Timing", nil, hs.screen:primaryScreen():next(), layoutMax },
    { "Obsidian", nil, hs.screen:primaryScreen():next(), layoutMax },
    { "Anki", nil, hs.screen:primaryScreen():next(), layoutMax },
    { "Zotero", nil, hs.screen:primaryScreen():next(), layoutMax },
}

-- Same as defaultLayout but with bigger terminal with nothing behind it
local bigTermOverrides = {
    { "Google Chrome", nil, hs.screen:primaryScreen():next(), layoutMax },
    { "Code", nil, hs.screen:primaryScreen():next(), layoutMax },
    { "kitty", nil, nil, layoutMax },
}
local bigTerm = hs.fnutils.concat(hs.fnutils.copy(defaultLayout), bigTermOverrides)

local readingOverrides = {
    { "Zotero", nil, nil, layoutLeft65 },
    { "Obsidian", nil, nil, layoutRight35 },
}
local reading = hs.fnutils.concat(hs.fnutils.copy(defaultLayout), readingOverrides)

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
    { mod = modifiers, key = "i", fn = function() launchOrFocus("kitty") end },
    { mod = modifiers, key = "e", fn = function() launchOrFocus("Google Chrome") end },
    { mod = modifiers, key = "a", fn = function() launchOrFocus("Visual Studio Code") end },
    { mod = modifiers, key = "m", fn = function() launchOrFocus("Spark Desktop") end },
    { mod = modifiers, key = "s", fn = function() launchOrFocus("Slack") end },
    { mod = modifiers, key = "z", fn = function() launchOrFocus("Zotero") end },
    { mod = modifiers, key = "o", fn = function() launchOrFocus("Obsidian") end },
    { mod = modifiers, key = "t", fn = function() launchOrFocus("Timing") end },
    { mod = modifiers, key = "b", fn = function() launchOrFocus("Finder") end },
    {
        mod = modifiers,
        key = "n",
        fn = function()
            launchOrFocus("Obsidian")
            keyStroke({ "cmd" }, "Y")
        end,
    },
    {
        mod = modifiers,
        key = "d",
        fn = function()
            launchOrFocus("Dash")
            keyStroke({ "cmd" }, "L")
        end,
    },
    { mod = modifiers, key = "x", fn = function() launchOrFocus("Anki") end },
    -- Windows
    { mod = modifiers, key = "h", fn = function() moveCurWindow(layoutLeft) end },
    { mod = modifier2, key = "h", fn = function() moveCurWindow(layoutLeft65) end },
    { mod = modifiers, key = "l", fn = function() moveCurWindow(layoutRight) end },
    { mod = modifier2, key = "l", fn = function() moveCurWindow(layoutRight35) end },
    { mod = modifiers, key = "j", fn = function() moveCurWindow(layoutTop) end },
    { mod = modifiers, key = "k", fn = function() moveCurWindow(layoutBottom) end },
    { mod = modifiers, key = "1", fn = function() moveCurWindow(layoutTopLeft) end },
    { mod = modifiers, key = "2", fn = function() moveCurWindow(layoutTopRight) end },
    { mod = modifiers, key = "3", fn = function() moveCurWindow(layoutBottomLeft) end },
    { mod = modifiers, key = "4", fn = function() moveCurWindow(layoutBottomRight) end },
    { mod = modifiers, key = "return", fn = maxCurWindow },
    { mod = modifiers, key = "-", fn = midCurWindow },
    { mod = modifiers, key = "=", fn = plusCurWindow },
    { mod = modifiers, key = "r", fn = function() hs.layout.apply(defaultLayout) end },
    { mod = modifiers, key = "6", fn = function() hs.layout.apply(bigTerm) end },
    { mod = modifiers, key = "7", fn = function() hs.layout.apply(reading) end },
    -- terminal
    -- misc
    { mod = modifiers, key = "0", fn = reloadConfig },
}

-- Bind the hotkeys
for _, binding in pairs(keybindings) do
    -- Bind on key release to avoid issues with sending keys whilst modifier is held down
    hs.hotkey.bind(binding.mod, binding.key, nil, binding.fn)
end

hs.alert.show("Config loaded")
