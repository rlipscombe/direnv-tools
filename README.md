# direnv-tools

## Prerequisites

We assume that you've installed `direnv`, and that it's available in `$PATH`.

For example, on Linux:

```bash
mkdir -p $HOME/bin
cd $HOME/bin
curl -qfsSL https://github.com/direnv/direnv/releases/download/v2.21.3/direnv.linux-amd64 -o direnv
chmod +x direnv
```

Then, at the end of your `.bashrc`:

```bash
export PATH=$HOME/bin:$PATH
eval "$(direnv hook bash)
```

## Installation

```bash
mkdir -p $HOME/.config/direnv
ln -s $(pwd)/lib $HOME/.config/direnv
```

## What's missing?

This is intended to be a self-installing version of the instructions at https://blog.differentpla.net/blog/2019/01/30/direnv-tool-versions/, but it's missing several of the steps, which you still have to do manually.
