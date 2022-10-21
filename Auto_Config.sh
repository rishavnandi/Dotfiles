#!/bin/bash

echo "
███████╗████████╗ █████╗ ██████╗ ███████╗██╗  ██╗██╗██████╗     ██████╗ ██████╗  ██████╗ ███╗   ███╗██████╗ ████████╗
██╔════╝╚══██╔══╝██╔══██╗██╔══██╗██╔════╝██║  ██║██║██╔══██╗    ██╔══██╗██╔══██╗██╔═══██╗████╗ ████║██╔══██╗╚══██╔══╝
███████╗   ██║   ███████║██████╔╝███████╗███████║██║██████╔╝    ██████╔╝██████╔╝██║   ██║██╔████╔██║██████╔╝   ██║   
╚════██║   ██║   ██╔══██║██╔══██╗╚════██║██╔══██║██║██╔═══╝     ██╔═══╝ ██╔══██╗██║   ██║██║╚██╔╝██║██╔═══╝    ██║   
███████║   ██║   ██║  ██║██║  ██║███████║██║  ██║██║██║         ██║     ██║  ██║╚██████╔╝██║ ╚═╝ ██║██║        ██║   
╚══════╝   ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚═╝╚═╝         ╚═╝     ╚═╝  ╚═╝ ╚═════╝ ╚═╝     ╚═╝╚═╝        ╚═╝   

 █████╗ ██╗   ██╗████████╗ ██████╗     ██╗███╗   ██╗███████╗████████╗ █████╗ ██╗     ██╗                             
██╔══██╗██║   ██║╚══██╔══╝██╔═══██╗    ██║████╗  ██║██╔════╝╚══██╔══╝██╔══██╗██║     ██║                             
███████║██║   ██║   ██║   ██║   ██║    ██║██╔██╗ ██║███████╗   ██║   ███████║██║     ██║                             
██╔══██║██║   ██║   ██║   ██║   ██║    ██║██║╚██╗██║╚════██║   ██║   ██╔══██║██║     ██║                             
██║  ██║╚██████╔╝   ██║   ╚██████╔╝    ██║██║ ╚████║███████║   ██║   ██║  ██║███████╗███████╗                        
╚═╝  ╚═╝ ╚═════╝    ╚═╝    ╚═════╝     ╚═╝╚═╝  ╚═══╝╚══════╝   ╚═╝   ╚═╝  ╚═╝╚══════╝╚══════╝"

echo "----------------https://github.com/rishavnandi/Dotfiles----------------"

echo "----------------Setup Common Software----------------"
sudo apt update && sudo apt upgrade -y
sudo apt install build-essential software-properties-common neovim neofetch git curl wget -y

echo "----------------Setup Bashrc----------------"
echo "----------------Enter Unix Username----------------"
read user
cat bashrc > /home/$user/.bashrc
sudo apt install dos2unix
dos2unix /home/$user/.bashrc
echo "----------------Disable Directory Highlights----------------"
dircolors -p | sed 's/;42/;01/' > /home/$user/.dircolors

echo "----------------Setup Starship For Bash----------------"
curl -sS https://starship.rs/install.sh | sh
if [ -d "/home/$user/.config/" ] 
then
    cat linux_starship.toml > /home/$user/.config/starship.toml 
else
    mkdir /home/$user/.config/ && cat linux_starship.toml > /home/$user/.config/starship.toml
fi

echo "----------------Setup PowerShell Profile----------------"
echo "----------------Enter Windows Username----------------"
read username
if [ -d "/mnt/c/Users/$username/Documents/WindowsPowerShell/" ] 
then
    cat ps_profile.ps1 > /mnt/c/Users/$username/Documents/PowerShell/Microsoft.PowerShell_profile.ps1
else
    mkdir /mnt/c/Users/$username/Documents/WindowsPowerShell/ && cat ps_profile.ps1 > /mnt/c/Users/$username/Documents/WindowsPowerShell/Microsoft.PowerShell_profile.ps1
fi

if [ -d "/mnt/c/Users/$username/.starship/" ]
then
    cat win_starship.toml > /mnt/c/Users/$username/.starship/starship.toml
else
    mkdir /mnt/c/Users/$username/.starship/ && cat win_starship.toml > /mnt/c/Users/$username/.starship/starship.toml
fi

if [ -d "/mnt/c/Users/$username/.config/winfetch/" ]
then
    cat winfetch.ps1 > /mnt/c/Users/$username/.config/winfetch/config.ps1
else
    mkdir /mnt/c/Users/$username/.config/winfetch/ && cat winfetch.ps1 > /mnt/c/Users/$username/.config/winfetch/config.ps1
fi

echo "----------------Setup Command Prompt----------------"
cat starship.lua > /mnt/c/Users/$username/AppData/Local/clink/starship.lua

echo "----------------Setup Windows Terminal----------------"
terminal_folder=$(ls | grep Terminal)
cat settings.json > /mnt/c/Users/$username/AppData/Local/Packages/$terminal_folder/LocalState/settings.json

echo "----------------Download QuickLook Plugins----------------"
cd /mnt/c/Users/$username/Downloads/
wget https://github.com/QL-Win/QuickLook.Plugin.EpubViewer/releases/download/1/QuickLook.Plugin.EpubViewer.qlplugin
wget https://github.com/QL-Win/QuickLook.Plugin.OfficeViewer/releases/download/4/QuickLook.Plugin.OfficeViewer.qlplugin
wget https://github.com/canheo136/QuickLook.Plugin.ApkViewer/releases/download/1.3.4/QuickLook.Plugin.ApkViewer.qlplugin
wget https://github.com/adyanth/QuickLook.Plugin.FolderViewer/releases/download/1.3/QuickLook.Plugin.FolderViewer.qlplugin
wget https://github.com/Cologler/QuickLook.Plugin.TorrentViewer/releases/download/0.1.0/QuickLook.Plugin.TorrentViewer.qlplugin
wget https://github.com/zhangkaihua88/QuickLook.Plugin.JupyterNotebookViewer/releases/download/1.0.1/QuickLook.Plugin.JupyterNotebookViewer.qlplugin

echo "----------------Download dotnet----------------"
wget -O runtime-desktop-6.0.10.exe https://dotnet.microsoft.com/en-us/download/dotnet/thank-you/runtime-desktop-6.0.10-windows-x64-installer

echo "----------------Download directx----------------"
wget https://download.microsoft.com/download/1/7/1/1718CCC4-6315-4D8E-9543-8E28A4E18C4C/dxwebsetup.exe

echo "----------------Download FxSound----------------"
wget -O fxsound.exe https://download.fxsound.com/fxsoundlatest

echo "----------------Setup lsd For Ubuntu----------------"
cd /home/$user/
wget https://github.com/Peltoche/lsd/releases/download/0.23.1/lsd_0.23.1_amd64.deb
sudo apt install ./lsd_0.23.1_amd64.deb -y
rm lsd_0.23.1_amd64.deb

echo "----------------Setup Vagrant For Ubuntu----------------"
cd /home/$user/
wget https://releases.hashicorp.com/vagrant/2.3.2/vagrant_2.3.2-1_amd64.deb
sudo apt install ./vagrant_2.3.2-1_amd64.deb -y
rm vagrant_2.3.2-1_amd64.deb
vagrant plugin install virtualbox_WSL2
vagrant plugin install vagrant-vbguest
vagrant autocomplete install --bash

echo "----------------Setup Terraform For Ubuntu----------------"
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common 
wget -O- https://apt.releases.hashicorp.com/gpg | \
    gpg --dearmor | \
    sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
    https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
    sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update
sudo apt install terraform -y
terraform -install-autocomplete

echo "----------------Setup pip----------------"
sudo apt install python3-pip -y

echo "----------------Setup Ansible----------------"
pip3 install ansible
pip3 install ansible-lint

echo "----------------Enable hushlogin----------------"
touch /home/$user/.hushlogin

echo "----------------Setup Git----------------"
echo "----------------Enter First Name----------------"
read first
echo "----------------Enter Last Name----------------"
read last
echo "----------------Enter GitHub Email----------------"
read gitemail
git config --global user.name "$first $last"
git config --global user.email "$gitemail"
