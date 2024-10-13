if CLIENT then return end

local quests = { 
    
    [0] = {
        reward = "it_bag1",
        "it_wood2&it_metal2",
        "it_glass2&it_brick",
        "it_metal2&it_plastic",
        "it_mine1&it_mine1",
        "it_hula&it_cactus&it_shoe",
        "it_coin&it_coin",
        "it_present",
        "it_dollar&it_dollar&it_dollar",
        "it_register",
        "it_melon&it_melon",
        "it_banana&it_banana",
        "cr_melon",
        "it_potter1&it_potter1",
        "it_radio",
        "it_coal&it_coal&it_coal",
        "cr_dollar",
        "it_combine",
        "it_wood&it_stone&it_metal&it_glass&it_junk",
        "it_brick&it_brick",
        "it_health&it_armor",
        "cr_seagull"
    },

    [15] = {
        reward = "it_bag2",
        "it_wood2&it_metal2&it_glass2&it_stone2",
        "it_metal2&it_metal2&it_plastic&it_plastic",
        "it_present&it_present",
        "it_crate2",
        "it_register&it_register",
        "it_apple&it_orange&it_melon&it_banana",
        "it_radio&it_jumppad",
        "it_potter2&it_potter2",
        "it_potter1&it_potter1&it_potter1&it_potter1",
        "it_stove1&it_stove1&it_stove1",
        "cr_crab&cr_crab2&cr_crab3",
        "cr_gold&cr_fish&cr_perch",
        "it_copperbar&it_leadbar&it_steelbar",
        "it_barre1&it_barre2&it_barre1",
        "it_oreblue&it_orepurple",
        "it_gballoon&it_gballoon&it_gballoon&it_gballoon",
        "it_crowbar&it_stunstick",
        "it_camera",
        "it_expr&it_expr&it_expr",
        "it_egg&it_egg",
        "cr_crow",
        "it_charcoal&it_charcoal&it_charcoal"
    },

    [30] = {
        reward = "it_bag3",
        "it_crate1&it_crate2&it_crate3",
        "it_present&it_present&it_present&it_present",
        "it_coin2",
        "it_flower&it_flower",
        "it_potter3&it_potter2&it_potter3",
        "it_egg&it_egg&it_egg&it_egg",
        "cr_perch&cr_perch&cr_perch",
        "it_mine2&it_bomb2",
        "it_gemblue&it_gempurple",
        "it_orewhite&it_orewhite",
        "it_defib",
        "it_figurine&it_torch",
        "cr_baby&cr_saw&cr_gnome",
        "cr_bread&it_pumpkin2&cr_bread",
        "it_firearm2&it_firearm2&it_ammo",
        "it_crate3&it_crate3&it_crate3",
        "it_oreblue&it_orepurple&it_oregreen&it_orered",
        "it_goldbar&it_goldbar",
        "it_copperbar&it_leadbar&it_steelbar&it_tungstenbar",
        "it_exp2",
        "cr_crow&cr_seagull&cr_pigeon"
    },

    [50] = {
        reward = "it_bag4",
        "it_bait3&it_bait3&it_exp3",
        "it_coin2&it_coin2&it_coin2&it_coin2",
        "it_goldbar&it_orewhite&it_goldbar",
        "it_pturre2&it_cturret&it_pturre1",
        "it_gemblue&it_gempurple&it_gemgreen&it_gemred",
        "it_gballoom&it_defib",
        "it_torch&it_figurine&it_cosmogram",
        "cr_pigeon&cr_pigeon&cr_pigeon&cr_pigeon",
        "it_treasure&it_treasure&it_coin2",
        "it_ammocan1&it_ammocan1&it_ammocan1&it_crate3",
        "cr_crow&cr_crow&cr_crow&cr_crow"
    }
}

for i, v in pairs(quests) do
    local reward = v.reward
    for _, k in ipairs(v) do -- shouldn't run k = [reward]
        
        xdefm_QuestRegister( i, k, reward )

    end
end

-- xdefm_QuestRegister( lvl , items , reward ) (lvl, "items", "4")