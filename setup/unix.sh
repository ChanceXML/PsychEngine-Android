#!/bin/sh
echo "Starting setup..."

mkdir -p ~/haxelib
haxelib setup ~/haxelib

haxelib install hxcpp 4.3.2 --quiet
haxelib set hxcpp 4.3.2

haxelib install flixel 5.6.1 --quiet
haxelib install flixel-addons 3.2.2 --quiet
haxelib install flixel-tools 1.5.1 --quiet
haxelib install hscript-iris 1.1.3 --quiet
haxelib install tjson 1.4.0 --quiet
haxelib install hxdiscord_rpc 1.2.4 --quiet
haxelib install hxvlc 2.0.1 --skip-dependencies --quiet
haxelib install lime 8.1.2 --quiet
haxelib install openfl 9.3.3 --quiet

haxelib git flxanimate https://github.com/Dot-Stuff/flxanimate 768740a56b26aa0c072720e0d1236b94afe68e3e
haxelib install linc_luajit 0.0.6
haxelib git funkin.vis https://github.com/FunkinCrew/funkVis 22b1ce089dd924f15cdc4632397ef3504d464e90
haxelib git grig.audio https://gitlab.com/haxe-grig/grig.audio.git cbf91e2180fd2e374924fe74844086aab7891666

if [ "$(uname)" = "Linux" ]; then
    echo "Installing SDL2 and system dependencies..."
    sudo apt-get update
    sudo apt-get install -y \
        build-essential clang g++ gcc \
        libsdl2-dev libsdl2-image-dev libsdl2-mixer-dev libsdl2-ttf-dev \
        libasound2-dev libpulse-dev libudev-dev libxi-dev libxrandr-dev \
        libxinerama-dev libxcursor-dev libgl1-mesa-dev libglu1-mesa-dev
fi

echo "Haxe/Android setup completed!"
