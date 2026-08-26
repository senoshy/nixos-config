local src_dir = os.getenv("HOME") .. "/.config/hypr/src"

dofile(src_dir .. "/env.lua")
dofile(src_dir .. "/device.lua")
dofile(src_dir .. "/startup.lua")
dofile(src_dir .. "/general.lua")
dofile(src_dir .. "/animation.lua")
dofile(src_dir .. "/dwindle.lua")
dofile(src_dir .. "/scrolling.lua")
dofile(src_dir .. "/binds.lua")
dofile(src_dir .. "/windowRules.lua")
