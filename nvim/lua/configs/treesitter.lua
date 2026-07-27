local options = {
  ensure_installed = {
    "html",
    "css",
    "typescript",
    "tsx",
    "javascript",
    "svelte",
    "json",
    "yaml",
    "lua",
    "rust",
    "haskell",
  },
  highlight = {
    enable = true,
  },
  indent = { enable = true },
}

require("nvim-treesitter.configs").setup(options)
