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

vim.api.nvim_create_user_command("AsepriteRun", function(_)
	local aseprite = require("nvim-aseprite")
	if aseprite.job and aseprite.job.id then
		vim.notify("Aseprite already running. Use :AsepriteStop or :AsepriteRestart instead.", vim.log.levels.INFO)
		return
	end
	aseprite.run()
end, {
	nargs = 0,
	desc = "Launch an Aseprite process tied to this session",
})

vim.api.nvim_create_user_command("AsepriteStop", function(_)
	local aseprite = require("nvim-aseprite")
	if not aseprite.job or not aseprite.job.id then
		vim.notify("No aseprite process running. Use :AsepriteRun or :AsepriteRestart instead.", vim.log.levels.INFO)
		return
	end
	aseprite.stop()
end, {
	nargs = 0,
	desc = "Stop the current Aseprite process",
})

vim.api.nvim_create_user_command("AsepriteRestart", function(_)
	local aseprite = require("nvim-aseprite")
	aseprite.restart()
end, {
	nargs = 0,
	desc = "Restart Aseprite, or simply start a new process if not currently running",
})
