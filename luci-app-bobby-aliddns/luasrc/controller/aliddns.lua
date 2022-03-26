module("luci.controller.aliddns", package.seeall)

function index()
    if not nixio.fs.access("/etc/config/aliddns") then
        return
    end

    local page

    page = entry({
        "admin",
        "services",
        "aliddns"
    }, cbi("aliddns"), _("DDNS"), 30)
    page.dependent = true
end
