return {
    "neovim/nvim-lspconfig",
    dependencies = {
        { "williamboman/mason.nvim", config = true },
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
                            version = "LuaJIT",
                            path = vim.split(package.path, ";"),
                        },
                        diagnostics = {
                            globals = { "vim" },
                        },
                        workspace = {
                            library = vim.api.nvim_get_runtime_file("", true),
                            checkThirdParty = false,
                        },
                        completion = {
                            callSnippet = "Replace",
                        },
                        telemetry = {
                            enable = false,
                        },
                    },
                },
            },
            vue_ls = {
                filetypes = { "typescript", "javascript", "vue" },
                init_options = {
                    typescript = {
                        tsdk = (vim.fs.root(0, "node_modules") or vim.fn.getcwd()) .. "/node_modules/typescript/lib",
                    },
                    vue = {
                        hybridMode = false,
                    },
                },
                settings = {
                    typescript = {
                        suggest = {
                            paths = true,
                            autoImports = true,
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

        -- lspconfig name -> mason package name overrides
        local mason_name_map = {
            vue_ls = "vue-language-server",
            lua_ls = "lua-language-server",
            cssls = "css-lsp",
            html = "html-lsp",
        }
        ensure_installed = vim.tbl_map(function(name)
            return mason_name_map[name] or name
        end, ensure_installed)

        vim.list_extend(ensure_installed, {
            "stylua",
        })
        require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

        -- Setup all LSP servers with shared capabilities and on_attach
        for server_name, server_opts in pairs(servers) do
            vim.lsp.config(
                server_name,
                vim.tbl_deep_extend("force", {
                    capabilities = capabilities,
                    on_attach = on_attach,
                }, server_opts)
            )
        end

        vim.lsp.enable(vim.tbl_keys(servers))
    end,
}
