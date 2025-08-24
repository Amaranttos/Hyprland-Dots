-- Import individual plugin specs
return {
  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },

  -- LSP Config
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lsp = require("lspconfig")
      lsp.pyright.setup{}  -- exemplo para Python
    end,
  },

  -- Autocompletion
  { "hrsh7th/nvim-cmp" },

  -- Alpha
  {
  "goolord/alpha-nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")

    -- Aqui você troca o ASCII
    dashboard.section.header.val = {
      [[ █████╗ ███╗   ███╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ]],
      [[██╔══██╗████╗ ████║██╔═══██╗██║   ██║██║████╗ ████║ ]],
      [[███████║██╔████╔██║██║   ██║██║   ██║██║██╔████╔██║ ]],
      [[██╔══██║██║╚██╔╝██║██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ]],
      [[██║  ██║██║ ╚═╝ ██║╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ]],
      [[╚═╝  ╚═╝╚═╝     ╚═╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ]],
    }

    -- Você também pode colocar só texto simples, ex:
    -- dashboard.section.header.val = { "Bem-vindo ao meu setup!" }

    -- Botões (opcional)
    dashboard.section.buttons.val = {
      dashboard.button("e", "  Novo arquivo", ":ene <BAR> startinsert <CR>"),
      dashboard.button("r", "  Arquivos recentes", ":Telescope oldfiles<CR>"),
      dashboard.button("f", "  Procurar arquivos", ":Telescope find_files<CR>"),
      dashboard.button("q", "  Sair", ":qa<CR>"),
    }

    -- Rodapé (opcional)
    dashboard.section.footer.val = "Camomila 🌸"

    -- Ativar
    alpha.setup(dashboard.opts)
  end,
  },

  -- OneDark
  {
  "navarasu/onedark.nvim",
  priority = 1000, -- make sure to load this before all the other start plugins
  config = function()
    require('onedark').setup {
      style = 'darker'
    }
    -- Enable theme
    require('onedark').load()
  end
 },

 -- NeoTree
{
 "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require("neo-tree").setup({
        close_if_last_window = true,
        filesystem = {
          filtered_items = {
            hide_dotfiles = false,
            hide_gitignored = true,
          },
        },
      })
    end,
  },

 -- Telescope
   {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
--                              , branch = '0.1.x',
      dependencies = { 'nvim-lua/plenary.nvim' }
    },
  -- LuaLine
  {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" }, -- ícones bonitos
  config = function()
    require("lualine").setup({
      options = {
        theme = "auto", -- detecta o tema atual
        section_separators = { left = "", right = "" },
        component_separators = { left = "", right = "" },
        icons_enabled = true,
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { "filename" },
        lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
      extensions = { "neo-tree", "lazy", "man" },
    })
  end,
},

  -- CMP
 {
  "hrsh7th/nvim-cmp", -- Autocomplete
  dependencies = {
    "L3MON4D3/LuaSnip",             -- Engine de snippets
    "saadparwaiz1/cmp_luasnip",     -- Snippets no autocomplete
    "hrsh7th/cmp-nvim-lsp",         -- Integração com LSP
    "hrsh7th/cmp-buffer",           -- Sugestões do buffer atual
    "hrsh7th/cmp-path",             -- Sugestões de caminhos
    "rafamadriz/friendly-snippets", -- Pacote de snippets prontos
  },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")

    -- Carrega snippets prontos
    require("luasnip.loaders.from_vscode").lazy_load()

    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body) -- Expande snippets
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-Space>"] = cmp.mapping.complete(), -- abre menu manualmente
        ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Enter confirma
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      }),
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "path" },
      }),
    })
  end,
  },

 -- Mason
  {
  "williamboman/mason.nvim",
  dependencies = { "williamboman/mason-lspconfig.nvim" },
  config = function()
    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = { "pylsp", "lua_ls", "ts_ls", "html", "cssls" },
    })
  end,
},

 --LSP 
  {
  "neovim/nvim-lspconfig",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
  },
  config = function()
    local lspconfig = require("lspconfig")
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    -- Atalhos básicos LSP
    local on_attach = function(_, bufnr)
      local opts = { noremap = true, silent = true, buffer = bufnr }
      local keymap = vim.keymap.set

      keymap("n", "gd", vim.lsp.buf.definition, opts)
      keymap("n", "K", vim.lsp.buf.hover, opts)
      keymap("n", "gi", vim.lsp.buf.implementation, opts)
      keymap("n", "<leader>rn", vim.lsp.buf.rename, opts)
      keymap("n", "<leader>ca", vim.lsp.buf.code_action, opts)
      keymap("n", "gr", vim.lsp.buf.references, opts)
      keymap("n", "<leader>f", function()
        vim.lsp.buf.format({ async = true })
      end, opts)
    end

    -- Python
    lspconfig.pylsp.setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    -- Lua
    lspconfig.lua_ls.setup({
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        Lua = {
          diagnostics = { globals = { "vim" } },
          workspace = { library = vim.api.nvim_get_runtime_file("", true) },
          telemetry = { enable = false },
        },
      },
    })

    -- JavaScript / TypeScript
    lspconfig.ts_ls.setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    -- HTML
    lspconfig.html.setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    -- CSS
    lspconfig.cssls.setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })
   end,
  },

 --Obsidian 
  {
  "epwalsh/obsidian.nvim",
  version = "*", -- sempre pega a versão estável mais recente
  lazy = true,
  ft = "markdown",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {
    workspaces = {
      {
        name = "personal",
        path = "~/Documentos/Cofre", -- ajuste para o caminho da sua vault
      },
    },
    completion = { nvim_cmp = true},
      picker = {
      nvim_cmp = "telescope.nvim", -- integra com nvim-cmp para autocomplete de links
    },
  },
},



}

