ACTIVE_KEY = "5c4965bbf469ca914edb8395bd5a2b50"

local req = http_request or request or (syn and syn.request)
assert(req, "Executor khong ho tro request")

local res = req({
    Url = "https://api.imt-hub.xyz/files/v2/loaders/6mss1famhjy2gasnw5w481j8b9yr42ji.lua",
    Method = "GET"
})

local src = type(res) == "table" and (res.Body or res.body) or res

assert(type(src) == "string", "Loader response khong phai string")

local fn, err = loadstring(src)
assert(fn, "Compile error: " .. tostring(err))

fn()
