return {
  "neo-tree.nvim",
  opts = {
    close_if_last_window = false,
    filesystem = {
      filtered_items = {
        hide_dotfiles = false,
        never_show = { ".git", ".DS_Store", ".localized" },
      },
    },
    window = {
      width = 30,
    },
  },
}
