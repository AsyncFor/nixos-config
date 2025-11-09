{self, ...}:
{
	flake.homeModules.main = {config, ...}:
	{
		imports = [
			self.homeModules.packages
			self.homeModules.hyprland
		];
		home.username = "frog";
		home.stateVersion = "25.11";
		fonts.fontconfig.enable = true;
	};
}
