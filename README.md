# nvim-aseprite
Get Lua API types and LSP support for developing Aseprite plugins in Neovim

This plugin wraps a [fork](https://github.com/scatternoodle/aseprite-lualib) of [RampantDespair's excellent definitions library](https://github.com/RampantDespair/Aseprite-Library). It dynamically detects when an Aseprite plugin project is opened, and inserts Aseprite API types and globals into the Lua language server (lua_ls) workspace.

nvim-aseprite is currently experimental and should be considered unstable until it reaches a 1.0 release.

## Acknowledgements
* RampantDespair - [Aseprite-Library](https://github.com/RampantDespair/Aseprite-Library)
* The Aseprite Team - [Aseprite API](https://www.aseprite.org/api)

## Dependencies
* The [Lua Language Server](https://luals.github.io/) (lua_ls) must be installed and enabled for this plugin to function. This is [available natively](https://neovim.io/doc/user/lsp.html#lsp-quickstart) in Neovim via lspconfig.

## Installation

Simply install via the method of your choice, making sure to call the setup function - the plugin won't work unless you do. There are currently no configuration options.

Lazy:
```Lua
{
	"scatternoodle/nvim-aseprite",
	config = function()
		require("nvim-aseprite").setup()
	end,
}
```

Packer:
```Lua
use({
  "scatternoodle/nvim-aseprite",
  config = function()
    require("nvim-aseprite").setup()
  end,
})
```

vim-plug:
```Lua
Plug 'scatternoodle/nvim-aseprite'
require("nvim-aseprite").setup()
```

## Usage

In-editor help: `:help nvim-aseprite`

The API libary is only inserted into the workspace once an Aseprite plugin is detected. There is no official Aseprite standard for this (such as a uniquely-named RC file or directory structure) so we have devised our own for this plugin. Simply place a file named `.aseprite` wtihin your project directory. This can be at the root of the project, but does not need to be. The file can be empty, and indeed, any content inside will be ignored.

<img width="331" height="162" alt="image" src="https://github.com/user-attachments/assets/76f0e108-8b61-427b-9c21-b03d1e39d7e5" />


The plugin will detect the presence of this file during the setup function, which will cause the API library to be inserted into the lua_ls workspace when the lua_ls client first attaches. After this, you can enjoy autocomplete, hover text, and other LSP goodies as you would with explicitly-included lua files.

<img width="640" height="188" alt="image" src="https://github.com/user-attachments/assets/c0687b55-5cd0-4560-8fcd-ddff2a9b5da9" />

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

