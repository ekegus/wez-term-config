local wezterm = require("wezterm")
local act = wezterm.action

wezterm.on("update-right-status", function(window)
	window:set_right_status(window:active_workspace())
end)

local module = {}

local keys = {
	-- https://github.com/wez/wezterm/issues/522
	{
		key = "t",
		mods = "SUPER|SHIFT",
		action = act.PromptInputLine({
			description = "Enter new name for tab",
			action = wezterm.action_callback(function(window, _, line)
				-- line will be `nil` if they hit escape without entering anything
				-- An empty string if they just hit enter
				-- Or the actual line of text they wrote
				if line then
					window:active_tab():set_title(line)
				end
			end),
		}),
	},
	{
		key = "d",
		mods = "CMD",
		action = act.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "d",
		mods = "CMD|SHIFT",
		action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "s",
		mods = "CMD|SHIFT",
		action = act.TogglePaneZoomState,
	},
	{
		key = "w",
		mods = "CMD|SHIFT",
		action = act.ShowLauncherArgs({
			flags = "FUZZY|WORKSPACES",
		}),
	},
	{
		key = "c",
		mods = "CMD|SHIFT",
		action = act.PromptInputLine({
			description = wezterm.format({
				{ Attribute = { Intensity = "Bold" } },
				{ Foreground = { AnsiColor = "Fuchsia" } },
				{ Text = "Enter name for new workspace." },
			}),
			action = wezterm.action_callback(function(window, pane, line)
				if line then
					window:perform_action(
						act.SwitchToWorkspace({
							name = line,
						}),
						pane
					)
				end
			end),
		}),
	},
	{
		key = "r",
		mods = "SUPER|SHIFT",
		action = act.PromptInputLine({
			description = "Enter new name for workspace",
			action = wezterm.action_callback(function(_, _, line)
				-- line will be `nil` if they hit escape without entering anything
				-- An empty string if they just hit enter
				-- Or the actual line of text they wrote
				if line then
					wezterm.mux.rename_workspace(wezterm.mux.get_active_workspace(), line)
				end
			end),
		}),
	},
}

module.keys = keys

return module
