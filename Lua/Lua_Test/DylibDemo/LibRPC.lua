local _RPC_ = {}
package.cpath = package.cpath..";"..deleteLastPathComponent(CurrentDir()).."/lib/?.dylib"
require  "libRPC_Client"
local device =nil
local Timeout = 3000
--------------------------------------------------------------------------
--[[
initWithEndpoint
initWithEndpoint
isServerReady
getServerMode
isServerUpToDate
rpc_client
rpc_client
sendFile
sendFile
getFile
getAndWriteFile
--]]
--print(device:rpc_client('server_fw_version'))


local time_utils = require("utils.time_utils")
local config_utils = require("utils.config_utils")
local uuid = require("utils.uuid")

local ip = CONFIG.ARMSOCKET_ADDRESS[CONFIG.ID + 1]--"169.254.1.32"--
local port = CONFIG.RPC_CLIENT_PORT--7801
local rep = config_utils.get_addr(CONFIG, "ARM_PORT", CONFIG.ID)--"tcp://127.0.0.1:7600"
local pub = config_utils.get_addr(CONFIG, "ARM_PUB", CONFIG.ID)--"tcp://127.0.0.1:7650"
print("--rpc client port: "..ip.." port: "..port.." rep: "..rep.." pub: "..pub)




function _RPC_._Connect_()
    os.execute("ping -c 2 " .. ip); 
    print("< ".. tostring(CONFIG.ID).." IASocketPort > Socket Port connect to: " .. tostring(ip).. ":" .. tostring(port))
	  device = RPC_Client:new();
    device:initWithEndpoint(ip..':'..port,ip..':1'..port)
    print("[CHECK RPC CONN]"..ip.." "..port)






    local ret = device:isServerReady()
    if ret ~= 0 then
       error("< ".. tostring(CONFIG.ID).." libRPC_Client > RPC connect Server Fail (xxxx)"..ret)
    else
	print(device:CreateIPC(rep,pub))
		   return 0
    end
    
end

function _RPC_._RPC_Send_Cmd_(cmd, args, kwargs,timeout)
   print("\r\n$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$")
   print("Send Command ===>> "..tostring(cmd))
   print("args ===>> "..tostring(args))
   print("kwargs ===>> "..tostring(kwargs))
   print("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\r\n")
   if timeout ~= nil then
   	  Timeout = timeout
   end
   if device then
       local ret = device:rpc_client(cmd,args,kwargs,Timeout)
       if ret ~= nil and ret ~= "" then
          return ret
       elseif string.find(ret,"Error") then
          assert(false,"--**Error**--"..tostring(ret)) 
          return tostring(ret)
       else
         return false,ret;
       end
   else
       return "Debug"
   end
end

return _RPC_