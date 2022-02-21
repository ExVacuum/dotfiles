# dotfiles

Silas' Arch Dotfiles

This repository contains configuration files, or *dotfiles* for many programs which I use in my Arch Linux install. I hope to soon migrate all of my configuration to this repository, as well as to automate the configuration process.

## Dependencies

To install the configurations of programs in this repository, the following programs are required:

- `yay`
- `python`
- `pip`
- `node`
- `siconf` - custom config/dependency loading program written in nodejs

Any of these which are not already installed can be installed using the `required` script in the root of this repository. Do not run it as root, you will be prompted fot the root password.
Note that this script will also install the following if they are not already present:

- `git`
- `curl`
- `base-devel` group

Dependencies for individual configurations can be installed by running the installed `siconf` program using the command:
```sh
siconf deps <program>
```
The configuration can be installed using the following command:
```sh
siconf install <program>
```

## Currently Available Dotfiles

### Program Categories

- [Development](#development)

### Development

| Name              | Description                    | Project Page(s)                                                                            |
| ----------------- | ------------------------------ | ------------------------------------------------------------------------------------------ |
| [Neovim](#neovim) | Community-driven fork of `vim` | [:globe_with_meridians:](https://neovim.io/) [:octocat:](https://github.com/neovim/neovim) |

#### Neovim

```sh
siconf deps neovim
siconf install neovim
```

Neovim is a community-driven fork of `vim`, and my primary development environment.

![](./doc/nvim.jpg)

**Note: Terminal opacity and background color is handled by my `kitty` config, and the prompt theme is handled by my `zsh` and `powerlevel10k` config.**

##### Features:

- LSP autocompletion/snippets/highlighting for:
    - C/C++ ([CCLS](https://github.com/MaskRay/ccls))
    - JS(X)/TS(X) ([ts-server](https://www.npmjs.com/package/ts-server))
    - CSS ([CSSLS](https://github.com/hrsh7th/vscode-langservers-extracted))
    - markdown ([remark_ls](https://github.com/remarkjs/remark-language-server))
    - bash ([bashls](https://github.com/bash-lsp/bash-language-server))
    - python ([pylsp](https://github.com/python-lsp/python-lsp-server))
    - lua ([sumneko_lua](https://github.com/sumneko/lua-language-server))
    - rust ([rust_analyzer](https://github.com/rust-analyzer/rust-analyzer))
using [COQ](https://github.com/ms-jpq/coq_nvim) completion engine
- [ARM assembly syntax](https://github.com/ARM9/arm-syntax-vim)
- [Limelight](https://github.com/junegunn/limelight.vim) focus mode
- In-editor ([Glow](https://github.com/ellisonleao/glow.nvim)) + [live browser](https://github.com/iamcco/markdown-preview.nvim) markdown previews
- File tree viewer using [nvim-tree](https://github.com/kyazdani42/nvim-tree.lua)
- [Autosave on edit](https://github.com/Pocco81/AutoSave.nvim)
- [Discord rich presence](https://github.com/andweeb/presence.nvim)
- [GNU Debugger (gdb) integration](https://github.com/sakhnik/nvim-gdb)
- [Greeter](https://github.com/goolord/alpha-nvim)
- Ability to force save read-only files ([Suda](https://github.com/lambdalisue/suda.vim))
- [Advanced TODO comment highlighting and listing](https://github.com/folke/todo-comments.nvim)
- Error/warning minibuffer ([Trouble](https://github.com/folke/trouble.nvim))
- Nordlike color scheme ([NightFox NordFox](https://github.com/EdenEast/nightfox.nvim))
- Remote connections over SSH with [Distant](https://github.com/chipsenkbeil/distant.nvim)
- [Color code highlighting in truecolor](https://github.com/norcalli/nvim-colorizer.lua)
- Markdown internal linking / note management ([mkdnflow](https://github.com/jakewvincent/mkdnflow.nvim))
- Word count for markdown and plaintext files

## Coming Soon

- kitty (terminal)
- zsh (shell)
    - powerlevel10k (theme)
- LightDM (Display Manager)
- Awesome Window Manager (WM)
- Picom (Compositor)

## TODO
- [ ] Migrate More Dotfiles
- [ ] Automated Config Linking Script
- [ ] Automated Package Installer Script
- [ ] Migrate user scripts
