local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Create ScreenGui for Main UI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "InjectGui"
screenGui.Parent = playerGui
screenGui.IgnoreGuiInset = true
screenGui.ResetOnSpawn = false

-- Create Main Frame (UI Container)
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0.25, 0, 0.2, 0)  -- Smaller UI
mainFrame.Position = UDim2.new(0.375, 0, 0.4, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
mainFrame.BorderSizePixel = 0
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.Parent = screenGui

-- Create UI Corner (Rounded Corners)
local mainUICorner = Instance.new("UICorner")
mainUICorner.CornerRadius = UDim.new(0, 10)
mainUICorner.Parent = mainFrame

-- Create Title Label (No Dragging)
local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, 0, 0.2, 0)
titleLabel.Position = UDim2.new(0, 0, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "Dolphin Injector"
titleLabel.TextScaled = true
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
titleLabel.Parent = mainFrame

-- Create Inject Button
local injectButton = Instance.new("TextButton")
injectButton.Size = UDim2.new(0.8, 0, 0.3, 0)
injectButton.Position = UDim2.new(0.1, 0, 0.5, 0)
injectButton.Text = "Inject"
injectButton.TextScaled = true
injectButton.Font = Enum.Font.GothamBold
injectButton.BackgroundColor3 = Color3.fromRGB(70, 130, 180)
injectButton.TextColor3 = Color3.fromRGB(255, 255, 255)
injectButton.BorderSizePixel = 0
injectButton.Parent = mainFrame

-- Add Rounded Corners to Button
local buttonCorner = Instance.new("UICorner")
buttonCorner.CornerRadius = UDim.new(0, 6)
buttonCorner.Parent = injectButton

-- Add Hover Effect to Button
injectButton.MouseEnter:Connect(function()
    injectButton.BackgroundColor3 = Color3.fromRGB(90, 160, 210)
end)
injectButton.MouseLeave:Connect(function()
    injectButton.BackgroundColor3 = Color3.fromRGB(70, 130, 180)
end)

-- Create Loading Bar Frame
local loadingBarBg = Instance.new("Frame")
loadingBarBg.Size = UDim2.new(0.8, 0, 0.1, 0)
loadingBarBg.Position = UDim2.new(0.1, 0, 0.85, 0)
loadingBarBg.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
loadingBarBg.BorderSizePixel = 0
loadingBarBg.Parent = mainFrame

-- Add Rounded Corners to Loading Bar
local loadingBarCorner = Instance.new("UICorner")
loadingBarCorner.CornerRadius = UDim.new(0, 6)
loadingBarCorner.Parent = loadingBarBg

-- Create Inner Loading Bar
local innerLoadingBar = Instance.new("Frame")
innerLoadingBar.Size = UDim2.new(0, 0, 1, 0)
innerLoadingBar.BackgroundColor3 = Color3.fromRGB(70, 130, 180)
innerLoadingBar.BorderSizePixel = 0
innerLoadingBar.Parent = loadingBarBg

-- Create Progress Label (Larger Text)
local progressLabel = Instance.new("TextLabel")
progressLabel.Size = UDim2.new(1, 0, 0.3, 0)
progressLabel.Position = UDim2.new(0, 0, 0.5, 0)
progressLabel.BackgroundTransparency = 1
progressLabel.Text = "0%"
progressLabel.TextSize = 30  -- Increased the text size
progressLabel.Font = Enum.Font.GothamBold
progressLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
progressLabel.Parent = loadingBarBg

-- Functions for Injecting
local function startInjecting()
    -- Simulate loading process
    local totalTime = 5  -- Adjust the time as needed
    local startTime = tick()
    while tick() - startTime < totalTime do
        local progress = (tick() - startTime) / totalTime
        innerLoadingBar.Size = UDim2.new(progress, 0, 1, 0)
        progressLabel.Text = math.floor(progress * 100) .. "%"
        wait(0.1)
    end

    -- After 100% progress, run the code (loadstring)
    local success, errorMessage = pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/UniDCYT/Dolhin-Tsb-Private-Cheat/refs/heads/main/MainCheat.lua"))()
    end)

    -- Check if the code ran successfully
    if success then
        print("Injection Complete!")
    else
        print("Error during injection: " .. errorMessage)
    end

    -- Close the UI after injection is done
    screenGui.Enabled = false
end

injectButton.MouseButton1Click:Connect(function()
    startInjecting()
end)