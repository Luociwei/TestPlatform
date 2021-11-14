
local _RPC_ = {}

require("lfs")
package.cpath = package.cpath..";"..lfs.currentdir().."/libDFUFixture.dylib"
require  "LibRPC"


test = RPC:new()

os.execute("sleep " .. 1)



print(test:FixtureWriteRead('sssffdsfafaafafafdas',0))



-- Aclass:Aclass(100)
-- Aclass:Get()
return _RPC_

