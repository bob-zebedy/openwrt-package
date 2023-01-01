m = Map("mosdns")
m.title = translate("MosDNS")

m:section(SimpleSection).template = "mosdns/mosdns_status"

s = m:section(TypedSection, "mosdns")
s.addremove = false
s.anonymous = true

enable = s:option(Flag, "enabled", translate("Enable"))
enable.rmempty = false

configfile = s:option(ListValue, "configfile", translate("Config File"))
configfile:value("/etc/mosdns/config.yaml", translate("Default Config"))
configfile:value("/etc/mosdns/config_custom.yaml", translate("Custom Config"))
configfile.default = "/etc/mosdns/config.yaml"

listenport = s:option(Value, "listen_port", translate("Listen port"))
listenport.datatype = "and(port,min(1))"
listenport.default = 5335
listenport:depends("configfile", "/etc/mosdns/config.yaml")

loglevel = s:option(ListValue, "log_level", translate("Log Level"))
loglevel:value("debug", translate("Debug"))
loglevel:value("info", translate("Info"))
loglevel:value("warn", translate("Warning"))
loglevel:value("error", translate("Error"))
loglevel.default = "info"
loglevel:depends("configfile", "/etc/mosdns/config.yaml")

logfile = s:option(Value, "logfile", translate("Log File"))
logfile.placeholder = "/tmp/mosdns.log"
logfile.default = "/tmp/mosdns.log"
logfile:depends("configfile", "/etc/mosdns/config.yaml")

redirect = s:option(Flag, "redirect", translate("DNS Forward"), translate("Forward Dnsmasq Domain Name resolution requests to MosDNS"))
redirect.default = true

custom_dns = s:option(Flag, "custom_dns", translate("Custom DNS"), translate("Follow WAN interface DNS if not enabled"))
custom_dns:depends("configfile", "/etc/mosdns/config.yaml")
custom_dns.default = false

upstream_dns = s:option(DynamicList, "local_dns", translate("Upstream DNS servers"))
upstream_dns:value("119.29.29.29", "119.29.29.29 (DNSPod)")
upstream_dns:value("119.28.28.28", "119.28.28.28 (DNSPod)")
upstream_dns:value("223.5.5.5", "223.5.5.5 (AliDNS)")
upstream_dns:value("223.6.6.6", "223.6.6.6 (AliDNS)")
upstream_dns.default = "119.29.29.29"
upstream_dns:depends("custom_dns", "1")

bootstrap_dns = s:option(ListValue, "bootstrap_dns", translate("Bootstrap DNS servers"), translate("Used to resolve IP addresses of the DoH/DoT resolvers you specify as upstreams"))
bootstrap_dns:value("119.29.29.29", "119.29.29.29 (DNSPod)")
bootstrap_dns:value("119.28.28.28", "119.28.28.28 (DNSPod)")
bootstrap_dns:value("223.5.5.5", "223.5.5.5 (AliDNS)")
bootstrap_dns:value("223.6.6.6", "223.6.6.6 (AliDNS)")
bootstrap_dns.default = "119.29.29.29"
bootstrap_dns:depends("custom_dns", "1")

remote_dns = s:option(DynamicList, "remote_dns", translate("Remote DNS"))
remote_dns:value("tls://1.1.1.1", "1.1.1.1 (CloudFlare DNS)")
remote_dns:value("tls://1.0.0.1", "1.0.0.1 (CloudFlare DNS)")
remote_dns:value("tls://8.8.8.8", "8.8.8.8 (Google DNS)")
remote_dns:value("tls://8.8.4.4", "8.8.4.4 (Google DNS)")
remote_dns:value("tls://208.67.222.222", "208.67.222.222 (Open DNS)")
remote_dns:value("tls://208.67.220.220", "208.67.220.220 (Open DNS)")
remote_dns:depends("configfile", "/etc/mosdns/config.yaml")

remote_dns_pipeline = s:option(Flag, "enable_pipeline", translate("Remote DNS Connection Multiplexing"), translate("Enable TCP/DoT RFC 7766 new Query Pipelining connection multiplexing mode"))
remote_dns_pipeline.rmempty = false
remote_dns_pipeline.default = false
remote_dns_pipeline:depends("configfile", "/etc/mosdns/config.yaml")

cache_size = s:option(Value, "cache_size", translate("DNS Cache Size"))
cache_size.datatype = "and(uinteger,min(0))"
cache_size.default = "200000"
cache_size:depends("configfile", "/etc/mosdns/config.yaml")

cache_size = s:option(Value, "cache_survival_time", translate("Cache Survival Time"))
cache_size.datatype = "and(uinteger,min(0))"
cache_size.default = "259200"
cache_size:depends("configfile", "/etc/mosdns/config.yaml")

minimal_ttl = s:option(Value, "minimal_ttl", translate("Minimum TTL"))
minimal_ttl.datatype = "and(uinteger,min(0))"
minimal_ttl.datatype = "and(uinteger,max(3600))"
minimal_ttl.default = "0"
minimal_ttl:depends("configfile", "/etc/mosdns/config.yaml")

maximum_ttl = s:option(Value, "maximum_ttl", translate("Maximum TTL"))
maximum_ttl.datatype = "and(uinteger,min(0))"
maximum_ttl.default = "0"
maximum_ttl:depends("configfile", "/etc/mosdns/config.yaml")

adblock = s:option(Flag, "adblock", translate("Enable DNS ADblock"))
adblock:depends("configfile", "/etc/mosdns/config.yaml")
adblock.default = false

adblock = s:option(Value, "ad_source", translate("ADblock Source"))
adblock:value("geosite.dat", "v2ray-geosite")
adblock:value("https://raw.githubusercontent.com/privacy-protection-tools/anti-AD/master/anti-ad-domains.txt", "anti-AD")
adblock:value("https://raw.githubusercontent.com/sjhgvr/oisd/main/dbl_basic.txt", "oisd (basic)")
adblock.default = "https://raw.githubusercontent.com/privacy-protection-tools/anti-AD/master/anti-ad-domains.txt"
adblock:depends("adblock", "1")

reload_service = s:option(Button, "_reload", translate("Reload Service"), translate("Reload service to take effect of new configuration"))
reload_service.write = function()
    luci.sys.exec("/etc/init.d/mosdns reload")
end
reload_service:depends("configfile", "/etc/mosdns/config_custom.yaml")

config = s:option(TextValue, "manual-config")
config.template = "cbi/tvalue"
config.rows = 30
config:depends("configfile", "/etc/mosdns/config_custom.yaml")

function config.cfgvalue(self, section)
    return nixio.fs.readfile("/etc/mosdns/config_custom.yaml")
end

function config.write(self, section, value)
    value = value:gsub("\r\n?", "\n")
    nixio.fs.writefile("/etc/mosdns/config_custom.yaml", value)
end

return m
