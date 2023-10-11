#!/usr/bin/env bash

# source: https://unix.stackexchange.com/questions/593050/shortcuts-to-enable-disable-a-touchpad-in-gnome3-on-wayland
if [ $(gsettings get org.gnome.desktop.peripherals.touchpad send-events) == "'enabled'" ]; then
    gsettings set org.gnome.desktop.peripherals.touchpad send-events disabled
else
    gsettings set org.gnome.desktop.peripherals.touchpad send-events enabled
fi
