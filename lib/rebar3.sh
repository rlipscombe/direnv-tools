erlang_version() {
    erl -noshell -eval '
        VersionFile = filename:join([
            code:root_dir(),
            "releases",
            erlang:system_info(otp_release),
            "OTP_VERSION"]),
        {ok, Version} = file:read_file(VersionFile),
        io:format("~s", [Version]),
        halt().'
}

use_rebar3() {
    # Rather than download rebar3 every time, we'll check that there's a copy in $XDG_CACHE_HOME:
    XDG_CACHE_HOME=${XDG_CACHE_HOME:-$HOME/.cache}
    REBAR_VERSION="${1:-3.25.1}"
    REBAR_SOURCE_URL=https://github.com/erlang/rebar3/releases/download/$REBAR_VERSION/rebar3
    REBAR_BOOTSTRAP_DIR=$XDG_CACHE_HOME/rebar3/bootstrap/${REBAR_VERSION}-$(erlang_version)
    REBAR_BOOTSTRAP=${REBAR_BOOTSTRAP_DIR}/rebar3

    if ! has "$REBAR_BOOTSTRAP"; then
        mkdir -p "$REBAR_BOOTSTRAP_DIR"
        echo "Fetching $REBAR_SOURCE_URL..."
        wget -O "$REBAR_BOOTSTRAP" $REBAR_SOURCE_URL
        chmod +x "$REBAR_BOOTSTRAP"
    fi

    # Then we'll use that bootstrap copy to do a per-repo local install, in the same place as we want it to install
    # plugins:
    # We vary the path by OTP version, to ensure that rebar and plugins are compiled against the correct version.
    REBAR_CACHE_DIR=$(pwd)/.direnv/$(erlang_version)/rebar3
    mkdir -p "$REBAR_CACHE_DIR"
    export REBAR_CACHE_DIR

    echo 'rebar3' > "$(pwd)/.direnv/$(erlang_version)/.gitignore"

    if ! has "$REBAR_CACHE_DIR/bin/rebar3"; then
        mkdir -p "$REBAR_CACHE_DIR/bin"
        echo "Bootstrapping rebar3 from $REBAR_BOOTSTRAP to $REBAR_CACHE_DIR/bin/rebar3..."
        REBAR_CONFIG=/dev/null "$REBAR_BOOTSTRAP" local install
        REBAR_CONFIG=/dev/null "$REBAR_CACHE_DIR/bin/rebar3" version
    fi

    PATH_add "$REBAR_CACHE_DIR/bin"
}

# vim:sw=4:sts=4:ts=8:et
