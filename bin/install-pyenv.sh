#!/bin/sh

PYENV_VERSION=2.3.11

mkdir -p "$HOME/.direnv/"
cd "$HOME/.direnv/" || exit

wget -O "pyenv-${PYENV_VERSION}.tar.gz" \
    "https://github.com/pyenv/pyenv/archive/v${PYENV_VERSION}.tar.gz"

tar -xzvf "pyenv-${PYENV_VERSION}.tar.gz"
rm pyenv
ln -s "pyenv-${PYENV_VERSION}" pyenv

mkdir -p "$HOME/.direnv/bin/"
ln -sf "$HOME/.direnv/pyenv/plugins/python-build/bin/python-build" \
    "$HOME/.direnv/bin/"
