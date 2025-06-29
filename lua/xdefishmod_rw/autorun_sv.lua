xdefm.quests = {}
xdefm.skips = {}
xdefm.pools = {}
xdefm.miscs.SaleTime = 0
xdefm.miscs.ShutDown = false
xdefm.miscs.LeadTime = 0
local lbtimer = "xdefm_leaderboardupdate"

util.AddNetworkString( "NET_xdefm_Anim" )
util.AddNetworkString( "NET_xdefm_Profile" )
util.AddNetworkString( "NET_xdefm_Menu" )
util.AddNetworkString( "NET_xdefm_Cmd" )
util.AddNetworkString( "NET_xdefm_SendNote" )
util.AddNetworkString( "NET_xdefm_SendSnd" )
util.AddNetworkString( "NET_xdefm_BreakEF" )
util.AddNetworkString( "NET_xdefm_UpdateShop" )
util.AddNetworkString( "NET_xdefm_NeedProfile" )
util.AddNetworkString( "NET_xdefm_MenuUpdate" )
util.AddNetworkString( "NET_xdefm_MenuClose" )
util.AddNetworkString( "NET_xdefm_SendFriends" )
util.AddNetworkString( "NET_xdefm_ConsoleCmd" )
util.AddNetworkString( "NET_xdefm_CLEffect" )
util.AddNetworkString( "NET_xdefm_Pickup" )
util.AddNetworkString( "NET_xdefm_Leaderboard" )
util.AddNetworkString( "NET_xdefm_BestiaryRecord" )
util.AddNetworkString( "NET_xdefm_BestiaryAll" )
util.AddNetworkString( "NET_xdefm_Quest" )

function xdefm_PoolAdd( dat )
    if !istable( dat ) then return false end
    local inp = {}
    inp.Items = {} --上钩物品,可只填字符,不允许留白
    if isstring( dat.Items ) then
        inp.Items = { dat.Items }
    elseif istable( dat.Items ) then
        inp.Items = dat.Items
    else
        return false
    end
    inp.Level	 	= isnumber( dat.Level ) and math.Clamp( math.Round( dat.Level ), 0, 1000 ) or 0 --等级限制,满级1000(不大可能达到的地位)
    inp.Exp 		= isnumber( dat.Exp ) and math.Clamp( math.Round( dat.Exp ), 0, 2147483647 ) or 0 --成功钓起获得经验
    inp.DepthMin 	= isnumber( dat.DepthMin ) and math.Clamp( math.Round( dat.DepthMin ), 0, 2147483647 ) or 0 --最低深度(米),0为表面
    inp.DepthMax 	= isnumber( dat.DepthMax ) and math.Clamp( math.Round( dat.DepthMax ), 0, 2147483647 ) or 2147483647 --最高深度(米)
    inp.GroundOnly 	= isbool( dat.GroundOnly ) and dat.GroundOnly or false --仅限河床,搭配深度效果更佳
    inp.Chances 	= {} --上钩几率, 数值越大几率越小,0为必然,裸钩(填数字默认)为"_",全饵通用为"*",不允许留白,效率值会按比例降低该数值
    if isnumber( dat.Chances ) then
        if istable( dat.Baits ) then
            for k, v in pairs( dat.Baits ) do
                inp.Chances[ v ] = math.max( 0, math.Round( dat.Chances ) )
            end
        elseif isstring( dat.Baits ) then
            inp.Chances = { [ dat.Baits ] = math.max( 0, math.Round( dat.Chances ) ) }
        else
            inp.Chances = { [ "_" ] = math.max( 0, math.Round( dat.Chances ) ) }
        end
    elseif istable( dat.Chances ) then
        for k, v in pairs( dat.Chances ) do
            if isstring( k ) and isnumber( v ) then
                inp.Chances[ k ] = math.max( 0, math.Round( v ) )
            end
        end
    end
    if #inp.Items <= 0 then return false end
    if inp.DepthMin > inp.DepthMax then
        inp.DepthMin = inp.DepthMax
    end
    local chn = inp.Chances
    for k, v in pairs( inp.Chances ) do
        if !istable( xdefm.pools[ k ] ) then
            xdefm.pools[ k ] = {}
        end
        local fin = inp
        fin.Chances = chn[ k ]
        table.insert( xdefm.pools[ k ], inp )
    end
    return true
end
function xdefm_PoolGet( dept, leve, bait, effi, grou )
    local add = ( GetConVar( "xdefmod_nodepth" ):GetInt() > 0 )
    if !isnumber( leve ) then leve = 0 else leve = math.Clamp( math.Round( leve ), 0, 1000 ) end
    if !isnumber( dept ) then dept = 0 else dept = math.max( 0, math.Round( dept, 1 ) ) end
    if !isstring( bait ) then bait = "_" end if !isbool( grou ) then grou = false end
    if !isnumber( effi ) then effi = 0 else effi = math.Clamp( math.Round( effi ), 0, 100 ) end
    if istable( xdefm.pools[ "*" ] ) and math.random( 1, 3 ) == 1 then
        bait = "*"
    end
    local lis = xdefm.pools[ bait ]
    if bait == "ba_gmod" then
        local tab = {}
        for k, v in pairs( xdefm.pools ) do
            table.insert( tab, v )
        end
        lis = tab[ math.random( #tab ) ]
    end
    if !istable( lis ) then return nil, nil end
    local cel = {}
    sel = lis[ math.random( #lis ) ]
    if !istable( sel ) or !isnumber( sel.Chances ) then return nil, nil end
    local ccc = sel.Chances
    local chn = math.ceil( math.random( ccc -math.min( math.ceil( dept/0.01905 ), ccc*0.5 ) )*( 1 - effi/100 ) )
    if chn < 1 then return nil, nil end
    if leve < sel.Level or ( !add and ( dept > sel.DepthMax or dept < sel.DepthMin ) ) or ( sel.GroundOnly and !grou ) then return nil, nil end
    return chn <= 1 and sel.Items[ math.random( #sel.Items ) ], sel.Exp or nil, nil
end
function xdefm_UpdateShop()
    local tab = {}
    for k, v in pairs( xdefm.shop ) do
        if GetConVar( "xdefmod_salecool" ):GetInt() > 0 then
            tab[ k ] = math.Round( math.Rand( 0.5, 1 ), 2 )
            xdefm.shop[ k ][ 1 ] = tab[ k ]
        else
            tab[ k ] = 1
            xdefm.shop[ k ][ 1 ] = 1
        end
    end
    net.Start( "NET_xdefm_UpdateShop" )
    net.WriteString( util.TableToJSON( tab ) )
    net.Broadcast()
end
function xdefm_FireSpot( pos, siz, pow, par )
    if !isvector( pos ) then return nil end
    siz = isnumber( siz ) and math.Clamp( siz, 0, 100 ) or 5
    pow = isnumber( pow ) and math.max( pow, 0 ) or siz
    local spo = ents.Create( "xdefm_firespot" )
    spo:SetPos( pos )
    spo:SetAngles( Angle( 0, 0, 0 ) )
    spo.Owner = Entity( 0 )
    if IsEntity( par ) then
        spo:SetParent( par )
        spo:SetAngles( par:GetAngles() )
    end
    spo:Spawn()
    spo:Activate()
    spo:SetFMod_Strength( siz )
    spo:SetFMod_Enable( false )
    par:DeleteOnRemove( spo )
    timer.Simple( 0, function()
        if IsValid( spo ) then
            spo.xdefm_Power = pow
        end
    end )
    return spo
end
function xdefm_SetupFriends( ply, tab )
    if !IsValid( ply ) or !ply:IsPlayer() or !isstring( ply:SteamID() ) or ply:IsBot() then return end
    local fil = "xdefishmod/f_"..string.Replace( ply:SteamID(), ":", "_" )..".txt"
    if !istable( tab ) then
        if file.Exists( fil, "DATA" ) then
            ply.xdefm_Friends = util.JSONToTable( file.Read( fil, "DATA" ) )
        else
            ply.xdefm_Friends = {}
            file.Write( fil, util.TableToJSON( {}, true ) )
        end
    else
        local ta2, num = {}, 0
        for k, v in pairs( tab ) do
            if num > 16 then break end
            if isnumber( tonumber( v[ 2 ] ) ) and ( tonumber( v[ 2 ] ) == 1 or tonumber( v[ 2 ] ) == 0 ) then
                ta2[ k ] = v  num = num +1
            end
        end
        ply.xdefm_Friends = ta2  file.Write( fil, util.TableToJSON( ta2, true ) )
        xdefm_UpdateMenu( ply, 2, ply.xdefm_Friends )
        xdefm_AddNote( ply, "xdefm.FriendAd5", "buttons/combine_button1.wav", "group", 5 )
    end
end
function xdefm_FriendAllow( ply, id )
    if !IsValid( ply ) or !ply:IsPlayer() or ply:IsBot() or !isstring( ply:SteamID() ) then return false end
    if ply:IsAdmin() or !isstring( id ) or ( id == "" or ply:SteamID() == id ) then return true end
    local path, num, i2, own = "xdefishmod/f_"..string.Replace( id, ":", "_" )..".txt", 0, ply:SteamID(), player.GetBySteamID( id )
    if IsValid( own ) and istable( own.xdefm_Friends ) then
        if istable( own.xdefm_Friends[ i2 ] ) then
            num = own.xdefm_Friends[ i2 ][ 2 ]
        end
    elseif file.Exists( path, "DATA" ) then
        local dat = util.JSONToTable( file.Read( path, "DATA" ) )
        if !istable( dat ) or !istable( tab[ i2 ] ) or #tab[ i2 ] != 2 then
            num = 0
        else
            num = tonumber( tab[ i2 ][ 2 ] )
        end
    end
    if !isnumber( num ) then num = tonumber( num ) end
    if !isnumber( num ) or num != 1 then
        return false
    end
    return true
end
function xdefm_NadAllow( ply, ent )
    if !NADMOD or !IsValid( ply ) or !IsValid( ent ) then return false end
    return NADMOD.PlayerCanTouch( ply, ent )
end
function xdefm_SendSnd( ply, snd )
    if !IsValid( ply ) or !ply:IsPlayer() or !isstring( snd ) or snd == "" or snd == "!V" then return end
    net.Start( "NET_xdefm_SendSnd" )
    net.WriteString( snd )
    net.Send( ply )
end
function xdefm_NoTool( ent, inv )
    if !IsValid( ent ) then return end
    if isbool( inv ) and inv == true then
        ent.xdefm_NoTool = false
    else
        ent.xdefm_NoTool = true
    end
    if inv then
        ent:SetUnFreezable( false )
        if IsValid( ent:GetPhysicsObject() ) then
            ent:GetPhysicsObject():ClearGameFlag( FVPHYSICS_NO_PLAYER_PICKUP )
        end
        return
    end
    ent:SetUnFreezable( true )
    if IsValid( ent:GetPhysicsObject() ) then
        ent:GetPhysicsObject():AddGameFlag( FVPHYSICS_NO_PLAYER_PICKUP )
    end
end
function xdefm_ProfileLoad( ply )
    if !IsValid( ply ) or !ply:IsPlayer() or !isstring( ply:SteamID() ) or ply:IsBot() then return end
    local name = string.lower( string.Replace( ply:SteamID(), ":", "_" ) )
    if !file.IsDir( "xdefishmod", "DATA" ) then
        file.CreateDir( "xdefishmod" )
    end
    local path = ( "xdefishmod/p_"..name..".txt" )
    local pro = {}
    if !istable( ply.xdefm_Friends ) then
        xdefm_SetupFriends( ply )
    end
    if file.Exists( path, "DATA" ) then
        pro = util.JSONToTable( file.Read( path, "DATA" ) )
        if !pro.UpdG then pro.UpdG = 0 end

        for k, v in pairs( pro.Items ) do 
            if isstring( v ) and v != "_" and !xdefm.items[ xdefm_GetClass( v ) ] then -- this code should never run, but just in case...
                pro.Items[ k ] = ( k == 21 and "ba_junk" or "it_error" ) 
            end 
        end
        for k, v in pairs( pro.Bnk ) do 
            if isstring( v ) and v != "_" and !xdefm.items[ xdefm_GetClass( v ) ] then 
                pro.Bnk[ k ] = "it_error" 
            end 
        end
    else
        pro = {
            Level = 0,
            Money = 0,
            Exp = 0,
            Items = { "it_bait1","re_basic|25","_","_","_","_","_","_","_","_","_","_","_","_","_","_","_","_","_","_", "_" },
            UpdA = 0,
            UpdB = 0,
            UpdC = 0,
            UpdD = 0,
            UpdE = 0,
            UpdF = 0,
            UpdG = 0,
            Skp = 0,
            Bnk = {},
            TCatch = 0,
            TExp = 0,
            TEarn = 0,
            TBuy = 0,
            TCraft = 0,
            TQuest = 0,
        }
    end
    ply.xdefm_Profile = pro
    xdefm_ProfileUpdate( ply, pro )
end
function xdefm_ItemGive( ply, str, non )
    if !IsValid( ply ) or !isstring( str ) or !istable( ply.xdefm_Profile ) then return false end
    local aa, bb = xdefm_ItemGet( str )
    if !istable( aa ) or !istable( bb ) then return false end
    local inv = ply.xdefm_Profile.Items
    if !istable( inv ) then return false end
    if bb.Type == "Creature" and isnumber( bb.MinSize ) and isnumber( bb.MaxSize ) and ( !istable( aa ) or #aa < 2 or aa[ 2 ] == 0 ) then
        local siz = math.Round( math.Rand( bb.MinSize, bb.MaxSize ), 1 )  table.insert( aa, 2, siz ) str = table.concat( aa, "|" )
    elseif bb.Type == "Recipe" and isnumber( bb.Durability ) and ( !istable( aa ) or #aa < 2 or aa[ 2 ] == 0 ) then
        local dur = math.ceil( math.Rand( bb.Durability/2, bb.Durability ) )  table.insert( aa, 2, dur ) str = table.concat( aa, "|" )
    end aa, bb = xdefm_ItemGet( str )
    for k, v in pairs( inv ) do
        if v == "_" and ( k != 21 or bb.Type == "Bait" ) and ( bb.Type != "Bait" or k != 21 or bb.Level <= ply.xdefm_Profile.Level ) then
            ply.xdefm_Profile.Items[ k ] = str
            xdefm_ProfileUpdate( ply )
            local cls = xdefm_GetClass( str )
            net.Start( "NET_xdefm_BestiaryRecord" )
            net.WriteString( cls )
            net.Send( ply )
            if !isbool( non ) or non == false then
                xdefm_AddNote( ply, "xdefm.Pickup&: "..xdefm_ItemMark( str ), "items/ammo_pickup.wav", "basket_put", 5 )
            end
            return true
        end
    end
    xdefm_AddNote( ply, "xdefm.FullInv", "resource/warning.wav", "cross", 5 )
    return false
end
function xdefm_ItemSpawn( nam, pos, ang, own, mdl )
    if !isstring( nam ) or nam == "" or nam == "_" then return nil end
    if !isvector( pos ) then pos = Vector( 0, 0, 0 ) end
    if !isangle( ang ) then ang = Angle( 0, 0, 0 ) end
    local aa, bb = xdefm_ItemGet( nam )
    if !istable( aa ) or !istable( bb ) then return nil end
    local ent = ents.Create( "xdefm_base" )
    ent:SetPos( pos )
    ent:SetAngles( ang )
    ent:SetFMod_DT( tostring( nam ) )
    if isstring( mdl ) and util.IsValidModel( mdl ) then
        ent.xdefm_Mdl = mdl
    end
    if !IsValid( own ) or !own:IsPlayer() then
        own = Entity( 0 )
    else
        ent:SetFMod_OI( own:SteamID() )
        if NADMOD then
            NADMOD.PlayerMakePropOwner( own, ent )
        end
    end
    ent:SetNWEntity( "Owner", own )
    ent:SetFMod_OW( own )
    ent.Owner = own
    local hk = hook.Run( "XDEFM_ItemSpawn", ent, nam, own )
    if isbool( hk ) and hk == false then
        ent:Remove()
        return
    end
    ent:Spawn()
    ent:Activate()
    return ent
end
function xdefm_DummySpawn( nam, pos, ang, own, mdl )
    if !isstring( nam ) or nam == "" or nam == "_" then return nil end
    if !isvector( pos ) then pos = Vector( 0, 0, 0 ) end
    if !isangle( ang ) then ang = Angle( 0, 0, 0 ) end
    local aa, bb = xdefm_ItemGet( nam )
    if !istable( aa ) or !istable( bb ) then return nil end
    local ent = ents.Create( "xdefm_dummy" )
    ent:SetPos( pos )
    ent:SetAngles( ang )
    ent:SetFMod_DT( tostring( nam ) )
    if isstring( mdl ) and util.IsValidModel( mdl ) then
        ent:SetModel( mdl )
        ent.xdefm_Mdl = mdl
    else
        ent:SetModel( bb.Model[ math.random( #bb.Model ) ] )
    end
    if !IsValid( own ) or !own:IsPlayer() then
        own = Entity( 0 )
    else
        ent:SetFMod_OI( own:SteamID() )
    end
    local hk = hook.Run( "XDEFM_DummySpawn", ent, nam, own )
    if isbool( hk ) and hk == false then
        ent:Remove()
        return
    end
    ent:SetFMod_OW( own )
    ent.Owner = own
    ent:Spawn()
    ent:Activate()
    return ent
end
function xdefm_GiveExp( ply, amo )
    if !IsValid( ply ) or !istable( ply.xdefm_Profile ) or !isnumber( amo ) or amo <= 0 then return end
    amo = math.max( 0, math.Round( amo ) )
    local fex, lex = ply.xdefm_Profile.Exp, xdefm_LevelExp( ply.xdefm_Profile.Level )
    ply.xdefm_Profile.Exp = ply.xdefm_Profile.Exp + amo
    if ply.xdefm_Profile.Level >= 1000 then
        ply.xdefm_Profile.Exp = 0
        xdefm_ProfileUpdate( ply )
        ply.xdefm_Profile.TExp = ply.xdefm_Profile.TExp + amo
        return
    end
    if ply.xdefm_Profile.Exp >= lex then
        ply.xdefm_Profile.Exp = 0
        ply.xdefm_Profile.Level = ply.xdefm_Profile.Level + 1
        if ply.xdefm_Profile.Level <= 1000 then
            ply.xdefm_Profile.Skp = ply.xdefm_Profile.Skp + 1
        end
        xdefm_AddNote( ply, "xdefm.Uplevel", "garrysmod/save_load4.wav", "arrow_up", 5 )
        ply.xdefm_Profile.TExp = ply.xdefm_Profile.TExp +math.max( 0, lex -fex )
    else
        xdefm_SendSnd( ply, "garrysmod/content_downloaded.wav" )
        ply.xdefm_Profile.TExp = ply.xdefm_Profile.TExp + amo
    end
    xdefm_ProfileUpdate( ply )
end
function xdefm_GiveMoney( ply, amo, nor )
    if !IsValid( ply ) or !istable( ply.xdefm_Profile ) or !isnumber( amo ) or amo <= 0 then return end
    amo = math.max( 0, math.Round( amo ) )
    ply.xdefm_Profile.Money = ply.xdefm_Profile.Money +amo
    if !nor then
        ply.xdefm_Profile.TEarn = ply.xdefm_Profile.TEarn +amo
    end
    xdefm_ProfileUpdate( ply )
    xdefm_SendSnd( ply, "physics/metal/chain_impact_soft"..math.random( 1, 3 )..".wav" )
end
function xdefm_UpdateMenu( ply, typ, dat )
    if !IsValid( ply ) or !istable( ply.xdefm_Profile ) or !isnumber( typ ) or !istable( dat ) then return end
    net.Start( "NET_xdefm_MenuUpdate" )
    net.WriteFloat( math.Round( typ ) )
    net.WriteString( util.TableToJSON( dat ) )
    net.Send( ply )
end
function xdefm_CleanupRefund()
    if GetConVar( "xdefmod_refund" ):GetInt() <= 0 then return end
    xdefm.refund = {}
    for k, v in pairs( ents.FindByClass( "xdefm_base" ) ) do
        if !IsValid( v ) or !istable( v.xdefm_T2 ) or !isstring( v:GetFMod_OI() ) or v:GetFMod_OI() == "" or !v:GetFMod_DT() then continue end local id = v:GetFMod_OI() local pc = xdefm_GetPrice( v:GetFMod_DT() ) 
        if ( xdefm_ItemGet( v ) == "cr_seagull" or xdefm_ItemGet( v ) == "cr_crow" or xdefm_GetClass( v ) == "cr_seagull2" ) and !v.xdefm_Killed then continue end local aa, bb = xdefm_ItemGet( v )
        if istable( v.xdefm_T3 ) and !table.IsEmpty( v.xdefm_T3 ) then
            for m, n in pairs( v.xdefm_T3 ) do if isstring( n ) and n != "_" then pc = pc +xdefm_GetPrice( n ) end end
        end
        if !isnumber( xdefm.refund[ id ] ) then
            xdefm.refund[ id ] = pc
        else
            xdefm.refund[ id ] = xdefm.refund[ id ] +pc
        end
        v:Remove()
    end
    for k, v in pairs( xdefm.refund ) do
        if !isstring( k ) or !isnumber( v ) or v <= 0 then continue end
        local ply = player.GetBySteamID( k )
        if IsValid( ply ) and ply:IsPlayer() and !ply:IsBot() and istable( ply.xdefm_Profile ) then
            xdefm_AddNote( ply, "xdefm.CleanRefund&: "..v, "!V", "coins", 5 ) xdefm_GiveMoney( ply, v )
        else
            local fil = "xdefishmod/p_"..k..".txt"
            if !file.Exists( fil, "DATA" ) then return end
            local tab = util.JSONToTable( file.Read( fil, "DATA" ) )
            if !istable( tab ) then return end
            tab.Money = tonumber( math.Round( tab.Money ) ) +v
            file.Write( fil, util.TableToJSON( tab, true ) )
        end
    end
    xdefm.refund = nil
end
function xdefm_LootDrop( tab, ent )
    if !istable( tab ) then return nil end
    local ite, ttl, tax = "_", 0, {}
    for k, v in pairs( tab ) do
        if !isstring( k ) or !isnumber( v ) then continue end
        ttl = ttl +v
        tax[ ttl ] = k
    end
    if ttl < 1 then return end
    local ran = math.random( 1, math.ceil( ttl ) )
    for k, v in SortedPairs( tax ) do
        if ran <= k then
            ite = v
            break
        end
    end
    if IsEntity( ent ) and !IsUselessModel( ent:GetModel() ) then
        local cen = ent:OBBCenter()
        local aa, bb = ent:OBBMins()*0.5, ent:OBBMaxs()*0.5
        local ang = Angle( math.Rand( 0, 360 ), math.Rand( 0, 360 ), 0 )
        local xx, yy, zz = math.Rand( aa.x, bb.x ), math.Rand( aa.y, bb.y ), math.Rand( aa.z, bb.z )
        local own = Entity( 0 )
        if ent:GetClass() == "xdefm_base" then
            own = ent:GetFMod_OW()
        end
        local ite = xdefm_ItemSpawn( ite, ent:LocalToWorld( Vector( xx, yy, zz )/4 ), ang, own )
        if IsValid( ite ) then
            ite:SetFMod_OI( ent:GetFMod_OI() )
            return ite
        end
    end
    return ite
end
function xdefm_QuestRegister( lvl, ned, rew )
    if !isstring( ned ) or ned == "_" or ned == "" then return end
    if !isstring( rew ) or rew == "_" or rew == "" then return end
    lvl = isnumber( lvl ) and math.max( math.Round( lvl ), 0 ) or 0
    table.insert( xdefm.quests, { lvl, ned, rew } )
end
function xdefm_QuestPick( lvl, ply )
    if !isnumber( lvl ) then return nil end
    if table.IsEmpty( xdefm.quests ) then return nil end
    if lvl != -1 then local tab = {}
        for k, v in RandomPairs( xdefm.quests ) do
            if v[ 1 ] <= lvl then tab = v break end
        end
        if IsValid( ply ) and ply:IsPlayer() and !ply:IsBot() then
            net.Start( "NET_xdefm_Quest" )
            net.WriteString( util.TableToJSON( tab ) )
            net.Send( ply )
            ply.xdefm_Quest = tab
        end
        return tab
    elseif IsValid( ply ) and ply:IsPlayer() and !ply:IsBot() then
        net.Start( "NET_xdefm_Quest" )
        net.WriteString( util.TableToJSON( {} ) )
        net.Send( ply )
        ply.xdefm_Quest = {}
    end
    return nil
end

hook.Add( "PhysgunPickup", "xdefm_NoTool", function( ply, ent )
    if ent.xdefm_NoTool then return false end
    if ent:GetClass() == "xdefm_base" then
        local aa, bb = xdefm_ItemGet( ent:GetFMod_DT() )
        return bb.CanPhysgun and xdefm_NadAllow( ply, ent )
    end
end )
hook.Add( "CanProperty", "xdefm_NoTool", function( ply, property, ent )
    if ent.xdefm_NoTool then return false end
    if ent:GetClass() == "xdefm_base" then return false end
end )
hook.Add( "CanTool", "xdefm_NoTool", function( ply, tr, toolname, tool, button )
    if IsValid( tr.Entity ) and tr.Entity.xdefm_NoTool then return false end
    if IsValid( tr.Entity ) and tr.Entity:GetClass() == "xdefm_base" then return false end
end )
hook.Add( "AllowPlayerPickup", "xdefm_NoTool", function( ply, ent )
    if ent.xdefm_NoTool then return false end
end )
hook.Add( "GravGunPickupAllowed", "xdefm_NoTool", function( ply, ent )
    if ent.xdefm_NoTool then return false end
end )
hook.Add( "PlayerCanPickupWeapon", "xdefm_NoPickup", function( ply, wep )
    if IsValid( wep ) and isstring( wep:GetClass() ) then
        local st, ed = string.find( wep:GetClass():lower(), "weapon_xdefm_" )
        if st and ply:HasWeapon( wep:GetClass() ) then
            return false
        end
    end
end )
hook.Add( "Think", "xdefm_TK", function()
    for k, v in pairs( ents.FindByClass( "xdefm_base" ) ) do
        if !IsValid( v ) or !istable( v.xdefm_T2 ) then continue end
        if !v:IsPlayerHolding() and !constraint.FindConstraint( v, "Weld" ) and v:WaterLevel() > 0 and v.xdefm_T2.KillInWater then
            SafeRemoveEntity( v )
            local data = EffectData()
            data:SetOrigin( v:WorldSpaceCenter() )
            data:SetScale( math.Round( v:OBBMins():Distance( v:OBBMaxs() )*0.1, 2 ) )
            util.Effect( "watersplash", data )
        end
    end
    local tim = math.max( math.Round( GetConVar( "xdefmod_salecool" ):GetInt() ), 0 )*60
    local time = math.Round( os.time()/tim )*tim
    if tim > 0 and time != xdefm.miscs.SaleTime then
        xdefm.miscs.SaleTime = time
        xdefm_UpdateShop()
    end
    local ti2 = math.max( math.Round( GetConVar( "xdefmod_lbdelay" ):GetInt() ), 0 )*60
    time = math.Round( os.time()/ti2 )*ti2
    if !istable( xdefm.leader ) or ( ti2 > 0 and time != xdefm.miscs.LeadTime ) then
        xdefm.miscs.LeadTime = time
        if !timer.Exists( lbtimer ) then
            local fil, dir = file.Find( "xdefishmod/p_*.txt", "DATA" )
            if !istable( fil ) or #fil <= 0 then return end
            local cfr, cto, ctb = 0, #fil, {}
            timer.Create( lbtimer, 0, 0, function()
                for i=1, 5 do
                    cfr = cfr +1
                    local fin = fil[ cfr ]
                    if !isstring( fin ) then
                        local jso = util.TableToJSON( ctb, true )
                        file.Write( "xdefishmod/leaderboard.txt", jso )
                        xdefm.leader = ctb
                        net.Start( "NET_xdefm_Leaderboard" )
                        net.WriteString( jso )
                        net.Broadcast()
                        for k, v in pairs( player.GetAll() ) do
                            xdefm_UpdateMenu( v, 7, ctb )
                        end
                        timer.Remove( lbtimer )
                        break
                    end
                    local tab = util.JSONToTable( file.Read( "xdefishmod/"..fin, "DATA" ) )
                    if !istable( tab ) then continue end
                    if istable( ctb[ 10 ] ) and ctb[ 10 ][ 1 ] > tab.TExp then continue end
                    for m = 1, 10 do
                        local ttt = ctb[ m ]
                        if ( !istable( ttt ) or ttt[ 1 ] < tab.TExp ) and isstring( tab.SID64 ) then
                            table.insert( ctb, m, { tab.TExp, tab.SID64, tab.Nick, tab.Level, tab.Money } )
                            if #ctb > 10 then
                                table.remove( ctb, 11 )
                            end
                            break
                        end
                    end
                end
            end )
        end
    end
end )
hook.Add( "EntityTakeDamage", "xdefm_Hurt", function( tar, dmg )
    if IsValid( dmg:GetInflictor() ) and dmg:GetInflictor():GetNWBool( "XDEFM_HO" ) and IsValid( dmg:GetInflictor():GetOwner() ) then
        dmg:SetInflictor( dmg:GetInflictor():GetOwner() )
        if IsValid( dmg:GetInflictor():GetOwner() ) then
            dmg:SetAttacker( dmg:GetInflictor():GetOwner() )
        end
        if !tar:IsPlayer() and !tar:IsNPC() and !tar:IsNextBot() then return true end
    end
    local inf, atk = dmg:GetInflictor(), dmg:GetAttacker()
    if !IsValid( atk ) or GetConVar( "xdefmod_noprophurt" ):GetInt() <= 0 then return end
    if tar:GetClass() == "xdefm_base" then
        local aa, bb = xdefm_ItemGet( tar:GetFMod_DT() )
        if istable( bb ) and bb.Type == "Creature" then return end
    end
    if atk:IsPlayer() and tar:GetClass() == "xdefm_base" and !xdefm_FriendAllow( atk, tar:GetFMod_OI() ) and !xdefm_NadAllow( atk, tar ) then return true end
    if atk:GetClass() == "xdefm_base" and tar:IsPlayer() and !xdefm_FriendAllow( atk:GetFMod_OW(), tar:SteamID() ) and !xdefm_NadAllow( tar, atk ) then return true end
end )
hook.Add( "PreCleanupMap", "xdefm_Refund", function()
    xdefm_CleanupRefund()
end )
hook.Add( "ShutDown", "xdefm_Refund", function()
    if xdefm.miscs.ShutDown then return end
    xdefm.miscs.ShutDown = true
    xdefm_CleanupRefund()
end )
hook.Add( "OnPlayerPhysicsPickup", "xdefm_LastTake", function( ply, ent )
    if IsValid( ply ) and IsValid( ent ) and ent:GetClass() == "xdefm_base" then
        ent:SetFMod_LU( ply )
    end
end )
hook.Add( "OnPlayerPhysicsDrop", "xdefm_LastDrop", function( ply, ent, thr )
    if IsValid( ply ) and IsValid( ent ) and ent:GetClass() == "xdefm_base" then
        ent:SetFMod_LU( nil )
        if istable( ent.xdefm_T2 ) then
            ent.xdefm_T2:OnDrop( ent, ply, thr )
        end
    end
end )

net.Receive( "NET_xdefm_Cmd", function( len, ply )
    if !IsValid( ply ) or len > 512 then return end
    local cmd, dat = net.ReadString(), net.ReadString()
    if isstring( cmd ) and isstring( dat ) and cmd != "" and dat != "" then
        xdefm_Command( ply, cmd, dat )
    end
end )
net.Receive( "NET_xdefm_SendFriends", function( len, ply )
    if !IsValid( ply ) or len > 8192 then return end
    if isnumber( ply.xdefm_Cool ) and ply.xdefm_Cool > CurTime() then return end
    ply.xdefm_Cool = CurTime() +0.9
    local tab = {}
    if len > 0 then
        local str = net.ReadString()
        if !isstring( str ) or str == "" then return end
        tab = util.JSONToTable( str )
        if !istable( tab ) then return end
    else
        tab = ply.xdefm_Friends
    end
    xdefm_SetupFriends( ply, tab )
end )
net.Receive( "NET_xdefm_ConsoleCmd", function( len, ply )
    if !IsValid( ply ) or len > 1024 or len <= 0 then return end
    if isnumber( ply.xdefm_Cool ) and ply.xdefm_Cool > CurTime() then return end
    ply.xdefm_Cool = CurTime() +0.1
    local cmd, var = net.ReadString(), net.ReadString()
    local tab = util.JSONToTable( var )
    xdefm_ConsoleCmd( cmd, tab, ply )
end )
net.Receive( "NET_xdefm_Pickup", function( len, ply )
    if !IsValid( ply ) or len <= 0 or len >= 128 or !ply:Alive() then return end
    if isnumber( ply.xdefm_Cool ) and ply.xdefm_Cool > CurTime() then return end
    local pl2 = net.ReadEntity()  if pl2 != ply then return end ply.xdefm_Cool = CurTime()+0.1
    local ent = ply:GetEyeTrace().Entity
    if IsValid( ent ) and ent:GetClass() == "xdefm_base" and !ent:IsConstrained() and xdefm_CanInteract( ply, ent ) and !ent.xdefm_Trashed then
        ply.xdefm_Cool = CurTime() +0.1
        local aa, bb = xdefm_ItemGet( ent:GetFMod_DT() )
        if istable( aa ) and istable( bb ) then
            local own, owi = ent:GetFMod_OW(), ent:GetFMod_OI()
            if bb:OnStore( ent, ply ) == false then return end
            ply.xdefm_Cool = CurTime() +0.1
            if xdefm_FriendAllow( ply, owi ) or xdefm_NadAllow( ply, ent ) then
                if istable( ent.xdefm_T3 ) and !table.IsEmpty( ent.xdefm_T3 ) then local yee = false
                    for k, v in pairs( ent.xdefm_T3 ) do if isstring( v ) and v != "_" then
                            xdefm_AddNote( ply, xdefm_ItemMark( ent:GetFMod_DT() ).."& &xdefm.NotEmpty", "resource/warning.wav", "cross", 5 ) yee = true break
                        end
                    end
                    if yee then return end
                end
                local hk = hook.Run( "XDEFM_PlayerTake", ply, ent )
                if isbool( hk ) and hk == false then return end
                if bb.Carryable and ( GetConVar( "xdefmod_tempmode" ):GetInt() <= 0 or bb.Type == "Bait" or bb.Type == "Recipe" ) then
                    if xdefm_ItemGive( ply, ent:GetFMod_DT() ) then
                        ent.xdefm_Trashed = true
                        ent:Remove()
                    end
                else
                    ent.xdefm_Trashed = true
                    ent:Remove()
                    local prc = xdefm_GetPrice( ent )
                    net.Start( "NET_xdefm_BestiaryRecord" )
                    net.WriteString( xdefm_GetClass( ent ) )
                    net.Send( ply )
                    if prc > 0 then
                        xdefm_GiveMoney( ply, prc, true )
                        xdefm_AddNote( ply, "xdefm.GetMoney&: "..prc, "!V", "coins", 5 )
                    else
                        xdefm_AddNote( ply, "xdefm.Trashed&: "..xdefm_ItemMark( ent:GetFMod_DT() ), "physics/cardboard/cardboard_box_impact_bullet1.wav", "bin_empty", 5 )
                    end
                end
            else xdefm_AddNote( ply, "xdefm.NotMine", "resource/warning.wav", "cross", 5 ) end
        end
    end
end )
net.Receive( "NET_xdefm_NeedProfile", function( len, ply )
    if !IsValid( ply ) or len > 0 or istable( ply.xdefm_Profile ) then return end
    if isnumber( xdefm.skips[ ply:SteamID() ] ) then
        ply:SetNWFloat( "XDEFM_QC", CurTime() +GetConVar( "xdefmod_qsttime" ):GetInt()*60 )
        ply:SetNWBool( "XDEFM_QD", true )
    end
    xdefm_ProfileLoad( ply )
    ply.xdefm_Cool = 0
    local id = ply:SteamID()
    for k, v in pairs( ents.FindByClass( "xdefm_base" ) ) do
        if !IsValid( v ) then continue end
        if v:GetFMod_OI() == id then
            v:SetFMod_OW( ply )
        end
    end
end )