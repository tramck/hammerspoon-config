HAMMERSPOON_CONFIG = os.getenv("HOME") .. "/.hammerspoon/"

-- reload config on change
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
myWatcher = hs.pathwatcher.new(HAMMERSPOON_CONFIG, reloadConfig):start()
hs.notify.new({title="Hammerspoon", informativeText="Config loaded"}):send()


local c = {}
c.HAMMERSPOON_CONFIG = HAMMERSPOON_CONFIG
return c
