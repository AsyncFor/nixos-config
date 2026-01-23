# NixOS Configuration Repository

This is a NixOS configuration repository using Nix Flakes, Home Manager, and Hyprland for desktop environment management. The repository is structured using flake-parts and import-tree for modular configuration management.

## Code Standards

### Required Before Each Commit

- Run `nix fmt` before committing any changes to ensure proper code formatting
  - This uses `nixfmt-rfc-style` to format all Nix files
- Run `statix check .` to perform static analysis on Nix code
- Run `deadnix --fail .` to find and fail on unused code in Nix files

### Development Flow

- **Format code**: `nix fmt`
- **Run static analysis**: `nix run nixpkgs#statix -- check .`
- **Check for dead code**: `nix run nixpkgs#deadnix -- --fail .`
- **Full checks**: `nix flake check` (includes formatting, statix, and deadnix)
- **Build configuration**: `nix build` or `nixos-rebuild build-vm` for testing
- **Development shell**: `nix develop` for development tools

## Repository Structure

- `flake.nix`: Main flake configuration with inputs, outputs, and development tools
- `flake.lock`: Lock file for reproducible builds
- `modules/`: NixOS and Home Manager configuration modules
  - `modules/configuration.nix`: Main NixOS configuration
  - `modules/hardware-configuration.nix`: Hardware-specific configuration
  - `modules/home-manager.nix`: Home Manager integration
  - `modules/home/`: Home Manager user configuration modules
  - Individual feature modules (hyprland.nix, nvidia.nix, stylix.nix, etc.)
- `.github/workflows/ci.yaml`: CI pipeline for linting and checking

## Key Guidelines

1. **Follow Nix best practices**:
   - Use `nixfmt-rfc-style` formatting style
   - Follow the existing module structure
   - Use attribute sets and let-in bindings appropriately
   - Avoid antipatterns caught by `statix`

2. **Module organization**:
   - Each module should be self-contained with its configuration
   - Use `import-tree` pattern for automatic module discovery
   - Keep related functionality grouped in the same module

3. **Flake inputs**:
   - Pin nixpkgs to stable releases (currently nixos-25.11)
   - Use `follows` to align transitive dependencies
   - Document any new flake inputs in comments

4. **Testing**:
   - Use `nix flake check` to validate all checks before committing
   - Test configuration changes in a VM with `nixos-rebuild build-vm` when possible
   - Ensure formatting, statix, and deadnix checks pass

5. **Documentation**:
   - Update this file if adding new development workflows
   - Comment complex Nix expressions
   - Document any non-obvious configuration choices

## Flake Structure

The repository uses `flake-parts` for modular flake composition:
- `perSystem` outputs include formatter, devShells, and checks
- `home-manager.flakeModules.home-manager` for Home Manager integration
- Modules are automatically imported via `import-tree ./modules`

## Common Tasks

- **Add a new module**: Create a `.nix` file in `modules/` or `modules/home/`
- **Update dependencies**: Run `nix flake update` to update `flake.lock`
- **Add new packages**: Update the appropriate module in `modules/home/packages.nix` or similar
- **Change system configuration**: Modify `modules/configuration.nix` or create new feature modules
