-- LSP stack for Neovim 0.11+/0.12 using the built-in vim.lsp.config / vim.lsp.enable.
-- mason-lspconfig v2 installs servers (ensure_installed) and auto-enables them;
-- it no longer has `handlers` or `automatic_installation`.
return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			{ "mason-org/mason.nvim", cmd = "Mason", opts = { ui = { border = "rounded" } } },
			{
				"mason-org/mason-lspconfig.nvim",
				opts = {
					-- NOTE: pyright, bashls, jsonls and yamlls are npm packages -> need Node/npm.
					ensure_installed = { "lua_ls", "pyright", "bashls", "jsonls", "yamlls" },
					automatic_enable = true,
				},
			},
			{ "folke/lazydev.nvim", ft = "lua", opts = {} },
			"saghen/blink.cmp",
		},
		config = function()
			-- Capabilities for every server (blink.cmp completion features)
			local ok, blink = pcall(require, "blink.cmp")
			if ok then
				vim.lsp.config("*", { capabilities = blink.get_lsp_capabilities() })
			end

			vim.lsp.config("lua_ls", {
				settings = {
					Lua = {
						workspace = { checkThirdParty = false },
						telemetry = { enable = false },
					},
				},
			})

			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
				callback = function(ev)
					local client = vim.lsp.get_client_by_id(ev.data.client_id)
					local buf = ev.buf
					local map = function(keys, func, desc)
						vim.keymap.set("n", keys, func, { buffer = buf, desc = desc })
					end

					map("gd", vim.lsp.buf.definition, "Go to definition")
					map("gr", vim.lsp.buf.references, "References")
					map("gI", vim.lsp.buf.implementation, "Go to implementation")
					map("K", vim.lsp.buf.hover, "Hover docs")
					map("<leader>rn", vim.lsp.buf.rename, "Rename symbol")
					map("<leader>ca", vim.lsp.buf.code_action, "Code action")
					map("<leader>d", vim.diagnostic.open_float, "Line diagnostics")
					map("[d", function()
						vim.diagnostic.jump({ count = -1, float = true })
					end, "Previous diagnostic")
					map("]d", function()
						vim.diagnostic.jump({ count = 1, float = true })
					end, "Next diagnostic")

					if client and client:supports_method("textDocument/inlayHint") then
						vim.lsp.inlay_hint.enable(true, { bufnr = buf })
					end
				end,
			})

			vim.diagnostic.config({
				virtual_text = { prefix = "●", spacing = 4 },
				signs = true,
				underline = true,
				update_in_insert = false,
				severity_sort = true,
			})
		end,
	},

	{
		"saghen/blink.cmp",
		version = "1.*",
		dependencies = { "rafamadriz/friendly-snippets" },
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			keymap = { preset = "default" },
			appearance = { nerd_font_variant = "mono" },
			completion = {
				documentation = { auto_show = true, auto_show_delay_ms = 200 },
			},
			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
				per_filetype = {
					lua = { inherit_defaults = true, "lazydev" },
				},
				providers = {
					lazydev = {
						name = "LazyDev",
						module = "lazydev.integrations.blink",
						score_offset = 100,
					},
				},
			},
			fuzzy = { implementation = "prefer_rust_with_warning" },
		},
		opts_extend = { "sources.default" },
	},

	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				"<leader>cf", -- was <leader>f, which shadowed <leader>ff/fg/fb/fh
				function()
					require("conform").format({ async = true, lsp_format = "fallback" })
				end,
				mode = "",
				desc = "Format buffer",
			},
		},
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "isort", "black" },
				javascript = { "prettier" },
				typescript = { "prettier" },
				json = { "prettier" },
				yaml = { "prettier" },
				markdown = { "prettier" },
				bash = { "shfmt" },
			},
			format_on_save = {
				timeout_ms = 500,
				lsp_format = "fallback",
			},
		},
	},

	-- Installs the formatters conform expects (mason-lspconfig only handles LSP servers).
	-- prettier needs Node/npm.
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		lazy = false,
		dependencies = { "mason-org/mason.nvim" },
		opts = {
			ensure_installed = { "stylua", "black", "isort", "prettier", "shfmt" },
		},
	},
}
