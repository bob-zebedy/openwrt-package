#
# Copyright (C) 2006-2017 Bobby
#

include $(TOPDIR)/rules.mk

LUCI_TITLE:=LuCI support for eqos
LUCI_DESCRIPTION:=LuCI support for Easy QoS
LUCI_DEPENDS:=+tc +kmod-sched-core +kmod-ifb
LUCI_PKGARCH:=all

PKG_NAME:=luci-app-eqos
PKG_VERSION:=1.0.0
PKG_RELEASE:=1

include $(TOPDIR)/feeds/luci/luci.mk

# call BuildPackage - OpenWrt buildroot signature

