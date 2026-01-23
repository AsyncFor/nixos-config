_:
{
  flake.homeModules.packages =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        # Terminal and shell utilities
        wl-clipboard
        cliphist
        kitty
        hyprcursor

        # Application launcher and notifications
        rofi
        dunst
        libnotify

        # Web and communication
        firefox
        vesktop

        # File management
        xfce.thunar
        gvfs
        unzip
        p7zip

        # Editors and IDEs
        zed-editor

        # Screenshot and screen recording
        grimblast
        grim
        slurp
        wf-recorder

        # Media
        spotify
        mpv
        imv
        pavucontrol
        playerctl

        # Gaming
        prismlauncher
        mangohud
        gamemode
        gamescope
        protonup-qt
        lutris

        # Fonts
        nerd-fonts.fira-code
        nerd-fonts.droid-sans-mono
        nerd-fonts.symbols-only
        font-awesome

        # Development tools (non-conflicting)
        # Use nix-shell or devShells for compiler toolchains to avoid conflicts
        cmake
        gnumake
        ninja
        gdb
        valgrind
        strace

        # Version control
        git
        gh

        # Code analysis
        cppcheck

        # Documentation
        man-pages
        man-pages-posix

        # System monitoring
        htop
        btop
        nvtopPackages.nvidia

        # Networking tools
        curl
        wget

        # Waybar
        waybar
      ];
    };
}
