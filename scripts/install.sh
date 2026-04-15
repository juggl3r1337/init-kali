#!/bin/sh

# run this as kali from above init-kali repo, probably /home/kali, script makes a catchall misc dir to trash
mkdir misc
cd misc

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
bash ../init-kali/scripts/prepareTools.sh

# install rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
. "$HOME/.cargo/env"

# install alacritty
git clone https://github.com/alacritty/alacritty.git
cd alacritty
rustup override set stable
rustup update stable
sudo apt install -y cmake g++ pkg-config libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev python3 gzip scdoc
cargo build --release
sudo cp target/release/alacritty /usr/local/bin # or anywhere else in $PATH
sudo cp extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg
sudo desktop-file-install extra/linux/Alacritty.desktop
sudo update-desktop-database
sudo mkdir -p /usr/local/share/man/man1
sudo mkdir -p /usr/local/share/man/man5
scdoc < extra/man/alacritty.1.scd | gzip -c | sudo tee /usr/local/share/man/man1/alacritty.1.gz > /dev/null
scdoc < extra/man/alacritty-msg.1.scd | gzip -c | sudo tee /usr/local/share/man/man1/alacritty-msg.1.gz > /dev/null
scdoc < extra/man/alacritty.5.scd | gzip -c | sudo tee /usr/local/share/man/man5/alacritty.5.gz > /dev/null
scdoc < extra/man/alacritty-bindings.5.scd | gzip -c | sudo tee /usr/local/share/man/man5/alacritty-bindings.5.gz > /dev/null
mkdir -p ${ZDOTDIR:-~}/.zsh_functions
echo 'fpath+=${ZDOTDIR:-~}/.zsh_functions' >> ${ZDOTDIR:-~}/.zshrc
cp extra/completions/_alacritty ${ZDOTDIR:-~}/.zsh_functions/_alacritty

cd ..

# install zellij
TMPDIR=~/tmp cargo install --locked zellij

## move zellij files to system
cp -r ../init-kali/zellij/. $HOME/.config/zellij/

## install ohmyszh
### still need to pull ohmyzsh config in
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# install zshrc with customized prompt and aliases
cp ../init-kali/zsh/.zshrc $HOME/

# move over scripts for aliases
mkdir ~/.scripts
cp ../init-kali/aliases/logme.sh ../init-kali/aliases/dirmaker.sh ~/.scripts/

## what about any microservices
## and what about any llm tools

## firefox bookmarks for my hacking stuff would be great too

# reminder to make SSH key and clone obsidian vault:
echo "make SSH key and clone obsidian vault and blade runner"
echo 'ssh-keygen -t ed25519 -C "your_email@example.com"'
echo 'eval "$(ssh-agent -s)"'
echo 'ssh-add ~/.ssh/id_ed25519'
echo 'cat ~/.ssh/id_ed25519.pub'
echo 'add to github keys'
echo 'ssh -T git@github.com'
echo 'git config --global user.name "juggl3r"'
echo 'git config --global user.email "juggl3r1337@proton.me"'

while [ "$input" != "ready" ]; do
	read -p "Type 'ready' to continue: " input
done

# download vault
git clone git@github.com:juggl3r1337/hack-vault.git
mkdir -p hack-vault/.obsidian/plugins

# download blade runner for obsidian, move to vault and install
git clone git@github.com:juggl3r1337/blade-runner-obsidian.git
cp -r blade-runner-obsidian/ hack-vault/.obsidian/plugins/
cd hack-vault/.obsidian/plugins/blade-runner-obsidian/
npm install
cd ../../../../

# download blade runner for zellij and build WASM
# need to automate deployment still
git clone git@github.com:juggl3r1337/blade-runner-zellij.git
cd blade-runner-zellij/
rustup target add wasm32-wasip1
cargo build --target wasm32-wasip1 --release
cd ..
echo 'manually add blade runner to zellij now'


echo '/n'

echo '--___---- kali initialized --___----'

