--------------------------------------------------
local MenuItemBase = require ("resources/scripts/menus/menu_items/menu_item_base")
local Mixin = require ("resources/scripts/menus/mixin")

--------------------------------------------------
local c = {}

--------------------------------------------------
function c:onUpdate (menu, x, y, was_left_clicked)
	self.isHighlighted = 
			x >= self.x and 
			x < self.x + self.width and
			y >= self.y and 
			y < self.y + self.height

	if was_left_clicked and self.isHighlighted then
		self.is_checked = not self.is_checked
		if self.onClicked then
			return self:onClicked (menu)
		end
	end
end

--------------------------------------------------
function c:onRender (font)
	local color = self.isHighlighted and 0xffffff or 0x00ffff
	if self.isHighlighted then
		font.drawString (self.x, self.y, ">", color)
	end
	font.drawString (self.x + 20, self.y, self.text, color)
	font.drawString (self.x + 200, self.y, "[   ]", color)
	if self.is_checked then
		font.drawString (self.x + 205, self.y, "X", color)
	end
end

--------------------------------------------------
return function (text, onClicked, is_checked)

	local instance = MenuItemBase ()

	local properties =
	{
		text = text,
		is_checked = is_checked,
		onClicked = onClicked
	}

	Mixin.CopyTo (instance, properties)
	Mixin.CopyTo (instance, c)

	return instance
end
