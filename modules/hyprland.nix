{ inputs, self, ... }:
{
	flake.nixosModules.hyprland = {config, pkgs, ...}:
	{	
		programs.hyprland = {
			enable = true;
			xwayland.enable = true;
		};
	};
}
