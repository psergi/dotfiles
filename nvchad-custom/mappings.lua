local M = {}

M.telescope = {
  n = {
    ["<C-p>"] = { "<cmd> Telescope find_files <CR>", "Find files" },
  }
}

M.vimtest = {
  n = {
    ["<Bslash>s"] = { "<cmd> silent TestNearest <CR>", "Run the test nearest to the cursor" },
    ["<Bslash>t"] = { "<cmd> silent TestFile <CR>", "Run the current test file" },
    ["<Bslash>a"] = { "<cmd> silent TestSuite <CR>", "Run the test suite" },
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
