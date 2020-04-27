#!/bin/bash
if [ UID != 0 ]; then
	echo "请以root用户执行"
	exit
fi
echo "正在屏蔽nouveau开源NVidia驱动"
cat >> /etc/modprobe.d/blacklist.conf << EOF
# 禁用Nouveau
blacklist nouveau
options nouveau modeset=0
EOF
if [ $? != 0 ]; then
	echo "写入配置文件失败！"
	exit
fi
update-intiramfs -u
if [ $? != 0 ]; then
	echo "更新驱动配置失败！"
	exit
fi
echo "禁用Nouveau成功，请重启电脑"
