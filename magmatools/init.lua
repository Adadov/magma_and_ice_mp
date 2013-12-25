-- mods/magmatools/init.lua

minetest.register_node('magmatools:stone_with_magma_crystal', {
	description = 'Magma Crystal Ore',
	tiles = {'default_stone.png^magmatools_mineral_magma_crystal.png'},
	light_source = 7,
	is_ground_content = true,
	groups = {level=2, cracky=2},
	drop = 'magmatools:magma_crystal',
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_craftitem('magmatools:magma_crystal', {
	description = 'Magma Crystal',
	inventory_image = 'magmatools_magma_crystal.png',
})

minetest.register_craftitem('magmatools:magma_crystal_refined', {
	description = 'Refined Magma Crystal',
	inventory_image = 'magmatools_magma_crystal_refined.png',
})

minetest.register_craft({
	type = "shapeless",
	output = 'magmatools:magma_crystal_refined',
	recipe = {'magmatools:magma_crystal', 'bucket:bucket_lava', 'default:mese_crystal'},
})

minetest.register_craft({
	output = 'magmatools:sword_magma',
	recipe = {
		{'magmatools:magma_crystal_refined'},
		{'magmatools:magma_crystal_refined'},
		{'default:torch'},
	}
})

minetest.register_craft({
	output = 'magmatools:pick_magma',
	recipe = {
		{'magmatools:magma_crystal_refined', 'magmatools:magma_crystal_refined', 'magmatools:magma_crystal_refined'},
		{'', 'default:torch', ''},
		{'', 'default:torch', ''},
	}
})

minetest.register_craft({
	output = 'magmatools:axe_magma',
	recipe = {
		{'magmatools:magma_crystal_refined', 'magmatools:magma_crystal_refined'},
		{'magmatools:magma_crystal_refined', 'default:torch'},
		{'', 'default:torch'},
	}
})

minetest.register_craft({
	output = 'magmatools:shovel_magma',
	recipe = {
		{'magmatools:magma_crystal_refined'},
		{'default:torch'},
		{'default:torch'},
	}
})


minetest.register_craft({
	output = 'magmatools:hoe_magma',
	recipe = {
		{'magmatools:magma_crystal_refined','magmatools:magma_crystal_refined'},
		{'','default:torch'},
		{'','default:torch'},
	}
})
if minetest.get_modpath("paxels") == nil then
	minetest.register_craft({
		output = 'magmatools:paxel_magma',
		recipe = {
			{'magmatools:axe_magma','magmatools:shovel_magma','magmatools:pick_magma'},
			{'','magmatools:magma_crystal_refined',''},
			{'','magmatools:magma_crystal_refined',''},
		}
	})
end

minetest.register_craft({
		type = "shapeless",
		output = 'magmatools:magma_crystal_refined 9',
		recipe = {'magmatools:magma_crystal_block'},
	})

minetest.register_craft({
		output = 'magmatools:magma_crystal_block',
		recipe = {
				{'magmatools:magma_crystal_refined','magmatools:magma_crystal_refined','magmatools:magma_crystal_refined'},
				{'magmatools:magma_crystal_refined','magmatools:magma_crystal_refined','magmatools:magma_crystal_refined'},
				{'magmatools:magma_crystal_refined','magmatools:magma_crystal_refined','magmatools:magma_crystal_refined'},
		}
})

minetest.register_node('magmatools:magma_crystal_block', {
        description = 'Refined Magma Crystal Block',
        tiles = {'magmatools_magma_crystal_block_top.png', 'magmatools_magma_crystal_block_bottom.png', 'magmatools_magma_crystal_block.png'},
		light_source = LIGHT_MAX,
        groups = {cracky=1,level=3},
        sounds = default.node_sound_stone_defaults(),
})

minetest.register_tool('magmatools:sword_magma', {
	description = 'Magma Sword',
	inventory_image = 'magmatools_tool_magmasword.png',
	tool_capabilities = {
		full_punch_interval = 0.4,
		max_drop_level=1,
		groupcaps={
			snappy={times={[1]=1.50, [2]=0.60, [3]=0.20}, uses=50, maxlevel=3},
		},
		damage_groups = {fleshy=10},
	}
})

minetest.register_tool('magmatools:pick_magma', {
	description = 'Magma Pickaxe',
	inventory_image = 'magmatools_tool_magmapick.png',
	tool_capabilities = {
		full_punch_interval = 0.4,
		max_drop_level=3,
		groupcaps={
			cracky = {times={[1]=0.90, [2]=0.40, [3]=0.10}, uses=50, maxlevel=3},
		},
		damage_groups = {fleshy=6},
	},
})

minetest.register_tool('magmatools:shovel_magma', {
	description = 'Magma Shovel',
	inventory_image = 'magmatools_tool_magmashovel.png',
	wield_image = 'magmatools_tool_magmashovel.png^[transformR90',
	tool_capabilities = {
		full_punch_interval = 0.4,
		max_drop_level=1,
		groupcaps={
			crumbly = {times={[1]=0.90, [2]=0.40, [3]=0.10}, uses=50, maxlevel=3},
		},
		damage_groups = {fleshy=5},
	},
})

minetest.register_tool('magmatools:axe_magma', {
	description = 'Magma Axe',
	inventory_image = 'magmatools_tool_magmaaxe.png',
	tool_capabilities = {
		full_punch_interval = 0.4,
		max_drop_level=1,
		groupcaps={
			choppy={times={[1]=0.90, [2]=0.40, [3]=0.10}, uses=50, maxlevel=2},
		},
		damage_groups = {fleshy=7},
	},
})


minetest.register_tool('magmatools:hoe_magma', {
    description = 'Magma Hoe',
    inventory_image = 'magmatools_tool_magmahoe.png',
    liquids_pointable = true,
    on_use = function(itemstack, user, pointed_thing)
        if pointed_thing.type ~= 'node' then
            return
        end
        local liquiddef = bucket.liquids['default:water_source']
		node = minetest.get_node(pointed_thing.under)
		if liquiddef ~= nil and liquiddef.itemname ~= nil and (node.name == liquiddef.source or
            (node.name == 'default:water_source' or node.name == 'default:water_flowing')) then
            minetest.add_node(pointed_thing.under, {name='default:obsidian'})
        itemstack:add_wear(65535/70)
        return itemstack
        end
    end
})

minetest.register_tool('magmatools:paxel_magma', {
	description = 'Magma Paxel',
	inventory_image = 'magmatools_tool_magmapaxel.png',
	tool_capabilities = {
		full_punch_interval = 0.4,
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
	ore_type       = 'scatter',
	ore            = 'magmatools:stone_with_magma_crystal',
	wherein        = 'default:stone',
	clust_scarcity = 24*24*24,
	clust_num_ores = 20,
	clust_size     = 6,
	height_min     = -31000,
	height_max     = -64,
	flags          = 'absheight',
})

minetest.register_ore({
	ore_type       = 'scatter',
	ore            = 'magmatools:stone_with_magma_crystal',
	wherein        = 'default:stone',
	clust_scarcity = 24*24*24,
	clust_num_ores = 24,
	clust_size     = 6,
	height_min     = -31000,
	height_max     = -128,
	flags          = 'absheight',
})