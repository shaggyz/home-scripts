-- DAP python (debugger) ------------------------------- https://github.com/mfussenegger/nvim-dap --

local dap = require('dap')

dap.adapters.python = {
    type = 'executable',
    command = os.getenv('HOME') .. '/.local/share/debugpy/bin/python3',
    args = { '-m', 'debugpy.adapter' },
    options = {
        source_filetype = 'python',
    },
}

local cwd = vim.fn.getcwd()

local function resolvePythonBinary()
    if vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
        return cwd .. '/venv/bin/python'
    elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
        return cwd .. '/.venv/bin/python'
    elseif vim.fn.executable(cwd .. '/.venv/bin/python3') == 1 then
        return cwd .. '/.venv/bin/python3'
    else
        return '/usr/bin/python3'
    end
end

dap.configurations.python = {
    {
        type = 'python',
        request = 'launch',
        name = "Launch file",
        program = "${file}",
        pythonPath = resolvePythonBinary,
    },
    -- {
    --     type = 'python',
    --     request = 'launch',
    --     name = "Launch FastAPI application",
    --     program = cwd .. "/.venv/bin/fastapi",
    --     args = {'run', cwd .. '/my_app/api/main.py'},
    --     pythonPath = resolvePythonBinary,
    -- },
    {
        type = 'python',
        request = 'launch',
        name = "Run all pytests",
        program = cwd .. "/.venv/bin/pytest",
        args = { '-s', '-v', cwd .. '/tests' },
        pythonPath = resolvePythonBinary,
    },
}

-- Automatically load launch.json DAP entries
local function loadLaunchFile()
    local launch_file = cwd .. "/launch.json"
    if vim.fn.filereadable(launch_file) == 1 then
        require('dap.ext.vscode').load_launchjs(launch_file)
        print("DAP: Loaded launch.json file")
    end
end

vim.api.nvim_create_user_command('DapLoadLaunchJSON', function()
    loadLaunchFile()
end, { nargs = '?', complete = "file" })

loadLaunchFile()

-- FIXME: Unknown character error
-- vim.fn.sign_define('DapBreakpoint', {text='', texthl='#de4948', linehl='', numhl=''})
-- vim.fn.sign_define('DapStopped', {text='', texthl='#1f717b', linehl='', numhl=''})
-- vim.fn.sign_define('DapBreakpointRejected', {text='', texthl='#ffa100', linehl='', numhl=''})
--
-- Nvim DAP UI ------------------------------------------ https://github.com/rcarriga/nvim-dap-ui --

local dapui = require("dapui")

dapui.setup()

dap.listeners.before.attach.dapui_config = function()
    dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
    dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
    dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
    dapui.close()
end
