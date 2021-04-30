use_elixir() {
    ELIXIR_VERSION="$1"
    if has kiex; then
        if [ -s "$HOME/.kiex/elixirs/elixir-$ELIXIR_VERSION.env" ]; then
            tput setaf 2
            echo "Using Elixir $ELIXIR_VERSION via kiex"
            tput sgr0
            . "$HOME/.kiex/elixirs/elixir-$ELIXIR_VERSION.env"
        else
            tput setaf 1
            echo "Elixir $ELIXIR_VERSION not available via kiex; using default"
            echo "See http://blog.differentpla.net/blog/2019/01/30/installing-elixir-with-kiex/"
            tput setaf 7
            echo "  kiex install $ELIXIR_VERSION"
            tput sgr0
        fi
    else
        tput setaf 1
        echo "kiex not available; using default Elixir"
        echo "See http://blog.differentpla.net/blog/2019/01/30/installing-kiex/"
        tput sgr0
    fi
}
