#
# Copyright (C) 2024 Bobby
#

include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-bobby-upnp
PKG_VERSION:=1.0
PKG_RELEASE:=1

LUCI_TITLE:=LuCI support for upnp By Bobby
LUCI_DESCRIPTION:=LuCI support for upnp By Bobby
LUCI_DEPENDS:=+miniupnpd
LUCI_PKGARCH:=all

include $(TOPDIR)/feeds/luci/luci.mk

# call BuildPackage - OpenWrt buildroot signature