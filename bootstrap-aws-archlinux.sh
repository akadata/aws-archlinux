#!/bin/bash
yum -y install wget
echo "n
p
1


a
1
w
"|fdisk /dev/xvdf
mkfs.ext4 -L ARCHROOTFS -j /dev/xvdf1 
mkdir -p /mnt/root.x86_64
mount /dev/xvdf1 /mnt/root.x86_64
cd /tmp
#wget http://archlinux.mirrors.uk2.net/iso/2015.08.01/archlinux-bootstrap-2015.08.01-x86_64.tar.gz
#wget http://slash64.uk/pacman-keys.tar.gz
cd /mnt/
tar -xzvf /tmp/archlinux-bootstrap-2015.08.01-x86_64.tar.gz
tar -xzvf /tmp/pacman-keys.tar.gz -C /mnt/root.x86_64/
if [ -a /mnt/root.x86_64/install-arch.sh ]
  then
	rm /mnt/root.x86_64/install-arch.sh
fi
echo "#!/bin/bash" >/mnt/root.x86_64/install-arch.sh
echo "source /etc/profile" >>/mnt/root.x86_64/install-arch.sh 
echo "ln -sf /usr/share/zoneinfo/Europe/London /etc/localtime" >>/mnt/root.x86_64/install-arch.sh 
echo "locale-gen" >>/mnt/root.x86_64/install-arch.sh 
echo "echo LANG=en_US > /etc/locale.conf" >>/mnt/root.x86_64/install-arch.sh 
echo "echo \"LABEL=ARCHROOTFS        /       ext4	defaults        0       0\" >/etc/fstab" >>/mnt/root.x86_64/install-arch.sh 
echo "useradd ec2-user" >>/mnt/root.x86_64/install-arch.sh 
echo "mkdir /home/ec2-user" >>/mnt/root.x86_64/install-arch.sh 
echo "nameserver 8.8.8.8" >/mnt/root.x86_64/etc/resolv.conf
echo "pacman-key --populate archlinux" >>/mnt/root.x86_64/install-arch.sh 
echo "pacman --noconfirm -Syyu" >>/mnt/root.x86_64/install-arch.sh 
echo "pacman --noconfirm -S grep" >>/mnt/root.x86_64/install-arch.sh
echo "pacman --noconfirm -S base mkinitcpio openssh vim cloud-init" >>/mnt/root.x86_64/install-arch.sh 
echo "pacman --noconfirm -S grub" >>/mnt/root.x86_64/install-arch.sh
echo "systemctl enable sshd" >>/mnt/root.x86_64/install-arch.sh
echo "systemctl enable dhcpcd" >>/mnt/root.x86_64/install-arch.sh
echo "systemctl enable rc-local" >>/mnt/root.x86_64/install-arch.sh
echo "mkinitcpio -p linux" >>/mnt/root.x86_64/install-arch.sh 
echo "grub-install /dev/xvdf" >>/mnt/root.x86_64/install-arch.sh 
echo "grub-mkconfig >/boot/grub/grub.cfg" >>/mnt/root.x86_64/install-arch.sh 
echo "mkdir -p /mnt/root.x86_64/home/ec2-user/.ssh/" >>/mnt/root.x86_64/install-arch.sh 
echo "chown ec2-user.ec2-user /home/ec2-user" >>/mnt/root.x86_64/install-arch.sh 
echo "useradd ec2-user" >>/mnt/root.x86_64/install-arch.sh 
echo "echo \"ec2-user:passw0rd\" | chpasswd" >>/mnt/root.x86_64/install-arch.sh 
echo "curl http://169.254.169.254/latest/meta-data/public-keys/0/openssh-key >/mnt/root.x86_64/home/ec2-user/.ssh/authorized_keys" >>/mnt/root.x86_64/install-arch.sh 
chmod 755 /mnt/root.x86_64/install-arch.sh
# creating /usr/lib/systemd/system/rc-local.service
echo "[Unit]">/mnt/root.x86_64/usr/lib/systemd/system/rc-local.service
echo "Description=/etc/rc.local compatibility">>/mnt/root.x86_64/usr/lib/systemd/system/rc-local.service
echo " ">>/mnt/root.x86_64/usr/lib/systemd/system/rc-local.service
echo "[Service]">>/mnt/root.x86_64/usr/lib/systemd/system/rc-local.service
echo "Type=oneshot">>/mnt/root.x86_64/usr/lib/systemd/system/rc-local.service
echo "ExecStart=/etc/rc.local">>/mnt/root.x86_64/usr/lib/systemd/system/rc-local.service
echo "RemainAfterExit=yes">>/mnt/root.x86_64/usr/lib/systemd/system/rc-local.service
echo " ">>/mnt/root.x86_64/usr/lib/systemd/system/rc-local.service
echo "[Install]">>/mnt/root.x86_64/usr/lib/systemd/system/rc-local.service
echo "WantedBy=multi-user.target">>/mnt/root.x86_64/usr/lib/systemd/system/rc-local.service


for i in proc sys dev run; do mount --rbind /$i /mnt/root.x86_64/$i; done
cd /mnt/root.x86_64/
chroot . ./install-arch.sh
chroot /mnt/root.x86_64/ /bin/bash
# I am leaving you in the chroot now to do as you wish before you disconnect the drive, snapshot, create a disk image and create your own AMI
# your ssh key from this instance is imported for you!! Have fun
# (C) 2015 - anderw.smalley@linux.com
