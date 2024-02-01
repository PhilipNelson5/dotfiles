local telescope = require('telescope.builtin')
vim.keymap.set('n', '<leader>fb', telescope.buffers, {})    -- find buffers
vim.keymap.set('n', '<leader>fh', telescope.help_tags, {})  -- find help
vim.keymap.set('n', '<leader>pf', telescope.find_files, {}) -- project find
vim.keymap.set('n', '<leader>pg', telescope.git_files, {})  -- project gitfiles
vim.keymap.set('n', '<leader>ps', function()                -- project search
	telescope.grep_string({ search = vim.fn.input("grep > ") });
end)
