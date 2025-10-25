require("options")
require("keymaps")

vim.pack.add {
    { src = 'https://github.com/neovim/nvim-lspconfig' },
    { src = 'https://github.com/mason-org/mason.nvim' },
    { src = 'https://github.com/mason-org/mason-lspconfig.nvim' },
    { src = "https://github.com/Saghen/blink.cmp" },
    { src = "https://github.com/scottmckendry/cyberdream.nvim" },
    { src = "https://github.com/nvim-lualine/lualine.nvim" },
    { src = "https://github.com/MeanderingProgrammer/render-markdown.nvim" },
    { src = "https://github.com/nvim-mini/mini.nvim" },
    { src = "https://github.com/chomosuke/typst-preview.nvim" },
    { src = "https://github.com/RRethy/vim-illuminate" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
    -- { src = "https://github.com/gelguy/wilder.nvim" },

    { src = "https://github.com/iamcco/markdown-preview.nvim" },
    -- falls yarn vergessen: in .local/share/nvim/site/pack/core/opt/markdown-preview.nvim -> yarn install
    -- muss noch manuel install werden: in: "~/.local/share/nvim/site/pack/core/opt/markdown-preview.nvim" -> npx --yes yarn install
}
vim.pack.del {
    -- { src = "https://github.com/gelguy/wilder.nvim" },
    -- { src = "https://github.com/iamcco/markdown-preview.nvim" },
}

require('mason').setup()
require('mason-lspconfig').setup({
    ensure_installed = {
        "lua_ls",
        "pyrefly",
        "pyright",
        "tinymist",
        "clangd",
        "bashls",
    }
})

require("blink.cmp").setup({
    fuzzy = { implementation = "lua" },
    sources = {
        default = { 'lsp', 'path', 'buffer' },
    },
    completion = {
        list = {
            selection = { preselect = false, auto_insert = true },
        },
        -- list.selection = { preselect = false, auto_insert = true },
    },
    keymap = {
        -- set to 'none' to disable the 'default' preset
        preset = 'none',

        ['<C-k>'] = { 'select_prev', 'fallback' },
        ['<C-j>'] = { 'select_next', 'fallback' },
        ['<c-Space>'] = { 'select_next', 'fallback' },
        ['<CR>'] = {"accept", "fallback"},
    }
})

require('cyberdream').setup({
    transparent = true,
})
vim.cmd("colorscheme cyberdream")

require("lualine").setup({
    options = {
        theme = "cyberdream",
        globalstatus = true,
        component_separators = { left = "|", right = "|" },
        section_separators = { left = "", right = "" },
    },
    sections = {
        lualine_a = { "mode" },
        lualine_b = { "buffers" },
        lualine_x = { "encoding", "fileformat", "filetype", "progress" },
        lualine_y = { "" },
        lualine_z = { "location" },
    },
    tabline = {},
})

-- require("wilder").setup({
--       modes = {':', '/', '?'},
--       next_key = '<Tab>',
--       previous_key = '<S-Tab>',
--       accept_key = '<Down>',
--       reject_key = '<Up>',
-- })

vim.opt.wildmenu = false
vim.opt.wildmode = ""

-- local wilder = require('wilder')
-- wilder.setup({ modes = { ":", "/", "?" } })
--
--     -- wilder.setup({ modes = { ":", "/", "?" } })
--
--     -- Define custom highlight groups
--
--     wilder.set_option(
--         "renderer",
--         wilder.popupmenu_renderer(wilder.popupmenu_border_theme({
--             min_width = "20%", -- minimum height of the popupmenu, can also be a number
--             max_height = "15%", -- to set a fixed height, set max_height to the same value
--             reverse = 0, -- if 1, shows the candidates from bottom to top
--             highlighter = {
--                 wilder.basic_highlighter(), -- Requires luarocks install pcre2
--             --     wilder.lua_pcre2_highlighter(), -- Requires luarocks install pcre2
--             --     wilder.lua_fzy_highlighter(), -- Requires fzy-lua-native
--             },
--             highlights = {
--                 default = wilder.make_hl(
--                     "WilderPopupMenu",
--                     "Pmenu",
--                     { { a = 1 }, { a = 1 }, { background = "#1E212B" } } -- Adjust background color
--                 ),
--                 accent = wilder.make_hl(
--                     "WilderAccent",
--                     "Pmenu",
--                     { { a = 1 }, { a = 1 }, { foreground = "#58FFD6", background = "#1e1e2e" } }
--                 ),
--             },
--             -- 'single', 'double', 'rounded' or 'solid'
--             -- can also be a list of 8 characters, see :h wilder#popupmenu_border_theme() for more details
--             border = "single",
--         }))
--     )

require("mini.comment").setup({
    mappings = {
        -- Toggle comment (like `gcip` - comment inner paragraph) for both
        -- Normal and Visual modes
        -- comment = 'gc',
        comment = '<C-c>',

        -- Toggle comment on current line
        -- comment_line = 'gcc',
        comment_line = '<C-c>',

        -- Toggle comment on visual selection
        comment_visual = '<C-c>',
    },

})
require("mini.trailspace").setup({
    only_in_normal_buffers = true,
})
vim.keymap.set("n", "<C-w>", function() MiniTrailspace.trim() end, { desc = "Erase Whitespace" })

require("typst-preview").setup({
    invert_colors = '{"rest": "always","image": "never"}',

    -- für "kiosk" ähnlicher modus
    -- open_cmd = "firefox %s -P typst-preview --class typst-preview --new-window",
    -- profile für "typst-preview" anlegen unter `about:profiles`
    -- in ~/.mozilla/firefox/lvqpvjav.typst-preview/chrome/userChrome.css resp. ~/.mozilla/firefox/<profilname>/chrome/userChrome.css
    -- /* Hauptleisten ausblenden */
    -- #nav-bar,          /* Adress- und Navigationsleiste */
    -- #TabsToolbar,      /* Tab-Leiste */
    -- #PersonalToolbar   /* Lesezeichen-Leiste */
    -- {
    --   visibility: collapse !important;
    -- }
    --
    -- sowie unter `about:config`: toolkit.legacyUserProfileCustomizations.stylesheets auf true
})

-- require("markdown-preview").setup({
--     cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
--     -- build = "cd app && yarn install",
--     init = function()
--         vim.g.mkdp_filetypes = { "markdown" }
--     end,
--     ft = { "markdown" },
--
-- })

vim.lsp.config('lua_ls', {
    settings = {
        Lua = {
            runtime = {
                version = 'LuaJIT',
            },
            diagnostics = {
                globals = {
                    'vim',
                    'require'
                },
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
            },
            telemetry = {
                enable = false,
            },
        },
    },
})


-- Disable New Line Comment
vim.api.nvim_create_autocmd("FileType", {
    pattern = "*",
    callback = function()
        -- Entfernt 'r' (Enter) und 'o' (o/O) sowie 'c' (Auto-Zeilenumbruch)
        -- vim.opt_local.formatoptions:remove({ 'c', 'r', 'o' })
        vim.opt.formatoptions:remove { "c", "r", "o" }
    end,
    desc = "Disable New Line Comment",
})

-- Set the diagnostic config with all icons
local signs = {
    [vim.diagnostic.severity.ERROR] = " ",
    [vim.diagnostic.severity.WARN]  = " ",
    [vim.diagnostic.severity.HINT]  = "󰠠 ",
    [vim.diagnostic.severity.INFO]  = " ",
}
vim.diagnostic.config({
    signs = {
        text = signs -- Enable signs in the gutter
    },
    virtual_text = true,  -- Specify Enable virtual text for diagnostics
    underline = true,     -- Specify Underline diagnostics
    update_in_insert = false,  -- Keep diagnostics active in insert mode
})
