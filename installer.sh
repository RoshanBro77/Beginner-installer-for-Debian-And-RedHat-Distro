#! /bin/bash
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
    echo "Re run";;
esac
echo "$reply"

#universal commands
sudo $cmd update && sudo $cmd upgrade -y
sudo $cmd install vlc gimp kdenlive neofetch htop radeontop gparted timeshift redshift-gtk

#PkG
echo "Do you want to install gnome tweak tools"
read ans
case $ans in
    y)
        sudo $cmd install gnome-tweak-tool
        echo "Open tweaks and customize according to your taste"
    ;;
    
    n)
        echo "Canceled"
    ;;
    *)
        echo "Something went wrong"
    ;;
esac



case $reply in
    d)
        cmd="apt"
        sudo $cmd install ubuntu-restricted-extras
        sudo $cmd install dconf-editor
        
        echo "Do you want to install numix -circles icons  y or n"
        read ans
        case $ans in
            y)
                sudo add-apt-repository ppa:numix/ppa
                sudo $cmd update
                sudo $cmd install numix-gtk-theme numix-icon-theme-circle
            ;;
            n)
                echo "Canceled"
            ;;
            *)
                echo "Something went wrong"
            ;;
            
        esac
        
        cat /proc/sys/vm/swappiness
        
        echo "Change swappiness in end of the file  vm.swappiness=30"
        sudo nano /etc/sysctl.conf
        echo "Add noatime in ext4 before ,errors=...... or subvol"
        echo "Click enter to proceed"
        read tmp
        #reduce ssd writes
        sudo nano /etc/fstab
        echo "Battery Optimization"
        echo "Autocpufreq is recommended if your laptop is not thinkpad "
        echo"lets proceed"
        read ans
        
        case $ans in
            y)
                
                echo "Is your laptop is thinkpad?"
                read reply
                case $reply in
                    y)
                        sudo apt install tlp tlp-rdw tp-smapi-dkms acpi-call-dkms
                    ;;
                    n)
                        echo "It is not thinkpad"
                        echo "Installed tlp"
                        sudo apt install tlp tlp-rdw
                    ;;
                    *)
                        echo "Something went wrong"
                    ;;
                esac
            ;;
            
            n)
                echo "Canceled"
            ;;
            *)
            ;;
        esac
        
        echo "Do you want to install Autocpufreq? Don't install if you already installed tlp!!"
        read ans
        case $ans in
            y)
                
                mkdir src
                cd src
                git clone git@github.com:AdnanHodzic/auto-cpufreq.git
                cd auto-cpufreq && sudo ./auto-cpufreq-installer
            ;;
            n)
                echo "Canceled"
            ;;
            *)
            ;;
        esac
        #Debian based commands
        sudo apt install bleachbit
        sudo apt install software-properties-common
        sudo add-apt-repository ppa:gerardpuig/ppa
        sudo apt update
        echo"Installing ubuntu-cleaner"
        sudo apt install ubuntu-cleaner
        sudo apt autoremove && sudo apt autoclean
        echo "Remainins steps are::"
        echo "  "
        echo "  "
        echo "Configure display sound and other user settings "
        echo "Install Java python Gnome extensions if needed go and search things to do after installing ubuntu in youtube."
        sudo apt install gufw
        echo "Enable firewall"
        
        
    ;;
    r)
        #Red hat Based
        cmd="dnf"
        sudo dnf upgrade --refresh
        echo "Add these lines in editor opened now"
        echo ""
        echo " "
        echo "fastestmirror=True"
        echo "max_parallel_downloads=10"
        echo "defaultyes=True"
        echo "keepcache=True"
        echo ""
        echo "copy lines from above to text editor"
        echo "Paste them in window which will pop up and then"
        echo "Enter 'crtl' and 'o' at the same time and press  'X' after pasting them"
        echo "click any button if you are ready to paste them"
        read tmp
        sudo nano /etc/dnf/dnf.conf
        sudo dnf clean dbcache
        sudo dnf update
        
        sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
        sudo dnf groupupdate core
        sudo dnf install gstreamer1-plugins-{bad-\*,good-\*,base} gstreamer1-plugin-openh264 gstreamer1-libav --exclude=gstreamer1-plugins-bad-free-devel
        sudo dnf install lame\* --exclude=lame-devel
        sudo dnf group upgrade --with-optional Multimedia
        sudo dnf groupupdate multimedia --setop="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin
        sudo dnf groupupdate sound-and-video
        echo "Do you want to install preload? y or n (recommended if ram is more than 8 GB)"
        read ans
        case $ans in
            y)
                sudo dnf copr enable elxreno/preload -y && sudo dnf install preload -y
            ;;
            n)
                echo "Canceled"
            ;;
            *)
            ;;
        esac
        
        sudo dnf install chrome-gnome-shell gnome-extensions-app
        sudo dnf copr enable dawid/better_fonts -y
        sudo dnf install fontconfig-font-replacements -y --skip-broken
        sudo dnf install fontconfig-enhanced-defaults -y --skip-broken
        sudo dnf install bleachbit
        echo "Battery Optimization"
        
        echo "Do you want to install Autocpufreq? (Don't install if you have already installed tlp!!)"
        read ans
        case $ans in
            y)
                
                mkdir src
                cd src
                git clone git@github.com:AdnanHodzic/auto-cpufreq.git
                cd auto-cpufreq && sudo ./auto-cpufreq-installer
            ;;
            n)
                echo "Canceled"
            ;;
            *)
            ;;
        esac
        echo "If you didn't installed autocpufreq but if you want install tlp then enter y else n (Autocpufreq is recommended)"
        read ans
        case $ans in
            y)
                
                echo "Is your laptop is thinkpad?"
                read ans
                case $ans in
                    y)
                        sudo dnf install tlp tlp-rdw tp-smapi-dkms acpi-call-dkms
                    ;;
                    n)
                        
                        sudo dnf install tlp tlp-rdw
                        echo "Canceled"
                        echo "Installed tlp"
                    ;;
                    *)
                    ;;
                esac
            ;;
            
            n)
                echo "Canceled"
            ;;
            *)
            ;;
        esac
        echo "Remainins steps are::"
        echo "  "
        echo " "
        echo "Configure display sound and other user settings "
        echo "Install Java python Gnome extensions if needed go and search things to do after installing fedora in youtube."
        echo "Install required apps from software store"
        echo "Install and enable firewall"
        echo "Custoimize dconf editor to active minimize Dock"
        echo "You are good to go"
    ;;
    
    *)
        echo "choose small d or r "
    ;;
esac





