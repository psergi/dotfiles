return {
  "vim-test/vim-test",
  lazy = false,
  dependencies = {
    "preservim/vimux"
  },
  init = function()
    vim.cmd [[
      let g:VimuxHeight = "30%"
      let test#strategy = "vimux"
      if filereadable('docker-compose.override.yml')
        let test#ruby#rspec#executable = "bin/runner rspec"
      elseif filereadable('bin/docker-cmd')
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
