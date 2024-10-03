TERMMY = {}

TERMMY.toggle = function(split)
    if vim.api.nvim_get_current_buf() == TERMMY.buf then
        vim.api.nvim_win_close(TERMMY.win, true)
        return
    end

    local is_new = TERMMY.buf == nil or not vim.api.nvim_buf_is_valid(TERMMY.buf)
    local cursor_pos = vim.fn.screenpos(0, vim.fn.line('.'), vim.fn.col('.'))

    if not split then
        local win_config = {
            relative = 'editor',
            row = cursor_pos.row + 0,
            col = cursor_pos.col - 1,
            width = 60,
            height = 10,
            style = 'minimal',
            border = 'single',
        }

        if is_new then
            TERMMY.buf = vim.api.nvim_create_buf(false, true)
        end

        TERMMY.win = vim.api.nvim_open_win(TERMMY.buf, true, win_config)
    end

    if split then
        vim.cmd("split")
        TERMMY.win = vim.api.nvim_get_current_win()
    end

    if is_new then
        vim.cmd("term")
    else
        vim.api.nvim_win_set_buf(TERMMY.win, TERMMY.buf)
    end

    TERMMY.buf = vim.api.nvim_get_current_buf()
end

return TERMMY
