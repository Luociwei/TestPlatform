--exam 1
function reversal_string(par)
	-- body
	if type(par) ~= "string" then return 'nil' end
	local table_str = {}
	for w in string.gmatch(par,"%a+") do
		table.insert(table_str,w)
		-- print(w)

	end
	local count = #table_str
	local new_str = ""
	for i=1,count do
		new_str = new_str..table_str[count+1-i].." "
	end
	return new_str
	
end

print("new_str:"..reversal_string("I love china"))


--exam 2
function sort_arr(arr)
	-- body

	table.sort(arr,function(a,b) return a>b end)
	for k,v in ipairs(arr) do
	print(k,v)
	end

	return arr

end


local str_arr = {'g','s','j','l'}
sort_arr(str_arr)

--exam 2
function numToHex(num)
	-- if string.find(num,"0x") then num = string.rep
	local hex = string.format("%#x",num)

	return hex
end
print('numToHex:'..numToHex(654987))function sort_string(par)
	-- body
	if type(par) ~= "string" then return 'nil' end
	local table_str = {}
	for w in string.gmatch(par,"%a+") do
		table.insert(table_str,w)
		print(w)

	end
	local count = #table_str
	local new_str = ""
	for i=1,count do
		new_str = new_str..table_str[count+1-i]
	end
	return new_str
	
end

print("new_str:"..sort_string("I love china"))



function sort_arr(arr)
	-- body

	table.sort(arr,function(a,b) return a>b end)
	for k,v in ipairs(arr) do
	print(k,v)
	end

	return arr

end

local num_arr = {100,23,54,1,67}
sort_arr(num_arr)
local str_arr = {'g','s','j','l'}
sort_arr(str_arr)


function numToHex(num)
	-- if string.find(num,"0x") then num = string.rep
	local hex = string.format("%#x",num)

	return hex
end
print('numToHex:'..numToHex(654987))