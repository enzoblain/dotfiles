return {
  {
    "nvim-tree/nvim-tree.lua",
    opts = function(_, opts)
      opts.renderer = opts.renderer or {}
      opts.renderer.highlight_git = false

      opts.renderer.icons = opts.renderer.icons or {}
      opts.renderer.icons.glyphs = opts.renderer.icons.glyphs or {}

      opts.renderer.icons.glyphs.git = {
        unstaged = "U",
        staged = "S",
        unmerged = "UM",
        renamed = "R",
        deleted = "D",
        untracked = "?",
        ignored = "I",
      }

      return opts
    end,
  },
}
