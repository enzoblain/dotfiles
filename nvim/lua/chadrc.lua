---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "github_dark",

  transparency = true,

  hl_override = {
    Normal = { bg = "NONE" },
    NormalFloat = { bg = "NONE" },
    FloatBorder = { bg = "NONE" },
    SignColumn = { bg = "NONE" },
    EndOfBuffer = { bg = "NONE" },
    NvimTreeGitDirty = { fg = "white" },
    NvimTreeGitNew = { fg = "white" },
    NvimTreeGitDeleted = { fg = "white" },
    NvimTreeGitIgnored = { fg = "white" },
    NvimTreeGitStaged = { fg = "white" },
    NvimTreeGitMerge = { fg = "white" },
    NvimTreeGitRenamed = { fg = "white" },
  },
}

return M
