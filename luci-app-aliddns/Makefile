#
# Copyright (C) 2021 Bobby
#

include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-aliddns
PKG_VERSION:=1.0
PKG_RELEASE:=1

LUCI_TITLE:=LuCI support for Aliddns
LUCI_DESCRIPTION:=LuCI interface for Aliddns
LUCI_DEPENDS:=+wget +openssl-util
LUCI_PKGARCH:=all

include $(TOPDIR)/feeds/luci/luci.mk

# call BuildPackage - OpenWrt buildroot signature
