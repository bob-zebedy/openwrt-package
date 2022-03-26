#
# Copyright (C) 2021 Bobby
#

include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-bobby-eqos
PKG_VERSION:=1.0.0
PKG_RELEASE:=1

LUCI_TITLE:=LuCI support for eqos By Bobby
LUCI_DESCRIPTION:=LuCI interface for Easy QoS By Bobby
LUCI_DEPENDS:=+tc +kmod-sched-core +kmod-ifb
LUCI_PKGARCH:=all

include $(TOPDIR)/feeds/luci/luci.mk

# call BuildPackage - OpenWrt buildroot signature
