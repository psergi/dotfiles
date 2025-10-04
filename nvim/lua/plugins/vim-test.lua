return {
  "vim-test/vim-test",
  lazy = false,
  init = function()
    vim.cmd [[
      let test#strategy = "toggleterm"
      if filereadable('bin/docker-cmd')
        let test#ruby#rspec#executable = "bin/docker-cmd spring rspec"
      elseif filereadable('bin/spring')
        let test#ruby#rspec#executable = "clear && bin/spring rspec --no-profile"
      else
        let test#ruby#rspec#executable = "clear && bundle exec rspec --no-profile"
      endif
      let test#go#gotest#options = { "all": "-v" }
    ]]
  end
}
