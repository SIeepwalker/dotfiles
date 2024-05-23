return {
    {
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        keys = { "<leader>f", "<leader>g" },
        cmd = "Telescope",
        config = function()
            require("telescope-config")
        end,
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope-fzy-native.nvim',
            'nvim-tree/nvim-web-devicons',
            'natecraddock/workspaces.nvim',
        }
    },
    {
        'natecraddock/workspaces.nvim',
        keys = { "<leader>fp" },
        cmd = "Telescope workspaces",
        config = function()
            require("workspaces").setup()
        end,
    },
}
