local M = {}

M.general = {
  n = {
    ["<C-a>"] = { "<C-^>", "Alternate file" },
  }
}

M.telescope = {
  n = {
    ["<C-p>"] = { "<cmd> Telescope find_files <CR>", "Find files" },
    ["<C-l>"] = { "<cmd> Telescope live_grep <CR>", "Live grep" },
  }
}

M.vimtest = {
  n = {
    ["<Bslash>s"] = { "<cmd> silent TestNearest <CR>", "Run the test nearest to the cursor" },
    ["<Bslash>t"] = { "<cmd> silent TestFile <CR>", "Run the current test file" },
    ["<Bslash>a"] = { "<cmd> silent TestSuite <CR>", "Run the test suite" },
  }
}

M.ale = {
  n = {
    ["<Bslash>f"] = { "<cmd> silent ALEFix <CR>", "Auto-fix linting issues with the current file" }
  }
}

M.nvterm = {
  n = {
    ["<C-t>"] = {
      function()
        require("nvterm.terminal").toggle "horizontal"
      end,
      "Toggle horizontal term",
    },
  }
}

return M
