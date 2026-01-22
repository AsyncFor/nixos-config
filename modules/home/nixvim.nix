{ inputs, ... }:
{
  flake.homeModules.nixvim = {
    imports = [ inputs.nixvim.homeModules.nixvim ];
    programs.nixvim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
      defaultEditor = true;

      opts = {
        number = true;
        relativenumber = true;
        expandtab = true;
        shiftwidth = 4;
        tabstop = 4;
        smartindent = true;
        termguicolors = true;
        signcolumn = "yes";
        updatetime = 300;
        mouse = "a";
        clipboard = "unnamedplus";
      };

      globals = {
        mapleader = " ";
      };

      plugins = {
        # LSP configuration
        lsp = {
          enable = true;
          servers = {
            clangd.enable = true; # C/C++ LSP
            nixd.enable = true; # Nix LSP
          };
        };

        # Autocompletion
        cmp = {
          enable = true;
          autoEnableSources = true;
          settings = {
            sources = [
              { name = "nvim_lsp"; }
              { name = "path"; }
              { name = "buffer"; }
            ];
            mapping = {
              "<C-Space>" = "cmp.mapping.complete()";
              "<CR>" = "cmp.mapping.confirm({ select = true })";
              "<Tab>" = "cmp.mapping.select_next_item()";
              "<S-Tab>" = "cmp.mapping.select_prev_item()";
            };
          };
        };

        # Treesitter for better syntax highlighting
        treesitter = {
          enable = true;
          settings = {
            highlight.enable = true;
            indent.enable = true;
          };
        };

        # File explorer
        neo-tree = {
          enable = true;
        };

        # Fuzzy finder
        telescope = {
          enable = true;
        };

        # Status line
        lualine = {
          enable = true;
        };

        # Git integration
        gitsigns = {
          enable = true;
        };

        # Auto pairs
        nvim-autopairs = {
          enable = true;
        };

        # Comments
        comment = {
          enable = true;
        };

        # Which key for keybinding hints
        which-key = {
          enable = true;
        };
      };

      keymaps = [
        # File explorer
        {
          mode = "n";
          key = "<leader>e";
          action = "<cmd>Neotree toggle<CR>";
          options.desc = "Toggle file explorer";
        }
        # Telescope
        {
          mode = "n";
          key = "<leader>ff";
          action = "<cmd>Telescope find_files<CR>";
          options.desc = "Find files";
        }
        {
          mode = "n";
          key = "<leader>fg";
          action = "<cmd>Telescope live_grep<CR>";
          options.desc = "Live grep";
        }
        {
          mode = "n";
          key = "<leader>fb";
          action = "<cmd>Telescope buffers<CR>";
          options.desc = "Find buffers";
        }
        # LSP
        {
          mode = "n";
          key = "gd";
          action = "<cmd>lua vim.lsp.buf.definition()<CR>";
          options.desc = "Go to definition";
        }
        {
          mode = "n";
          key = "gr";
          action = "<cmd>lua vim.lsp.buf.references()<CR>";
          options.desc = "Find references";
        }
        {
          mode = "n";
          key = "K";
          action = "<cmd>lua vim.lsp.buf.hover()<CR>";
          options.desc = "Hover documentation";
        }
        {
          mode = "n";
          key = "<leader>ca";
          action = "<cmd>lua vim.lsp.buf.code_action()<CR>";
          options.desc = "Code action";
        }
        {
          mode = "n";
          key = "<leader>rn";
          action = "<cmd>lua vim.lsp.buf.rename()<CR>";
          options.desc = "Rename symbol";
        }
      ];
    };
  };
}
