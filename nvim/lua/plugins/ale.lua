return {
  "dense-analysis/ale",
  lazy = false,
  init = function()
    vim.cmd [[
      let g:ale_linter_aliases = { "vue": ["vue", "javascript"] }
      let g:ale_linters = { "javascript": ["eslint"], "typescript": ["eslint"], "ruby": ["rubocop"], "vue": ["eslint", "vls"], "go": ["golangci-lint"], "scss": ["stylelint"] }
      let g:ale_linters_explicit = 1
      let g:ale_use_neovim_diagnostics_api = 0
      let g:ale_ruby_rubocop_executable = "bundle"
      let g:ale_ruby_rubocop_options = "--server"
      if filereadable("bin/docker-cmd")
        let g:ale_command_wrapper = "bin/docker-cmd"
        let g:ale_ruby_rubocop_executable = "rubocop"
        let g:ale_javascript_eslint_executable = "node_modules/.bin/eslint"
        let g:ale_javascript_eslint_use_global = 1
        let g:ale_css_stylelint_executable = "node_modules/.bin/stylelint"
        let g:ale_css_stylelint_use_global = 1
      endif
      let g:ale_fixers = { "go": ["gofumpt"], "javascript": ["eslint"] }
      let g:ale_fix_on_save = 1
      let g:ale_fix_on_save_ignore = ["eslint"]
      let g:ale_virtualtext_cursor = "current"
      let g:ale_go_golangci_lint_package = 1
    ]]
  end,
}
