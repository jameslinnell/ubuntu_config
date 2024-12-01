-- local plugins = {
  --{
  --  "williamboman/mason.nvim",
  --  opts = {
  --    ensure_installed = {
  --      "pyright",
  --    },
  --  },
  --},
  -- {
  --  "nvim-telescope/telescope-fzf-native.nvim",
  --  build = "make",
  -- }
  -- ["custom/cpm_test_runner"] = {
  --   config = function()
  --     require("cpm_test_runner")
  --   end,
  -- },
-- }
-- return plugins
return {
  ["custom/cpm_tests"] = {
    config = function()
      require("cpm_tests")
    end,
  },
}
