local wezterm = require("wezterm")
local tab_bar = require("tab_bar")

local color_scheme = "nord"

local tab_bar_theme = tab_bar.extract_tab_bar_colors_from_theme(color_scheme)

local config = wezterm.config_builder()
config.keys = tab_bar.keys

config.color_scheme = color_scheme
config.window_frame = tab_bar.merge_tables({
	font = wezterm.font("Dank Mono", { weight = "Medium" }),
	font_size = 15,
}, tab_bar_theme.window_frame_colors)
config.colors = {
	tab_bar = tab_bar_theme.tab_bar_colors,
}
config.font_size = 17.0
config.use_fancy_tab_bar = true

return config
