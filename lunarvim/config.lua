-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Example configs: https://github.com/LunarVim/starter.lvim
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny
lvim.plugins = {
  {
    "ggandor/leap.nvim",
    name = "leap",
    config = function()
      require("leap").add_default_mappings()
    end,
  },
  {
    "pwntester/octo.nvim",
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require("octo").setup()
    end,
  },
  {
    'github/copilot.vim',
    lazy = false
  },
  {
    'akinsho/toggleterm.nvim',
    version = "*",
    config = true
  },
  {
    'rcarriga/nvim-dap-ui',
    dependencies = {
      'mfussenegger/nvim-dap'
    },
    lazy = false
  },
}

lvim.keys.normal_mode[";;"] = "A;<Esc>"

vim.api.nvim_create_user_command('MyIssues', 'Octo issue list techlift-tech/PokerManagerIssues', {})

local dap = require('dap')

dap.adapters.coreclr = {
  type = 'executable',
  command = '/usr/bin/netcoredbg/netcoredbg',
  args = { '--interpreter=vscode' }
}

dap.configurations.cs = {
  {
    type = "coreclr",
    name = "launch - netcoredbg",
    request = "launch",
    program = function()
      return vim.fn.input('Path to dll', vim.fn.getcwd() .. '/bin/Debug/', 'file')
    end,
  },
}

-- dap (Debug Adapter Protocol) key mappings
lvim.keys.normal_mode["<F5>"] = "<Cmd>lua require'dap'.continue()<CR>"
lvim.keys.normal_mode["<F10>"] = "<Cmd>lua require'dap'.step_over()<CR>"
lvim.keys.normal_mode["<F11>"] = "<Cmd>lua require'dap'.step_into()<CR>"
lvim.keys.normal_mode["<F12>"] = "<Cmd>lua require'dap'.step_out()<CR>"
lvim.keys.normal_mode["<Leader>b"] = "<Cmd>lua require'dap'.toggle_breakpoint()<CR>"
lvim.keys.normal_mode["<Leader>B"] = "<Cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>"
lvim.keys.normal_mode["<Leader>lp"] =
"<Cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>"
lvim.keys.normal_mode["<Leader>dr"] = "<Cmd>lua require'dap'.repl.open()<CR>"
lvim.keys.normal_mode["<Leader>dl"] = "<Cmd>lua require'dap'.run_last()<CR>"

-- Setting up ToggleTerm to float
-- lvim.builtin.terminal.direction = "float"
-- Ensure this table is defined before setting the sources
lvim.builtin.cmp = lvim.builtin.cmp or {}

-- Set up completion sources
lvim.builtin.cmp.sources = {
  { name = "nvim_lsp" },
  { name = "nvim_lua" },
  { name = "path" },
  { name = "luasnip" },
  { name = "calc" },
  -- { name = "buffer" }, -- comment this line out to disable buffer source
}

-- Optionally, you might want to ensure other settings are kept intact
lvim.builtin.cmp.completion = {
  completeopt = "menu,menuone,noinsert",
}

