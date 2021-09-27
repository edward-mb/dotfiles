--[[
lvim is the global options object

Linters should be
filled in as strings with either
a global executable or a path to
an executable
]]
-- THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT

-- general
lvim.log.level = "warn"
lvim.format_on_save = true
lvim.colorscheme = "tokyonight"
vim.g.tokyonight_style = "night"

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"

-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.dashboard.active = true
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.side = "left"
lvim.builtin.nvimtree.show_icons.git = 0

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = "maintained"
lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true

lvim.builtin.bufferline.active = true

lvim.plugins = {
	{ "folke/tokyonight.nvim" },
	{
		"ray-x/lsp_signature.nvim",
		config = function()
			require("lsp_signature").on_attach()
		end,
		event = "InsertEnter",
	},
	{
		"p00f/nvim-ts-rainbow",
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		event = "BufRead",
		setup = function()
			vim.g.indentLine_enabled = 1
			vim.g.indent_blankline_char = "▏"
			vim.g.indent_blankline_filetype_exclude = { "help", "terminal", "dashboard" }
			vim.g.indent_blankline_buftype_exclude = { "terminal" }
			vim.g.indent_blankline_show_trailing_blankline_indent = false
			vim.g.indent_blankline_show_first_indent_level = false
			vim.g.indent_blankline_show_current_context = true
		end,
	},
	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup({ "*" }, {
				RGB = true, -- #RGB hex codes
				RRGGBB = true, -- #RRGGBB hex codes
				RRGGBBAA = true, -- #RRGGBBAA hex codes
				rgb_fn = true, -- CSS rgb() and rgba() functions
				hsl_fn = true, -- CSS hsl() and hsla() functions
				css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
				css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
			})
		end,
	},
	{
		"ethanholz/nvim-lastplace",
		event = "BufRead",
		config = function()
			require("nvim-lastplace").setup({
				lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
				lastplace_ignore_filetype = {
					"gitcommit",
					"gitrebase",
					"svn",
					"hgcommit",
				},
				lastplace_open_folds = true,
			})
		end,
	},
	{ "folke/todo-comments.nvim", event = "BufRead" },
	{ "mattn/emmet-vim" },
	{
		"aca/emmet-ls",
		config = function()
			local lspconfig = require("lspconfig")
			local configs = require("lspconfig/configs")

			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities.textDocument.completion.completionItem.snippetSupport = true
			capabilities.textDocument.completion.completionItem.resolveSupport = {
				properties = {
					"documentation",
					"detail",
					"additionalTextEdits",
				},
			}

			if not lspconfig.emmet_ls then
				configs.emmet_ls = {
					default_config = {
						cmd = { "emmet-ls", "--stdio" },
						filetypes = {
							"html",
							"css",
							"javascript",
							"typescript",
							"eruby",
							"typescriptreact",
							"javascriptreact",
							"scss",
							"svelte",
							"vue",
						},
						root_dir = function()
							return vim.loop.cwd()
						end,
						settings = {},
					},
				}
			end
			lspconfig.emmet_ls.setup({ capabilities = capabilities })
		end,
	},
}

vim.g.loaded_perl_provider = 0
vim.g.loaded_python_provider = 0
vim.g.python3_host_prog = "/usr/local/Caskroom/miniforge/base/bin/python"

lvim.lang.ruby.lsp.setup.cmd = { "/Users/x/.rbenv/shims/solargraph", "stdio" }
lvim.lang.lua.formatters = { { exe = "stylua" } }
lvim.lang.lua.linters = { { exe = "selene" } }
lvim.lang.html.formatters = { { exe = "prettierd" } }
lvim.lang.javascript.formatters = { { exe = "prettierd" } }
lvim.lang.css.formatters = { { exe = "prettierd" } }

local lsp = require("lsp")
local common_on_attach = lsp.common_on_attach
local common_capabilities = lsp.common_capabilities()
local common_on_init = lsp.common_on_init

local ls_install_prefix = vim.fn.stdpath "data" .. "/lspinstall"


lvim.lang.scss = {
	formatters = { { exe = "prettierd" } },
	linters = {},
	lsp = {
		provider = "cssls",
		setup = {
			cmd = {
				"node",
				ls_install_prefix .. "/css/vscode-css/css-language-features/server/dist/node/cssServerMain.js",
				"--stdio",
			},
			on_attach = common_on_attach,
			on_init = common_on_init,
			capabilities = common_capabilities,
		},
	},
}

lvim.builtin.autopairs.on_config_done = function(module)
	module.add_rules(require("nvim-autopairs.rules.endwise-ruby"))
end

lvim.builtin.treesitter.rainbow = {
	enable = true,
	extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
	max_file_lines = nil, -- Do not enable for files with more than n lines, int
	-- colors = {},
}
