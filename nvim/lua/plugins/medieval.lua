return {
    "gpanders/vim-medieval",
	-- lazy = false,
    ft = "markdown",
    config = function()
        -- vim.g.medieval_langs = 'python=python3'
        vim.g.medieval_langs = {'python=python3', "py=python3", 'sh', 'bash', 'c=tcc -run', 'console=bash'}
    end,
}
