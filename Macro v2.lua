-- Mantener tu grab activo cuando te agarran (95% de probabilidad)
	RunService.Heartbeat:Connect(function()
		local isGrabbed =
			humanoidRootPart:FindFirstChildWhichIsA("AlignPosition") or
			humanoidRootPart:FindFirstChildWhichIsA("BodyPosition") or
			humanoidRootPart:FindFirstChildWhichIsA("VectorForce") or
			humanoidRootPart:FindFirstChildWhichIsA("BodyMover") or
			humanoidRootPart:FindFirstChildWhichIsA("AlignOrientation")

		if isGrabbed and math.random() < 0.95 then
			humanoid.PlatformStand = false
			if humanoid:GetState() == Enum.HumanoidStateType.Physics or 
			   humanoid:GetState() == Enum.HumanoidStateType.Ragdoll then
				humanoid:ChangeState(Enum.HumanoidStateType.Running)
			end
		end
	end)
end

--==========================
--Macro
--==========================

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local events = ReplicatedStorage:WaitForChild("Events")
local punchRemote = events:WaitForChild("Punch")

-- Intervalos originales
local hitDelays = {
    3.19,
    4.00,
    3.24,
    4.00,
    4.25
}

local COMBO_RESET_TIME = 1.5
local UNLOCK_FACTOR = 0.9

local lastPunch = 0
local lastComboTime = 0
local combo = 0
local isPunching = false

local function doPunch(isCharged)
    local now = os.clock()

    if isPunching then
        return
    end

    if now - lastComboTime > COMBO_RESET_TIME then
        combo = 0
    end

    local nextCombo = (combo % #hitDelays) + 1
    local currentDelay = hitDelays[nextCombo]

    if now - lastPunch < currentDelay then
        return
    end

    isPunching = true
    lastPunch = now
    lastComboTime = now
    combo = nextCombo

    local chargeValue = isCharged and 0.35 or 0

    punchRemote:FireServer(
        chargeValue,
        currentDelay,
        combo
    )

    task.delay(currentDelay * UNLOCK_FACTOR, function()
        isPunching = false
    end)
end

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then
        return
    end

    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        doPunch(false)
    elseif input.UserInputType == Enum.UserInputType.Gamepad1
        and input.KeyCode == Enum.KeyCode.ButtonX then
        doPunch(true)
    end
end)

print("Combat macro loaded")
