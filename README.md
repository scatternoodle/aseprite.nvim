# nvim-aseprite
Tools and commands for working with Aseprite plugin projects in Neovim.

* Commands for launching Aseprite and testing plugins
* This plugin wraps a [fork](https://github.com/scatternoodle/aseprite-lualib) of [RampantDespair's excellent definitions library](https://github.com/RampantDespair/Aseprite-Library). It dynamically detects when an Aseprite plugin project is opened, and inserts Aseprite API types and globals into the Lua language server (lua_ls) workspace.

**_nvim-aseprite is currently experimental and should be considered unstable until it reaches a 1.0 release._**

## Acknowledgements
* RampantDespair - [Aseprite-Library](https://github.com/RampantDespair/Aseprite-Library)
* The Aseprite Team - [Aseprite API](https://www.aseprite.org/api)

## Dependencies
* The [Lua Language Server](https://luals.github.io/) (lua_ls) must be installed and enabled for this plugin to function. This is [available natively](https://neovim.io/doc/user/lsp.html#lsp-quickstart) in Neovim via lspconfig.

## Installation

It is recommended to use a plugin manager, such as `lazy.nvim`. Either way,
ensure that plugin load and setup function run early - this is critical for
parts of the plugin such as LSP support to function correctly. For lazy.nvim
users, this means either setting `lazy = false` or `event = "VeryLazy"`.

Example setup using `lazy.nvim`
```lua
	"scatternoodle/nvim-aseprite",
	event = "VeryLazy",
	opts = {},
	keys = {
		{ "<leader>a", desc = "Aseprite" },
		{ "<leader>ar", "<cmd>AsepriteRestart<cr>", desc = "Restart Aseprite" },
		{ "<leader>as", "<cmd>AsepriteStop<cr>", desc = "Stop Aseprite" },
	},
```

## Usage

Get documentation inside Neovim with `:help nvim-aseprite`

### Aseprite project detection
The plugin only loads if an Aseprite plugin is detected. There is no official Aseprite standard for this (such as a uniquely-named RC file or directory structure) so we have devised our own for this plugin. Simply place a file named `.aseprite` wtihin your project directory. This can be at the root of the project, but does not need to be. The file can be empty, and indeed, any content inside will be ignored.

<img width="331" height="162" alt="image" src="https://github.com/user-attachments/assets/76f0e108-8b61-427b-9c21-b03d1e39d7e5" />

### Commands

* `:AsepriteRun`
  Start Aseprite from Neovim, with no arguments. The Aseprite process is tied
  to the neovim session. Only one Aseprite process can be attached at a time.
  The current job ID is stored in `nvim-aseprite.job.id`.

* `:AsepriteStop`
  Stop the current Aseprite process (stored under `nvim-aseprite.job.id`) if
  running.

* `:AsepriteRestart`
  Stop the current Aseprite process if running, and start a new one. The
  pre-existing process ID is not retained. `:AsepriteRestart` can be used
  regardless of whether there is an existing Aseprite process; a new one will
  be started and override `nvim-aseprite.job.id` either way.

## Copyright Notice

    Copyright © 2025  Elliot "Scatternoodle" Shirra
	
	This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License along
    with this program; if not, write to the Free Software Foundation, Inc.,
    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.

