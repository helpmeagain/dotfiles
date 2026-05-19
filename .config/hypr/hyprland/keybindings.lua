require("hyprland.variables")

-- Custom Bindings
hl.bind(MainMod .. " + T", hl.dsp.exec_cmd(terminal))
hl.bind(MainMod .. " + Return", hl.dsp.exec_cmd(terminal))
hl.bind(MainMod .. " + F", hl.dsp.window.fullscreen({mode = "maximized"}))
hl.bind(MainMod .. " + SHIFT + F", hl.dsp.window.fullscreen())
hl.bind("Print", hl.dsp.exec_cmd("hyprshot -m output -z -o ~/Imagens/Printscreen -s"))
hl.bind(MainMod .. " + Print", hl.dsp.exec_cmd("hyprshot -m window -z -o ~/Imagens/Printscreen -s"))
hl.bind("SHIFT + Print", hl.dsp.exec_cmd("hyprshot -m region -z -o ~/Imagens/Printscreen -s"))

-- Noctalia
hl.bind(MainMod .. " + Space", hl.dsp.exec_cmd(NoctaliaIPS .. " launcher toggle"))
hl.bind(MainMod .. " + L", hl.dsp.exec_cmd(NoctaliaIPS .. " lockScreen lock"))
hl.bind(MainMod .. " + L", hl.dsp.exec_cmd(NoctaliaIPS .. " lockScreen lock"))
hl.bind(MainMod .. " + period", hl.dsp.exec_cmd(NoctaliaIPS .. " launcher emoji"))

-- Example binds, see https://wiki.hypr.land/Configuring/Basics/Binds/ for more
hl.bind(MainMod .. " + C", hl.dsp.window.close())
hl.bind(MainMod .. " + M", hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))
hl.bind(MainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(MainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(MainMod .. " + R", hl.dsp.exec_cmd(menu))
hl.bind(MainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(MainMod .. " + J", hl.dsp.layout("togglesplit"))    -- dwindle only

-- Move focus with MainMod + arrow keys
hl.bind(MainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(MainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(MainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(MainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

-- Switch workspaces with MainMod + [0-9]
for i = 1, 10 do
    local key = i % 10
    hl.bind(MainMod .. " + " .. key,             hl.dsp.focus({ workspace = i}))
    hl.bind(MainMod .. " + SHIFT + " .. key,     hl.dsp.window.move({ workspace = i }))
end

-- Example special workspace (scratchpad)
hl.bind(MainMod .. " + S",         hl.dsp.workspace.toggle_special("magic"))
hl.bind(MainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with MainMod + scroll
hl.bind(MainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(MainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with MainMod + LMB/RMB and dragging
hl.bind(MainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(MainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                  { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })