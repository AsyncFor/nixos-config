{ inputs, self, ... }:
{
	flake.nixosConfigurations.nixnix = inputs.nixpkgs.lib.nixosSystem {
		modules = [
			inputs.stylix.nixosModules.stylix
			self.nixosModules.hardware
			self.nixosModules.nixnix
			self.nixosModules.locale
			self.nixosModules.nvidia
			self.nixosModules.hyprland
			self.nixosModules.home-manager
			self.nixosModules.stylix
			self.nixosModules.mullvad
		];
	};
	
	flake.nixosModules.nixnix = {config, pkgs, ...}:
	{
		networking.hostName = "nixnix";
		nix.settings.experimental-features = ["nix-command" "flakes"];
		imports = [
			inputs.home-manager.nixosModules.home-manager
		];
		
			
		# boot loader
		boot.loader.systemd-boot.enable = true;
		boot.loader.efi.canTouchEfiVariables = true;
		
		# state version
		system.stateVersion = "25.05";
		
	
		nixpkgs.config.allowUnfree = true;
		environment.systemPackages = with pkgs; [
			vim
			wget
			git
			curl
		];
		
		programs.fish.enable = true;	
	
		users.users.frog = {
			isNormalUser = true;
			extraGroups = ["networkmanager" "wheel"];
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
