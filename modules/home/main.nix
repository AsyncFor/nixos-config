{self, ...}:
{
	flake.homeModules.main = {config, ...}:
	{
		imports = [
			self.homeModules.packages
			self.homeModules.hyprland
		];
		stylix.targets.rofi.enable = true;
		stylix.targets.kitty.enable = true;
		stylix.autoEnable = true;
		home.username = "frog";
		home.stateVersion = "25.11";
		fonts.fontconfig.enable = true;
	};
}
