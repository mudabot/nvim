return {
	"CopilotC-Nvim/CopilotChat.nvim",
	dependencies = {
		{ "github/copilot.vim" },
		{ "nvim-lua/plenary.nvim", branch = "master" },
	},
	build = "make tiktoken",
	cmd = { "CopilotChat", "CopilotChatToggle" },
	keys = {
		{ "<leader>cc", "<cmd>CopilotChatToggle<cr>", mode = { "n", "v" }, desc = "Copilot Chat" },
	},
	opts = {},
}
