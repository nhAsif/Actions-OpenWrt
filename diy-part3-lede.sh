#!/bin/bash
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#
# Copyright (c) 2019-2024 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#

# 替换 openssl
git clone https://github.com/istoreos/istoreos.git
rm -rf package/libs/openssl/
cp -r istoreos/package/libs/openssl/ package/libs/openssl/

# 下载 adguardhome 预编译文件
rm -rf feeds/packages/net/adguardhome/*
cp -r custom_packages/AdGuardHome/Makefile feeds/packages/net/adguardhome/