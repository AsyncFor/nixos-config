{ inputs, self, ... }:
{
	flake.nixosModules.stylix = {config, pkgs, lib, ...}:
	{
		stylix.enable = true;
		stylix.autoEnable = true;
		stylix.polarity = "dark";
		stylix.base16Scheme = "${inputs.tt-schemes}/base16/horizon-dark.yaml";
		
		# Wallpaper - fetched from NixOS artwork
		stylix.image = pkgs.fetchurl {
			url = "https://raw.githubusercontent.com/NixOS/nixos-artwork/master/wallpapers/nix-wallpaper-simple-dark-gray.png";
			sha256 = "sha256-6Ur6Id+rBx0p8AcNuMBv8UE6dkdT5BZtHPUCyqSZyEY=";
		};
		
		# Disable GNOME-specific targets since we use Hyprland
		stylix.targets.gnome.enable = false;
	};
}
