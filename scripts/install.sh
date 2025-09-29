#!/bin/sh

# update first
apt-get update -y && apt-get full-upgrade -y && apt-get dist-upgrade -y && apt autoremove -y && apt autoclean

# to prevent screen from locking/blanking
xset s off
xset -dpms
xset s noblank

# clone init-kali repo
git clone https://github.com/juggl3r1337/init-kali.git

# change wallpaper
xfconf-query --channel xfce4-desktop --property /backdrop/screen0/monitorVirtual1/workspace0/last-image --set ./init-kali/resources/kali.png

# install some tools via prepareTools.sh
zsh ./init-kali/scripts/prepareTools.sh

# install rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# install alacritty
rustup override set stable
rustup update stable
apt install -y cmake g++ pkg-config libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev python3 gzip scdoc
cargo build --release
cp target/release/alacritty /usr/local/bin # or anywhere else in $PATH
cp extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg
desktop-file-install extra/linux/Alacritty.desktop
update-desktop-database
mkdir -p /usr/local/share/man/man1
mkdir -p /usr/local/share/man/man5
scdoc < extra/man/alacritty.1.scd | gzip -c | sudo tee /usr/local/share/man/man1/alacritty.1.gz > /dev/null
scdoc < extra/man/alacritty-msg.1.scd | gzip -c | sudo tee /usr/local/share/man/man1/alacritty-msg.1.gz > /dev/null
scdoc < extra/man/alacritty.5.scd | gzip -c | sudo tee /usr/local/share/man/man5/alacritty.5.gz > /dev/null
scdoc < extra/man/alacritty-bindings.5.scd | gzip -c | sudo tee /usr/local/share/man/man5/alacritty-bindings.5.gz > /dev/null
mkdir -p ${ZDOTDIR:-~}/.zsh_functions
echo 'fpath+=${ZDOTDIR:-~}/.zsh_functions' >> ${ZDOTDIR:-~}/.zshrc
cp extra/completions/_alacritty ${ZDOTDIR:-~}/.zsh_functions/_alacritty

# install zellij
cargo install --locked zellij

# install other apt tools
apt install -y obsidian tor torbrowser-launcher

# write aliases
mkdir ~/.scripts
cp ./init-kali/scripts/logme.sh ./init-kali/scripts/dirmaker.sh ~/.scripts/
echo 'alias logme="~/.scripts/logme.sh"' >> ~/.zshrc
echo 'alias htb-mkdir="~/.scripts/dirmaker.sh"' >> ~/.zshrc

# for now, manually go change ZSH prompt to include timestamp using ` -[%D{%m\/%d}-%*] `


