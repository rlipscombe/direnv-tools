use_python() {
    PYTHON_VERSION="$1"

    PYTHONS_DIR="$HOME/.pyenv/versions"
    PYTHON_PREFIX="$PYTHONS_DIR/$PYTHON_VERSION"
    if [ -s "$PYTHON_PREFIX" ]; then
        load_prefix "$PYTHON_PREFIX"
    else
        tput setaf 1
        echo "Python $PYTHON_VERSION not available; using default"
        echo "See http://blog.differentpla.net/blog/2019/01/30/python-build/"
        tput sgr0
    fi
}
