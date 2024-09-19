return{
    "jupyter-vim/jupyter-vim",
    config = function ()
        vim.g.python3_host_prog = '/nix/store/l014xp1qxdl6gim3zc0jv3mpxhbp346s-python3-3.12.4/bin/python'
        vim.g.jupyter_vim_default_kernel = 'python3'
    end
}
