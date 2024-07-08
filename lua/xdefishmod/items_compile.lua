local function registerAll(tbl)
    for i, v in pairs(tbl) do -- simple as that!
		v.Name   = "#xdefm."  .. i
		v.Helper = "#xdefm.d" .. i
		if v.Based ~= nil and isstring( v.Based ) then
			for b, k in pairs(tbl[v.Based]) do -- items[v.Based] must be in the same file as it is local
				v[b] = v[b] or k
			end
		end
		xdefm_ItemRegister( i, v )
	end
end

local fil = file.Find( "xdefishmod/items_*.lua", "LUA" )
for _, name in pairs() do 
    if name ~= "compile" then 
        if SERVER then AddCSLuaFile( "xdefishmod/"..out ) end
        include("xdefishmod/" .. name)
    end
end

local items = ITEMS[1]
table.Merge(items, ITEMS[2]) -- this looks like a terrible idea, and I think it is!
table.Merge(items, ITEMS[3])
table.Merge(items, ITEMS[4])
table.Merge(items, ITEMS[5])

registerAll(items)


