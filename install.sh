#!/usr/bin/env bash

show_help()
{
    echo "Usage: $0 [mode]"
    echo -e "Where mode is: \n"
    echo -e "\tupdate : Update all configurations"
    echo -e "\tos : Install os-spec packages"
}

os()
{
    if [[ "$OSTYPE" == "linux-gnu" ]]; then
        confirm "Installing base packages for debian. Are you Sure? [y/N] " && debian
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        confirm "Installing base packages for OS. Are you Sure? [y/N] " && osx
    else
        echo "What OS are you using?"
    fi
}

confirm() {
    read -r -p "${1:-Are you sure? [y/N]} " response
    case "$response" in
        [yY][eE][sS]|[yY]) 
            true
            ;;
        *)
            false
            ;;
    esac
}

debian()
{
    cat os-spec/debian/general.apt.packages | xargs sudo apt-get install
}

osx()
{
    echo "TBD"
}

update()
{
    for DIR in `find ./configs -type d`
    do
        if [ -f "$DIR/install.sh" ]; then
            echo -e "Running installer for $DIR\n"
            "$DIR/install.sh"
        fi
    done
}

if [ "$1" = "" ]; then
    show_help
else
    $1
fi

exit 0