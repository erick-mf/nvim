return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
		"williamboman/mason.nvim",
		"jay-babu/mason-nvim-dap.nvim",
	},
	keys = {
		{
			"<F5>",
			function()
				require("dap").continue()
			end,
			desc = "Debug: Start/Continue",
		},
		{
			"<F1>",
			function()
				require("dap").step_into()
			end,
			desc = "Debug: Step Into",
		},
		{
			"<F2>",
			function()
				require("dap").step_over()
			end,
			desc = "Debug: Step Over",
		},
		{
			"<F3>",
			function()
				require("dap").step_out()
			end,
			desc = "Debug: Step Out",
		},
		{
			"<F10>",
			function()
				require("dap").terminate()
				require("dap").close()
				require("dap").clear_breakpoints()
				require("dapui").close()
			end,
			desc = "Debug: Terminate",
		},
		{
			"<leader>b",
			function()
				require("dap").set_breakpoint()
			end,
			desc = "Debug: Set Breakpoint",
		},
		{
			"<leader>B",
			function()
				require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
			end,
			desc = "Debug: Set Breakpoint Conditional",
		},
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")

		require("mason-nvim-dap").setup({
			automatic_installation = true,
			handlers = {},
			ensure_installed = {
				"php-debug-adapter",
			},
		})

		dapui.setup({
			layouts = {
				{
					elements = {
						{ id = "breakpoints", size = 0.20 },
						{ id = "scopes", size = 0.60 }, --[[ "watches" ]]
						{ id = "stacks", size = 0.20 },
					},
					size = 60,
					position = "left",
				},
				{ elements = { "repl", "console" }, size = 0.20, position = "bottom" },
			},
			render = { indent = 2 },
		})

		dap.listeners.after.event_initialized["dapui_config"] = dapui.open
		dap.listeners.before.event_terminated["dapui_config"] = dapui.close
		dap.listeners.before.event_exited["dapui_config"] = dapui.close

		-- grupo de resaltado para el punto de interrupción
		vim.api.nvim_set_hl(0, "DapBreakpoint", { fg = "#FF4444", bg = "NONE" })

		-- el signo del punto de interrupción
		vim.fn.sign_define("DapBreakpoint", {
			text = " ●",
			texthl = "DapBreakpoint",
			linehl = "",
			numhl = "DapBreakpoint",
		})

		vim.api.nvim_set_hl(0, "DapStopped", { fg = "#00FF00", bg = "NONE" })
		vim.api.nvim_set_hl(0, "DapStoppedLine", { bg = "#2A2A2A" })

		vim.fn.sign_define("DapStopped", {
			text = " ▶",
			texthl = "DapStopped",
			linehl = "DapStoppedLine",
			numhl = "DapStopped",
		})

		dap.adapters.php = {
			type = "executable",
			command = "node",
			args = {
				os.getenv("HOME") .. "/.local/share/nvim/mason/packages/php-debug-adapter/extension/out/phpDebug.js",
			},
			-- pathMappings = {
			--     ["/mnt/d/code/php/"] = "${workspaceFolder}"
			-- }
		}
		dap.configurations.php = {
			{
				type = "php",
				request = "launch",
				name = "Launch Xdebug",
				port = 9003,
				-- program = "${file}",
				cwd = "${workspaceFolder}",
				console = "integratedTerminal",
			},
			{
				type = "php",
				request = "launch",
				name = "Laravel",
				port = 9003,
				pathMappings = {
					["/var/www/app"] = "${workspaceFolder}",
				},
			},
			{
				type = "php",
				request = "launch",
				name = "Symfony",
				port = 9003,
				pathMappings = {
					["/app"] = "${workspaceFolder}",
				},
			},
		}
	end,
}
