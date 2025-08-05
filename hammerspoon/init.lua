-- add slight gap to the left and right
hs.window.animationDuration = 0
local modifiers = { "ctrl", "cmd" } -- most shortcuts use this
local modifier2 = { "ctrl", "cmd", "shift" } -- for some extra window movement
local launchOrFocus = hs.application.launchOrFocus
local keyStroke = hs.eventtap.keyStroke
local is_65_35_split = true
local add_gap_between_windows = true

local function makeLayout(x, y, w, h)
    if add_gap_between_windows then
        -- add slight gap in between windows
        w = w - 0.001
        if x ~= 0 then
            x = x + 0.001
        end
    end
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
    if direction == layoutRight or direction == layoutRight35 then
        local nextScreen = win:screen():next()
        win:moveToScreen(nextScreen)
        win:move(is_65_35_split and layoutLeft65 or layoutLeft)
    elseif direction == layoutLeft or direction == layoutLeft65 then
        local nextScreen = win:screen():previous()
        win:moveToScreen(nextScreen)
        win:move(is_65_35_split and layoutRight35 or layoutRight)
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

local function isWindowLeftOfMidpoint(win, screen)
    local frame = win:frame()
    local screenFrame = screen:frame()
    local midPoint = screenFrame.x + (screenFrame.w / 2)
    local windowMidPoint = frame.x + (frame.w / 2)
    return windowMidPoint < midPoint
end

local function tileWindows6535()
    local curScreen = hs.window.focusedWindow():screen()
    local allWindows = hs.window.visibleWindows()

    for _, win in ipairs(allWindows) do
        if win:screen() == curScreen then
            if isWindowLeftOfMidpoint(win, curScreen) then
                win:move(layoutLeft65)
            else
                win:move(layoutRight35)
            end
        end
    end
end

local function tileWindows5050()
    local curScreen = hs.window.focusedWindow():screen()
    local allWindows = hs.window.visibleWindows()

    for _, win in ipairs(allWindows) do
        if win:screen() == curScreen then
            if isWindowLeftOfMidpoint(win, curScreen) then
                win:move(layoutLeft)
            else
                win:move(layoutRight)
            end
        end
    end
end

local function toggleTileWindows()
    if is_65_35_split then
        tileWindows5050()
    else
        tileWindows6535()
    end
    is_65_35_split = not is_65_35_split
end

-- Keybindings
local keybindings = {
    -- Apps
    { mod = modifiers, key = "i", fn = function() launchOrFocus("kitty") end },
    { mod = modifiers, key = "a", fn = function() launchOrFocus("Zed Preview") end },
    { mod = modifiers, key = "v", fn = function() launchOrFocus("Visual Studio Code") end },
    { mod = modifiers, key = "s", fn = function() launchOrFocus("Slack") end },
    { mod = modifiers, key = "b", fn = function() launchOrFocus("Finder") end },
    { mod = modifiers, key = "x", fn = function() launchOrFocus("Anki") end },
    -- Windows
    { mod = modifiers, key = "h", fn = function() moveCurWindow(is_65_35_split and layoutLeft65 or layoutLeft) end },
    { mod = modifiers, key = "l", fn = function() moveCurWindow(is_65_35_split and layoutRight35 or layoutRight) end },
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
    { mod = modifiers, key = "r", fn = toggleTileWindows },
    -- misc
    { mod = modifiers, key = "0", fn = hs.reload },
}

-- Bind the hotkeys
for _, binding in pairs(keybindings) do
    -- Bind on key release to avoid issues with sending keys whilst modifier is held down
    hs.hotkey.bind(binding.mod, binding.key, nil, binding.fn)
end

hs.alert.show("Config loaded")
