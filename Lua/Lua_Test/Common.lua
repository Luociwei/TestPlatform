
local Common = {}

local a = os.time()
-- print(a)

os.execute("sleep 5")

local b = os.time()
print(b)
local c = os.difftime(b, a)

local lfs = require "lfs"
local currentdir = lfs.currentdir()
os.execute('ls'..' &> '..currentdir..'test.txt')


function Common.test() 
  return 10
end

-- function trim(s)
--   return s:gsub('^%s*(.-)%s*$', "%1")
-- end

local function readFile(filepath,mode)
	mode = mode or "r"
  	local file = io.open(filepath,mode)
  	if file then
    	local str = file:read("*a")
    	file:close()
    	return str
  	end
  	return nil
end

local function writeFile(filepath,str)
	local file = io.open(filepath,"w")
	if file then
		file:write(str)
		file:close()
		return true
	end
	return false
end

local function popen(cmd)
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

function hasValue(tab, val)
    for k, v in pairs(tab) do
        -- We grab the first index of our sub-table instead
        if v == val then
            return true
        end
    end
    return false
end

function file_exists(name)
    if name then
        local f=io.open(name,"r")
        if f~=nil then io.close(f) return true else return false end
    else
        return false
    end
end


function stringSplit(inputstr, sep)
    if sep == nil then
            sep = "%s"
    end
    local t={}
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
            table.insert(t, str)
    end
    return t
end
-- 　 lfs.attributes(filepath [, aname]) 获取路径指定属性
--     lfs.chdir(path) 改变当前工作目录，成功返回true，失败返回nil加上错误信息
--     lfs.currentdir 获取当前工作目录，成功返回路径，失败为nil加上错误信息
--     lfs.dir(path) 返回一个迭代器（function）和一个目录（userdata），每次迭代器都会返回一个路径，直到不是文件目录为止，则迭代器返回nil
--     lfs.lock(filehandle, mode[, start[, length]])
--     lfs.mkdir(dirname)  创建一个新目录
--     lfs.rmdir(dirname) 删除一个已存在的目录，成功返回true，失败返回nil加上错误信息
function GetAllFiles(rootPath)
    local allFilePath = {}
    local lfs = require "lfs"
    for entry in lfs.dir(rootPath) do
        if entry~='.' and entry~='..' then
            local path = rootPath..'/'..entry
            local attr = lfs.attributes(path)
            assert(type(attr)=="table") --如果获取不到属性表则报错
            -- PrintTable(attr)
            if(attr.mode == "directory") then
                print("Dir:",path)
                GetAllFiles(path) --自调用遍历子目录
            elseif attr.mode=="file" then
                print(attr.mode,path)
                table.insert(allFilePath,path)
            end
        end
    end
    return allFilePath
end

-- GetAllFiles('/Users/ciweiluo/Desktop/Compare_CycleTime')

return Common
