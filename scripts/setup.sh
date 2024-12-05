sudo dnf upgrade --refresh

# install fusion repositories
sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
sudo dnf install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

# install packages
sudo dnf install dnf-plugins-core keepassxc gnome-tweaks zsh vim neovim stow
sudo dnf install ffmpeg --allowerasing

# install lazygit
sudo dnf copr enable atim/lazygit
sudo dnf install lazygit

# install oh my zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" 

# install zsh-vi-mode plugin
git clone https://github.com/jeffreytse/zsh-vi-mode $ZSH_CUSTOM/plugins/zsh-vi-mode

# install docker
sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
sudo dnf install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo systemctl enable docker --now 

sudo usermod -aG docker $USER

# generate new ssh key
ssh-keygen -t ed25519

# load gnome configs
dconf load / < scripts/gnome.ini

# install font
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/FiraMono.zip 
unzip FiraMono.zip -d ~/.fonts
rm FiraMono.zip
fc-cache -fv

# git config
git config --global push.autoSetupRemote 1
git config --global rebase.autosquash 1

# install configs
stow .

