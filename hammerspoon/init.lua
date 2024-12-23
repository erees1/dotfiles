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
local layoutBottom75 = makeLayout(0, 0.25, 1, 0.75)
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

-- local function applyLayoutSafely(layout)
--     -- Launch all apps first
--     for _, entry in ipairs(layout) do
--         local appName = entry[1]
--         launchOrFocus(appName)
--     end

--     -- Wait briefly for apps to launch
--     hs.timer.doAfter(0.5, function()
--         hs.layout.apply(layout)
--     end)
-- end

local defaultLayout = {
    { "Code", nil, nil, layoutLeft65 },
    { "Zed Nightly", nil, nil, layoutLeft65 },
    { "kitty", nil, nil, layoutRight35 },
    { "Sublime Merge", nil, nil, layoutPlus },
    { "Google Chrome", nil, hs.screen:primaryScreen():next(), layoutMax },
    { "Spark Desktop", nil, hs.screen:primaryScreen():next(), layoutMax },
    { "Spotify", nil, hs.screen:primaryScreen():next(), layoutMax },
    { "Slack", nil, hs.screen:primaryScreen():next(), layoutMax },
    { "Dash", nil, hs.screen:primaryScreen():next(), layoutMax },
    { "Timing", nil, hs.screen:primaryScreen():next(), layoutMax },
    { "Obsidian", nil, hs.screen:primaryScreen():next(), layoutMax },
    { "Anki", nil, hs.screen:primaryScreen():next(), layoutMax },
    { "Zotero", nil, hs.screen:primaryScreen():next(), layoutMax },
}


local splitWork = {
    { "Zed Nightly", nil, nil, makeLayout(0, 0, 0.60, 1) },
    { "kitty", nil, nil, makeLayout(0.60, 0, 0.40, 1) },
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

-- Keybindings
local keybindings = {
    -- Apps
    { mod = modifiers, key = "i", fn = function() launchOrFocus("kitty") end },
    { mod = modifiers, key = "a", fn = function() launchOrFocus("Zed Nightly") end },
    { mod = modifiers, key = "v", fn = function() launchOrFocus("Visual Studio Code") end },
    { mod = modifiers, key = "m", fn = function() launchOrFocus("Spark Desktop") end },
    { mod = modifiers, key = "s", fn = function() launchOrFocus("Slack") end },
    { mod = modifiers, key = "z", fn = function() launchOrFocus("Zotero") end },
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
    { mod = modifiers, key = "k", fn = function() moveCurWindow(layoutTop) end },
    { mod = modifiers, key = "j", fn = function() moveCurWindow(layoutBottom) end },
    { mod = modifier2, key = "j", fn = function() moveCurWindow(layoutBottom75) end },
    { mod = modifiers, key = "1", fn = function() moveCurWindow(layoutTopLeft) end },
    { mod = modifiers, key = "2", fn = function() moveCurWindow(layoutTopRight) end },
    { mod = modifiers, key = "3", fn = function() moveCurWindow(layoutBottomLeft) end },
    { mod = modifiers, key = "4", fn = function() moveCurWindow(layoutBottomRight) end },
    { mod = modifiers, key = "return", fn = maxCurWindow },
    { mod = modifiers, key = "-", fn = midCurWindow },
    { mod = modifiers, key = "=", fn = plusCurWindow },
    { mod = modifiers, key = "r", fn = function() launchOrFocus("Zed Nightly") launchOrFocus("kitty") hs.layout.apply(splitWork) end },
    { mod = modifiers, key = "6", fn = function() hs.layout.apply(bigTerm) end },
    { mod = modifiers, key = "7", fn = function() hs.layout.apply(reading) end },
    -- terminal
    -- misc
    { mod = modifiers, key = "0", fn = hs.reload } ,
}

-- Bind the hotkeys
for _, binding in pairs(keybindings) do
    -- Bind on key release to avoid issues with sending keys whilst modifier is held down
    hs.hotkey.bind(binding.mod, binding.key, nil, binding.fn)
end

hs.alert.show("Config loaded")
