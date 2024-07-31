{ lib, pkgs, ... }: {

  nixpkgs.hostPlatform = {
    system = "x86_64-linux";
  };

  boot.initrd.availableKernelModules = [
    "virtio_net" "virtio_pci" "virtio_mmio" "virtio_blk" "virtio_scsi" "virtio_balloon" "virtio_console"
  ];

  boot.kernelModules = [
    "r8169"
    "ahci"
    "nvme"
    "usb-storage" "uas"
    "dm-raid" "raid1"
  ];

  # hardware.firmware = [
  #   (pkgs.callPackage ../../pkgs/minimal-linux-firmware.nix {
  #     fwDirs = [ "rtl_nic" ];
  #   })
  # ];

}
