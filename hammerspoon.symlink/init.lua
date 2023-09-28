
hs.window.animationDuration = 0;
modifiers = {"ctrl", "cmd"}

function bindHotkeys(mapping)
  for key, app in pairs(mapping) do
    hs.hotkey.bind(modifiers, key, function()
      hs.application.launchOrFocus(app)
    end)
  end
end

mapping = {
  i = "iTerm",
  e = "Google Chrome",
  m = "Spark Desktop",
  a = "Sublime Text",
  s = "Slack",
}

bindHotkeys(mapping)

-- Snap window to the left half of the screen
hs.hotkey.bind(modifiers, "h", function()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()

    f.x = max.x
    f.y = max.y
    f.w = max.w / 2
    f.h = max.h
    win:setFrame(f)
end)

-- Snap window to the right half of the screen
hs.hotkey.bind(modifiers, "l", function()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()

    f.x = max.x + (max.w / 2)
    f.y = max.y
    f.w = max.w / 2
    f.h = max.h
    win:setFrame(f)
end)

-- Make window full screen
hs.hotkey.bind(modifiers, "return", function()
    local win = hs.window.focusedWindow()
    local screen = win:screen()
    local max = screen:frame()

    win:setFrame(max)
end)

-- Layouts
local windowLayout = {
    {"Sublime Text",  nil,          laptopScreen, hs.layout.left50,    nil, nil},
    {"iTerm",    nil,          laptopScreen, hs.layout.right50,   nil, nil},
    {"Google Chrome",    nil,          laptopScreen, hs.layout.right50,   nil, nil},
    {"Code",  nil,     laptopScreen, hs.layout.left50, nil, nil},
}
hs.hotkey.bind(modifiers, "r", function()
    hs.layout.apply(windowLayout)
end)

-- Automatically reload config
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
hs.alert.show("Config loaded")
