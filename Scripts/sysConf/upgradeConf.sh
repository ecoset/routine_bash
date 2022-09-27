#!/bin/bash

upg=~/upg
sheb=#!/bin/bash
os=/etc/os-release
chmod="chmod 700"

upg() {
    if ! [ -f /bin/upg ]
    then
        if (grep debian $os)
            then
                echo "Running script for Debian architecture"
                sleep 1
                inst="sudo apt"
                touch $upg
                echo $sheb > $upg
                echo "" >> $upg
                echo "$inst update" >> $upg
                echo "$inst dist-upgrade -y" >> $upg
                echo "$inst autoremove -y" >> $upg
                echo "$inst autoclean -y" >> $upg
                echo "$inst clean -y" >> $upg
                $chmod $upg
                sudo mv $upg /bin/upg
            elif (grep arch $os)
                then
                    echo "Running script for Arch architecture"
                    sleep 1
                    inst="sudo pacman"
                    yes | $inst -Syu
                    yes | $inst -S yay
                    $inst -Syu
                    touch $upg
                    echo $sheb > $upg
                    echo "" >> $upg
                    echo "yes | $inst -Syu" >> $upg
                    echo "yes | $inst -Scc" >> $upg
                    # *error means -no orphaned packages
                    echo "yes | $inst -Rs \$(pacman -Qdtq)" >> $upg 
                    echo "yes | yay -Syu" >> $upg
                    echo "yes | yay -Yc" >> $upg
                    $chmod $upg
                    sudo mv $upg /bin/upg
                else
                    echo "Error - this OS is not in the script"
                    exit 1
        fi
    else
        echo "File exists!"
    fi
    
}
upg