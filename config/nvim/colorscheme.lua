return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      no_italic = true,
      integrations = {
        neotree = true,
      },
    },
  },
  { "LazyVim/LazyVim", opts = {
    colorscheme = "catppuccin-mocha",
  } },
}
