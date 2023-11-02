# nvim-donfig

My neovim configuration derived from nvim 
[kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim).

## install

You will need neovim >= 8.0 (otherwise lazy plugin manager will not work)

You should copy files found in `nvim-config` repository into your
`~/.config/nvim` directory.

## dependencies 

If you build NeoVIM from sources you should set to environment variables:

```sh
export PATH="~/dev/neovim/build/bin/:$PATH"
export VIMRUNTIME="~/dev/neovim/runtime"
```


In order to use fuzzy search in files content you need to install the following
dependencies

on debian:

```sh
sudo apt install luajit fzf ripgrep
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
