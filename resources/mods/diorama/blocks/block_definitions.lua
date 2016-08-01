--------------------------------------------------
-- TODO turn this into an enum
local modes =
{
    repeat1x1 = 0,
    repeat2x2 = 1,
}

--------------------------------------------------
local tiles =
{
    {mode = modes.repeat1x1, uvs = {3, 0}},                         -- side of grass (1)
    {mode = modes.repeat2x2, uvs = {7, 12, 8, 12, 7, 13, 8, 13}},   -- grass (2)
    {mode = modes.repeat1x1, uvs = {2, 0}},                         -- mud (2)
}

--------------------------------------------------
local entities =
{
    sign = {type = "SIGN", text = "Placeholder Text"}
}
--------------------------------------------------
local blocks =
{
    -- 0 = air
    -- 1
    {name = "grass",                tiles = {1, 2, 3}},
    {name = "mud",                  tiles = {3}},
    {name = "granite",              uvs = {1, 0}},
    {name = "obsidian",             uvs = {5, 2}},
    {name = "sand",                 uvs = {2, 1}},
    {name = "snowy grass",          uvs = {4, 4, 2, 4, 2, 0}},
    {name = "brick",                uvs = {7, 0}},
    {name = "tnt",                  uvs = {8, 0, 9, 0, 10, 0}},
    {name = "pumpkin",              uvs = {7, 7, 6, 7, 6, 7, 6, 7, 6, 6, 6, 6}},

    -- 10
    {name = "jump pad",             uvs = {12, 6, 11, 6, 13, 6}},
    {name = "cobble",               uvs = {0, 1}},
    {name = "trunk",                uvs = {4, 1, 5, 1, 5, 1}},
    {name = "wood",                 uvs = {4, 0}},
    {name = "leaf",                 uvs = {4, 3},                    isTransparent = false},
    {name = "glass",                uvs = {1, 3},                    isTransparent = true,    hidesMatching = true},
    {name = "lit pumpkin",          uvs = {8, 7, 6, 7, 6, 7, 6, 7, 6, 6, 6, 6}},
    {name = "melon",                uvs = {8, 8, 9, 8, 9, 8}},
    {name = "crafting table",       uvs = {11, 2}},

    -- 19
    {name = "gold",                 uvs = {7, 1}},
    {name = "slab",                 uvs = {5, 0, 6, 0, 6, 0}},
    {name = "big slab",             uvs = {6, 0}},
    {name = "gravel",               uvs = {3, 1}},
    {name = "bedrock",              uvs = {1, 1}},
    {name = "wood panel",           uvs = {9, 1}},
    {name = "books",                uvs = {3, 2, 4, 0, 4, 0}},
    {name = "mossy cobble",         uvs = {4, 2}},
    {name = "stone brick",          uvs = {6, 3}},

    -- 28
    {name = "sponge",               uvs = {8, 4}},
    {name = "herringbone",          uvs = {10, 4}},
    {name = "black wool",           uvs = {1, 7}},
    {name = "dark grey wool",       uvs = {2, 7}},
    {name = "light grey wool",      uvs = {1, 14}},
    {name = "white wool",           uvs = {0, 4}},
    {name = "dark cyan wool",       uvs = {1, 13}},
    {name = "brown wool",           uvs = {1, 10}},
    {name = "pink wool",            uvs = {2, 8}},

    -- 37
    {name = "light blue wool",      uvs = {2, 11}},
    {name = "light green wool",     uvs = {2, 9}},
    {name = "yellow wool",          uvs = {2, 10}},
    {name = "orange wool",          uvs = {2, 13}},
    {name = "red wool",             uvs = {1, 8}},
    {name = "violet wool",          uvs = {2, 12}},
    {name = "purple wool",          uvs = {1, 12}},
    {name = "dark blue wool",       uvs = {1, 11}},
    {name = "dark green wool",      uvs = {1, 9}},

    -- 46
    {name = "floating sign",        uvs = {0, 15},          entity = "sign"},
    {name = "grass",                uvs = {7, 2},           shape = "cross",    isSolid = false},
    {name = "red flower",           uvs = {12, 0},          shape = "cross",    isSolid = false},
    {name = "yellow flower",        uvs = {13, 0},          shape = "cross",    isSolid = false},
    {name = "red mushroom",         uvs = {12, 1},          shape = "cross",    isSolid = false},
    {name = "brown mushroom",       uvs = {13, 1},          shape = "cross",    isSolid = false},
    {name = "sapling",              uvs = {15, 0},          shape = "cross",    isSolid = false},
    {name = "bamboo",               uvs = {9, 4},           shape = "cross",    isSolid = false},
    {name = "wheat",                uvs = {15, 5},          shape = "cross",    isSolid = false},

    -- 55
    {name = "bush",                 uvs = {7, 3},           shape = "cross",    isSolid = false},
    {name = "stem",                 uvs = {15, 6},          shape = "cross",    isSolid = false},
    {name = "cactus top",           uvs = {6, 4, 5, 4, 7, 4}},
    {name = "cactus body",          uvs = {6, 4, 7, 4, 7, 4}},
    {name = "gravity block",        uvs = {12, 6, 10, 6, 13, 6}},
    {name = "all grass",            uvs = {0, 0}},
    {name = "water",                uvs = {14, 0},         isLiquid = true},
    {name = "ice",                  uvs = {3, 4}},
    {name = "coal block",           uvs = {1, 15}},

    -- 64
    {name = "gold ore",             uvs = {0, 2}},
    {name = "iron ore",             uvs = {1, 2}},
    {name = "coal ore",             uvs = {2, 2}},
    {name = "diamond ore",          uvs = {2, 3}},
    {name = "red ore",              uvs = {3, 3}},
    {name = "lapis ore",            uvs = {0, 10}},
    {name = "smooth sandstone",     uvs = {0, 11}},
    {name = "sandstone brick",      uvs = {0, 12}},
    {name = "hellrock",             uvs = {7, 6}},

    -- 73
    {name = "hellsand",             uvs = {8, 6}},
    {name = "spawner",              uvs = {1, 4},           isTransparent = true},
}

return {blocks = blocks, tiles = tiles, entities = entities}