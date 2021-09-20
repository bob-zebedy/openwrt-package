module("luci.controller.eqos", package.seeall)

function index()
    if not nixio.fs.access("/etc/config/eqos") then return end

    local page

    page = entry({"admin", "services", "eqos"}, cbi("eqos"), _("EQoS"), 1000)
    page.dependent = true
end
