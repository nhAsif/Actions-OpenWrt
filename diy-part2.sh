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

# 修改默认 IP
sed -i 's/192.168.1.1/192.168.2.1/g' package/base-files/files/bin/config_generate
sed -i 's/192.168.1.1/192.168.2.1/g' package/base-files/luci2/bin/config_generate

# ash -> bash
sed -i 's#/bin/ash#/bin/bash#' package/base-files/files/etc/passwd

# 修改默认主题
#sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile

# 修改主机名
sed -i 's/LEDE/OpenWrt/g' package/base-files/files/bin/config_generate
sed -i 's/LEDE/OpenWrt/g' package/base-files/luci2/bin/config_generate

# 修改 tailscale 菜单位置
sed -i 's#admin/services#admin/vpn#g' feeds/luci/applications/luci-app-tailscale/root/usr/share/luci/menu.d/luci-app-tailscale.json

# cloudflared 启动脚本增加 --protocol http2 参数，使国内连接更稳定
sed -i '/procd_append_param command "--no-autoupdate"/a \\tprocd_append_param command "--protocol" "http2"' feeds/packages/net/cloudflared/files/cloudflared.init

# 快速 node 
rm -rf feeds/packages/lang/node
git clone https://github.com/sbwml/feeds_packages_lang_node-prebuilt -b packages-23.05 feeds/packages/lang/node

# 下载 AdGuardHome core
case $CONFIG_ARCH in
x86_64)
    ARCH_TAG="amd64"
    ;;
aarch64)
    ARCH_TAG="arm64"
    ;;
*)
    echo "不支持的架构: $ARCH"
    exit 1
    ;;
esac

mkdir -p files/usr/bin/AdGuardHome || true
AGH_CORE=$(curl -sL https://api.github.com/repos/AdguardTeam/AdGuardHome/releases/latest | grep /AdGuardHome_linux_${ARCH_TAG} | awk -F '"' '{print $4}') || true
wget -qO- $AGH_CORE | tar xOvz > files/usr/bin/AdGuardHome/AdGuardHome || true
chmod +x files/usr/bin/AdGuardHome/AdGuardHome || true