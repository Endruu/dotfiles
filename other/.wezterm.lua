local w = require 'wezterm'

local c = w.config_builder()

c.default_prog = { 'wsl', '-d', 'Debian' }

c.hide_tab_bar_if_only_one_tab = true

c.color_scheme = 'Tokyo Night'
c.font = w.font('JetBrains Mono')
c.harfbuzz_features = { 'calt=0' } -- disable ligatures:
c.window_background_opacity = 0.95

return c
