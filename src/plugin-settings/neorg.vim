" Manually set filetype (this is a bug...).
" TODO: Find out why this doesn't happen automatically.
au BufRead,BufNewFile *.norg set ft=norg

" Outsource folding to treesitter.
au filetype norg set foldmethod=expr
au filetype norg set foldexpr=nvim_treesitter#foldexpr()

" Concealer
au filetype norg set conceallevel=3

" Modules and their config.
lua << EOF
require('neorg').setup {
    load = {
        ["core.defaults"] = {}, -- Loads default behaviour
        -- ["core.autocommands"] = {},
        -- ["core.integrations.treesitter"] = {},
        -- ["core.export.markdown"] = {},
        ["core.export"] = {},
        ["core.concealer"] = { -- Adds pretty icons to your documents
            config = {
                folds = true,
                icon_preset = "diamond",
                init_open_folds = "auto",
            },
        },
        ["core.dirman"] = { -- Manages Neorg workspaces
            config = {
                workspaces = {
                    notes = "~/notes",
                },
            },
        },
    },
}
EOF
