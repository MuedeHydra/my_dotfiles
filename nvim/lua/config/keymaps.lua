
vim.g.mapleader = " "

-- NO MAKRO!
vim.keymap.set("n", "q", "")

-- NvimTree
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")
vim.keymap.set("n", "<leader>f", ":NvimTreeFocus<CR>")

-- go back to folder
vim.keymap.set("n", "<leader>v", vim.cmd.Ex)

-- markdown rendering
vim.keymap.set("n", "<leader>m", ":RenderMarkdown toggle<CR>")
-- markdown rendering in browser
vim.keymap.set("n", "<leader>n", ":MarkdownPreview<CR>")
-- run code block
vim.keymap.set("n", "<leader>b", ":EvalBlock<CR> :sleep 200m <CR> <C-w>j") -- 200m = 200 milisecund

-- unselect search
vim.keymap.set("n", "<CS-Space>", ":nohlsearch<CR>")

vim.keymap.set("n", "<CS-Space>", ":nohlsearch<CR>")

-- copy to clipboard
vim.keymap.set("v", "<C-y>", '"+y')

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

-- Terminal --
-- Better terminal navigation
vim.keymap.set("t", "<C-h>", "<C-\\><C-N><C-w>h")
vim.keymap.set("t", "<C-j>", "<C-\\><C-N><C-w>j")
vim.keymap.set("t", "<C-k>", "<C-\\><C-N><C-w>k")
vim.keymap.set("t", "<C-l>", "<C-\\><C-N><C-w>l")


local b = {'n', 'i'}
vim.keymap.set('n', '<F8>', ":w <bar> :term tcc -run %<CR>i")
vim.keymap.set('i', '<F8>', "<ESC> :w <bar> :term tcc -run %<CR>i")
-- run python script
vim.keymap.set(b, '<F9>', "<ESC> :w <bar> exec '!python3 '.shellescape('%')<CR>")
-- vim.keymap.set(b, '<F10>', "<ESC> :w <bar> :term python %<CR>i")
-- vim.keymap.set('i', '<F10>', "<ESC> :w <bar> :term python %<CR>i")
-- vim.keymap.set(b, '<F11>', "<ESC> :w <bar> :vsplit | term python %<CR>i")
-- vim.keymap.set("n", "F9", ":w <bar> exec '!python3'.shellescape(@%, 1)<CR>")
-- vim.keymap.set('n', '<F12>', ":w <bar> :!pdflatex %<CR><CR>")

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
    pattern = {"c"},
    group = vim.api.nvim_create_augroup("run_c", { clear = true }),
    callback = function()
        vim.api.nvim_buf_set_keymap(0, "n", '<F10>', "<ESC> :w <bar> :term tcc -run %<CR>i", { noremap = true, silent = true })
        vim.api.nvim_buf_set_keymap(0, "i", '<F10>', "<ESC> :w <bar> :term tcc -run %<CR>i", { noremap = true, silent = true })

        vim.api.nvim_buf_set_keymap(0, "n", '<F11>', "<ESC> :w <bar> :!gcc -o %:p:r.out %:p<CR> :term %:p:r.out <CR>i", { noremap = true, silent = true })
        vim.api.nvim_buf_set_keymap(0, "i", '<F11>', "<ESC> :w <bar> :!gcc -o %:p:r.out %:p<CR> :term %:p:r.out <CR>i", { noremap = true, silent = true })
    end,
})
vim.api.nvim_create_autocmd("FileType", {
    pattern = {"cpp"},
    group = vim.api.nvim_create_augroup("platformIO", { clear = true }),
    callback = function()
        vim.api.nvim_buf_set_keymap(0, "n", '<F10>', "<ESC>:w<bar>:term cd %:p:h:h && pio -f -c vim run --target upload<CR>i", { noremap = true, silent = true })
        vim.api.nvim_buf_set_keymap(0, "i", '<F10>', "<ESC>:w<bar>:term cd %:p:h:h && pio -f -c vim run --target upload<CR>i", { noremap = true, silent = true })

        vim.api.nvim_buf_set_keymap(0, "n", '<F11>', "<ESC>:w<bar>:term cd %:p:h:h && pio device monitor<CR>i", { noremap = true, silent = true })
        vim.api.nvim_buf_set_keymap(0, "i", '<F11>', "<ESC>:w<bar>:term cd %:p:h:h && pio device monitor<CR>i", { noremap = true, silent = true })
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "tex",
    group = vim.api.nvim_create_augroup("run_tex", { clear = true }),
    callback = function()
        vim.opt.wrap=true
        -- vim.opt.wrapmargin=200
        vim.api.nvim_buf_set_keymap(0, "n", '<F10>', "<ESC> :w <bar> :!pdflatex -output-directory=%:p:h %:p<CR><CR>", { noremap = true, silent = true })
        vim.api.nvim_buf_set_keymap(0, "i", '<F10>', "<ESC> :w <bar> :!pdflatex -output-directory=%:p:h %:p<CR><CR>", { noremap = true, silent = true })

        vim.api.nvim_buf_set_keymap(0, "n", '<F11>', "<ESC> :!zathura %:p:r.pdf & <CR><CR>", { noremap = true, silent = true })
    end,
})
vim.api.nvim_create_autocmd("FileType", {
    pattern = "markdown",
    group = vim.api.nvim_create_augroup("run_md_server", { clear = true }),
    callback = function()
        vim.opt.wrap=true
        -- vim.opt.wrapmargin=200
        vim.api.nvim_buf_set_keymap(0, "n", '<F10>', "<ESC> :w <bar> :EvalBlock<CR> :sleep 200m <CR> <C-w>j", { noremap = true, silent = true })
        vim.api.nvim_buf_set_keymap(0, "i", '<F10>', "<ESC> :w <bar> :EvalBlock<CR> :sleep 200m <CR> <C-w>j", { noremap = true, silent = true })

        -- vim.api.nvim_buf_set_keymap(0, "n", '<F11>', "<ESC> :w <bar> :MarkdownPreview<CR>", { noremap = true, silent = true })
        vim.api.nvim_buf_set_keymap(0, "n", '<F11>', "<ESC>:MarkdownPreview<CR>", { noremap = true, silent = true })

        -- vim.api.nvim_buf_set_keymap(0, "n", '<F12>', "<ESC> :w <bar> :RenderMarkdown toggle<CR>", { noremap = true, silent = true })
        vim.api.nvim_buf_set_keymap(0, "n", '<F12>', "<ESC>:RenderMarkdown toggle<CR>", { noremap = true, silent = true })
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
