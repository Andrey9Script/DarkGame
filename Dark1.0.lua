loadstring(game:HttpGet("https://raw.githubusercontent.com/ahmadsgamer2/Speed-Hub-X/main/ui.lua"))()

local themes = {
    Background = Color3.fromRGB(24, 24, 24),
    Glow = Color3.fromRGB(255, 0, 0),
    Accent = Color3.fromRGB(45, 45, 45),
    LightContrast = Color3.fromRGB(20, 20, 20),
    DarkContrast = Color3.fromRGB(30, 30, 30),
    TextColor = Color3.fromRGB(255, 255, 255)
}

local page = library:AddPage("Main", 5012544693)
local section1 = page:AddSection("Main")

local main_toggle = section1:AddToggle("Main Toggle", nil, function(state)
    if state then
        print("Main Toggle is On")
    else
        print("Main Toggle is Off")
    end
end)

local section2 = page:AddSection("Section 2")
local textbox = section2:AddTextBox("TextBox", function(value)
    print("TextBox", value)
end)
local dropdown = section2:AddDropdown({"Option 1", "Option 2", "Option 3"}, function(option)
    print(option)
end)
local slider = section2:AddSlider("Slider", 0, 100, function(value)
    print(value)
end)
local button = section2:AddButton("Button", function()
    print("Button clicked")
end)
local section3 = page:AddSection("Section 3")

local colorpicker = section3:AddColorPicker("ColorPicker", function(color)
    print(color)
end)

local bindable = section3:AddKeybind("Keybind", Enum.KeyCode.Q, function()
    print("Keybind Pressed")
end)

local section4 = page:AddSection("Section 4")

local player = game.Players.LocalPlayer

local player_dropdown = section4:AddDropdown({"WalkSpeed", "JumpPower"}, function(option)
    local value = tonumber(section4:GetTextbox("Value").Text)
    if option == "WalkSpeed" then
        player.Character.Humanoid.WalkSpeed = value
    elseif option == "JumpPower" then
        player.Character.Humanoid.JumpPower = value
    end
end)

local value_textbox = section4:AddTextbox("Value", function(value)
    print("Value", value)
end)

local section5 = page:AddSection("Section 5")

local credits_label = section5:AddLabel("Made by Ahmad#9999", Color3.fromRGB(255, 255, 255))
-- Functions to change color themes
function changeTheme(theme)
    for component, color in pairs(theme) do
        library:SetColor(component, color)
    end
end

function updateTheme()
    local selected_theme = library:GetDropdown("Theme"):GetSelected()
    if selected_theme == "Theme 1" then
        changeTheme(themes)
    elseif selected_theme == "Theme 2" then
        changeTheme({
            Background = Color3.fromRGB(255, 255, 255),
            Glow = Color3.fromRGB(0, 255, 0),
            Accent = Color3.fromRGB(200, 200, 200),
            LightContrast = Color3.fromRGB(230, 230, 230),
            DarkContrast = Color3.fromRGB(210, 210, 210),
            TextColor = Color3.fromRGB(0, 0, 0)
        })
    end
end

-- Main
changeTheme(themes)

local page = library:AddPage("Main", 5012544693)
local theme_section = page:AddSection("Theme")

local theme_dropdown = theme_section:AddDropdown({"Theme 1", "Theme 2"}, updateTheme)

local section1 = page:AddSection("Main")
local main_toggle = section1:AddToggle("Main Toggle", nil, function(state)
    if state then
        print("Main Toggle is On")
    else
        print("Main Toggle is Off")
    end
end)

local section2 = page:AddSection("Section 2")
local textbox = section2:AddTextBox("TextBox", function(value)
    print("TextBox", value)
end)
local dropdown = section2:AddDropdown({"Option 1", "Option 2", "Option 3"}, function(option)
    print(option)
end)
local slider = section2:AddSlider("Slider", 0, 100, function(value)
    print(value)
end)
local button = section2:AddButton("Button", function()
    print("Button clicked")
end)

local section3 = page:AddSection("Section 3")
local colorpicker = section3:AddColorPicker("ColorPicker", function(color)
    print(color)
end)

local bindable = section3:AddKeybind("Keybind", Enum.KeyCode.Q, function()
    print("Keybind Pressed")
end)

local section4 = page:AddSection("Section 4")
local player = game.Players.LocalPlayer
local player_dropdown = section4:AddDropdown({"WalkSpeed", "JumpPower"}, function(option)
    local value = tonumber(section4:GetTextbox("Value").Text)
    if option == "WalkSpeed" then
        player.Character.Humanoid.WalkSpeed = value
    elseif option == "JumpPower" then
        player.Character.Humanoid.JumpPower = value
    end
end)
local value_textbox = section4:AddTextbox("Value", function(value)
    print("Value", value)
end)

local section5 = page:AddSection("Section 5")
local credits_label = section5:AddLabel("Made by Ahmad#9999", Color3.fromRGB(255, 255, 255))
local gun = "Combat Shotgun"
local anim = "Cock"
local delay = 0.4

if not game:IsLoaded() then
    game.Loaded:Wait()
end

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RemoteEvents = ReplicatedStorage:WaitForChild("Remotes")
local TweenService = game:GetService("TweenService")
local LocalPlayer = game:GetService("Players").LocalPlayer

local function fireGun()
    local remoteEvent = RemoteEvents:FindFirstChild("GunEvent")

    if not remoteEvent then
        return
    end

    remoteEvent:FireServer(gun, anim, delay)
end

local function tweenGui(guiObject, tweenInfo, properties)
    local tween = TweenService:Create(guiObject, tweenInfo, properties)
    tween:Play()
end

local function showGui(guiObject, duration)
    guiObject.Visible = true

    local tweenInfo = TweenInfo.new(duration)
    local properties = {
        Position = UDim2.new(0.5, 0, 0.5, 0),
        BackgroundTransparency = 0.5,
        BorderSizePixel = 0
    }

    tweenGui(guiObject, tweenInfo, properties)
end

local function hideGui(guiObject, duration)
    local tweenInfo = TweenInfo.new(duration)
    local properties = {
        Position = UDim2.new(0.5, 0, -1.5, 0),
        BackgroundTransparency = 1,
        BorderSizePixel = 0
    }

    tweenGui(guiObject, tweenInfo, properties)
    wait(duration)
    guiObject.Visible = false
end

local function onInputBegan(input, gameProcessed)
    if gameProcessed then
        return
    end

    if input.UserInputType == Enum.UserInputType.Keyboard then
        local keyCode = input.KeyCode

        if keyCode == Enum.KeyCode.Q then
            fireGun()
        elseif keyCode == Enum.KeyCode.E then
            local guiObject = script.Parent.MainFrame
            showGui(guiObject, 0.3)
        end
    end
end

local function onInputEnded(input, gameProcessed)
    if gameProcessed then
        return
    end

    if input.UserInputType == Enum.UserInputType.Keyboard then
        local keyCode = input.KeyCode

        if keyCode == Enum.KeyCode.E then
            local guiObject = script.Parent.MainFrame
            hideGui(guiObject, 0.3)
        end
    end
end

local function onCharacterAdded(character)
    character:WaitForChild("Humanoid")

    local humanoid = character:WaitForChild("Humanoid")
    humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
end

LocalPlayer.CharacterAdded:Connect(onCharacterAdded)
game:GetService("UserInputService").InputBegan:Connect(onInputBegan)
game:GetService("UserInputService").InputEnded:Connect(onInputEnded)
local function onPlayerGuiChanged(player, gui)
    if gui and gui.Name == "SpeedHubXGui" then
        local textButton = gui:WaitForChild("MainFrame"):WaitForChild("TextButton")
        textButton.Activated:Connect(function()
            fireGun()
        end)
    end
end

game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui").ChildAdded:Connect(onPlayerGuiChanged)
