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

# This has to come after 'layout ruby'
use_bundler() {
    if [ -f Gemfile.lock ]; then
        watch_file Gemfile.lock
        bundler_version="$(grep -A1 '^BUNDLED WITH' Gemfile.lock | tail -n 1 | xargs echo)"
        echo "Using bundler $bundler_version"
        gem list -i '^bundler$' -v "$bundler_version" > /dev/null || \
            gem install --no-document bundler -v "$bundler_version"
    fi
    if [ -f Gemfile ]; then
        watch_file Gemfile
        bundle check
    fi
}
