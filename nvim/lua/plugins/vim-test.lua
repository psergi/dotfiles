return {
  "vim-test/vim-test",
  lazy = false,
  init = function()
    vim.cmd [[
      let test#strategy = "toggleterm"
      if filereadable('bin/docker-cmd')
        let test#ruby#rspec#executable = "bin/docker-cmd spring rspec"
      elseif filereadable('bin/spring')
        let test#ruby#rspec#executable = "clear && COVERAGE=false bundle exec spring rspec"
      else
        let test#ruby#rspec#executable = "clear && COVERAGE=false bundle exec rspec"
      endif
      let test#go#gotest#options = { "all": "-v" }
    ]]
  end
}
