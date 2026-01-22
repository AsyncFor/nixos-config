{ ... }:
{
  flake.nixosModules.nvidia =
    { config, pkgs, ... }:
    {
      # Enable graphics
      hardware.graphics = {
        enable = true;
        enable32Bit = true; # Required for Steam and 32-bit games
        extraPackages = with pkgs; [
          libva
          libvdpau
          nvidia-vaapi-driver
          libva-vdpau-driver
        ];
        extraPackages32 = with pkgs.pkgsi686Linux; [
          libva
          libvdpau
        ];
      };

      # NVIDIA driver configuration
      services.xserver.videoDrivers = [ "nvidia" ];

      hardware.nvidia = {
        open = false;
        package = config.boot.kernelPackages.nvidiaPackages.latest;
        modesetting.enable = true;
        powerManagement.enable = false;
        powerManagement.finegrained = false;
        nvidiaSettings = true;
        forceFullCompositionPipeline = false; # Disable for VRR support
      };

      # Disable CUDA support (not needed for gaming/dev)
      nixpkgs.config.cudaSupport = false;

      # Steam and gaming support
      programs.steam = {
        enable = true;
        remotePlay.openFirewall = true;
        dedicatedServer.openFirewall = true;
        gamescopeSession.enable = true;
      };

      # Gamemode for improved gaming performance
      programs.gamemode = {
        enable = true;
        enableRenice = true;
        settings = {
          general = {
            renice = 10;
          };
          gpu = {
            apply_gpu_optimisations = "accept-responsibility";
            gpu_device = 0;
            nv_powermizer_mode = 1;
          };
        };
      };
    };
}
