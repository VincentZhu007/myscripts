#!/bin/bash
#
# install-frp.sh
#
# 安装并配置frp服务
# Vincent Zhu 2020-05-21

source ./functions.sh

# 检查是否为root用户
is_root
if [ $? -ne 0 ]; then
	echo "请以root用户运行此脚本。"
	exit 1
fi

# 获取安装包
package='https://github.com/fatedier/frp/releases/download/v0.33.0/frp_0.33.0_linux_amd64.tar.gz'
if [ $(get_os_bits) -eq '32' ]; then
	package=$(echo $package | sed "s/amd64/386/")
fi
echo $package
wget $package

# 安装
tar xzvf frp*.tar.gz
cat << EOF > frp*/frps.ini
# frpc.ini
[common]
server_addr = iamzhu.top
server_port = 7000

[ssh]
type = tcp
local_ip = 127.0.0.1
local_port = 22
remote_port = 6000
EOF

cp frp*/frps /usr/bin/
mkdir /etc/frp/
cp frp*/frps.ini /etc/frp/
cp frp*/systemd/frps.service /usr/lib/systemd/system/ # 设置systemd
systemctl enable frps # 设置开机自启动
systemctl start frps # 开启systemd服务
firewall-cmd --zone=public --add-port=7000/tcp
firewall-cmd --zone=public --add-port=6000/tcp
echo "Finished"

# 清除
rm -rf frp*.tar.gz*
rm -rf frp*/
echo "Cleaned"
