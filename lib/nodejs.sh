use_nodejs() {
    NODE_VERSION="$1"

    if has fnm; then
        FNM_INTERACTIVE_CLI=false fnm use "$NODE_VERSION" || echo "$(tput setaf 1)fnm install $NODE_VERSION$(tput sgr0)"
        PATH_add $HOME/.fnm/current/bin
    else
        export NVM_DIR=$HOME/.nvm

        type nvm >/dev/null 2>&1 || . ~/.nvm/nvm.sh
        nvm use "$NODE_VERSION"
    fi
}

use_fnm() {
    if has fnm; then
        FNM_INTERACTIVE_CLI=false fnm use
        PATH_add $HOME/.fnm/current/bin
    else
        tput setaf 1
        echo "'fnm' not installed; see https://github.com/Schniz/fnm"
        tput sgr0
   fi
}
