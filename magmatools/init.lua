-- mods/magmatools/init.lua

minetest.register_node('magmatools:stone_with_magma_crystal', {
	description = 'Magma Crystal Ore',
	tiles = {'default_stone.png^magmatools_mineral_magma_crystal.png'},
	light_source = 7,
	is_ground_content = true,
	groups = {level=2, cracky=2},
	drop = 'magmatools:magma_crystal',
	sounds = default.node_sound_stone_defaults(),
	clust_scarcity = 9 * 9 * 9,
	clust_size = 9,
	clust_num_ores = 3,
	y_max = -80,
})

minetest.register_craftitem('magmatools:magma_crystal', {
	description = 'Magma Crystal',
	inventory_image = 'magmatools_magma_crystal.png',
})

minetest.register_craftitem('magmatools:lava_source', {
	description = 'Lava',
	inventory_image = minetest.inventorycube("default_lava.png"),
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

minetest.register_craft({
		output = 'bucket:bucket_lava',
		recipe = {
				{'magmatools:lava_source'},
				{'bucket:bucket_empty'},
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
	},
	minetest.register_on_punchnode(function(pos, node, puncher, pointed_thing)
		if puncher:get_wielded_item():get_name() == 'magmatools:sword_magma' then
			if node.name ~= "air" then
				minetest.add_node(pointed_thing.above, {name = "fire:basic_flame"})
			end
		end
	end)
})

local old_handle_node_drops = minetest.handle_node_drops
function minetest.handle_node_drops(pos, drops, digger)
    local tool = digger:get_wielded_item():get_name()
    if tool == ('magmatools:pick_magma') or (tool == 'magmatools:axe_magma') or (tool == 'magmatools:shovel_magma') or (tool == 'magmatools:paxel_magma') then
        local newdrops = { }
        for _, drop in ipairs(drops) do
            local stack = ItemStack(drop)
			local product = minetest.get_craft_result({method = "cooking", width = 1, items = {drop}})
            if product and product.item and (not product.item:is_empty())  then
                table.insert(newdrops, ItemStack({
                    name = product.item:get_name(),
                    count = stack:get_count(),
                }))
            else
                table.insert(newdrops, stack)
            end
        end
        drops = newdrops
    end
    return old_handle_node_drops(pos, drops, digger)
end



local groupcaps ={times={[1]=1.20, [2]=0.60, [3]=0.30}, uses=40, maxlevel=3}
minetest.register_tool('magmatools:pick_magma', {
	description = 'Magma Pickaxe',
	inventory_image = 'magmatools_tool_magmapick.png',
	tool_capabilities = {
		full_punch_interval = 0.4,
		max_drop_level=3,
		groupcaps={
			cracky = groupcaps,
		},
		damage_groups = {fleshy=6},
	},
})

minetest.register_tool('magmatools:shovel_magma', {
	description = 'Magma Shovel',
	liquids_pointable = true,
	inventory_image = 'magmatools_tool_magmashovel.png',
	wield_image = 'magmatools_tool_magmashovel.png^[transformR90',
	tool_capabilities = {
		full_punch_interval = 0.4,
		max_drop_level=1,
		groupcaps={
			crumbly = groupcaps,
		},
		damage_groups = {fleshy=5},
	},

	minetest.register_on_punchnode(function(pos, node, puncher, pointed_thing)
		if puncher:get_wielded_item():get_name() == 'magmatools:shovel_magma' then
			if node.name == "default:lava_source" then
				minetest.remove_node(pos)
				local inv = puncher:get_inventory()
				if inv then
					inv:add_item("main", "magmatools:lava_source")
				end
			elseif node.name == "default:lava_flowing" then
				minetest.remove_node(pos)
			end
		end
	end)
})

minetest.register_tool('magmatools:axe_magma', {
	description = 'Magma Axe',
	inventory_image = 'magmatools_tool_magmaaxe.png',
	liquids_pointable = true,
	tool_capabilities = {
		full_punch_interval = 0.4,
		max_drop_level=1,
		groupcaps={
			choppy=groupcaps,
		},
		damage_groups = {fleshy=7},
	},
	minetest.register_on_punchnode(function(pos, node, puncher, pointed_thing)
		if puncher:get_wielded_item():get_name() == 'magmatools:axe_magma' then
			if node.name == "default:lava_source" then
				minetest.add_node(pos, { name="default:lava_flowing"})
			elseif node.name == "default:lava_flowing" then
				minetest.remove_node(pos)
			end
		end
	end)
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
        --itemstack:add_wear(65535/70)
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
			choppy = groupcaps,
			crumbly = groupcaps,
			cracky = groupcaps,
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
	y_min     = -31000,
	y_max     = -64,
	flags          = 'absheight',
})

minetest.register_ore({
	ore_type       = 'scatter',
	ore            = 'magmatools:stone_with_magma_crystal',
	wherein        = 'default:stone',
	clust_scarcity = 24*24*24,
	clust_num_ores = 24,
	clust_size     = 6,
	y_min     = -31000,
	y_max     = -128,
	flags          = 'absheight',
})
