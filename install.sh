#!/usr/bin/bash

cp etc/systemd/system/libvirt-nosleep@.service /etc/systemd/system/libvirt-nosleep@.service
cp etc/libvirt/hooks/qemu /etc/libvirt/hooks/qemu
cp etc/libvirt/hooks/qemu.d/win11/prepare/begin/start.sh /etc/libvirt/hooks/qemu.d/win11/prepare/begin/start.sh
cp etc/libvirt/hooks/qemu.d/win11/release/end/stop.sh /etc/libvirt/hooks/qemu.d/win11/release/end/stop.sh

chmod +x /etc/libvirt/hooks/qemu
chmod +x /etc/libvirt/hooks/qemu.d/win11/prepare/begin/start.sh
chmod +x /etc/libvirt/hooks/qemu.d/win11/release/end/stop.sh
