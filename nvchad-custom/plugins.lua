local plugins = {
  -- disble default plugins that are not needed
  {
    "lewis6991/gitsigns.nvim",
    enabled = false
  },

  -- custom config for default plugins
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "gopls"
      },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = function()
      local defaults = require "plugins.configs.treesitter"
      local custom = require "custom.configs.treesitter"
      return vim.tbl_deep_extend("force", defaults, custom)
    end,
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
  },

  {
    "nvim-telescope/telescope.nvim",
    opts = function()
      local defaults = require "plugins.configs.telescope"
      local custom = require "custom.configs.telescope"
      return vim.tbl_deep_extend("force", defaults, custom)
    end,
    dependencies = {
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make"
      },
    }
  },

  {
    "hrsh7th/nvim-cmp",
    opts = function()
      local defaults = require "plugins.configs.cmp"
      local custom = require "custom.configs.cmp"
      return vim.tbl_deep_extend("force", defaults, custom)
    end,
  },

  -- additional plugins

  {
    "vim-test/vim-test",
    lazy = false,
    init = function()
      vim.cmd [[
        let test#strategy = "toggleterm"
        let test#ruby#rspec#executable = "clear && COVERAGE=false bundle exec spring rspec"
        let test#go#gotest#options = { "all": "-v" }
      ]]
    end,
  },

  {
    "tpope/vim-rails",
    ft = { "ruby" }
  },

  {
    "tpope/vim-fugitive",
    lazy = false,
    config = function(_, _)
      dofile(vim.g.base46_cache .. "git")
    end
  },

  {
    "dense-analysis/ale",
    lazy = false,
    init = function()
      vim.cmd [[
        let g:ale_linter_aliases = { "vue": ["vue", "javascript"] }
        let g:ale_linters = { "javascript": ["eslint"], "typescript": ["eslint"], "ruby": ["rubocop"], "vue": ["eslint", "vls"], "go": ["golangci-lint"] }
        let g:ale_linters_explicit = 1
        let g:ale_ruby_rubocop_executable = "bundle"
        let g:ale_fixers = { "go": ["gofumpt"] }
        let g:ale_fix_on_save = 0
        let g:ale_virtualtext_cursor = "current"
        " let g:ale_go_golangci_lint_package = 1
      ]]
    end,
  },

  {
    "andymass/vim-matchup",
    lazy = false
  },

  {
    "akinsho/toggleterm.nvim",
    version = "*",
    init = function()
      require("toggleterm").setup({
        size = 15,
        shade_terminals = false,
        open_mapping = [[<C-\>]]
      })
    end,
  },
}

return plugins
