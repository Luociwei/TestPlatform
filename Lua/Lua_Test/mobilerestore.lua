
local time_utils = require("utils.time_utils")
local console = require(CONFIG.DUT_CONSOLE)
local global  = require("functions.Global")
local console = require(CONFIG.DUT_CONSOLE)--CONFIG.IEFI_UART_CONSOLE
print("testsssss< "..tostring(CONFIG.ID).." > Load Global...")
require "pathManager"
package.cpath = package.cpath..";"..deleteLastPathComponent(CurrentDir()).."/lib/?.dylib"
require "libGlobal"


local MR_Restore_Module = {}
-- mr_cmd_new = '/usr/local/bin/mobile_restore -l 0x14710000 -D /Users/gdlocal/Library/Application\ Support/PurpleRestore/DFU.pr --bundle /Users/gdlocal/RestorePackage/CurrentBundle/Restore --variant "Factory - DFU" -F /Users/gdlocal/Desktop/diags/diag-J523.im4p -b --server http://spidercab:8080 -I /Users/gdlocal/RestorePackage/CurrentBundle/Restore/Firmware/all_flash/iBootData.j523.DEVELOPMENT.im4p --timeout 30'
local mobile_restore_log_file = "/Users/gdlocal/Config/mobile_restore_log.txt"
local mobile_restore_setting_file = "/Users/gdlocal/Config/RestoreSetting.txt"
-- local usbfs_log_path   = "/vault/Suncode_log/usbfs_log_uut"..tostring(CONFIG.ID)..".txt"
-- local usblocation_path = "/vault/Suncode_log/usb_location_"..tostring(CONFIG.ID)..".txt"


local function addWriteFile(filepath,str)
  local ret = nil;
  local f = io.open(filepath, "a");
  if f == nil then return nil, "failed to open file"; end
  ret = f:write(tostring(str));
  f:close();
end



local function ReadFile(filepath,mode)
  if mode == nil then
    mode = "r"
  end 
  local file = io.open(filepath,mode)
  if file then
    local str = file:read("*a")
    file:close()
    return str
  end
  return nil
end


local function Popen(cmd)
  local l = io.popen(cmd)
  local str = l:read("*all")
  print("popen read:"..str)
  l:close()
  return str
end

local function mobile_restore()
     os.execute("killall -9 usbfs")
    local settingTable = {}

    local index =0
    for cmd_list in io.lines(mobile_restore_setting_file) do
        if not(string.find(cmd_list,"#")) then

         index = index+1

         settingTable[index] = cmd_list

            print(cmd_list)
 
        end
    end

    local mr_cmd_termial = '/usr/local/bin/mobile_restore -l '..settingTable[8]..' -D '..settingTable[2]..' --bundle '..settingTable[3]..' --variant "Factory - DFU" -F '..settingTable[4]..' -b --server http://spidercab:8080 -I '..settingTable[5]..' --timeout 30'
    print('====>mr_cmd_1:'..mr_cmd_termial)

    local restore_result = false
    for i=1,1 do

      os.execute(mr_cmd_termial..' &> '..mobile_restore_log_file)
      time_utils.delay(20000)

      local mobile_restore_log = ReadFile(mobile_restore_log_file)
      if mobile_restore_log~=nil then 
          print('mobile_restore_log read:'..mobile_restore_log)
          print('mobile restore finish'..' retry--'..i)
          if string.match(mobile_restore_log,"Done")=='Done' then restore_result = true break end

      end


      --time_utils.delay(2000)
        
    end
    
    addWriteFile(mobile_restore_log_file,'\n\n====>mr_cmd_1:'..mr_cmd_termial)

    if restore_result == false then return "--FAIL--mobile restore fail" end


    -- time_utils.delay(15000)

    -- console._DUT_Set_Detect_String_("]")
    -- console._DUT_Send_String_("\r")
    -- time_utils.delay(200)
    -- local st, msg = console._DUT_Wait_For_String_(10000)

    

    -- console._DUT_Set_Detect_String_("] :-)")
    -- console._DUT_Send_String_("diags")
    -- time_utils.delay(200)

    console._DUT_Set_Detect_String_("] :-)")
    console._DUT_Send_String_("\r")
    time_utils.delay(200)
    
    local st, msg = console._DUT_Wait_For_String_(10000)
    if st ~= 0 then

        return "--FAIL--Enter Diags Failed"

    end

    -- time_utils.delay(5000)

    if tonumber(settingTable[6]) == 1 then

        local usbfs_cmd = "/usr/local/bin/usbfs -f "..tostring(settingTable[7])

        --print(Popen(usbfs_cmd)) 
        --   local _last_diags_response = ""

        local console_cmd = "/usr/bin/script"

        --global.close_usbfs() 

        global.open_usbfs(console_cmd)
        time_utils.delay(1500)
        global.send_usbfs(usbfs_cmd)
        time_utils.delay(2000)

        local usbfs_ret = global.read_usbfs()
        if usbfs_ret==nil then usbfs_ret ="nil" end
        print("usbfs read:"..usbfs_ret)

        if string.match(usbfs_ret,"over USB to diags") == nil then
           global.close_usbfs()  
      --global.unlock("usbfs") 
           return "--FAIL-- not find over USB to diags--"..usbfs_ret
        end

        time_utils.delay(2000)
        

        console._DUT_Send_Cmd_("usbfs -e",nil,10000)
        time_utils.delay(1000)
        local usbfs_e_ret= console._DUT_Read_String_()
        --if string.find(usbfs_e_ret,"over USB to diags") == nil then
        if string.match(tostring(usbfs_e_ret),"Inited%s*FS")==nil then 
           global.close_usbfs()  
      --global.unlock("usbfs") 
           return "--FAIL-- usbfs_enable_fail"
        end
        

        

    end


    
    return "--PASS--NOPDCA"


end



function MR_Restore_Module.usbfs_e()
   os.execute("killall -9 usbfs")
   local settingTable = {}

    local index =0
    for cmd_list in io.lines(mobile_restore_setting_file) do
        if not(string.find(cmd_list,"#")) then

         index = index+1

         settingTable[index] = cmd_list

            print(cmd_list)
 
        end
    end

   local usbfs_cmd = "/usr/local/bin/usbfs -f "..tostring(settingTable[7])

        --print(Popen(usbfs_cmd)) 
        --   local _last_diags_response = ""

        local console_cmd = "/usr/bin/script"

        --global.close_usbfs() 

        global.open_usbfs(console_cmd)
        time_utils.delay(1500)
        global.send_usbfs(usbfs_cmd)
        time_utils.delay(2000)

        local usbfs_ret = global.read_usbfs()
        if usbfs_ret==nil then usbfs_ret ="nil" end
        print("usbfs read:"..usbfs_ret)

        if string.match(usbfs_ret,"over USB to diags") == nil then
           global.close_usbfs()  
      --global.unlock("usbfs") 
           return "--FAIL-- not find over USB to diags--"..usbfs_ret
        end

        time_utils.delay(2000)
        

        console._DUT_Send_Cmd_("usbfs -e",nil,10000)
        time_utils.delay(1000)
        local usbfs_e_ret= console._DUT_Read_String_()
        --if string.find(usbfs_e_ret,"over USB to diags") == nil then
        if string.match(tostring(usbfs_e_ret),"Inited%s*FS")==nil then 
           global.close_usbfs()  
      --global.unlock("usbfs") 
           return "--FAIL-- usbfs_enable_fail"
        end

end





function MR_Restore_Module.restore()

    time_utils.delay(3000)

   -- RestoreMessageBox(tonumber(0))

    return mobile_restore()


end


function MR_Restore_Module.Clear_Dut_Buffer(sequence, global_var_table)
     --os.execute("killall -9 usbfs-2.4.8")
    
     console._Clear_Pub_Msg_()
     console._DUT_Clear_Buffer_()
     -- time_utils.delay(5000)
 --    global.setStopButton("disable")
     return 1
end


function MR_Restore_Module.restore2()

    time_utils.delay(3000)

    return mobile_restore()


end

function MR_Restore_Module.usbfs()



    local usbfs_cmd = "/usr/local/bin/usbfs -f ".."/Users/gdlocal/dvp"
    local console_cmd = "/usr/bin/script"


    --global.close_usbfs()  
    -- global.open_usbfs(console_cmd)

    -- global.open_usbfs(console_cmd)

    -- global.open_usbfs(console_cmd)
    -- os.execute(string.format("ping 127.0.0.1"..'&>'..mobile_restore_log_file))

    -- global.open_usbfs(console_cmd)
    -- time_utils.delay(2000)

    -- global.send_usbfs("ping 127.0.0.1")
    -- time_utils.delay(1000)
    -- global.close_usbfs() 


    global.open_usbfs(console_cmd)
    time_utils.delay(1000)

    -- global.send_usbfs("ls")
    global.send_usbfs(usbfs_cmd)
    time_utils.delay(2000)

    local usbfs_ret = global.read_usbfs()
    global.close_usbfs()  

    return '------'..usbfs_ret..'--------'

end

return MR_Restore_Module