local options = {
  pickers = {
    find_files = {
      follow = true
    }
  },
  extensions_list = { "themes", "terms", "fzf", "live_grep_args" },
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

return options
