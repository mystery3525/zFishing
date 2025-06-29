local Zom = Material( "vgui/zoom" )
function xdefm_AddShop( nam, lvl, prc )
    if !isstring( nam ) then return end
    lvl = isnumber( lvl ) and math.max( 0, math.Round( lvl ) ) or 0
    prc = isnumber( prc ) and math.max( 0, math.Round( prc ) ) or 0
    local aa, bb = xdefm_ItemGet( nam )
    if !istable( bb ) or bb.Type != "Bait" then return end
    xdefm.shop[ nam ] = { 1, lvl, prc }
end
function xdefm_GetPrice( ite )
    if IsEntity( ite ) and ite:GetClass() == "xdefm_base" then
        ite = ite:GetFMod_DT()
    end
    if !isstring( ite ) or ite == "" or ite == "_" then return 0 end
    local aa, bb = xdefm_ItemGet( ite )
    if !istable( bb ) then return 0 end
    local prc = bb.Price
    if bb.Type == "Creature" and isnumber( tonumber( aa[ 2 ] ) ) then
        prc = math.ceil( prc*tonumber( aa[ 2 ] ) )
    end
    if bb.Type == "Bait" then
        return prc
    elseif bb.Type == "Recipe" then
        return isnumber( tonumber( aa[ 2 ] ) ) and math.ceil( prc*tonumber( aa[ 2 ] )/bb.Durability ) or prc
    else
        local cm = xdefm_CookMeter( ite )
        if cm != 0 then
            return cm > 0 and math.ceil( prc +prc*cm*4 ) or math.ceil( prc*math.abs( 1+ cm )*5 )
        else
            return prc
        end
    end
    return 0
end
function xdefm_GetClass( ite )
    if IsEntity( ite ) and ite:GetClass() == "xdefm_base" then
        ite = ite:GetFMod_DT()
    end
    local tb = string.Explode( "|", ite )
    if istable( tb ) and #tb > 1 then
        ite = tb[ 1 ]
    end
    if isstring(ite) then
        local prefix = string.Left(ite, 3)
        if !xdefm.items[ite] then
            if prefix == "it_" or prefix == "ba_" or prefix == "re_" or prefix == "cr_" then
                local ITEM = {
                    Type = "Common",
                    Model = "models/hunter/blocks/cube025x025x025.mdl",
                    Rarity = 1,
                    Price = 20000,
                    PhysSound = "citadel.br_no",
                    CantCook = true
                }
                
                xdefm_ItemRegister(ite, ITEM) -- this is for items that have been removed due to a compile error, without removing the item from inventory
            end
        end
    end
    return ite
end
function xdefm_ConsoleCmd( cmd, var, ply )
    if !isstring( cmd ) or cmd == "" or !istable( var ) or !IsValid( ply ) or !ply:IsPlayer() or ply:IsBot() then return end
    if CLIENT then
        net.Start( "NET_xdefm_ConsoleCmd" )
        net.WriteString( cmd )
        net.WriteString( util.TableToJSON( var ) )
        net.SendToServer()
    else
        if ply:IsSuperAdmin() and cmd == "xdefmod_note" then
            for k, v in pairs( player.GetAll() ) do
                xdefm_AddNote( v, table.concat( var, " " ), "ambient/levels/canals/windchime2.wav", "!V", 5 )
            end
        end
        if ply:IsSuperAdmin() and cmd == "xdefmod_collectall" then
            net.Start( "NET_xdefm_BestiaryAll" )
            net.WriteFloat( 1 )
            net.Send( ply )
        end
        if ply:IsSuperAdmin() and cmd == "xdefmod_collectclear" then
            net.Start( "NET_xdefm_BestiaryAll" )
            net.WriteFloat( 2 )
            net.Send( ply )
        end
        if ply:IsSuperAdmin() and cmd == "xdefmod_give" then
            local v = table.concat( var, "" )
            xdefm_ItemGive( ply, v )
        end
        if ply:IsSuperAdmin() and cmd == "xdefmod_spawn" and ply:CheckLimit( "xdefmod_items" ) then
            local v = table.concat( var, "" )
            local ite = xdefm_ItemSpawn( table.concat( var, "" ), ply:GetEyeTrace().HitPos, Angle( 0, ply:EyeAngles().yaw, 0 ), ply )
            if !IsValid( ite ) then return end
            ite:SetPos( ite:GetPos() +Vector( 0, 0, ite:OBBMaxs():Distance( ite:OBBMins() )/2 ) )
            local aa, bb = xdefm_ItemGet( ite:GetFMod_DT() )
            if !istable( aa ) or !istable( bb ) then return end
            undo.Create( bb.Name )
            undo.AddEntity( ite )
            undo.SetPlayer( ply )
            undo.Finish()
        end
        if ply:IsSuperAdmin() and cmd == "xdefmod_firespot" and ply:CheckLimit( "xdefmod_items" ) then
            local v = tonumber( table.concat( var, "" ) )
            if !isnumber( v ) then return end
            local spo = xdefm_FireSpot( ply:GetEyeTrace().HitPos +ply:GetEyeTrace().HitNormal, v, v )
            spo.Owner = ply
            spo:Spawn()
            spo:Activate()
            undo.Create( "#xdefm.FireSpot" )
            undo.AddEntity( spo )
            undo.SetPlayer( ply )
            undo.Finish()
            spo:SetFMod_Strength( v )
            spo:SetFMod_Enable( true )
        end
        if cmd == "xdefmod_openinv" then xdefm_OpenMenu( ply, 0, ply.xdefm_Profile ) end
        if cmd == "xdefmod_openbes" then xdefm_OpenMenu( ply, 8, ply.xdefm_Profile ) end
        if cmd == "xdefmod_openfri" then xdefm_OpenMenu( ply, 6, ply.xdefm_Friends ) end
        if cmd == "xdefmod_opentrd" then
            if !istable( ply.xdefm_Trade ) then
                ply.xdefm_Trade = {"_","_","_","_","_","_","_","_","_","_",0}
            end
            xdefm_OpenMenu( ply, 0, ply.xdefm_Profile )
            xdefm_OpenMenu( ply, 7, ply.xdefm_Trade )
        end
        if cmd == "xdefmod_openbnk" then
            xdefm_OpenMenu( ply, 0, ply.xdefm_Profile )
            xdefm_OpenMenu( ply, 5, ply.xdefm_Profile )
        end
        if cmd == "xdefmod_opencft" then
            xdefm_OpenMenu( ply, 0, ply.xdefm_Profile )
            xdefm_OpenMenu( ply, 9, ply.xdefm_Profile )
        end
        if cmd == "xdefmod_opendrp" then
            xdefm_OpenMenu( ply, 2, ply.xdefm_Profile )
        end
    end
end
function xdefm_LevelExp( lvl )
    if !isnumber( lvl ) then return 0 end
    return math.ceil( 100 +lvl^1.5 )
end
function xdefm_AddNote( ply, txt, snd, ico, dur )
    if CLIENT then
        ply = LocalPlayer()
        if isstring( snd ) and snd != "" and snd != "!V" then
            surface.PlaySound( snd )
        end
        dur = isnumber( dur ) and dur or 5
        if string.find( string.lower( txt ), "&" ) != nil then
            local tab = string.Explode( "&", txt )
            for k, v in pairs( tab ) do
                if v != "" and v != " " and string.find( string.lower( v ), "xdefm." ) != nil then
                    tab[ k ] = language.GetPhrase( v )
                end
            end
            txt = table.concat( tab, "" )
        elseif txt != "!V" and string.find( string.lower( txt ), "xdefm." ) then
            txt = language.GetPhrase( txt )
        end
        if !isstring( ico ) or ico == "" or ico == "!V" then
            ico = "information"
        end
        if GetConVar( "xdefmod_printnote" ):GetInt() > 0 then
            MsgC( Color( 255, 255, 255 ), "[", Color( 0, 255, 255 ), "xdefmod", Color( 255, 255, 255 ), "]"..txt.."\n" )
        end
        if txt != "!V" then
            table.insert( xdefm.miscs.Notes, { SysTime() +tonumber( string.Left( tostring( dur ), 4 ) ), txt, Material( "icon16/"..ico..".png" ), 0 } )
        end
    else
        if !isstring( txt ) or txt == "" then
            txt = "!V"
        end
        if !isstring( snd ) or snd == "" then
            snd = "!V"
        end
        if !isstring( ico ) or ico == "" then
            ico = "!V"
        end
        net.Start( "NET_xdefm_SendNote" )
        net.WriteString( txt )
        net.WriteString( snd )
        net.WriteFloat( dur )
        net.WriteString( ico )
        if ply:IsPlayer() then
            net.Send( ply )
        else
            net.Broadcast()
        end
    end
end
function xdefm_CookMeter( str )
    if IsEntity( str ) and str:GetClass() == "xdefm_base" then str = str:GetFMod_DT() end
    if !isstring( str ) or str == "" or str == "_" then return 0 end
    local aa, bb = xdefm_ItemGet( str )
    if !istable( aa ) or !istable( bb ) or bb.Type == "Bait" or bb.Type == "Recipe" then return 0 end
    local met = tonumber( aa[ #aa ] )
    if !isnumber( met ) or met == 0 then return 0 end
    local mex = math.ceil( bb.Rarity*100 )
    local me2 = math.ceil( mex*0.1 )
    if met <= mex then
        return math.Clamp( met/mex, 0, 1 )
    else
        return -math.Clamp( ( met-mex )/me2, 0, 1 )
    end
end
function xdefm_CookAdd( tar, met )
    if !IsEntity( tar ) and !isstring( tar ) or ( IsEntity( tar ) and tar:GetClass() != "xdefm_base" ) then return nil end
    if !isnumber( met ) then
        met = 0
    else
        met = math.max( 0, math.ceil( met ) )
    end
    if IsEntity( tar ) and SERVER then
        local str = tar:GetFMod_DT()
        if !isstring( str ) or str == "_" then return nil end
        local aa, bb = xdefm_ItemGet( str )
        if !istable( bb ) or bb.Type == "Bait" or bb.Type == "Recipe" or bb.CantCook then return nil end
        local med, mex = tonumber( aa[ #aa ] ), bb.Rarity*110
        if !isnumber( med ) or med >= mex then return end
        med = math.min( med +met, mex )
        if med >= mex and !tar:IsOnFire() then
            tar:Ignite( math.Rand( 3, 6 ) )
        end
        aa[ #aa ] = med
        tar:SetFMod_DT( table.concat( aa, "|" ) )
        return tar:GetFMod_DT()
    elseif isstring( tar ) then
        local aa, bb = xdefm_ItemGet( str )
        if !istable( bb ) or bb.Type == "Bait" or bb.CantCook then return nil end
        local med, mex = tonumber( aa[ #aa ] ), bb.Rarity*110
        if !isnumber( med ) or med >= mex then return nil end
        med = math.min( med +met, mex )
        aa[ #aa ] = med
        return table.concat( aa, "|" )
    end
end
function xdefm_CloseMenu( ply, str )
    if !isstring( str ) then return end
    if SERVER and IsValid( ply ) and ply:IsPlayer() and !ply:IsBot() then
        net.Start( "NET_xdefm_MenuClose" )
        net.WriteString( str )
        net.Send( ply )
        return
    end
    if CLIENT then if IsValid( xdefm.miscs.Menus[ str ] ) then xdefm.miscs.Menus[ str ]:Remove() end end
end
if SERVER then
    AddCSLuaFile("xdefishmod_rw/func/openmenu_sh.lua")
end
include("xdefishmod_rw/func/openmenu_sh.lua")
function xdefm_ProfileUpdate( ply, tab )
    if !IsValid( ply ) or !ply:IsPlayer() or !isstring( ply:SteamID() ) or ply:IsBot() then return end
    if !istable( tab ) then tab = ply.xdefm_Profile end
    if SERVER then
        tab.Nick = ply:Nick()
        tab.SID64 = ply:SteamID64()
        local dat = util.TableToJSON( tab, true )
        if !isstring( dat ) or dat == "" then
            tab = {
                Level = 0,
                Money = 0,
                Exp = 0,
                Items = { "it_bait1","_","_","_","_","_","_","_","_","_","_","_","_","_","_","_","_","_","_","_", "_" },
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
                TBuy = 0
            }
            tab.Nick = ply:Nick()
            tab.SID64 = ply:SteamID64()
            dat = util.TableToJSON( tab, true )
        end
        ply.xdefm_Profile = tab
        local name = string.lower( string.Replace( ply:SteamID(), ":", "_" ) )
        if !file.IsDir( "xdefishmod", "DATA" ) then
            file.CreateDir( "xdefishmod" )
        end
        file.Write( "xdefishmod/p_"..name..".txt", dat )
        net.Start( "NET_xdefm_Profile" )
        net.WriteString( util.TableToJSON( ply.xdefm_Profile ) )
        net.Send( ply )
        xdefm_UpdateMenu( ply, 0, ply.xdefm_Profile )
    end
end
function xdefm_GetUpValue( lvl, ele )
    if !isnumber( lvl ) or !isstring( ele ) then return nil end
    lvl = math.Clamp( math.Round( lvl ), 0, 100 )
    if ele == "A" then return 0.5 +lvl*0.025 end
    if ele == "B" then return 210 +lvl*90 end
    if ele == "C" then return 0.8 +lvl*0.192 end
    if ele == "D" then return 200 +lvl*50 end
    if ele == "E" then return lvl*0.01 end
    if ele == "F" then return 0 +lvl end
    if ele == "G" then return 1 +lvl end
    return nil
end
function xdefm_CanInteract( fr, to )
    if !IsValid( fr ) or !IsValid( to ) or !fr:IsPlayer() then return false end
    local siz = to:OBBMins():Distance( to:OBBMaxs() )
    return fr:WorldSpaceCenter():Distance( to:WorldSpaceCenter() ) <= math.max( 64, math.ceil( siz*1.5 ) )
end
function xdefm_ItemMark( str, aco )
    if !isstring( str ) or str == "" or str == "_" then return "" end
    local aa, bb = xdefm_ItemGet( str )
    if !istable( aa ) or !istable( bb ) then return "" end
    local ext = ""
    if bb.Type == "Creature" and aa[2] then
        ext = " (x"..aa[2]..")"
    end
    if bb.Type == "Recipe" and aa[2] then
        local per = math.Round( ( aa[2]/bb.Durability )*100 )
        ext = " ("..per.."%)"
    end
    local nam = bb.Name
    if CLIENT then
        nam = language.GetPhrase( nam )
    end
    if aco then
        return nam..ext
    else
        local col = xdefm.miscs.Rarity[ bb.Rarity+1 ]
        return "&<color="..col.r..","..col.g..","..col.b..">&"..nam.."&"..ext.."&</color>&"
    end
end

function xdefm_ItemRegisterAll(tbl)
    for i, v in pairs(tbl) do -- simple as that!
        v.Name   = "#xdefm."  .. i or "#xdefm.it_error"
        v.Helper = "#xdefm.d" .. i or "#xdefm.dit_error"
        if v.Based ~= nil and isstring( v.Based ) then
            for b, k in pairs(tbl[v.Based]) do -- items[v.Based] must be in the same file as it is local
                v[b] = v[b] or k
            end
        end
        xdefm_ItemRegister( i, v )
    end
end

function xdefm_ItemRegister( nam, dat )
    if !isstring( nam ) or nam == "" or nam == "_" or nam == "!V" or !istable( dat ) then return false end
    local inp = {}
    inp.Name 		= isstring( dat.Name ) and dat.Name or language.GetPhrase( "xdefm.BaseItem" ) --物品名称
    inp.Type 		= ( isstring( dat.Type ) and isnumber( xdefm.miscs.Types[ dat.Type ] ) ) and dat.Type or "Useless" --种类,参考xdefm.miscs.Types
    inp.Model 		= { "models/props_junk/popcan01a.mdl" } --模型,可用集合,注意图标只选择集合第一个模型,填入非模型路径会导致报错
    inp.Helper 		= isstring( dat.Helper ) and dat.Helper or "" --注释
    inp.Rarity 		= isnumber( dat.Rarity ) and math.Clamp( math.Round( dat.Rarity ), 1, 5 ) or 1 --稀有度,白绿蓝紫橙
    inp.Price 		= isnumber( dat.Price ) and math.max( math.Round( dat.Price ), 0 ) or 0 --价格,出售价格另算
    inp.Carryable 	= true  if isbool( dat.Carryable ) then inp.Carryable = dat.Carryable end --可放入背包
    inp.Secret 		= true  if isbool( dat.Secret ) then inp.Secret = dat.Secret end --设置此项使该物品无法用指令刷出
    inp.TickRate 	= isnumber( dat.TickRate ) and math.max( dat.TickRate, 0 ) or 60 --实体Think间隔(秒)
    inp.KillInWater = false  if isbool( dat.KillInWater ) then inp.KillInWater = dat.KillInWater end --入水消失,默认关闭
    inp.Constants 	= {}  if istable( dat.Constants ) then inp.Constants = dat.Constants end --常量集合
    inp.PhysSound	= isstring( dat.PhysSound ) and dat.PhysSound or nil --碰撞音效
    inp.CantCook	= isbool( dat.CantCook ) and dat.CantCook or nil --不允许该物品烹饪增值,用于炉子一类物品
    inp.CanPhysgun  = isbool( dat.CanPhysgun) and dat.CanPhysgun or false -- adds the ability to physgun certain items (like workbenches)
    if SERVER then
        inp.OnTouch = function( inp, ent, usr, typ ) end if isfunction( dat.OnTouch ) then inp.OnTouch = dat.OnTouch end --触摸,usr触碰实体,typ1开始,0持续,-1结束
        inp.OnUse = function( inp, ent, usr ) return true end if isfunction( dat.OnUse ) then inp.OnUse = dat.OnUse end --使用,return false来阻止捡起物品
        inp.OnThink = function( inp, ent ) end if isfunction( dat.OnThink ) then inp.OnThink = dat.OnThink end
        inp.OnCollide = function( inp, ent, dat ) end if isfunction( dat.OnCollide ) then inp.OnCollide = dat.OnCollide end --碰撞,dat数据
        inp.OnInit = function( inp, ent ) return false end if isfunction( dat.OnInit ) then inp.OnInit = dat.OnInit end --生成,于OnDrop后,return false取消默认实体设定
        inp.OnReady = function( inp, ent ) end if isfunction( dat.OnReady ) then inp.OnReady = dat.OnReady end --生成后0.1秒
        inp.OnDamaged = function( inp, ent, dmg ) return true end if isfunction( dat.OnDamaged ) then inp.OnDamaged = dat.OnDamaged end --受伤,return false不受伤害影响
        inp.OnDrop = function( inp, ent, usr, typ ) end if isfunction( dat.OnDrop ) then inp.OnDrop = dat.OnDrop end --按E捡起丢在地上或丢出,typ false为丢在地上,true为丢出
        inp.OnStore = function( inp, ent, usr ) return true end if isfunction( dat.OnStore ) then inp.OnStore = dat.OnStore end --R键存储,return false拒绝或inp.Carryable反选
        inp.OnPhysSimulate = function( inp, ent, phy, del ) end if isfunction( dat.OnPhysSimulate ) then inp.OnPhysSimulate = dat.OnPhysSimulate end --物理操控
        inp.OnRemove = function( inp, ent ) end if isfunction( dat.OnRemove ) then inp.OnRemove = dat.OnRemove end --删除
        inp.OnPlayerDrop = function( inp, ent ) end if isfunction( dat.OnPlayerDrop ) then inp.OnPlayerDrop = dat.OnPlayerDrop end --被玩家丢弃
        inp.OnCaught = function( inp, ent, ply ) end if isfunction( dat.OnCaught ) then inp.OnCaught = dat.OnCaught end --被钓出水面(钓鱼成功加经验时)
    else
        inp.OnDraw = function( inp, ent ) end if isfunction( dat.OnDraw ) then inp.OnDraw = dat.OnDraw end --实体渲染
        inp.HelperUse = "xdefm.U1"  if isstring( dat.HelperUse ) then inp.HelperUse = dat.HelperUse end --使用键注释,默认"捡起"
    end
    if isstring( dat.Model ) then inp.Model = { dat.Model } elseif istable( dat.Model ) and #dat.Model > 0 then inp.Model = dat.Model end local typ = dat.Type
    if typ == "Creature" then
        inp.MaxSize = ( isnumber( dat.MaxSize ) and math.max( math.Round( dat.MaxSize, 1 ), 0 ) or 1 ) --生物最高大小
        inp.MinSize = ( isnumber( dat.MinSize ) and math.max( math.Round( dat.MinSize, 1 ), 0 ) or 1 ) --生物最低大小
        if inp.MinSize > inp.MaxSize then inp.MinSize = inp.MaxSize end
    elseif typ == "Bait" then
        inp.Consume = ( isnumber( dat.Consume ) and math.max( dat.Consume, 0 ) or 0 ) --鱼饵消耗几率,数值越大越不容易被消耗,1为一次消耗,0为不消耗
        inp.Level = ( isnumber( dat.Level ) and math.Clamp( dat.Level, 0, 1000 ) or 0 ) --鱼饵等级限制
    elseif typ == "Recipe" then
        inp.Durability = ( isnumber( dat.Durability ) and math.max( math.Round( dat.Durability ), 1 ) or 1 ) --图纸能用几次
        if istable( dat.Crafts ) or isstring( dat.Crafts ) then inp.Crafts = dat.Crafts else return false end --图纸材料&产品,可填集合
        if isstring( inp.Crafts ) then inp.Crafts = { inp.Crafts } end for k, v in pairs( inp.Crafts ) do if !isstring( v ) then return false end
        local dec = string.Explode( "&", v ) if !istable( dec ) or #dec < 2 then return false end end
        --图纸格式:"材料A&材料B&材料C&产品",可填集合,产品为&分割开的最后一个物品,材料种类可重合,物品类别不做要求
        --注意生物大小不受限制,但烹饪后的物品无法参与制作
    elseif typ == "Structure" then
        inp.SType = isnumber( dat.SType ) and math.Clamp( math.Round( dat.SType ), 0, 3 ) or 0 --建筑类型,其他、存储、合成、商店
        if inp.SType == 1 then
            inp.Accepted = istable( dat.Accepted ) and dat.Accepted or nil --存储物品类型限制,留白为不限
            inp.Amount = isnumber( dat.Amount ) and math.max( 0, math.Round( dat.Amount ) ) or 0 --存储容量
        elseif inp.SType == 2 then
            if istable( dat.Crafts ) or isstring( dat.Crafts ) then inp.Crafts = dat.Crafts else return false end --合成格式同图纸,但是可以无限使用
            if isstring( inp.Crafts ) then inp.Crafts = { inp.Crafts } end for k, v in pairs( inp.Crafts ) do if !isstring( v ) then return false end
            local dec = string.Explode( "&", v ) if !istable( dec ) or #dec < 2 then return false end end
        elseif inp.SType == 3 then
            if istable( dat.Shop ) then inp.Shop = dat.Shop else return false end --物品&价格,可填集合,不会降价
            for k, v in pairs( inp.Shop ) do if !istable( v ) then return false end end
        end
        inp.OnInteract =  isfunction( dat.OnInteract ) and dat.OnInteract or nil --typ1,0,-1对应进入,互动,退出
        inp.StartSound = isstring( dat.StartSound ) and dat.StartSound or nil --开始使用音效
        inp.ExitSound  = isstring( dat.ExitSound ) and dat.ExitSound or nil --结束使用音效
    end
    nam = string.Replace( nam, " ", "_" )
    xdefm.items[ nam ] = inp
    return true
end
function xdefm_ItemBased( bas, nam, dat )
    if !isstring( nam ) or nam == "" or nam == "_" or !istable( dat ) or string.find( nam, "|" ) != nil or string.find( nam, "&" ) != nil then return false end
    local aa, bb = xdefm_ItemGet( bas )
    if !istable( bb ) then return false end
    local inp = {}
    for k, v in pairs( bb ) do
        inp[ k ] = ( dat[ k ] != nil and dat[ k ] or v )
    end
    if isstring( inp.Model ) then
        inp.Model = { inp.Model }
    end
    nam = string.Replace( nam, " ", "_" )
    xdefm.items[ nam ] = inp
    return true
end
function xdefm_ItemGet( dat )
    if IsEntity( dat ) and dat:GetClass() == "xdefm_base" then
        dat = dat:GetFMod_DT()
    end
    if !isstring( dat ) or dat == "" or dat == "_" then
        return nil, nil
    end
    local it1 = string.Explode( "|", dat )
    if istable( it1 ) then
        dat = xdefm_GetClass( dat )
    end
    local tab = xdefm.items[ dat ]
    if !istable( tab ) then
        return nil, nil
    end
    if !istable( it1 ) then
        it1 = { dat }
    end
    return it1, table.Inherit( tab, {} )
end
if SERVER then
    AddCSLuaFile("xdefishmod_rw/func/command_sh.lua")
end
include("xdefishmod_rw/func/command_sh.lua")
function xdefm_BreakEffect( ent, typ )
    if !IsEntity( ent ) or !isnumber( typ ) or ent == Entity( 0 ) then return end
    typ = math.max( 0, math.Round( typ ) )
    if SERVER then
        net.Start( "NET_xdefm_BreakEF" )
        net.WriteEntity( ent )
        net.WriteFloat( typ )
        net.Broadcast()
    else
        if !IsValid( ent ) then return end
        local pos = ent:GetPos()
        local aa, bb = ent:WorldSpaceAABB()
        local num = math.Clamp( math.Round( ent:BoundingRadius() / 8 ), 0, 32 )
        for i = 0, num do
            local ef = EffectData()
            ef:SetOrigin( Vector( math.Rand( aa.x, bb.x ), math.Rand( aa.y, bb.y ), math.Rand( aa.z, bb.z ) ) )
            ef:SetMagnitude( typ )
            util.Effect( "xdefm_gib", ef )
        end
    end
end
function xdefm_SetMoney( ply, amo, add )
    if !IsValid( ply ) or !istable( ply.xdefm_Profile ) then return end
    amo = isnumber( amo ) and math.Round( amo ) or 0
    if !isbool( add ) then
        add = true
    end
    local def = ply.xdefm_Profile.Money
    if !add then
        ply.xdefm_Profile.Money = amo
    else
        ply.xdefm_Profile.Money = def +amo
        if amo > 0 then
            ply.xdefm_Profile.Total = ply.xdefm_Profile.Total +amo
        end
    end
    xdefm_ProfileUpdate( ply )
end
function xdefm_BroadEffect( nam, dat )
    if !isstring( nam ) or !istable( dat ) then return end
    if SERVER then
        net.Start( "NET_xdefm_CLEffect" )
        net.WriteString( nam )
        net.WriteString( util.TableToJSON( dat ) )
        net.Broadcast()
    else
        local eff = EffectData()
        if isangle( dat.Angles ) then eff:SetAngles( dat.Angles ) end
        if isnumber( dat.Attachment ) then eff:SetAttachment( dat.Attachment ) end
        if isnumber( dat.Color ) then eff:SetColor( dat.Color ) end
        if isnumber( dat.DamageType ) then eff:SetDamageType( dat.DamageType ) end
        if isnumber( dat.EntIndex ) then eff:SetEntIndex( dat.EntIndex ) end
        if IsEntity( dat.Entity ) then eff:SetEntity( dat.Entity ) end
        if isnumber( dat.Flags ) then eff:SetFlags( dat.Flags ) end
        if isnumber( dat.HitBox ) then eff:SetHitBox( dat.HitBox ) end
        if isnumber( dat.Magnitude ) then eff:SetMagnitude( dat.Magnitude ) end
        if isnumber( dat.Scale ) then eff:SetScale( dat.Scale ) end
        if isnumber( dat.Radius ) then eff:SetRadius( dat.Radius ) end
        if isnumber( dat.MaterialIndex ) then eff:SetMaterialIndex( dat.MaterialIndex ) end
        if isvector( dat.Normal ) then eff:SetNormal( dat.Normal ) end
        if isvector( dat.Origin ) then eff:SetOrigin( dat.Origin ) end
        if isvector( dat.Start ) then eff:SetStart( dat.Start ) end
        if isnumber( dat.SurfaceProp ) then eff:SetSurfaceProp( dat.SurfaceProp ) end
        util.Effect( nam, eff )
    end
end

hook.Add( "StartCommand", "xdefm_Move", function( ply, cmd )
    if IsValid( ply ) and ply:Alive() and IsValid( ply:GetActiveWeapon() ) and ply:GetActiveWeapon():GetClass() == "weapon_xdefm_rod" then
        local wep = ply:GetActiveWeapon()
        if CLIENT and cmd:GetMouseWheel() != 0 then
            xdefm.miscs.LFOV = math.Clamp( xdefm.miscs.LFOV -cmd:GetMouseWheel()/10, 0.25, 5 )
        end
    end
    if SERVER and IsValid( ply ) then
        if IsValid( ply.xdefm_Struct ) and ply.xdefm_Struct:GetClass() == "xdefm_base" and ply:GetPos():Distance( ply.xdefm_Struct:GetPos() ) > 300 then local usi = ply.xdefm_Struct
            xdefm_CloseMenu( v, "Structure" )
        end
        if ply:GetNWFloat( "XDEFM_QC" ) > 0 and ply:GetNWFloat( "XDEFM_QC" ) <= CurTime() then
            ply:SetNWFloat( "XDEFM_QC", 0 ) ply:SetNWBool( "XDEFM_QD", false ) xdefm.skips[ ply:SteamID() ] = nil
        end
        local usi, usn = ply:GetNWEntity( "XDEFM_Using" ), ply.xdefm_Using
        local trd = ply:GetNWEntity( "XDEFMod_TPL" )
        if IsValid( trd ) and trd:IsPlayer() and trd:Alive() and trd:HasWeapon( "weapon_xdefm_trade" ) and trd:GetNWEntity( "XDEFMod_TPL" ) == ply and
        trd:WorldSpaceCenter():DistToSqr( ply:WorldSpaceCenter() ) < 70000 and ply:HasWeapon( "weapon_xdefm_trade" ) and !ply:GetNWBool( "XDEFMod_BTD" ) and !trd:GetNWBool( "XDEFMod_BTD" ) then
            if !ply.xdefm_HasTPL then
                ply.xdefm_HasTPL = true
                xdefm_UpdateMenu( ply, 6, { trd:Nick(), trd:SteamID64(), false } )
                xdefm_AddNote( ply, "xdefm.Trade15&"..trd:Nick().."&xdefm.Trade16", "garrysmod/content_downloaded.wav", "arrow_refresh", 5 )
                if !istable( ply.xdefm_Trade ) then ply.xdefm_Trade = { "_", "_", "_", "_", "_", "_", "_", "_", "_", "_", 0 } end
                if !istable( trd.xdefm_Trade ) then trd.xdefm_Trade = { "_", "_", "_", "_", "_", "_", "_", "_", "_", "_", 0 } end
                xdefm_UpdateMenu( ply, 5, trd.xdefm_Trade )
                xdefm_UpdateMenu( ply, 4, ply.xdefm_Trade )
            end
        elseif ply.xdefm_HasTPL then
            ply.xdefm_HasTPL = nil
            xdefm_UpdateMenu( ply, 6, { "_", nil, false } )
            ply:SetNWFloat( "XDEFMod_RTT", 2 )
        end
    end
end )
hook.Add( "CanTool", "xdefm_NoTool", function( ply, tr, toolname, tool, button )
    if IsValid( tr.Entity ) and ( tr.Entity:GetNWString( "xdefm_Data" ) != "" or string.find( tr.Entity:GetClass():lower(), "xdefm_" ) ) then
        return true
    end
end )
hook.Add( "PlayerButtonDown", "xdefm_QuickInv", function( ply, key )
    if ( CLIENT or game.SinglePlayer() ) and key == GetConVar( "xdefmod_quickinv" ):GetInt() then
        xdefm_ConsoleCmd( "xdefmod_openinv", {}, ply )
    end
end )