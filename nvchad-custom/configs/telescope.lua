local options = {
  pickers = {
    find_files = {
      follow = true
    }
  },
  extensions_list = { "themes", "terms", "fzf" },
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
    }
  },
}

return options
