
local _RPC_ = {}

require("lfs")
package.cpath = package.cpath..";"..lfs.currentdir().."/libMyLuaLibTest.dylib"
require  "libTest"


test = Aclass:new(100)
print(test:Get())

-- Aclass:Aclass(100)
-- Aclass:Get()
return _RPC_

