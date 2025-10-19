# aseprite.nvim
Tools and commands for working with Aseprite plugin projects in Neovim.

* Launch Aseprite from inside Neovim
* Get LSP type support for Aseprite's API, using a [fork](https://github.com/scatternoodle/aseprite-lualib) of [RampantDespair's excellent definitions library](https://github.com/RampantDespair/Aseprite-Library).

**_nvim.aseprite is currently experimental and should be considered unstable._**

## Setup

### Dependencies 
* [Aseprite](https://www.aseprite.org/)
* [Lua Language Server](https://luals.github.io/) (lua_ls) must be installed and enabled for this plugin to function. This is [available natively](https://neovim.io/doc/user/lsp.html#lsp-quickstart) in Neovim via lspconfig.

### Installation
It is recommended to use a plugin manager, such as `lazy.nvim`. Either way,
ensure that plugin load and setup function run early - this is critical for
parts of the plugin such as LSP support to function correctly. For lazy.nvim
users, this means either setting `lazy = false` or `event = "VeryLazy"`.

Example setup using `lazy.nvim`
```lua
	"scatternoodle/aseprite.nvim",
	event = "VeryLazy",
	opts = {},
	keys = {
		{ "<leader>a", desc = "Aseprite" },
		{ "<leader>ar", "<cmd>AsepriteRestart<cr>", desc = "Restart Aseprite" },
		{ "<leader>as", "<cmd>AsepriteStop<cr>", desc = "Stop Aseprite" },
	},
```

### Configuration

Default config options below, please use `:help aseprite` inside Neovim for more detailed documentation about each option.
```Lua
aseprite.options_defaults = {
	path_aseprite_binary = "aseprite", -- custom aseprite install path
}
```

## Usage

Get full documentation including commands inside Neovim with `:help aseprite`. Read on for a note about Aseprite project detection.

### Aseprite project detection
The plugin only loads if an Aseprite plugin is detected. There is no official Aseprite standard for this (such as a uniquely-named RC file or directory structure) so we have devised our own for this plugin. Simply place a file named `.aseprite` wtihin your project directory. This can be at the root of the project, but does not need to be. The file can be empty, and indeed, any content inside will be ignored.

<img width="331" height="162" alt="image" src="https://github.com/user-attachments/assets/76f0e108-8b61-427b-9c21-b03d1e39d7e5" />

## Acknowledgements
* RampantDespair, for [Aseprite-Library](https://github.com/RampantDespair/Aseprite-Library)
* The Aseprite Team, for [Aseprite API](https://www.aseprite.org/api)

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

