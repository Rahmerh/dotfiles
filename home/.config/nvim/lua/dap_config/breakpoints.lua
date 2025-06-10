local has_pb, pb = pcall(require, "persistent-breakpoints")
if not has_pb then
    vim.notify("persistent-breakpoints not found", vim.log.levels.WARN)
    return
end

pb.setup {
    save_dir = vim.fn.stdpath('data') .. '/nvim_checkpoints',
    load_breakpoints_event = { "BufReadPost" },
}
