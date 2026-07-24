require("nvchad.configs.lspconfig").defaults()

local servers = { "rust_analyzer", "html", "cssls", "hls", "ts_ls", "svelte", "lua_ls" }
vim.lsp.enable(servers)

vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        checkThirdParty = false,
      },
      telemetry = {
        enable = false,
      },
    },
  },
})
vim.lsp.config("hls", {})
vim.lsp.config("svelte", {})
vim.lsp.config("rust_analyzer", {
  settings = {
    ["rust-analyzer"] = {
      checkOnSave = true,
      check = {
        command = "clippy",
        extraArgs = { "--", "-D", "warnings" },
      },
    },
  },
})
