## Setup

#### required packages termux

```
apt update -y
apt upgrade -y
apt install x11-repo -y
apt install termux-x11-nightly -y
apt install tur-repo -y
apt install pulseaudio -y
apt install proot-distro -y
apt install wget -y
apt install git -y

```

#### termux dependencies

```
apt install -y arj bat binutils bzip2 cabextract coreutils cpio curl diffutils eza file findutils fzf git grep gzip imagemagick jq less lhasa lzip lzop nala ncompress nodejs openssh openssl p7zip procps python sed tar termux-api unrar unzip vim xz-utils zoxide zsh zstd

```


#### install nerd fonts

```
bash -c  "$(curl -fsSL https://raw.githubusercontent.com/officialrajdeepsingh/nerd-fonts-installer/main/install.sh)"

```

#### install desktop environment

```
apt install -y xfce4 xfce4-appfinder xfce4-battery-plugin xfce4-clipman-plugin xfce4-screenshooter xfce4-whiskermenu-plugin ristretto xfce4-notifyd xfce4-pulseaudio-plugin firefox kitty

```