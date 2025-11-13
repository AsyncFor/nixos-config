{self, ...}:
{
	flake.homeModules.hyprland = {config, ...}:
	{
		wayland.windowManager.hyprland = {
			enable = true;
			xwayland.enable = true;
			settings = {
				env = [
				"HYPRCURSOR_THEME,rose-pine-hyprcursor"
				"HYPRCURSOR_SIZE, 30"
				];
				general = {
					layout = "master";
				};
				
				decoration = {
					rounding = 5;
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
				];
				bindm = [
					"$mod, mouse:272, movewindow"
					"$mod, mouse:273, resizewindow"
				];
				exec-once = "hyprpanel";
				input = {
					kb_layout = "tr";
				};
				monitor = ", highrr, auto, 1";
			};
		};

		programs.hyprpanel = {
			enable = true;
      			settings.theme.bar.transparent = true;
			settings.menus.dashboard.stats.enable_gpu = true;
      			settings.theme.font = {
        			name = "DroidSansM Nerd Font Mono";
        			size = "11pt";
			};
		};
	};
}
