#!/bin/sh

# run this as kali from above init-kali repo

# update first
sudo apt-get update -y && sudo apt-get full-upgrade -y && sudo apt-get dist-upgrade -y && sudo apt autoremove -y && sudo apt autoclean

# to prevent screen from locking/blanking
xset s off
xset -dpms
xset s noblank

# clone init-kali repo
#git clone https://github.com/juggl3r1337/init-kali.git

# change wallpaper (didn't work)
# xfconf-query --channel xfce4-desktop --property /backdrop/screen0/monitor0/workspace0/last-image --set ./init-kali/resources/kali.png

# install some tools via prepareTools.sh
zsh ./init-kali/scripts/prepareTools.sh

# install rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
. "$HOME/.cargo/env"

# install alacritty
git clone https://github.com/alacritty/alacritty.git
cd alacritty
rustup override set stable
rustup update stable
apt install -y cmake g++ pkg-config libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev python3 gzip scdoc
cargo build --release
sudo cp target/release/alacritty /usr/local/bin # or anywhere else in $PATH
sudo cp extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg
sudo desktop-file-install extra/linux/Alacritty.desktop
sudo update-desktop-database
mkdir -p /usr/local/share/man/man1
mkdir -p /usr/local/share/man/man5
scdoc < extra/man/alacritty.1.scd | gzip -c | sudo tee /usr/local/share/man/man1/alacritty.1.gz > /dev/null
scdoc < extra/man/alacritty-msg.1.scd | gzip -c | sudo tee /usr/local/share/man/man1/alacritty-msg.1.gz > /dev/null
scdoc < extra/man/alacritty.5.scd | gzip -c | sudo tee /usr/local/share/man/man5/alacritty.5.gz > /dev/null
scdoc < extra/man/alacritty-bindings.5.scd | gzip -c | sudo tee /usr/local/share/man/man5/alacritty-bindings.5.gz > /dev/null
mkdir -p ${ZDOTDIR:-~}/.zsh_functions
echo 'fpath+=${ZDOTDIR:-~}/.zsh_functions' >> ${ZDOTDIR:-~}/.zshrc
cp extra/completions/_alacritty ${ZDOTDIR:-~}/.zsh_functions/_alacritty

cd ..

# install zellij
cargo install --locked zellij
## need to add this to path after

# install other apt tools
sudo apt install -y obsidian tor torbrowser-launcher

# write aliases
mkdir ~/.scripts
cp ./init-kali/aliases/logme.sh ./init-kali/aliases/dirmaker.sh ~/.scripts/
echo 'alias logme="~/.scripts/logme.sh"' >> ~/.zshrc
echo 'alias htb-mkdir="~/.scripts/dirmaker.sh"' >> ~/.zshrc

# for now, manually go change ZSH prompt to include timestamp using ` -[%D{%m\/%d}-%*] `

## install ohmyszh
### still need to pull ohmyzsh config in
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

## i think ohmyzsh config and zellij files are outstanding TODO, as well as ohmyzsh prompt/theme
## what about any microservices
## and what about any llm tools

## firefox bookmarks for my hacking stuff would be great too


