set -e

sudo dnf upgrade --refresh

# util function for optional steps
prompt() {
    read -p "$1 (y/n): " response
    if [[ "$response" == "y" || "$response" == "Y" ]]; then
        return 0 
    else
        return 1
    fi
}

# install fusion repositories
sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
sudo dnf install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

# install packages
sudo dnf install dnf-plugins-core zsh neovim stow git zoxide

# install lazygit
sudo dnf copr enable atim/lazygit
sudo dnf install lazygit

# install oh my zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" 

# install zsh-vi-mode plugin
git clone https://github.com/jeffreytse/zsh-vi-mode ~/.oh-my-zsh/custom/plugins/zsh-vi-mode

# install docker
if prompt "Do you want to install Docker?"; then
    sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
    sudo dnf install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
    sudo systemctl enable docker --now 
    
    sudo usermod -aG docker $USER
fi

# generate new ssh key
ssh-keygen -t ed25519

# git config
git config --global push.autoSetupRemote 1
git config --global rebase.autosquash 1

# setup with graphical interface
if [ "$XDG_SESSION_TYPE" ]; then
    sudo dnf install keepassxc gnome-tweaks 
    sudo dnf install ffmpeg --allowerasing

    # load gnome configs
    dconf load / < scripts/gnome.ini

    # install font
    wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/FiraMono.zip 
    unzip FiraMono.zip -d ~/.fonts
    rm FiraMono.zip
    fc-cache -fv
    wget https://extensions.gnome.org/extension-data/tactilelundal.io.v34.shell-extension.zip
    gnome-extensions install tactilelundal.io.v34.shell-extension.zip
    rm tactilelundal.io.v34.shell-extension.zip
fi

stow .

