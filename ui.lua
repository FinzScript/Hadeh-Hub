-- Fikri Cihuy Hub - Roblox Script GUI for Hade's RNG
-- Created by LUA Programming GOD

-- Initialization
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Clean up old GUI if exists
if CoreGui:FindFirstChild("FikriCihuyHub") then
    CoreGui.FikriCihuyHub:Destroy()
end

local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "FikriCihuyHub"
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 500, 0, 600)
MainFrame.Position = UDim2.new(0.25, 0, 0.15, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.Active = true
MainFrame.Draggable = true

local UICorner = Instance.new("UICorner", MainFrame)
UICorner.CornerRadius = UDim.new(0, 10)

local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Text = "Fikri Cihuy Hub | Hade's RNG"
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.SourceSansBold
Title.TextScaled = true

local Tabs = Instance.new("Frame", MainFrame)
Tabs.Name = "Tabs"
Tabs.Size = UDim2.new(0, 120, 1, -40)
Tabs.Position = UDim2.new(0, 0, 0, 40)
Tabs.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Instance.new("UICorner", Tabs).CornerRadius = UDim.new(0, 6)

local Pages = Instance.new("Frame", MainFrame)
Pages.Name = "Pages"
Pages.Position = UDim2.new(0, 120, 0, 40)
Pages.Size = UDim2.new(1, -120, 1, -40)
Pages.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Instance.new("UICorner", Pages).CornerRadius = UDim.new(0, 6)

local tabNames = {"Tools", "ESP", "Teleport", "Utility"}
local tabFrames = {}

for i, name in ipairs(tabNames) do
    local btn = Instance.new("TextButton", Tabs)
    btn.Size = UDim2.new(1, -10, 0, 35)
    btn.Position = UDim2.new(0, 5, 0, (i - 1) * 40 + 5)
    btn.Text = name
    btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextScaled = true
    btn.Name = name .. "Tab"

    local tabFrame = Instance.new("Frame", Pages)
    tabFrame.Name = name .. "Page"
    tabFrame.Size = UDim2.new(1, 0, 1, 0)
    tabFrame.Visible = i == 1
    tabFrame.BackgroundTransparency = 1
    tabFrames[name] = tabFrame

    btn.MouseButton1Click:Connect(function()
        for _, frame in pairs(tabFrames) do frame.Visible = false end
        tabFrame.Visible = true
    end)
end

local function createTabButton(parent, label, y, callback)
    local button = Instance.new("TextButton", parent)
    button.Size = UDim2.new(0, 300, 0, 35)
    button.Position = UDim2.new(0, 10, 0, y)
    button.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    button.TextColor3 = Color3.new(1, 1, 1)
    button.Font = Enum.Font.SourceSans
    button.Text = label
    button.TextScaled = true
    Instance.new("UICorner", button).CornerRadius = UDim.new(0, 4)
    button.MouseButton1Click:Connect(callback)
end

-- Tools Tab Buttons
local toolPage = tabFrames["Tools"]

createTabButton(toolPage, "Quick Roll", 10, function()
    for _, r in pairs(game:GetService("ReplicatedStorage"):GetDescendants()) do
        if (r:IsA("RemoteEvent") or r:IsA("RemoteFunction")) and string.lower(r.Name):find("quick") then
            pcall(function() r:FireServer() end)
            break
        end
    end
end)

createTabButton(toolPage, "Anti-AFK", 55, function()
    local vu = game:GetService("VirtualUser")
    LocalPlayer.Idled:Connect(function()
        vu:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        task.wait(1)
        vu:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    end)
end)

createTabButton(toolPage, "Auto Daily Quest", 100, function()
    for _, r in pairs(game:GetService("ReplicatedStorage"):GetDescendants()) do
        if r:IsA("RemoteEvent") and r.Name:lower():find("quest") then
            pcall(function() r:FireServer() end)
        end
    end
end)

-- ESP Tab
local espPage = tabFrames["ESP"]

local function makeESP(itemName, color)
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("Tool") and obj.Name == itemName and obj:FindFirstChild("Handle") then
            local esp = Instance.new("BillboardGui", obj.Handle)
            esp.Adornee = obj.Handle
            esp.Size = UDim2.new(0, 100, 0, 40)
            esp.AlwaysOnTop = true
            esp.Name = "ESP_TAG"
            local label = Instance.new("TextLabel", esp)
            label.Size = UDim2.new(1, 0, 1, 0)
            label.BackgroundTransparency = 1
            label.Text = itemName:upper()
            label.TextColor3 = color
            label.Font = Enum.Font.Arial
            label.TextScaled = true
        end
    end
end

createTabButton(espPage, "ESP Gwa Gwa", 10, function() makeESP("Gwa Gwa", Color3.new(1, 1, 0)) end)
createTabButton(espPage, "ESP Maxwell", 55, function() makeESP("Maxwell", Color3.new(0, 1, 0)) end)
createTabButton(espPage, "ESP Lunaris", 100, function() makeESP("Lunaris", Color3.new(0, 0.5, 1)) end)
createTabButton(espPage, "ESP Doge", 145, function() makeESP("Doge", Color3.new(1, 0.5, 0)) end)
createTabButton(espPage, "Remove All ESP", 190, function()
    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("BillboardGui") and v.Name == "ESP_TAG" then v:Destroy() end
    end
end)

-- Teleport Tab
local tpPage = tabFrames["Teleport"]

createTabButton(tpPage, "Teleport to Kvjesm", 10, function()
    local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("Model") and obj.Name == "Kvjesm" and obj:FindFirstChild("HumanoidRootPart") then
            hrp.CFrame = obj.HumanoidRootPart.CFrame + Vector3.new(0, 5, 0)
            return
        end
    end
    local msg = Instance.new("Message", workspace)
    msg.Text = "Traveling Merchant has not spawned!"
    task.wait(3)
    msg:Destroy()
end)

createTabButton(tpPage, "Teleport to Gwa Gwa", 55, function()
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("Model") and obj.Name == "Gwa Gwa" and obj:FindFirstChild("HumanoidRootPart") then
            LocalPlayer.Character.HumanoidRootPart.CFrame = obj.HumanoidRootPart.CFrame + Vector3.new(0, 5, 0)
            break
        end
    end
end)

-- Utility Tab
local utilPage = tabFrames["Utility"]

createTabButton(utilPage, "Toggle GUI", 10, function()
    MainFrame.Visible = not MainFrame.Visible
end)

createTabButton(utilPage, "Destroy GUI", 55, function()
    ScreenGui:Destroy()
end)

createTabButton(utilPage, "Print Loaded Tabs", 100, function()
    for name, _ in pairs(tabFrames) do
        print("Tab: " .. name)
    end
end)

-- Footer Credit
local credit = Instance.new("TextLabel", MainFrame)
credit.Size = UDim2.new(1, 0, 0, 25)
credit.Position = UDim2.new(0, 0, 1, -25)
credit.BackgroundTransparency = 1
credit.Text = "Fikri Cihuy Hub | Scripted by LUA Programming GOD"
credit.Font = Enum.Font.SourceSans
credit.TextColor3 = Color3.fromRGB(255, 255, 255)
credit.TextScaled = true
