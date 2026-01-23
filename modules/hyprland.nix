_:
{
  flake.nixosModules.hyprland =
    _:
    {
      programs.hyprland = {
        enable = true;
        xwayland.enable = true;
      };
    };
}
