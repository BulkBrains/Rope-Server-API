local Players = {}

local HttpService = game:GetService("HttpService")

local universe = script.Parent:GetAttribute("UniverseId")
local key = script.Parent:GetAttribute("ConnectionKey")

function Players.Ban(player, duration, reason)
	local playerId = player.UserId
	local url = "https://apis.bulkbrains.com/rope/players/ban?"
	local response = HttpService:GetAsync(url .. "key=" .. key .. "&universe=" .. universe .. "&player=" .. playerId .. "&banned=" .. "true" .. "&duration=" .. duration .. "&reason=" .. reason)

	local decoded = HttpService:JSONDecode(response)
	
	print(decoded)

	if (decoded.success) then
		player:Kick("You have been kicked by Rope game managment software. Reason: " .. reason .. ". Banned Until: " .. os.date("%c", decoded.duration))
	elseif (decoded.error == "server") then
		error("Rope server error, if this continues please contact support")
	elseif (decoded.error == "invalid") then
		error("Invalid UniverseId or ConnectionKey")
	end
end


function Players.Unban(player)
	local playerId = player.UserId
	local url = "https://apis.bulkbrains.com/rope/players/ban?"
	local response = HttpService:GetAsync(url .. "key=" .. key .. "&universe=" .. universe .. "&player=" .. playerId .. "&banned=" .. "false" .. "&duration=" .. "0" .. "&reason=" .. "")

	local decoded = HttpService:JSONDecode(response)

	if (decoded.success) then
		warn("Rope game managment software has unbanned " .. playerId)
	elseif (decoded.error == "server") then
		error("Rope server error, if this continues please contact support")
	elseif (decoded.error == "invalid") then
		error("Invalid UniverseId or ConnectionKey")
	end
end


function Players.Warn(player)
	local playerId = player.UserId
	local url = "https://apis.bulkbrains.com/rope/players/ban?"
	local response = HttpService:GetAsync(url .. "key=" .. key .. "&universe=" .. universe .. "&player=" .. playerId)

	local decoded = HttpService:JSONDecode(response)

	if (decoded.success) then
		warn("Rope game managment software has warned " .. playerId)
	elseif (decoded.error == "server") then
		error("Rope server error, if this continues please contact support")
	elseif (decoded.error == "invalid") then
		error("Invalid UniverseId or ConnectionKey")
	end
end


function Players.ChangeDuration(player, duration)
	local playerId = player.UserId
	local url = "https://apis.bulkbrains.com/rope/players/duration?"
	local response = HttpService:GetAsync(url .. "key=" .. key .. "&universe=" .. universe .. "&player=" .. playerId .. "&duration=" .. duration)

	local decoded = HttpService:JSONDecode(response)

	if (decoded.success) then
		warn("Rope game managment software has changed player " .. playerId .. "'s ban duration to " .. duration .. "hours")
	elseif (decoded.error == "server") then
		error("Rope server error, if this continues please contact support")
	elseif (decoded.error == "invalid") then
		error("Invalid UniverseId or ConnectionKey")
	end
end


function Players.ChangeReason(player, reason)
	local playerId = player.UserId
	local url = "https://apis.bulkbrains.com/rope/players/reason?"
	local response = HttpService:GetAsync(url .. "key=" .. key .. "&universe=" .. universe .. "&player=" .. playerId .. "&reason=" .. reason)

	local decoded = HttpService:JSONDecode(response)

	if (decoded.success) then
		warn("Rope game managment software has changed player " .. playerId .. "'s ban reason to " .. reason .. "hours")
	elseif (decoded.error == "server") then
		error("Rope server error, if this continues please contact support")
	elseif (decoded.error == "invalid") then
		error("Invalid UniverseId or ConnectionKey")
	end
end

return Players
