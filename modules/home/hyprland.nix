_: {
  flake.homeModules.hyprland = _: {
    wayland.windowManager.hyprland = {
      enable = true;
      xwayland.enable = true;
      settings = {
        env = [
          "HYPRCURSOR_THEME,rose-pine-hyprcursor"
          "HYPRCURSOR_SIZE,30"
          # NVIDIA-specific environment variables for better performance
          "LIBVA_DRIVER_NAME,nvidia"
          "XDG_SESSION_TYPE,wayland"
          "GBM_BACKEND,nvidia-drm"
          "__GLX_VENDOR_LIBRARY_NAME,nvidia"
          "WLR_NO_HARDWARE_CURSORS,1"
          "__GL_GSYNC_ALLOWED,1"
          "__GL_VRR_ALLOWED,1"
        ];
        general = {
          layout = "master";
          gaps_in = 5;
          gaps_out = 10;
          border_size = 2;
          allow_tearing = true;
        };

        decoration = {
          rounding = 8;
          blur = {
            enabled = true;
            size = 8;
            passes = 2;
            new_optimizations = true;
          };
          shadow = {
            enabled = true;
            range = 10;
            render_power = 3;
          };
        };

        animations = {
          enabled = true;
          bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
          animation = [
            "windows, 1, 7, myBezier"
            "windowsOut, 1, 7, default, popin 80%"
            "border, 1, 10, default"
            "borderangle, 1, 8, default"
            "fade, 1, 7, default"
            "workspaces, 1, 6, default"
          ];
        };

        misc = {
          vrr = 1; # Variable refresh rate (adaptive sync)
          disable_hyprland_logo = true;
          disable_splash_rendering = true;
          force_default_wallpaper = 0;
        };

        "$mod" = "SUPER";
        bind = [
          # rofi
          "$mod, $mod_L, exec, pkill rofi || rofi -show drun"

          # keybinds
          "$mod, Return, exec, ghostty"
          "$mod, Q, killactive"
          "$mod, M, exit"
          "$mod, F, fullscreen"
          "$mod, Space, togglefloating"
          "$mod, T, exec, firefox"
          "$mod, A, layoutmsg, swapwithmaster master"
          "$mod, E, exec, thunar"
          "$mod, V, exec, cliphist list | rofi -dmenu | cliphist decode | wl-copy"

          # screenshot
          ", Print, exec, grimblast copy area"
          "$mod, Print, exec, grimblast copy output"
          "SHIFT, Print, exec, grimblast copy screen"

          # workspaces
          "$mod, 1, workspace, 1"
          "$mod, 2, workspace, 2"
          "$mod, 3, workspace, 3"
          "$mod, 4, workspace, 4"
          "$mod, 5, workspace, 5"
          "$mod, 6, workspace, 6"
          "$mod, 7, workspace, 7"
          "$mod, 8, workspace, 8"
          "$mod, 9, workspace, 9"
          "$mod, 0, workspace, 10"

          # move windows to workspaces
          "$mod SHIFT, 1, movetoworkspace, 1"
          "$mod SHIFT, 2, movetoworkspace, 2"
          "$mod SHIFT, 3, movetoworkspace, 3"
          "$mod SHIFT, 4, movetoworkspace, 4"
          "$mod SHIFT, 5, movetoworkspace, 5"
          "$mod SHIFT, 6, movetoworkspace, 6"
          "$mod SHIFT, 7, movetoworkspace, 7"
          "$mod SHIFT, 8, movetoworkspace, 8"
          "$mod SHIFT, 9, movetoworkspace, 9"
          "$mod SHIFT, 0, movetoworkspace, 10"

          # scroll through workspaces
          "$mod, mouse_down, workspace, e+1"
          "$mod, mouse_up, workspace, e-1"

          # focus movement
          "$mod, H, movefocus, l"
          "$mod, L, movefocus, r"
          "$mod, K, movefocus, u"
          "$mod, J, movefocus, d"
        ];
        bindm = [
          "$mod, mouse:272, movewindow"
          "$mod, mouse:273, resizewindow"
        ];

        # Startup applications - only waybar, no duplicates
        exec-once = [
          "waybar"
          "dunst"
          "wl-paste --type text --watch cliphist store"
          "wl-paste --type image --watch cliphist store"
        ];

        input = {
          kb_layout = "tr";
          follow_mouse = 1;
          sensitivity = 0;
        };

        # Monitor configuration - explicitly set 144Hz for all monitors
        # Format: monitor = name, resolution@refresh, position, scale
        # Use "highrr" to prefer highest refresh rate available
        # Second monitor positioned on the left (negative X position)
        monitor = [
          "DP-1, highrr, 1920x0, 1" # Primary monitor (right)
          "DP-2, highrr, 0x0, 1" # Second monitor (left)
          "HDMI-A-2, highrr, 0x0, 1" # Alternative: second monitor via HDMI (left)
          ", highrr, auto, 1" # Fallback for any other monitor
        ];

        # Window rules for gaming
        windowrulev2 = [
          "immediate, class:^(steam_app)(.*)$"
          "immediate, class:^(gamescope)(.*)$"
          "fullscreen, class:^(steam_app)(.*)$"
        ];
      };
    };

    # Waybar - more stable and customizable bar
    programs.waybar = {
      enable = true;
      settings = {
        mainBar = {
          layer = "top";
          position = "top";
          height = 30;
          spacing = 4;
          modules-left = [
            "hyprland/workspaces"
            "hyprland/window"
          ];
          modules-center = [ "clock" ];
          modules-right = [
            "pulseaudio"
            "network"
            "cpu"
            "memory"
            "temperature"
            "tray"
          ];

          "hyprland/workspaces" = {
            format = "{name}";
            on-click = "activate";
          };

          "hyprland/window" = {
            format = "{}";
            max-length = 50;
            separate-outputs = true;
          };

          clock = {
            format = "{:%H:%M}";
            format-alt = "{:%Y-%m-%d}";
            tooltip-format = "<tt><small>{calendar}</small></tt>";
          };

          cpu = {
            format = "  {usage}%";
            tooltip = true;
          };

          memory = {
            format = "  {}%";
          };

          temperature = {
            critical-threshold = 80;
            format = " {temperatureC}°C";
          };

          network = {
            format-wifi = "  {signalStrength}%";
            format-ethernet = "󰈀 Connected";
            format-disconnected = "󰖪 Disconnected";
            tooltip-format = "{ifname}: {ipaddr}";
          };

          pulseaudio = {
            format = "{icon} {volume}%";
            format-muted = "󰝟 Muted";
            format-icons = {
              default = [
                ""
                ""
                ""
              ];
            };
            on-click = "pavucontrol";
          };

          tray = {
            spacing = 10;
          };
        };
      };
      style = ''
        * {
          font-family: "DroidSansM Nerd Font Mono", "Font Awesome 6 Free";
          font-size: 13px;
        }

        window#waybar {
          background-color: rgba(30, 30, 46, 0.9);
          color: #cdd6f4;
          border-bottom: 2px solid #45475a;
        }

        #workspaces button {
          padding: 0 8px;
          color: #cdd6f4;
          background-color: transparent;
          border-radius: 5px;
          margin: 3px;
        }

        #workspaces button.active {
          background-color: #45475a;
          color: #f5c2e7;
        }

        #workspaces button:hover {
          background-color: #585b70;
        }

        #window {
          padding: 0 10px;
          margin: 3px 0;
          border-radius: 5px;
          background-color: transparent;
          color: #cba6f7;
          font-weight: bold;
        }

        #clock, #cpu, #memory, #temperature, #network, #pulseaudio, #tray {
          padding: 0 10px;
          margin: 3px 0;
          border-radius: 5px;
          background-color: #45475a;
        }

        #cpu {
          color: #f38ba8;
        }

        #memory {
          color: #fab387;
        }

        #temperature {
          color: #f9e2af;
        }

        #temperature.critical {
          color: #f38ba8;
        }

        #network {
          color: #89b4fa;
        }

        #pulseaudio {
          color: #a6e3a1;
        }
      '';
    };
  };
}
