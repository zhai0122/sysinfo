#!/usr/bin/env bash

# Author: zhai0122
# date: 2022/07/29
# Description: 显示一些系统信息

check_root(){
	[[ $EUID -ne 0 ]] && echo -e "请使用 root 用户运行本脚本！" && exit 1
}

pre_info() {
    echo -e " 1. 安装到ssh_motd "
    echo -e " 2. 安装到环境变量 "
    echo -e " 3. 全部删除 "
    echo -e " 4. 退出 "
    while :; do echo
        read -p " 请输入数字选择模式：" selection
        if [[ ! $selection =~ ^[1-4]$ ]]; then
            echo -ne "输入错误"
        else
            break
        fi
    done
}
install_info() {
    pre_info;
    if [[ ${selection} == 1 ]]; then
        if [ ! -e '/etc/motd.bak' ]; then
            mv /etc/motd /etc/motd.bak  > /dev/null 2>&1
        fi
        rm /etc/motd > /dev/null 2>&1
        mkdir -p /etc/update-motd.d > /dev/null 2>&1
        curl -o /etc/update-motd.d/sys-info https://ghproxy.com/https://raw.githubusercontent.com/zhai0122/sysinfo/main/sysinfo.sh > /dev/null 2>&1
        chmod +x /etc/update-motd.d/sys-info > /dev/null 2>&1
        echo -ne "安装到ssh_motd成功\n"
    fi
    if [[ ${selection} == 2 ]]; then
        curl -o /usr/bin/sysinfo https://ghproxy.com/https://raw.githubusercontent.com/zhai0122/sysinfo/main/sysinfo.sh > /dev/null 2>&1
        chmod +x /usr/bin/sysinfo > /dev/null 2>&1
        echo -ne "安装到环境变量成功\n"
    fi
    if [[ ${selection} == 3 ]]; then
        mv /etc/motd.bak /etc/motd  > /dev/null 2>&1
        rm -f /usr/bin/sysinfo > /dev/null 2>&1
        echo -ne "删除成功\n"
    fi
    [[ ${selection} == 4 ]] && exit 1
    source /etc/profile > /dev/null 2>&1
        
}
check_root;
install_info;