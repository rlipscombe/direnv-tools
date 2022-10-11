# direnv-tools

## Prerequisites

We assume that you've installed a reasonably up-to-date `direnv`, and that it's
available in `$PATH`.

For example, on Linux:

```bash
mkdir -p $HOME/bin
cd $HOME/bin
curl -qfsSL https://github.com/direnv/direnv/releases/download/v2.32.1/direnv.linux-amd64 -o direnv
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

## Troubleshooting

If `direnv reload` complains about missing functions, such as `use_ruby`, etc.,
then you need a newer version of direnv.

## What's missing?

This is intended to be a self-installing version of the instructions at
https://blog.differentpla.net/blog/2019/01/30/direnv-tool-versions/, but it's
missing several of the steps, which you still have to do manually.
