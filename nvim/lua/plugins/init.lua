return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    opts = function(_, opts)
      opts.formatters = vim.tbl_deep_extend("force", opts.formatters or {}, {
        odinfmt = {
          command = "odinfmt",
          args = { "-stdin" },
          stdin = true,
        },
      })

      opts.formatters_by_ft = vim.tbl_deep_extend("force", opts.formatters_by_ft or {}, {
        lua = { "stylua" },
        rust = { "rustfmt" },
        javascript = { "prettier" },
        javascriptreact = { "prettier" },
        typescript = { "prettier" },
        typescriptreact = { "prettier" },
        svelte = { "prettier" },
        html = { "prettier" },
        css = { "prettier" },
        scss = { "prettier" },
        json = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
        haskell = { "fourmolu" },
        odin = { "odinfmt" },
        julia = { "runic" },
      })

      opts.format_on_save = {
        timeout_ms = 2000,
        lsp_format = "fallback",
      }

      return opts
    end,
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"

      vim.lsp.enable "ols"
    end,
  },

  {
    "mrcjkb/rustaceanvim",
    version = "^9",
    lazy = false,
    init = function()
      local mason_registry = require "mason-registry"
      local codelldb = mason_registry.get_package "codelldb"
      local extension_path = codelldb:get_install_path() .. "/extension/"
      local codelldb_path = extension_path .. "adapter/codelldb"
      local liblldb_path = extension_path .. "lldb/lib/liblldb.dylib"
      local cfg = require "rustaceanvim.config"

      vim.g.rustaceanvim = {
        dap = {
          adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path),
        },

        server = {
          settings = {
            ["rust-analyzer"] = {
              cargo = {
                allFeatures = true,
              },

              checkOnSave = true,

              check = {
                command = "clippy",
                extraArgs = { "--", "-D", "warnings" },
              },
            },
          },
        },
      }
    end,
  },

  {
    "mfussenegger/nvim-dap",
    config = function()
      local dap, dapui = require "dap", require "dapui"

      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end

      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end

      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end

      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end
    end,
  },

  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
    },
    config = function()
      require("dapui").setup()
    end,
  },

  {
    "saecki/crates.nvim",
    ft = { "toml" },
    config = function()
      require("crates").setup {
        completion = {
          cmp = {
            enabled = true,
          },
        },
      }

      require("cmp").setup.buffer {
        sources = {
          { name = "crates" },
        },
      }
    end,
  },

  {
    "folke/todo-comments.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    event = "VeryLazy",
    opts = {},
  },

  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
      "nvim-telescope/telescope.nvim",
    },
    cmd = "Neogit",
    opts = {},
  },

  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
    config = function()
      require "configs.treesitter"
    end,
  },
}
