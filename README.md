# nvim-donfig

My neovim configuration derived from nvim 
[kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim).

## install

You should copy files found in `nvim-config` repository into your
`~/.config/nvim` directory.

## dependencies 

In order to use fuzzy search in files content you need to install the following
dependencies

on debian:

```sh
sudo apt install fzf ripgrep
```

on mac:

```sh
brew install fsf ripgrep
```

## Ruby debugger DAP adapter 

You will need to have working `rdbg` and install 
[debug.rb](https://github.com/ruby/debug) gem:

```rb
gem install debug
```
