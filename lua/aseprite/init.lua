--------------------------------------------------------------------------------
-- Copyright © 2025  Elliot "Scatternoodle" Shirra
--
-- This program is free software; you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation; either version 2 of the License, or
-- (at your option) any later version.
--
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License along
-- with this program; if not, write to the Free Software Foundation, Inc.,
-- 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
--------------------------------------------------------------------------------

---@diagnostic disable: param-type-mismatch
---@diagnostic disable: missing-fields

local uv = vim.uv
local api = vim.api

---@class aseprite
---@field loaded boolean
---@field options options
---@field options_defaults options
---@field job job
local aseprite = {
	loaded = false,
}

---@class options
---@field path_aseprite_binary? string: Path to your Aseprite binary
aseprite.options = {}
aseprite.options_defaults = {
	path_aseprite_binary = "aseprite", -- custom aseprite install path
}

---@class job
---@field id integer
aseprite.job = {}

local function extend_lsp()
	if not vim.lsp.config.lua_ls then
		vim.notify("nvim_aseprite: extend_lsp: could not find lua_ls config", vim.log.levels.ERROR)
		return
	end

	local settings = {
		Lua = {
			workspace = {
				-- Without libary because vim.tbl_deep_extend overwrites lists
				-- and user may have their own libraries configured. Rather
				-- than force overwrite, we'll insert the libary below.
			},
		},
	}
	settings = vim.tbl_deep_extend("force", vim.lsp.config.lua_ls.settings or {}, settings)

	-- Add libaries separately so that we can insert the Aseprite library
	-- safely, without overwriting any pre-existing user libaries.
	local libraries = {}
	---@diagnostic disable-next-line: undefined-field
	libraries = settings.Lua.workspace.library or {}
	table.insert(libraries, vim.fn.globpath(vim.o.runtimepath, "aseprite-lualib"))
	---@diagnostic disable-next-line: undefined-field
	settings.Lua.workspace.library = libraries

	-- Apply and restart the language server, because as of 2025-10-17, Neovim
	-- LSP implementation does not yet support dynamic configuration updates.
	vim.lsp.config("lua_ls", { settings = settings })
	vim.lsp.enable("lua_ls", false)
	vim.lsp.enable("lua_ls", true)
end

--- Returns true if dir is in an aseprite project, which is a project where
--- there is a file named ".aseprite" within the project structure. Searches upwards
--- until it finds the .aseprite file, or stopping once it hits a directory
--- containing a .git directory, which is assumed to be project root.
---
--- @param dir string
--- @return boolean
aseprite.is_aseprite_project = function(dir)
	while dir do
		if uv.fs_stat(vim.fs.joinpath(dir, ".aseprite")) then
			return true
		end
		if uv.fs_stat(vim.fs.joinpath(dir, ".git")) then
			return false
		end

		local parent = uv.fs_realpath(vim.fs.joinpath(dir, ".."))
		if not parent or parent == dir then
			return false
		end
		dir = parent
	end
	return false
end

---Starts an Aseprite process tied to the current neovim session. Only attached
---Aseprite job may be active at any given time.
aseprite.cmd_run = function()
	if aseprite.job and aseprite.job.id then
		vim.notify("Aseprite already running. Use :AsepriteStop or :AsepriteRestart instead.", vim.log.levels.INFO)
		return
	end
	aseprite.job = {}
	local cmd = vim.fn.expand(aseprite.options.path_aseprite_binary)
	aseprite.job.id = vim.fn.jobstart(cmd, {
		on_exit = function()
			aseprite.job = {}
		end,
	})
end

---Stops the current Aseprite process, if running.
aseprite.cmd_stop = function()
	if not aseprite.job or not aseprite.job.id then
		vim.notify("No aseprite process running. Use :AsepriteRun or :AsepriteRestart instead.", vim.log.levels.INFO)
		return
	end
	local res = vim.fn.jobstop(aseprite.job.id)
	aseprite.job = {}
end

---Restarts the current Aseprite process, or simply starts a new one if none are
---running currently. Note, this will not retain the existing process ID.
aseprite.cmd_restart = function()
	if aseprite.job and aseprite.job.id then
		aseprite.cmd_stop()
	end
	aseprite.cmd_run()
end

---@param opts? options
aseprite.setup = function(opts)
	if not aseprite.is_aseprite_project(vim.fn.getcwd()) then
		return
	end

	aseprite.options = vim.tbl_deep_extend("force", {}, aseprite.options_defaults, opts or {})
	aseprite.job = {}

	local group = api.nvim_create_augroup("nvim-aseprite", { clear = true })
	api.nvim_create_autocmd("LspAttach", {
		group = group,
		once = true, -- Has to be one-shot, because otherwise the LSP restart causes an endless loop
		callback = function(args)
			local client = vim.lsp.get_client_by_id(args.data.client_id)
			if not client or client.name ~= "lua_ls" then
				return
			end
			extend_lsp()
		end,
	})

	api.nvim_create_user_command("AsepriteRun", function(_)
		aseprite.cmd_run()
	end, {
		nargs = 0,
		desc = "Launch an Aseprite process tied to this session",
	})
	api.nvim_create_user_command("AsepriteStop", function(_)
		aseprite.cmd_stop()
	end, {
		nargs = 0,
		desc = "Stop the current Aseprite process",
	})
	api.nvim_create_user_command("AsepriteRestart", function(_)
		aseprite.cmd_restart()
	end, {
		nargs = 0,
		desc = "Restart Aseprite, or simply start a new process if not currently running",
	})

	aseprite.loaded = true
	print("loaded")
end

return aseprite
