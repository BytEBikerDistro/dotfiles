## Setup

#### required packages termux

```bash
apt update -y
apt upgrade -y
apt install x11-repo -y
apt install termux-x11-nightly -y
apt install tur-repo -y
apt install pulseaudio -y
apt install proot-distro -y
apt install wget -y
apt install git -y
apt install termux-api -y
termux-wake-lock
termux-setup-storage
```

#### termux dependencies

```bash
apt install -y arj bat binutils bzip2 cabextract coreutils cpio curl dconf-editor diffutils dialog evince eza fd file findutils fzf git gnome-themes-extra grep gzip imagemagick jq less lhasa lzip lzop make nala ncompress nodejs openssh openssl p7zip procps python python-pip ripgrep sed tar unrar unzip uuid-utils neovim xz-utils zellij zoxide zsh zstd
```

#### install gogh color schemes

```bash
bash -c "$(wget -qO- https://git.io/vQgMr)"
```

#### install nerd fonts

```bash
bash -c  "$(curl -fsSL https://raw.githubusercontent.com/officialrajdeepsingh/nerd-fonts-installer/main/install.sh)"
```

#### install desktop environment

##### basic base

```bash
apt install -y xfce4 xfce4-appfinder xfce4-whiskermenu-plugin ristretto xfce4-pulseaudio-plugin firefox
```

##### with some useful plugins

```bash
apt install -y xfce4 xfce4-appfinder xfce4-battery-plugin xfce4-clipman-plugin xfce4-screenshooter xfce4-whiskermenu-plugin ristretto xfce4-notifyd xfce4-pulseaudio-plugin firefox
```


#### debian dependencies

```bash
sudo apt install -y arj bat binutils bzip2 cabextract coreutils cpio curl dconf-cli diffutils dialog evince eza file findutils fzf git gnome-keyring gnome-keysign grep gzip imagemagick jq less lhasa lzip lzop nala ncompress nodejs openssl p7zip procps python3 python3-pip ripgrep sed tar unace unrar-free unzip uuid-runtime neovim xz-utils xdg-utils zellij zoxide zsh zstd
```

#### install libreoffice in debian

```bash
sudo apt install libreoffice-writer libreoffice-calc libreoffice-impress
```
