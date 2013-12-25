-- mods/icetools/init.lua

minetest.register_node("icetools:stone_with_ice_crystal", {
	description = "Ice Crystal Ore",
	tiles = {"default_stone.png^icetools_mineral_ice_crystal.png"},
	light_source = 7,
	is_ground_content = true,
	groups = {level=2, cracky=2},
	drop = "icetools:ice_crystal",
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_craftitem("icetools:ice_crystal", {
	description = "Ice Crystal",
	inventory_image = "icetools_ice_crystal.png",
})

minetest.register_craftitem("icetools:ice_crystal_refined", {
	description = "Refined Ice Crystal",
	inventory_image = "icetools_ice_crystal_refined.png",
})

minetest.register_craft({
	type = "shapeless",
	output = "icetools:ice_crystal_refined",
	recipe = {"icetools:ice_crystal", "bucket:bucket_water", "default:diamond"},
})

minetest.register_craft({
		type = "shapeless",
		output = 'icetools:ice_crystal_refined 9',
		recipe = {'icetools:ice_crystal_block'},
	})

minetest.register_craft({
		output = 'icetools:ice_crystal_block',
		recipe = {
				{'icetools:ice_crystal_refined','icetools:ice_crystal_refined','icetools:ice_crystal_refined'},
				{'icetools:ice_crystal_refined','icetools:ice_crystal_refined','icetools:ice_crystal_refined'},
				{'icetools:ice_crystal_refined','icetools:ice_crystal_refined','icetools:ice_crystal_refined'},
		}
})

minetest.register_craft({
	output = "icetools:sword_ice",
	recipe = {
		{"icetools:ice_crystal_refined"},
		{"icetools:ice_crystal_refined"},
		{"group:stick"},
	}
})

minetest.register_craft({
	output = "icetools:pick_ice",
	recipe = {
		{"icetools:ice_crystal_refined", "icetools:ice_crystal_refined", "icetools:ice_crystal_refined"},
		{"", "group:stick", ""},
		{"", "group:stick", ""},
	}
})

minetest.register_craft({
	output = "icetools:axe_ice",
	recipe = {
		{"icetools:ice_crystal_refined", "icetools:ice_crystal_refined"},
		{"icetools:ice_crystal_refined", "group:stick"},
		{"", "group:stick"},
	}
})

minetest.register_craft({
	output = "icetools:shovel_ice",
	recipe = {
		{"icetools:ice_crystal_refined"},
		{"group:stick"},
		{"group:stick"},
	}
})

minetest.register_craft({
	output = "icetools:hoe_ice",
	recipe = {
		{"icetools:ice_crystal_refined","icetools:ice_crystal_refined"},
		{"","group:stick"},
		{"","group:stick"},
	}
})

if minetest.get_modpath("paxels") == nil then
	minetest.register_craft({
		output = "icetools:paxel_ice",
		recipe = {
			{"icetools:axe_ice","icetools:shovel_ice","icetools:pick_ice"},
			{"","icetools:ice_crystal_refined",""},
			{"","icetools:ice_crystal_refined",""},
		}
	})
end
minetest.register_tool("icetools:sword_ice", {
	description = "Ice Sword",
	inventory_image = "icetools_tool_icesword.png",
	tool_capabilities = {
		full_punch_interval = 0.5,
		max_drop_level=1,
		groupcaps={
			snappy={times={[1]=1.50, [2]=0.60, [3]=0.20}, uses=50, maxlevel=3},
		},
		damage_groups = {fleshy=9},
	}
})

minetest.register_tool("icetools:pick_ice", {
	description = "Ice Pickaxe",
	inventory_image = "icetools_tool_icepick.png",
	tool_capabilities = {
		full_punch_interval = 0.5,
		max_drop_level=3,
		groupcaps={
			cracky = {times={[1]=0.90, [2]=0.40, [3]=0.10}, uses=50, maxlevel=3},
		},
		damage_groups = {fleshy=5},
	},
})

minetest.register_tool("icetools:shovel_ice", {
	description = "Ice Shovel",
	inventory_image = "icetools_tool_iceshovel.png",
	wield_image = "icetools_tool_iceshovel.png^[transformR90",
	tool_capabilities = {
		full_punch_interval = 0.5,
		max_drop_level=1,
		groupcaps={
			crumbly = {times={[1]=0.90, [2]=0.40, [3]=0.10}, uses=50, maxlevel=3},
		},
		damage_groups = {fleshy=4},
	},
})

minetest.register_tool("icetools:axe_ice", {
	description = "Ice Axe",
	inventory_image = "icetools_tool_iceaxe.png",
	tool_capabilities = {
		full_punch_interval = 0.5,
		max_drop_level=1,
		groupcaps={
			choppy={times={[1]=0.90, [2]=0.40, [3]=0.10}, uses=50, maxlevel=2},
		},
		damage_groups = {fleshy=7},
	},
})


minetest.register_tool("icetools:hoe_ice", {
    description = "Ice Hoe",
    inventory_image = "icetools_tool_icehoe.png",
    liquids_pointable = true,
    on_use = function(itemstack, user, pointed_thing)
        if pointed_thing.type ~= "node" then
            return
        end
        node = minetest.get_node(pointed_thing.under)
        liquiddef = bucket.liquids["default:lava_source"]
        if liquiddef ~= nil and liquiddef.itemname ~= nil and (node.name == liquiddef.source or
            (node.name == "default:lava_source" or node.name == "default:lava_flowing")) then
            minetest.add_node(pointed_thing.under, {name="default:obsidian"})
        itemstack:add_wear(65535/70)
        return itemstack
        end
    end
})

minetest.register_tool("icetools:paxel_ice", {
	description = "Ice Paxel",
	inventory_image = "icetools_tool_icepaxel.png",
	tool_capabilities = {
		full_punch_interval = 0.5,
		max_drop_level=3,
		groupcaps={
			choppy = {times={[1]=0.80, [2]=0.40, [3]=0.10}, uses=50, maxlevel=2},
			crumbly = {times={[1]=0.80, [2]=0.40, [3]=0.10}, uses=50, maxlevel=3},
			cracky = {times={[1]=0.80, [2]=0.40, [3]=0.10}, uses=50, maxlevel=3},
		},
		damage_groups = {fleshy=8},
	},
})



minetest.register_ore({
	ore_type       = "scatter",
	ore            = "icetools:stone_with_ice_crystal",
	wherein        = "default:stone",
	clust_scarcity = 24*24*24,
	clust_num_ores = 27,
	clust_size     = 6,
	height_min     = -31000,
	height_max     = -64,
	flags          = "absheight",
})

minetest.register_node('icetools:ice_crystal_block', {
    description = 'Refined Ice Crystal Block',
	paramtype2 = 'facedir',
	tiles = {"icetools_ice_crystal_block.png", "icetools_ice_crystal_block.png^[transformR270", "icetools_ice_crystal_block.png^[transformR90",
	"icetools_ice_crystal_block.png", "icetools_ice_crystal_block.png^[transformR270", "icetools_ice_crystal_block.png^[transformR180"},
	light_source = LIGHT_MAX,
    groups = {cracky=1,level=3},
    sounds = default.node_sound_stone_defaults(),
})
