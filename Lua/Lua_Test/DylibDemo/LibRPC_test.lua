
package.cpath = "/Users/RyanGao/RyanWorking/Suncode/J307/TM_Source_Code/Build/Products/Debug/?.dylib"
require  "libRPC_Client"
local device =nil
local Timeout = 3000
--------------------------------------------------------------------------
local ip = "169.254.1.32"--
local port = 7801
local rep = "tcp://127.0.0.1:7600"
local pub = "tcp://127.0.0.1:7650"

--print("--rpc client port: "..ip.." port: "..port.." rep: "..rep.." pub: "..pub)
os.execute("ping -c 1 " .. ip); 
--print("< ".. tostring(CONFIG.ID).." IASocketPort > Socket Port connect to: " .. tostring(ip).. ":" .. tostring(port))


print("===========1==============")
device = RPC_Client:new();
print("===========2==============")
device:initWithEndpoint(ip..':'..port,ip..':1'..port,1000,4)
-- print("===========3==============")

-- local ret = device:isServerReady()
-- print("]]]]]]:"..ret)
-- print("===========4=============="..ret)


-- print("======>>"..device:getServerMode())
-- print("===========5==============")
-- if ret ~= 0 then
--    print("< ".." libRPC_Client > RPC connect Server Fail (xxxx)"..ret)
-- else
-- 	print("--creat ipc===")
-- 	print(device:CreateIPC(rep,pub))

-- end

-- print(">>>>>>><<<<<"..device:rpc_client("io_set"))
-- print("=================99999999999========")
-- os.execute("sleep 2")
print("=====================00000000==========")
local ret = device:rpc_client("eeprom_write","47,nihaoma_kk",nil,3000)
print("===11===>"..ret)
-- os.execute("sleep 2")


-- function _RPC_._Connect_()
--     os.execute("ping -c 2 " .. ip); 
--     print("< ".. tostring(CONFIG.ID).." IASocketPort > Socket Port connect to: " .. tostring(ip).. ":" .. tostring(port))
-- 	  device = RPC_Client:new();
--     device:initWithEndpoint(ip..':'..port,ip..':1'..port)
--     print("[CHECK RPC CONN]"..ip.." "..port)






--     local ret = device:isServerReady()
--     if ret ~= 0 then
--        error("< ".. tostring(CONFIG.ID).." libRPC_Client > RPC connect Server Fail (xxxx)"..ret)
--     else
-- 	print(device:CreateIPC(rep,pub))
-- 		   return 0
--     end
    
-- end

-- function _RPC_._RPC_Send_Cmd_(cmd, args, kwargs,timeout)
--    print("\r\n$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$")
--    print("Send Command ===>> "..tostring(cmd))
--    print("args ===>> "..tostring(args))
--    print("kwargs ===>> "..tostring(kwargs))
--    print("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\r\n")
--    if timeout ~= nil then
--    	  Timeout = timeout
--    end
--    if device then
--        local ret = device:rpc_client(cmd,args,kwargs,Timeout)
--        if ret ~= nil and ret ~= "" then
--           return ret
--        elseif string.find(ret,"Error") then
--           assert(false,"--**Error**--"..tostring(ret)) 
--           return tostring(ret)
--        else
--          return false,ret;
--        end
--    else
--        return "Debug"
--    end
-- end

