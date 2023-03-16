#
# Copyright (C) 2023 Bobby
#

include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-bobby-wireguard
PKG_VERSION:=1.0
PKG_RELEASE:=1

LUCI_TITLE:=LuCI support for WireGuard By Bobby
LUCI_DESCRIPTION:=LuCI interface for WireGuard By Bobby
LUCI_DEPENDS:=+wireguard-tools +kmod-wireguard +luci-proto-wireguard
LUCI_PKGARCH:=all

include $(TOPDIR)/feeds/luci/luci.mk

# call BuildPackage - OpenWrt buildroot signature
