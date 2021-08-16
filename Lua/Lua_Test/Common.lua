local a = os.time()
print(a)

os.execute("sleep 5")

local b = os.time()
print(b)
local c = os.difftime(b, a)

local lfs = require "lfs"
local currentdir = lfs.currentdir()
os.execute('ls'..' &> '..currentdir..'test.txt')

local usb_name, popen = "", io.popen
for filename in popen('ls -a /dev'):lines() do
	if string.match(filename, "cu.usbserial") then
   		usb_name = usb_name.."/dev/"..filename..";"
   		print('sc_debug--usb_name:'..usb_name)
 	end
end

local function ReadFile(filepath,mode)
	mode = mode or "r"
  	local file = io.open(filepath,mode)
  	if file then
    	local str = file:read("*a")
    	file:close()
    	return str
  	end
  	return nil
end

local function WriteFile(filepath,str)
	local file = io.open(filepath,"w")
	if file then
		file:write(str)
		file:close()
		return true
	end
	return false
end

local function Popen(cmd)
  local l = io.popen(cmd)
  local str = l:read("*all")
  print("popen read:"..str)
  l:close()
  return str
end

local function toFloat( str )
  -- body
  -- if type(str) == tonumber then return str end
  if str == nil or str == '' then return 0 end

  return tonumber(string.format("%0.6f",str))
end 


local function getItemTable(content)
  -- body
  local arr = {}
  -- for vaule in io.lines(content) do
  --   print(vaule)
  -- end

  for vaule in string.gmatch(content,'([^,]+)') do
    vaule = string.gsub(vaule,"\n", "")
    vaule = string.gsub(vaule,"\r", "")
    vaule = string.gsub(vaule,",", "")
    table.insert(arr,vaule)
    print(vaule)

  end

  return arr
end

