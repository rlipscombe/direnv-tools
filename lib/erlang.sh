# shellcheck shell=sh

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

normal="$(tput sgr0)"
red="${normal}$(tput setaf 1)"
red_bold="${normal}$(tput setaf 1; tput bold)"
green="${normal}$(tput setaf 2)"
green_bold="${normal}$(tput setaf 2; tput bold)"
yellow="${normal}$(tput setaf 3)"
yellow_bold="${normal}$(tput setaf 3; tput bold)"
grey="${normal}$(tput setaf 7)"

use_erlang() {
    OTP_VERSION="$1"
    if has kerl; then
        OTP_INSTALLATION=$(kerl list installations | grep "^$OTP_VERSION " | cut -d' ' -f2)
        if [ -s "$OTP_INSTALLATION/activate" ] ; then
            echo "${green}Using Erlang/OTP ${green_bold}$OTP_VERSION${green} (in $OTP_INSTALLATION) via kerl${normal}"
            # shellcheck source=/dev/null
            . "$OTP_INSTALLATION/activate"

            export OTP_ROOT="$OTP_INSTALLATION"
            export OTP_VERSION
        elif has erl; then
            echo "${yellow}Erlang/OTP ${yellow_bold}$OTP_VERSION${yellow} not available via kerl; using default ${yellow_bold}$(erlang_version)${normal}"
            echo "${yellow}See http://blog.differentpla.net/blog/2019/01/30/installing-erlang-with-kerl/${normal}"
            echo "${grey}"
            echo "  kerl build git https://github.com/erlang/otp.git $OTP_VERSION $OTP_VERSION"
            echo "  kerl install $OTP_VERSION $HOME/.kerl/erlangs/$OTP_VERSION"
            echo "${normal}"
        else
            echo "${red}Erlang/OTP ${red_bold}$OTP_VERSION${red} not available via kerl; no default available${normal}"
        fi
    elif has erl; then
        echo "${yellow}kerl not available; using default Erlang/OTP ${yellow_bold}$(erlang_version)${normal}"
        echo "${yellow}See http://blog.differentpla.net/blog/2019/01/30/installing-kerl/${normal}"
    else
        echo "${red}No default Erlang/OTP available${normal}"
    fi
}

use_rebar3() {
    # Rather than download rebar3 every time, we'll check that there's a copy in $XDG_CACHE_HOME:
    XDG_CACHE_HOME=${XDG_CACHE_HOME:-$HOME/.cache}
    REBAR_SOURCE_URL=https://s3.amazonaws.com/rebar3/rebar3
    REBAR_BOOTSTRAP=$XDG_CACHE_HOME/rebar3/tmp/rebar3

    if ! has "$REBAR_BOOTSTRAP"; then
        mkdir -p "$XDG_CACHE_HOME/rebar3/tmp"
        wget -O "$REBAR_BOOTSTRAP" $REBAR_SOURCE_URL
        chmod +x "$REBAR_BOOTSTRAP"
    fi

    # Then we'll use that bootstrap copy to do a per-repo local install, in the same place as we want it to install
    # plugins:
    # We vary the path by OTP version, to ensure that rebar and plugins are compiled against the correct version.
    REBAR_CACHE_DIR=$(pwd)/.direnv/${OTP_VERSION}/rebar3
    export REBAR_CACHE_DIR
    mkdir -p "$REBAR_CACHE_DIR"

    if ! has "$REBAR_CACHE_DIR/bin/rebar3"; then
        mkdir -p "$REBAR_CACHE_DIR/bin"
        REBAR_CONFIG=/dev/null "$REBAR_BOOTSTRAP" local install
    fi

    PATH_add "$REBAR_CACHE_DIR/bin"
}

# vim:sw=4:sts=4:ts=8:et
