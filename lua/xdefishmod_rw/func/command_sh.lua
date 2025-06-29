function xdefm_Command( ply, cmd, dat )
    if isnumber( dat ) then dat = tostring( dat ) end
    if !isstring( dat ) or dat == "" or !isstring( cmd ) or ( isnumber( ply.XDEFM_Cool ) and ply.XDEFM_Cool > CurTime() )
    or !istable( ply.xdefm_Profile ) then return false end
    if CLIENT then
        net.Start( "NET_xdefm_Cmd" )
        net.WriteString( cmd )
        net.WriteString( dat )
        net.SendToServer()
        if GetConVar( "xdefmod_printcmd" ):GetInt() > 0 then
            MsgC( Color( 255, 255, 255 ), "[", Color( 0, 255, 255 ), "xdefmod", Color( 255, 255, 255 ), "]Command: "..cmd.." "..dat.."\n" )
        end
    else
        ply.XDEFM_Cool = CurTime()+0.2
        local wep = ply:GetActiveWeapon()
        local usi = ply:GetNWEntity( "XDEFM_Using" )
        local hk = hook.Run( "XDEFM_Command", ply, cmd, dat )
        if isbool( hk ) and hk == false then return false end
        if cmd == "StructExit" then local usi = ply.xdefm_Struct  if !IsValid( ply.xdefm_Struct ) then return false end
            local aa, bb = xdefm_ItemGet( usi )  if !istable( bb ) then return false end
            if bb.ExitSound then usi:EmitSound( bb.ExitSound ) end ply.xdefm_Struct = nil
            if bb.OnInteract then local yes = true
                for k, v in pairs( player.GetHumans() ) do if v.xdefm_Struct == usi then yes = false end end
                if yes then bb:OnInteract( usi, ply, -1 ) end
            end return true
        elseif cmd == "Structure" then local usi = ply.xdefm_Struct  if !IsValid( ply.xdefm_Struct ) then return false end local usi = ply.xdefm_Struct  local cls = xdefm_GetClass( usi )
            if ( !xdefm_FriendAllow( ply, usi ) and !xdefm_NadAllow( ply, usi ) ) then return end
            if !isstring( cls ) then return false end local aa, bb = xdefm_ItemGet( cls )  if !istable( bb ) or bb.Type != "Structure" then return false end local stp = bb.SType
            if stp == 1 then local ab = string.Explode( "|", dat ) if !istable( ab ) or #ab != 2 then return false end
                if isfunction( bb.OnInteract ) then if bb:OnInteract( usi, ply, 0, unpack( ab ) ) == false then
                xdefm_AddNote( ply, "!V", "resource/warning.wav", "cross", 5 ) return end end
                local aa, bb = tonumber( ab[ 1 ] ), tonumber( ab[ 2 ] )  if !isnumber( aa ) or !isnumber( bb ) then return false end
                local wep = ply:GetWeapon( "weapon_xdefm_rod" )  if aa == 21 and IsValid( wep ) then
                    local rd = wep.FMod_Rod  local bb = wep.FMod_Bobber  local hk = wep.FMod_Hook
                    if IsValid( rd ) and IsValid( hk ) then xdefm_AddNote( ply, "xdefm.StillFishing", "resource/warning.wav", "cross", 5 ) return false end
                end local a1 = ply.xdefm_Profile.Items[ aa ]  local b1 = usi.xdefm_T3[ bb ]
                if !isstring( a1 ) or !isstring( b1 ) or ( a1 == "_" and b1 == "_" ) then return false end
                local a2, a3 = xdefm_ItemGet( a1 )  local b2, b3 = xdefm_ItemGet( b1 )
                if aa == 21 and b3 and istable( b3 ) and b3.Type != "Bait" then
                xdefm_AddNote( ply, "xdefm.NotBait& "..xdefm_ItemMark( b1 ).." &xdefm.NotBai2", "resource/warning.wav", "cross", 5 ) return false end
                if ( !istable( a3 ) and !istable( b3 ) ) then return end
                if istable( b3 ) and b3.Type == "Bait" and aa == 21 and b3.Level > ply.xdefm_Profile.Level then	
                xdefm_AddNote( ply, "xdefm.NoLevel", "resource/warning.wav", "cross", 5 ) return false end
                ply.xdefm_Profile.Items[ aa ] = b1  usi.xdefm_T3[ bb ] = a1
                if isstring( b1 ) and b1 != "_" then net.Start( "NET_xdefm_BestiaryRecord" ) net.WriteString( xdefm_GetClass( b1 ) ) net.Send( ply ) end xdefm_ProfileUpdate( ply )
                for k, v in pairs( player.GetHumans() ) do if v.xdefm_Struct and v.xdefm_Struct == usi then xdefm_UpdateMenu( v, 3, { [ bb ] = a1 } ) end end return true
            elseif stp == 2 then local slo = bb.Crafts[ tonumber( dat ) ]  if !isstring( slo ) then return false end
                if isfunction( bb.OnInteract ) then if bb:OnInteract( usi, ply, 0, slo ) == false then
                xdefm_AddNote( ply, "!V", "resource/warning.wav", "cross", 5 ) return end end
                ply.XDEFM_Cool = CurTime() +0.1  local ing = string.Explode( "&", slo )  if !istable( ing ) or #ing < 2 then return false end
                local wep = ply:GetWeapon( "weapon_xdefm_rod" )  if IsValid( wep ) then
                    local rd = wep.FMod_Rod  local bb = wep.FMod_Bobber  local hk = wep.FMod_Hook
                    if IsValid( rd ) and IsValid( hk ) then xdefm_AddNote( ply, "xdefm.StillFishing", "resource/warning.wav", "cross", 5 ) return false end
                end local ite, ned = ply.xdefm_Profile.Items, {}
                for k, v in pairs( ing ) do if k == #ing then break end
                    local yes = false
                    for m, n in pairs( ite ) do if n == "_" or ned[ m ] != nil then continue end
                        if xdefm_GetClass( n ) == v then
                            yes = true  ned[ m ] = 0 break
                        end
                    end if !yes then xdefm_AddNote( ply, "xdefm.NeedMat", "resource/warning.wav", "cross", 5 ) return false end
                end
                for k, v in pairs( ned ) do ply.xdefm_Profile.Items[ k ] = "_" end
                if xdefm_ItemGive( ply, ing[ #ing ], true ) then aa[ 2 ] = tonumber( aa[ 2 ] )
                    xdefm_AddNote( ply, "xdefm.Crafted&: &"..xdefm_ItemMark( ing[ #ing ] ), "buttons/lever7.wav", "wrench", 5 )
                    ply.xdefm_Profile.TCraft = ( isnumber( ply.xdefm_Profile.TCraft ) and ply.xdefm_Profile.TCraft +1 or 0 )
                    xdefm_ProfileUpdate( ply )
                end return true
            elseif stp == 3 then
                local pro = ply.xdefm_Profile  local mon, lvl = ply.xdefm_Profile.Money, ply.xdefm_Profile.Level
                local slo = bb.Shop[ dat ] if !istable( slo ) then return false end
                if isfunction( bb.OnInteract ) then if bb:OnInteract( usi, ply, 0, dat ) == false then
                xdefm_AddNote( ply, "!V", "resource/warning.wav", "cross", 5 ) return end end
                local prc = math.ceil( slo[ 1 ] ) if mon < prc or lvl < slo[ 2 ] then return false end local slo = 0
                for k, v in pairs( pro.Items ) do if v == "_" then slo = k break end end
                if IsValid( wep ) and wep:GetClass() == "weapon_xdefm_rod" and slo == 21 then
                    local rd = wep.FMod_Rod  local bb = wep.FMod_Bobber  local hk = wep.FMod_Hook
                    if IsValid( rd ) and IsValid( hk ) then xdefm_AddNote( ply, "xdefm.StillFishing", "resource/warning.wav", "cross", 5 ) return false end end
                if xdefm_ItemGive( ply, dat ) then ply.xdefm_Profile.Money = mon -prc
                    ply.xdefm_Profile.TBuy = ply.xdefm_Profile.TBuy+1  xdefm_ProfileUpdate( ply ) return true end
                end return true
        elseif cmd == "StructOuter" then local usi = ply.xdefm_Struct  if !IsValid( ply.xdefm_Struct ) then return false end local usi = ply.xdefm_Struct  local cls = xdefm_GetClass( usi )
            if !isstring( cls ) then return false end local aa, bb = xdefm_ItemGet( cls )  if !istable( bb ) or bb.Type != "Structure" then return false end local stp = bb.SType
            if stp == 1 then local ab = string.Explode( "|", dat ) if !istable( ab ) or #ab != 2 then return false end
                if isfunction( bb.OnInteract ) then if bb:OnInteract( usi, ply, 0, unpack( ab ) ) == false then
                xdefm_AddNote( ply, "!V", "resource/warning.wav", "cross", 5 ) return end end
                local aa, bb = tonumber( ab[ 1 ] ), tonumber( ab[ 2 ] )  if !isnumber( aa ) or !isnumber( bb ) then return false end
                local a1 = usi.xdefm_T3[ aa ]  local b1 = usi.xdefm_T3[ bb ]
                if !isstring( a1 ) or !isstring( b1 ) or ( a1 == "_" and b1 == "_" ) then return false end
                usi.xdefm_T3[ aa ] = b1  usi.xdefm_T3[ bb ] = a1
                if isstring( b1 ) and b1 != "_" then net.Start( "NET_xdefm_BestiaryRecord" ) net.WriteString( xdefm_GetClass( b1 ) ) net.Send( ply ) end xdefm_ProfileUpdate( ply )
                for k, v in pairs( player.GetHumans() ) do if v.xdefm_Struct and v.xdefm_Struct == usi then xdefm_UpdateMenu( v, 3, { [ bb ] = a1, [ aa ] = b1 } ) end end return true
            end
        elseif cmd == "MoveInv" then local ab = string.Explode( "|", dat ) if !istable( ab ) or #ab != 2 then return false end
            local aa, bb = tonumber( ab[1] ), tonumber( ab[2] ) if !isnumber( aa ) or !isnumber( bb ) or aa <= 0 or bb <= 0 then return false end
            aa = math.Clamp( math.Round( aa ), 1, 21 )  bb = math.Clamp( math.Round( bb ), 1, 21 )  local inv = ply.xdefm_Profile.Items
            local a1, a2 = inv[ aa ], inv[ bb ]  if a1 == "_" and a2 == "_" or aa == bb or a1 == a2 then return false end
            local c1, t1 = xdefm_ItemGet( a1 )  local c2, t2 = xdefm_ItemGet( a2 )  if !istable( c1 ) and !istable( c2 ) then return false end
            if ( istable( t1 ) and t1.Type != "Bait" and bb == 21 ) or ( istable( t2 ) and t2.Type != "Bait" and aa == 21 ) then local bai = ""
            if istable( t1 ) and t1.Type != "Bait" then bai = a1 elseif istable( t2 ) and t2.Type != "Bait" then bai = a2 end
            xdefm_AddNote( ply, "xdefm.NotBait& "..xdefm_ItemMark( bai ).." &xdefm.NotBai2", "resource/warning.wav", "cross", 5 ) return false end
            if istable( t2 ) and t2.Type == "Bait" and aa == 21 and t2.Level > ply.xdefm_Profile.Level then
            xdefm_AddNote( ply, "xdefm.NoLevel", "resource/warning.wav", "cross", 5 ) return false end
            if istable( t1 ) and t1.Type == "Bait" and bb == 21 and t1.Level > ply.xdefm_Profile.Level then
            xdefm_AddNote( ply, "xdefm.NoLevel", "resource/warning.wav", "cross", 5 ) return false end
            local wep = ply:GetWeapon( "weapon_xdefm_rod" )  if ( aa == 21 or bb == 21 ) and IsValid( wep ) then
                local rd = wep.FMod_Rod  local bb = wep.FMod_Bobber  local hk = wep.FMod_Hook
                if IsValid( rd ) and IsValid( hk ) then xdefm_AddNote( ply, "xdefm.StillFishing", "resource/warning.wav", "cross", 5 ) return false end
            end ply.xdefm_Profile.Items[ aa ] = a2  ply.xdefm_Profile.Items[ bb ] = a1  xdefm_ProfileUpdate( ply ) return true
        elseif cmd == "DestroyInv" then local aa = tonumber( dat )  if !isnumber( aa ) then return false end aa = math.Clamp( math.Round( aa ), 1, 21 )  local inv = ply.xdefm_Profile.Items
            local a1 = inv[ aa ]  if !isstring( a1 ) or a1 == "_" then return false end  local bb, cc = xdefm_ItemGet( a1 )
            local prc = xdefm_GetPrice( a1 )  local wep = ply:GetWeapon( "weapon_xdefm_rod" )  if aa == 21 and IsValid( wep ) then
                local rd = wep.FMod_Rod  local bb = wep.FMod_Bobber  local hk = wep.FMod_Hook
                if IsValid( rd ) and IsValid( hk ) then xdefm_AddNote( ply, "xdefm.StillFishing", "resource/warning.wav", "cross", 5 ) return false end
            end if istable( cc ) and prc > 0 then xdefm_GiveMoney( ply, prc ) xdefm_AddNote( ply, "xdefm.GetMoney&: "..prc, "!V", "coins", 5 )
            else xdefm_AddNote( ply, "xdefm.Trashed&: "..xdefm_ItemMark( a1 ), "physics/cardboard/cardboard_box_impact_bullet1.wav", "bin_empty", 5 ) end
            ply.xdefm_Profile.Items[ aa ] = "_"  xdefm_ProfileUpdate( ply ) return true
        elseif cmd == "DropInv" then local aa = tonumber( dat )  if !isnumber( aa ) then return false end aa = math.Clamp( math.Round( aa ), 1, 21 )  local inv = ply.xdefm_Profile.Items
            local a1 = inv[ aa ]  if !isstring( a1 ) or a1 == "_" then return false end
            if !ply:CheckLimit( "xdefmod_items" ) or ( URS and URS.Check( ply, "xdefmod_item", "_" ) == false ) or !ply:IsInWorld() then return false end
            local yes = xdefm_ItemSpawn( a1, ply:WorldSpaceCenter(), Angle( 0, ply:EyeAngles().yaw, 0 ), ply )
            if IsValid( yes ) then ply.xdefm_Profile.Items[ aa ] = "_"  xdefm_ProfileUpdate( ply )  local siz = yes:OBBMins():Distance( yes:OBBMaxs() )
            local tr = util.QuickTrace( ply:EyePos(), ply:EyeAngles():Forward()*( yes:OBBMins():Distance( yes:OBBMaxs() ) )*4, { yes, ply } )
            yes:SetPos( tr.HitPos +( tr.Hit and tr.HitNormal or Vector( 0, 0, 1 ) )*math.abs( yes:OBBMins().z -yes:OBBMaxs().z ) ) end
            local wep = ply:GetWeapon( "weapon_xdefm_rod" )  if aa == 21 and IsValid( wep ) then
                local rd = wep.FMod_Rod  local bb = wep.FMod_Bobber  local hk = wep.FMod_Hook
                if IsValid( rd ) and IsValid( hk ) then xdefm_AddNote( ply, "xdefm.StillFishing", "resource/warning.wav", "cross", 5 ) return false end
            end local aa, bb = xdefm_ItemGet( a1 ) if istable( aa ) and istable( bb ) then bb:OnPlayerDrop( yes, ply ) ply:AddCount( "xdefmod_items", yes )
            xdefm_AddNote( ply, "xdefm.Dropped&: "..xdefm_ItemMark( a1 ), "weapons/iceaxe/iceaxe_swing1.wav", "basket_remove", 5 ) end return true
        elseif cmd == "Upgrade" then local pro = ply.xdefm_Profile  local skp = pro.Skp  local exp = string.Explode( "|", dat )
            local d1, d2  if istable( exp ) and #exp == 2 then d1, d2 = exp[ 1 ], exp[ 2 ] else d1, d2 = dat, 1 end
            d2 = tonumber( d2 ) if !isnumber( d2 ) or d2 <= 0 then return false end d2 = math.ceil( d2 )
            local maxx = ( d1 == "G" and 5 or 100 )  local max2 = maxx -ply.xdefm_Profile[ "Upd"..d1 ]  d2 = math.min( max2, d2 )
            if !isnumber( xdefm.miscs.Costs[ d1 ] ) or ply.xdefm_Profile[ "Upd"..d1 ] >= maxx or max2 <= 0 then return false end
            local co1 = xdefm.miscs.Costs[ d1 ]  local co2 = co1*d2  if skp < co2 then d2 = math.floor( skp/co1 ) end
            if d2 <= 0 then xdefm_AddNote( ply, "xdefm.NoEnoughSkp", "resource/warning.wav", "cross", 5 ) return false end
            co2 = co1*d2 if IsValid( wep ) and wep:GetClass() == "weapon_xdefm_rod" then
                local rd = wep.FMod_Rod  local bb = wep.FMod_Bobber  local hk = wep.FMod_Hook
                if IsValid( rd ) and IsValid( hk ) then xdefm_AddNote( ply, "xdefm.StillFishing", "resource/warning.wav", "cross", 5 ) return false end
            end if d1 == "F" then for i=1, d2 do if !isstring( ply.xdefm_Profile[ "Bnk" ][ ply.xdefm_Profile[ "UpdF" ]+i ] ) then
                ply.xdefm_Profile[ "Bnk" ][ ply.xdefm_Profile[ "UpdF" ]+i ] = "_" end end
            end ply.xdefm_Profile[ "Upd"..d1 ] = ply.xdefm_Profile[ "Upd"..d1 ] +d2
            ply.xdefm_Profile[ "Skp" ] = ply.xdefm_Profile[ "Skp" ] -co2  xdefm_ProfileUpdate( ply )
            if d1 == "G" and GetConVar( "xdefmod_nomorehook" ):GetInt() >= 1 then
                xdefm_AddNote( ply, "xdefm.NoMoreHook", "resource/warning.wav", "cross", 5 )
            else
                xdefm_AddNote( ply, "xdefm.Upgraded&: &xdefm.Upd"..d1, "ui/buttonclick.wav", "lightning_add", 5 )
            end
            if IsValid( wep ) and wep:GetClass() == "weapon_xdefm_rod" and IsValid( wep.FMod_Rod ) then wep.FMod_Rod:Remove() end return true
        elseif cmd == "Downgrade" then local pro = ply.xdefm_Profile  local skp = pro.Skp  local exp = string.Explode( "|", dat )
            local d1, d2  if istable( exp ) and #exp == 2 then d1, d2 = exp[ 1 ], exp[ 2 ] else d1, d2 = dat, 1 end
            d2 = tonumber( d2 ) if !isnumber( d2 ) or d2 <= 0 then return false end d2 = math.ceil( d2 )
            if !isnumber( xdefm.miscs.Costs[ d1 ] ) or ply.xdefm_Profile[ "Upd"..d1 ] <= 0 then return false end
            d2 = math.min( ply.xdefm_Profile[ "Upd"..d1 ], d2 )  local co1 = xdefm.miscs.Costs[ d1 ]  local co2 = co1*d2
            if IsValid( wep ) and wep:GetClass() == "weapon_xdefm_rod" then
                local rd = wep.FMod_Rod  local bb = wep.FMod_Bobber  local hk = wep.FMod_Hook
                if IsValid( rd ) and IsValid( hk ) then xdefm_AddNote( ply, "xdefm.StillFishing", "resource/warning.wav", "cross", 5 ) return false end
            end ply.xdefm_Profile[ "Upd"..d1 ] = ply.xdefm_Profile[ "Upd"..d1 ] -d2
            ply.xdefm_Profile[ "Skp" ] = ply.xdefm_Profile[ "Skp" ] +co2  xdefm_ProfileUpdate( ply )
            xdefm_AddNote( ply, "xdefm.Downgraded&: &xdefm.Upd"..d1, "ui/buttonclick.wav", "lightning_delete", 5 )
            if IsValid( wep ) and wep:GetClass() == "weapon_xdefm_rod" and IsValid( wep.FMod_Rod ) then wep.FMod_Rod:Remove() end return true
        elseif cmd == "MoveBank" then local sls = ply.xdefm_Profile.Bnk
            local ab = string.Explode( "|", dat ) if !istable( ab ) or #ab != 2 then return false end
            local aa, bb = tonumber( ab[ 1 ] ), tonumber( ab[ 2 ] )  if !isnumber( aa ) or !isnumber( bb ) then return false end
            local wep = ply:GetWeapon( "weapon_xdefm_rod" )  if aa == 21 and IsValid( wep ) then
                local rd = wep.FMod_Rod  local bb = wep.FMod_Bobber  local hk = wep.FMod_Hook
                if IsValid( rd ) and IsValid( hk ) then xdefm_AddNote( ply, "xdefm.StillFishing", "resource/warning.wav", "cross", 5 ) return false end
            end local a1 = ply.xdefm_Profile.Items[ aa ]  local b1 = sls[ bb ]
            if !isstring( a1 ) or !isstring( b1 ) or ( a1 == "_" and b1 == "_" ) then return false end
            local a2, a3 = xdefm_ItemGet( a1 )  local b2, b3 = xdefm_ItemGet( b1 )
            if aa == 21 and b3 and istable( b3 ) and b3.Type != "Bait" then
            xdefm_AddNote( ply, "xdefm.NotBait& "..xdefm_ItemMark( b1 ).." &xdefm.NotBai2", "resource/warning.wav", "cross", 5 ) return false end
            if ( !istable( a3 ) and !istable( b3 ) ) or bb > ply.xdefm_Profile.UpdF then return end
            if istable( b3 ) and b3.Type == "Bait" and aa == 21 and b3.Level > ply.xdefm_Profile.Level then	
            xdefm_AddNote( ply, "xdefm.NoLevel", "resource/warning.wav", "cross", 5 ) return false end
            ply.xdefm_Profile.Items[ aa ] = b1  ply.xdefm_Profile.Bnk[ bb ] = a1
            if isstring( b1 ) and b1 != "_" then net.Start( "NET_xdefm_BestiaryRecord" ) net.WriteString( xdefm_GetClass( b1 ) ) net.Send( ply ) end
            xdefm_ProfileUpdate( ply ) return true
        elseif cmd == "MoveBankOuter" then local sls = ply.xdefm_Profile.Bnk
            local ab = string.Explode( "|", dat ) if !istable( ab ) or #ab != 2 then return false end
            local aa, bb = tonumber( ab[ 1 ] ), tonumber( ab[ 2 ] )  if !isnumber( aa ) or !isnumber( bb ) then return false end
            local a1 = sls[ aa ]  local b1 = sls[ bb ]
            if !isstring( a1 ) or !isstring( b1 ) or ( a1 == "_" and b1 == "_" ) then return false end
            local a2, a3 = xdefm_ItemGet( a1 )  local b2, b3 = xdefm_ItemGet( b1 )
            if ( !istable( a3 ) and !istable( b3 ) ) or aa > ply.xdefm_Profile.UpdF or bb > ply.xdefm_Profile.UpdF then return end
            ply.xdefm_Profile.Bnk[ aa ] = b1  ply.xdefm_Profile.Bnk[ bb ] = a1
            xdefm_ProfileUpdate( ply ) return true
        elseif cmd == "MoveTrade" and istable( ply.xdefm_Trade ) then
            local ab = string.Explode( "|", dat ) if !istable( ab ) or #ab != 2 then return false end
            local aa, bb = tonumber( ab[ 1 ] ), tonumber( ab[ 2 ] )  if !isnumber( aa ) or !isnumber( bb ) then return false end
            aa = math.Clamp( math.Round( aa ), 1, 21 )  bb = math.Clamp( math.Round( bb ), 1, 10 )
            local a1 = ply.xdefm_Profile.Items[ aa ]  local b1 = ply.xdefm_Trade[ bb ]
            if !isstring( a1 ) or !isstring( b1 ) or ( a1 == "_" and b1 == "_" ) then return false end
            local a2, a3 = xdefm_ItemGet( a1 )  local b2, b3 = xdefm_ItemGet( b1 ) if !istable( a3 ) and !istable( b3 ) then return false end
            local wep = ply:GetWeapon( "weapon_xdefm_rod" )  if aa == 21 and IsValid( wep ) then
                local rd = wep.FMod_Rod  local bb = wep.FMod_Bobber  local hk = wep.FMod_Hook
                if IsValid( rd ) and IsValid( hk ) then xdefm_AddNote( ply, "xdefm.StillFishing", "resource/warning.wav", "cross", 5 ) return false end
            end if !( !istable( a3 ) and istable( b3 ) ) and !( ply:GetNWEntity( "XDEFMod_TPL" ):IsPlayer() and ply:GetNWEntity( "XDEFMod_TPL" ):GetNWEntity( "XDEFMod_TPL" ) == ply ) then
            xdefm_AddNote( ply, "xdefm.NotTrading", "resource/warning.wav", "cross", 5 ) return false end
            if istable( b3 ) and b3.Type == "Bait" and aa == 21 and b3.Level > ply.xdefm_Profile.Level then	
            xdefm_AddNote( ply, "xdefm.NoLevel", "resource/warning.wav", "cross", 5 ) return false end
            ply.xdefm_Profile.Items[ aa ] = b1  ply.xdefm_Trade[ bb ] = a1
            if isstring( b1 ) and b1 != "_" then net.Start( "NET_xdefm_BestiaryRecord" ) net.WriteString( xdefm_GetClass( b1 ) ) net.Send( ply ) end
            if ply:GetNWEntity( "XDEFMod_TPL" ):IsPlayer() and ply:GetNWEntity( "XDEFMod_TPL" ):GetNWEntity( "XDEFMod_TPL" ) == ply then
                xdefm_UpdateMenu( ply:GetNWEntity( "XDEFMod_TPL" ), 5, ply.xdefm_Trade )
            end xdefm_ProfileUpdate( ply ) xdefm_UpdateMenu( ply, 4, ply.xdefm_Trade ) return true
        elseif cmd == "MoveTradeOuter" and istable( ply.xdefm_Trade ) then
            local ab = string.Explode( "|", dat ) if !istable( ab ) or #ab != 2 then return false end
            local aa, bb = tonumber( ab[ 1 ] ), tonumber( ab[ 2 ] )  if !isnumber( aa ) or !isnumber( bb ) then return false end
            aa = math.Clamp( math.Round( aa ), 1, 10 )  bb = math.Clamp( math.Round( bb ), 1, 10 )
            local a1 = ply.xdefm_Trade[ aa ]  local b1 = ply.xdefm_Trade[ bb ]
            if !isstring( a1 ) or !isstring( b1 ) or ( a1 == "_" and b1 == "_" ) then return false end
            local a2, a3 = xdefm_ItemGet( a1 )  local b2, b3 = xdefm_ItemGet( b1 ) if !istable( a3 ) and !istable( b3 ) then return false end
            ply.xdefm_Trade[ aa ] = b1  ply.xdefm_Trade[ bb ] = a1
            if ply:GetNWEntity( "XDEFMod_TPL" ):IsPlayer() and ply:GetNWEntity( "XDEFMod_TPL" ):GetNWEntity( "XDEFMod_TPL" ) == ply then
                xdefm_UpdateMenu( ply:GetNWEntity( "XDEFMod_TPL" ), 5, ply.xdefm_Trade )
            end xdefm_ProfileUpdate( ply ) xdefm_UpdateMenu( ply, 4, ply.xdefm_Trade ) return true
        elseif cmd == "TradeMoney" and istable( ply.xdefm_Trade ) then
            local ab = tonumber( dat ) if !isnumber( ab ) or ab < 0 or ab > 2147483647 then return false end
            ab = math.Clamp( math.Round( ab ), 0, 2147483647 )  local mn, dl = ply.xdefm_Profile.Money, ply.xdefm_Trade[ 11 ]
            ab = ab -ply.xdefm_Trade[ 11 ]  if ab == 0 then return false end
            if ab > 0 then if !ply:GetNWEntity( "XDEFMod_TPL" ):IsPlayer() or ply:GetNWEntity( "XDEFMod_TPL" ):GetNWEntity( "XDEFMod_TPL" ) != ply then
                xdefm_AddNote( ply, "xdefm.NotTrading", "resource/warning.wav", "cross", 5 ) return false end
                ab = math.min( mn, ab )  ply.xdefm_Trade[ 11 ] = ply.xdefm_Trade[ 11 ] +ab
                ply.xdefm_Profile.Money = ply.xdefm_Profile.Money -ab
                xdefm_ProfileUpdate( ply ) xdefm_UpdateMenu( ply, 4, ply.xdefm_Trade )
                if ply:GetNWEntity( "XDEFMod_TPL" ):IsPlayer() and ply:GetNWEntity( "XDEFMod_TPL" ):GetNWEntity( "XDEFMod_TPL" ) == ply then
                    xdefm_UpdateMenu( ply:GetNWEntity( "XDEFMod_TPL" ), 5, ply.xdefm_Trade )
                end
            else ab = math.abs( ab )  ply.xdefm_Trade[ 11 ] = ply.xdefm_Trade[ 11 ] -ab
                ply.xdefm_Profile.Money = ply.xdefm_Profile.Money +ab
                xdefm_ProfileUpdate( ply ) xdefm_UpdateMenu( ply, 4, ply.xdefm_Trade )
                if ply:GetNWEntity( "XDEFMod_TPL" ):IsPlayer() and ply:GetNWEntity( "XDEFMod_TPL" ):GetNWEntity( "XDEFMod_TPL" ) == ply then
                    xdefm_UpdateMenu( ply:GetNWEntity( "XDEFMod_TPL" ), 5, ply.xdefm_Trade )
                end
            end return true
        elseif cmd == "TradeToggle" and istable( ply.xdefm_Trade ) then local tar = ply:GetNWEntity( "XDEFMod_TPL" )  ply.xdefm_Cool = CurTime() + 0.9
            if !tar:IsPlayer() or tar:GetNWEntity( "XDEFMod_TPL" ) != ply then ply:SetNWFloat( "XDEFMod_RTT", 0 )
            else ply:SetNWFloat( "XDEFMod_RTT", ply:GetNWFloat( "XDEFMod_RTT" ) != 1 and 1 or 0 ) end local tpl = ply:GetNWEntity( "XDEFMod_TPL" )
            if tpl:IsPlayer() and tpl:GetNWEntity( "XDEFMod_TPL" ) == ply then
                xdefm_UpdateMenu( tpl, 6, { ply:Nick(), ply:SteamID64(), ply:GetNWFloat( "XDEFMod_RTT" ) } )
                xdefm_SendSnd( tpl, "buttons/lightswitch2.wav" ) end return true
        elseif cmd == "ResetSkp" then ply.xdefm_SkpCool = CurTime() +GetConVar( "xdefmod_skpcool" ):GetInt() -0.5
            local pro = ply.xdefm_Profile  local skp = pro.Skp  if IsValid( wep ) and wep:GetClass() == "weapon_xdefm_rod" then
                local rd = wep.FMod_Rod  local bb = wep.FMod_Bobber  local hk = wep.FMod_Hook
                if IsValid( rd ) and IsValid( hk ) then xdefm_AddNote( ply, "xdefm.StillFishing", "resource/warning.wav", "cross", 5 ) return false end
            end for k, v in pairs( xdefm.miscs.Costs ) do local pts = pro[ "Upd"..k ] if !isnumber( pts ) or pts <= 0 then continue end
                skp = skp +v*pts  ply.xdefm_Profile[ "Upd"..k ] = 0
            end xdefm_AddNote( ply, "xdefm.ClearedP", "buttons/button15.wav", "lightning_go", 5 )
            if IsValid( wep ) and wep:GetClass() == "weapon_xdefm_rod" and IsValid( wep.FMod_Rod ) then wep.FMod_Rod:Remove() end
            ply.xdefm_Profile[ "Skp" ] = skp  xdefm_ProfileUpdate( ply ) return true
        elseif cmd == "BuyBait" then
            local pro = ply.xdefm_Profile  local mon, lvl = ply.xdefm_Profile.Money, ply.xdefm_Profile.Level  local slo = xdefm.shop[ dat ] if !istable( slo ) then return false end
            local prc = math.ceil( slo[ 1 ] * slo[ 3 ] ) if mon < prc or lvl < slo[ 2 ] then return false end local slo = 0
            for k, v in pairs( pro.Items ) do if v == "_" then slo = k break end end
            if IsValid( wep ) and wep:GetClass() == "weapon_xdefm_rod" and slo == 21 then
                local rd = wep.FMod_Rod  local bb = wep.FMod_Bobber  local hk = wep.FMod_Hook
                if IsValid( rd ) and IsValid( hk ) then xdefm_AddNote( ply, "xdefm.StillFishing", "resource/warning.wav", "cross", 5 ) return false end end
            if xdefm_ItemGive( ply, dat ) then ply.xdefm_Profile.Money = mon -prc
                ply.xdefm_Profile.TBuy = ply.xdefm_Profile.TBuy+1  xdefm_ProfileUpdate( ply )
            return true end
        elseif cmd == "MoveCraft" then local aa = tonumber( dat )  if !isnumber( aa ) then return end
            local wep = ply:GetWeapon( "weapon_xdefm_rod" )  if aa == 21 and IsValid( wep ) then
                local rd = wep.FMod_Rod  local bb = wep.FMod_Bobber  local hk = wep.FMod_Hook
                if IsValid( rd ) and IsValid( hk ) then xdefm_AddNote( ply, "xdefm.StillFishing", "resource/warning.wav", "cross", 5 ) return false end
            end local a1, b1 = ply.xdefm_Profile.Items[ aa ], ply.xdefm_Recipe or "_"
            if !isstring( a1 ) or ( a1 == "_" and b1 == "_" ) then return end
            local a2, a3 = xdefm_ItemGet( a1 )
            if istable( a3 ) and a3.Type != "Recipe" then
                xdefm_AddNote( ply, "xdefm.NotRecipe& "..xdefm_ItemMark( a1 ).." &xdefm.NotRecip2", "resource/warning.wav", "cross", 5 ) return false end
            ply.xdefm_Recipe = a1
            ply.xdefm_Profile.Items[ aa ] = b1
            if isstring( b1 ) and b1 != "_" then net.Start( "NET_xdefm_BestiaryRecord" ) net.WriteString( xdefm_GetClass( b1 ) ) net.Send( ply ) end
            xdefm_ProfileUpdate( ply ) xdefm_UpdateMenu( ply, 9, { ply.xdefm_Recipe } ) return true
        elseif cmd == "Craft" then
            local ab = tonumber( dat ) if !isnumber( ab ) then return false end local re = ply.xdefm_Recipe or "_"
            local aa, bb = xdefm_ItemGet( re )  if !istable( bb ) or bb.Type != "Recipe" or !bb.Crafts or !isstring( bb.Crafts[ ab ] ) then return false end
            ply.XDEFM_Cool = CurTime() +0.1  local ing = string.Explode( "&", bb.Crafts[ ab ] )  if !istable( ing ) or #ing < 2 then return false end
            local wep = ply:GetWeapon( "weapon_xdefm_rod" )  if IsValid( wep ) then
                local rd = wep.FMod_Rod  local bb = wep.FMod_Bobber  local hk = wep.FMod_Hook
                if IsValid( rd ) and IsValid( hk ) then xdefm_AddNote( ply, "xdefm.StillFishing", "resource/warning.wav", "cross", 5 ) return false end
            end local ite, ned = ply.xdefm_Profile.Items, {}
            for k, v in pairs( ing ) do if k == #ing then break end
                local yes = false
                for m, n in pairs( ite ) do if n == "_" or ned[ m ] != nil then continue end
                    if xdefm_GetClass( n ) == v then
                        yes = true  ned[ m ] = 0 break
                    end
                end if !yes then xdefm_AddNote( ply, "xdefm.NeedMat", "resource/warning.wav", "cross", 5 ) return false end
            end
            for k, v in pairs( ned ) do ply.xdefm_Profile.Items[ k ] = "_" end
            if xdefm_ItemGive( ply, ing[ #ing ], true ) then aa[ 2 ] = tonumber( aa[ 2 ] )
                xdefm_AddNote( ply, "xdefm.Crafted&: &"..xdefm_ItemMark( ing[ #ing ] ), "buttons/lever7.wav", "wrench", 5 )
                ply.xdefm_Profile.TCraft = ( isnumber( ply.xdefm_Profile.TCraft ) and ply.xdefm_Profile.TCraft +1 or 0 )
                xdefm_ProfileUpdate( ply )
                if !isnumber( aa[ 2 ] ) or aa[ 2 ] <= 1 then ply.xdefm_Recipe = "_" else ply.xdefm_Recipe = aa[ 1 ].."|"..( aa[ 2 ] -1 ) end
                xdefm_UpdateMenu( ply, 9, { ply.xdefm_Recipe } )
            end return true
        elseif cmd == "Quest" then local dt = ply.xdefm_Quest  if !istable( dt ) or table.IsEmpty( dt ) then return false end
            local rq, rw = ( string.Explode( "&", dt[ 2 ] ) or { dt[ 2 ] } ), ( string.Explode( "&", dt[ 3 ] ) or { dt[ 3 ] } )
            local dl, em, pr, ot = {}, 0, ply.xdefm_Profile.Items, {}  ply.XDEFM_Cool = CurTime() +0.5  local yes = false
            for k, v in pairs( ents.FindInSphere( ply:GetPos(), 512 ) ) do
                if v:GetClass() == "sent_xdefm_quest" or v:GetClass() == "sent_xdefm_darknpc" then yes = true break end
            end if !yes then return false end
            for k, v in pairs( rq ) do
                local yes = false
                for m, n in pairs( pr ) do
                    if m != 21 and !dl[ m ] and xdefm_GetClass( n ) == v then
                        dl[ m ] = 0
                        yes = true
                        break
                    end
                end if !yes then return false end
            end
            for k, v in pairs( pr ) do
                if k != 21 and ( v == "_" or dl[ k ] ) then
                    em = em +1  table.insert( ot, k )
                end
            end if em < #rw then return false end
            for k, v in pairs( dl ) do ply.xdefm_Profile.Items[ k ] = "_" end
            for k, v in pairs( rw ) do
                ply.xdefm_Profile.Items[ ot[ k ] ] = v
                if v != "_" then net.Start( "NET_xdefm_BestiaryRecord" ) net.WriteString( xdefm_GetClass( v ) )
                net.Send( ply ) end
            end
            xdefm_QuestPick( -1, ply ) xdefm_AddNote( ply, "xdefm.Complete", "ui/achievement_earned.wav", "page", 5 )
            ply.xdefm_Profile.TQuest = ( ply.xdefm_Profile.TQuest and ply.xdefm_Profile.TQuest +1 or 1 )
            xdefm_ProfileUpdate( ply ) return true
        elseif cmd == "Skip" then local dt = ply.xdefm_Quest  if !istable( dt ) or table.IsEmpty( dt ) then return false end
            if xdefm.skips[ ply:SteamID() ] or ply:GetNWFloat( "XDEFM_QC" ) > CurTime() then return false end ply.XDEFM_Cool = CurTime() +0.5
            xdefm.skips[ ply:SteamID() ] = 0
            local yes = false  for k, v in pairs( ents.FindInSphere( ply:GetPos(), 512 ) ) do
                if v:GetClass() == "sent_xdefm_quest" or v:GetClass() == "sent_xdefm_darknpc" then yes = true break end
            end if !yes then return false end ply:SetNWFloat( "XDEFM_QC", CurTime() +GetConVar( "xdefmod_qsttime" ):GetInt()*60 )
            xdefm_QuestPick( -1, ply ) xdefm_AddNote( ply, "xdefm.Skipped", "npc/vort/claw_swing1.wav", "page_red", 5 )
            ply.xdefm_Profile.TQuest = ( ply.xdefm_Profile.TQuest or 0 )
            xdefm_ProfileUpdate( ply ) return true
        elseif cmd == "Convert" then if !DarkRP then xdefm_AddNote( ply, "xdefm.NotRP", "resource/warning.wav", "cross", 5 ) return false end
            local ab = string.Explode( "|", dat ) if !istable( ab ) or #ab != 2 then return false end
            local aa, bb = tonumber( ab[ 1 ] ), tonumber( ab[ 2 ] )
            if !isnumber( aa ) or !isnumber( bb ) or ( bb != 1 and bb != 2 ) or aa <= 0 or aa >= 2147483647 then return false end
            if ( bb == 1 and ply.xdefm_Profile.Money < aa ) or ( bb == 2 and !ply:canAfford( aa ) ) then return false end
            local rat = GetConVar( "xdefmod_darkrp" ):GetFloat()
            local num = math.max( bb == 1 and math.floor( aa*rat*0.99 ) or math.floor( aa/rat*0.99 ), 0 )
            if bb == 1 then
                ply.xdefm_Profile.Money = ply.xdefm_Profile.Money -aa
                ply:addMoney( num )
            else
                ply:addMoney( -aa )
                ply.xdefm_Profile.Money = ply.xdefm_Profile.Money +num
            end
            xdefm_AddNote( ply, "xdefm.Exchanged&: "..( bb == 1 and "-" or "+" )..num, "garrysmod/ui_return.wav", "calculator", 5 )
            xdefm_ProfileUpdate( ply ) return true
        elseif cmd == "NPC" then
            local num = tonumber( dat )  if !isnumber( num ) or num < 1 or num > 7 then return false end ply.xdefm_Cool = CurTime() +0.2
            if num == 1 then
                local tak, weps = false, { "inventory", "rod", "trade" }
                for k, v in pairs( weps ) do local www = ( "weapon_xdefm_"..v )
                    if !ply:HasWeapon( www ) then ply:Give( www, true ) tak = true end end
                if tak then ply:EmitSound( "AmmoCrate.Open" ) return true else
                for k, v in pairs( weps ) do local www = ( "weapon_xdefm_"..v )
                    if ply:HasWeapon( www ) then ply:StripWeapon( www ) end end ply:EmitSound( "AmmoCrate.Close" ) return true end
            elseif num == 2 then
                local prc = 0  local wep = ply:GetWeapon( "weapon_xdefm_rod" )  if aa == 21 and IsValid( wep ) then
                    local rd = wep.FMod_Rod  local bb = wep.FMod_Bobber  local hk = wep.FMod_Hook
                    if IsValid( rd ) and IsValid( hk ) then xdefm_AddNote( ply, "xdefm.StillFishing", "resource/warning.wav", "cross", 5 ) return false end
                end for k, v in pairs( ply.xdefm_Profile.Items ) do
                    prc = prc +xdefm_GetPrice( v )  ply.xdefm_Profile.Items[ k ] = "_"
                end if prc > 0 then xdefm_GiveMoney( ply, prc ) xdefm_AddNote( ply, "xdefm.GetMoney&: "..prc, "!V", "coins", 5 ) end
                xdefm_ProfileUpdate( ply ) return true
            elseif num == 3 then xdefm_OpenMenu( ply, 0, ply.xdefm_Profile ) xdefm_OpenMenu( ply, 5, ply.xdefm_Profile ) return true
            elseif num == 4 then xdefm_OpenMenu( ply, 0, ply.xdefm_Profile ) xdefm_OpenMenu( ply, 9, { ply.xdefm_Recipe or "_" } ) return true
            elseif num == 5 then xdefm_OpenMenu( ply, 8, ply.xdefm_Profile ) return true
            elseif num == 6 then
                if ply:GetNWBool( "XDEFM_QD" ) then xdefm_AddNote( ply, "xdefm.Failed", "resource/warning.wav", "cross", 5 ) return true end local lvl = ( ply.xdefm_Profile.Level or 0 )
                if !istable( ply.xdefm_Quest ) or table.IsEmpty( ply.xdefm_Quest ) then local qst = xdefm_QuestPick( lvl, ply )
                if qst then xdefm_AddNote( ply, "xdefm.QuestSt", "friends/friend_online.wav", "page_add", 5 ) end
                end xdefm_OpenMenu( ply, 1, ply.xdefm_Quest or {} ) xdefm_UpdateMenu( ply, 0, ply.xdefm_Profile ) return true
            elseif num == 7 then
                xdefm_OpenMenu( ply, 2, ply.xdefm_Profile ) return true end
            return false
        end
    end
end
