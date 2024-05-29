# Neovim-Configuration

This file is to describe how my Neovim is configurated. First off, I used [NvChad](https://nvchad.com/) to
"bootstrap" my Neovim. NvChad has many [inbuilt plugins](https://nvchad.com/docs/features/) that I do not
have to configure manually, and it utilizes lazy loading, so the plugins are loaded when needed.

## Plugins

NvChad has many inbuilt plugins, but you can add new plugins or customize NvChad's inbuilt plugins.
The plugins are located in `~/.config/nvim/lua/plugins/init.lua`.

[`conform.nvim`](https://github.com/stevearc/conform.nvim)

```lua
{
  "stevearc/conform.nvim",
  event = "BufWritePre",
  config = function()
    require "configs.conform"
  end,
}
```

This is one of the inbuilt plugins that NvChad uses, and it is initially commented out. I uncommented out because
I need to add different formatters for different file types. Additionally, `event = "BufWritePre` allows me to
format on save. The configuration file for `conform.nvim` is found in `~/.config/nvim/lua/configs/conform.lua`.

```lua
local options = {
  formatters_by_ft = {
    css = { "prettierd" },
    html = { "prettierd" },
    javascript = { "prettierd" },
    typescript = { "prettierd" },
    javascriptreact = { "prettierd" },
    typescriptreact = { "prettierd" },
    json = { "prettierd" },
    typst = { "typstfmt" },
    terraform = { "tflint" }
  },

  format_on_save = { -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_fallback = true,
  },
}
```

This is the current configuration for `conform.nvim`. Initially, I had `lua = { "stylua" }`, but something happend with
`stylua` to where it does not format `lua` files anymore.

[`nvim-lspconfig`](https://github.com/neovim/nvim-lspconfig)

```lua
{
  "neovim/nvim-lspconfig",
  config = function()
    require("nvchad.configs.lspconfig").defaults()
    require "configs.lspconfig"
  end,
}
```

This is also one of the inbuilt plugins that NvChad uses, and it is initially commented out. I uncommented out because
I need to add different LSPs for different languages.

```lua
local servers = { "html", "cssls", "tailwindcss", "eslint", "jsonls", "typst_lsp", "terraformls" }

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
  }
end
```

These are the different language server protocols that are setup with default configs. There are other language server
protocols that has to be configured with custom configurations.

```lua
lspconfig.cssls.setup {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
  settings = {
    css = {
      validate = true,
      lint = {
        unknownAtRules = "ignore"
      }
    },
  }
}
```

This is the configuration for the `CSS` language server protocol. Since I am using TailwindCSS, `CSS` gives the warning
`Unknown at rule @tailwind`. This custom configuration ignores the `TailwindCSS` rules, so no warnings are present
in the `CSS` files. See this [Reddit](https://www.reddit.com/r/lunarvim/comments/w50jfk/comment/jcl262v/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button) post.

```lua
lspconfig.tsserver.setup {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
  commands = {
    OrganizeImports = {
      function()
        local params = {
          command = "_typescript.organizeImports",
          arguments = { vim.api.nvim_buf_get_name(0) },
          title = ""
        }
        vim.lsp.buf.execute_command(params)
      end,
      description = "Organize Imports"
    }
  }
}
```

This is the configuration for the `TypeScript` language server protocol. This custom configuration creates a custom
command called `OrganizeImports` that organizes the imports for `TypeScript` (and probably `JavaScript`) files. To
enter the command, type `:OrganizeImports`. See this [Reddit](https://www.reddit.com/r/neovim/comments/lwz8l7/comment/gpkueno/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button) post.

[`mason.nvim`](https://github.com/williamboman/mason.nvim)

```lua
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
      "prettierd",
      "tailwindcss-language-server",
      "terraform-ls",
      "tflint",
      "typescript-language-server",
      "typst-lsp",
      "typstfmt"
    },
  },
}
```

This is also one of the inbuilt plugins that NvChad uses, and it is initially commented out. I uncommented out because
I want to ensure that some `LSP`, `DAP`, `Linter`, and `Formatter` are installed. You can use the command `MasonInstallAll`
to install all `LSP`, `DAP`, `Linter`, and `Formatter` under `ensure_installed` are installed.

[`nvim-treesitter`](https://github.com/nvim-treesitter/nvim-treesitter)

```lua
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
}
```

This is also one of the inbuilt plugins that NvChad uses, and it is initially commented out. I uncommented out because
I want to ensure that some languages are installed.

[`nvim-jdtls`](https://github.com/mfussenegger/nvim-jdtls)

```lua
"mfussenegger/nvim-jdtls"
```

This is one of the custom plugins for Java `LSP`. In order to make sure that the `LSP` works when opening a `Java`
file, `nvim-jdtls` requires a configuration file found in `~/.config/nvim/ftplugin/java.lua`.

```lua
local config = {
  cmd = {
    "/Users/darren/.local/share/nvim/mason/bin/jdtls",
    "--jvm-arg=-javaagent:/Users/darren/.local/share/nvim/mason/share/jdtls/lombok.jar",
  },
  root_dir = vim.fs.dirname(vim.fs.find({ "gradlew", ".git", "mvnw" }, { upward = true })[1]),
}
require("jdtls").start_or_attach(config)
```

The one customization to `cmd` is the `--jvm-arg=-javaagent:/Users/darren/.local/share/nvim/mason/share/jdtls/lombok.jar`,
which allows the `LSP` to detect `Lombok`. For example, let's say a `Person` class has a `name` attribute with the `@Getter`
annotation. In another class, if we were to call `new Person().getName()`, the method `getName` will not be detected without
the customization to `cmd`. Therefore, the customization to `cmd` is needed in order to detect `Lombok`.
See this [Reddit](https://www.reddit.com/r/neovim/comments/124t2u6/comment/jwrid3y/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button)
post.

## Keyboard Shortcuts, Mappings, and Commands

The `<leader>` key is " " (Space). To see some of the default mappings that NvChad provides, you can look at the `NvChad Cheat Sheet`
by pressing `<leader>ch`.

Here are some other helpful keyboard shortcuts and commands.

- `K`: When hovering over a variable or a function, the `TypeScript LSP` will display a pop-up window, stating the type
  definition of the variable or function as well as the `JSDoc`.
- `vim.print({})`: This command prints out the contents of a table in a formatted style.

Here are some of my custom key mappings for my `LSP` configuration.

```lua
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function()
    local buf = vim.lsp.buf
    map("n", "<leader>lr", buf.references, { desc = "lists all references" })
    map("n", "<leader>li", buf.implementation, { desc = "lists all implementations" })
    map("n", "<leader>lc", buf.code_action, { desc = "list code actions" })
    map("n", "<leader>ls", buf.document_symbol, { desc = "list all symbols" })
    map("n", "<leader>ln", buf.rename, { desc = "rename" })
    map("n", "<leader>lh", buf.signature_help, { desc = "display method signature information" })
  end
})
```
