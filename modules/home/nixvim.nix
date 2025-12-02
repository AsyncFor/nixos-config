{ inputs, ...}:
{
	flake.homeModules.nixvim = {
	  imports = [ inputs.nixvim.homeModules.nixvim ];
	  programs.nixvim = {
    	    enable = true;
	    viAlias = true;
	    vimAlias = true;
	    defaultEditor = true;
  	  };
	};
}
