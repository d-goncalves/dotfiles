local bufnr = 8

local attach_to_buffer = function(output_bufnr,pattern, command)
    vim.api.nvim_create_autocmd("BufWritePost", {
        group = vim.api.nvim_create_augroup("SaveFileToCompileAndExecute", { clear = true }),
        pattern = "test.cpp",
        callback = function()
            local append_data = function(_, data)
                if data then
                    vim.api.nvim_buf_set_lines(bufnr, -1, -1, false, data)
                end
            end
            vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { "Testing Compilation" })
            vim.fn.jobstart(command, {
                stdout_buffered = true,
                on_stdout = append_data,
                on_stderr = append_data,
            })
            vim.api.nvim_buf_set_lines(bufnr, -1, -1, false, { "Running:" })
            vim.fn.jobstart({ "./a.out" }, {
                stdout_buffered = true,
                on_stdout = append_data,
            })
        end,
    })
end

-- attach_to_buffer(8,"*.cpp", {"g++", "test.cpp"})


vim.api.nvim_create_user_command("AutoRun", function()
    attach_to_buffer(8,"*.cpp", {"g++", "test.cpp"})
end, {})
