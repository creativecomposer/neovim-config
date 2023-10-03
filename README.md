# My NeoVim config

This is my NeoVim setup for my Web Development work.

It is based on the video and repo by `ThePrimeagen`:

1.  [The Video](https://youtu.be/w7i4amO_zaE)
2.  [The repo](https://github.com/ThePrimeagen/init.lua)

It uses [lsp-zero](https://github.com/VonHeikemen/lsp-zero.nvim), which makes it super easy to
set up LSP.

## How to set up

1. Clone this repo to `~/.config/nvim/`.
2. Run `ansible-playbook packer.yml`.
3. Make sure that the npm packages `typescript`, `typescript-language-server`, and `vscode-langservers-extracted` are installed.
   I use `nvm` to manage node and the global npm packages. So, running `nvm install --lts` installs all of these packages for me.
4. Install NeoVim.
