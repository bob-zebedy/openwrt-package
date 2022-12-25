local a = require "luci.sys"
local e = luci.model.uci.cursor()
local e = require "nixio.fs"

require("luci.sys")

local t, e, o
local m, s

t = Map("aliddns")
t.title = translate("AliDDNS")

e = t:section(TypedSection, "base")
e.anonymous = true

e:tab("basic", translate("Settings"))

enable = e:taboption("basic", Flag, "enable", translate("Enable"))
enable.rmempty = false

telegram_notify = e:taboption("basic", Flag, "telegram_notify", translate("Telegram Bot Notify"))
telegram_notify.rmempty = false

telegram_token = e:taboption("basic", Value, "telegram_token", translate("Telegram Bot Token"))
telegram_token:depends("telegram_notify", 1)

telegram_chatid = e:taboption("basic", Value, "telegram_chatid", translate("Telegram Chat ID"))
telegram_chatid:depends("telegram_notify", 1)

token = e:taboption("basic", Value, "app_key", translate("AccessKey ID"))
email = e:taboption("basic", Value, "app_secret", translate("Secret"))
iface = e:taboption("basic", ListValue, "interface", translate("Interface"))
iface.description = translate("Choice interface")
for t, e in ipairs(a.net.devices()) do
    if e ~= "lo" then
        iface:value(e)
    end
end
iface.rmempty = false

main = e:taboption("basic", Value, "domain", translate("Domain"))
main.rmempty = false

sub = e:taboption("basic", Value, "host", translate("Host"))
sub.rmempty = false

time = e:taboption("basic", Value, "time", translate("Check interval"))
time.description = translate("Check interval (1-59) min")
time.rmempty = false

e:tab("log", translate("log"))
e.anonymous = true

local logfile = "/var/log/aliddns.log"
tvlog = e:taboption("log", TextValue, "sylogtext")
tvlog.rows = 30
tvlog.readonly = "readonly"
tvlog.wrap = "off"
function tvlog.cfgvalue(m, n)
    sylogtext = ""
    if logfile and nixio.fs.access(logfile) then
        sylogtext = luci.sys.exec("tail -n 100 %s | sort -r" % logfile)
    end
    return sylogtext
end
tvlog.write = function(m, n, t)
end
local e = luci.http.formvalue("cbi.apply")
if e then
    io.popen("/etc/init.d/aliddns restart")
end
return t
