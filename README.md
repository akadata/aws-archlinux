# aws-archlinux

This is a bootstrap script to install ArchLinux from a bootstrap tar.gz file

Download this to an Amazon AWS Instance of any Linux type.

Attach a new disk 5gb is more than enough with the default settings which are usually /dev/sdf

It can be accessed as /dev/xvdf

the script will format ext4 with journal get the bootstrap filesystem and my pre-init pacman-keys to save time

you may want to run pacman-key --init to create your own master keyset. Be warned this takes time

It should fdisk, format and extract

my chroot portion is having problems at the moment so input is welcome here. 
