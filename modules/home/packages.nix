{self, ...}:
{
	flake.homeModules.packages = {config, pkgs, ...}:
	{
		home.packages = with pkgs; [
			# Terminal and shell utilities
			wl-clipboard
			cliphist
			kitty
			hyprcursor
			
			# Application launcher and notifications
			rofi-wayland
			dunst
			libnotify
			
			# Web and communication
			firefox
			vesktop
			
			# File management
			xfce.thunar
			gvfs  # For thunar mounting capabilities
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
			
			# C/C++ Development Environment
			gcc
			clang
			clang-tools  # clangd, clang-format, etc.
			lldb
			gdb
			cmake
			gnumake
			ninja
			meson
			pkg-config
			autoconf
			automake
			libtool
			
			# Build and debugging tools
			valgrind
			strace
			ltrace
			binutils
			
			# Libraries (common development headers)
			glibc.dev
			
			# Version control
			git
			gh  # GitHub CLI
			
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
			
			# Waybar dependencies
			waybar
		];
	};
}
