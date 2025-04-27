#!/usr/bin/bash

USER=william

function limiting_host_cpus(){
    systemctl set-property --runtime -- system.slice AllowedCPUs=0,8
    systemctl set-property --runtime -- user.slice AllowedCPUs=0,8
    systemctl set-property --runtime -- init.scope AllowedCPUs=0,8
}

function unbind_vtconsoles(){
    for vt in /sys/class/vtconsole/vtcon*; do
        echo 0 > $vt
    done
}

function unload_nvidia_drivers(){
    modprobe -r nvidia_uvm
    modprobe -r nvidia_drm
    modprobe -r nvidia_modeset
    modprobe -r nvidia
}

function load_vfio_pci_drivers(){
    modprobe vfio
    modprobe vfio_pci
    modprobe vfio_iommu_type1
}

function main (){
    limiting_host_cpus
    systemctl start libvirt-nosleep@win11 # Prevents the host from sleeping
    killall -u "$USER" # close all applications
    systemctl stop display-manager.service # stop display manager
    unbind_vtconsoles
    echo efi-framebuffer.0 > /sys/bus/platform/drivers/efi-framebuffer/unbind
    unload_nvidia_drivers
    load_vfio_pci_drivers 
}

main
