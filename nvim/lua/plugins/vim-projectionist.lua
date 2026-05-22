return {
  "tpope/vim-projectionist",
  init = function()
    vim.g.projectionist_heuristics = {
      -- Ruby
      ["Gemfile"] = {
        ["lib/*.rb"] = { alternate = "spec/{}_spec.rb" },
        ["spec/*_spec.rb"] = { alternate = "lib/{}.rb" },
        ["app/*.rb"] = { alternate = "spec/{}_spec.rb", type = "source" },
      },

      -- Go
      ["go.mod"] = {
        ["*.go"] = { alternate = "{}_test.go" },
        ["*_test.go"] = { alternate = "{}.go" },
      },

      -- Node / TS
      ["package.json"] = {
        ["src/*.ts"] = { alternate = "src/{}.test.ts" },
        ["src/*.test.ts"] = { alternate = "src/{}.ts" },
      },
    }
  end
}
