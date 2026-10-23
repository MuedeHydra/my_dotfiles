hl.monitor({ output = "eDP-1", mode = "2560x1600@240", position = "0x0", scale = 1, bitdepth = 10})
hl.monitor({ output = "DP-2", mode = "1920x1080@60", position = "0x1600",  scale = 1 })

-- hl.monitor({ output = "HDMI-A-1", mode = "1920x1080@60", position = "0x1600",  scale = 1 })
hl.monitor({ output = "HDMI-A-1", mode = "1920x1080@60", position = "auto",  scale = 1, mirror = "eDP-1" })

-- hl.monitor({ output = "HDMI-A-1",
--             mode = "3840x2160@60",
--             position = "2560x0",
--             scale = 1,
--             bitdepth = 10,
--             cm = "hdr",
--             sdrbrightness = 1.2,
--             sdr_eotf = "gamma22",
--             supports_hdr = 1, -- force HDR
-- })


-- hl.monitor({ output = "DP-2", mode = "2560x1440@165", position = "2560x0",  scale = 1 })

hl.on("hyprland.start", function ()
  hl.exec_cmd("sudo brightnessctl set 40%")
  hl.exec_cmd("sleep 5 && bongocat --watch-config")
  -- hl.exec_cmd("sleep 5 && tuxedo-control-center")
end)
