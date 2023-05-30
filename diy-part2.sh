#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# Modify default IP
#sed -i 's/192.168.1.1/192.168.50.5/g' package/base-files/files/bin/config_generate

# Modify default theme（FROM uci-theme-bootstrap CHANGE TO luci-theme-material）
sed -i 's/luci-theme-bootstrap/luci-theme-material/g' ./feeds/luci/collections/luci/Makefile

# Add autocore support for armvirt
sed -i 's/TARGET_rockchip/TARGET_rockchip\|\|TARGET_armvirt/g' package/lean/autocore/Makefile

# Set etc/openwrt_release
sed -i "s|DISTRIB_REVISION='.*'|DISTRIB_REVISION='R$(date +%Y.%m.%d)'|g" package/lean/default-settings/files/zzz-default-settings
echo "DISTRIB_SOURCECODE='lede'" >>package/base-files/files/etc/openwrt_release

# replace samba4
rm -rf feeds/packages/net/samba4
svn co https://github.com/openwrt/packages/trunk/net/samba4 feeds/packages/net/samba4

# Add luci-app-amlogic
svn co https://github.com/ophub/luci-app-amlogic/trunk/luci-app-amlogic package/luci-app-amlogic

# set config for amlogic
sed -i "s|amlogic_firmware_repo.*|amlogic_firmware_repo 'https://github.com/windyjdk/openwrt'|g" package/luci-app-amlogic/root/etc/config/amlogic
sed -i "s|ARMv8|N1|g" package/luci-app-amlogic/root/etc/config/amlogic
#sed -i "s|.img.gz|.OPENWRT_SUFFIX|g" package/luci-app-amlogic/root/etc/config/amlogic
#sed -i "s|amlogic_kernel_path.*|amlogic_kernel_path 'https://github.com/USERNAME/REPOSITORY'|g" package/luci-app-amlogic/root/etc/config/amlogic

# Add luci-app-openclash
svn co https://github.com/vernesong/OpenClash/trunk/luci-app-openclash package/lean/openclash
