return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },
  {
    "tpope/vim-fugitive",
  },
  {
    "nvim-lua/plenary.nvim",
    lazy = true, -- Optional: Load only when required
  },
  {
    "TimUntersberger/neogit",
    dependencies = { "nvim-lua/plenary.nvim" }, -- Required dependency
    config = function()
      require("neogit").setup({
        integrations = {
          diffview = true, -- Optional: If you want to integrate with Diffview.nvim
        },
      })
    end,
  },
  -- Optional: Diffview.nvim for enhanced diff UI
  {
    "sindrets/diffview.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  {
    "kdheepak/lazygit.nvim",
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },

    dependencies = {
      "nvim-lua/plenary.nvim",
    },

    keys = {
      { "<leader>lg", "<cmd>LazyGit<cr>", desc = "Open LazyGit" },
    },
  },
  -- {
  --   "lewis6991/gitsigns.nvim",
  --   config = function()
  --     require("gitsigns").setup()
  --   end,
  -- },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make"
  },
  -- Add gitsigns.nvim plugin
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup({
        signs = {
          add = { text = "│" },
          change = { text = "│" },
          delete = { text = "_" },
          topdelete = { text = "‾" },
          changedelete = { text = "~" },
        },
        current_line_blame = true, -- Display blame information inline
        current_line_blame_opts = {
          delay = 100,
          virt_text_pos = "eol",
        },
      })
      -- Set highlights for GitSigns
      vim.api.nvim_set_hl(0, "GitSignsAdd", { link = "GitGutterAdd" })
      vim.api.nvim_set_hl(0, "GitSignsChange", { link = "GitGutterChange" })
      vim.api.nvim_set_hl(0, "GitSignsDelete", { link = "GitGutterDelete" })
    end,
  },

  --{
  --  "iamcco/markdown-preview.nvim",
  --  build = function() vim.fn["mkdp#util#install"]() end,
  --  ft = "markdown",
  --},
  -- {
  -- 	"nvim-treesitter/nvim-treesitter",
  -- 	opts = {
  -- 		ensure_installed = {
  -- 			"vim", "lua", "vimdoc",
  --      "html", "css"
  -- 		},
  -- 	},
  -- },
}
