{
  description = "NixOS configuration with Home Manager and Hyprland";

  inputs = {
    # Core inputs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    flake-parts.url = "github:hercules-ci/flake-parts";
    import-tree.url = "github:vic/import-tree";

    # Home Manager
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Desktop environment
    hyprland.url = "github:hyprwm/Hyprland?shallow=1";
    rose-pine-hyprcursor = {
      url = "github:ndom91/rose-pine-hyprcursor";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.hyprlang.follows = "hyprland/hyprlang";
    };

    # Theming
    stylix = {
      url = "github:nix-community/stylix/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    tt-schemes = {
      url = "github:tinted-theming/schemes?shallow=1";
      flake = false;
    };

    # Editor
    nixvim = {
      url = "github:nix-community/nixvim/nixos-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # System utilities
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.3";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      flake-parts,
      import-tree,
      ...
    }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        inputs.home-manager.flakeModules.home-manager
        (import-tree ./modules)
      ];

      systems = [ "x86_64-linux" ];

      perSystem =
        { pkgs, ... }:
        {
          # Formatter for `nix fmt`
          formatter = pkgs.nixfmt-rfc-style;

          # Development shell with linting tools
          devShells.default = pkgs.mkShell {
            name = "nixos-config-dev";
            packages = with pkgs; [
              # Nix formatting
              nixfmt-rfc-style
              nixfmt-tree

              # Nix linting
              statix # Static analysis for Nix
              deadnix # Find unused code in Nix

              # Nix language server
              nil

              # Nix utilities
              nix-tree # Visualize nix derivations
              nix-diff # Compare nix derivations
            ];

            shellHook = ''
              echo "NixOS config development shell"
              echo ""
              echo "Available commands:"
              echo "  nix fmt        - Format all Nix files"
              echo "  statix check   - Run static analysis"
              echo "  deadnix        - Find unused code"
              echo "  nix flake check - Run all checks"
              echo "  treefmt - Format tree"
            '';
          };

          # Checks for CI and `nix flake check`
          checks = {
            formatting = pkgs.runCommand "check-formatting" { } ''
              ${pkgs.findutils}/bin/find ${./.} -name '*.nix' -exec ${pkgs.nixfmt-rfc-style}/bin/nixfmt --check {} +
              touch $out
            '';

            statix = pkgs.runCommand "check-statix" { } ''
              ${pkgs.statix}/bin/statix check ${./.}
              touch $out
            '';

            deadnix = pkgs.runCommand "check-deadnix" { } ''
              ${pkgs.deadnix}/bin/deadnix --fail ${./.}
              touch $out
            '';
          };
        };
    };
}
