-- Script chạy trong Delta

local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local MarketplaceService = game:GetService("MarketplaceService")

-- Tạo ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "PurchaseGui"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true
screenGui.Parent = playerGui

-- Frame
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 200, 0, 50)
frame.Position = UDim2.new(0.5, -100, 0.5, -25)
frame.BackgroundTransparency = 0.3
frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
frame.Parent = screenGui

-- Button
local purchaseButton = Instance.new("TextButton")
purchaseButton.Size = UDim2.new(1, 0, 1, 0)
purchaseButton.Text = "Loading..."
purchaseButton.BackgroundTransparency = 1
purchaseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
purchaseButton.Parent = frame

-- Loading Label
local loadingLabel = Instance.new("TextLabel")
loadingLabel.Size = UDim2.new(1, 0, 1, 0)
loadingLabel.Text = "Loading..."
loadingLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
loadingLabel.BackgroundTransparency = 1
loadingLabel.Visible = true
loadingLabel.Parent = frame

-- Confirm Label
local confirmLabel = Instance.new("TextLabel")
confirmLabel.Size = UDim2.new(1, 0, 1, 0)
confirmLabel.Text = "Confirm"
confirmLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
confirmLabel.BackgroundTransparency = 1
confirmLabel.Visible = false
confirmLabel.Parent = frame

-- Chuyển sang Confirm sau 2s
task.wait(2)
loadingLabel.Visible = false
confirmLabel.Visible = true
purchaseButton.Text = "Confirm"

-- Xử lý khi bấm Confirm
purchaseButton.MouseButton1Click:Connect(function()
    if confirmLabel.Visible then
        purchaseButton.Text = "Loading..."
        confirmLabel.Visible = false
        loadingLabel.Visible = true

        -- Prompt mua GamePass
        local gamepassId = 89294735 -- 👉 thay bằng ID gamepass của bạn
        MarketplaceService:PromptGamePassPurchase(player, gamepassId)
    end
end)
