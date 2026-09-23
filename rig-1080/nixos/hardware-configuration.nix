# Written by hand from the running Arch system's lsblk output (2026-09-22).
# The sda UUIDs below are the CURRENT partitions — if you reformat any of them
# during the NixOS install, regenerate this file (`nixos-generate-config`) or
# update the UUIDs. sdb1/sdc1 keep their UUIDs as long as they aren't touched.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  # All drives are SATA — ahci is required to find the root disk at boot.
  boot.initrd.availableKernelModules = [ "ahci" "xhci_pci" "usb_storage" "usbhid" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/eecafbed-6ced-4646-bdc7-67f937be2528";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/5089-3D36";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };

  fileSystems."/home" =
    { device = "/dev/disk/by-uuid/97a76312-b474-46eb-9277-079a05465ef8";
      fsType = "ext4";
    };

  fileSystems."/mnt/backup" =
    { device = "/dev/disk/by-uuid/82e7b69e-d4b4-4ad5-9cd3-9d1fa3fce49b";
      fsType = "ext4";
    };

  fileSystems."/mnt/storage" =
    { device = "/dev/disk/by-uuid/2f1971f9-fc4d-47c5-b8ff-691f13508151";
      fsType = "ext4";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/98a5f4e1-e0e6-4466-b43e-d1cf6c47ba31"; }
    ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
