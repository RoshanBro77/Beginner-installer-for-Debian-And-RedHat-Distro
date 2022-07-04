#! /bin/sh
echo "Type d if you are using debian distro and type r if you are using red hat distro"
read reply
cmd=""
#selecting pkg manager
case $reply in 
    d)
    cmd="apt";;
    r)
    cmd="dnf";;

    *)
    echo "Re run"
esac
echo "$reply"

#universal commands
sudo $cmd update && sudo $cmd upgrade -y
sudo $cmd install vlc gimp kdenlive kwrite neofetch htop radeontop synaptic gparted timeshift redshift

#PkG
echo "Do you want to install gnome tweak tools"
read ans
    if ["$ans" = "y"]; then
        sudo $cmd install gnome-tweak-tool
        gnome-tweak-tool
    elif ["$ans" = "n"];
    then
        echo "Canceled"
    fi


case $reply in
    d)
    cmd="apt"
    sudo apt install ubuntu-restricted-extras
    sudo apt install dconf-editor
    dconf-editor
    echo "Custoimize dconf editor to active minimize Dock"
    echo "Do you want to install numix -circles icons  y or n"
    read ans
    if [$ans=="y"]
    then
        sudo add-apt-repository ppa:numix/ppa
        sudo apt-get update
        sudo apt-get install numix-gtk-theme numix-icon-theme-circle
    elif [$ans=="n"]
    then
        echo "Canceled"
    fi
   cat /proc/sys/vm/swappiness

   echo "Change swappiness in last of the file  vm.swappiness=30"
   sudo nano /etc/sysctl.conf
   echo "Add noatime in ext4 before ,errors=......"
   #reduce ssd writes
   sudo nano /etc/fstab
   echo "Battery Optimization"
   echo "Autocpufreq is recommended if you want to install tlp then enter y else n"
   read ans
   if [$ans=="y"]
   then
        sudo apt install tlp tlp-rdw
        echo "Is your laptop is thinkpad?"
        read ans
        if [$ans=="y"]
        then
            sudo apt install tlp tlp-rdw tp-smapi-dkms acpi-call-dkms
        elif [$ans=="n"]
        then
            echo "Canceled"
        fi
    elif [$ans=="n"]
    then
        echo "Canceled"
    fi
    echo "Do you want to install Autocpufreq? Don't install if you already installed tlp!!"
    read ans
    if [$ans=="y"]
        then
            mkdir Development
            cd Development
            git clone git@github.com:AdnanHodzic/auto-cpufreq.git
            cd auto-cpufreq && sudo ./auto-cpufreq-installer
    elif [$ans=="n"]
    then
        echo "Canceled"
    fi
#Debian based commands
    sudo apt install bleachbit
    sudo apt install software-properties-common
    sudo add-apt-repository ppa:gerardpuig/ppa
    sudo apt update
    sudo apt install ubuntu-cleaner
    sudo apt autoremove && sudo apt autoclean
    echo "Copy auto-cpufreq.confexample file from auto-cpufreq folder in Development to /etc/ and rename as auto-cpufreq.conf after editing it"
    echo "Remainins steps are::"
    echo "  "
    echo " "
    echo "Configure display sound and other user settings "
    echo "Install Java python Gnome extensions if needed go and search things to do after installing ubuntu in youtube."
    echo "search gufw in synaptic and enable firewall"

    ;;
    r)
    #Red hat Based
    cmd="dnf"
    sudo dnf upgrade --refresh
    echo "Add these lines in editor opened now"
    sudo nano /etc/dnf/dnf.conf
    echo "fastestmirror=True"
    echo "max_parallel_downloads=10"
    echo "defaultyes=True"
    sudo dnf update
    sudo dnf install \
  https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
    sudo dnf install \
  https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
    sudo dnf install gstreamer1-plugins-{bad-\*,good-\*,base} gstreamer1-plugin-openh264 gstreamer1-libav --exclude=gstreamer1-plugins-bad-free-devel
    sudo dnf install lame\* --exclude=lame-devel
    sudo dnf group upgrade --with-optional Multimedia
    echo "Do you want to install preload? y or n"
    read ans
    if [$ans==y]
    then
        sudo dnf copr enable elxreno/preload -y && sudo dnf install preload -y
    elif [$ans=="n"]
    then
        echo "Canceled"
    fi
    sudo dnf install chrome-gnome-shell gnome-extensions-app
    sudo dnf copr enable dawid/better_fonts -y
    sudo dnf install fontconfig-font-replacements -y
    sudo dnf install fontconfig-enhanced-defaults -y
    sudo dnf install bleachbit
    echo "Battery Optimization"
   echo "Autocpufreq is recommended if you want to install tlp then enter y else n"
   read ans
    if [$ans=="y"]
    then
        sudo dnf install tlp tlp-rdw
        echo "Is your laptop is thinkpad?"
        read ans
        if [$ans=="y"]
        then
            sudo dnf install tlp tlp-rdw tp-smapi-dkms acpi-call-dkms
        elif [$ans=="n"]
        then
            echo "Canceled"
        fi
    elif [$ans=="n"]
    then
        echo "Canceled"
    fi
    echo "Do you want to install Autocpufreq? Don't install if you already installed tlp!!"
    read ans
    if [$ans=="y"]
        then
            mkdir Developments
            cd Development
            git clone git@github.com:AdnanHodzic/auto-cpufreq.git
            cd auto-cpufreq && sudo ./auto-cpufreq-installer
    elif [$ans=="n"]
    then
        echo "Canceled"
    fi
    echo "Copy auto-cpufreq.confexample file from auto-cpufreq folder in Development to /etc/ and rename as auto-cpufreq.conf after editing it"
    echo "Remainins steps are::"
    echo "  "
    echo " "
    echo "Configure display sound and other user settings "
    echo "Install Java python Gnome extensions if needed go and search things to do after installing fedora in youtube."
    echo "enable firewall"
    echo "You are good to go"
    ;;

    *)
    echo "Re run"
esac





