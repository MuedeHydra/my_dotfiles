local opts = { noremap = true, silent = true }

vim.g.mapleader = " "

-- NO MAKRO!
vim.keymap.set("n", "q", "")
vim.keymap.set("n", "Q", "")

-- unselect search
vim.keymap.set("n", "<CS-Space>", ":nohlsearch<CR>")
vim.keymap.set("n", "<Esc>", ":nohlsearch<CR>")

-- search (curser bleibt in der mitte)
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- verliert die markierung nicht
vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)

-- copy to clipboard
vim.keymap.set("v", "<C-y>", '"+y')

-- the how it be paste
vim.keymap.set("x", "p", [["_dP]])

-- remember yanked
vim.keymap.set("v", "p", '"_dp', opts)

-- leader d delete wont remember as yanked/clipboard when delete pasting
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- prevent x delete from registering when next paste
vim.keymap.set("n", "x", '"_x', opts)

-- Replace the word cursor is on globally
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
    { desc = "Replace word cursor is on globally" })

-- Hightlight yanking
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
    callback = function()
        vim.hl.on_yank()
    end,
})

-- tab stuff
vim.keymap.set("n", "<leader>to", "<cmd>tabnew<CR>")   --open new tab
vim.keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>") --close current tab
vim.keymap.set("n", "<leader>tn", "<cmd>tabn<CR>")     --go to next
vim.keymap.set("n", "<leader>tp", "<cmd>tabp<CR>")     --go to pre
vim.keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>") --open current tab in new tab

-- Tabs mit Ctrl-Nummer wechseln
vim.api.nvim_set_keymap('n', '<C-1>', ':tabnext 1<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-2>', ':tabnext 2<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-3>', ':tabnext 3<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-4>', ':tabnext 4<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-5>', ':tabnext 5<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-6>', ':tabnext 6<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-7>', ':tabnext 7<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-8>', ':tabnext 8<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-9>', ':tabnext 9<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-0>', ':tablast<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-q>', ':tabclose<CR>', { noremap = true, silent = true })
vim.keymap.set("n", "<C-n>", ":tabnew ") --open current tab in new tab


-- move line up and down
vim.keymap.set("v", "<C-j>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<C-k>", ":m '<-2<CR>gv=gv")

-- Better window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

-- Resize with arrows
vim.keymap.set("n", "<C-Up>", ":resize +2<CR>")
vim.keymap.set("n", "<C-Down>", ":resize -2<CR>")
vim.keymap.set("n", "<C-Left>", ":vertical resize +2<CR>")
vim.keymap.set("n", "<C-Right>", ":vertical resize -2<CR>")
vim.keymap.set("n", "<C-e>", "<C-w>=")

-- Terminal --
-- Better terminal navigation
vim.keymap.set("t", "<C-h>", "<C-\\><C-N><C-w>h")
vim.keymap.set("t", "<C-j>", "<C-\\><C-N><C-w>j")
vim.keymap.set("t", "<C-k>", "<C-\\><C-N><C-w>k")
vim.keymap.set("t", "<C-l>", "<C-\\><C-N><C-w>l")


-- NvimTree
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")
vim.keymap.set("n", "<leader>f", ":NvimTreeFocus<CR>")

-- go back to folder
vim.keymap.set("n", "<leader>v", vim.cmd.Ex)


-- :!echo %:p:r → zum testen
-- print pattern mit: :verbose set filetype?
-- https://vimdoc.sourceforge.net/htmldoc/cmdline.html#filename-modifiers

vim.api.nvim_create_autocmd("FileType", {
    pattern = "python",
    group = vim.api.nvim_create_augroup("run_python", { clear = true }),
    callback = function()
        -- vim.api.nvim_buf_set_keymap(0, 'i', '<space><space>', '.<space>', { noremap = true, silent = true })
        -- vim.api.nvim_buf_set_keymap(0, "n", '<F10>', "<ESC> :w <bar> :term python %<CR>i", { noremap = true, silent = true })
        vim.api.nvim_buf_set_keymap(0, "n", '<F10>', "<ESC>:w<bar>:term python %<CR>i", { noremap = true, silent = true })
        vim.api.nvim_buf_set_keymap(0, "i", '<F10>', "<ESC>:w<bar>:term python %<CR>i", { noremap = true, silent = true })
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    --pattern = {"c", "cpp"},
    pattern = { "c" },
    group = vim.api.nvim_create_augroup("run_c", { clear = true }),
    callback = function()
        vim.api.nvim_buf_set_keymap(0, "n", '<F10>', "<ESC> :w <bar> :term tcc -run %<CR>i",
            { noremap = true, silent = true })
        vim.api.nvim_buf_set_keymap(0, "i", '<F10>', "<ESC> :w <bar> :term tcc -run %<CR>i",
            { noremap = true, silent = true })

        vim.api.nvim_buf_set_keymap(0, "n", '<F11>', "<ESC> :w <bar> :!gcc -o %:p:r.out %:p<CR> :term %:p:r.out <CR>i",
            { noremap = true, silent = true })
        vim.api.nvim_buf_set_keymap(0, "i", '<F11>', "<ESC> :w <bar> :!gcc -o %:p:r.out %:p<CR> :term %:p:r.out <CR>i",
            { noremap = true, silent = true })
    end,
})
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "cpp", "arduino" },
    group = vim.api.nvim_create_augroup("platformIO", { clear = true }),
    callback = function()
        vim.api.nvim_buf_set_keymap(0, "n", '<F10>',
            "<ESC>:w<bar>:term cd %:p:h:h && pio -f -c vim run --target upload<CR>i", { noremap = true, silent = true })
        vim.api.nvim_buf_set_keymap(0, "i", '<F10>',
            "<ESC>:w<bar>:term cd %:p:h:h && pio -f -c vim run --target upload<CR>i", { noremap = true, silent = true })

        vim.api.nvim_buf_set_keymap(0, "n", '<F11>', "<ESC>:w<bar>:term cd %:p:h:h && pio device monitor<CR>i",
            { noremap = true, silent = true })
        vim.api.nvim_buf_set_keymap(0, "i", '<F11>', "<ESC>:w<bar>:term cd %:p:h:h && pio device monitor<CR>i",
            { noremap = true, silent = true })

        vim.api.nvim_buf_set_keymap(0, "n", '<F12>',
            "<ESC>:w<bar>:term cd %:p:h:h && pio -f -c vim run --target upload && pio device monitor<CR>i",
            { noremap = true, silent = true })
        vim.api.nvim_buf_set_keymap(0, "i", '<F12>',
            "<ESC>:w<bar>:term cd %:p:h:h && pio -f -c vim run --target upload && pio device monitor<CR>i",
            { noremap = true, silent = true })
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "tex",
    group = vim.api.nvim_create_augroup("run_tex", { clear = true }),
    callback = function()
        vim.opt.wrap = true
        -- vim.opt.wrapmargin=200
        vim.api.nvim_buf_set_keymap(0, "n", '<F10>', "<ESC> :w <bar> :!pdflatex -output-directory=%:p:h %:p<CR><CR>",
            { noremap = true, silent = true })
        vim.api.nvim_buf_set_keymap(0, "i", '<F10>', "<ESC> :w <bar> :!pdflatex -output-directory=%:p:h %:p<CR><CR>",
            { noremap = true, silent = true })

        vim.api.nvim_buf_set_keymap(0, "n", '<F11>', "<ESC> :!zathura %:p:r.pdf & <CR><CR>",
            { noremap = true, silent = true })
    end,
})
vim.api.nvim_create_autocmd("FileType", {
    pattern = "text",
    group = vim.api.nvim_create_augroup("txt", { clear = true }),
    callback = function()
        vim.opt.wrap = true
        -- vim.opt.wrapmargin=200
    end,
})
vim.api.nvim_create_autocmd("FileType", {
    pattern = "markdown",
    group = vim.api.nvim_create_augroup("run_md_server", { clear = true }),
    callback = function()
        vim.opt.wrap = true
        -- vim.opt.wrapmargin=200
        vim.api.nvim_buf_set_keymap(0, "n", '<F10>', "<ESC> :w <bar> :EvalBlock<CR> :sleep 200m <CR> <C-w>j",
            { noremap = true, silent = true })
        vim.api.nvim_buf_set_keymap(0, "i", '<F10>', "<ESC> :w <bar> :EvalBlock<CR> :sleep 200m <CR> <C-w>j",
            { noremap = true, silent = true })

        vim.api.nvim_buf_set_keymap(0, "n", '<F11>', "<ESC>:RenderMarkdown toggle<CR>", { noremap = true, silent = true })
        vim.api.nvim_buf_set_keymap(0, "n", '<F12>', "<ESC>:MarkdownPreview<CR>", { noremap = true, silent = true })
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "typst",
    group = vim.api.nvim_create_augroup("run_typst", { clear = true }),
    callback = function()
        vim.opt.wrap = true
        -- vim.opt.wrapmargin=200
        vim.api.nvim_buf_set_keymap(0, "n", '<F10>', "<ESC> :w <bar> :!typst compile %:p<CR><CR>",
            { noremap = true, silent = true })
        vim.api.nvim_buf_set_keymap(0, "n", '<F11>', "<ESC> :!zathura %:p:r.pdf & <CR><CR>",
            { noremap = true, silent = true })
        vim.api.nvim_buf_set_keymap(0, "n", '<F12>', "<ESC>:TypstPreview document<CR>", { noremap = true, silent = true })
        vim.api.nvim_buf_set_keymap(0, "n", '<C-F12>', "<ESC>:TypstPreview slide<CR>", { noremap = true, silent = true })
        -- vim.api.nvim_buf_set_keymap(0, "n", '<F12>', "<ESC>:TypstPreviewFollowCursorToggle<CR>", { noremap = true, silent = true })
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "sh",
    group = vim.api.nvim_create_augroup("run_sh", { clear = true }),
    callback = function()
        -- vim.api.nvim_buf_set_keymap(0, 'i', '<space><space>', '.<space>', { noremap = true, silent = true })
        -- vim.api.nvim_buf_set_keymap(0, "n", '<F10>', "<ESC> :w <bar> :term python %<CR>i", { noremap = true, silent = true })
        vim.api.nvim_buf_set_keymap(0, "n", '<F10>', "<ESC>:w<bar>:term sh %<CR>i", { noremap = true, silent = true })
        vim.api.nvim_buf_set_keymap(0, "i", '<F10>', "<ESC>:w<bar>:term sh %<CR>i", { noremap = true, silent = true })
    end,
})
