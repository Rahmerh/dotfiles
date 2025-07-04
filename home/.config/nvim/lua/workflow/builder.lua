local M = {}

local project_types = {
    rust = {
        markers = { "Cargo.toml" },
        build = "cargo build"
    },
}

local active_build_win = nil

local function get_build_cmd_for_current_project()
    local cwd = vim.fn.getcwd()

    for _, meta in pairs(project_types) do
        local has_marker = false

        for _, marker in ipairs(meta.markers) do
            if #vim.fn.glob(cwd .. "/" .. marker, false, true) > 0 then
                has_marker = true
                break
            end
        end

        if not has_marker then
            goto continue
        end

        if type(meta.build) == "function" then
            return meta.build(cwd)
        else
            return meta.build
        end

        ::continue::
    end
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
            local code_lines = { '\tProcess exited with code ' .. color .. code .. '\x1b[37m' }

            local lastline = vim.api.nvim_buf_line_count(buf)
            baleia.buf_set_lines(buf, lastline, lastline, true, code_lines)

            local total_time = 10
            local namespace = vim.api.nvim_create_namespace("builder_timer")
            local current_win_height = vim.api.nvim_win_get_height(win)
            local buf_line_count = vim.api.nvim_buf_line_count(buf)

            if buf_line_count < current_win_height then
                local padding = {}
                for _ = 1, current_win_height - buf_line_count do
                    table.insert(padding, "")
                end
                vim.api.nvim_buf_set_lines(buf, -1, -1, false, padding)
            end

            local timer = vim.loop.new_timer()
            timer:start(0, 1000, vim.schedule_wrap(function()
                if not vim.api.nvim_buf_is_valid(buf) or not vim.api.nvim_win_is_valid(win) then
                    timer:stop()
                    return
                end

                if total_time < 0 then
                    timer:stop()
                    vim.api.nvim_win_close(win, true)
                    return
                end

                local msg = total_time .. "s"
                local line = current_win_height - 1

                vim.api.nvim_buf_clear_namespace(buf, namespace, line, line + 1)
                vim.api.nvim_buf_set_extmark(buf, namespace, line, 0, {
                    virt_text = { { msg, "Comment" } },
                    virt_text_pos = "right_align",
                })

                total_time = total_time - 1
            end))
        end

    })
end

M.build = function()
    local build_cmd = get_build_cmd_for_current_project()

    if not build_cmd then
        vim.notify("No build command found", vim.log.levels.WARN)
        return
    end

    run_command(build_cmd)
end

M.close_build_log = function()
    if active_build_win and vim.api.nvim_win_is_valid(active_build_win) then
        vim.api.nvim_win_close(active_build_win, true)
        active_build_win = nil
    end
end

return M
