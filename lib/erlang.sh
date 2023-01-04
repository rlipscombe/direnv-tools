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

use_erlang() {
    OTP_VERSION="$1"
    if has kerl; then
        OTP_INSTALLATION=$(kerl list installations | grep "^$OTP_VERSION " | cut -d' ' -f2)
        if [ -s "$OTP_INSTALLATION/activate" ] ; then
            tput setaf 2
            echo "Using Erlang/OTP $OTP_VERSION (in $OTP_INSTALLATION) via kerl"
            tput sgr0
            . "$OTP_INSTALLATION/activate"

            export OTP_ROOT="$OTP_INSTALLATION"
            export OTP_VERSION
        else
            tput setaf 1
            echo "$(tput setaf 1)Erlang/OTP $(tput bold)$OTP_VERSION$(tput sgr0; tput setaf 1) not available via kerl; using default $(tput bold)$(erlang_version)$(tput sgr0; tput setaf 1)"
            echo "See http://blog.differentpla.net/blog/2019/01/30/installing-erlang-with-kerl/"
            tput setaf 7
            echo "  kerl build git https://github.com/erlang/otp.git $OTP_VERSION $OTP_VERSION"
            echo "  kerl install $OTP_VERSION $HOME/.kerl/erlangs/$OTP_VERSION"
            tput sgr0
        fi
    else
        tput setaf 1
        echo "kerl not available; using default $(tput bold)$(erlang_version)$(tput sgr0; tput setaf 1)"
        echo "See http://blog.differentpla.net/blog/2019/01/30/installing-kerl/"
        tput sgr0
    fi
}

# vim:sw=4:sts=4:ts=8:et
