if CLIENT then local langs = {}
	langs[ "zh-CN" ] = {
		[ "it_wood3" ] 		= "精木板", [ "dit_wood3" ] 		= "",
		[ "it_metal3" ] 	= "合金板", [ "dit_metal3" ] 		= "",
		[ "it_plastic2" ] 	= "高级塑料板", [ "dit_plastic2" ] 	= "",
       	 	[ "it_part" ] 		= "金属部件", [ "dit_part" ] 		= "",
        	[ "it_part2" ] 		= "高级金属部件", [ "dit_part2" ] 	= "",
        	[ "it_coffee" ] 	= "咖啡机", [ "dit_coffee" ] 		= "放入一瓶水,一包种子和一节电池制作一杯咖啡(图纸).",
        	[ "it_meat" ] 		= "肉", [ "dit_meat" ] 			= "吃吃吃吃.",
        	[ "it_bone" ] 		= "骨头", [ "dit_bone" ] 		= "哈人.",
		[ "it_rainbow" ] 	= "彩虹石", [ "dit_rainbow" ] 		= "<color=0,0,255>★</color><color=255,0,255>★</color><color=0,255,0>★</color><color=255,255,0>★</color><color=255,0,0>★</color><color=255,255,255>★</color>.",
		[ "it_crafting1" ] 	= "工作台", [ "dit_crafting1" ] 		= "用于制作基础物品.",
		[ "it_crafting2" ] 	= "机械台", [ "dit_crafting2" ] 		= "用于制作高级物品.",
		[ "it_recycler" ]	= "洗衣机", [ "dit_recycler" ]     	= "清理垃圾",
		[ "it_storage1" ] 	= "储藏箱", [ "dit_storage1" ] 		= "可以存放12个物品.",
		[ "it_storage2" ] 	= "大储藏箱", [ "dit_storage2" ] 	= "可以存放30个物品.",
		[ "it_bucket" ]     	= "储物桶",  ["dit_bucket"]         	= "可以存放6个物品.",
		[ "it_error" ] 		= "被删除物品", [ "dit_error" ] 		= "拿点鱼币做补偿吧.",
		[ "it_furnace2" ] 	= "金属熔炉", [ "dit_furnace2" ] 	= "高级矿石冶炼.",
		[ "it_cquest" ] 	= "联合军终端", [ "dit_cquest" ] 	= "上交珍贵物品以获得奖励.",
		[ "it_pshop" ] 		= "未知传送门", [ "dit_pshop" ] 		= "可以购买一些稀有物品.",
		[ "it_bouncy" ] 	= "弹力球", [ "dit_bouncy" ] 		= "弹性超好的球.",
	}
	langs[ "en" ] = {
		[ "it_wood3" ] 		= "Wooden Plate", [ "dit_wood3" ] 		= "",
		[ "it_metal3" ] 	= "Metal Plate", [ "dit_metal3" ] 		= "",
		[ "it_plastic2" ] 	= "Advanced Plastic Plate", [ "dit_plastic2" ] 	= "",
        	[ "it_part" ] 		= "Metal Part", [ "dit_part" ] 			= "",
        	[ "it_part2" ] 		= "Advanced Metal Part", [ "dit_part2" ] 	= "",
			[ "it_part3" ] 		= "Flux Transducer Part", [ "dit_part3" ] 	= "A bundle of random sensors in a bar",
		[ "it_coffee" ] 	= "Coffee Machine", [ "dit_coffee" ] 		= "Insert a Water Bottle, a Seed Bag, and a Battery to make Coffee (recipe).",
        	[ "it_meat" ] 		= "Meat", [ "dit_meat" ] 			= "Meaty meat.",
        	[ "it_bone" ] 		= "Bone", [ "dit_bone" ] 			= "Dinner?",
		[ "it_rainbow" ] 	= "Rainbow Gem", [ "dit_rainbow" ] 		= "<color=0,0,255>★</color><color=255,0,255>★</color><color=0,255,0>★</color><color=255,255,0>★</color><color=255,0,0>★</color><color=255,255,255>★</color>.",
		[ "it_crafting1" ] 	= "Inventor's Table", [ "dit_crafting1" ] 	= "Craft Basic items.",
		[ "it_crafting2" ] 	= "Machinist's Table", [ "dit_crafting2" ] 	= "Craft Advanced items.",
		[ "it_recycler" ]	= "Washing Machine", [ "dit_recycler" ]     	= "Cleans Junk",
		[ "it_storage1" ] 	= "Storage Crate", [ "dit_storage1" ] 		= "Can hold up to 12 items.",
		[ "it_storage2" ] 	= "Big Storage Crate", [ "dit_storage2" ] 	= "Can hold up to 30 items.",
		[ "it_storage3" ] 	= "Storage Locker", [ "dit_storage3" ] 	= "The future is now! Stores 45 items.",
		[ "it_bucket" ]     	= "Storage Bucket", ["dit_bucket"]          	= "Can hold up to 6 items.",
		[ "it_error" ] 		= "Compile Error", [ "dit_error" ] 		= "Have no fear, keep this item safe until it is readded... or sell it.",
		[ "it_furnace2" ] 	= "Metal Furnace", [ "dit_furnace2" ] 		= "Advanced ore smelting.",
		[ "it_cquest" ] 	= "Combine Terminal", [ "dit_cquest" ] 		= "Turn in valuable items for rewards.",
		
		[ "it_pshop" ] 		= "Mysterious Portal", [ "dit_pshop" ] 		= "Buy valuable items.",
		[ "it_bouncy" ] 	= "Bouncy Ball", [ "dit_bouncy" ] 		= "Super bouncy.",
		[ "it_charcoal" ]   = "Charcoal", [ "dit_charcoal" ] = "Produced from burning coal or wood. Cheaper steel this way!",
		[ "it_boiler" ] = "Steam Boiler", [ "dit_boiler" ] = "Turns flameables into charcoal and water into steam.",
		[ "it_pump" ] = "Water Pump", [ "dit_pump" ] = "Pumps water using electricity or a battery",
		[ "it_turbine" ] = "Steam Turbine", [ "dit_turbine" ] = "Turns steam into electricity.",
		[ "it_relay" ] = "Power Relay", [ "dit_relay" ] = "Wireless power managemet, because nobody could afford the wires",
		[ "it_battery" ] = "Battery", [ "dit_battery" ] = "Stores 1kW of power.",
		[ "it_flask" ]   = "Steam Flask", [ "dit_flask" ] = "Stores 1000 steam. psi? tons? idk.",
		[ "it_furnace3" ] = "Electric Furnace", [ "dit_furnace3" ] = "Furnace that runs on electricity."
    }
	local ln = GetConVar( "gmod_language" ):GetString()  local lg = "en"
	if ln != nil and istable( langs[ ln ] ) then lg = GetConVar( "gmod_language" ):GetString() end
	for holder, text in pairs( langs[ lg ] ) do language.Add( "xdefm."..holder, text ) end

end

langs = nil
items = {}

items.it_wood3 = {
	Type = "Rare",
	Model = "models/props_phx/construct/wood/wood_panel1x1.mdl",
	Rarity = 3,
	Price = 750,
	PhysSound = "Wood.ImpactHard"
	}


items.it_metal3 = {
	Type = "Rare",
	Model = "models/props_phx/construct/metal_plate1.mdl",
	Rarity = 3,
	Price = 820,
	PhysSound = "EpicMetal.ImpactHard"
	}


items.it_plastic2 = {
	Type = "Rare",
	Model = "models/hunter/plates/plate1x1.mdl",
	Rarity = 3,
	Price = 500,
	PhysSound = "Plastic_Barrel.ImpactHard"
	}


items.it_part = {
	Type = "Uncommon",
	Model = "models/props_c17/utilityconnecter006.mdl",
	Rarity = 2,
	Price = 500,
	PhysSound = "SolidMetal.ImpactSoft"
	}


items.it_part2 = {
	Type = "Rare",
	Model = "models/props_c17/utilityconducter001.mdl",
	Rarity = 3,
	Price = 3000,
	PhysSound = "SolidMetal.ImpactHard"
	}

items.it_part3 = {
	Type = "Rare",
	Model = "models/props_lab/tpplugholder.mdl",
	Rarity = 4,
	Price = 4500,
	PhysSound = "SolidMetal.ImpactHard"
	}


items.it_coffee = {
	Type = "Structure",
	Model = "models/props_unique/coffeemachine01.mdl",
	Rarity = 4,
	Price = 2650,
	TickRate = 1,
	PhysSound = "Computer.ImpactHard",
	HelperUse = "xdefm.U3",
	SType = 2,
	StartSound = "Buttons.snd4",
	ExitSound = "NPC.ButtonLatchUnlocked2",
	CanPhysgun = true
	}
   	items.it_coffee.Crafts = {
		"it_water&ba_seed&it_armor&re_exp",
		"it_water&ba_seed&it_health&re_exp"
 		}


items.it_meat = {
	Type = "Uncommon",
	Model = "models/tysn/tysn_birdmeat_1.mdl",
	Rarity = 2,
	Price = 500,
	PhysSound = "Watermelon.Impact",
	HelperUse = "xdefm.U2"
	}
	function items.it_meat:OnInit( self ) self.xdefm_Killed = false end
	function items.it_meat:OnUse( self, ent ) if self.xdefm_Used then return end if ent:Health() >= ent:GetMaxHealth() then return true end
		if ent:KeyDown( IN_SPEED ) then return true end local met = xdefm_CookMeter( self:GetFMod_DT() )
		if met >= 0 then ent:SetHealth( math.min( ent:GetMaxHealth(), ent:Health() +math.ceil( 20*( 1 +met*9 ) ) ) ) end
		ent:EmitSound( "NPC_Barnacle.FinalBite" ) self:Remove() self.xdefm_Used = true return false
	end


items.it_bone = {
	Type = "Common",
	Model = {
		"models/gibs/hgibs_spine.mdl", "models/gibs/hgibs_rib.mdl",
		"models/gibs/hgibs_scapula.mdl"
		},
	Rarity = 1,
	Price = 10,
	PhysSound = "Body.ImpactSoft"
	}


items.it_rainbow = {
	Type = "Exotic",
	Model = "models/oc_diving/diamond.mdl",
	Rarity = 5,
	Price = 100000,
	PhysSound = "Weapon_StunStick.Melee_HitWorld",
	TickRate = 0.01
	}
	local Mat = Material( "effects/blueflare1" )
	function items.it_rainbow:OnThink( self ) self:SetColor( HSVToColor( ( CurTime()*100 ), 1, 1 ) ) end
	function items.it_rainbow:OnDraw( self ) render.SetMaterial( Mat ) local siz, col = 36 +math.sin( CurTime()*2 )*8, self:GetColor()
		render.DrawSprite( self:WorldSpaceCenter(), siz, siz, col )
        if ( !isnumber( self.xdefm_Pa1 ) or self.xdefm_Pa1 <= CurTime() ) then self.xdefm_Pa1 = CurTime() +0.05
			if !self.Emit or !IsValid( self.Emit ) then self.Emit = ParticleEmitter( self:WorldSpaceCenter() )
				self:CallOnRemove( "XDEEmitter", function( self ) if self.Emit then self.Emit:Finish() end end )
			else
				local particle = self.Emit:Add( "particle/particle_glow_03_additive", self:WorldSpaceCenter() +VectorRand():GetNormalized()*math.random( 0, 4 ) )
				particle:SetVelocity( VectorRand():GetNormalized()*32 +Vector( 0, 0, 48 ) )
				particle:SetColor( col.r, col.g, col.b )
				particle:SetDieTime( math.Rand( 1, 2 ) )
				particle:SetStartAlpha( 255 )
				particle:SetEndAlpha( 0 )
				particle:SetStartSize( 2 )
				particle:SetStartLength( 4 )
				particle:SetEndLength( 4 )
				particle:SetEndSize( 0 )
				particle:SetGravity( Vector( 0, 0, -128 ) )
				particle:SetCollide( true )
				particle:SetBounce( 1 )
			end
			if !isnumber( self.xdefm_Pa2 ) or self.xdefm_Pa2 <= CurTime() then self.xdefm_Pa2 = CurTime() +1
				if !self.xdefm_Emi2 or !IsValid( self.xdefm_Emi2 ) then
					self.xdefm_Emi2 = ParticleEmitter( self:WorldSpaceCenter(), true )
					self:CallOnRemove( "XDEEmitter2", function( self ) if self.Emi2 then self.Emi2:Finish() end end )
				else
					local particle = self.xdefm_Emi2:Add( "particle/particle_ring_wave_addnofog", self:WorldSpaceCenter() )
					particle:SetAngles( Angle( 90, 0, 0 ) )
					particle:SetColor( col.r, col.g, col.b )
					particle:SetDieTime( 2 )
					particle:SetStartAlpha( 192 )
					particle:SetEndAlpha( 0 )
					particle:SetStartSize( 0 )
					particle:SetEndSize( 16 )
					particle:SetPos( self:WorldSpaceCenter() -self:GetUp()*12 )
					particle:SetThinkFunction( function( particle )
						if IsValid( self ) then particle:SetPos( self:WorldSpaceCenter() ) end
						particle:SetNextThink( CurTime() )
					end ) particle:SetNextThink( CurTime() )
				end
			end
		end
	end


items.it_error = {
	Type = "Common",
	Model = "models/hunter/blocks/cube025x025x025.mdl",
	Rarity = 1,
	Price = 20000,
	PhysSound = "citadel.br_no",
	CantCook = true
	}


items.it_crafting1 = {
	Type = "Structure",
	Model = "models/props_forest/table_shed.mdl",
	StartSound = "DoorHandles.Locked2",
	ExitSound = "DoorSound.DefaultLocked",
	Rarity = 3,
	Price = 1000,
	PhysSound = "Wood.ImpactHard",
	SType = 2,
	HelperUse = "xdefm.U3",
	CanPhysgun = true
	}
    items.it_crafting1.Crafts = {
		"it_wood&it_wood&it_wood&it_wood2",
		"it_metal&it_metal&it_metal&it_metal2",
		"it_glass&it_glass&it_glass&it_glass2",
        "it_stone&it_stone&it_stone&it_brick",
		"it_junk&it_junk&it_junk&it_plastic",
		"it_metal&it_copperbar&it_steelbar&it_part",
		"it_wood&it_stone&it_ore&it_chemical",
		"it_metal2&it_coal&it_propane",
		"it_wood&it_stone&it_stone&it_campfire",
		"it_metal2&it_armor&it_stove1",
		"it_wood2&it_furniture1",
		"it_metal2&it_furniture2",
		"it_coal&it_metal&it_pipebomb",
		"it_copperbar&it_glass2&it_armor",
		"it_melon&it_plastic&it_health",
		"it_metal2&it_metal2&it_cage",
		"it_copperbar&it_brick&it_brick&st_furnace",
		"it_paper&it_coal&ba_money",
		"it_stone&it_wood&it_melon&ba_seed",
		"it_metal&it_metal&it_metal&ba_wrench",
		"it_metal2&ba_hook",
		"it_metal2&ba_pan",
		"it_wood2&it_plastic&ba_bread",
		"it_brick&it_brick&ba_skull",
		"it_plastic&it_plastic&ba_box",
		"it_rottenmeat&it_rottenmeat&it_rottenmeat&ba_fish",
		"it_glass2&it_glass2&it_copperbar&ba_lamp",
		"it_metal2&it_steelbar&ba_pickaxe",
		"it_metal2&it_metal2&it_bucket"
   	 	}


items.it_crafting2 = {
	Type = "Structure",
	Model = "models/props_waterfront/tattoo_table.mdl",
	StartSound = "DoorHandles.Unlocked2",
	ExitSound = "Doors.FullClose1",
	Rarity = 4,
	Price = 2500,
	PhysSound = "Metal_Box.ImpactHard",
	SType = 2,
	HelperUse = "xdefm.U3",
	CanPhysgun = true
	}
   	items.it_crafting2.Crafts = {
		"it_wood2&it_wood2&it_wood2&it_wood3",
		"it_brick&it_brick&it_brick&it_brick&it_stone2",
		"it_metal2&it_metal2&it_copperbar&it_metal3",
		"it_plastic&it_glass2&it_plastic&it_barre1&it_plastic2",
		"it_metal2&it_metal2&it_glass2&it_glass3",
		"it_metal2&it_silverbar&it_tungstenbar&it_part2",
		"it_tungstenbar&it_metal2&it_plastic&it_pmetal",
		"it_steelbar&it_metal2&it_glass3&it_cmetal",
		"it_propane&it_steelbar&it_stove3",
		"it_health&it_metal2&it_chealth",
		"it_armor&it_metal2&it_carmor",
		"it_coal&it_leadbar&it_grenade",
		"it_coal&it_tungstenbar&it_flashbang",
		"it_health&it_armor&it_refill",
		"it_chealth&it_carmor&it_csuper",
		"it_glass3&it_copperbar&it_antibird",
		"it_mine1&it_metal2&it_coal&it_mine2",
		"it_leadbar&it_firearm1&it_metal2&it_firearm2",
		"it_leadbar&it_steelbar&it_metal2&it_grinder",
		"it_part&it_metal3&st_printer",
		"it_part&it_propane&it_copperbar&re_furn1|20",
		"it_rottenmeat&it_rottenmeat&it_hula&it_bugs&ba_teddy",
		"it_leadbar&it_metal2&ba_bomb",
		"ba_fish&ba_fish&ba_fish&ba_fish&ba_meat",
		"it_steelbar&it_glass3&ba_c4",
		"it_armor&it_steelbar&it_metal3&ba_drill",
    		}


items.it_recycler = {
	Type = "Structure",
	Model = "models/props_c17/FurnitureWashingmachine001a.mdl",
	StartSound = "DoorHandles.Unlocked2",
	ExitSound = "Doors.FullClose1",
	Rarity = 4,
	Price = 3000,
	PhysSound = "Metal_Box.ImpactHard",
	SType = 2,
	HelperUse = "xdefm.U3",
	CanPhysgun = true
	}
	items.it_recycler.Crafts = {
	"it_junk&it_junk&it_junk&it_junk&it_wood",
	"it_junk&it_junk&it_junk&it_junk&it_glass",
	"it_junk&it_junk&it_junk&it_junk&it_stone",
	"it_junk&it_junk&it_junk&it_junk&it_metal"
	}


items.it_storage1 = {
	Type = "Structure",
	Model = "models/props_junk/wood_crate001a.mdl",
	Amount = 12,
	StartSound = "AmmoCrate.Open",
	ExitSound = "AmmoCrate.Close",
	Rarity = 3,
	Price = 1000,
	PhysSound = "Wood.ImpactHard",
	SType = 1,
	HelperUse = "xdefm.U3",
	CanPhysgun = true
	}
	function items.it_storage1:OnInit( self ) self:SetSkin( 1 ) end


items.it_storage2 = {
	Type = "Structure",
	Model = "models/props_junk/wood_crate002a.mdl",
	Amount = 30,
	StartSound = "AmmoCrate.Open",
	ExitSound = "AmmoCrate.Close",
	Rarity = 4,
	Price = 4500,
	PhysSound = "Wood.ImpactHard",
	SType = 1,
	HelperUse = "xdefm.U3",
	CanPhysgun = true
	}
	function items.it_storage2:OnInit( self ) self:SetSkin( 1 ) end

items.it_storage3 = {
	Type = "Structure",
	Model = "models/props_wasteland/controlroom_storagecloset001a.mdl",
	Amount = 45,
	StartSound = "DoorHandles.Unlocked2",
	ExitSound = "Doors.FullClose1",
	Rarity = 4,
	Price = 6500,
	PhysSound = "Metal_Box.ImpactHard",
	SType = 1,
	HelperUse = "xdefm.U3",
	CanPhysgun = true
	}
	function items.it_storage3:OnInit( self ) self:SetSkin( 1 ) end

items.it_bucket = { 
	Type = "Structure", 
	Model = "models/props_junk/MetalBucket01a.mdl", 
	Amount = 6, 
	StartSound = "Metal_Box.ImpactSoft", 
	ExitSound = "MetalGrate.ImpactSoft",
	Rarity = 2, 
	Price = 500, 
	PhysSound = "MetalVent.ImpactHard",
	SType = 1, 
	HelperUse = "xdefm.U3",
	CanPhysgun = true 
}


items.it_furnace2 = {
	Type = "Structure",
	Model = "models/props/cs_militia/furnace01.mdl",
	StartSound = "Metal_Barrel.ImpactSoft",
	ExitSound = "Metal_Barrel.ImpactHard",
	Rarity = 4,
	Price = 3000,
	PhysSound = "EpicMetal.ImpactSoft",
	HelperUse = "xdefm.U3",
	SType = 2,
	CanPhysgun = true
	}
	items.it_furnace2.Crafts = {
		"it_wood&it_wood&it_wood&it_coal",
		"it_ore&it_ore&it_coal&it_copperbar",
		"it_metal&it_metal&it_coal&it_metal2",
		"it_scrap&it_scrap&it_coal&it_steelbar",
		"it_ejunk&it_ejunk&it_coal&it_tungstenbar",
		"it_coin&it_coin&it_coal&it_silverbar",
		"it_pottery&it_pottery&it_coal&it_potter1",
		"it_potter1&it_potter1&it_coal&it_potter2",
		"it_potter2&it_potter2&it_coal&it_potter3",
		"it_oreblue&it_oreblue&it_coal&it_gemblue",
		"it_orepurple&it_orepurple&it_coal&it_gempurple",
 		"it_oregreen&it_oregreen&it_coal&it_gemgreen",
		"it_orered&it_orered&it_coal&it_gemred",
		"it_orewhite&it_orewhite&it_coal&it_gemwhite",
		"it_copperbar&it_steelbar&it_tungstenbar&it_silverbar&it_goldbar&it_platinumbar&it_rainbowbar",
		"it_gemblue&it_gempurple&it_gemgreen&it_gemred&it_gemwhite&it_rainbow",
	}


items.it_cquest = {
	Type = "Structure",
	Model = "models/props_combine/breenconsole.mdl",
	Rarity = 5,
	Price = 5000,
	PhysSound = "Computer.ImpactHard",
	HelperUse = "xdefm.U3",
	SType = 2,
	StartSound = "Weapon_AR2.Reload_Rotate",
	ExitSound = "Weapon_AR2.Reload_Push",
	CanPhysgun = true
	}
	items.it_cquest.Crafts = {
		"it_bait3&it_bait3&it_exp3&it_bag4",
		"it_coin2&it_coin2&it_coin2&it_coin2&it_bag4",
		"it_goldbar&it_orewhite&it_goldbar&it_bag4",
		"it_pturre2&it_cturret&it_pturre1&it_bag4",
		"it_gemblue&it_gempurple&it_gemgreen&it_gemred&it_bag4",
		"it_gballoom&it_defib&it_bag4",
		"it_torch&it_figurine&it_cosmogram&it_bag4",
		"cr_pigeon&cr_pigeon&cr_pigeon&cr_pigeon&it_bag4",
		"it_treasure&it_treasure&it_coin2&it_bag4",
		"it_ammocan1&it_ammocan1&it_ammocan1&it_crate3&it_bag4",
		}


items.it_plate = { --What are you?
	Type = "Structure",
	Model = "models/props_collectables/piepan.mdl",
	Amount = 1,
	StartSound = "GlassBottle.ImpactSoft",
	ExitSound = "GlassBottle.ImpactHard",
	Helper = "#xdefm.Plate2",
	Rarity = 2,
	Price = 100,
	PhysSound = "GlassBottle.ImpactHard",
	SType = 1,
	HelperUse = "xdefm.U3",
	TickRate = 0.1
	}
	function items.it_plate:OnInit( self ) self.xdefm_Dummy = nil end
	function items.it_plate:OnInteract( self, ent, typ )
		if typ == -1 then local cls = self.xdefm_T3[ 1 ]
			if isstring( cls ) and cls != "_" then
			if IsValid( self.xdefm_Dummy ) then self.xdefm_Dummy:Remove() end
			local ite = xdefm_DummySpawn( cls, self:GetPos(), self:GetAngles(), self:GetFMod_OW() )
			if IsValid( ite ) then ite:SetPos( self:WorldSpaceCenter() +self:GetUp()*8 ) ite:SetParent( self ) self.xdefm_Dummy = ite end end
		end
	end
	function items.it_plate:OnThink( self ) if IsValid( self.xdefm_Dummy ) then self.xdefm_Dummy:SetAngles( self:LocalToWorldAngles( Angle( 0, CurTime()*10, 0 ) ) ) end end


items.it_pshop = {
	Type = "Structure",
	Model = "models/props_lab/teleplatform.mdl",
	Rarity = 5,
	Price = 7500,
	PhysSound = "EpicMetal_Heavy.ImpactHard",
	HelperUse = "xdefm.U3",
	SType = 3,
	StartSound = "Weapon_PhysCannon.Charge",
	ExitSound = "Weapon_PhysCannon.Drop",
	CanPhysgun = true
	}
	local Ma2 = Material( "effects/exit1" )
	items.it_pshop.Shop = {
		[ "it_recipe1" ] = { 1500, 25 },
		[ "it_recipe2" ] = { 3750, 25 },
		[ "it_stove3" ] = { 3750, 25 },
		[ "re_toolbox|10" ] = { 1000, 25 },
		[ "it_antibird" ] = { 2500, 25 },
		[ "it_part2" ] = { 15000, 25 },
		[ "it_flower" ] = { 2000, 25 },
		[ "it_recipe3" ] = { 6000, 25 },
		[ "it_pturre1" ] = { 11250, 25 },
		[ "it_cturret" ] = { 9000, 25 },
		[ "it_bust" ] = { 18000, 25 },
		[ "it_tesla" ] = { 20000, 25 }
		}
	if CLIENT then -- xdefm_beam
	local EFFECT = {}
		function EFFECT:Init( data )
			self.StartPos = data:GetStart()
			self.EndPos = data:GetOrigin()
			self.Parts = {}  self.Part2 = {}
			self.Size = math.Rand( 8, 16 )
			local par = math.random( 8, 12 )
			for i=0, par-1 do
				table.insert( self.Parts, self.StartPos +( self.EndPos -self.StartPos )*( i/par ) +VectorRand():GetNormalized() )
			end
			self:SetRenderBoundsWS( self.StartPos, self.EndPos )
			self.MaxLife = math.Rand( 0.5, 1 )
			self.Life = SysTime() +self.MaxLife
		end
		function EFFECT:Think() return self.Life > SysTime() end
		local Mat = Material( "sprites/rollermine_shock" )
		function EFFECT:Render()
			local per = math.Clamp( ( self.Life -SysTime() )/self.MaxLife, 0, 1 )
			render.SetMaterial( Mat )
			render.StartBeam( #self.Parts )
				for i=1, #self.Parts do
					self.Parts[ i ] = self.Parts[ i ] +( i == 1 and Vector( 0, 0, 0 ) or ( Vector( 0, 0, 0.1 ) +VectorRand():GetNormalized() ) )
					render.AddBeam( self.Parts[ i ], self.Size*per*( 1 -i/#self.Parts )*per, 2, Color( 255*per, 255*per, 0*per ) )
				end
			render.EndBeam()
		end
		effects.Register( EFFECT, "xdefm_beam" )
	end
	function items.it_pshop:OnDraw( self ) render.SetMaterial( Ma2 ) local siz, col = 72 +math.sin( CurTime()*2 )*8, self:GetColor()
		render.DrawSprite( self:WorldSpaceCenter(), siz, siz, col )
        if ( !isnumber( self.xdefm_Pa1 ) or self.xdefm_Pa1 <= CurTime() ) then self.xdefm_Pa1 = CurTime() +math.Rand( 0.1, 0.3 )
			local ef = EffectData()  ef:SetStart( self:WorldSpaceCenter() )
			ef:SetOrigin( util.QuickTrace( self:WorldSpaceCenter(), VectorRand():GetNormalized()*128, self ).HitPos )
			util.Effect( "xdefm_beam", ef )
		end
	end


items.it_bouncy = {
	Type = "Uncommon",
	Model = "models/maxofs2d/hover_classic.mdl",
	Rarity = 2,
	Price = 180,
	PhysSound = "Rubber_Tire.ImpactHard"
	}
	function items.it_bouncy:OnInit( self ) end function items.it_bouncy:OnReady( self ) self:GetPhysicsObject():SetMaterial( "metal_bouncy" ) end
	function items.it_bouncy:OnCollide( self, dat ) local phy = self:GetPhysicsObject()
		local LastSpeed = math.max( dat.OurOldVelocity:Length(), dat.Speed )
		local NewVelocity = phy:GetVelocity():GetNormalized()
		LastSpeed = math.max( NewVelocity:Length(), LastSpeed ) phy:SetVelocity( NewVelocity*LastSpeed )
		local ent = dat.HitEntity  if IsValid( ent ) and dat.Speed >= 120 and dat.DeltaTime > 0.2 and ( ent:IsPlayer() or ent:IsNPC() ) then
			local dmg = DamageInfo()  local vel = ( ent:GetPos() -self:GetPos() ):GetNormalized()*100
			dmg:SetDamagePosition( self:WorldSpaceCenter() ) dmg:SetDamageForce( vel*100 ) dmg:SetAttacker( self:GetFMod_OW() )
			dmg:SetInflictor( self ) dmg:SetDamage( 2 ) ent:TakeDamageInfo( dmg ) ent:EmitSound( "Flesh.ImpactHard" ) ent:SetVelocity( vel*10 )
			local ef = EffectData() ef:SetOrigin( self:WorldSpaceCenter() ) ef:SetEntity( self ) ef:SetRadius( 1 )
			ef:SetScale( 1 ) ef:SetMagnitude( 1 ) util.Effect( "GlassImpact", ef )
		end
	end

items.it_charcoal = {
	Type = "Common",
	Model = "models/props_debris/concrete_spawnchunk001k.mdl",
	Rarity = 1,
	Price = 5,
	KillInWater = true, 
	PhysSound = "Wood.ImpactSoft"
}
	function items.it_charcoal:OnInit( self )
		self:SetColor(Color(50, 50, 50))
	end



items.it_boiler = {
	Type = "Structure",
	Model = "models/props_wasteland/laundry_washer001a.mdl",
	Rarity = 4,
	Price = 8000,
	Amount = 12,
	PhysSound = "EpicMetal_Heavy.ImpactHard",
	HelperUse = "xdefm.U3",
	SType = 1,
	StartSound = "Doors.FullOpen9",
	ExitSound = "Doors.FullClose10",
	CanPhysgun = true,
	TickRate = 1
}

	function items.it_boiler:OnInit( self )
		if CLIENT then return end
		self.xdefm_Enabled = false
		self.xdefm_WaterIn = 5
		self.xdefm_SteamOut = 20
		self.xdefm_HasWater = false
		self.xdefm_delay = 240 -- how many iterations with coef it can sustain before removing an item
		self.xdefm_coef = {
			["it_coal"]  = 1,
			["it_wood2"] = 2,
			["it_wood1"] = 3,
			["it_wood"]  = 5
		}
		self.xdefm_Snd = nil
		self.xdefm_Fuel = nil
	end

	function items.it_boiler:OnThink( self )
		if CLIENT then return end
		local fuel = nil -- the item for fuel
		local coef = 0 -- the higher the faster fuel burns
		local c_tbl = self.xdefm_coef

		self:SetNWBool( "xdefm_HasWater", self.xdefm_HasWater )

		if !isnumber(c_tbl[self.xdefm_Fuel]) then -- only checks if fuel slot has been updated or removed
			for i, v in pairs(self.xdefm_T3) do
				if v ~= "_" then
					local pre = string.Explode( "|", v )[1]
					if isnumber(c_tbl[pre]) and self.xdefm_HasWater then
						fuel = i
						self.xdefm_Fuel = i
						coef = c_tbl[pre]
						self.xdefm_Enabled = true
						self:SetNWBool( "xdefm_Enabled", true)
						self.xdefm_Snd = self:StartLoopingSound("ambient.steam01")
						break
					end
				end
			end
		end

		if fuel == nil then 
			self.xdefm_Enabled = false
			self:SetNWBool( "xdefm_Enabled", false)
			if isnumber(self.xdefm_Snd) then
				self:StopLoopingSound(self.xdefm_Snd)
			end
			return 
		end -- online only from here on
		local delay = self.xdefm_delay - coef

		if delay <= 0 then 
			self.xdefm_delay = 240
			self.xdefm_T3[fuel] = "it_charcoal"
			self:EmitSound("underground_steamjet")
			return
		else self.xdefm_delay = delay end

		self:SetNWFloat( "xdefm_Fuel", delay / coef)

	end

	function items.it_boiler:OnDraw( self )

		local enabled = self:GetNWBool( "xdefm_Enabled" ) 
		local haswat = self:GetNWBool( "xdefm_HasWater" )
		local fuel = tostring( self:GetNWFloat( "xdefm_Fuel" ) ) -- time in seconds for the next fuel to burn
		
		local enStr = "Offline"
		local enCol = Color(255, 0, 0)
		if enabled then
			enStr = "Online"
			enCol = Color(0, 255, 0)
		end

		local waStr = "No Water"
		local waCol = Color(255, 0, 0)
		if enabled then
			waStr = "Has Water"
			waCol = Color(0, 255, 0)
		end

		cam.Start3D2D(self:LocalToWorld( Vector(-6, -48, 24) ), self:LocalToWorldAngles( Angle(0, 0, 90)), 0.10)
			draw.RoundedBox( 2, 0, 0, 120, 100, Color( 0, 0, 0, 235 ) )
			
			draw.TextShadow( { text = enStr, pos = { 60, 20 }, font = "HudHintTextLarge", xalign = TEXT_ALIGN_CENTER, yalign = TEXT_ALIGN_CENTER, color = enCol }, 1, 255 )
			draw.TextShadow( { text = waStr, pos = { 60, 40 }, font = "HudHintTextLarge", xalign = TEXT_ALIGN_CENTER, yalign = TEXT_ALIGN_CENTER, color = waCol }, 1, 255 )
			if enabled then
				draw.TextShadow( { text = fuel .. " seconds", pos = { 60, 70 }, font = "HudHintTextLarge", xalign = TEXT_ALIGN_CENTER, yalign = TEXT_ALIGN_CENTER, color = Color(255, 255, 255) }, 1, 255 )
			end
		cam.End3D2D()

	end

items.it_pump = {
	Type = "Structure",
	Model = "models/props_canal/winch02.mdl",
	Rarity = 3,
	Price = 2500,
	HelperUse = "xdefm.U4",
	PhysSound = "EpicMetal_Heavy.ImpactHard",
	CanPhysgun = true,
	TickRate = 1
}

	function items.it_pump:OnInit( self )
		self.xdefm_Enabled = false
		self.xdefm_InWater = false
		self.xdefm_WaterOut = 10
		self.xdefm_WaterTo = {}
		self.xdefm_HasPower = false -- for system power
		self.xdefm_PowerIn = 5
		self.xdefm_Battery = 0
		self.xdefm_Snd = nil
	end

	function items.it_pump:OnUse( self, ply )
		if xdefm_NadAllow( ply, self) and self.xdefm_InWater then
			if !self.xdefm_HasPower and self.xdefm_Battery <= 0 then 
				self:EmitSound("ATV_stall_in_water")
				return false 
			end

			if self.xdefm_Enabled then 
				self.xdefm_Enabled = false 
				if isnumber(self.xdefm_Snd) then self:StopLoopingSound( self.xdefm_Snd ) end
				for i, v in pairs(self.xdefm_WaterTo) do
					v.xdefm_HasWater = false
				end
				return false 
			else
				self.xdefm_Enabled = true
				self:EmitSound("Trainyard.sodamachine_dispense")
				self.xdefm_Snd = self:StartLoopingSound( "d1_canals.diesel_generator" )
			end
		end

		local near = ents.FindInSphere( self:GetPos(), 512)
		if #near == 0 then return false end

		for i, v in pairs(near) do
			if v:GetClass() == "xdefm_base" and v:GetOwner() == self:GetOwner() and xdefm_GetClass( v ) == "it_boiler" then
				table.insert(self.xdefm_WaterTo, v)
			end
		end

		return false -- disable normal pickup
	end

	function items.it_pump:OnTouch( self, ent, typ )
		if typ == -1 and ent:GetClass() == "xdefm_base" and self.xdefm_Battery < 25 then
			local cls = xdefm_GetClass( ent )
			if cls == "it_armor" or cls == "it_refill" then
				ent:Remove()
				self.xdefm_Battery = 100
				self:EmitSound( "ambient/energy/zap2.wav" )
			end
		end
	end

	function items.it_pump:OnThink( self )
		if math.abs(self:GetAngles()[1]) > 30 or math.abs(self:GetAngles()[3]) > 30 then 
			self.xdefm_Enabled = false
		end -- if upright
		local tr = {
				start = self:GetPos(),
				endpos = self:GetPos() - Vector(0, 0, 128),
				filter = function( ent )
					local pump = self -- locaize due to filter function being stored where self return nil or other unrelated entities
					return self ~= ent
				end,
				mask = MASK_WATER
		}

		local inWater   = util.TraceLine(tr).Hit
		self.xdefm_InWater = inWater
		local onBattery = !self.xdefm_HasPower

		self:SetNWBool( "xdefm_Enabled", self.xdefm_Enabled )
		self:SetNWBool( "xdefm_InWater", inWater )
		self:SetNWBool( "xdefm_HasPower", !onBattery )
		self:SetNWFloat( "xdefm_Battery", self.xdefm_Battery * 4 )

		if !self.xdefm_Enabled then return end

		if !inWater or onBattery and self.xdefm_Battery <= 0 then -- double purpose to not continue and end sound
			if isnumber(self.xdefm_Snd) then
				self:StopLoopingSound( self.xdefm_Snd )
				self.xdefm_Snd = nil
				self:EmitSound("ATV_stall_in_water")
			end
			self.xdefm_Enabled = false
			for i, v in pairs(self.xdefm_WaterTo) do
				if !v:IsValid() then table.remove(self.xdefm_WaterTo, i) else
					v.xdefm_HasWater = false
				end
			end
			return
		end

		if !isnumber(self.xdefm_Snd) then self.xdefm_Snd = self:StartLoopingSound( "d1_canals.diesel_generator" ) end
		if onBattery then self.xdefm_Battery = self.xdefm_Battery - 0.25 end -- about 400 seconds of runtime

		local water = self.xdefm_WaterOut

		for i, v in pairs(self.xdefm_WaterTo) do
			if !v:IsValid() then table.remove(self.xdefm_WaterTo, i) else
				v.xdefm_HasWater = true
				water = water - v.xdefm_WaterIn
			end
		end
	end

	function items.it_pump:OnDraw( self )

		local enabled = self:GetNWBool( "xdefm_Enabled" ) 
		local haswat = self:GetNWBool( "xdefm_InWater" )
		local haspow = self:GetNWBool( "xdefm_HasPower" )
		local battery = self:GetNWFloat( "xdefm_Battery" )
		
		local enStr = "Offline"
		local enCol = Color(255, 0, 0)
		if enabled then
			enStr = "Online"
			enCol = Color(0, 255, 0)
		end

		local waStr = "No Water"
		local waCol = Color(255, 0, 0)
		if haswat then
			waStr = "Has Water"
			waCol = Color(0, 255, 0)
		end

		local pwStr = "On Battery"
		local pwCol = Color(255, 0, 0)
		local batCol = Color(255, 255, 255)
		if haspow then
			pwStr = "Has Power"
			pwCol = Color(0, 255, 0)
			batCol = Color( 150, 150, 150)
		end

		local batStr = tostring(battery) .. " seconds"
		if battery == 0 then 
			batStr = "Empty"
			batCol = Color( 255, 0, 0)
		end
		

		cam.Start3D2D(self:LocalToWorld( Vector(-10, 3, 42) ), self:LocalToWorldAngles( Angle(0, -90, 90)), 0.10)
			draw.RoundedBox( 2, 0, 0, 120, 100, Color( 0, 0, 0, 235 ) )
			
			draw.TextShadow( { text = enStr, pos = { 60, 20 }, font = "HudHintTextLarge", xalign = TEXT_ALIGN_CENTER, yalign = TEXT_ALIGN_CENTER, color = enCol }, 1, 255 )
			draw.TextShadow( { text = waStr, pos = { 60, 40 }, font = "HudHintTextLarge", xalign = TEXT_ALIGN_CENTER, yalign = TEXT_ALIGN_CENTER, color = waCol }, 1, 255 )
			draw.TextShadow( { text = pwStr, pos = { 60, 60 }, font = "HudHintTextLarge", xalign = TEXT_ALIGN_CENTER, yalign = TEXT_ALIGN_CENTER, color = pwCol }, 1, 255 )
			draw.TextShadow( { text = batStr, pos = { 60, 80 }, font = "HudHintTextLarge", xalign = TEXT_ALIGN_CENTER, yalign = TEXT_ALIGN_CENTER, color = batCol }, 1, 255 )

		cam.End3D2D()


	end

items.it_turbine = {
	Type = "Structure",
	Model = "models/props_vehicles/generatortrailer01.mdl",
	Rarity = 4,
	Price = 3000,
	HelperUse = "xdefm.U4",
	PhysSound = "EpicMetal_Heavy.ImpactHard",
	CanPhysgun = true,
	TickRate = 1
}
	function items.it_turbine:OnInit( self )
		self.xdefm_Enabled = false
		self.xdefm_SteamIn = 10
		self.xdefm_PowerOutMax = 20
		self.xdefm_PowerOut = 0
		self.xdefm_HasSteam = false
		self.xdefm_Snd = nil
		self:NextThink( CurTime() + 1 )
	end

	function items.it_turbine:OnUse( self, ply )
		if xdefm_NadAllow( ply, self) then
			if self.xdefm_Enabled then 
				self.xdefm_Enabled = false 
				self:SetNWBool( "xdefm_Enabled", false) 
				if isnumber(self.xdefm_Snd) then 
					self:StopLoopingSound(self.xdefm_Snd) 
					self.xdefm_Snd = nil
				end
			else
				self.xdefm_Enabled = true
				self:SetNWBool( "xdefm_Enabled", true) 
				self:EmitSound("Trainyard.sodamachine_dispense")
				self.xdefm_Snd = self:StartLoopingSound( "d1_canals.substation_generators" )
			end
		end
		return false 
	end

	function items.it_turbine:OnThink( self )

		self:SetNWBool( "xdefm_HasSteam", self.xdefm_HasSteam) 

		if self.xdefm_Enabled and self.xdefm_HasSteam then
			if !isnumber(self.xdefm_Snd) then self.xdefm_Snd = self:StartLoopingSound( "d1_canals.substation_generators" ) end
			self.xdefm_PowerOut = self.xdefm_PowerOutMax
		else
			if isnumber(self.xdefm_Snd) then -- love piggybacking
				self:StopLoopingSound(self.xdefm_Snd) 
				self.xdefm_Snd = nil
				self.xdefm_PowerOut = 0
			end
		end
	end

	function items.it_turbine:OnDraw( self ) -- since everything is shared, I might as well be lazy
		local enabled = self:GetNWBool( "xdefm_Enabled" ) 
		local hasSteam = self:GetNWBool( "xdefm_HasSteam" )
		local enStr = "Disabled"
		local enCol = Color(255, 0, 0)
		if enabled then
			enStr = "Enabled"
			enCol = Color(0, 255, 0)
		end
		local hsStr = "No Steam"
		local hsCol = Color(255, 0, 0)
		if hasSteam then
			hsStr = "Steam Ready"
			hsCol = Color(0, 255, 0)
		end

		cam.Start3D2D(self:LocalToWorld( Vector(-64, 6, 56) ), self:LocalToWorldAngles( Angle(0, -90, 90)), 0.10)
			draw.RoundedBox( 2, 0, 0, 120, 100, Color( 0, 0, 0, 235 ) )

			draw.TextShadow( { text = enStr, pos = { 60, 30 }, font = "HudHintTextLarge", xalign = TEXT_ALIGN_CENTER, yalign = TEXT_ALIGN_CENTER, color = enCol }, 1, 255 )
			draw.TextShadow( { text = hsStr, pos = { 60, 70 }, font = "HudHintTextLarge", xalign = TEXT_ALIGN_CENTER, yalign = TEXT_ALIGN_CENTER, color = hsCol }, 1, 255 )
		cam.End3D2D()

	end

items.it_relay = {
	Type = "Structure",
	Model = "models/props_wasteland/laundry_washer003.mdl",
	Rarity = 3,
	Price = 3000,
	HelperUse = "xdefm.U2",
	PhysSound = "EpicMetal_Heavy.ImpactHard",
	CanPhysgun = true,
	TickRate = 1
}
	function items.it_relay:OnInit( self )
		self.xdefm_Steam = { ["In"] = {}, ["Out"] = {}}
		self.xdefm_Power = { ["In"] = {}, ["Out"] = {}}
		self.xdefm_SteamDraw = 0 -- this is for flask draw
		self.xdefm_PowerDraw = 0 -- this is for battery draw
		self:NextThink( CurTime() + 1)
	end

	function items.it_relay:OnUse( self, ply )
		if !xdefm_NadAllow( ply, self ) then return false end

		self:EmitSound( "Buttons.snd17" )
		local near = ents.FindInSphere( self:GetPos(), 512)
		if #near == 0 then return end

		local steam = { ["In"] = {}, ["Out"] = {}, ["Store"] = {}}
		local power = { ["In"] = {}, ["Out"] = {}, ["Store"] = {}}
		for i, v in pairs(near) do
			if v:GetClass() == "xdefm_base" and v:GetOwner() == self:GetOwner() then
				
				if xdefm_GetClass( v ) == "it_battery" then
					table.insert( power["Store"], v )
				else
					if isnumber(v.xdefm_PowerOut) then
						table.insert( power["In"], v )
					end
					if isnumber(v.xdefm_PowerIn) then
						table.insert( power["Out"], v )
					end
				end

				if xdefm_GetClass( v ) == "it_flask" then
					table.insert( steam["Store"], v )
				else
					if isnumber(v.xdefm_SteamOut) then
						table.insert( steam["In"], v )
					end
					if isnumber(v.xdefm_SteamIn) then
						table.insert( steam["Out"], v )
					end
				end
			end
		end

		self.xdefm_Steam = steam
		self.xdefm_Power = power
		return false
	end

	function items.it_relay:OnThink( self )
		local steam = self.xdefm_Steam
		local power = self.xdefm_Power

		if #steam.Out > 0 then -- nothing needs? nothing takes
			
			local total = 0
			local supIn = 0
			local supOut = 0
			local batIn = 0
			local batOut = 0

			for i, v in pairs( steam.In ) do
				if !v:IsValid() then 
					table.remove(self.xdefm_Steam.In, i)
				elseif v.xdefm_Enabled then
					total = total + v.xdefm_SteamOut
				end
			end
			supIn = total

			for i, v in pairs( steam.Out ) do
				if !v:IsValid() then 
					table.remove(self.xdefm_Steam.Out, i)
				elseif v.xdefm_Enabled then
					total = total - v.xdefm_SteamIn
				end
			end
			supOut = math.abs(total - supIn)
			
			if total > 0 then
				for i, v in pairs( steam.Store ) do
					if total <= 0 then break end -- use up all slack

					if !v:IsValid() then 
						table.remove(self.xdefm_Steam.Store, i)

					elseif v.xdefm_BatteryMax > v.xdefm_Battery then
						local maxIn = math.Clamp( v.xdefm_SteamInMax, 0, v.xdefm_BatteryMax - v.xdefm_Battery)
						local pin = math.Clamp( maxIn, 0, total) -- Steamin, in is taken, makes me mad

						total = total - pin
						v.xdefm_Battery = v.xdefm_Battery + pin
						batOut = batOut + pin	
					end
				end
			elseif total < 0 then
				for i, v in pairs( steam.Store ) do
					if total >= 0 then break end -- win condition

					if !v:IsValid() then 
						table.remove(self.xdefm_Steam.Store, i)

					elseif v.xdefm_Enabled and v.xdefm_Battery > 0 then

						local maxOut = math.Clamp( v.xdefm_SteamOutMax, 0, v.xdefm_Battery) -- use the last drop
						local out = math.Clamp( maxOut, 0, -total)

						total = total + out
						v.xdefm_Battery = v.xdefm_Battery - out
						batIn = batIn + out
					end
				end
			end

			supTot = total -- supply total for dishing out supply without messing with display variables
			for i, v in pairs( steam.Out ) do
				if v.xdefm_Enabled then
					if supTot >= 0 then
						v.xdefm_HasSteam = true
					else
						supTot = supTot + v.xdefm_SteamIn -- reversing negative to steam only what didn't make it go negative is a workaround to having more than one variable
						v.xdefm_HasSteam = false
					end
				else v.xdefm_HasSteam = false end
			end


			self:SetNWString( "XDEFM_RDEMS", "IN:" .. tostring(supIn) .. " OUT:" .. tostring(supOut) .. 
			"|TOTAL:" .. tostring( total ) ..
			"|Flask: " .. tostring(batIn - batOut ) )
		end

		if #power.Out > 0 then -- nothing needs? nothing takes
			
			local total = 0
			local supIn = 0
			local supOut = 0
			local batIn = 0
			local batOut = 0

			for i, v in pairs( power.In ) do
				if !v:IsValid() then 
					table.remove(power.In, i)
				elseif v.xdefm_Enabled then
					total = total + v.xdefm_PowerOut
				end
			end
			supIn = total

			for i, v in pairs( power.Out ) do
				if !v:IsValid() then 
					table.remove(power.In, i)
				elseif v.xdefm_Enabled then
					total = total - v.xdefm_PowerIn
				end
			end
			supOut = math.abs(total - supIn)
			
			if total > 0 then
				for i, v in pairs( power.Store ) do
					if total <= 0 then break end -- use up all slack

					if !v:IsValid() then 
						table.remove(power.Store, i)

					elseif v.xdefm_BatteryMax > v.xdefm_Battery then
						local maxIn = math.Clamp( v.xdefm_PowerInMax, 0, v.xdefm_BatteryMax - v.xdefm_Battery)
						local pin = math.Clamp( maxIn, 0, total) -- Powerin, in is taken, makes me mad

						total = total - pin
						v.xdefm_Battery = v.xdefm_Battery + pin
						batOut = batOut + pin	
					end
				end
			elseif total < 0 then
				for i, v in pairs( power.Store ) do
					if total >= 0 then break end -- win condition

					if !v:IsValid() then 
						table.remove(power.Store, i)

					elseif v.xdefm_Enabled and v.xdefm_Battery > 0 then

						local maxOut = math.Clamp( v.xdefm_PowerOutMax, 0, v.xdefm_Battery) -- use the last drop
						local out = math.Clamp( maxOut, 0, -total)

						total = total + out
						v.xdefm_Battery = v.xdefm_Battery - out
						batIn = batIn + out
					end
				end
			end

			supTot = total -- supply total for dishing out supply without messing with display variables
			for i, v in pairs( power.Out ) do
				if v.xdefm_Enabled then
					if supTot >= 0 then
						v.xdefm_HasPower = true
					else
						supTot = supTot + v.xdefm_PowerIn -- reversing negative to power only what didn't make it go negative is a workaround to having more than one variable
						v.xdefm_HasPower = false
					end
				else v.xdefm_HasPower = false end
			end


			self:SetNWString( "XDEFM_RDEMP", "IN:" .. tostring(supIn) .. " OUT:" .. tostring(supOut) .. 
			"|TOTAL:" .. tostring( total ) ..
			"|Battery: " .. tostring(batIn - batOut ) )
		end
	end

	function items.it_relay:OnDraw( self )
		local txt  = string.Explode( "|", tostring( self:GetNWString( "XDEFM_RDEMS" )) )
		local txt2 = string.Explode( "|", tostring( self:GetNWString( "XDEFM_RDEMP" )) )
		surface.SetFont( "HudHintTextLarge" )  
		
		cam.Start3D2D(self:LocalToWorld( Vector(0, 12, 20) ), self:LocalToWorldAngles( Angle(0, 180, 45)), 0.10)
			draw.RoundedBox( 2, 10, 0, 140, 80, Color( 0, 0, 0, 235 ) )
			draw.RoundedBox( 2, 170, 0, 140, 80, Color( 0, 0, 0, 235 ) )

			draw.TextShadow( { text = "STEAM", pos = { 80, 10 }, font = "HudHintTextLarge", xalign = TEXT_ALIGN_CENTER, yalign = TEXT_ALIGN_CENTER, color = Color( 255, 255, 255 ) }, 1, 255 )
			draw.TextShadow( { text = txt[1], pos = { 80, 30 }, font = "HudHintTextLarge", xalign = TEXT_ALIGN_CENTER, yalign = TEXT_ALIGN_CENTER, color = Color( 255, 255, 255 ) }, 1, 255 )
			draw.TextShadow( { text = txt[2], pos = { 80, 50 }, font = "HudHintTextLarge", xalign = TEXT_ALIGN_CENTER, yalign = TEXT_ALIGN_CENTER, color = Color( 255, 255, 255 ) }, 1, 255 )
			draw.TextShadow( { text = txt[3], pos = { 80, 70 }, font = "HudHintTextLarge", xalign = TEXT_ALIGN_CENTER, yalign = TEXT_ALIGN_CENTER, color = Color( 255, 255, 255 ) }, 1, 255 )

			draw.TextShadow( { text = "POWER", pos = { 240, 10 }, font = "HudHintTextLarge", xalign = TEXT_ALIGN_CENTER, yalign = TEXT_ALIGN_CENTER, color = Color( 255, 255, 255 ) }, 1, 255 )
			draw.TextShadow( { text = txt2[1], pos = { 240, 30 }, font = "HudHintTextLarge", xalign = TEXT_ALIGN_CENTER, yalign = TEXT_ALIGN_CENTER, color = Color( 255, 255, 255 ) }, 1, 255 )
			draw.TextShadow( { text = txt2[2], pos = { 240, 50 }, font = "HudHintTextLarge", xalign = TEXT_ALIGN_CENTER, yalign = TEXT_ALIGN_CENTER, color = Color( 255, 255, 255 ) }, 1, 255 )
			draw.TextShadow( { text = txt2[3], pos = { 240, 70 }, font = "HudHintTextLarge", xalign = TEXT_ALIGN_CENTER, yalign = TEXT_ALIGN_CENTER, color = Color( 255, 255, 255 ) }, 1, 255 )

		cam.End3D2D()
	end

items.it_battery = {
	Type = "Structure",
	Model = "models/props_c17/trappropeller_engine.mdl",
	Rarity = 3,
	Price = 1500,
	HelperUse = "xdefm.U4",
	PhysSound = "EpicMetal_Heavy.ImpactHard",
	CanPhysgun = true,
	TickRate = 1
}

	function items.it_battery:OnInit( self )
		self.xdefm_Enabled = false
		self.xdefm_PowerInMax = 2
		self.xdefm_PowerOutMax = 10
		self.xdefm_BatteryMax = 1000
		self.xdefm_Battery = 0
		self:NextThink( CurTime() + 1)
	end

	function items.it_battery:OnUse( self, ply )
		if xdefm_NadAllow( ply, self) then
			self.xdefm_Enabled = !self.xdefm_Enabled
			self:SetNWBool( "xdefm_Enabled", self.xdefm_Enabled) 
			self:EmitSound("Trainyard.sodamachine_dispense")
		end
		return false
	end

	function items.it_battery:OnThink( self )
		self:SetNWFloat("xdefm_battery", self.xdefm_Battery)
	end

	function items.it_battery:OnDraw( self ) -- since everything is shared, I might as well be lazy
		local txt  = tostring( self:GetNWFloat( "xdefm_Battery" ))
		local enabled = self:GetNWBool( "xdefm_Enabled" ) 
		local enStr = "Storing"
		local enCol = Color(255, 0, 0)
		if enabled then
			enStr = "Providing"
			enCol = Color(0, 255, 0)
		end

		cam.Start3D2D(self:LocalToWorld( Vector(-14, 6, 12) ), self:LocalToWorldAngles( Angle(0, -90, 90)), 0.10)
			draw.RoundedBox( 2, 10, 0, 140, 80, Color( 0, 0, 0, 235 ) )

			draw.TextShadow( { text = "Battery", pos = { 80, 20 }, font = "HudHintTextLarge", xalign = TEXT_ALIGN_CENTER, yalign = TEXT_ALIGN_CENTER, color = Color( 255, 255, 255 ) }, 1, 255 )
			draw.TextShadow( { text = enStr, pos = { 80, 40 }, font = "HudHintTextLarge", xalign = TEXT_ALIGN_CENTER, yalign = TEXT_ALIGN_CENTER, color = enCol }, 1, 255 )
			draw.TextShadow( { text = txt, pos = { 80, 60 }, font = "HudHintTextLarge", xalign = TEXT_ALIGN_CENTER, yalign = TEXT_ALIGN_CENTER, color = Color( 255, 255, 255 ) }, 1, 255 )
		cam.End3D2D()

	end



items.it_flask = {
	Type = "Structure",
	Model = "models/props_c17/canister_propane01a.mdl",
	Rarity = 3,
	Price = 1000,
	HelperUse = "xdefm.U4",
	PhysSound = "EpicMetal_Heavy.ImpactHard",
	CanPhysgun = true,
	TickRate = 1
}

	function items.it_flask:OnInit( self )
		self.xdefm_Enabled = false
		self.xdefm_SteamInMax = 2
		self.xdefm_SteamOutMax = 10
		self.xdefm_BatteryMax = 1000 -- just gonna keep it the same
		self.xdefm_Battery = 0
		self:NextThink( CurTime() + 1)
	end

	function items.it_flask:OnUse( self, ply )
		if xdefm_NadAllow( ply, self) then
			self.xdefm_Enabled = !self.xdefm_Enabled
			self:SetNWBool( "xdefm_Enabled", self.xdefm_Enabled) 
			self:EmitSound("Trainyard.sodamachine_dispense")
		end
		return false
	end

	function items.it_flask:OnThink( self )
		self:SetNWFloat("xdefm_battery", self.xdefm_Battery)
	end

	function items.it_flask:OnDraw( self ) -- since everything is shared, I might as well be lazy
		local txt  = tostring( self:GetNWFloat( "xdefm_Battery" ))
		local enabled = self:GetNWBool( "xdefm_Enabled" ) 
		local enStr = "Storing"
		local enCol = Color(255, 0, 0)
		if enabled then
			enStr = "Providing"
			enCol = Color(0, 255, 0)
		end

		cam.Start3D2D(self:LocalToWorld( Vector(-16, 8, 48) ), self:LocalToWorldAngles( Angle(0, -90, 90)), 0.10)
			draw.RoundedBox( 2, 10, 0, 140, 80, Color( 0, 0, 0, 235 ) )

			draw.TextShadow( { text = "Steam Flask", pos = { 80, 20 }, font = "HudHintTextLarge", xalign = TEXT_ALIGN_CENTER, yalign = TEXT_ALIGN_CENTER, color = Color( 255, 255, 255 ) }, 1, 255 )
			draw.TextShadow( { text = enStr, pos = { 80, 40 }, font = "HudHintTextLarge", xalign = TEXT_ALIGN_CENTER, yalign = TEXT_ALIGN_CENTER, color = enCol }, 1, 255 )
			draw.TextShadow( { text = txt, pos = { 80, 60 }, font = "HudHintTextLarge", xalign = TEXT_ALIGN_CENTER, yalign = TEXT_ALIGN_CENTER, color = Color( 255, 255, 255 ) }, 1, 255 )
		cam.End3D2D()
	end

items.it_furnace3 = {
	Type = "Structure",
	Model = "models/props/cs_militia/furnace01.mdl",
	StartSound = "Metal_Barrel.ImpactSoft",
	ExitSound = "Metal_Barrel.ImpactHard",
	Rarity = 4,
	Price = 3000,
	Amount = 12,
	PhysSound = "EpicMetal.ImpactSoft",
	HelperUse = "xdefm.U3",
	SType = 1,
	CanPhysgun = true,
	TickRate = 1
}

	function items.it_furnace3:OnInit( self )

		self.xdefm_HasPower = false
		self.xdefm_PowerIn = 25
		self.xdefm_Enabled = false
		self.xdefm_Selected = nil
		self.xdefm_SmeltTime = nil

		self.sm_tbl = {
			["it_scrap"] = {amount = 1, result = "it_steelbar"},
			["it_ore"]	 = {amount = 1, result = "it_copperbar"},
			["it_ejunk"] = {amount = 2, result = "it_tungstonbar"},
			["it_coin"] =  {amount = 2, result = "it_silverbar"},
			["it_pottery"] = {amount = 2, result = "it_potter1"},
			["it_potter1"] = {amount = 2, result = "it_potter2"},
			["it_potter2"] = {amount = 2, result = "it_potter3"},
			["it_oreblue"] =   {amount = 2, result = "it_gemblue"},
			["it_orepurple"] = {amount = 2, result = "it_gempurple"},
			["it_oregreen"] =  {amount = 2, result = "it_gemgreen"},
			["it_orered"] =    {amount = 2, result = "it_gemred"},
			["it_orewhite"] =  {amount = 2, result = "it_gemwhite"},
		}
	end

	function items.it_furnace3:OnThink( self )

		local slots = {} -- table of all the matching indexes for the items listed

		for i, v in pairs(self.xdefm_T3) do
			if v ~= "_" then -- non-empty slot
				local pre = string.Explode( "|", v )[1]

				if istable(self.sm_tbl[pre]) then
					if not istable(slots[pre]) then slots[pre] = {} end
					table.insert(slots[pre], i)
				end
			end
		end

		self.xdefm_Enabled = table.Count(slots) > 0

		if self.xdefm_Enabled then
			if not self.xdefm_HasPower then return end

			local sel = nil
			for i, v in pairs(slots) do
				if table.Count(v) >= self.sm_tbl[i].amount then 
					sel = i
					break
				end
			end
			if sel == nil then return end
			self.xdefm_Selected = sel

			self.xdefm_SmeltTime = self.xdefm_SmeltTime or CurTime() + 3
			local stime = self.xdefm_SmeltTime

			if stime < CurTime() then
				self.xdefm_T3[slots[sel][1]] = self.sm_tbl[sel].result
				if self.sm_tbl[sel].amount > 1 then
					for i = 2, self.sm_tbl[sel].amount do
						self.xdefm_T3[slots[sel][i]] = "_"
					end
				end

				self.xdefm_SmeltTime = CurTime() + 3
			end
		else
			self.xdefm_Selected = nil
			self.xdefm_SmeltTime = nil
		end

	end
xdefm_ItemRegisterAll(items)