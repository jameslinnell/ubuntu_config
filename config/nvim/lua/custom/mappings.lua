-- lua/custom/mappings.lua

---@class M
local M = {}

M.general = {
  n = {
    ["<leader>F"] = { "<cmd>Telescope find_files<cr>", "Find files" },
    ["<leader>Z"] = { "<cmd>Telescope live_grep<cr>", "Live grep" },
    ["<leader>U"] = { "<cmd>lua require('hello_world').print_hello()<cr>", "Print Hello World" },
--    ["<leader>tu"] = { "<cmd>lua require('cpm_test_runner').run_test()<CR>", "Run CPM unit tests"},
  },
}

return M
