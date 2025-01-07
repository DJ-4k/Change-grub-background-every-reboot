# WARNING
The directory /home/ak/Imágenes/grub2/ must contain the images listed according to the number of them.

If I have 10 images in this directory /home/ak/Images/grub2/ the first line of /usr/local/sbin/change_background should be:
echo GRUB_BACKGROUND=\"/home/ak/Imágenes/grub2/\"\$((1 + RANDOM %10)).\".png\" > /etc/default/grub"

# Images format
The images located in /home/ak/Imágenes/grub2 cThey have the .png format and a 16:9 aspect ratio, this means that the following resolutions are valid:
```
2160p (4K): 3840 × 2160
1440p (2K): 2560 × 1440
1080p (HD): 1920 × 1080
720p (HD): 1280 × 720
```
# What does runAsRoot.sh do?
This script automates the process of configuring GRUB to support dynamic background changes on a Debian-based Linux system. Here's a detailed breakdown of what the script does:
The script:
```
1.-Creates a backup of the current GRUB configuration file (/etc/default/grub) as /etc/default/grub.bk.
2.-Installs a custom script (change_background) to generate a random background image path for GRUB.
3.-Installs a systemd service (change-background.service) to manage the execution of the change_background script.
4.-Ensures the systemd service is enabled and ready to run on system startup.
```
# I only did this because I wanted to decorate my grub a little, I'm not an expert, you may have to make some modifications according to the location of the grub file, this worked on the computer with the following characteristics:
```
uname -a
Linux Linux4K 6.1.0-28-amd64 #1 SMP PREEMPT_DYNAMIC Debian 6.1.119-1 (2024-11-22) x86_64 GNU/Linux
```
