return { -- Starter screen
	{
		"echasnovski/mini.starter",
		enabled = true,
		version = false, -- wait till new 0.7.0 release to put it back on semver
		event = "VimEnter",
		opts = function()
			local logo = [[
                                             
      ████ ██████           █████      ██
     ███████████             █████ 
     █████████ ███████████████████ ███   ███████████
    █████████  ███    █████████████ █████ ██████████████
   █████████ ██████████ █████████ █████ █████ ████ █████
 ███████████ ███    ███ █████████ █████ █████ ████ █████
██████  █████████████████████ ████ █████ █████ ████ ██████
]]
			local pad = string.rep(" ", 25)
			local new_section = function(name, action, section)
				return {
					name = name,
					action = action,
					section = pad .. section,
				}
			end

			local starter = require("mini.starter")
			return {
				evaluate_single = true,
				header = logo,
				items = {
					new_section("Find file", ":Pick files", "Files"),
					new_section("New file", "ene | startinsert", "Built-in"),
					new_section("Quit", "qa", "Built-in"),
				},
				content_hooks = {
					starter.gen_hook.adding_bullet(pad .. "• ", false),
					starter.gen_hook.aligning("center", "center"),
				},
			}
		end,
		config = function(_, config)
			-- close Lazy and re-open when starter is ready
			if vim.o.filetype == "lazy" then
				vim.cmd.close()
				vim.api.nvim_create_autocmd("User", {
					pattern = "MiniStarterOpened",
					callback = function()
						require("lazy").show()
					end,
				})
			end

			local starter = require("mini.starter")
			starter.setup(config)

			vim.api.nvim_create_autocmd("User", {
				pattern = "LazyVimStarted",
				callback = function()
					local stats = require("lazy").stats()
					local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
					local pad_footer = string.rep(" ", 8)
					starter.config.footer = pad_footer
						.. "⚡ Neovim loaded "
						.. stats.count
						.. " plugins in "
						.. ms
						.. "ms"
					pcall(starter.refresh)
				end,
			})
		end,
	},
}
