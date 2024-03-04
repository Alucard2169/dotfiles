-- powermenu_widget.lua

local awful = require("awful")
local wibox = require("wibox")

local powermenu_widget = wibox.widget({
	{
		text = " ",
		halign = "center",
		valign = "center",
		widget = wibox.widget.textbox,
	},
	forced_width = 25,
	forced_height = 25,
	layout = wibox.layout.fixed.horizontal,
})

powermenu_widget:buttons(awful.button({}, 1, function()
	awful.spawn.with_shell("$HOME/.config/awesome/widgets/powermenu/powermenu.sh")
end))

return powermenu_widget
