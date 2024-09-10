-- lazy-nvim
require("lazy").setup(
    "plugins",
    {
        defaults = {
            lazy = true
        },
        performance = {
            cache = {
                enabled = true,
            },
            reset_packpath = true, -- reset the package path to improve startup time
            rtp = {
                reset = true,      -- reset the runtime path to $VIMRUNTIME and your config directory
                ---@type string[]
                paths = {},        -- add any custom paths here that you want to includes in the rtp
                ---@type string[] list any plugins you want to disable here
                disabled_plugins = {
                    "gzip",
                    "matchit",
                    "matchparen",
                    "netrwPlugin",
                    "tarPlugin",
                    "tohtml",
                    "tutor",
                    "zipPlugin",
                },
            },
        },
    }
)
