return {
  "dense-analysis/ale",
  lazy = false,
  init = function()
    vim.cmd [[
      let g:ale_linters = {
        \ "javascript": ["eslint"],
        \ "typescript": ["eslint"],
        \ "typescriptreact": ["eslint"],
        \ "ruby": ["rubocop"],
        \ "vue": ["eslint", "vls"],
        \ "go": ["golangci-lint"],
        \ "scss": ["stylelint"]
      \ }
      let g:ale_linters_explicit = 1
      let g:ale_use_neovim_diagnostics_api = 1
      let g:ale_ruby_rubocop_executable = "bundle"
      let g:ale_ruby_rubocop_options = "--server"
      if filereadable("bin/docker-cmd")
        let g:ale_command_wrapper = "bin/docker-cmd"
        let g:ale_ruby_rubocop_executable = "rubocop"
      endif
      let g:ale_fixers = {
        \ "go": ["gofumpt"],
        \ "javascript": ["eslint"],
        \ "typescript": ["eslint"],
        \ "typescriptreact": ["eslint"]
      \ }
      let g:ale_fix_on_save = 1
      let g:ale_fix_on_save_ignore = ["eslint"]
      " let g:ale_virtualtext_cursor = "current"
      let g:ale_virtualtext = 0
      let g:ale_virtualtext_cursor = 0
      let g:ale_echo_cursor = 0
      let g:ale_go_golangci_lint_package = 1
    ]]
  end,
}
