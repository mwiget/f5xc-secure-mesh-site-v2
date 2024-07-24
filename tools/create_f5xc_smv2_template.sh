#!/bin/bash
# adjust full path to downloaded qcow2 file, target template id and storage ...
qcow2=$1
id=$2
if [ -e $id ]; then
  echo "Proxmox script to create VM template from downloaded qcow2 image"
  echo ""
  echo "Usage:"
  echo "$0 <qcow2 file> <id>"
  echo ""
  echo "Example: $0 f5xc-ce-9.2024.22-20240716144557.qcow2 9002"
  exit 1
fi

if [ $(basename $qcow2) == $qcow2 ]; then
  qcow2="$PWD/$qcow2"
fi

storage=local-lvm
filename="${qcow2%.*}"
VER=$(basename $filename)

echo qcow2=$qcow2 id=$id VER=$VER ...

echo "resizing image to 50G ..."
qemu-img resize $qcow2 50G
echo "destroying existing VM $id (if present) ..."
qm destroy $id
echo "creating vm template $id from $image .."
qm create $id --memory 16384 --net0 virtio,bridge=vmbr0 --scsihw virtio-scsi-pci --cores 4 --cpu cputype=host
qm set $id --name $VER
qm set $id --scsi0 $storage:0,import-from=$qcow2
qm set $id --boot order=scsi0
qm set $id --serial0 socket
qm set $id --vga serial0
qm template $id
