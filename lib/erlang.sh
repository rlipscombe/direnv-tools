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

# vim:sw=4:sts=4:ts=8:et
