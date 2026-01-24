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
    };
}
