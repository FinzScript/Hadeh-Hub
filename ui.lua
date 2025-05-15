-- Hadeh Hub v2 - Final Version dengan Loading Screen & Timer
if game.CoreGui:FindFirstChild("HadehHub") then
    game.CoreGui:FindFirstChild("HadehHub"):Destroy()
end

local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local rollRemote = ReplicatedStorage:FindFirstChild("Roll") or ReplicatedStorage:FindFirstChild("RollRemote")

local npcList = { "Gwa Gwa", "Mina", "Kvjesm", "Midori", "Koin", "Henben", "Aqua", "DarkLuna", "Binjun" }
local itemList = { "Gwa Gwa", "Doge", "Lunaris", "Maxwell" }

-- GUI Init
local gui = Instance.new("ScreenGui")
gui.Name = "HadehHub"
gui.ResetOnSpawn = false
gui.Parent = game:GetService("CoreGui")

-- Loading Screen
local loadingFrame = Instance.new("Frame", gui)
loadingFrame.Size = UDim2.new(1, 0, 1, 0)
loadingFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
local loadingText = Instance.new("TextLabel", loadingFrame)
loadingText.Size = UDim2.new(0, 300, 0, 50)
loadingText.Position = UDim2.new(0.5, -150, 0.5, -25)
loadingText.Text = "Memuat Hadeh Hub..."
loadingText.TextScaled = true
loadingText.TextColor3 = Color3.new(1, 1, 1)
loadingText.BackgroundTransparency = 1
loadingText.Font = Enum.Font.GothamBold

wait(1.5)
loadingFrame:Destroy()

-- Main Frame
local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 260, 0, 330)
main.Position = UDim2.new(0, 20, 0.3, 0)
main.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
main.BorderSizePixel = 0

local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1, 0, 0, 30)
title.Text = "Hadeh Hub"
title.TextColor3 = Color3.new(1, 1, 1)
title.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
title.Font = Enum.Font.GothamBold
title.TextScaled = true

-- NPC Dropdown
local drop = Instance.new("TextButton", main)
drop.Size = UDim2.new(1, -20, 0, 30)
drop.Position = UDim2.new(0, 10, 0, 40)
drop.Text = "Pilih NPC"
drop.TextColor3 = Color3.new(1,1,1)
drop.Font = Enum.Font.Gotham
drop.TextScaled = true
drop.BackgroundColor3 = Color3.fromRGB(60,60,60)

local dropFrame = Instance.new("Frame", drop)
dropFrame.Position = UDim2.new(0, 0, 1, 0)
dropFrame.Size = UDim2.new(1, 0, 0, #npcList * 25)
dropFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
dropFrame.Visible = false
dropFrame.ClipsDescendants = true

local selectedNPC = nil
for i, npc in ipairs(npcList) do
    local opt = Instance.new("TextButton", dropFrame)
    opt.Size = UDim2.new(1, 0, 0, 25)
    opt.Position = UDim2.new(0, 0, 0, (i - 1) * 25)
    opt.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    opt.Text = npc
    opt.TextColor3 = Color3.new(1,1,1)
    opt.Font = Enum.Font.Gotham
    opt.TextScaled = true

    opt.MouseButton1Click:Connect(function()
        selectedNPC = npc
        drop.Text = npc
        dropFrame.Visible = false
    end)
end

drop.MouseButton1Click:Connect(function()
    dropFrame.Visible = not dropFrame.Visible
end)

-- Tombol Teleport
local teleportBtn = Instance.new("TextButton", main)
teleportBtn.Size = UDim2.new(1, -20, 0, 30)
teleportBtn.Position = UDim2.new(0, 10, 0, 80)
teleportBtn.Text = "Teleport"
teleportBtn.TextColor3 = Color3.new(1, 1, 1)
teleportBtn.BackgroundColor3 = Color3.fromRGB(50, 100, 50)
teleportBtn.Font = Enum.Font.Gotham
teleportBtn.TextScaled = true

teleportBtn.MouseButton1Click:Connect(function()
    if selectedNPC then
        for _, obj in pairs(workspace:GetChildren()) do
            if obj.Name == selectedNPC and obj:IsA("Model") then
                local root = obj:FindFirstChild("HumanoidRootPart") or obj:FindFirstChildWhichIsA("BasePart")
                if root then
                    hrp.CFrame = root.CFrame + Vector3.new(0, 5, 0)
                    break
                end
            end
        end
    end
end)

-- Tombol Quick Roll
local rollBtn = Instance.new("TextButton", main)
rollBtn.Size = UDim2.new(1, -20, 0, 30)
rollBtn.Position = UDim2.new(0, 10, 0, 130)
rollBtn.Text = "Quick Roll"
rollBtn.TextColor3 = Color3.new(1, 1, 1)
rollBtn.BackgroundColor3 = Color3.fromRGB(100, 50, 50)
rollBtn.Font = Enum.Font.Gotham
rollBtn.TextScaled = true

rollBtn.MouseButton1Click:Connect(function()
    if rollRemote and rollRemote:IsA("RemoteEvent") then
        rollRemote:FireServer()
    else
        warn("Remote Roll tidak ditemukan.")
    end
end)

-- Teleport Merchant (Kvjesm)
local merchantBtn = Instance.new("TextButton", main)
merchantBtn.Size = UDim2.new(1, -20, 0, 30)
merchantBtn.Position = UDim2.new(0, 10, 0, 180)
merchantBtn.Text = "Teleport to Merchant (Kvjesm)"
merchantBtn.TextColor3 = Color3.new(1, 1, 1)
merchantBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 110)
merchantBtn.Font = Enum.Font.Gotham
merchantBtn.TextScaled = true

local function notify(text)
    local notif = Instance.new("TextLabel", gui)
    notif.Size = UDim2.new(0, 300, 0, 40)
    notif.Position = UDim2.new(0.5, -150, 0.2, 0)
    notif.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    notif.BorderSizePixel = 0
    notif.TextColor3 = Color3.new(1, 1, 1)
    notif.Font = Enum.Font.GothamBold
    notif.TextScaled = true
    notif.Text = text
    notif.AnchorPoint = Vector2.new(0.5, 0)
    game:GetService("TweenService"):Create(notif, TweenInfo.new(0.5), {BackgroundTransparency = 0.2}):Play()
    wait(2)
    notif:Destroy()
end

merchantBtn.MouseButton1Click:Connect(function()
    local foundKvjesm = false
    for _, obj in pairs(workspace:GetChildren()) do
        if obj.Name == "Kvjesm" and obj:IsA("Model") then
            local root = obj:FindFirstChild("HumanoidRootPart") or obj:FindFirstChildWhichIsA("BasePart")
            if root then
                hrp.CFrame = root.CFrame + Vector3.new(0, 5, 0)
                foundKvjesm = true
                break
            end
        end
    end
    if not foundKvjesm then
        notify("Kvjesm tidak sedang spawn.")
    end
end)

-- Auto Collect Item
spawn(function()
    while wait(2) do
        pcall(function()
            for _, item in pairs(workspace:GetChildren()) do
                if table.find(itemList, item.Name) and item:IsA("Model") then
                    local part = item:FindFirstChild("MainPart") or item:FindFirstChildWhichIsA("BasePart")
                    if part and part:FindFirstChildOfClass("ProximityPrompt") then
                        hrp.CFrame = part.CFrame + Vector3.new(0, 5, 0)
                        fireproximityprompt(part:FindFirstChildOfClass("ProximityPrompt"))
                        wait(1)
                    end
                end
            end
        end)
    end
end)

-- Timer (Playtime)
local timerLabel = Instance.new("TextLabel", gui)
timerLabel.Size = UDim2.new(0, 140, 0, 30)
timerLabel.Position = UDim2.new(0.5, -70, 0, 10)
timerLabel.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
timerLabel.TextColor3 = Color3.new(1, 1, 1)
timerLabel.Font = Enum.Font.Gotham
timerLabel.TextScaled = true
timerLabel.Text = "Waktu: 00:00"
timerLabel.BorderSizePixel = 0

local seconds = 0
spawn(function()
    while true do
        wait(1)
        seconds += 1
        local minutes = math.floor(seconds / 60)
        local sec = seconds % 60
        timerLabel.Text = string.format("Waktu: %02d:%02d", minutes, sec)
    end
end)
