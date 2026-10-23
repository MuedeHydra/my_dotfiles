-- You can (and should!!) split this configuration into multiple files
-- Create your files separately and then require them like this:
-- require("myColors")
-- require("screen-hyprland")
local function get_name()
    local name = ""
    local file = io.open(os.getenv("HOME") .. "/.config/system.txt", "r")
    if file then
        name = file:read("*all")

        file:close()

        name = string.gsub(name, "\n", "")
    else
        print("Datei konnte nicht geoeffnet werden.")
    end
    return name
end


if get_name() == "notebook" then
    require("screen_Notebook")
else
    require("screen_PC")
end


hl.monitor({
    output   = "",
    mode     = "preferred",
    position = "auto",
    scale    = "auto",
})

hl.config({
    ecosystem = {
        no_update_news = true,
        no_donation_nag = true
    }
})

-------------------
---- AUTOSTART ----
-------------------
hl.on("hyprland.start", function ()
  hl.exec_cmd("syncthing serve --no-browser")
  hl.exec_cmd("wl-paste --type text --watch cliphist store")
  hl.exec_cmd("wl-paste --type image --watch cliphist store")
  hl.exec_cmd("waybar -c ~/.config/waybar/config.jsonc")
  hl.exec_cmd("openrazer-daemon -F")
  hl.exec_cmd("sleep 2 && razer-cli --dpi 800")

  hl.exec_cmd("hyprpaper")
  hl.exec_cmd("hyprsunset")
  hl.exec_cmd("systemctl --user start hyprpolkitagent")
  hl.exec_cmd("nm-applet --indicator")
  hl.exec_cmd("/usr/bin/gnome-keyring-daemon --start --components=secrets")

  hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
  hl.exec_cmd("~/.config/hypr/xdg-portal-hyprland")
  hl.exec_cmd("./python/batt-log.py")
  hl.exec_cmd("~/.config/hypr/tools/liquidctl-start.sh")
  hl.exec_cmd("python ~/python/HydraInput/src/HydraInput.py -r")
  hl.exec_cmd("sudo nvidia-smi -i 0 -pl 140")
end)


-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------
local cursor = "rose-pine-hyprcursor"

hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TZPE", "wayland")
-- hl.env("QT_QPA_PLATFORM", "wayland")
hl.env("QT_QPA_PLATFORM", "xcb")
hl.env("QT_SCREEN_SCALE_FACTORS", "1;1")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
-- hl.env("QT_LOGGING_RULES", "qt.qpa.wayland=false") -- disable warnings

-- Steam
hl.env("DXVK_HUD", "compiler") -- info when compiling shaders
hl.env("STAGING_SHARED_MEMORY", "1")

-- Mozilla
hl.env("MOZ_ENABLE_WAYLAND", "1")
hl.env("MOZ_DBUS_REMOTE", "1")
hl.env("MOZ_USE_XINPUT2", "1")

hl.env("MESA_SHADER_CACHE_DISABLE", "0")
hl.env("SDL_VIDEODRIVER", "'wayland,x11,windows'")

hl.env("XCURSOR_SIZE", "24")
hl.env("XCURSOR_THEME", "Adwaita")
hl.env("HYPRCURSOR_THEME", cursor)
hl.env("HYPRCURSOR_SIZE", "48")
hl.env("QT_QPA_PLATFORMTHEME", "wayland")
hl.env("WLR_NO_HARDWARE_CURSORS", "1")
hl.env("GTK_THEME", "Adwaita-dark")
hl.env("BROWSER", "firefox")
hl.env("TERM", "xterm-kitty")
hl.env("TERMINAL", "kitty")
hl.env("EDITOR", "nvim")

-----------------------
----- PERMISSIONS -----
-----------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Permissions/
-- Please note permission changes here require a Hyprland restart and are not applied on-the-fly
-- for security reasons

-- hl.config({
--   ecosystem = {
--     enforce_permissions = true,
--   },
-- })

-- hl.permission("/usr/(bin|local/bin)/grim", "screencopy", "allow")
-- hl.permission("/usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland", "screencopy", "allow")
-- hl.permission("/usr/(bin|local/bin)/hyprpm", "plugin", "allow")


-----------------------
---- LOOK AND FEEL ----
-----------------------

-- Refer to https://wiki.hypr.land/Configuring/Basics/Variables/
hl.config({
    general = {
        gaps_in  = 5,
        gaps_out = 8,

        border_size = 4,

        col = {
            active_border   = { colors = {"rgba(33ccffee)", "rgba(00ff99ee)"}, angle = 45 },
            inactive_border = "rgba(595959aa)",
        },

        -- Set to true to enable resizing windows by clicking and dragging on borders and gaps
        resize_on_border = false,

        -- Please see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/ before you turn this on
        allow_tearing = true,

        layout = "dwindle",
    },

    decoration = {
        rounding       = 10,
        rounding_power = 2,

        -- Change transparency of focused and unfocused windows
        active_opacity   = 1.0,
        inactive_opacity = 1.0,

        shadow = {
            enabled      = false,
            range        = 4,
            render_power = 3,
            color        = 0xee1a1a1a,
        },

        blur = {
            enabled   = false,
            size      = 3,
            passes    = 1,
            vibrancy  = 0.1696,
        },
    },
})


-- Default curves and animations, see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/
hl.curve("easeOutQuint",   { type = "bezier", points = { {0.23, 1},    {0.32, 1}    } })
hl.curve("easeInOutCubic", { type = "bezier", points = { {0.65, 0.05}, {0.36, 1}    } })
hl.curve("linear",         { type = "bezier", points = { {0, 0},       {1, 1}       } })
hl.curve("almostLinear",   { type = "bezier", points = { {0.5, 0.5},   {0.75, 1}    } })
hl.curve("quick",          { type = "bezier", points = { {0.15, 0},    {0.1, 1}     } })
-- hl.curve("easy",           { type = "spring", mass = 1, stiffness = 71.2633, dampening = 15.8273644 })
-- hl.curve("easy",           { type = "spring", mass = 1, stiffness = 238.1191, dampening = 24.21279333 })
hl.curve("easy",           { type = "spring", mass = 1, stiffness = 238.1191, dampening = 30 })

-- hl.curve("costum",         { type = "bezier", points = { {0.42, 0},    {0.58, 1}     } })
hl.curve("costum",         { type = "bezier", points = { {0.61, 1},    {0.88, 1}     } })

-- hl.animation({ leaf = "global",        enabled = true,  speed = 1,    spring = "easy" })
-- hl.animation({ leaf = "global",        enabled = true,  speed = 1,    bezier = "linear" })
hl.animation({ leaf = "global",        enabled = true,  speed = 2,    bezier = "costum" })
-- hl.animation({ leaf = "global",        enabled = true,  speed = 10,   bezier = "default" })
-- hl.animation({ leaf = "border",        enabled = true,  speed = 5.39, bezier = "easeOutQuint" })
-- hl.animation({ leaf = "windows",       enabled = true,  speed = 1, spring = "easy" })
-- -- hl.animation({ leaf = "windowsIn",     enabled = true,  speed = 4.1,  spring = "easy",         style = "popin 87%" })
-- -- hl.animation({ leaf = "windowsOut",    enabled = true,  speed = 1.49, bezier = "linear",       style = "popin 87%" })
-- hl.animation({ leaf = "fadeIn",        enabled = true,  speed = 1.73, bezier = "almostLinear" })
-- hl.animation({ leaf = "fadeOut",       enabled = true,  speed = 1.46, bezier = "almostLinear" })
-- hl.animation({ leaf = "fade",          enabled = true,  speed = 3.03, bezier = "quick" })
-- hl.animation({ leaf = "layers",        enabled = true,  speed = 3.81, bezier = "easeOutQuint" })
-- hl.animation({ leaf = "layersIn",      enabled = true,  speed = 4,    bezier = "easeOutQuint", style = "fade" })
-- hl.animation({ leaf = "layersOut",     enabled = true,  speed = 1.5,  bezier = "linear",       style = "fade" })
-- hl.animation({ leaf = "fadeLayersIn",  enabled = true,  speed = 1.79, bezier = "almostLinear" })
-- hl.animation({ leaf = "fadeLayersOut", enabled = true,  speed = 1.39, bezier = "almostLinear" })
-- hl.animation({ leaf = "workspaces",    enabled = true,  speed = 1,    spring = "easy" })
-- -- hl.animation({ leaf = "workspaces",    enabled = true,  speed = 1.94, bezier = "almostLinear", style = "fade" })
-- -- hl.animation({ leaf = "workspacesIn",  enabled = true,  speed = 1.21, bezier = "almostLinear", style = "fade" })
-- -- hl.animation({ leaf = "workspacesOut", enabled = true,  speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "zoomFactor",    enabled = true,  speed = 7,    bezier = "quick" })


-- See https://wiki.hypr.land/Configuring/Layouts/Dwindle-Layout/ for more
hl.config({
    dwindle = {
        preserve_split = true, -- You probably want this
    },
})

-- See https://wiki.hypr.land/Configuring/Layouts/Master-Layout/ for more
hl.config({
    master = {
        new_status = "master",
    },
})

-- See https://wiki.hypr.land/Configuring/Layouts/Scrolling-Layout/ for more
hl.config({
    scrolling = {
        fullscreen_on_one_column = true,
    },
})

----------------
----  MISC  ----
----------------
hl.config({
    misc = {
        force_default_wallpaper = 2,    -- Set to 0 or 1 to disable the anime mascot wallpapers
        disable_hyprland_logo   = false, -- If true disables the random hyprland logo / anime girl background. :(
        disable_splash_rendering = true,
        on_focus_under_fullscreen = 2,
        -- 0 ignore
        -- 1 new window fullscreen
        -- 2 side by side view
        vrr = 2, -- 0 - off, 1 - on, 2 - fullscreen only, 3 - fullscreen with video or game content type
    },
})

---------------
---- INPUT ----
---------------
hl.config({
    input = {
        kb_layout  = "hydra, ch",
        kb_variant = "",
        kb_model   = "",
        kb_options = "grp:shift_caps_toggle, caps:hyper, fkeys:basic_13-24",
        kb_rules   = "",

        follow_mouse = 1,
        -- 0 Cursor movement will not change focus.
        -- 1 Cursor movement will always change focus to the window under the cursor.
        -- 2 Cursor focus will be detached from keyboard focus. Clicking on a window will move keyboard focus to that window.
        -- 3 Cursor focus will be completely separate from keyboard focus. Clicking on a window will not change keyboard focus.

        numlock_by_default = true,
        sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.

        repeat_rate = 80,
        repeat_delay = 200,

        touchpad = {
            natural_scroll = true,
            disable_while_typing = true,
            scroll_factor = 0.3,
        },
    },
    cursor = {
        no_hardware_cursors = 0,
        -- 0 - use hw cursors if possible
        -- 1 - don’t use hw cursors
        -- 2 - auto (disable when tearing)
    }
})

hl.config({
    input = {
        tablet = {
            output = "current"
            -- output = "Unknown-2"
        }
    }
})

hl.device({
    name        = "razer-razer-viper-ultimate-dongle",
    sensitivity = -1,
})

hl.device({
    name        = "logitech-b330/m330/m331-1",
    sensitivity = -0.8,
})

hl.device({
    name        = "akko-jin01-1-keyboard",
    kb_layout   = "hydra_ansi"
})

hl.device({
    name        = "royuan-akko-multi-modes-keyboard-b",
    kb_layout   = "hydra_ansi"
})

-- hl.device({
--     name        = "uniw0001:00-093a:0255-touchpad",
--     enabled = LAPTOP_KB_ENABLED
-- })

hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace"
})


---------------------
---- KEYBINDINGS ----
---------------------
local mainMod = "SUPER" -- Sets "Windows" key as main modifier

-- hl.bind(mainMod .. " + A", )
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd("firefox"))
hl.bind(mainMod .. " + C", hl.dsp.window.close())
hl.bind(mainMod .. " + D", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd("kitty yazi"))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen("toggle"))
-- hl.bind(mainMod .. " + G", )
hl.bind(mainMod .. " + H",  hl.dsp.focus({ direction = "left" }))
-- hl.bind(mainMod .. " + I", )
hl.bind(mainMod .. " + J",    hl.dsp.focus({ direction = "down" }))
hl.bind(mainMod .. " + K",  hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("~/.config/hypr/tools/network.sh"))
-- hl.bind(mainMod .. " + N", )
-- hl.bind(mainMod .. " + O", )
hl.bind(mainMod .. " + P", hl.dsp.exec_cmd("~/.config/hypr/tools/monitor.py"))
hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd("kitty"))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd("$(tofi-drun)"))
hl.bind(mainMod .. " + S", hl.dsp.exec_cmd("zathura ~/FHGR/photonics/photonics.pdf"))
hl.bind(mainMod .. " + T", hl.dsp.layout("togglesplit"))    -- dwindle only
-- hl.bind(mainMod .. " + U", )
hl.bind(mainMod .. " + V", hl.dsp.exec_cmd("cliphist list | tofi | cliphist decode | wl-copy"))
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd("killall waybar || waybar -c ~/.config/waybar/config.jsonc"))
hl.bind(mainMod .. " + X", hl.dsp.exec_cmd("cat ~/dokumente-sync/commands.txt | tofi | tr -d '\n' | wl-copy"))
hl.bind(mainMod .. " + Y", hl.dsp.exec_cmd("hyprpicker -a"))
-- hl.bind(mainMod .. " + Z", hl.dsp.exec_cmd("zathura ~/FHGR/photonics/photonics.pdf"))


hl.bind(mainMod .. " + SHIFT + B", hl.dsp.exec_cmd("firefox --private-window"))
hl.bind(mainMod .. " + SHIFT + E", hl.dsp.exec_cmd("nautilus --new-window"))
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.window.swap({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.window.swap({ direction = "down" }))
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.window.swap({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.window.swap({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + M", hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))
hl.bind(mainMod .. " + SHIFT + P", hl.dsp.exec_cmd("~/.config/hypr/tools/audio-switcher.py"))
hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.exec_cmd("hyprlock"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd("hyprctl hyprsunset temperature 2500"))
hl.bind(mainMod .. " + SHIFT + ESCAPE", hl.dsp.exec_cmd("~/.config/hypr/tools/powermenu.sh"))

-- hl.bind(mainMod .. " + CTRL + A", hl.dsp.exec_cmd(""))
-- hl.bind(mainMod .. " + CTRL + B", hl.dsp.exec_cmd(""))
-- hl.bind(mainMod .. " + CTRL + C", hl.dsp.exec_cmd(""))
hl.bind(mainMod .. " + CTRL + D", hl.dsp.exec_cmd("discord"))
hl.bind(mainMod .. " + CTRL + E", hl.dsp.exec_cmd("kitty yazi ~/FHGR"))
-- hl.bind(mainMod .. " + CTRL + F", hl.dsp.exec_cmd(""))
-- hl.bind(mainMod .. " + CTRL + G", hl.dsp.exec_cmd(""))
hl.bind(mainMod .. " + CTRL + H", hl.dsp.window.move({ direction = "left" }))
-- hl.bind(mainMod .. " + CTRL + I", hl.dsp.exec_cmd(""))
hl.bind(mainMod .. " + CTRL + J", hl.dsp.window.move({ direction = "down" }))
hl.bind(mainMod .. " + CTRL + K", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + CTRL + L", hl.dsp.window.move({ direction = "right" }))
-- hl.bind(mainMod .. " + CTRL + M", hl.dsp.exec_cmd(""))
-- hl.bind(mainMod .. " + CTRL + N", hl.dsp.exec_cmd(""))
-- hl.bind(mainMod .. " + CTRL + O", hl.dsp.exec_cmd(""))
-- hl.bind(mainMod .. " + CTRL + P", hl.dsp.exec_cmd(""))
hl.bind(mainMod .. " + CTRL + Q", hl.dsp.exec_cmd("hyprlock & sleep 1 && systemctl suspend"))
-- hl.bind(mainMod .. " + CTRL + R", hl.dsp.exec_cmd(""))
hl.bind(mainMod .. " + CTRL + S", hl.dsp.exec_cmd("hyprctl hyprsunset identity"))

hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

hl.bind("        PRINT", hl.dsp.exec_cmd("hyprshot --silent -o ~/dokumente-sync/hyprshot --freeze --mode region"))
hl.bind("SHIFT + PRINT", hl.dsp.exec_cmd("hyprshot --silent -o ~/dokumente-sync/hyprshot --freeze --mode window"))
hl.bind("CTRL  + PRINT", hl.dsp.exec_cmd("hyprshot --silent -o ~/dokumente-sync/hyprshot --mode active -m output"))
hl.bind("ALT   + PRINT", hl.dsp.exec_cmd("hyprshot --silent -o ~/dokumente-sync/hyprshot --freeze --mode region -- pinta"))

hl.bind(mainMod .. " +         PRINT", hl.dsp.exec_cmd("hyprshot --silent -o ~/dokumente-sync/hyprshot --clipboard-only --freeze --mode region"))
hl.bind(mainMod .. " + SHIFT + PRINT", hl.dsp.exec_cmd("hyprshot --silent -o ~/dokumente-sync/hyprshot --clipboard-only --freeze --mode window"))
hl.bind(mainMod .. " + CTRL  + PRINT", hl.dsp.exec_cmd("hyprshot --silent -o ~/dokumente-sync/hyprshot --clipboard-only --mode active -m output"))

hl.bind(mainMod .. " + SHIFT + CTRL + 1", hl.dsp.window.move({ monitor = "DP-1" }))
hl.bind(mainMod .. " + SHIFT + CTRL + 2", hl.dsp.window.move({ monitor = "DP-2" }))
hl.bind(mainMod .. " + SHIFT + CTRL + 3", hl.dsp.window.move({ monitor = "DP-3" }))
hl.bind(mainMod .. " + SHIFT + CTRL + 4", hl.dsp.window.move({ monitor = "eDP-1" }))
hl.bind(mainMod .. " + SHIFT + CTRL + 5", hl.dsp.window.move({ monitor = "HDMI-A-1" }))

hl.bind("ALT + SHIFT + CTRL + 1", hl.dsp.workspace.move({ monitor = "DP-1" }))
hl.bind("ALT + SHIFT + CTRL + 2", hl.dsp.workspace.move({ monitor = "DP-2" }))
hl.bind("ALT + SHIFT + CTRL + 3", hl.dsp.workspace.move({ monitor = "DP-3" }))
hl.bind("ALT + SHIFT + CTRL + 4", hl.dsp.workspace.move({ monitor = "eDP-1" }))
hl.bind("ALT + SHIFT + CTRL + 5", hl.dsp.workspace.move({ monitor = "HDMI-A-1" }))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key,             hl.dsp.focus({ workspace = i}), {dont_inhibit = true})
    hl.bind(mainMod .. " + SHIFT + " .. key,     hl.dsp.window.move({ workspace = i }))
    hl.bind(mainMod .. " + CTRL + " .. key,      hl.dsp.window.move({ workspace = i, follow = false }))
end

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e+1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd("kitty"))
hl.bind(mainMod .. " + ALT",       hl.dsp.exec_cmd("kitty"), { release = true })
-- hl.bind("ALT + ALT_L", hl.dsp.exec_cmd("kitty"), { release = true })
-- hl.bind("ALT + ALT_L", hl.dsp.exec_cmd("kitty"), {long_press = true})
-- hl.bind("ALT + ALT_L", hl.dsp.exec_cmd("kitty"))
-- hl.bind("SUPER + ALT_L", hl.dsp.exec_cmd("kitty"))
-- hl.bind(mainMod .. " + ALT_L",       hl.dsp.window.drag(), { mouse = true, drag = true, transparent = true, release = true, description = "why aaaaaaaaaaaaaaaa"})
hl.bind(mainMod .. " + ALT_L",       hl.dsp.window.drag())
hl.bind(mainMod .. " + Control_L",      hl.dsp.window.resize())

hl.bind("ALT + Tab", function()
    hl.dispatch(hl.dsp.window.cycle_next())   -- Change focus to another window
    hl.dispatch(hl.dsp.window.bring_to_top()) -- Bring it to the top
end)
hl.bind("ALT + Tab", hl.dsp.send_shortcut({mods = "ALT", key = "Tab", window = "class:^(com.moonlight_stream.Moonlight)$"}))
hl.bind("ALT + SPACE", hl.dsp.send_shortcut({mods = "Control_L + SHIFT_L", key = "M", window = "class:^(discord)$"}))

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })
hl.bind(mainMod .. " + SPACE",  hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),                  { locked = true, repeating = true })

hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                  { locked = true, repeating = true })
hl.bind("code:238",             hl.dsp.exec_cmd("brightnessctl -d smc::kbd_backlight s +10"),                  { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })

hl.bind("XF86AudioPlay", hl.dsp.pass({window = "class:^(mpv)$"}))
hl.bind("XF86AudioNext", hl.dsp.pass({window = "class:^(mpv)$"}))
hl.bind("XF86AudioPrev", hl.dsp.pass({window = "class:^(mpv)$"}))
hl.bind("XF86audiostop", hl.dsp.pass({window = "class:^(mpv)$"}))

local function zoom(z)
        hl.config({ cursor = { zoom_factor = z } })
end

hl.bind("MOD3 + 1", function() zoom(1) end)
hl.bind("MOD3 + 2", function() zoom(1.5) end)
hl.bind("MOD3 + 3", function() zoom(2) end)
hl.bind("MOD3 + 4", function() zoom(4) end)

hl.bind("MOD3 + H", hl.dsp.send_shortcut({mods = "", key = "left", window = "active"}))
hl.bind("MOD3 + J", hl.dsp.send_shortcut({mods = "", key = "down", window = "active"}))
hl.bind("MOD3 + K", hl.dsp.send_shortcut({mods = "", key = "up", window = "active"}))
hl.bind("MOD3 + L", hl.dsp.send_shortcut({mods = "", key = "right", window = "active"}))

hl.bind("MOD3 + Q", hl.dsp.exec_cmd("playerctl previous"))
hl.bind("MOD3 + Q", hl.dsp.send_shortcut({mods = "", key = "XF86AudioPrev", window = "class:^(mpv)$"}))
hl.bind("MOD3 + W", hl.dsp.exec_cmd("playerctl play-pause"))
hl.bind("MOD3 + W", hl.dsp.send_shortcut({mods = "", key = "XF86AudioPause", window = "class:^(mpv)$"}))
hl.bind("MOD3 + E", hl.dsp.send_shortcut({mods = "", key = "XF86AudioNext", window = "class:^(mpv)$"}))
hl.bind("MOD3 + E", hl.dsp.exec_cmd("playerctl next"))

--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------
-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- and https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

local overlayLayerRule = hl.layer_rule({
    name  = "no-anim-overlay",
    match = { namespace = "^(selection)$" },
    no_anim = true,
})
overlayLayerRule:set_enabled(true)

local suppressMaximizeRule = hl.window_rule({
    -- Ignore maximize requests from all apps. You'll probably like this.
    name  = "suppress-maximize-events",
    match = { class = ".*" },

    suppress_event = "maximize",
})
suppressMaximizeRule:set_enabled(true)

hl.window_rule({
    -- Fix some dragging issues with XWayland
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },

    no_focus = true,
})


hl.window_rule({ match = { class = "dragon" }, pin = true })
hl.window_rule({ match = { class = "(steam_app_)(\\d+)" }, render_unfocused = true, immediate = true })

hl.window_rule({
    name  = "overlayed_rules",
    match = { class = "overlayed" },
    no_focus = true,
    no_blur = true,
    border_size = 0,
    pin = true,
})

-- hl.window_rule({ match = { class = "org.pwmt.zathura" }, workspace = "5 silent" })

