--------------------------------------------------
local Menus = require ("resources/gamemodes/default/mods/frontend_menus/menu_construction")
local MenuClass = require ("resources/gamemodes/default/mods/frontend_menus/menu_class")
local Mixin = require ("resources/gamemodes/default/mods/frontend_menus/mixin")

--------------------------------------------------
local c = {}

--------------------------------------------------
function c:onSessionShutdownCompleted ()
    print ("close the application now from quitting!")
    dio.system.closeApplication ()
end

--------------------------------------------------
function c:onAppShouldClose ()
    print ("successful close from quitting!")
    return nil, false
end

--------------------------------------------------
return function ()
    local instance = MenuClass ("QUITTING MENU")
    Mixin.CopyToAndBackupParents (instance, c)
    return instance
end
