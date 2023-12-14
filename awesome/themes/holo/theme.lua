local gears = require("gears")
local lain = require("lain")
local awful = require("awful")
local wibox = require("wibox")
local dpi = require("beautiful.xresources").apply_dpi

local string, os = string, os
local my_table = gears.table

local theme = {}
theme.default_dir = require("awful.util").get_themes_dir() .. "default"
theme.icon_dir = os.getenv("HOME") .. "/.config/awesome/themes/holo/icons"
theme.wallpaper = os.getenv("HOME") .. "/wall/active_wallpaper.png"
theme.font = "eldur Bold 10"
theme.taglist_font = "eldur Condensed Regular 9"
theme.fg_normal = "#FFFFFF"
theme.fg_focus = "#0099CC"
theme.bg_focus = "#303030"
theme.bg_normal = "#000000"
theme.fg_urgent = "#CC9393"
theme.bg_urgent = "#006B8E"
theme.border_width = dpi(0)
theme.border_normal = "#252525"
theme.border_focus = "#0099CC"
theme.taglist_fg_focus = "#FFFFFF"
theme.tasklist_bg_normal = "#222222"
theme.tasklist_fg_focus = "#4CB7DB"
theme.menu_height = dpi(20)
theme.menu_width = dpi(180)
theme.menu_icon_size = dpi(8)
theme.awesome_icon = theme.icon_dir .. "/awesome_icon_white.png"
theme.awesome_icon_launcher = theme.icon_dir .. "/awesome_icon.png"
theme.taglist_squares_sel = theme.icon_dir .. "/square_sel.png"
theme.taglist_squares_unsel = theme.icon_dir .. "/square_unsel.png"
theme.spr_small = theme.icon_dir .. "/spr_small.png"
theme.spr_very_small = theme.icon_dir .. "/spr_very_small.png"
theme.spr_right = theme.icon_dir .. "/spr_right.png"
theme.spr_bottom_right = theme.icon_dir .. "/spr_bottom_right.png"
theme.spr_left = theme.icon_dir .. "/spr_left.png"
theme.bar = theme.icon_dir .. "/bar.png"
theme.bottom_bar = theme.icon_dir .. "/bottom_bar.png"
theme.mpdl = theme.icon_dir .. "/mpd.png"
theme.mpd_on = theme.icon_dir .. "/mpd_on.png"
theme.prev = theme.icon_dir .. "/prev.png"
theme.nex = theme.icon_dir .. "/next.png"
theme.stop = theme.icon_dir .. "/stop.png"
theme.pause = theme.icon_dir .. "/pause.png"
theme.play = theme.icon_dir .. "/play.png"
theme.clock = theme.icon_dir .. "/clock.png"
theme.calendar = theme.icon_dir .. "/cal.png"
theme.cpu = theme.icon_dir .. "/cpu.png"
theme.net_up = theme.icon_dir .. "/net_up.png"
theme.net_down = theme.icon_dir .. "/net_down.png"
theme.layout_tile = theme.icon_dir .. "/tile.png"
theme.layout_tileleft = theme.icon_dir .. "/tileleft.png"
theme.layout_tilebottom = theme.icon_dir .. "/tilebottom.png"
theme.layout_tiletop = theme.icon_dir .. "/tiletop.png"
theme.layout_fairv = theme.icon_dir .. "/fairv.png"
theme.layout_fairh = theme.icon_dir .. "/fairh.png"
theme.layout_spiral = theme.icon_dir .. "/spiral.png"
theme.layout_dwindle = theme.icon_dir .. "/dwindle.png"
theme.layout_max = theme.icon_dir .. "/max.png"
theme.layout_fullscreen = theme.icon_dir .. "/fullscreen.png"
theme.layout_magnifier = theme.icon_dir .. "/magnifier.png"
theme.layout_floating = theme.icon_dir .. "/floating.png"
theme.tasklist_plain_task_name = true
theme.tasklist_disable_icon = true
theme.useless_gap = dpi(4)

theme.musicplr = string.format("%s -e ncmpcpp", awful.util.terminal)

local markup = lain.util.markup

local space3 = markup.font("eldur 3", " ")

-- Clock
local mytextclock = wibox.widget.textclock(markup("#FFFFFF", space3 .. "%H:%M   " .. markup.font("eldur 4", " ")))
mytextclock.font = theme.font
local clock_icon = wibox.widget.imagebox(theme.clock)
local clockbg = wibox.container.background(mytextclock, theme.bg_focus, gears.shape.rectangle)
local clockwidget = wibox.container.margin(clockbg, dpi(0), dpi(3), dpi(5), dpi(5))

-- Calendar
local mytextcalendar =
	wibox.widget.textclock(markup.fontfg(theme.font, "#FFFFFF", space3 .. "%d %b " .. markup.font("eldur 5", " ")))
local calendar_icon = wibox.widget.imagebox(theme.calendar)
local calbg = wibox.container.background(mytextcalendar, theme.bg_focus, gears.shape.rectangle)
local calendarwidget = wibox.container.margin(calbg, dpi(0), dpi(0), dpi(5), dpi(5))
theme.cal = lain.widget.cal({
	attach_to = { mytextclock, mytextcalendar },
	notification_preset = {
		fg = "#FFFFFF",
		bg = theme.bg_normal,
		position = "top_right",
		font = "eldur 10",
	},
})

-- MPD
local mpd_icon = awful.widget.launcher({ image = theme.mpdl, command = theme.musicplr })
local prev_icon = wibox.widget.imagebox(theme.prev)
local next_icon = wibox.widget.imagebox(theme.nex)
local stop_icon = wibox.widget.imagebox(theme.stop)
local pause_icon = wibox.widget.imagebox(theme.pause)
local play_pause_icon = wibox.widget.imagebox(theme.play)
theme.mpd = lain.widget.mpd({
	settings = function()
		if mpd_now.state == "play" then
			mpd_now.artist = mpd_now.artist:upper():gsub("&.-;", string.lower)
			mpd_now.title = mpd_now.title:upper():gsub("&.-;", string.lower)
			widget:set_markup(
				markup.font("eldur 4", " ")
					.. markup.font(theme.taglist_font, " " .. mpd_now.artist .. " - " .. mpd_now.title .. "  ")
					.. markup.font("eldur 5", " ")
			)
			play_pause_icon:set_image(theme.pause)
		elseif mpd_now.state == "pause" then
			widget:set_markup(
				markup.font("eldur 4", " ")
					.. markup.font(theme.taglist_font, " MPD PAUSED  ")
					.. markup.font("eldur 5", " ")
			)
			play_pause_icon:set_image(theme.play)
		else
			widget:set_markup("")
			play_pause_icon:set_image(theme.play)
		end
	end,
})
local musicbg = wibox.container.background(theme.mpd.widget, theme.bg_focus, gears.shape.rectangle)
local musicwidget = wibox.container.margin(musicbg, dpi(0), dpi(0), dpi(5), dpi(5))

musicwidget:buttons(my_table.join(awful.button({}, 1, function()
	awful.spawn(theme.musicplr)
end)))
prev_icon:buttons(my_table.join(awful.button({}, 1, function()
	os.execute("mpc prev")
	theme.mpd.update()
end)))
next_icon:buttons(my_table.join(awful.button({}, 1, function()
	os.execute("mpc next")
	theme.mpd.update()
end)))
stop_icon:buttons(my_table.join(awful.button({}, 1, function()
	play_pause_icon:set_image(theme.play)
	os.execute("mpc stop")
	theme.mpd.update()
end)))
play_pause_icon:buttons(my_table.join(awful.button({}, 1, function()
	os.execute("mpc toggle")
	theme.mpd.update()
end)))

-- ALSA volume bar
theme.volume = lain.widget.alsabar({
	notification_preset = { font = "eldur 9" },
	--togglechannel = "IEC958,3",
	width = dpi(80),
	height = dpi(10),
	border_width = dpi(0),
	colors = {
		background = "#383838",
		unmute = "#80CCE6",
		mute = "#FF9F9F",
	},
})
theme.volume.bar.paddings = dpi(0)
theme.volume.bar.margins = dpi(5)
local volumewidget = wibox.container.background(theme.volume.bar, theme.bg_focus, gears.shape.rectangle)
volumewidget = wibox.container.margin(volumewidget, dpi(0), dpi(0), dpi(5), dpi(5))

-- CPU
local cpu_icon = wibox.widget.imagebox(theme.cpu)
local cpu = lain.widget.cpu({
	settings = function()
		widget:set_markup(
			space3 .. markup.font(theme.font, "CPU " .. cpu_now.usage .. "% ") .. markup.font("eldur 5", " ")
		)
	end,
})
local cpubg = wibox.container.background(cpu.widget, theme.bg_focus, gears.shape.rectangle)
local cpuwidget = wibox.container.margin(cpubg, dpi(0), dpi(0), dpi(5), dpi(5))

-- Launcher
local mylauncher = awful.widget.button({ image = theme.awesome_icon_launcher })
mylauncher:connect_signal("button::press", function()
	awful.util.mymainmenu:toggle()
end)

-- Separators
local first = wibox.widget.textbox('<span font="eldur 7"> </span>')
local spr_small = wibox.widget.imagebox(theme.spr_small)
local spr_very_small = wibox.widget.imagebox(theme.spr_very_small)
local spr_right = wibox.widget.imagebox(theme.spr_right)
local spr_bottom_right = wibox.widget.imagebox(theme.spr_bottom_right)
local spr_left = wibox.widget.imagebox(theme.spr_left)
local bar = wibox.widget.imagebox(theme.bar)
local bottom_bar = wibox.widget.imagebox(theme.bottom_bar)

local barcolor = gears.color({
	type = "linear",
	from = { dpi(32), 0 },
	to = { dpi(32), dpi(32) },
	stops = { { 0, theme.bg_focus }, { 0.25, "#505050" }, { 1, theme.bg_focus } },
})

function theme.at_screen_connect(s)
	-- Quake application
	s.quake = lain.util.quake({ app = awful.util.terminal })

	-- If wallpaper is a function, call it with the screen
	local wallpaper = theme.wallpaper
	if type(wallpaper) == "function" then
		wallpaper = wallpaper(s)
	end
	gears.wallpaper.maximized(wallpaper, s, true)

	-- Tags
	awful.tag(awful.util.tagnames, s, awful.layout.layouts[1])

	-- Create a promptbox for each screen
	s.mypromptbox = awful.widget.prompt()
	-- Create an imagebox widget which will contains an icon indicating which layout we're using.
	-- We need one layoutbox per screen.
	s.mylayoutbox = awful.widget.layoutbox(s)
	s.mylayoutbox:buttons(my_table.join(
		awful.button({}, 1, function()
			awful.layout.inc(1)
		end),
		awful.button({}, 2, function()
			awful.layout.set(awful.layout.layouts[1])
		end),
		awful.button({}, 3, function()
			awful.layout.inc(-1)
		end),
		awful.button({}, 4, function()
			awful.layout.inc(1)
		end),
		awful.button({}, 5, function()
			awful.layout.inc(-1)
		end)
	))
	-- Create a taglist widget
	s.mytaglist =
		awful.widget.taglist(s, awful.widget.taglist.filter.all, awful.util.taglist_buttons, { bg_focus = barcolor })

	mytaglistcont = wibox.container.background(s.mytaglist, theme.bg_focus, gears.shape.rectangle)
	s.mytag = wibox.container.margin(mytaglistcont, dpi(5), dpi(5), dpi(5), dpi(5))

	-- Create a tasklist widget
	s.mytasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, awful.util.tasklist_buttons, {
		bg_focus = theme.bg_focus,
		shape = gears.shape.rectangle,
		shape_border_width = 5,
		shape_border_color = theme.tasklist_bg_normal,
		align = "center",
	})
	-- local systray
	local systray = wibox.widget.systray()
	systray:set_base_size(18)
	systray:set_horizontal(true)

	-- Create the wibox
	s.mywibox = awful.wibar({ position = "top", screen = s, height = dpi(32) })

	-- Add widgets to the wibox
	s.mywibox:setup({
		layout = wibox.layout.align.horizontal,
		{ -- Left widgets
			layout = wibox.layout.fixed.horizontal,
			mylauncher,
			first,
			s.mytag,
			s.mypromptbox,
		},
		nil, -- Middle widget
		{ -- Right widgets
			layout = wibox.layout.fixed.horizontal,
			{
				widget = wibox.container.place,
				systray,
				valign = "center",
				halign = "center",
			},

			musicwidget,
			bar,
			prev_icon,
			next_icon,
			stop_icon,
			play_pause_icon,
			bar,
			mpd_icon,
			bar,
			volumewidget,
			spr_left,
			bottom_bar,

			cpu_icon,
			cpuwidget,
			bottom_bar,
			calendar_icon,
			calendarwidget,
			bottom_bar,
			clock_icon,
			clockwidget,
			{
				widget = wibox.container.place,
				systray,
				valign = "center",
				halign = "center",
			},
		},
	})
end

return theme
