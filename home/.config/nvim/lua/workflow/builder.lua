local M = {}

local builders = {
    rust_analyzer = "cargo build"
}

local active_build_win = nil

local function get_builder_for_current_lsp()
    local clients = vim.lsp.get_clients()
    if #clients == 0 then
        vim.notify("No active LSP client", vim.log.levels.WARN)
        return nil
    end

    for _, client in ipairs(clients) do
        local match = builders[client.name]
        if match then
            return match
        end
    end

    return nil
end

local function run_command(cmd)
    local buf = vim.api.nvim_create_buf(false, true)

    vim.bo[buf].buftype = "nofile"
    vim.bo[buf].bufhidden = "wipe"
    vim.bo[buf].swapfile = false
    vim.bo[buf].modifiable = true

    local win_width = math.floor(vim.o.columns * 0.2)
    local win_height = math.floor(vim.o.lines * 0.8)

    local win = vim.api.nvim_open_win(buf, false, {
        relative = "editor",
        anchor = "NE",
        width = win_width,
        height = win_height,
        row = 1,
        col = vim.o.columns,
        style = "minimal",
        border = "none",
        focusable = false,
        zindex = 50,
    })

    vim.wo[win].winblend = 20
    vim.wo[win].winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder";

    active_build_win = win

    local baleia = require('baleia').setup({})
    baleia.automatically(buf)

    local function append(lines)
        if lines and #lines > 0 then
            if #lines == 1 and lines[1] == "" then return end

            for i, line in ipairs(lines) do
                local cleaned = line
                    :gsub("\27%[%d*K", "")
                    :gsub("\27%[%d*G", "")
                    :gsub("\r", "")
                lines[i] = cleaned
            end

            vim.api.nvim_buf_set_lines(buf, -1, -1, false, lines)

            local line_count = vim.api.nvim_buf_line_count(buf)
            vim.api.nvim_win_set_cursor(win, { line_count, 0 })
        end
    end

    vim.fn.jobstart(cmd, {
        pty = true,
        stdout_buffered = false,
        stderr_buffered = false,
        on_stdout = function(_, data) append(data) end,
        on_stderr = function(_, data) append(data) end,
        on_exit = function(_, code)
            local color = code == 0 and '\x1b[32m' or '\x1b[31m'
            local code_lines = { '\t[' .. color .. code .. '\x1b[37m]' }

            local lastline = vim.api.nvim_buf_line_count(buf)
            baleia.buf_set_lines(buf, lastline, lastline, true, code_lines)

            vim.bo[buf].modifiable = false
            vim.defer_fn(function()
                if vim.api.nvim_win_is_valid(win) then
                    vim.api.nvim_win_close(win, true)
                end
            end, 10000)
        end,
    })

    vim.keymap.set("n", "<leader>bc", function()
        if active_build_win and vim.api.nvim_win_is_valid(active_build_win) then
            vim.api.nvim_win_close(active_build_win, true)
            active_build_win = nil
        end
    end)
end

M.build = function()
    local builder = get_builder_for_current_lsp()

    if not builder then
        vim.notify("No build command found", vim.log.levels.WARN)
        return
    end

    run_command(builder)
end

return M
