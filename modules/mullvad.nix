{self, ...}:
{
	flake.nixosModules.mullvad = { config, pkgs, ... }:
	{
		services.mullvad-vpn.enable = true;
		services.mullvad-vpn.package = pkgs.mullvad-vpn;	
	};
}
