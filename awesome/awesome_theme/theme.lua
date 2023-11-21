---------------------------
-- Default awesome theme --
---------------------------

local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local rnotification = require("ruled.notification")
local dpi = xresources.apply_dpi
local gears = require("gears")

local gfs = require("gears.filesystem")
local themes_path = gfs.get_themes_dir()

local theme = {}

theme.font = "~/usr/share/fonts/fantasquesansmono-regular 9"

theme.bg_normal = "#001f54"
theme.bg_focus = "#001f54"
theme.bg_urgent = "#C51605"
theme.bg_minimize = "#444444"
theme.bg_systray = theme.bg_normal

theme.fg_normal = "#ffffff"
theme.fg_focus = "#ffbc42"
theme.fg_urgent = "#BE3144"
theme.fg_minimize = "#ffffff"

theme.useless_gap = dpi(5)
theme.gap_single_client = true
theme.systray_icon_spacing = 10
theme.border_width = dpi(0)
theme.border_color_normal = "#000000"
theme.border_color_active = "#535d6c"
theme.border_color_marked = "#91231c"

theme.taglist_fg_occupied = "#d81159"
theme.taglist_spacing = 6

-- Generate taglist squares:
local taglist_square_size = dpi(0)
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(taglist_square_size, theme.fg_normal)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(taglist_square_size, theme.fg_normal)

-- You can use your own layout icons like this:
theme.layout_fairh = "~/.config/awesome/awesome_theme/layouts/fairhw.png"
theme.layout_fairv = "~/.config/awesome/awesome_theme/layouts/fairvw.png"
theme.layout_floating = "~/.config/awesome/awesome_theme/layouts/floatingw.png"
theme.layout_magnifier = "~/.config/awesome/awesome_theme/layouts/magnifierw.png"
theme.layout_max = "~/.config/awesome/awesome_theme/layouts/maxw.png"
theme.layout_fullscreen = "~/.config/awesome/awesome_theme/layouts/fullscreenw.png"
theme.layout_tilebottom = "~/.config/awesome/awesome_theme/layouts/tilebottomw.png"
theme.layout_tileleft = "~/.config/awesome/awesome_theme/layouts/tileleftw.png"
theme.layout_tile = "~/.config/awesome/awesome_theme/layouts/tilew.png"
theme.layout_tiletop = "~/.config/awesome/awesome_theme/layouts/tiletopw.png"
theme.layout_spiral = "~/.config/awesome/awesome_theme/layouts/spiralw.png"
theme.layout_dwindle = "~/.config/awesome/awesome_theme/layouts/dwindlew.png"
theme.layout_cornernw = "~/.config/awesome/awesome_theme/layouts/cornernww.png"
theme.layout_cornerne = "~/.config/awesome/awesome_theme/layouts/cornernew.png"
theme.layout_cornersw = "~/.config/awesome/awesome_theme/layouts/cornersww.png"
theme.layout_cornerse = "~/.config/awesome/awesome_theme/layouts/cornersew.png"

-- Notification --
theme.notification_bg = "#212529"
theme.notification_fg = "#f8f9fa"
theme.notification_width = dpi(50)
theme.notification_height = auto
theme.notification_opacity = 8
theme.notification_border_width = 0
theme.notification_spacing = 10

theme.menu_submenu_icon = themes_path .. "default/submenu.png"
theme.menu_height = dpi(15)
theme.menu_width = dpi(100)

theme.bg_widget = "#cc0000"

theme.wallpaper = "/home/Alucard/wall/active_wallpaper.png"

theme.awesome_icon = theme_assets.awesome_icon(theme.menu_height, theme.bg_focus, theme.fg_focus)
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = "Adwaita"

-- Set different colors for urgent notifications.
rnotification.connect_signal("request::rules", function()
	rnotification.append_rule({
		rule = { urgency = "critical" },
		properties = { bg = "#e63946", fg = "#212529" },
	})
end)

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
