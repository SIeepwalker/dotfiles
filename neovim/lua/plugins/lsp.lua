return {
    {
        "folke/lazydev.nvim",
        event = "VeryLazy",
        ft = "lua",
        opts = {},
        dependencies = {
            "williamboman/mason.nvim",
        }
    },
    {
        "williamboman/mason.nvim",
        event = "VeryLazy",
        version = "1.*",
        config = function()
            require("cmp-setup")
            require("mason-setup")
            require("lsp-setup")
        end,
        dependencies = {
            {"williamboman/mason-lspconfig.nvim", version = "1.*"},
            {"neovim/nvim-lspconfig", version = "0.*"},
        }
    },
    {

        'hrsh7th/nvim-cmp',
        event = "VeryLazy",
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline',
            {"L3MON4D3/LuaSnip", version = "2.*"},
            "saadparwaiz1/cmp_luasnip",
            'rafamadriz/friendly-snippets', 
        }
    },
    {
        "zeioth/garbage-day.nvim",
        dependencies = "neovim/nvim-lspconfig",
        version = "1.*",
        event = "VeryLazy",
        opts = {}
    },
}
