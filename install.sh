#!/bin/bash

VIRTUALCAM_NAME="Virtual Front Camera"
V4L2_DEVICE_FILTER="Internal front camera"

systemctl --user stop libcamera-on-demand.service

mkdir -p ~/.local/bin
cp -f ./libcamera-on-demand ~/.local/bin/

mkdir -p ~/.config/systemd/user/
cp -f ./libcamera-on-demand.service ~/.config/systemd/user/

sudo cp -f ./etc/modules-load.d/v4l2loopback.conf /etc/modules-load.d/
sudo cp -f ./etc/modprobe.d/v4l2loopback.conf /etc/modprobe.d/

sudo rmmod v4l2loopback
sudo modprobe v4l2loopback devices=1 exclusive_caps=1 card_label="${VIRTUALCAM_NAME}"

systemctl --user daemon-reload
systemctl --user enable libcamera-on-demand.service
systemctl --user start libcamera-on-demand.service

INPUT=$(cam --list | grep -A1 "${V4L2_DEVICE_FILTER}")
OUTPUT=$(v4l2-ctl --list-devices | grep -A1 "${VIRTUALCAM_NAME}" | tail -n1 | awk '{print $1}')
echo ""
echo "Input: ${INPUT}"
echo "Output: ${OUTPUT}"
