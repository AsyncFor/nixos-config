{
  description = "Home manager and hyprland";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    flake-parts.url = "github:hercules-ci/flake-parts";
    import-tree.url = "github:vic/import-tree";
    home-manager = {
       url="github:nix-community/home-manager";
       inputs.nixpkgs.follows="nixpkgs";
    };
    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    tt-schemes = {
      url = "github:tinted-theming/schemes?shallow=1";
      flake = false;
    };

  };

  outputs = 
      inputs @ { flake-parts, import-tree, nixpkgs, stylix, ... }: 
      flake-parts.lib.mkFlake { inherit inputs; } {
         imports = [
            inputs.home-manager.flakeModules.home-manager
            (import-tree ./modules)
         ];
         systems = ["x86_64-linux"];
      };
}
