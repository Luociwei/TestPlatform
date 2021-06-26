
local _RPC_ = {}

require("lfs")
package.cpath = package.cpath..";"..lfs.currentdir().."/libMyLuaLibTest.dylib"
require  "libTest"


test = Aclass:new(100)

os.execute("sleep " .. 3)

print(test:Get())
print(test:Get1())


-- Aclass:Aclass(100)
-- Aclass:Get()
return _RPC_

