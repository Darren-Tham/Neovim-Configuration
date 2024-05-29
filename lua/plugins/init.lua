return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- format on save
    config = function()
      require "configs.conform"
    end,
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
    end,
  },

  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "css-lsp",
        "eslint-lsp",
        "eslint_d",
        "html-lsp",
        "jdtls",
        "json-lsp",
        "lua-language-server",
        "marksman",
        "prettierd",
        "tailwindcss-language-server",
        "terraform-ls",
        "tflint",
        "typescript-language-server",
        "typst-lsp",
        "typstfmt"
      },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "c",
        "css",
        "html",
        "java",
        "javascript",
        "jsdoc",
        "json",
        "lua",
        "luadoc",
        "markdown",
        "markdown_inline",
        "printf",
        "query",
        "terraform",
        "tsx",
        "typescript",
        "typst",
        "vim",
        "vimdoc",
      },
    },
  },

  "mfussenegger/nvim-jdtls",

  {
    "goolord/alpha-nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require "alpha".setup(require "alpha.themes.startify".config)
    end,
    lazy = false
  },
}
