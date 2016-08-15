--------------------------------------------------
local BreakMenuItem = require ("resources/gamemodes/default/mods/frontend_menus/menu_items/break_menu_item")
local ButtonMenuItem = require ("resources/gamemodes/default/mods/frontend_menus/menu_items/button_menu_item")
local Menus = require ("resources/gamemodes/default/mods/frontend_menus/menu_construction")
local MenuClass = require ("resources/gamemodes/default/mods/frontend_menus/menu_class")
local Mixin = require ("resources/gamemodes/default/mods/frontend_menus/mixin")

--------------------------------------------------
local function addMenuButton (menu, text, to_menu)
    local button = ButtonMenuItem (text,      function () return to_menu end)
    menu:addMenuItem (button)
end

--------------------------------------------------
local c = {}

--------------------------------------------------
function c:onAppShouldClose ()
    self.parent.onAppShouldClose (self)
    return "quitting_menu"
end

--------------------------------------------------
return function ()

    local instance = MenuClass ("Create New Level")

    local properties =
    {
    }

    Mixin.CopyTo (instance, properties)
    Mixin.CopyToAndBackupParents (instance, c)

    addMenuButton (instance, "Back To Back",        "back_to_back_terrain_type_menu")
    addMenuButton (instance, "Cubic World",         "cubic_terrain_type_menu")
    addMenuButton (instance, "Normal",              "flat_terrain_type_menu")
    addMenuButton (instance, "Floating Islands",    "floating_islands_terrain_type_menu")
    addMenuButton (instance, "Hollow Earth",        "hollow_earth_terrain_type_menu")
    addMenuButton (instance, "Parallel World",      "parallel_facing_terrain_type_menu")
    addMenuButton (instance, "Square World",        "square_ring_terrain_type_menu")

    instance:addMenuItem (BreakMenuItem ())

    addMenuButton (instance, "Return To Parent Menu",       "single_player_top_menu")

    return instance
end
