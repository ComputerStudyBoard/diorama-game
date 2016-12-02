--------------------------------------------------
local BreakMenuItem = require ("gamemodes/default/mods/frontend_menus/menu_items/break_menu_item")
local ButtonMenuItem = require ("gamemodes/default/mods/frontend_menus/menu_items/button_menu_item")
local LabelMenuItem = require ("gamemodes/default/mods/frontend_menus/menu_items/label_menu_item")
local Menus = require ("gamemodes/default/mods/frontend_menus/menu_construction")
local MenuClass = require ("gamemodes/default/mods/frontend_menus/menu_class")
local Mixin = require ("gamemodes/default/mods/frontend_menus/mixin")

--------------------------------------------------
local function onSinglePlayerClicked ()
    return "single_player_top_menu"
end

--------------------------------------------------
local function onMultiplayerClicked ()
    return "mp_select_server_menu"
end

--------------------------------------------------
local function onEditPlayerClicked ()
    return "player_controls_menu"
end

--------------------------------------------------
local function onTextFileClicked (menu, file)
    menu.textFileMenu:recordFilename (file)
    return "text_file_menu"
end

--------------------------------------------------
local function onQuitClicked ()
    dio.system.closeApplication ()
    return "quitting_menu"
end

-- --------------------------------------------------
-- local function onPaintClicked ()
--     return "paint_main_menu"
-- end

-- --------------------------------------------------
-- local function onPlayTetrisClicked ()
--     return "tetris_main_menu"
-- end

--------------------------------------------------
local c = {}

--------------------------------------------------
function c:onAppShouldClose ()
    self.parent.onAppShouldClose (self)
    return "quitting_menu"
end

--------------------------------------------------
function c:onEnter (menus)
    assert (menus ~= nil)
    assert (menus.text_file_menu ~= nil)
    self.textFileMenu = menus.text_file_menu
end

--------------------------------------------------
function c:onExit ()
    self.textFileMenu = nil
end

--------------------------------------------------
function c:onRender ()
    -- dio.drawing.drawTexture2 (self.texture1, 0, 48)
    -- dio.drawing.drawTexture2 (self.texture2, 32, 0)
    local result = self.parent.onRender (self)
    return result
end

--------------------------------------------------
-- function c:onRenderLate ()
--     dio.drawing.drawTexture2 (self.texture1, 256, 16)
--     dio.drawing.drawTexture2 (self.texture2, 1024, 256)
-- end

--------------------------------------------------
return function ()

    local instance = MenuClass ("Diorama")

    local properties =
    {
    }

    Mixin.CopyTo (instance, properties)
    Mixin.CopyToAndBackupParents (instance, c)

    instance:addMenuItem (ButtonMenuItem ("Single Player", onSinglePlayerClicked))
    instance:addMenuItem (ButtonMenuItem ("Multiplayer", onMultiplayerClicked))
    instance:addMenuItem (ButtonMenuItem ("Options", onEditPlayerClicked))

    instance:addMenuItem (BreakMenuItem ())

    instance:addMenuItem (ButtonMenuItem ("Read 'readme.txt'", function (menuItem, menu) return onTextFileClicked   (menu, "readme.txt"  ) end))
    instance:addMenuItem (ButtonMenuItem ("Read 'contrib.txt'", function (menuItem, menu) return onTextFileClicked  (menu, "contrib.txt" ) end))
    instance:addMenuItem (ButtonMenuItem ("Read 'licenses.txt'", function (menuItem, menu) return onTextFileClicked (menu, "licenses.txt") end))

    instance:addMenuItem (BreakMenuItem ())

    -- instance:addMenuItem (ButtonMenuItem ("Paint", onPaintClicked))
    -- instance:addMenuItem (ButtonMenuItem ("Play Block Falling Game", onPlayTetrisClicked))

    -- instance:addMenuItem (BreakMenuItem ())

    instance:addMenuItem (ButtonMenuItem ("Quit Game", onQuitClicked))

    local versionInfo = dio.system.getVersion ()

    instance:addMenuItem (LabelMenuItem (""))
    instance:addMenuItem (LabelMenuItem (versionInfo.title))
    instance:addMenuItem (LabelMenuItem (versionInfo.buildDate))
    instance:addMenuItem (LabelMenuItem ("twitch.tv/robtheswan             robtheswan.com"))

    return instance
end