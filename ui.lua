-- Hadeh Hub by Kamu Sendiri
local HadehHub = Instance.new("ScreenGui")
local Main = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local OpenButton = Instance.new("TextButton")

-- Parent ke CoreGui biar aman
HadehHub.Name = "HadehHub"
HadehHub.ResetOnSpawn = false
HadehHub.Parent = game.CoreGui

-- Open/Close Button
OpenButton.Name = "OpenButton"
OpenButton.Parent = HadehHub
OpenButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
OpenButton.Position = UDim2.new(0, 10, 0.5, -25)
OpenButton.Size = UDim2.new(0, 60, 0, 25)
OpenButton.Text = "Open"
OpenButton.TextColor3 = Color3.new(1,1,1)
OpenButton.TextScaled = true
OpenButton.Font = Enum.Font.GothamBold

-- Main UI
Main.Name = "Main"
Main.Parent = HadehHub
Main.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Main.Position = UDim2.new(0.05, 0, 0.2, 0)
Main.Size = UDim2.new(0, 250, 0, 200)
Main.Visible = false
Main.BorderSizePixel = 0

-- Title
Title.Name = "Title"
Title.Parent = Main
Title.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Text = "Hadeh Hub"
Title.TextColor3 = Color3.new(1,1,1)
Title.Font = Enum.Font.GothamBold
Title.TextScaled = true

-- Open / Close toggle
OpenButton.MouseButton1Click:Connect(function()
	Main.Visible = not Main.Visible
	OpenButton.Text = Main.Visible and "Close" or "Open"
end)
