{ inputs, self, ... }:
{
	flake.nixosConfigurations.nixnix = inputs.nixpkgs.lib.nixosSystem {
		modules = [
			inputs.stylix.nixosModules.stylix
			inputs.lanzaboote.nixosModules.lanzaboote
			inputs.nix-index-database.nixosModules.nix-index
			self.nixosModules.hardware
			self.nixosModules.nixnix
			self.nixosModules.locale
			self.nixosModules.nvidia
			self.nixosModules.hyprland
			self.nixosModules.home-manager
			self.nixosModules.stylix
			self.nixosModules.mullvad
			self.nixosModules.cachix
		];
	};
	
	flake.nixosModules.nixnix = {config, pkgs, ...}:
	{
		networking.hostName = "nixnix";
		nix.settings.experimental-features = ["nix-command" "flakes"];
		imports = [
			inputs.home-manager.nixosModules.home-manager
		];
		

            	boot.lanzaboote = {
              		enable = true;
              		pkiBundle = "/var/lib/sbctl";
            	};
		# boot loader
		boot.loader.systemd-boot.enable = false;
		boot.loader.efi.canTouchEfiVariables = true;
		
		# state version
		system.stateVersion = "24.11";
		
	
		nixpkgs.config.allowUnfree = true;
		environment.systemPackages = [
			pkgs.vim
			pkgs.wget
			pkgs.git
			pkgs.curl
			pkgs.sbctl
			pkgs.pciutils
			pkgs.usbutils
			pkgs.lshw
			pkgs.file
			pkgs.tree
			inputs.rose-pine-hyprcursor.packages.${pkgs.system}.default
		];
		
		programs.fish.enable = true;
		programs.fish.interactiveShellInit = "set fish_greeting";
		programs.nix-index-database.comma.enable = true;
		
		# Enable dconf for GTK settings
		programs.dconf.enable = true;
		
		# Pipewire for audio (better for gaming)
		security.rtkit.enable = true;
		services.pipewire = {
			enable = true;
			alsa.enable = true;
			alsa.support32Bit = true;
			pulse.enable = true;
			jack.enable = true;
			wireplumber.enable = true;
		};
		
		# XDG portal for screen sharing and file dialogs
		xdg.portal = {
			enable = true;
			extraPortals = [ pkgs.xdg-desktop-portal-hyprland pkgs.xdg-desktop-portal-gtk ];
		};
		
		# Polkit for authentication dialogs
		security.polkit.enable = true;
		systemd.user.services.polkit-gnome-authentication-agent-1 = {
			description = "polkit-gnome-authentication-agent-1";
			wantedBy = [ "graphical-session.target" ];
			wants = [ "graphical-session.target" ];
			after = [ "graphical-session.target" ];
			serviceConfig = {
				Type = "simple";
				ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
				Restart = "on-failure";
				RestartSec = 1;
				TimeoutStopSec = 10;
			};
		};
		
		# Enable GVFS for thunar mounting
		services.gvfs.enable = true;
		
		# Enable thumbnails in thunar
		services.tumbler.enable = true;

		users.users.frog = {
			isNormalUser = true;
			extraGroups = ["networkmanager" "wheel" "video" "audio" "input" "gamemode"];
			packages = with pkgs; [];
			shell = pkgs.fish;
		};
		
		# required for mullvad	
		networking.nameservers=["1.1.1.1#one.one.one.one" "1.0.0.1#one.one.one.one"];
		services.resolved = {
			enable = true;
			dnssec = "true";
			domains = ["~."];
			fallbackDns=["1.1.1.1#one.one.one.one" "1.0.0.1#one.one.one.one"];
			dnsovertls = "true";
		};
		networking.networkmanager.enable = true;
		
	};
}
