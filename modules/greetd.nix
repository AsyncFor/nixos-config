_: {
  flake.nixosModules.greetd =
    { pkgs, ... }:
    {
      # Enable greetd login manager
      services.greetd = {
        enable = true;
        settings = {
          default_session = {
            command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --remember --cmd Hyprland";
            user = "greeter";
          };
        };
      };

      # Make tuigreet remember the last user
      systemd.services.greetd.serviceConfig = {
        Type = "idle";
        StandardInput = "tty";
        StandardOutput = "tty";
        StandardError = "journal";
        TTYReset = true;
        TTYVHangup = true;
        TTYVTDisallocate = true;
      };
    };
}
