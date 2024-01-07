local devicons = require("nvim-web-devicons")
devicons.setup({
  strict = true,
  override = {
    astro = {
      icon = "󱓟",
      color = "#ef8547",
      name = "Astro",
    },
  },
  override_by_extension = {
    ["astro"] = {
      icon = "󱓟",
      color = "#ef8547",
      name = "Astro",
    },
  },
})
