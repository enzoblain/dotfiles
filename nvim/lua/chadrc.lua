---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "onedark",

  hl_override = {
    NvimTreeGitDirty = { fg = "white" },
    NvimTreeGitNew = { fg = "white" },
    NvimTreeGitDeleted = { fg = "white" },
    NvimTreeGitIgnored = { fg = "white" },
    NvimTreeGitStaged = { fg = "white" },
    NvimTreeGitMerge = { fg = "white" },
    NvimTreeGitRenamed = { fg = "white" },
    NvimTreeDiagnosticErrorFileHL = { fg = "red", bold = true },
    NvimTreeDiagnosticWarnFileHL = { fg = "yellow" },
    NvimTreeDiagnosticInfoFileHL = { fg = "blue" },
    NvimTreeDiagnosticHintFileHL = { fg = "green" },
  },
}

return M
