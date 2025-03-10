return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.8",
  dependencies = {
    {
      "nvim-lua/plenary.nvim"
    },
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make"
    },
    {
      "nvim-telescope/telescope-live-grep-args.nvim"
    }
  },
  opts = {
    defaults = {
      prompt_prefix = "   ",
      selection_caret = "  ",
      entry_prefix = "  ",
      initial_mode = "insert",
      selection_strategy = "reset",
      sorting_strategy = "ascending",
      layout_strategy = "horizontal",
      layout_config = {
        horizontal = {
          prompt_position = "top",
          preview_width = 0.55,
        },
        vertical = {
          mirror = false,
        },
        width = 0.87,
        height = 0.80,
        preview_cutoff = 120,
      }
    },
    extensions = {
      fzf = {
        fuzzy = true,                    -- false will only do exact matching
        override_generic_sorter = true,  -- override the generic sorter
        override_file_sorter = true,     -- override the file sorter
        case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
      },
      live_grep_args = {
        auto_quoting = false, -- enable/disable auto-quoting
      }
    },
  }
}
