# Check environment
unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*)     machine=linux;;
    Darwin*)    machine=macOS;;
    CYGWIN*)    machine=cygwin;;
    MINGW*)     machine=mingw;;
    *)          machine="UNKNOWN:${unameOut}"
esac
echo "Detected environment: ${machine}"

if [[ $machine == "UNKNOWN"*  ]]; then
    echo "Aborting..."
    exit 1
else
    home=$HOME
fi

# Remove Pathogen and all installed plugins
rm -rf $home/.vim/bundle
rm -rf $home/.vim/autoload

# Delete contents of .vimrc
vimrcFile=$home/.vimrc
if test -f "$vimrcFile"; then
    cp $home/.vimrc $home/.vimrc.backup
    echo "A backup file has been created for the .vimrc file under $home/.vimrc.backup"
fi
: > $home/.vimrc

# Delete fzf
if [[ $machine == "macOS" ]]; then
    brew remove fzf
else
    rm -rf $home/.fzf
    # $home/.fzf/uninstall
fi

echo "Uninstallation complete!"
