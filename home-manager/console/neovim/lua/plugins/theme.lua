local spec = {
    {
        "shaunsingh/nord.nvim",
        priority = 1000,
        lazy = false,
        config = function()
            vim.g.nord_italic = false
            require("nord").set()
        end,
    },

    {
        -- Set lualine as statusline
        "nvim-lualine/lualine.nvim",
        -- See `:help lualine.txt`
        event = "VeryLazy",
        opts = {
            options = {
                icons_enabled = true,
                theme = "nord",
                -- component_separators = { left = '', right = '' },
                -- section_separators = { left = '', right = '' }
            },
        },
    },

    { "nvim-tree/nvim-web-devicons", opt = true },

    -- {
    -- 	-- Add indentation guides even on blank lines
    -- 	"shellRaining/hlchunk.nvim",
    -- 	event = { "BufReadPre", "BufNewFile" },
    -- 	config = function()
    -- 		require("hlchunk").setup({
    -- 			chunk = {
    -- 				enable = true,
    -- 				-- ...
    -- 			},
    -- 			indent = {
    -- 				enable = true,
    -- 				-- ...
    -- 			},
    -- 		})
    -- 	end,
    -- },
    {
        "hiphish/rainbow-delimiters.nvim",
        event = { "BufReadPost", "BufNewFile" },
        dependencies = { "nvim-treesitter/nvim-treesitter" },

        config = function()
            vim.g.rainbow_delimiters = {
                highlight = {
                    "RainbowDelimiterCyan",
                    "RainbowDelimiterYellow",
                    "RainbowDelimiterBlue",
                    "RainbowDelimiterGreen",
                    "RainbowDelimiterViolet",
                },
            }
        end,
    },
    {
        "akinsho/bufferline.nvim",
        version = "*",
        config = function()
            vim.opt.termguicolors = true
            local highlights = require("nord").bufferline.highlights({
                italic = true,
                bold = true,
            })

            require("bufferline").setup({
                options = {
                    separator_style = "thin",
                },
                highlights = highlights,
            })
        end,
        event = "VeryLazy",
    },
}
return spec
