local wezterm = require("wezterm")
local tab_bar = require("tab_bar")
local colors = require("colors")
local keys_bindings = require("key_bindings")

local color_scheme = colors.color_scheme
local font = "Iosevka Nerd Font"

wezterm.on("gui-startup", function(cmd)
	local _, _, window = wezterm.mux.spawn_window(cmd or {})
	window:gui_window():maximize()
end)

local tab_bar_theme = tab_bar.extract_tab_bar_colors_from_theme(color_scheme)

local config = wezterm.config_builder()

config.keys = keys_bindings.keys

config.color_scheme = color_scheme
config.window_frame = tab_bar.merge_tables({
	font = wezterm.font(font, { weight = "DemiBold" }),
	font_size = 15,
}, tab_bar_theme.window_frame_colors)
config.colors = {
	tab_bar = tab_bar_theme.tab_bar_colors,
}
config.tab_bar_at_bottom = true
config.font_size = 16.0
config.use_fancy_tab_bar = true
config.font = wezterm.font(font, { weight = "Regular" })

return config
