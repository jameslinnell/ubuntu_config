require "nvchad.mappings"
local opts = { noremap = true, silent = true }
-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("n", "<leader>fz", "<cmd>Telescope live_grep<cr>", opts)
map("n", "<leader>U", "<cmd>lua require('custom.cpm_tests').run_cpm_test_unit()<cr>", { silent = false, buffer = true, script = true })
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
