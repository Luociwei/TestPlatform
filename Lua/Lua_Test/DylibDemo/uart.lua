---FCT module
--for control table : GT_control_table_V6_2012_8-21.xlsx
local modname=...;
local M={};
_G[modname]=M;
package.loaded[modname]=M;


function FCT_log(fmt,...)
    Log("[Tester] : "..tostring(fmt),ID);
end

---------------------Hardware reset------------------------
function M.sendCmd(par)
    RS232:WriteString(par);
end

function M.Reset()
    RS232:WriteString("*RST");
    Delay(500) ;
    RS232:WriteString("*cls");
    Delay(500) ;
    RS232:WriteString("SYSTEM:Remote");
    Delay(500) ;
end

function M.ReadVPP()
 --  return GPIB:ReadVPP(channel) ;
    RS232:WriteString("SYSTEM:Remote");
    RS232:WriteString("Meas:Curr:DC?") ;
    RS232:WriteString("READ?");
    Delay(2000) ;
    local ret = RS232:ReadString() ;
    DbgOut("9999read vpp:%s",tostring(ret));
    --RS232:WriteString("SYSTEM:Local\n") ;
    --return tonumber(ret);
end

function M.AgilentReadVolt()
 --   RS232:WriteString("Meas:volt?") ;
 --   Delay(1500) ;
    local response = RS232:SendCmd("Meas:volt?",5000) ;
    assert(response>=0,"Read 34401 Error(-1:TimeOut,-999:Serial port init first)\r\n"..tostring(response));
    local ret = RS232:ReadString() ;
    ret = string.match(tostring(ret),"([+-]?%d.-)[\r\n]");
    assert(ret~=nil,"Read 34401 Error (Volt Data Format Error):\r\n"..tostring(ret));
    DbgOut("Agilent 34401A read volt:%s",tostring(ret));
    return tonumber(ret);
end

function M.ReadCurrent()
   -- RS232:WriteString("MEAS:CURR:DC?");
   -- Delay(1800) ;
    local response = RS232:SendCmd("MEAS:CURR:DC?",5000);
    assert(response>=0,"Read 34401 Error(-1:TimeOut,-999:Serial port init first)\r\n"..tostring(response));
    local ret = RS232:ReadString() ;
    ret = string.match(tostring(ret),"([+-]?%d.-)[\r\n]");
    assert(ret~=nil,"Read 34401 Error (Current Data Format Error):\r\n"..tostring(ret));
    DbgOut("Agilent 34401A read current:%s",tostring(ret));
    return tonumber(ret);
end

function M.MeasurePanel(msg)
    return RS232:ShowMeasurePanel(msg);
end
---------------------------------------Hardwar---------------------------------