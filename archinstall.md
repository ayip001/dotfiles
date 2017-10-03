# Arch installation guide  
Courtesy of @alan23394  
### 0. Prep
---
1. Get Rufus.
2. Download the Arch installation image.
3. Plug in USB (USB will be wiped).
4. Select the Arch iso on Rufus, leave all settings default, click start.  
**Skip to Section 1 if NOT dual booting with Windows**  
5. \<win\> + \<r\>, type `diskmgmt.msc`, enter.
6. Right click the main volume and select shrink. Just make some empty free space for Arch. Also account for the swap partition which should be the same size as RAM.
7. Disable Fast Startup.
8. Disable UEFI secure boot if machine has it in BIOS.

### 1. Init archiso env
---
1. Boot into archiso using BIOS boot (i.e. pressing f12). If possible, boot using EFI boot.  
**Skip to Section 2 if ethernet is connected and `ping google.com` works. TODO Ethernet connection instructions**  
2. `ip link` to list wifi interfaces. Find out your wifi device name.
3. `wifi-menu [device name]`, then `ping google.com` to verify connection.

### 1.5 High DPI tiny text solution
---
1. `pacman -Sy terminus-font` then `setfont ter-v32n`. Also if you want bigger text in general. If no internet just do `setfont latarcyrheb-sun32` as it's the only default 8x32 font.  

### 2. Partition
---
1. `lsblk` to check disk name of the place where you want to install Arch. It looks something like `/dev/sda`.
2. `cfdisk` to make an EFI partition for booting ONLY IF your device does not have one, swap partition with size same as RAM, and then a filesystem partition. Write after each command.

### 3. Init swap
---
1. `mkswap -L "Linux Swap" [swap partition name]`. Use `fdisk -l` to find the name that looks something like `/dev/sda2`. Also refer back to this command to find partition name for filesystem and EFI.
2. `swapon [swap partition name]`.
3. `free -m` to verify. It should have a size for swap in the last line.

### 4. Init filesystem
---
1. `mkfs.ext4 -L "Arch Linux" [filesystem partition name]` formats filesystem partition to ext4.
2. `mount [filesystem partition name] /mnt` mounts the partition to a port.

### 5. Init EFT
---
1. `mkdir -p /mnt/boot`.
2. If NOT dual booting with Windows, `mkfs.vfat [EFI partition name]`. **Keep your Windows EFI partition intact if dual booting.**
3. `mount [EFI partition name] /mnt/boot` mounts the EFI partition within the filesystem.
4. `pacstrap /mnt base` to install the base Arch Linux package on the filesystem and boot partition. Use `base-devel` instead of `base` for more development tools.
5. `genfstab -U -p /mnt >> /mnt/etc/fstab` to create boot information containing partition information. Check with `cat /mnt/etc/fstab`.

### 6. Basic config
---
1. `arch-chroot /mnt` to access the installed Arch Linux from archiso. Also `pacman -Sy dialog wpa_supplicant iw` to use `wifi-menu` when booting directly to Arch. `pacman -Sy intel-ucode` for intel processor info. Throw in `vim` and `terminus-font` as you see fit.  
**Locale**  
2. `vim /etc/locale.gen` and uncomment the line with your layout and timezone (e.g. `en_US.UTF-8 UTF-8`). Use another editor like `nano` instead of `vim` as you see fit.
3. `locale-gen`.
4. `echo LANG=en_US.UTF-8 > /etc/locale.conf`.
5. `export LANG=en_US.UTF-8`.
6. `rm /etc/localtime`.
7. `ln -s /usr/share/zoneinfo/[continent]/[location] /etc/localtime`. Use \<tab\> to list options in brackets.
8. `hwclock --systohc --utc`. `timedatectl` to check time & date.  
**Hostname**  
9. `echo [hostname] > /etc/hostname` names how your device shows up on networks.
10. `vim /etc/hosts` then add hostname after both `localhosts`.  
**Pacman swag**  
11. `vim /etc/pacman.conf` under `Architecture = Auto` add `ILoveCandy` and `Color` on their own lines so it looks like:
```
...
Architecture = Auto
ILoveCandy
Color
...
```
Then add these to the end of the document:
```
[archlinuxfr]
SigLevel = Never
Server = http://repo.archlinux.fr/$arch
update: "pacman -Syu"
```
12. If running 32-bit, uncomment the include line under `[multilib]`  
**Root and users**  
13. `passwd` to set root password.
14. `useradd -m -g users -G wheel,storage,power -s /bin/bash [username]` to create user.
15. `passwd [username]` to assign password to said user.

### 7. Bootloader setup
---
1. `bootctl install` and pray.
2. `vim /boot/loader/loader.conf`, delete everything in it and add:
```
timeout 4
default arch
```
3. `vim /boot/loader/entries/arch.conf` and add:
```
title Archlinux
linux /vmlinuz-linux
initrd /initramfs-linux.img
initrd /intel-ucode.img
options root=PARTUUID=[type ':r !blkid' and copy from Arch partition] rw
```
- Alternatively, `blkid >> /boot/loader/entries/arch.conf` and then use your editor of choice to fill in the rest.  `
- Skip the `intel-ucode.img` if you don't have it in `/boot`  
4. Reboot and pray to the gods  
5. Log back in as root  

### 7.5 Nvidia + Intel GPU causes shutdown/reboot hang fix  
---
1. `vim /etc/modprobe.d/modprob.conf` and add these 3 lines: `blacklist nvidia`, `blacklist nouveau`, and `options bbswitch load_state=0 unload_state=1`.  
2. If you wish to turn ON/OFF the GPU, enter: `sudo rmmod bbswitch`/`sudo modprobe bbswitch`.  

### 8. Install things as you see fit
---  
1. `xf86-input-synaptics` for touchpad  
2. `mesa` an open-source implementation of the OpenGL specification  
3. `bash-completion`  
4. `xorg-server xorg-apps xorg-xinit` that's for window managers
5. `gvim git openssh` gvim for the `+clipboard` over vim  
6. Run `pacaur_helper.sh` in the Scripts folder. `pacaur` searches, installs, and manages packages from the AUR and behaves just like `pacman` which is the best package manager tbh  
7. `i3-gaps` or wm of choice  
8. `urxvt` or terminal emulator of choice  
9. `neofetch` prints system info and ASCII art of the distro's logo  
10. `compton` is a composite manager that lets you do transparancy. As a result, you can add two more degit to the hex code (eg `#000000` -> `#88000000`), where `88` is the hex code for the alpha channel  
11. `feh` manages your desktop background  
12. `firefox` or browser of choice  
13. `font-awesome` for glyphs, `terminus-font` if you hadn't already, and fonts of choice  
14. `sudo` then look up how to set up sudoers  

### 9. Interface setup
---
1. Reboot again  
2. Login as user  
3. `vim .bashrc` and add in whatever you see fit you find in my `.bashrc`. Type `bash` to test those settings out  
4. To set up i3 (or alternative) with `startx`, add these lines to `~/.xinitrc`: `xrdb .Xresources`, `xrandr --dpi 282` if HiDPI, `exec i3`  
5. To run `startx` automatically on login, add these lines to `~/.bash_profile`:  
```
if [ "$(tty)" = "/dev/tty1" ]; then
	startx && exit
fi
```
6. Reboot and spend the next week debugging and ricing your Linux :^)
