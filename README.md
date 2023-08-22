# Minimal Arch Install with LUKS Encryption, LVM, and rEFInd boot manager 

Welcome to the Minimal Arch Install repository! This collection of bash scripts simplifies the process of setting up a minimal Arch OS with LUKS encryption, LVM, and rEFInd boot manager on a UEFI system.

## Installation

1. **Boot into Arch Live Environment:** Start by booting into your live Arch environment. You can use a USB drive with Arch installation or similar methods.

2. **Copy the Scripts:** Copy the provided scripts to the live environment. Ensure that all scripts are executable.

3. **Run the Installation Script:** Execute the following command to initiate the installation process:

    ```bash
    ./install-arch.sh
    ```

   This script will prompt you with various questions during the installation.

   - The script will request the block device path where you want to install Arch.
   - Choose between manual partitioning or the default partitioning scheme.
     - Default scheme: Creates a 550 MB EFI partition and a 170 GB Linux partition for LUKS encryption. Assumes the block device is an NVME SSD, but you can adjust sizes and names as needed.
     - Manual partitioning: Use `cfdisk` for cases with existing OSes/partitions on the device.
   - For dual-booting with Windows 11, it's recommended to install Arch first with sufficient space for boot files, then install Windows 11 considering Windows 11 allocates a mere 100 MB for its EFI partition.

   The script sets up two logical volumes named root (40 GB) and home (remaining partition space) within the encrypted partition. Additionally, it installs and configures the rEFInd boot manager.

4. **Post-Installation Setup:** After the installation script finishes, reboot your system and log in as the root user. Run the `init-root.sh` script:

    ```bash
    ./init-root.sh
    ```

   This script performs the following tasks:
   - Creates a new user and adds it to relevant groups.
   - Modifies suders config
   - Improves some `pacman` functionalities
   - Sets up a 2 GB swap file.

## Notes

- Customize: Feel free to modify the scripts and configurations according to your needs.
- Windows Dual Boot: If dual-booting with Windows 11, install Arch first, allowing space for boot files. Then install Windows 11.
- Manual Partitioning: Use manual partitioning (via `cfdisk`) if existing OSes/partitions are on the block device.
- Credits: These scripts simplify the installation process but may require adjustments based on your hardware and preferences.

Enjoy your minimal Arch OS setup with enhanced security and efficient disk management!
