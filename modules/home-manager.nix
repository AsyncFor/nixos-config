{ self, ... }:
{
  flake.nixosModules.home-manager =
    _:
    {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        backupFileExtension = "backup";
        users.frog = {
          imports = [ self.homeModules.main ];
        };
      };
    };
}
