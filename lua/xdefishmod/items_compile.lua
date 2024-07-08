function RegisterAll(tbl)
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
