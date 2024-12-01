local M = {}

M.print_hello = function()
  print("Hello World")
end

-- Function to run the cpm-test-unit command
M.run_cpm_test_unit = function()
  -- Open a new terminal window and run the test command
  vim.cmd("split | terminal zsh -i -c 'cpm-test-unit'")
  -- vim.fn.system("source ~/.zshrc")
  -- local job = vim.fn.systemlist("cpm-test-unit")
  -- local job = vim.fn.systemlist("sh ~/Scripts/run-cpm.sh --unittest")
  -- local job = vim.fn.systemlist("zsh -i -c 'cpm-test-unit'")
  -- Check for errors
  -- if vim.v.shell_error == 0 then
  --   -- If successful, print the output
  --   print("CPM Test Unit ran successfully:")
  --   print(table.concat(job, "\n"))
  -- else
  --   -- If there was an error, print it
  --   print("Error running CPM Test Unit:")
  --   print(table.concat(job, "\n"))
  -- end
end

return M
