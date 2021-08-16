local lfs = require "lfs"
local currentdir = lfs.currentdir()
local Atlas2_Cycle_TimePath =currentdir..'/J407_SC_Atlas2_Cycle_Time.csv'
local SC_FCT_Cycle_TimePath =currentdir..'/J407_SC_FCT_Cycle_Time.csv'

local SC_Atals2_Cycle_ComparePath =currentdir..'/SC_Atals2_Cycle_Compare.csv'
local systemSchedulerPath =currentdir..'/SC_Atals2_Cycle_Compare_SystemScheduler.csv'

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
  -- print("popen read:"..str)
  l:close()
  return str
end

local function getItemTable(content)
	-- body
	local arr = {}

	for vaule in string.gmatch(content,'([^,]+)') do
		vaule = string.gsub(vaule,"\n", "")
		vaule = string.gsub(vaule,"\r", "")
		vaule = string.gsub(vaule,",", "")
		table.insert(arr,vaule)
		print(vaule)

	end

	return arr
end


local function getSafetyString( str )
	-- body
	if str == nil then return '' end
end

local function getSafetyNumber( num )
	-- body
	if num == nil then return 0 end
end

local function grepWithCmd( cmd )
	-- body
	local log = Popen(cmd)
	local row_item = ''
	local items_count = 0
	local atlas2_items = ''
	local table = {}
	for str in string.gmatch(log,'(.-)\n') do
		if str ~=nil then
			if items_count == 0 then
				row_item = str

				-- table.insert(table,str)
			-- print(str)
			end
			items_count = items_count + 1
		end

	end
	local is_found = false
	if items_count == 1 then 
		local arr = getItemTable(row_item)
		-- print('arr---count'..#arr)
		if #arr == 9 then
			atlas2_items = ','..arr[5]..','..arr[6]..','..arr[7]..',Y\n'
			is_found = true
		end
	end
	return items_count,atlas2_items,is_found
end

local function compareCalculate(SC_FCT_Cycle_TimePath,Atlas2_Cycle_TimePath)
	-- body
	local sc_CycleTimeContent = ReadFile(SC_FCT_Cycle_TimePath)
	-- print(sc_CycleTimeContent)
	local sc_atlas2_CycleTimeContent = ''

	local index = 0
	local condition_count = 0
	for row_str in string.gmatch(sc_CycleTimeContent,'(.-)\n') do

		local arr = getItemTable(row_str)
		row_str = string.gsub(row_str,"\n", "")
		row_str = string.gsub(row_str,"\r", "")
		local test_name = arr[1] or ''
		local sub_name = arr[2] or ''
		local sub_sub_name = arr[3] or ''
		local testName_subItem = test_name..','..sub_name..','
		local sc_time = arr[4]
		if sc_time == nil or sc_time == '' then sc_time = 0 end

		if index == 0 then --TestName,SubItem,SubSubItem,test time(s)
			condition_count = #arr
			local new_item = row_str..',Atlas_test_time(s),Atlas_SubItem,Atlas_Item,Is_Found\n'
			print(new_item)
			sc_atlas2_CycleTimeContent = sc_atlas2_CycleTimeContent..new_item

		else
			local is_null = row_str == ",,," or row_str == '' or #arr ~= condition_count
			local atlas2_items = ''
			local is_found = false
			if is_null == false then
				local cmd1 = 'grep \",.* .* '..sub_sub_name..',\" '..Atlas2_Cycle_TimePath
				local items_count1,atlas2_items1,is_found1 =  grepWithCmd(cmd1)
				atlas2_items = atlas2_items1
				is_found = is_found1
				if is_found1 == false and items_count1 > 1 then
					local cmd2 = 'grep \",'..test_name..' .* '..sub_sub_name..',\" '..Atlas2_Cycle_TimePath
					local items_count2,atlas2_items2,is_found2 =  grepWithCmd(cmd2)
					atlas2_items = atlas2_items2
					is_found = is_found2
					if is_found2 == false and items_count2 > 1 then
						local cmd3 = 'grep \",'..test_name..' '..sub_name..' '..sub_sub_name..',\" '..Atlas2_Cycle_TimePath
						local items_count3,atlas2_items3,is_found3 =  grepWithCmd(cmd3)
						atlas2_items = atlas2_items3
						is_found = is_found3
					end
				end
				if is_found == true then
					local new_item = row_str..atlas2_items
					print(new_item)
					sc_atlas2_CycleTimeContent = sc_atlas2_CycleTimeContent..new_item
					
				else
					local full_name = test_name..' '..sub_name..' '..sub_sub_name
					-- local new_item = row_str..','..sc_time..','..sub_name..','..full_name..',N\n'
					local new_item = row_str..','..sc_time..',,,N\n'
					print(new_item)
					sc_atlas2_CycleTimeContent = sc_atlas2_CycleTimeContent..new_item
				end

			end


		end
		index = index + 1

	end
	-- print(sc_atlas2_CycleTimeContent)
	WriteFile(SC_Atals2_Cycle_ComparePath,sc_atlas2_CycleTimeContent)
	return sc_atlas2_CycleTimeContent
	
end



local function systemSchedulert_Calculate( sc_atlas2_CycleTimePath )
	-- body
	local compareContent = ReadFile(sc_atlas2_CycleTimePath)
	-- local compareContent = sc_atlas2_CycleTimeContent
	local compareContent_copy = compareContent
	local index = 0
	
	local sum_sc_time=0
	local sum_atlas_time=0
	-- local float_sc_sum_time = 0
	-- local float_atlas_sum_time = 0
	local last_row_str=''
	local last_TestName_SubItem=''
	-- SystemScheduler

	local condition_count = 0
	for row_str in string.gmatch(compareContent_copy,'(.-)\n') do
		-- print(row_str)
		local arr = getItemTable(row_str)
		local test_name = arr[1] or ''
		local sub_name = arr[2] or ''
		local testName_subItem = test_name..','..sub_name..','
		
		local sc_time = arr[4]
		if sc_time == nil or sc_time == '' then sc_time = 0 end
		local atlas_time = arr[5]
		if atlas_time == nil or atlas_time == '' then atlas_time = 0 end
		
		-- print(#arr)
		if index == 0 then condition_count = #arr end
			
		if index == 1 then

			last_TestName_SubItem = testName_subItem
			sum_sc_time=sc_time
			sum_atlas_time=atlas_time
			last_row_str=row_str

			-- goto continue
		elseif index > 1 then

			local is_null = row_str == ",,,,,,," or test_name..sub_name == '' or #arr ~= condition_count

			if is_null == false then

				if last_TestName_SubItem ~= testName_subItem then

 					local resplaceStr = last_row_str..'\n'
					local systemScheduler =resplaceStr..last_TestName_SubItem..'SystemScheduler,'..sum_sc_time..','..sum_atlas_time..',,,\n,,,,,,,\n,,,,,,,\n'
 					
 					compareContent = string.gsub(compareContent,resplaceStr,systemScheduler)
					-- local 
					sum_sc_time=sc_time

					sum_atlas_time=atlas_time

					
				else
					
					sum_sc_time = sum_sc_time+sc_time
					
					sum_atlas_time = sum_atlas_time+atlas_time
					


				end
				last_row_str=row_str
				last_TestName_SubItem = testName_subItem

			end

		
		end

		index = index + 1
		-- print(index..'===='..index)
		-- print(index..'===='..tostring(row_str))

	end

	local resplaceStr = last_row_str..'\n'
	local systemScheduler =resplaceStr..last_TestName_SubItem..'SystemScheduler,'..sum_sc_time..','..sum_atlas_time..',,,\n,,,,,,,\n,,,,,,,\n'
 					
 	compareContent = string.gsub(compareContent,resplaceStr,systemScheduler)

	print(compareContent)

	WriteFile(systemSchedulerPath,compareContent)


end

-- print('sss--'..tonumber(string.format("%0.4f","0.1234"))+tonumber(string.format("%0.4f","0.2234")))
-- print('sss--'..tonumber(string.format("%0.4f","0.1234"))+tonumber(string.format("%0.4f","0.2234")))

-- local sc_atlas2_CycleTimeContent = compareCalculate(SC_FCT_Cycle_TimePath,Atlas2_Cycle_TimePath)
-- systemSchedulert_Calculate(SC_Atals2_Cycle_ComparePath)




-- systemSchedulert_Calculate(sc_atlas2_CycleTimeContent)




local function compare_time(comparePath,saveFilePath)
	-- body
	local compareContent = ReadFile(comparePath)
	-- local compareContent = sc_atlas2_CycleTimeContent
	local compareContent_new = ''
	local index = 0
	
	local sum_sc_time=0
	local sum_atlas_time=0

	-- SystemScheduler

	local condition_count = 0
	for row_str in string.gmatch(compareContent,'(.-)\n') do
		-- print(row_str)
		local arr = getItemTable(row_str)
		row_str = string.gsub(row_str,"\n", "")
		row_str = string.gsub(row_str,"\r", "")
		local test_name = arr[1] or ''
		local sub_name = arr[2] or ''
		local testName_subItem = test_name..','..sub_name..','
		
		local sc_time = arr[4]
		if sc_time == nil or sc_time == '' then sc_time = 0 end
		local atlas_time = arr[5]
		if atlas_time == nil or atlas_time == '' then atlas_time = 0 end
		
		-- print(#arr)
		if index == 0 then 
			condition_count = #arr 
			row_str = row_str..',Commnet\n'

			
			-- goto continue
		elseif index >= 1 then
			local is_null = row_str == ",,,,,,," or #arr ~= condition_count
			if is_null then
				row_str = row_str..',\n'
			else
				local time1 = atlas_time - sc_time
				-- local time2 = sc_time - atlas_time
				print('time1='..time1)

				if time1 >= 0.1 then 
					row_str = row_str..',long long time\n'
				elseif time1 <= 0.1 and time1 >0 then 
					row_str = row_str..',long time\n'
				elseif time1 == 0 then 
					row_str = row_str..',same time\n'
				elseif time1 >= -0.1 and time1 < 0 then 
					row_str = row_str..',short time\n'
				elseif time1 < -0.1 then 
					row_str = row_str..',short short time\n'
				end

			end




		
		end

		compareContent_new = compareContent_new..row_str

		index = index + 1
		-- print(index..'===='..index)
		-- print(index..'===='..tostring(row_str))

	end

	-- local resplaceStr = last_row_str..'\n'
	-- local systemScheduler =resplaceStr..last_TestName_SubItem..'SystemScheduler,'..sum_sc_time..','..sum_atlas_time..',,,\n,,,,,,,\n,,,,,,,\n'
 					
 -- 	compareContent = string.gsub(compareContent,resplaceStr,systemScheduler)

	-- print(compareContent_new)

	WriteFile(saveFilePath,compareContent_new)




end
-- WriteFile('222222222','/Users/gdlocal/Desktop/J407_SC_Atlas2_FCT_Cycle_Time/SC_Atals2_Cycle_Compare_2.csv')
-- local saveFilePath = currentdir..'/SC_Atals2_Cycle_Compare_2.csv'
-- compare_time(SC_Atals2_Cycle_ComparePath,saveFilePath)

local saveFilePath = currentdir..'/SC_Atals2_Cycle_Compare_SystemScheduler_2.csv'
compare_time(SC_Atals2_Cycle_ComparePath,saveFilePath)
