{self, ...}:
{
	flake.homeModules.main = {config, pkgs, ...}:
	{
		imports = [
			self.homeModules.packages
			self.homeModules.hyprland
			self.homeModules.nixvim
		];
		
		# Stylix theming
		stylix.targets.rofi.enable = true;
		stylix.targets.kitty.enable = true;
		stylix.targets.waybar.enable = false;  # We use custom waybar style
		stylix.autoEnable = true;
		
		# User settings
		home.username = "frog";
		home.homeDirectory = "/home/frog";
		home.stateVersion = "25.11";
		
		# Font configuration
		fonts.fontconfig.enable = true;
		
		# Shell configuration
		programs.fish = {
			enable = true;
			interactiveShellInit = ''
				set fish_greeting
				# Add common dev aliases
				alias ll "ls -la"
				alias gs "git status"
				alias gd "git diff"
				alias gc "git commit"
				alias gp "git push"
				alias make "make -j$(nproc)"
			'';
		};
		
		# Terminal configuration
		programs.ghostty = {
			enable = true;
			enableFishIntegration = true;
		};
		
		programs.kitty = {
			enable = true;
			settings = {
				confirm_os_window_close = 0;
				enable_audio_bell = false;
			};
		};
		
		# Git configuration
		programs.git = {
			enable = true;
			extraConfig = {
				init.defaultBranch = "main";
				pull.rebase = true;
				push.autoSetupRemote = true;
			};
		};
		
		# Direnv for development environments
		programs.direnv = {
			enable = true;
			nix-direnv.enable = true;
		};
		
		# Btop for system monitoring
		programs.btop = {
			enable = true;
			settings = {
				color_theme = "Default";
				theme_background = false;
			};
		};
		
		# XDG configuration
		xdg.enable = true;
		xdg.userDirs = {
			enable = true;
			createDirectories = true;
		};
	};
}
