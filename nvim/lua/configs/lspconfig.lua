require("nvchad.configs.lspconfig").defaults()

local servers = {
  "html",
  "cssls",
  "css_variables",
  "emmet_language_server",
  "ts_ls",
  "svelte",
  "jsonls",
  "yamlls",
  "taplo",
  "lua_ls",
  "marksman",
  "texlab",
  "ltex",
  "hls",
  "dockerls",
  "docker_compose_language_service",
  "bashls",
  "graphql",
  "htmx",
  "solidity",
  "ols",
  "julials",
  "zls",
  "sqls",
}

vim.lsp.enable(servers)

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    if vim.lsp.inlay_hint then
      vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
    end
  end,
})
