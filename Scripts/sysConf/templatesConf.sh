#!/bin/bash
os=/etc/os-release


# Проверка наличия архива
if ! [ -f ../../Packeges/templates.tar.xz ]; then
    echo "Проверка интернет соединения"
    check_inet=$(ping -c 3 ya.ru | tail -2 | head -1 | awk '{print $4}')
    if [ $check_inet -eq 0 ]; then
        echo -e "Error - No internet connection!"
        exit 1
    else
        echo "Проверка наличия установленной программы wget"
        if ! [ -f /bin/wget ]; then
            echo "Программа wget не установленна"
            if ( grep debian $os ); then
                echo "Установка программы wget"
                sudo apt update && sudo apt install wget -y && echo "wget установлен"
            elif ( grep arch $os ); then
                yes | sudo pacman -Syu
                yes | sudo pacman -S wget
                echo "wget установлен"
            else
                echo "Error - this OS is not in the script"
                exit 1
            fi
            
        fi
        cd ~/
        wget -c https://github.com/fulgeat/routine_bash/tree/main/Packeges/templates.tar.xz
        if [ -d ~/Шаблоны ]; then
            tar -xf templates.tar.xz
            mv ./templates/*  ~/Шаблоны
            rm -fr ~/templates.tar.xz templates
        elif [ -d ~/Templates ]; then
            mkdir tempDir && cd tempDir
            tar -xf templates.tar.xz
            mv ./templates/*  ~/Templates
            cd ~
            rm -fr tempDir
        else 
            echo "Error - Required directory does not exist"
            rm -f ~/templates.tar.xz
            exit 1
        fi
    fi
else
    cd ../../Packeges/
    tar -xf templates.tar.xz
    if [ -d ~/Шаблоны ]; then
        mv ./templates/*  ~/Шаблоны
    elif [ -d ~/Templates ]; then
        mv ./templates/*  ~/Templates
    else 
        echo "Error - Required directory does not exist"
        rm -fr ./templates
        exit 1
    fi
    rm -fr ./templates
fi