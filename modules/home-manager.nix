{self, ...}:
{
	flake.nixosModules.home-manager = { config, pkgs, ... }:
	{
		home-manager = {
			useGlobalPkgs = true;
			useUserPackages = true;
			backupFileExtension = "backup";
			users.frog = {
				imports = [self.homeModules.main];
			};
		};
	};
}
