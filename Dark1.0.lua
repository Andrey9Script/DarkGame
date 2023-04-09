local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local Camera = workspace.CurrentCamera

local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")

local Frame = Instance.new("Frame")
local TextButton = Instance.new("TextButton")
local UIGradient = Instance.new("UIGradient")
local Shadow = Instance.new("Frame")
local ScrollingFrame = Instance.new("ScrollingFrame")
local UIGridLayout = Instance.new("UIGridLayout")

local Enabled = false

Frame.Name = "Frame"
Frame.Parent = CoreGui
Frame.Active = true
Frame.Draggable = true
Frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Frame.BorderColor3 = Color3.fromRGB(255, 255, 255)
Frame.BorderSizePixel = 2
Frame.Position = UDim2.new(0.397, 0, 0.402, 0)
Frame.Size = UDim2.new(0, 400, 0, 350)

TextButton.Name = "TextButton"
TextButton.Parent = Frame
TextButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextButton.BackgroundTransparency = 1.000
TextButton.BorderSizePixel = 0
TextButton.Position = UDim2.new(0, 0, 0, 0)
TextButton.Size = UDim2.new(0, 400, 0, 50)
TextButton.Font = Enum.Font.Gotham
TextButton.Text = "Speed Hub X"
TextButton.TextColor3 = Color3.fromRGB(255, 255, 255)
TextButton.TextSize = 22.000

UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(23, 23, 23)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(0, 0, 0))}
UIGradient.Parent = TextButton

Shadow.Name = "Shadow"
Shadow.Parent = Frame
Shadow.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Shadow.BorderSizePixel = 0
Shadow.Position = UDim2.new(0, 4, 0, 4)
Shadow.Size = UDim2.new(1, 0, 1, 0)

local function CreateButton(name, func)
    local Button = Instance.new("TextButton")
    local UIGradient_2 = Instance.new("UIGradient")

    Button.Name = name
    Button.Parent = ScrollingFrame
    Button.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Button.BackgroundTransparency = 1.000
    Button.BorderSizePixel = 0
    Button.Size = UDim2.new(0, 375, 0, 50)
    Button.Font = Enum.Font.Gotham
    Button.Text = name
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.TextSize = 18.000

    UIGradient_2.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(23, 23, 23)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(0, 0, 0))}
    UIGradient_2.Parent = Button
    
    Button.MouseButton1Click:Connect(function()
        func()
    end)
end

ScrollingFrame.Name = "ScrollingFrame"
ScrollingFrame.Parent = Frame
ScrollingFrame.Active = true
ScrollingFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
ScrollingFrame.BorderColor3 = Color3.fromRGB(255, 255, 255)
ScrollingFrame.BorderSizePixel = 0
ScrollingFrame.Position = UDim2.new(0.025, 0, 0.175, 0)
ScrollingFrame.Size = UDim2.new(0, 375, 0, 250)
ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 1000)

UIGridLayout.Parent = ScrollingFrame
UIGridLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIGridLayout.CellPadding = UDim2.new(0, 0, 0, 10)
UIGridLayout.CellSize = UDim2.new(0, 375, 0, 50)

CreateButton("WalkSpeed", function()
    local Speed = tonumber(prompt("Enter WalkSpeed", LocalPlayer.Character.Humanoid.WalkSpeed))
    if Speed then
        LocalPlayer.Character.Humanoid.WalkSpeed = Speed
    end
end)

CreateButton("JumpPower", function()
    local Power = tonumber(prompt("Enter JumpPower", LocalPlayer.Character.Humanoid.JumpPower))
    if Power then
        LocalPlayer.Character.Humanoid.JumpPower = Power
    end
end)

CreateButton("Gravity", function()
    local Gravity = tonumber(prompt("Enter Gravity", workspace.Gravity))
    if Gravity then
        workspace.Gravity = Gravity
    end
end)

CreateButton("Noclip", function()
    Enabled = not Enabled
    if Enabled then
        for _, Part in pairs(LocalPlayer.Character:GetDescendants()) do
            if Part:IsA("BasePart") then
                Part.CanCollide = false
            end
        end
    else
        for _, Part in pairs(LocalPlayer.Character:GetDescendants()) do
            if Part:IsA("BasePart") then
                Part.CanCollide = true
            end
        end
    end
end)

CreateButton("Teleport", function()
    local Position = Mouse.Hit.Position
    LocalPlayer.Character:MoveTo(Position)
end)

CreateButton("Fly", function()
    local Part = Instance.new("Part", workspace)
    Part.Anchored = true
    Part.CanCollide = false
    Part.Transparency = 1
    Part.Size = Vector3.new(5, 5, 5)
    Part.Position = LocalPlayer.Character.HumanoidRootPart.Position
    local BodyVelocity = Instance.new("BodyVelocity", Part)
    BodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
    local function Fly()
        if not Part or not Part.Parent then return end
        local Direction = Camera.CFrame.lookVector
        BodyVelocity.Velocity = Direction * 50
        RunService.RenderStepped:Wait()
        Fly()
    end
    Fly()
end)

