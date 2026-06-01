vim.pack.add({
    { src = "https://github.com/catppuccin/nvim", name = "catppuccin" },
    "https://github.com/nvim-mini/mini.nvim",
    "https://www.github.com/nvim-tree/nvim-tree.lua",
    "https://www.github.com/ibhagwan/fzf-lua"
})


-- Theme
require("catppuccin").setup({
    flavour = "mocha", -- latte, frappe, macchiato, mocha

    transparent_background = true,

    float = {
        transparent = true,
    },
})

vim.cmd.colorscheme("catppuccin")

-- Tree
require("nvim-tree").setup({
	view = {
		width = 30,
	},
	filters = {
		dotfiles = false,
        custom = {
            "^%.git$",
        },
	},
	renderer = {
		group_empty = true,
	},
})

vim.keymap.set("n", "<leader>e", function()
	require("nvim-tree.api").tree.toggle()
end, { desc = "Toggle NvimTree" })
vim.keymap.set("n", "<leader>er", function()
    require("nvim-tree.api").tree.change_root_to_node()
end, { desc = "Root tree at current node" })

-- Mini
require("mini.notify").setup({
    content = {
        format = function(notif)
            return notif.msg
        end,
    },
})

require("mini.cmdline").setup({})

-- fzf
require("fzf-lua").setup({})
vim.keymap.set("n", "<leader>ff", function()
	require("fzf-lua").files()
end, { desc = "FZF Files" })
vim.keymap.set("n", "<leader>fg", function()
	require("fzf-lua").live_grep()
end, { desc = "FZF Live Grep" })