local wezterm = require 'wezterm'

return {
  front_end = "WebGpu",
  color_scheme = "Solarized Light (Gogh)",
  font = wezterm.font 'Fira Code',
  font_size = 14.0,
  default_prog = { os.getenv("HOME") .. "/.nix-profile/bin/fish" },
}
