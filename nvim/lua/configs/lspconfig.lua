require("nvchad.configs.lspconfig").defaults()

local servers = require "configs.lsp_servers"

vim.lsp.enable(servers)

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    if vim.lsp.inlay_hint then
      vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
    end
  end,
})
