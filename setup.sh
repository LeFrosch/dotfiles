sudo dnf upgrade --refresh
sudo dnf -y install dnf-plugins-core
sudo dnf install keepassxc gnome-tweaks zsh vim

# install oh my zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" 

# install zsh-vi-mode plugin
git clone https://github.com/jeffreytse/zsh-vi-mode $ZSH_CUSTOM/plugins/zsh-vi-mode

# generate new ssh key
ssh-keygen -t ed25519
cat .ssh/id_ed25519.pub

# fetch dot files
git init
git remote add origin https://github.com/LeFrosch/dotfiles.git
git fetch --all
git reset --hard origin/main
rm -rf .git

# install docker
sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
sudo dnf install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo systemctl enable docker --now 

sudo usermod -aG docker $USER

// disable on laptop - causes freezes
// sudo rmmod intel_rapl_msr
