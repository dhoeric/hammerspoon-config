-- Disable animation
hs.window.animationDuration = 0


-- General key
local mash = {"alt", "ctrl"}
local super_mash = {"cmd", "alt", "ctrl"}


-- System events
hs.hotkey.bind(super_mash, "K", function()
  hs.caffeinate.shutdownSystem()
end)

hs.hotkey.bind(super_mash, "W", function()
  if hs.wifi.currentNetwork() == nil then
    os.execute("networksetup -setairportpower en0 on")
  else
    os.execute("networksetup -setairportpower en0 off")
  end
end)

hs.hotkey.bind(super_mash, "L", function()
  hs.caffeinate.lockScreen()
end)


-- Launching applications
hs.hotkey.bind(mash, "T", function()
  hs.application.launchOrFocus("iTerm")
end)

hs.hotkey.bind(mash, "G", function()
  hs.application.launchOrFocus("Google Chrome")
end)

hs.hotkey.bind(mash, "V", function()
  hs.application.launchOrFocus("MacVim")
end)

hs.hotkey.bind(mash, "S", function()
  hs.application.launchOrFocus("Slack")
end)

hs.hotkey.bind(mash, "K", function()
  hs.application.launchOrFocus("Keychain Access")
end)

hs.hotkey.bind(mash, "E", function()
  hs.application.launchOrFocus("Evernote")
end)

hs.hotkey.bind(mash, "P", function()
  hs.application.launchOrFocus("Spotify")
end)

hs.hotkey.bind(mash, "O", function()
  hs.application.launchOrFocus("Microsoft OneNote")
end)


-- Controlling spotify
hs.hotkey.bind(super_mash, "Space", function()
  hs.spotify.playpause()
end)

hs.hotkey.bind(super_mash, "Left", function()
  hs.spotify.previous()
end)

hs.hotkey.bind(super_mash, "Right", function()
  hs.spotify.next()
end)


-- Resizing windows
hs.hotkey.bind(mash, "Left", function()
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

hs.hotkey.bind(mash, "Right", function()
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

hs.hotkey.bind(mash, "Up", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y
  f.w = max.w
  f.h = max.h / 2
  win:setFrame(f)
end)

hs.hotkey.bind(mash, "Down", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y + (max.h / 2)
  f.w = max.w
  f.h = max.h / 2
  win:setFrame(f)
end)

hs.hotkey.bind(mash, "Space", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y
  f.w = max.w
  f.h = max.h
  win:setFrame(f)
end)


-- Pathwatcher
function reloadConfig(files)
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

hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()


-- Battery watcher
function batteryChangedCallback()
  if hs.battery.isCharged() then
    hs.notify.new({title="Your battery is charged", informativeText="Please disconnect the charger.", soundName="Hero"}):send():release()
  end
end

batteryWatcher = hs.battery.watcher.new(batteryChangedCallback)
batteryWatcher:start()
