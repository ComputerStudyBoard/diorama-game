--------------------------------------------------
local BreakMenuItem = require ("resources/scripts/menus/menu_items/break_menu_item")
local ButtonMenuItem = require ("resources/scripts/menus/menu_items/button_menu_item")
local CheckboxMenuItem = require ("resources/scripts/menus/menu_items/checkbox_menu_item")
local KeySelectMenuItem = require ("resources/scripts/menus/menu_items/key_select_menu_item")
local Menus = require ("resources/scripts/menus/menu_construction")
local MenuClass = require ("resources/scripts/menus/menu_class")
local Mixin = require ("resources/scripts/menus/mixin")

--------------------------------------------------
local function onSaveClicked (self, menu)
	dio.inputs.mouse.setIsInverted (menu.invert_mouse_checkbox.is_checked)
	return "main_menu"
end

--------------------------------------------------
local function onCancelClicked ()
	return "main_menu"
end

--------------------------------------------------
local c = {}

-- --------------------------------------------------
-- function c:onAppShouldClose (parent_func)
-- 	parent_func (self)
-- 	return "quitting_menu"
-- end

--------------------------------------------------
function c:onEnter ()
	self.invert_mouse_checkbox:setIsChecked (dio.inputs.mouse.getIsInverted ())
end

-- --------------------------------------------------
-- function c:onExit ()
-- 	dio.session.terminate ()
-- end

--------------------------------------------------
return function ()

	local instance = MenuClass ("PLAYER CONTROLS MENU")

	Mixin.CopyTo (instance, c)

	local is_mouse_inverted = dio.inputs.mouse.getIsInverted ()

	instance:addMenuItem (BreakMenuItem ())
	local checkbox = instance:addMenuItem (CheckboxMenuItem ("Invert Mouse", nil, is_mouse_inverted))
	local f = instance:addMenuItem (KeySelectMenuItem ("Forward", nil, "W"))
	local l = instance:addMenuItem (KeySelectMenuItem ("Left", nil, "A"))
	local b = instance:addMenuItem (KeySelectMenuItem ("Back", nil, "S"))
	local r = instance:addMenuItem (KeySelectMenuItem ("Right", nil, "D"))
	local j = instance:addMenuItem (KeySelectMenuItem ("Jump", nil, "SPACE"))
	local t = instance:addMenuItem (KeySelectMenuItem ("Turbo", nil, "LEFT SHIFT"))
	instance:addMenuItem (BreakMenuItem ())
	instance:addMenuItem (ButtonMenuItem ("Save", onSaveClicked))	
	instance:addMenuItem (BreakMenuItem ())
	instance:addMenuItem (ButtonMenuItem ("Cancel", onCancelClicked))	

	instance.invert_mouse_checkbox = checkbox

	return instance
end
