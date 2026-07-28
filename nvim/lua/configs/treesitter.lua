local ensure_installed = {
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
}

require("nvim-treesitter").install(ensure_installed)

vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "html",
    "css",
    "typescript",
    "typescriptreact",
    "javascript",
    "javascriptreact",
    "svelte",
    "json",
    "yaml",
    "lua",
    "rust",
    "haskell",
  },
  callback = function(args)
    vim.treesitter.start(args.buf)
    vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
})
