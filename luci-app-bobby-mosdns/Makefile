include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-bobby-mosdns
PKG_VERSION:=1.0.0
PKG_RELEASE:=1

LUCI_TITLE:=LuCI Support for mosdns By Bobby
LUCI_DESCRIPTION:=LuCI interface for mosdns By Bobby
LUCI_DEPENDS:=+mosdns +jsonfilter +luci-compat +curl +v2ray-geoip +v2ray-geosite
LUCI_PKGARCH:=all

define Package/$(PKG_NAME)/conffiles
/etc/config/mosdns
/etc/mosdns/config_custom.yaml
/etc/mosdns/rule
endef

include $(TOPDIR)/feeds/luci/luci.mk

# call BuildPackage - OpenWrt buildroot signature
