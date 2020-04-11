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


# Install/Setup Pathogen
mkdir -p $home/.vim/autoload $home/.vim/bundle
curl -LSso $home/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

# Copy the included .vimrc to the $HOME directory
vimrcFile=$home/.vimrc
if test -f "$vimrcFile"; then
    echo ".vimrc file already exists! Backing up..."
    cp $home/.vimrc $home/.vimrc.backup.old
    echo "Existing .vimrc file was backed up under $home/.vimrc.backup.old"
fi
cp ./vimrc.txt $home/.vimrc

# Start installing plugins

# lightline.vim
git clone https://github.com/itchyny/lightline.vim $home/.vim/bundle/lightline.vim

# auto-pairs
git clone git://github.com/jiangmiao/auto-pairs.git $home/.vim/bundle/auto-pairs

# vim-surround
git clone https://github.com/tpope/vim-surround $home/.vim/bundle/vim-surround

# commentary.vim
git clone https://github.com/tpope/vim-commentary $home/.vim/bundle/vim-commentary

# nerdtree
git clone https://github.com/preservim/nerdtree.git $home/.vim/bundle/nerdtree

# vim-gitgutter
git clone https://github.com/airblade/vim-gitgutter.git $home/.vim/bundle/vim-gitgutter

# fzf
if [[ $machine == "macOS" ]]; then
    brew install fzf
    echo "set rtp+=/usr/local/opt/fzf" >> $home/.vimrc
else
    git clone --depth 1 https://github.com/junegunn/fzf.git $home/.fzf
    $home/.fzf/install --bin
    echo "set rtp+=~/.fzf" >> $home/.vimrc
fi

# animate.vim
git clone https://github.com/camspiers/animate.vim $home/.vim/bundle/vim-animate

# lens.vim
git clone https://github.com/camspiers/lens.vim $home/.vim/bundle/vim-lens

echo "Installation complete!"
