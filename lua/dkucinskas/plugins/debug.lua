-- debug.lua
--
-- Shows how to use the DAP plugin to debug your code.
--
-- Primarily focused on configuring the debugger for Go, but can
-- be extended to other languages as well. That's why it's called
-- kickstart.nvim and not kitchen-sink.nvim ;)

return {
  -- NOTE: Yes, you can install new plugins here!
  'mfussenegger/nvim-dap',
  -- NOTE: And you can specify dependencies as well
  dependencies = {
    -- Creates a beautiful debugger UI
    'rcarriga/nvim-dap-ui',

    -- Installs the debug adapters for you
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',

    'nvim-telescope/telescope-dap.nvim',

    -- Add your own debuggers here
    'leoluz/nvim-dap-go',
    -- '0000marcell/nvim-dap-ruby',
    'takkii/neoruby-debugger',
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'
    local whichkey = require 'which-key'

    require('mason-nvim-dap').setup {
      -- Makes a best effort to setup the various debuggers with
      -- reasonable debug configurations
      automatic_installation = true,
      automatic_setup = true,

      -- You can provide additional configuration to the handlers,
      -- see mason-nvim-dap README for more information
      handlers = {},

      -- You'll need to check that you have the required things installed
      -- online, please don't ask me how to install them :)
      ensure_installed = {
        -- Update this to ensure that you have the debuggers for the langs you want
        -- 'delve',
        'rdbg',
      },
    }

    -- local keymap = {
    --   d = {
    --     name = "Debug",
    --     a = { "<cmd>lua require'dap'.restart()<cr>", "Restart" },
    --     c = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
    --     C = { "<cmd>lua require'dap'.set_breakpoint(vim.fn.input '[Condition] > ')<cr>", "Conditional Breakpoint" },
    --     d = { "<cmd>lua require'dap'.focus_frame()<cr>", "Focus current frame" },
    --     i = { "<cmd>lua require'dap'.step_into()<cr>", "Step Into" },
    --     o = { "<cmd>lua require'dap'.step_over()<cr>", "Step Over" },
    --     j = { "<cmd>lua require'dap'.up()<cr>", "Go up the stack frame" },
    --     k = { "<cmd>lua require'dap'.down()<cr>", "Go down the stack frame" },
    --     f = { "<cmd>Telescope dap frames<cr>", "Telescope frames" },
    --     b = { "<cmd>Telescope dap list_breakpoints<cr>", "Telescope list breakpoints" },
    --     r = {
    --       "<cmd>lua  require('dapui').float_element('repl', { width = 100, height = 20, enter = true, position = 'center' })<cr>",
    --       "Toggle Repl" },
    --     w = {
    --       "<cmd>lua  require('dapui').float_element('watches', { width = 100, height = 20, enter = true, position = 'bottom' })<cr>",
    --       "Toggle Watch" },
    --     v = { "<cmd>lua require'telescope'.extensions.dap.variables{}<cr>", "Toggle Repl" },
    --     s = { "<cmd>lua require'dap'.continue()<cr>", "Start" },
    --     t = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Toggle Breakpoint" },
    --     x = { "<cmd>lua require'dap'.terminate()<cr>", "Terminate" },
    --     X = { "<cmd>lua require'dap'.clear_breakpoints()<cr>", "Clear breakpoints" },
    --     u = { "<cmd>lua require'dap'.step_out()<cr>", "Step Out" },
    --     h = { "<cmd>lua require'dap.ui.widgets'.hover()<cr>", "Hover Variables" },
    --     U = { "<cmd>lua require'dapui'.toggle()<cr>", "Toggle UI" },
    --     e = { "<cmd>lua require'dapui'.eval()<cr>", "Evaluate" },
    --   },
    -- }
    -- whichkey.register(keymap, {
    --   mode = "n",
    --   prefix = "<leader>",
    --   buffer = nil,
    --   silent = true,
    --   noremap = true,
    --   nowait = false,
    -- })
    --
    -- local keymap_v = {
    --   name = "Debug",
    --   e = { "<cmd>lua require'dapui'.eval()<cr>", "Evaluate" },
    -- }
    -- whichkey.register(keymap_v, {
    --   mode = "v",
    --   prefix = "<leader>",
    --   buffer = nil,
    --   silent = true,
    --   noremap = true,
    --   nowait = false,
    -- })

    -- debugging keymaps, feel free to change to your liking!
    vim.keymap.set('n', '<F5>', dap.continue)
    vim.keymap.set('n', '<F7>', dap.step_into)
    vim.keymap.set('n', '<F8>', dap.step_over)
    vim.keymap.set('n', '<F9>', dap.step_out)
    vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint)
    vim.keymap.set('n', '<leader>B', function()
      dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
    end)

    -- Dap UI setup
    -- For more information, see |:help nvim-dap-ui|
    dapui.setup {
      -- Set icons to characters that are more likely to work in every terminal.
      --    Feel free to remove or use ones that you like more! :)
      --    Don't feel like these are good choices.
      icons = {
        expanded = '▾',
        collapsed = '▸',
        current_frame = '*'
      },
      controls = {
        icons = {
          pause = '',
          play = '',
          step_into = '',
          step_over = '',
          step_out = '',
          step_back = '',
          run_last = '',
          terminate = '',
        },
      },
    }

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    -- Install golang specific config
    -- require('dap-go').setup()
    -- require('dap-ruby').setup()
    require('neoruby-debugger').setup()
  end,
}
