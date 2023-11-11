-- volume_widget.lua

local awful = require("awful")
local wibox = require("wibox")

local function get_volume_status()
	local status = io.popen("amixer sget Master"):read("*all")
	return string.match(status, "%[(o[^%]]*)%]") == "on", string.match(status, "(%d?%d?%d)%%")
end

local volume_widget = wibox.widget({
	{
		id = "icon",
		image = "", -- Replace with the path to your volume icon
		widget = wibox.widget.imagebox,
	},
	{
		id = "text",
		widget = wibox.widget.textbox,
	},
	layout = wibox.layout.fixed.horizontal,
})

local update_widget = function()
	local is_muted, volume_level = get_volume_status()

	local icon = volume_widget:get_children_by_id("icon")[1]
	local text = volume_widget:get_children_by_id("text")[1]

	if is_muted then
		icon.image = "󰖁" -- Replace with the path to your mute icon
		text:set_text("Muted")
	else
		icon.image = "" -- Replace with the path to your volume icon
		text:set_text("Vol: " .. volume_level .. "%")
	end
end

update_widget()

-- Update the widget on right-click (button 3)
volume_widget:buttons(awful.button({}, 3, function()
	awful.spawn.with_shell("amixer -q set Master toggle")
	update_widget()
end))

-- Update the widget every 5 seconds (you can adjust this interval)
awful.widget.watch("bash -c 'amixer sget Master'", 5, function(_, stdout)
	update_widget()
end)

return volume_widget
