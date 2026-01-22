{ self, ... }:
{
  flake.nixosModules.home-manager =
    { ... }:
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
