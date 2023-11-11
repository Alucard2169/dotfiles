local awful = require("awful")
local wibox = require("wibox")

-- Create a text widget with a Nerd Font network icon
local network_icon = wibox.widget.textbox("󰤨  ") -- You can replace "直" with the Nerd Font network icon of your choice
network_icon.font = "Nerd Font 12" -- Change the font and size as needed

-- Create a function to check the network connection status
local function check_network_status()
	local iface = "wlp0s29u1u6" -- Change this to your network interface (e.g., wlan0)
	local status = io.popen("ip link show " .. iface .. " | grep 'state UP'"):read("*a")
	return status and status:find("state UP")
end

-- Create a function to update the network icon
local function update_network_icon()
	if check_network_status() then
		network_icon.text = "󰤨 " -- Use the connected icon
	else
		network_icon.text = "󰤭 " -- Use the not connected icon
	end
end

-- Add a click event to open nmtui when the widget is clicked
network_icon:connect_signal("button::press", function(_, _, _, button)
	if button == 1 then
		awful.spawn("alacritty -e nmtui")
	end
end)

-- Update the network icon initially
update_network_icon()

-- Create a timer to periodically update the network icon
local network_status_timer = timer({ timeout = 30 })
network_status_timer:connect_signal("timeout", update_network_icon)
network_status_timer:start()

-- Create a wibox container for the network icon
local network_widget = wibox.container.margin(network_icon, 5, 5)

return network_widget
