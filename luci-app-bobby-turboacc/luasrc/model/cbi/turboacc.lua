local kernel_version = luci.sys.exec("echo -n $(uname -r)")

m = Map("turboacc")
m.title = translate("Turbo ACC Acceleration Settings")
m:append(Template("turboacc/turboacc_status"))

s = m:section(TypedSection, "turboacc", "")
s.addremove = false
s.anonymous = true

if nixio.fs.access("/lib/modules/" .. kernel_version .. "/xt_FLOWOFFLOAD.ko") and not nixio.fs.access("/lib/modules/" .. kernel_version .. "/mtkhnat.ko") then
    sw_flow = s:option(Flag, "sw_flow", translate("Software flow offloading"))
    sw_flow.default = 0
    sw_flow.description = translate("Software based offloading for routing/NAT")
    sw_flow:depends("sfe_flow", 0)
end

if luci.sys.call("cat /etc/openwrt_release | grep -q mt762") == 0 and not nixio.fs.access("/lib/modules/" .. kernel_version .. "/mtkhnat.ko") then
    hw_flow = s:option(Flag, "hw_flow", translate("Hardware flow offloading"))
    hw_flow.default = 0
    hw_flow.description = translate("Requires hardware NAT support")
    hw_flow:depends("sw_flow", 1)
end

if nixio.fs.access("/lib/modules/" .. kernel_version .. "/shortcut-fe-cm.ko") or nixio.fs.access("/lib/modules/" .. kernel_version .. "/fast-classifier.ko") then
    sfe_flow = s:option(Flag, "sfe_flow", translate("Shortcut-FE flow offloading"))
    sfe_flow.default = 0
    sfe_flow.description = translate("Shortcut-FE based offloading for routing/NAT")
    sfe_flow:depends("sw_flow", 0)
end

if nixio.fs.access("/lib/modules/" .. kernel_version .. "/tcp_bbr.ko") then
    bbr_cca = s:option(Flag, "bbr_cca", translate("BBR CCA"))
    bbr_cca.default = 0
    bbr_cca.description = translate("Using BBR CCA can improve TCP network performance effectively")
end

if nixio.fs.access("/lib/modules/" .. kernel_version .. "/xt_FULLCONENAT.ko") then
    fullcone_nat = s:option(Flag, "fullcone_nat", translate("FullCone NAT"))
    fullcone_nat.default = 0
    fullcone_nat.description = translate("Using FullCone NAT can improve gaming performance effectively")
end

if nixio.fs.access("/usr/sbin/pdnsd") or nixio.fs.access("/usr/bin/dnsforwarder") or nixio.fs.access("/usr/bin/dnsproxy") then
    dns_caching = s:option(Flag, "dns_caching", translate("DNS Caching"))
    dns_caching.default = 0
    dns_caching.rmempty = false
    dns_caching.description = translate("Enable DNS Caching and anti ISP DNS pollution")
end

dns_caching_mode = s:option(ListValue, "dns_caching_mode", translate("Resolve DNS Mode"), translate("DNS Program"))
if nixio.fs.access("/usr/sbin/pdnsd") then
    dns_caching_mode:value("1", translate("Using PDNSD to query and cache"))
end
if nixio.fs.access("/usr/bin/dnsforwarder") then
    dns_caching_mode:value("2", translate("Using DNSForwarder to query and cache"))
end
if nixio.fs.access("/usr/bin/dnsproxy") then
    dns_caching_mode:value("3", translate("Using DNSProxy to query and cache"))
end
dns_caching_mode.default = 1
dns_caching_mode:depends("dns_caching", 1)

dns_caching_dns = s:option(Value, "dns_caching_dns", translate("Upsteam DNS Server"))
dns_caching_dns.default = "119.29.29.29,223.5.5.5,1.2.4.8"
dns_caching_dns.description = translate("Muitiple DNS server can saperate with ','")
dns_caching_dns:depends("dns_caching", 1)

return m