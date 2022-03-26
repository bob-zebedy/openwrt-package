#
# Copyright (C) 2021 Bobby
#

include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-ipsec-bobby-server
PKG_VERSION:=1.0
PKG_RELEASE:=1

LUCI_TITLE:=LuCI support for IPSec VPN Server By Bobby
LUCI_DESCRIPTION:=LuCI interface for IPSec VPN Server By Bobby
LUCI_DEPENDS:=+strongswan +strongswan-minimal +strongswan-mod-xauth-generic +strongswan-mod-kernel-libipsec +kmod-tun
LUCI_PKGARCH:=all

include $(TOPDIR)/feeds/luci/luci.mk

# call BuildPackage - OpenWrt buildroot signature