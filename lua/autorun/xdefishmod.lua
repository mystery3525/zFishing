--[[
	Fishing Mod by LemonCola3424(XDE).
	DO NOT REUPLOAD/MODIFY/COPY WITHOUT AUTHORS' PERMISSION.
	和蔼！任何邪恶，终将绳之以法！

	Fork by Flof and Autumn

--]]

local SVConvars = bit.bor( FCVAR_ARCHIVE, FCVAR_NOTIFY, FCVAR_REPLICATED, FCVAR_LUA_SERVER )
CreateConVar( "xdefmod_nodepth", "0", SVConvars, "", 0, 1 )
CreateConVar( "xdefmod_refund", "1", SVConvars, "", 0, 1 )
CreateConVar( "xdefmod_tempmode", "0", SVConvars, "", 0, 1 )
CreateConVar( "xdefmod_thief", "10", SVConvars, "", 0, 100 )
CreateConVar( "xdefmod_thiefnerf", "0", SVConvars, "", 0, 1 )
CreateConVar( "xdefmod_noprophurt", "1", SVConvars, "", 0, 1 )
CreateConVar( "xdefmod_hurtrod", "0", SVConvars, "", 0, 1 )
CreateConVar( "xdefmod_skpcool", "30", SVConvars, "", 0 )
CreateConVar( "xdefmod_salecool", "5", SVConvars, "", 0 )
CreateConVar( "xdefmod_qsttime", "10", SVConvars, "", 0 )
CreateConVar( "xdefmod_lbdelay", "10", SVConvars, "", 0 )
CreateConVar( "xdefmod_nomorehook", "0", SVConvars, "", 0, 1 )
CreateConVar( "xdefmod_darkrp", "0.05", SVConvars, "", 0.01, 10 )
CreateConVar( "sbox_maxxdefmod_items", "60", SVConvars )

CreateClientConVar( "xdefmod_tagdist", "256", true, false, "", -1 )
CreateClientConVar( "xdefmod_sonar", "1", true, false, "", 0, 1 )
CreateClientConVar( "xdefmod_renderdist", "2048", true, false, "", 0 )
CreateClientConVar( "xdefmod_animui", "1", true, false, "", 0, 1 )
CreateClientConVar( "xdefmod_showhook", "1", true, false, "", 0, 1 )
CreateClientConVar( "xdefmod_printnote", "0", true, false, "", 0, 1 )
CreateClientConVar( "xdefmod_printcmd", "0", true, false, "", 0, 1 )

CreateClientConVar( "xdefmod_drawhalo", "1", true, false, "", 0, 1 )
CreateClientConVar( "xdefmod_collect", "0", true, false, "", 0, 1 )
CreateClientConVar( "xdefmod_fastreel", "0", true, true, "", 0, 1 )
CreateClientConVar( "xdefmod_quickinv", "-1", true, false, "" )
CreateClientConVar( "xdefmod_fps", "0", true, false, "", 0, 1 )
CreateClientConVar( "xdefmod_collection", "11111111111", true, false, "" )
CreateClientConVar( "xdefmod_bgr", "28", true, false, "", 0, 255 )
CreateClientConVar( "xdefmod_bgg", "25", true, false, "", 0, 255 )
CreateClientConVar( "xdefmod_bgb", "72", true, false, "", 0, 255 )
CreateClientConVar( "xdefmod_bga", "255", true, false, "", 0, 255 )
CreateClientConVar( "xdefmod_brr", "0", true, false, "", 0, 255 )
CreateClientConVar( "xdefmod_brg", "206", true, false, "", 0, 255 )
CreateClientConVar( "xdefmod_brb", "209", true, false, "", 0, 255 )
CreateClientConVar( "xdefmod_bra", "255", true, false, "", 0, 255 )

if istable( xdefm ) and istable( xdefm.miscs ) and istable( xdefm.miscs.Menus ) then
	for k, v in pairs( xdefm.miscs.Menus ) do
		if v != nil then
			v:Remove()
		end
	end
end

xdefm = {}
xdefm.miscs = {}
xdefm.miscs.Version = "4.5.1"
xdefm.items = {}
xdefm.shop = {}
xdefm.leader = nil
xdefm.miscs.RodPos = Vector( -6, -2.5, 10 )
xdefm.miscs.RodAng = Angle( 0, 90, 135 )
xdefm.miscs.RiflePos = Vector( 22, -1, 0 )
xdefm.miscs.RifleAng = Angle( -20, 180, 180 )
xdefm.lin_col = Color( 0, 0, 0 )
xdefm.bck_col = Color( GetConVar( "xdefmod_bgr" ):GetInt(), GetConVar( "xdefmod_bgg" ):GetInt(), GetConVar( "xdefmod_bgb" ):GetInt(), GetConVar( "xdefmod_bga" ):GetInt() )
xdefm.ext_col = Color( GetConVar( "xdefmod_brr" ):GetInt(), GetConVar( "xdefmod_brg" ):GetInt(), GetConVar( "xdefmod_brb" ):GetInt(), GetConVar( "xdefmod_bra" ):GetInt() )

if true then --信息集锦
	xdefm.miscs.Rarity = {
		Color( 100, 100, 100 ),
		Color( 255, 255, 255 ),
		Color( 50, 205, 50 ),
		Color( 30, 144, 255 ),
		Color( 148, 0, 211 ),
		Color( 255, 215, 0 ),
	}
	xdefm.miscs.Rarit2 = {
		"xdefm.T0",
		"#xdefm.T1",
		"#xdefm.T2",
		"#xdefm.T3",
		"#xdefm.T4",
		"#xdefm.T5",
		"#xdefm.T6"
	}
	xdefm.miscs.Costs = {
		[ "A" ] = 1,
		[ "B" ] = 1,
		[ "C" ] = 1,
		[ "D" ] = 1,
		[ "E" ] = 1,
		[ "F" ] = 1,
		[ "G" ] = 20
	}
	xdefm.miscs.Types = {
		[ "Creature" ] = 3,
		[ "Bait" ] = 1,
		[ "Useless" ] = 2,
		[ "Recipe" ] = 2,
		[ "Structure" ] = 2,
	}
	xdefm.miscs.Icons = {
		[ "Creature" ] = Material( "icon16/monkey.png" ),
		[ "Bait" ] = Material( "icon16/bug.png" ),
		[ "Useless" ] = Material( "icon16/box.png" ),
		[ "Recipe" ] = Material( "icon16/script.png" ),
		[ "Structure" ] = Material( "icon16/building.png" )
	}
end
sound.Add( { name = "xdefm.ChargeMax", channel = CHAN_WEAPON, volume = 1, level = 75, pitch = 80, sound = ")weapons/shotgun/shotgun_empty.wav" } )
sound.Add( { name = "xdefm.UnReel", channel = CHAN_WEAPON, volume = 1, level = 75, pitch = { 95, 105 }, sound = ")weapons/crossbow/reload1.wav" } )
sound.Add( { name = "xdefm.Break", channel = CHAN_WEAPON, volume = 1, level = 75, pitch = 100, sound = "npc/roller/blade_in.wav" } )
sound.Add( { name = "xdefm.Throw", channel = CHAN_WEAPON, volume = 1, level = 75, pitch = 100, sound = { "npc/vort/claw_swing1.wav", "npc/vort/claw_swing2.wav" } } )
sound.Add( { name = "xdefm.Reel", channel = CHAN_WEAPON, volume = 1, level = 75, pitch = 100, sound = "fishingrod/reel.wav" } )
sound.Add( { name = "xdefm.Bite", channel = CHAN_WEAPON, volume = 1, level = 75, pitch = 100, sound = "weapons/slam/mine_mode.wav" } )

local SP_URS = "ulx/modules/urs_server.lua" --强行接口URS
if SERVER and file.Exists( SP_URS, "LUA" ) then
	include( SP_URS )
end
if istable( URS ) and URS.types then
	local tab = {}
	tab.limits = { "xdefmod_item" }
	table.Merge( URS.types, tab )
	if SERVER then
		for k, v in pairs( tab ) do
			if !URS[ k ] then
				URS[ k ] = {}
			end
			for n, m in pairs( v ) do
				if !URS[ k ][ m ] then
					URS[ k ][ m ] = {}
				end
			end
		end
	end
end

if SERVER then
	AddCSLuaFile("xdefishmod_rw/autorun_cl.lua")
end

if CLIENT then --客户端
	include("xdefishmod_rw/autorun_cl.lua")
end

if SERVER then --服务端
	include("xdefishmod_rw/autorun_sv.lua")
end

if SERVER or CLIENT then --通用端
	AddCSLuaFile("xdefishmod_rw/autorun_sh.lua")
	include("xdefishmod_rw/autorun_sh.lua")
end

concommand.Add( "xdefmod_note", function( ply, cmd, var ) xdefm_ConsoleCmd( cmd, var, ply ) end )
concommand.Add( "xdefmod_give", function( ply, cmd, var ) xdefm_ConsoleCmd( cmd, var, ply ) end )
concommand.Add( "xdefmod_spawn", function( ply, cmd, var ) xdefm_ConsoleCmd( cmd, var, ply ) end )
concommand.Add( "xdefmod_firespot", function( ply, cmd, var ) xdefm_ConsoleCmd( cmd, var, ply ) end )
concommand.Add( "xdefmod_count", function( ply, cmd, var ) local num = 0  for k, v in pairs( xdefm.items ) do num = num +1 end print( num ) end )
concommand.Add( "xdefmod_openinv", function( ply, cmd, var ) xdefm_ConsoleCmd( cmd, {}, ply ) end )
concommand.Add( "xdefmod_openbnk", function( ply, cmd, var ) xdefm_ConsoleCmd( cmd, {}, ply ) end )
concommand.Add( "xdefmod_openfri", function( ply, cmd, var ) xdefm_ConsoleCmd( cmd, {}, ply ) end )
concommand.Add( "xdefmod_opentrd", function( ply, cmd, var ) xdefm_ConsoleCmd( cmd, {}, ply ) end )
concommand.Add( "xdefmod_openbes", function( ply, cmd, var ) xdefm_ConsoleCmd( cmd, {}, ply ) end )
concommand.Add( "xdefmod_opencft", function( ply, cmd, var ) xdefm_ConsoleCmd( cmd, {}, ply ) end )
concommand.Add( "xdefmod_opendrp", function( ply, cmd, var ) xdefm_ConsoleCmd( cmd, {}, ply ) end )
concommand.Add( "xdefmod_collectall", function( ply, cmd, var ) xdefm_ConsoleCmd( cmd, {}, ply ) end, nil, nil, FCVAR_PROTECTED )
concommand.Add( "xdefmod_collectclear", function( ply, cmd, var ) xdefm_ConsoleCmd( cmd, {}, ply ) end, nil, nil, FCVAR_PROTECTED )
if CLIENT then -- xdefm_gib
	local Mats = { [ "1" ] = "wood", [ "2" ] = "glass", [ "3" ] = "metal", [ "4" ] = "concrete", [ "5" ] = "flesh" }
	local Gibs = {
		[ "1" ] = {
			"models/gibs/wood_gib01c.mdl", "models/gibs/wood_gib01d.mdl", "models/gibs/wood_gib01e.mdl",
		},
		[ "2" ] = {
			"models/gibs/glass_shard01.mdl", "models/gibs/glass_shard02.mdl", "models/gibs/glass_shard03.mdl",
			"models/gibs/glass_shard04.mdl", "models/gibs/glass_shard05.mdl", "models/gibs/glass_shard06.mdl"
		},
		[ "3" ] = {
			"models/gibs/metal_gib1.mdl", "models/gibs/metal_gib2.mdl", "models/gibs/metal_gib3.mdl",
			"models/gibs/metal_gib4.mdl", "models/gibs/metal_gib5.mdl"
		},
		[ "4" ] = {
			"models/props_debris/concrete_chunk09a.mdl", "models/props_debris/concrete_chunk03a.mdl"
		},
		[ "5" ] = {
			"models/gibs/antlion_gib_medium_2.mdl", "models/gibs/antlion_gib_small_2.mdl", "models/gibs/antlion_gib_small_1.mdl",
			"models/gibs/antlion_gib_medium_3.mdl", "models/gibs/antlion_gib_medium_1.mdl"
		},
	}
	local EFFECT = {}
	function EFFECT:Init( data )
		local Mag = data:GetMagnitude() if !istable( Gibs[ tostring( Mag ) ] ) then return end local gg = Gibs[ tostring( Mag ) ]
		self.Entity:SetModel( gg[ math.random( #gg ) ] ) self.Entity:PhysicsInit( SOLID_VPHYSICS ) self.Entity:SetRenderMode( RENDERMODE_TRANSCOLOR )
		self.Entity:SetCollisionGroup( COLLISION_GROUP_DEBRIS ) self.Entity:SetCollisionBounds( Vector( -128 -128, -128 ), Vector( 128, 128, 128 ) )
		self.Entity:SetModelScale( math.Rand( 0.5, 1 ) ) self.Entity:SetRenderMode( RENDERMODE_TRANSCOLOR )
		local phys = self.Entity:GetPhysicsObject()  if IsValid( phys ) then
			phys:Wake() phys:EnableMotion( true )
			phys:SetMaterial( Mats[ tostring( Mag ) ] )
			phys:SetAngles( Angle( math.Rand( 0, 360 ), math.Rand( 0, 360 ), math.Rand( 0, 360 ) ) )
			local vel = VectorRand():GetNormalized()*math.Rand( 50, 150 )  vel = Vector( vel.x, vel.y, math.abs( vel.z ) )
			phys:SetVelocity( vel ) phys:Wake()
		end if Mag == 5 then self.Entity:SetMaterial( "models/flesh" ) end
		self.LifeTime = CurTime() + math.Rand( 3, 5 )  self.LifeAlp = 255  self.xdefm_Allow = true
	end
	function EFFECT:PhysicsCollide( data, physobj ) end
	function EFFECT:Think() if !self.xdefm_Allow then return false end local own = self.Entity
		if self.LifeTime < CurTime() then  self.LifeAlp = Lerp( 0.05, self.LifeAlp, 0 )
			self.Entity:SetColor( Color( own:GetColor().r, own:GetColor().g, own:GetColor().b, self.LifeAlp ) )
			if self.LifeAlp <= 1 then return false end
		end return true
	end
	function EFFECT:Render() if self.xdefm_Allow then self.Entity:DrawModel() end end
	effects.Register( EFFECT, "xdefm_gib" ) end
if true then -- xdefm_base
	local ENT = {}  ENT.Base = "base_anim"  ENT.PrintName = ""  ENT.Spawnable = false  ENT.xdefm_Hold = {}
	ENT.RenderGroup = RENDERGROUP_BOTH  ENT.Owner = nil  ENT.xdefm_T1 = {}  ENT.xdefm_T2 = {}  ENT.xdefm_OnLook = false  ENT.xdefm_Cur = 0
	function ENT:SetupDataTables() self:NetworkVar( "Entity", 0, "FMod_OW" ) self:NetworkVar( "String", 0, "FMod_OI" )
	self:NetworkVar( "String", 1, "FMod_DT" ) self:NetworkVar( "Entity", 1, "FMod_LU" ) end
	function ENT:Initialize() if !SERVER then return end self:SetCollisionGroup( COLLISION_GROUP_NONE ) self:SetUseType( SIMPLE_USE )
		if !isstring( self:GetFMod_DT() ) or self:GetFMod_DT() == "" then self:Remove() return end
		local aa, bb = xdefm_ItemGet( self:GetFMod_DT() )  if !istable( aa ) or !istable( bb ) then self:Remove() return end
		self.xdefm_T1 = aa  self.xdefm_T2 = bb  local tab = string.Explode( "|", self:GetFMod_DT() )
		if bb.Type == "Creature" and isnumber( bb.MinSize ) and isnumber( bb.MaxSize ) and ( !istable( tab ) or #tab < 2 or tab[ 2 ] == 0 ) then
			local siz = math.Round( math.Rand( bb.MinSize, bb.MaxSize ), 1 ) if !istable( tab ) then tab = { self:GetFMod_DT() } end
			table.insert( tab, 2, siz ) self:SetFMod_DT( table.concat( tab, "|" ) )
		elseif bb.Type == "Recipe" and isnumber( bb.Durability ) and ( !istable( tab ) or #tab < 2 or tab[ 2 ] == 0 ) then
			local dur = math.ceil( math.Rand( bb.Durability/2, bb.Durability ) ) if !istable( tab ) then tab = { self:GetFMod_DT() } end
			table.insert( tab, 2, dur ) self:SetFMod_DT( table.concat( tab, "|" ) )
		elseif bb.Type == "Structure" and bb.SType == 1 and bb.Amount > 0 then self.xdefm_T3 = {}
			for i=1, bb.Amount do self.xdefm_T3[ i ] = "_" end
		end local tab = string.Explode( "|", self:GetFMod_DT() )
		if bb.Type != "Bait" and ( !istable( tab ) or #tab != xdefm.miscs.Types[ bb.Type ] ) then self:SetFMod_DT( self:GetFMod_DT().."|0" ) end
		if bb.Type == "Creature" and istable( tab ) and isnumber( tonumber( tab[ 2 ] ) ) then self:SetModelScale( tonumber( tab[ 2 ] ), 0.01 ) end
		if isstring( self.xdefm_Mdl ) then self:SetModel( self.xdefm_Mdl ) else
		self:SetModel( bb.Model[ math.random( #bb.Model ) ] ) end local ovrd = self.xdefm_T2:OnInit( self )
		if !ovrd then self:PhysicsInit( SOLID_VPHYSICS ) self:SetMoveType( MOVETYPE_VPHYSICS )
			self:SetRenderMode( RENDERMODE_TRANSCOLOR )  if IsValid( self:GetPhysicsObject() ) then self:GetPhysicsObject():Wake()
				self:GetPhysicsObject():AddGameFlag( FVPHYSICS_NO_IMPACT_DMG )
				self:GetPhysicsObject():AddGameFlag( FVPHYSICS_NO_NPC_IMPACT_DMG ) end
		end timer.Simple( 0.1, function() if IsValid( self ) then bb:OnReady( self ) end end ) self:Activate()
	end
	function ENT:HandleAnimEvent() return true end
	function ENT:OnRemove() if CLIENT or !istable( self.xdefm_T2 ) then return end self.xdefm_T2:OnRemove( self )
		if self.xdefm_T2.Type == "Structure" then
			for k, v in pairs( player.GetHumans() ) do if v.xdefm_Struct == self then xdefm_CloseMenu( v, "Structure" ) end end
		end
	end
	function ENT:OnDuplicated() SafeRemoveEntity( self ) end
	function ENT:OnRestore() if SERVER then SafeRemoveEntity( self ) end end
	function ENT:OnTakeDamage( dmg ) if !istable( self.xdefm_T2 ) or dmg:GetDamage() <= 0 then return end local aa, bb = xdefm_ItemGet( self:GetFMod_DT() )
		local yes = self.xdefm_T2:OnDamaged( self, dmg ) if !isbool( yes ) or yes == true then self:TakePhysicsDamage( dmg ) end
	end
	function ENT:TurnToDummy() if CLIENT then return nil end
		local dum = ents.Create( "xdefm_dummy" )  dum:SetModel( self:GetModel() )
		dum:SetAngles( self:GetAngles() ) dum:SetPos( self:GetPos() ) dum:SetFMod_DT( self:GetFMod_DT() ) dum:Spawn() dum:Activate()
		self.OnRemove = function() end dum:SetFMod_OW( self:GetFMod_OW() ) dum:SetFMod_OI( self:GetFMod_OI() )
		SafeRemoveEntity( self ) return dum
	end
	function ENT:Use( ent ) if !IsValid( ent ) or !istable( self.xdefm_T2 ) or !ent:IsPlayer() or ent:KeyDown( IN_RELOAD ) then return end local owi = self:GetFMod_OI()
		if self.xdefm_T2.Type ~= "Structure" or self.xdefm_T2.SType < 2 then
			if !xdefm_CanInteract( ent, self ) or ( !xdefm_FriendAllow( ent, owi ) and !xdefm_NadAllow( ent, self ) ) then return end
		end

		if self.xdefm_T2.Type == "Structure" and self.xdefm_T2.SType ~= 0 and !ent:IsBot() then
			local act = self.xdefm_T2.OnInteract and self.xdefm_T2:OnInteract( self, ent, 1 ) or nil
			if act == false or IsValid( ent.xdefm_Struct ) then return end 
			local ttt, dat = self.xdefm_T2.SType, {}
			if !ent:KeyDown( IN_SPEED ) then
				if ttt == 1 then 
					dat = { xdefm_GetClass( self ), unpack( self.xdefm_T3 ) } 
				else 
					dat = { xdefm_GetClass( self ) } 
				end
				xdefm_OpenMenu( ent, 0, ent.xdefm_Profile ) 
				xdefm_OpenMenu( ent, 4, dat ) 
				ent.xdefm_Struct = self
				if self.xdefm_T2.StartSound then self:EmitSound( self.xdefm_T2.StartSound ) end 
				if act != true then return end
			end
		end
		local use = self.xdefm_T2:OnUse( self, ent )  local typ = self.xdefm_T2.Type

		if ( !isbool( use ) or use != false ) and !ent:IsPlayerHolding() then
			if !constraint.FindConstraint( self, "Weld" ) and IsValid( self:GetPhysicsObject() ) and !self:IsPlayerHolding() 
			and self:GetPhysicsObject():IsMotionEnabled() and ( !ent.xdefm_Cool or ent.xdefm_Cool <= CurTime() ) then 
				ent:PickupObject( self ) 
			end
		end
	end
	function ENT:StartTouch( ent ) if !IsValid( ent ) or !istable( self.xdefm_T2 ) then return end local tab = self.xdefm_T2
		tab:OnTouch( self, ent, 1 )
	end
	function ENT:Touch( ent ) if !IsValid( ent ) or !istable( self.xdefm_T2 ) then return end
		if ent:GetClass() == "xdefm_base" and !xdefm_FriendAllow( ent:GetFMod_OW(), self:GetFMod_OI() ) and !xdefm_NadAllow( ent:GetFMod_OW(), self ) then return end
		self.xdefm_T2:OnTouch( self, ent, 0 )
	end
	function ENT:EndTouch( ent ) if !IsValid( ent ) or !istable( self.xdefm_T2 ) then return end
		self.xdefm_T2:OnTouch( self, ent, -1 )
	end
	function ENT:PhysicsCollide( dat, phy ) if !istable( self.xdefm_T2 ) or !IsValid( self:GetPhysicsObject() ) then return end
		local col = self.xdefm_T2:OnCollide( self, dat )  if isbool( col ) and col == false then return end
		if isstring( self.xdefm_T2.PhysSound ) and dat.Speed >= 60 and dat.DeltaTime > 0.2 then
			self:StopSound( self.xdefm_T2.PhysSound ) self:EmitSound( self.xdefm_T2.PhysSound )
		end
	end
	function ENT:PhysicsSimulate( phy, del ) if !istable( self.xdefm_T2 ) then return end
		self.xdefm_T2:OnPhysSimulate( self, phy, del )
	end
	function ENT:Think() if !istable( self.xdefm_T2 ) then return end
		if CLIENT then local ply = LocalPlayer()  self:NextThink( CurTime() +0.1 )  if !IsValid( ply ) then return end
			self:NextThink( CurTime() +0.1 )
			if self.xdefm_OnLook != self:BeingLookedAtByLocalPlayer() then
				self.xdefm_OnLook = self:BeingLookedAtByLocalPlayer()
				self.xdefm_Cur = SysTime() +0.25
			end
			local aa, bb = xdefm_ItemGet( self:GetFMod_DT() )
			if istable( bb ) and self.xdefm_OnLook or self.xdefm_Cur > SysTime() then
				local alp = math.Clamp( ( self.xdefm_Cur -SysTime() )/0.25, 0, 1 )
				if self.xdefm_OnLook then alp = 1-alp end
				local col = xdefm.miscs.Rarity[ bb.Rarity+1 ]
				halo.Add( { self }, Color( col.r, col.g, col.b, 255*alp ), 2*alp, 2*alp, 2*alp, true, true )
			end
		else self.xdefm_T2:OnThink( self ) self:NextThink( CurTime() +self.xdefm_T2.TickRate ) local tab = self.xdefm_T2 end
		return true
	end
	if CLIENT then local Mat = Material( "models/shiny" )
		function ENT:Draw() if isstring( self:GetFMod_DT() ) and self:GetFMod_DT() != "" and self:GetFMod_DT() != "_" then
			local aa, bb = xdefm_ItemGet( self:GetFMod_DT() ) if istable( bb ) then local dis = GetConVar( "xdefmod_renderdist" ):GetInt()
			local ply, wep = LocalPlayer(), LocalPlayer():GetActiveWeapon()
			if !IsValid( LocalPlayer() ) or dis <= 0 or LocalPlayer():GetPos():DistToSqr( self:GetPos() ) <= dis^2 then self:DrawModel()
			if bb.Type != "Bait" and !bb.CantCook then local me2, per = xdefm_CookMeter( self:GetFMod_DT() ), 0
				if me2 > 0 then render.SetColorModulation( 1, 1, 0 ) per = me2*0.4 elseif me2 < 0 then per = 0.4 +math.abs( me2 )*0.5
					local aaa = math.abs( 1 +me2 ) render.SetColorModulation( aaa, aaa, 0 )
				end if per > 0 then render.SetBlend( per ) render.MaterialOverride( Mat )
				self:DrawModel() render.SetBlend( 1 ) render.MaterialOverride() render.SetColorModulation( 1, 1, 1 ) end
			end bb:OnDraw( self ) end
		end end end
		function ENT:BeingLookedAtByLocalPlayer() local ply = LocalPlayer() if !IsValid( ply ) or !ply:Alive() then return false end
			local view = ply:GetViewEntity()  local dist = math.Clamp( math.ceil( GetConVar( "xdefmod_tagdist" ):GetInt() )^2, -1, 2147483647 )
			if view:IsPlayer() then return ( ( view:EyePos():DistToSqr( self:GetPos() ) <= dist or dist == -1 ) and view:GetEyeTrace().Entity == self ) end return false
		end
	end
	scripted_ents.Register( ENT, "xdefm_base" ) end
if true then -- xdefm_dummy
	local ENT = {}  ENT.Base = "base_anim"  ENT.PrintName = ""  ENT.Spawnable = false
	ENT.RenderGroup = RENDERGROUP_BOTH  ENT.Owner = nil  ENT.xdefm_T1 = {}  ENT.xdefm_T2 = {}
	function ENT:SetupDataTables() self:NetworkVar( "String", 1, "FMod_DT" ) self:NetworkVar( "String", 2, "FMod_OI" )
	self:NetworkVar( "Entity", 0, "FMod_OW" ) end
	function ENT:Initialize() if !SERVER then return end
		if !isstring( self:GetFMod_DT() ) or self:GetFMod_DT() == "" then self:Remove() return end
		local aa, bb = xdefm_ItemGet( self:GetFMod_DT() )  if !istable( aa ) or !istable( bb ) then self:Remove() return end
		self.xdefm_T1 = aa  self.xdefm_T2 = bb  local tab = string.Explode( "|", self:GetFMod_DT() )
		if bb.Type == "Creature" and isnumber( bb.MinSize ) and isnumber( bb.MaxSize ) and ( !istable( tab ) or #tab < 2 or tab[ 2 ] == 0 ) then
			local siz = math.Round( math.Rand( bb.MinSize, bb.MaxSize ), 1 ) if !istable( tab ) then tab = { self:GetFMod_DT() } end
			table.insert( tab, 2, siz ) self:SetFMod_DT( table.concat( tab, "|" ) )
		elseif bb.Type == "Recipe" and isnumber( bb.Durability ) and ( !istable( tab ) or #tab < 2 or tab[ 2 ] == 0 ) then
			local dur = math.ceil( math.Rand( bb.Durability/2, bb.Durability ) ) if !istable( tab ) then tab = { self:GetFMod_DT() } end
			table.insert( tab, 2, dur ) self:SetFMod_DT( table.concat( tab, "|" ) )
		elseif bb.Type == "Structure" and bb.SType == 1 and bb.Amount > 0 then self.xdefm_T3 = {}
			for i=1, bb.Amount do self.xdefm_T3[ i ] = "_" end
		end local tab = string.Explode( "|", self:GetFMod_DT() )
		if bb.Type != "Bait" and ( !istable( tab ) or #tab != xdefm.miscs.Types[ bb.Type ] ) then self:SetFMod_DT( self:GetFMod_DT().."|0" ) end
		if bb.Type == "Creature" and istable( tab ) and isnumber( tonumber( tab[ 2 ] ) ) then self:SetModelScale( tonumber( tab[ 2 ] ), 0.01 ) end
		self:SetNotSolid( true ) self:Activate()
	end
	function ENT:OnDuplicated() SafeRemoveEntity( self ) end
	function ENT:OnRestore() if SERVER then SafeRemoveEntity( self ) end end
	function ENT:Think() if CLIENT then return end if !istable( self.xdefm_T2 ) then self:Remove() return false end
		if !self:IsInWorld() then self:Remove() return false end self:NextThink( CurTime() +0.1 ) return true
	end
	function ENT:TurnToItem()
		local ite = xdefm_ItemSpawn( self:GetFMod_DT(), self:GetPos(), self:GetAngles(), own, self:GetModel() )
		if IsValid( ite ) then ite:SetFMod_OW( self:GetFMod_OW() ) ite:SetFMod_OI( self:GetFMod_OI() )
			if NADMOD and self:GetFMod_OW():IsPlayer() then NADMOD.PlayerMakePropOwner( self:GetFMod_OW(), ent ) end
			ite:SetNWEntity( "Owner", self:GetFMod_OW() )  ite.Owner = self:GetFMod_OW()
			self:Remove() return ite end self:Remove()
	end
	if CLIENT then local Mat = Material( "models/shiny" )
		function ENT:Draw() if isstring( self:GetFMod_DT() ) and self:GetFMod_DT() != "" and self:GetFMod_DT() != "_" then
			local aa, bb = xdefm_ItemGet( self:GetFMod_DT() ) if istable( bb ) then local dis = GetConVar( "xdefmod_renderdist" ):GetInt()
			local ply, wep = LocalPlayer(), LocalPlayer():GetActiveWeapon()  self:DrawModel()
			if !IsValid( LocalPlayer() ) or dis <= 0 or LocalPlayer():GetPos():DistToSqr( self:GetPos() ) <= dis^2 then
			if bb.Type != "Bait" and !bb.CantCook then local me2, per = xdefm_CookMeter( self:GetFMod_DT() ), 0
				if me2 > 0 then render.SetColorModulation( 1, 1, 0 ) per = me2*0.4 elseif me2 < 0 then per = 0.4 +math.abs( me2 )*0.5
					local aaa = math.abs( 1 +me2 ) render.SetColorModulation( aaa, aaa, 0 )
				end if per > 0 then render.SetBlend( per ) render.MaterialOverride( Mat )
				self:DrawModel() render.SetBlend( 1 ) render.MaterialOverride() render.SetColorModulation( 1, 1, 1 ) end
			end bb:OnDraw( self ) end
		end end end
		function ENT:BeingLookedAtByLocalPlayer() local ply = LocalPlayer() if !IsValid( ply ) or !ply:Alive() then return false end
			local view = ply:GetViewEntity()  local dist = math.Clamp( math.ceil( GetConVar( "xdefmod_tagdist" ):GetInt() )^2, -1, 2147483647 )
			if view:IsPlayer() then return ( ( view:EyePos():DistToSqr( self:GetPos() ) <= dist or dist == -1 ) and view:GetEyeTrace().Entity == self ) end return false
		end
	end
	scripted_ents.Register( ENT, "xdefm_dummy" ) end
if true then -- xdefm_firespot
	local ENT = {}  ENT.Base = "base_anim"  ENT.PrintName = ""  ENT.Spawnable = false
	ENT.RenderGroup = RENDERGROUP_TRANSLUCENT  ENT.xdefm_NextBurn = 0  ENT.xdefm_Power = -1
	function ENT:SetupDataTables() self:NetworkVar( "Bool", 0, "FMod_Enable" ) self:NetworkVar( "Float", 0, "FMod_Strength" ) end
	function ENT:Initialize() if !SERVER then return end self:SetModel( "models/hunter/plates/plate.mdl" )
		self:SetNotSolid( true ) self:SetFMod_Enable( false ) self:SetMoveType( MOVETYPE_NONE )
		self:DrawShadow( false ) self:SetFMod_Strength( 5 ) self:Activate()
	end
	function ENT:OnDuplicated() SafeRemoveEntity( self ) end
	function ENT:OnRestore() if SERVER then SafeRemoveEntity( self ) end end
	function ENT:OnTakeDamage( dmg ) end function ENT:Use( ent ) end
	function ENT:Think() if CLIENT or !self:GetFMod_Enable() then return end self:NextThink( CurTime() +0.1 )
		if self.xdefm_NextBurn <= CurTime() and self.xdefm_Power > 0 then self.xdefm_NextBurn = CurTime() +math.Rand( 0.1, 0.5 )
			local own = ( IsValid( self:GetParent() ) and self:GetParent() or Entity( 0 ) )
			local siz = math.Clamp( self:GetFMod_Strength(), 1, 100 )  local tr = util.TraceHull( {
				start = self:WorldSpaceCenter() +Vector( 0, 0, siz ), endpos = self:WorldSpaceCenter() +Vector( 0, 0, siz*3 ),
				filter = { own, self }, mask = MASK_SHOT, mins = Vector( -siz, -siz, -siz ), maxs = Vector( siz, siz, siz )
			} ) local ent = tr.Entity  if IsValid( ent ) and !ent:IsWorld() and util.IsValidModel( ent:GetModel() ) then
				if ent:GetClass() != "xdefm_base" or !istable( ent.xdefm_T2 ) or ent.xdefm_T2.Type == "Bait" or ent:Health() > 0 then
					local dmg = DamageInfo() dmg:SetDamage( self.xdefm_Power ) dmg:SetAttacker( Entity( 0 ) )
					dmg:SetInflictor( self ) dmg:SetDamageType( DMG_BURN ) local vel = VectorRand():GetNormalized()*1000
					dmg:SetDamageForce( Vector( vel.x, vel.y, 1000 ) ) dmg:SetDamagePosition( tr.HitPos ) ent:TakeDamageInfo( dmg )
				else xdefm_CookAdd( ent, self.xdefm_Power ) end
			end
		end
	end
	if CLIENT then
		ENT.xdefm_Emitter = nil  ENT.xdefm_NextEmit = 0
		local Mat = Material( "sprites/light_glow02_add" ) Mat:SetInt( "$ignorez", 1 )  local Mat2 = Material( "debug/debugwireframevertexcolor" )
		function ENT:Draw() self:SetRenderBounds( Vector( -256, -256, -256 ), Vector( 256, 256, 256 ) ) self:DrawShadow( false )
			local dis = GetConVar( "xdefmod_renderdist" ):GetInt()
			if !( !IsValid( LocalPlayer() ) or dis <= 0 or LocalPlayer():GetPos():DistToSqr( self:GetPos() ) <= dis^2 ) then return end
			if GetConVar( "developer" ):GetInt() > 0 then
				cam.IgnoreZ( true ) render.SetMaterial( Mat2 )
				render.DrawBox( self:GetPos(), self:GetAngles(), self:OBBMins(), self:OBBMaxs(), Color( 255, 255, 0 ) )
				render.DrawBox( self:GetPos(), self:GetAngles(), self:OBBMaxs(), self:OBBMins(), Color( 255, 255, 0 ) )
				cam.IgnoreZ( false )
			end
			if self.xdefm_Emitter == nil then self.xdefm_Emitter = ParticleEmitter( self:WorldSpaceCenter() ) end
			if self.xdefm_Emitter != nil and self:GetFMod_Enable() and self:GetFMod_Strength() > 0 then
				local siz, emt = math.Clamp( self:GetFMod_Strength(), 1, 100 ), self.xdefm_Emitter
				local own = ( IsValid( self:GetParent() ) and self:GetParent() or Entity( 0 ) )
				if GetConVar( "developer" ):GetInt() > 0 then
					local tr = util.TraceHull( {
						start = self:WorldSpaceCenter() +Vector( 0, 0, siz ), endpos = self:WorldSpaceCenter() +Vector( 0, 0, siz +siz*2 ),
						filter = { own, self }, mask = MASK_SHOT, mins = Vector( -siz, -siz, -siz ), maxs = Vector( siz, siz, siz )
					} )
					cam.IgnoreZ( true ) render.SetMaterial( Mat2 ) local pos = tr.HitPos
					local col = ( tr.Hit and Color( 255, 0, 0 ) or Color( 255, 255, 0 ) )
					render.DrawBox( pos, Angle(0,0,0), Vector(-siz,-siz,-siz), Vector(siz,siz,siz), col )
					render.DrawBox( pos, Angle(0,0,0), Vector(-siz,-siz,siz), Vector(siz,siz,-siz), col )
					cam.IgnoreZ( false )
				end
				render.SetMaterial( Mat ) local sss = siz*7 +math.sin( CurTime()*20 )*siz*2
				render.DrawSprite( self:WorldSpaceCenter(), sss, sss, Color( 255, 155, 0, 255 ) )
				if self.xdefm_NextEmit > CurTime() then return end self.xdefm_NextEmit = CurTime() +0.05
				local particle = emt:Add( "effects/fire_cloud"..math.random( 1, 2 ), self:WorldSpaceCenter() )
				particle:SetLifeTime( 0 )
				particle:SetDieTime( math.Rand( 0.75, 1.5 ) )
				particle:SetStartAlpha( 255 )
				particle:SetEndAlpha( 0 )
				local Size = math.Rand( siz*0.8, siz*1.2 )
				particle:SetStartSize( Size )
				particle:SetEndSize( 0.1 )		
				particle:SetRoll( math.random( 0, 360 ) )
				particle:SetAirResistance( 200 )
				particle:SetGravity( VectorRand():GetNormalized()*siz*2 +Vector( 0, 0, siz*math.Rand( 12, 20 ) ) )
				particle:SetColor( 255, math.random( 200, 255 ), math.random( 200, 255 ) )
				particle:SetCollide( false )
				particle:SetBounce( 0 )
				particle:SetLighting( false )
				local particle = emt:Add( "particle/smokesprites_000"..math.random( 1, 9 ), self:WorldSpaceCenter() +VectorRand():GetNormal()*siz/2 )
				particle:SetLifeTime( 0 )
				particle:SetDieTime( math.Rand( 1, 1.5 ) )
				particle:SetStartAlpha( 128 )
				particle:SetEndAlpha( 0 )
				local Size = math.Rand( siz*0.8, siz*1.6 )
				particle:SetStartSize( 0 )
				particle:SetEndSize( Size )		
				particle:SetRoll( math.random( 0, 360 ) )
				particle:SetRollDelta( math.Rand( -3, 3 ) )
				particle:SetAirResistance( 200 )
				particle:SetGravity( VectorRand():GetNormalized()*siz*4 +Vector( 0, 0, siz*20 ) )
				particle:SetColor( 128, 128, 128 )
				particle:SetCollide( false )
				particle:SetBounce( 0 )
				particle:SetLighting( false )
			end
		end
	end
	scripted_ents.Register( ENT, "xdefm_firespot" ) end
local fil, dir = file.Find( "xdefishmod/*.lua", "LUA" ) if !fil or !dir then return end
for _, out in pairs( fil ) do if SERVER then AddCSLuaFile( "xdefishmod/"..out ) end include( "xdefishmod/"..out ) end
if SERVER then xdefm_UpdateShop() end
