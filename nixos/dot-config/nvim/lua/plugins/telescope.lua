return {
  'nvim-telescope/telescope.nvim',
  dependencies = { 
    'nvim-lua/plenary.nvim',
    -- Fuzzy Finder Algorithm which requires local dependencies to be built.
    -- Only load if `make` is available. Make sure you have the system
    -- dependencies installed.
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      -- NOTE: If you are having trouble with this installation,
      --       refer to the README for telescope-fzf-native for more instructions.
      build = 'make',
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
    'nvim-telescope/telescope-ui-select.nvim',
  },
  config = function()
    local telescope = require('telescope')
    local actions = require('telescope.actions')

    telescope.setup({
      defaults = {
        layout_strategy = "horizontal",
        layout_config = {
          horizontal = {
            prompt_position = "top",
            preview_width = 0.55,
            results_width = 0.8,
          },
          vertical = {
            mirror = false,
          },
          width = 0.87,
          height = 0.80,
          preview_cutoff = 120,
        },
        sorting_strategy = "ascending",
        winblend = 0,
        file_ignore_patterns = {
          "node_modules",
          ".git/",
          "dist/",
          "build/",
          "target/",
        },
        vimgrep_arguments = {
          'rg',
          '--color=never',
          '--no-heading',
          '--with-filename',
          '--line-number',
          '--column',
          '--smart-case',
          '--hidden',
        },
      },
      pickers = {
        find_files = {
          hidden = true,
          find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
        },
        live_grep = {
          additional_args = function(opts)
            return {"--hidden"}
          end
        },
        buffers = {
          theme = "dropdown",
          previewer = false,
          initial_mode = "normal",
          mappings = {
            i = {
              ["<C-d>"] = actions.delete_buffer,
            },
            n = {
              ["dd"] = actions.delete_buffer,
            },
          },
        },
        colorscheme = {
          enable_preview = true,
        },
      },
      extensions = {
        ["ui-select"] = {
          require("telescope.themes").get_dropdown {
            -- even more opts
          }
        }
      }})

    require("telescope").load_extension("ui-select")
  end,
  keys = {
    -- File pickers
    { "<leader>ff", function() require('telescope.builtin').find_files() end, desc = "Find Files" },
    { "<leader>ff", function()
        local text = vim.fn.getregion(vim.fn.getpos('v'), vim.fn.getpos('.'), { type = vim.fn.mode() })
        require('telescope.builtin').find_files({ default_text = table.concat(text, ' ') })
      end, mode = "v", desc = "Find Files with Selection" },
    { "<leader>fg", function() require('telescope.builtin').live_grep() end, desc = "Live Grep" },
    { "<leader>fg", function()
        local text = vim.fn.getregion(vim.fn.getpos('v'), vim.fn.getpos('.'), { type = vim.fn.mode() })
        require('telescope.builtin').live_grep({ default_text = table.concat(text, ' ') })
      end, mode = "v", desc = "Live Grep with Selection" },
    { "<leader>fb", function() require('telescope.builtin').buffers() end, desc = "Find Buffers" },
    { "<leader>fh", function() require('telescope.builtin').help_tags() end, desc = "Help Tags" },
    { "<leader>fr", function() require('telescope.builtin').oldfiles() end, desc = "Recent Files" },
    { "<leader>fw", function() require('telescope.builtin').grep_string() end, desc = "Find Word under Cursor" },
    { "<leader>rs", function() require('telescope.builtin').resume() end, desc = "Resume search" },

    -- Git pickers
    { "<leader>gf", function() require('telescope.builtin').git_files() end, desc = "Git Files" },
    { "<leader>gc", function() require('telescope.builtin').git_commits() end, desc = "Git Commits" },
    { "<leader>gb", function() require('telescope.builtin').git_branches() end, desc = "Git Branches" },
    { "<leader>gs", function() require('telescope.builtin').git_status() end, desc = "Git Status" },

    -- Other useful pickers
    { "<leader>fc", function() require('telescope.builtin').colorscheme() end, desc = "Colorscheme" },
    { "<leader>fk", function() require('telescope.builtin').keymaps() end, desc = "Keymaps" },
    { "<leader>fm", function() require('telescope.builtin').marks() end, desc = "Marks" },
    { "<leader>fj", function() require('telescope.builtin').jumplist() end, desc = "Jumplist" },
    { "<leader>fd", function() require('telescope.builtin').diagnostics() end, desc = "Diagnostics" },

    -- LSP pickers (if LSP is active)
    { "<leader>lr", function() require('telescope.builtin').lsp_references() end, desc = "LSP References" },
    { "<leader>ld", function() require('telescope.builtin').lsp_definitions() end, desc = "LSP Definitions" },
    { "<leader>li", function() require('telescope.builtin').lsp_implementations() end, desc = "LSP Implementations" },
    { "<leader>ls", function() require('telescope.builtin').lsp_document_symbols() end, desc = "Document Symbols" },
    { "<leader>lw", function() require('telescope.builtin').lsp_workspace_symbols() end, desc = "Workspace Symbols" },
  },
}

