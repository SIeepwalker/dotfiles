return {
    { "folke/neodev.nvim", opts = {} },
    {
        "williamboman/mason.nvim",
        event = "VeryLazy",
        cmd = { "LspInfo", "Mason" },
        config = function()
            require("cmp-setup")
            require("mason-setup")
            require("lsp-setup")
        end,
        dependencies = {
            "williamboman/mason-lspconfig.nvim",
            "neovim/nvim-lspconfig",
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline',
            'hrsh7th/nvim-cmp',
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
            'rafamadriz/friendly-snippets', }
    },
    {
        'aznhe21/actions-preview.nvim',
        keys = "cr",
        config = function()
            local actionsPreview = require("actions-preview")
            actionsPreview.setup { telescope = require("telescope.themes").get_ivy({}) }
            vim.keymap.set({ 'n', 'v' }, 'cr', actionsPreview.code_actions, {})
        end,
        dependencies = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope-fzy-native.nvim', 'nvim-tree/nvim-web-devicons' }
    },
    {
        "zeioth/garbage-day.nvim",
        dependencies = "neovim/nvim-lspconfig",
        event = "VeryLazy",
        opts = {}
    },
}
