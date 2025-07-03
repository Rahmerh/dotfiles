local M = {}

local active_win = nil
local active_terminals = {}

local function close_terminal(cmd)
    local active_terminal = active_terminals[cmd]
    if not active_terminal then
        return
    end

    if active_terminal.float_win and vim.api.nvim_win_is_valid(active_terminal.float_win) then
        vim.api.nvim_win_close(active_terminal.float_win, true)
    end

    if active_terminal.float_buf and vim.api.nvim_buf_is_valid(active_terminal.float_buf) then
        vim.api.nvim_buf_delete(active_terminal.float_buf, { force = true })
    end

    active_terminals[cmd] = nil
end

function M.toggle(cmd)
    if active_win and vim.api.nvim_win_is_valid(active_win) then
        vim.api.nvim_win_hide(active_win)
        active_win = nil
        return
    end

    local width = math.floor(vim.o.columns * 0.8)
    local height = math.floor(vim.o.lines * 0.8)
    local row = math.floor((vim.o.lines - height) / 2)
    local col = math.floor((vim.o.columns - width) / 2)

    local term_opts = {
        relative = "editor",
        width = width,
        height = height,
        row = row,
        col = col,
        style = "minimal",
        border = "none",
    }

    local command = cmd or vim.o.shell
    local active_terminal = active_terminals[command]
    if active_terminal then
        active_win = vim.api.nvim_open_win(active_terminal.float_buf, true, term_opts)

        vim.cmd("startinsert")
        return
    end

    local float_buf = vim.api.nvim_create_buf(false, true)
    local float_win = vim.api.nvim_open_win(float_buf, true, term_opts)

    vim.wo[float_win].winblend = 20
    vim.wo[float_win].winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder";

    local float_job_id = vim.fn.jobstart(command, {
        term = true,
        pty = true,
        on_exit = function()
            close_terminal(command)
        end,
    })

    active_terminals[command] = {
        float_buf = float_buf,
        float_win = float_win,
        float_job_id = float_job_id
    }

    vim.keymap.set("t", "<C-q>", function()
        close_terminal(command)
    end, { buffer = float_buf, nowait = true })

    vim.cmd("startinsert")

    active_win = float_win
end

function M.print_active_terminals()
    local json_str = vim.fn.json_encode(active_terminals)
    print(json_str)
end

return M
