
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local events = ReplicatedStorage:WaitForChild("Events")
local punchRemote = events:WaitForChild("Punch")

local TOGGLE_KEY = Enum.KeyCode.P
local enabled = false

local hitDelays = {
    3.15,
    3.90,
    3.15,
    3.90,
    4.20
}

local lastPunch = 0
local combo = 0
local lastComboTime = 0
local isPunching = false

local function doPunch(isCharged)
    if not enabled then return end

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

    if input.KeyCode == TOGGLE_KEY then
        enabled = not enabled
        print("Script: " .. (enabled and "ACTIVADO" or "DESACTIVADO"))
        return
    end

    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        doPunch(false)
    end

    if input.UserInputType == Enum.UserInputType.Gamepad1
        and input.KeyCode == Enum.KeyCode.ButtonX then
        doPunch(true)
    end
end)

print("Script cargado. Presiona P para activarlo.")

