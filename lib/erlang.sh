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
            echo "Erlang/OTP $OTP_VERSION not available via kerl; using default"
            echo "See http://blog.differentpla.net/blog/2019/01/30/installing-erlang-with-kerl/"
            tput setaf 7
            echo "  kerl build git https://github.com/erlang/otp.git $OTP_VERSION $OTP_VERSION"
            echo "  kerl install $OTP_VERSION $HOME/.kerl/erlangs/$OTP_VERSION"
            tput sgr0
        fi
    else
        tput setaf 1
        echo "kerl not available; using default Erlang"
        echo "See http://blog.differentpla.net/blog/2019/01/30/installing-kerl/"
        tput sgr0
    fi
}
