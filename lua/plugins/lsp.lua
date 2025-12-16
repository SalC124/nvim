return {
    { "mason-org/mason.nvim", opts = {} },
    {
        "mason-org/mason-lspconfig.nvim",
        dependencies = {
            "mason-org/mason.nvim",
            "neovim/nvim-lspconfig",
        },
        opts = {
            ensure_installed = { "pyright", "cssls", "html", "bashls", "jsonls", "kotlin_language_server", "lua_ls", "nil_ls", "ruff", "tinymist" },
        },
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("GlobalInlayHints", {}),
                callback = function(args)
                    local client = vim.lsp.get_client_by_id(args.data.client_id)
                    if client and client.server_capabilities.inlayHintProvider then
                        vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
                        vim.lsp.inlay_hint.enable(false)
                    end
                end,
            })
            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup('lsp_attach_disable_ruff_hover', { clear = true }),
                callback = function(args)
                    local client = vim.lsp.get_client_by_id(args.data.client_id)
                    if client == nil then
                        return
                    end
                    if client.name == 'ruff' then
                        -- Disable hover in favor of Pyright
                        client.server_capabilities.hoverProvider = false
                    end
                end,
                desc = 'LSP: Disable hover capability from Ruff',
            })
            -- vim.diagnostic.config(
            --     {
            --         virtual_text = false,
            --         float = { border = "rounded" }
            --     }
            -- )
            vim.diagnostic.config({
                virtual_text = {
                    spacing = 2, -- 4
                    prefix = "■", -- or ">>", "●", etc.
                },
                signs = true,
                underline = true,
                update_in_insert = true, -- false
                severity_sort = true,
            })
        end,
    },

    -- {
    --     "nvimtools/none-ls.nvim",
    --     config = function()
    --         local null_ls = require("null-ls")
    --         null_ls.setup({
    --             debug = true,
    --             sources = {
    --                 null_ls.builtins.formatting.stylua,
    --                 null_ls.builtins.formatting.prettierd,
    --                 -- null_ls.builtins.formatting.nixpkgs_fmt, -- doesnt work; use conform
    --                 -- null_ls.builtins.formatting.alejandra,
    --                 null_ls.builtins.formatting.black,
    --                 null_ls.builtins.formatting.google_java_format,
    --             },
    --         })
    --     end,
    -- },
    {
        "stevearc/conform.nvim",
        config = function()
            require("conform").setup({
                -- format_on_save = {
                --     timeout_ms = 500,
                --     lsp_fallback = true,
                -- },
                formatters_by_ft = {
                    nix = { "nixpkgs_fmt" }, -- or "alejandra"
                    python = {
                        -- To fix auto-fixable lint errors.
                        "ruff_fix",
                        -- To run the Ruff formatter.
                        "ruff_format",
                        -- To organize the imports.
                        "ruff_organize_imports",
                    },
                    markdown = {
                        "prettierd", "prettier"
                    }
                },
            })
        end
    },
    requires = { "nvim-lua/plenary.nvim" },
}
