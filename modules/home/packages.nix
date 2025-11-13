{self, ...}:
{
	flake.homeModules.packages = {config, pkgs, ...}:
	{
		home.packages = with pkgs; [
			kitty
			st
			hyprcursor
			rofi
			firefox
			dunst
			quickshell
			vesktop
			zed-editor
			xfce.thunar
			nerd-fonts.fira-code
			nerd-fonts.droid-sans-mono
			nerd-fonts.symbols-only
			prismlauncher
			spotify
		];
	};
}
