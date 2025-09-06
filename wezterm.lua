local wezterm = require 'wezterm'
local act = wezterm.action

return {
  front_end = "WebGpu",
  color_scheme = "Solarized (light) (terminal.sexy)",
  font = wezterm.font 'Fira Code',
  font_size = 14.0,
  default_prog = { os.getenv("HOME") .. "/.nix-profile/bin/fish" },
  audible_bell = "Disabled",

  keys = {
    {
      key = '|',
      mods = 'CTRL|SHIFT|ALT',
      action = act.SplitHorizontal { domain = 'CurrentPaneDomain' },
    },
    {
      key = 'w',
      mods = 'CMD',
      action = act.CloseCurrentPane { confirm = true },
    },
    {
      key = 'h',
      mods = 'CTRL|SHIFT',
      action = act.ActivatePaneDirection 'Left',
    },
    {
      key = 'l',
      mods = 'CTRL|SHIFT',
      action = act.ActivatePaneDirection 'Right',
    },
    {
      key = 'k',
      mods = 'CTRL|SHIFT',
      action = act.ActivatePaneDirection 'Up',
    },
    {
      key = 'j',
      mods = 'CTRL|SHIFT',
      action = act.ActivatePaneDirection 'Down',
    },
  }
}
