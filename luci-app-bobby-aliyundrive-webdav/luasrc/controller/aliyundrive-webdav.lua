module("luci.controller.aliyundrive-webdav", package.seeall)

function index()
    if not nixio.fs.access("/etc/config/aliyundrive-webdav") then
        return
    end

    local page

    page = entry({
        "admin",
        "services",
        "aliyundrive-webdav"
    }, alias("admin", "services", "aliyundrive-webdav", "client"), _("WebDAV"), 50)
    page.dependent = true
    page.acl_depends = {
        "luci-app-aliyundrive-webdav"
    }

    entry({
        "admin",
        "services",
        "aliyundrive-webdav",
        "client"
    }, cbi("aliyundrive-webdav/client"), _("Settings"), 10).leaf = true

    entry({
        "admin",
        "services",
        "aliyundrive-webdav",
        "status"
    }, call("action_status")).leaf = true

    entry({
        "admin",
        "services",
        "aliyundrive-webdav",
        "qrcode"
    }, call("action_generate_qrcode")).leaf = true

    entry({
        "admin",
        "services",
        "aliyundrive-webdav",
        "query"
    }, call("action_query_qrcode")).leaf = true
    
    entry({
        "admin",
        "services",
        "aliyundrive-webdav",
        "invalidate-cache"
    }, call("action_invalidate_cache")).leaf = true
end

function action_status()
    local e = {}
    e.running = luci.sys.call("pidof aliyundrive-webdav >/dev/null") == 0
    e.application = luci.sys.exec("aliyundrive-webdav --version")
    luci.http.prepare_content("application/json")
    luci.http.write_json(e)
end

function action_invalidate_cache()
    local e = {}
    e.ok = luci.sys.call("kill -HUP `pidof aliyundrive-webdav`") == 0
    luci.http.prepare_content("application/json")
    luci.http.write_json(e)
end

function action_generate_qrcode()
    local output = luci.sys.exec("aliyundrive-webdav qr generate")
    luci.http.prepare_content("application/json")
    luci.http.write(output)
end

function action_query_qrcode()
    local data = luci.http.formvalue()
    local t = data.t
    local ck = data.ck
    local output = {}
    output.refresh_token = luci.sys.exec("aliyundrive-webdav qr query --t " .. t .. " --ck " .. ck)
    luci.http.prepare_content("application/json")
    luci.http.write_json(output)
end
