{ inputs, self, ... }:
{
	flake.nixosModules.nvidia = {config, pkgs, ...}:
	{
		hardware.graphics.enable = true;
		services.xserver.videoDrivers = ["nvidia" "modesetting"];
		hardware.graphics.extraPackages = with pkgs; [libva libvdpau nvidia-vaapi-driver libva-vdpau-driver];
		hardware.nvidia = {
			open = false;
			package = config.boot.kernelPackages.nvidiaPackages.latest;
		};
		nixpkgs.config.cudaSupport = false;
	};
}
