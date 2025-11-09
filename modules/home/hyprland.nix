{self, ...}:
{
	flake.homeModules.hyprland = {config, ...}:
	{
		wayland.windowManager.hyprland = {
			enable = true;
			xwayland.enable = true;
			settings = {
				"$mod" = "SUPER";
				bind = [
					"$mod, $mod_L, exec, pkill rofi || rofi -show drun"
					"$mod, Return, exec, kitty"
					"$mod, Q, killactive"
					"$mod, M, exit"
					"$mod, F, fullscreen"
					"$mod, Space, togglefloating"
					"$mod, T, exec, firefox" 
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
