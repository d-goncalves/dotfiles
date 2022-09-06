local M = {}

local function configure()
    require("dap")

    local dap_breakpoint = {
        error = {
            text = "🔴",
            texthl = "DiffDelete",
            linehl = "",
            numhl = "DiffDelete",
        },
        rejected = {
            text = "",
            texthl = "LspDiagnosticsSignHint",
            linehl = "",
            numhl = "",
        },
        stopped = {
            text = "➔",
            texthl = "LspDiagnosticsSignInformation",
            linehl = "DiagnosticUnderlineInfo",
            numhl = "LspDiagnosticsSignInformation",
        },
    }

    vim.fn.sign_define("DapBreakpoint", dap_breakpoint.error)
    vim.fn.sign_define("DapStopped", dap_breakpoint.stopped)
    vim.fn.sign_define("DapBreakpointRejected", dap_breakpoint.rejected)
end

local function configure_exts()
    require("nvim-dap-virtual-text").setup({
        commented = true,
    })

    local dap, dapui = require("dap"), require("dapui")
    dapui.setup({}) -- use default
    dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
    end
end

local function configure_debuggers()
    require("config.dap.language.lua").setup()
    require("config.dap.language.python").setup()
    require("config.dap.language.cpp").setup()
end

function M.setup()
    configure() -- Configuration
    configure_exts() -- Extensions
    configure_debuggers() -- Debugger
    require("config.dap.keymaps").setup()
end

return M
