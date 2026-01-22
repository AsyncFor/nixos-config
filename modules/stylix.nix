{ inputs, self, ... }:
{
	flake.nixosModules.stylix = {config, pkgs, ...}:
	{
		stylix.enable = true;
		stylix.autoEnable = true;
		stylix.polarity = "dark";
		stylix.base16Scheme = "${inputs.tt-schemes}/base16/horizon-dark.yaml";
		
		# Disable GNOME-specific targets since we use Hyprland
		stylix.targets.gnome.enable = false;
	};
}
