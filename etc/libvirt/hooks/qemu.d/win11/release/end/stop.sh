#!/usr/bin/bash

function restore_host_cpus(){
    systemctl set-property --runtime -- system.slice AllowedCPUs=0-15
    systemctl set-property --runtime -- user.slice AllowedCPUs=0-15
    systemctl set-property --runtime -- init.scope AllowedCPUs=0-15
}

function unload_vfio_pci_drivers(){
    modprobe -r vfio_pci
    modprobe -r vfio_iommu_type1
    modprobe -r vfio
}

function load_nvidia_drivers(){
    modprobe nvidia
    modprobe nvidia_modeset
    modprobe nvidia_drm
    modprobe nvidia_uvm
}

function rebind_vtconsoles(){
    echo 1 > /sys/class/vtconsole/vtcon0/bind
    echo 1 > /sys/class/vtconsole/vtcon1/bind
}

function main(){
    restore_host_cpus
    systemctl stop libvirt-nosleep@win11
    unload_vfio_pci_drivers
    load_nvidia_drivers
    echo "efi-framebuffer.0" > /sys/bus/platform/drivers/efi-framebuffer/bind
    rebind_vtconsoles
    systemctl start display-manager.service
}

main
