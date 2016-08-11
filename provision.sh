#!/bin/bash -x

export DEBIAN_FRONTEND=noninteractive

echo "deb http://http.debian.net/debian jessie-backports main" > /etc/apt/sources.list.d/jessie_backports.list
apt-get update
apt-get install -y libjson-perl vim tmate git locate curl cpanminus exuberant-ctags htop iotop atop sysdig ack-grep linux-tools-3.16
apt-get -y upgrade

which chef || (curl --silent --location --output /tmp/chef.deb https://packages.chef.io/stable/debian/8/chefdk_0.16.28-1_amd64.deb && dpkg -i /tmp/chef.deb)

if [ ! -f /root/.ssh ]
then
	mkdir /root/.ssh
	cp /home/vagrant/.ssh/authorized_keys /root/.ssh/authorized_keys
	chmod 600 /root/.ssh/ -R
fi

if [ ! -f /home/share/secret/gitlab_token ]
then
   echo "Actoin Required: You need to create /home/share/secret/gitlab_token and save your gitlap token there (token:domain)"
   exit 1;
fi

[[ ! -f /root/.bash_profile ]] && cp /home/share/config/bash_profile /root/.bash_profile

if [ ! -f /etc/cron.d/zram ]
then
cat <<End > /opt/zram.sh
#!/bin/bash
set -x
[ -f /sys/block/zram0/disksize ] && exit 0
/sbin/modprobe zram
echo 256M > /sys/block/zram0/disksize
/sbin/mkswap /dev/zram0
/sbin/swapoff -a
/sbin/swapon /dev/zram0
End
	chmod +x /opt/zram.sh
	echo "@reboot root /opt/zram.sh" > /etc/cron.d/zram
	/opt/zram.sh
fi

[ -f /home/share/secret/gitlab_token ] && perl /home/share/update_gitlab_repos.pl

exit 0
