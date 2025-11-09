{ inputs, self, ... }:
{
	flake.nixosConfigurations.nixnix = inputs.nixpkgs.lib.nixosSystem {
		modules = [
			../../hardware-configuration.nix
			inputs.stylix.nixosModules.stylix
			self.nixosModules.nixnix
			self.nixosModules.locale
			self.nixosModules.nvidia
			self.nixosModules.hyprland
			self.nixosModules.home-manager
			self.nixosModules.stylix
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
	
		users.users.frog = {
			isNormalUser = true;
			extraGroups = ["networkmanager" "wheel"];
			packages = with pkgs; [];
		};
		
		networking.networkmanager.enable = true;	
	};
}
