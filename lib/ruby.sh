use_ruby() {
    RUBY_VERSION="$1"

    RUBIES_DIR="$HOME/.rubies"
    RUBY_PREFIX="$RUBIES_DIR/ruby-$RUBY_VERSION"
    if [ -s "$RUBY_PREFIX" ]; then
        load_prefix "$RUBY_PREFIX"
        tput setaf 2
        echo "Using Ruby $RUBY_VERSION (in $RUBY_PREFIX)"
        tput sgr0
    else
        tput setaf 1
        echo "Ruby $RUBY_VERSION not available; using default"
        echo "See http://blog.differentpla.net/blog/2019/01/30/ruby-install/"
        tput sgr0
    fi

    # TODO: If relevant, remind the user to do the following:
    # gem install bundler && bundle install
}

bundle_check() {
    # This has to come after 'layout ruby'
    if [ -f Gemfile ]; then
        gem list -i '^bundler$' >/dev/null || \
            gem install --no-ri --no-rdoc bundler && \
            bundle check
    fi
}
