local datatypes = require "luci.cbi.datatypes"

local white_list_file = "/etc/mosdns/rule/whitelist.txt"
local block_list_file = "/etc/mosdns/rule/blocklist.txt"
local grey_list_file = "/etc/mosdns/rule/greylist.txt"
local hosts_list_file = "/etc/mosdns/rule/hosts.txt"
local redirect_list_file = "/etc/mosdns/rule/redirect.txt"
local local_ptr_file = "/etc/mosdns/rule/local-ptr.txt"

m = Map("mosdns")

s = m:section(TypedSection, "mosdns")
s.anonymous = true

s:tab("white_list", translate("White Lists"))
s:tab("grey_list", translate("Grey Lists"))
s:tab("block_list", translate("Block Lists"))
s:tab("redirect_list", translate("Redirect"))
s:tab("local_ptr_list", translate("Block PTR"))
s:tab("hosts_list", translate("Hosts"))

o = s:taboption("white_list", TextValue, "whitelist", "")
o.rows = 30
o.wrap = "off"
o.cfgvalue = function(self, section)
    return nixio.fs.readfile(white_list_file) or ""
end
o.write = function(self, section, value)
    nixio.fs.writefile(white_list_file, value:gsub("\r\n", "\n"))
end
o.remove = function(self, section, value)
    nixio.fs.writefile(white_list_file, "")
end
o.validate = function(self, value)
    return value
end

o = s:taboption("grey_list", TextValue, "greylist", "")
o.rows = 30
o.wrap = "off"
o.cfgvalue = function(self, section)
    return nixio.fs.readfile(grey_list_file) or ""
end
o.write = function(self, section, value)
    nixio.fs.writefile(grey_list_file, value:gsub("\r\n", "\n"))
end
o.remove = function(self, section, value)
    nixio.fs.writefile(grey_list_file, "")
end
o.validate = function(self, value)
    return value
end

o = s:taboption("block_list", TextValue, "blocklist", "")
o.rows = 30
o.wrap = "off"
o.cfgvalue = function(self, section)
    return nixio.fs.readfile(block_list_file) or ""
end
o.write = function(self, section, value)
    nixio.fs.writefile(block_list_file, value:gsub("\r\n", "\n"))
end
o.remove = function(self, section, value)
    nixio.fs.writefile(block_list_file, "")
end
o.validate = function(self, value)
    return value
end

o = s:taboption("redirect_list", TextValue, "redirect", "")
o.rows = 30
o.wrap = "off"
o.cfgvalue = function(self, section)
    return nixio.fs.readfile(redirect_list_file) or ""
end
o.write = function(self, section, value)
    nixio.fs.writefile(redirect_list_file, value:gsub("\r\n", "\n"))
end
o.remove = function(self, section, value)
    nixio.fs.writefile(redirect_list_file, "")
end
o.validate = function(self, value)
    return value
end

o = s:taboption("local_ptr_list", TextValue, "local_ptr", "")
o.rows = 30
o.wrap = "off"
o.cfgvalue = function(self, section)
    return nixio.fs.readfile(local_ptr_file) or ""
end
o.write = function(self, section, value)
    nixio.fs.writefile(local_ptr_file, value:gsub("\r\n", "\n"))
end
o.remove = function(self, section, value)
    nixio.fs.writefile(local_ptr_file, "")
end
o.validate = function(self, value)
    return value
end

o = s:taboption("hosts_list", TextValue, "hosts", "")
o.rows = 30
o.wrap = "off"
o.cfgvalue = function(self, section)
    return nixio.fs.readfile(hosts_list_file) or ""
end
o.write = function(self, section, value)
    nixio.fs.writefile(hosts_list_file, value:gsub("\r\n", "\n"))
end
o.remove = function(self, section, value)
    nixio.fs.writefile(hosts_list_file, "")
end
o.validate = function(self, value)
    return value
end

local apply = luci.http.formvalue("cbi.apply")
if apply then
    luci.sys.exec("/etc/init.d/mosdns reload")
end

return m
