-- Geral
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

map("n", "<C-s>", ":w<CR>", opts)      -- salvar
map("n", "<C-t>", ":term<CR>", opts)   -- abrir terminal

-- Abrir/Fechar Neo-tree
map("n", "<leader>e", ":Neotree toggle<CR>", opts)

-- Abrir Neo-tree no diretório atual
map("n", "<leader>o", ":Neotree reveal<CR>", opts)

-- Focar Neo-tree
map("n", "<leader>f", ":Neotree focus<CR>", opts)

-- Obsdian keymaps
vim.keymap.set("n", "<leader>on", ":ObsidianNew<CR>", { desc = "Nova nota Obsidian" })
vim.keymap.set("n", "<leader>oo", ":ObsidianOpen<CR>", { desc = "Abrir nota atual no app Obsidian" })
vim.keymap.set("n", "<leader>os", ":ObsidianSearch<CR>", { desc = "Pesquisar notas" })
vim.keymap.set("n", "<leader>ot", ":ObsidianToday<CR>", { desc = "Nota diária de hoje" })

