#!/bin/bash
yum -y install wget
echo "n
p
1

a
1
w
"|fdisk /dev/xvdf
mkfs.ext4 -L ARCHROOTFS -j /dev/xvdf1; mount /dev/xvfd1 /mnt/root.x86_64
cd /tmp
wget http://archlinux.mirrors.uk2.net/iso/2015.08.01/archlinux-bootstrap-2015.08.01-x86_64.tar.gz
wget http://slash64.uk/pacman-keys.tar.gz
mkdir -p /mnt/root.x86_64; cd /mnt/root.x86_64
tar -xzvf archlinux-bootstrap-2015.08.01-x86_64.tar.gz
tar -xzvf pacman-keys.tar.gz -C /mnt/root.x86_64/etc/
cat <<EOF > /mnt/root.x86_64/install-arch.sh
#!/bin/bash
source /etc/profile 
ln -sf /usr/share/zoneinfo/Europe/London /etc/localtime
locale-gen
echo LANG=en_US > /etc/locale.conf
echo "LABEL=ARCHROOTFS        /       ext4	defaults        0       0" >/etc/fstab
systemctl enable sshd
systemctl enable dhcpcd
useradd ec2-user
mkdir /home/ec2-user
pacman -Syyu
pacman --noconfirm -S base openssh vim cloud-init
mkinitcpio -p linux
grub-install /dev/xvdf
grub-mkconfig >/boot/grub/grub.cfg
chown ec2-user.ec2-user /home/ec2-user
useradd ec2-user
echo "ec2-user:passw0rd" | chpasswd
echo "System Bootstrap complete! Please change root=UUID=??? to root=LABEL==ARCHROOTFS"
EOF
for i in proc sys dev run; do mount --rbind /$i $i; done; chroot . /bin/bash install-arch.sh


