return {
    "neovim/nvim-lspconfig",
    dependencies = {
        { "williamboman/mason.nvim", config = true },
        "williamboman/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        { "j-hui/fidget.nvim", opts = {} },
    },
    config = function()
        -- Get the LSP capabilities from blink.cmp
        local capabilities = require("blink.cmp").get_lsp_capabilities(vim.lsp.protocol.make_client_capabilities())

        -- Configure diagnostic signs
        vim.diagnostic.config({
            signs = {
                text = {
                    [vim.diagnostic.severity.ERROR] = "󰅚",
                    [vim.diagnostic.severity.WARN] = "󰀪",
                    [vim.diagnostic.severity.INFO] = "󰋽",
                    [vim.diagnostic.severity.HINT] = "󰌶",
                },
            },
        })

        -- Define the on_attach function for keymaps
        local on_attach = function(client, bufnr)
            local map = function(mode, lhs, rhs, desc)
                vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true, desc = desc })
            end
            -- FzfLua LSP keymaps
            map("n", "gd", ":FzfLua lsp_definitions<CR>", "[G]oto [D]efinition")
            map("n", "gr", ":FzfLua lsp_references<CR>", "[G]oto [R]eferences")
            map("n", "gI", ":FzfLua lsp_implementations<CR>", "[G]oto [I]mplementation")
            map("n", "gD", ":FzfLua lsp_declarations<CR>", "[G]oto [D]eclaration")
            map("n", "gy", ":FzfLua lsp_typedefs<CR>", "[G]oto T[y]pe Definition")
            map("n", "K", vim.lsp.buf.hover, "Hover Doc")
            map("n", "<leader>ca", vim.lsp.buf.code_action, "Code Action")
            map("n", "<leader>cr", vim.lsp.buf.rename, "[C]ode [R]ename")
        end

        -- Server-specific configs
        local servers = {
            lua_ls = {
                settings = {
                    Lua = {
                        runtime = {
                            version = "LuaJIT", -- Required for Neovim
                            path = vim.split(package.path, ";"),
                        },
                        diagnostics = {
                            globals = { "vim" }, -- Allow `vim` without warning
                        },
                        workspace = {
                            library = vim.api.nvim_get_runtime_file("", true),
                            checkThirdParty = false, -- Disable popup about third party
                        },
                        completion = {
                            callSnippet = "Replace", -- Enables param placeholders
                        },
                        telemetry = {
                            enable = false,
                        },
                    },
                },
            },
            volar = {
                filetypes = { "typescript", "javascript", "vue" },
                init_options = {
                    typescript = {
                        tsdk = vim.fn.getcwd() .. "/node_modules/typescript/lib",
                    },
                    vue = {
                        hybridMode = false,
                    },
                },
                settings = {
                    typescript = {
                        suggest = {
                            -- enabled = true,
                            paths = true,
                            autoImports = true,
                            -- completeFunctionCalls = true,
                            -- includeCompletionsForImportStatements = true,
                            -- includeCompletionsWithClassMemberSnippets = true,
                            -- includeAutomaticOptionalChainCompletions = true,
                            -- includeCompletionsForModuleExports = true,
                            -- includeCompletionsWithSnippetText = true,
                            -- includeCompletionsWithInsertText = true,
                            -- includePackageJsonAutoImports = "auto",
                            -- includeCompletionsWithObjectLiteralMethodSnippets = true,
                            -- generateReturnInDocTemplate = true,
                        },
                    },
                },
            },
            intelephense = {},
            cssls = {},
            html = {},
        }

        -- Mason setup
        require("mason").setup()
        local ensure_installed = vim.tbl_keys(servers or {})
        vim.list_extend(ensure_installed, {
            "stylua",
        })
        require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

        -- Setup all LSP servers with shared capabilities and on_attach
        local lspconfig = require("lspconfig")
        for server_name, server_opts in pairs(servers) do
            -- Apply common options to all servers
            local opts = {
                capabilities = capabilities,
                on_attach = on_attach,
            }

            -- Merge server-specific options
            for k, v in pairs(server_opts) do
                opts[k] = v
            end

            lspconfig[server_name].setup(opts)
        end
    end,
}
