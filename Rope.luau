local Rope = {
	["Players"] = require(script.Players),
}

local PlayersService = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local ReplicatedFirst = game:GetService("ReplicatedFirst")

Rope.Version = 1.0

local universe = script:GetAttribute("UniverseId")
local key = script:GetAttribute("ConnectionKey")
local showSplash = script:GetAttribute("ShowSplash")


function GetPlayer (player)
	local url = "https://apis.bulkbrains.com/rope/players/fetch?"

	return HttpService:GetAsync(url .. "key=" .. key .. "&universe=" .. universe .. "&player=" .. player)
end

function renderSplash (player)
	if (showSplash == true) then
		local playerGui = player:WaitForChild("PlayerGui")

		local splash = script.Splash:Clone()
		splash.Parent = playerGui

		ReplicatedFirst:RemoveDefaultLoadingScreen()

		task.wait(5)

		splash:Destroy()
	end
end

PlayersService.PlayerAdded:Connect(function (player)
	renderSplash(player)
	
	local response = GetPlayer(player.UserId)
	local decoded = HttpService:JSONDecode(response)
	
	if (decoded.banned == true) then
		local durationString = tostring(decoded.duration)
		local duration10 = string.sub(durationString, 1, 10)
		local durationInt = tonumber(duration10)
		local durationFormat = os.date("%c", durationInt)
		
		player:Kick("You have been kicked by Rope game managment software. Reason: " .. decoded.reason .. ". Banned Until: " .. durationFormat)
	elseif (decoded.error == "server") then
			error("Rope server error, if this continues please contact support")
	elseif (decoded.error == "invalid") then
		error("Invalid UniverseId or ConnectionKey")
	end
end)

return Rope
