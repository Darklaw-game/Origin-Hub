-- This is a combined script that creates the Edgelord GUI and binds the
-- "E" button/key to toggle the visual glitch aura effect.
-- The "T" and "F" buttons/keys retain their original remote script execution functionality.

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer

-- Check for and remove existing GUI to prevent duplicates
local existingGui = player.PlayerGui:FindFirstChild("EdgelordGui")
if existingGui then
    existingGui:Destroy()
end

-- Create the ScreenGui
local EdgelordGui = Instance.new("ScreenGui")
EdgelordGui.Name = "EdgelordGui"
EdgelordGui.ResetOnSpawn = false
EdgelordGui.DisplayOrder = 1
EdgelordGui.Parent = player.PlayerGui

-- UI utility functions
local function AddCorner(frame, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius)
    corner.Parent = frame
end

local function AddStroke(frame, thickness)
    local stroke = Instance.new("UIStroke")
    stroke.Thickness = thickness
    stroke.Parent = frame
end

local function createGradient(frame, color1, color2)
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new(color1, color2)
    gradient.Parent = frame
end

-- GUI Buttons
local EAbilityButton = Instance.new("Frame", EdgelordGui)
EAbilityButton.BackgroundColor3 = Color3.new(100, 0, 0)
EAbilityButton.Size = UDim2.new(.1, 0, .22, 0)
EAbilityButton.Position = UDim2.new(0.82, 0, 0.06, 0)
EAbilityButton.Transparency = 0
EAbilityButton.Draggable = false
EAbilityButton.Visible = true

local EAbilityButtonReal = Instance.new("TextButton", EAbilityButton)
EAbilityButtonReal.Size = UDim2.new(1, 0, 1, 0)
EAbilityButtonReal.Position = UDim2.new(0, 0, 0, 0)
EAbilityButtonReal.Text = "E"
EAbilityButtonReal.TextSize = 80
EAbilityButtonReal.TextColor3 = Color3.new(255, 255, 255)
EAbilityButtonReal.Font = Enum.Font.SourceSans
EAbilityButtonReal.BackgroundTransparency = 1
AddCorner(EAbilityButton, 10)
AddStroke(EAbilityButton, 4)
createGradient(EAbilityButton, Color3.new(1, 1, 1), Color3.new(0, 0, 1))

local TAbilityButton = Instance.new("Frame", EdgelordGui)
TAbilityButton.BackgroundColor3 = Color3.new(100, 0, 0)
TAbilityButton.Size = UDim2.new(.1, 0, .22, 0)
TAbilityButton.Position = UDim2.new(0.76, 0, 0.3, 0)
TAbilityButton.Transparency = 0
TAbilityButton.Draggable = false
TAbilityButton.Visible = true

local TAbilityButtonReal = Instance.new("TextButton", TAbilityButton)
TAbilityButtonReal.Size = UDim2.new(1, 0, 1, 0)
TAbilityButtonReal.Position = UDim2.new(0, 0, 0, 0)
TAbilityButtonReal.Text = "T"
TAbilityButtonReal.TextSize = 80
TAbilityButtonReal.TextColor3 = Color3.new(255, 255, 255)
TAbilityButtonReal.Font = Enum.Font.SourceSans
TAbilityButtonReal.BackgroundTransparency = 1
AddCorner(TAbilityButton, 10)
AddStroke(TAbilityButton, 4)
createGradient(TAbilityButton, Color3.new(1, 1, 1), Color3.new(0, 0, 1))

local FAbilityButton = Instance.new("Frame", EdgelordGui)
FAbilityButton.BackgroundColor3 = Color3.new(100, 0, 0)
FAbilityButton.Size = UDim2.new(.1, 0, .22, 0)
FAbilityButton.Position = UDim2.new(0.87, 0, 0.3, 0)
FAbilityButton.Transparency = 0
FAbilityButton.Draggable = false
FAbilityButton.Visible = true

local FAbilityButtonReal = Instance.new("TextButton", FAbilityButton)
FAbilityButtonReal.Size = UDim2.new(1, 0, 1, 0)
FAbilityButtonReal.Position = UDim2.new(0, 0, 0, 0)
FAbilityButtonReal.Text = "F"
FAbilityButtonReal.TextSize = 80
FAbilityButtonReal.TextColor3 = Color3.new(255, 255, 255)
FAbilityButtonReal.Font = Enum.Font.SourceSans
FAbilityButtonReal.BackgroundTransparency = 1
AddCorner(FAbilityButton, 10)
AddStroke(FAbilityButton, 4)

local DaShowing = Instance.new("TextButton", EdgelordGui)
DaShowing.Size = UDim2.new(0.02, 0, 0.58, 0)
DaShowing.Position = UDim2.new(0.978, 0, 0.05, 0)
DaShowing.BackgroundColor3 = Color3.new(0, 0, 0)
DaShowing.Text = ">"
DaShowing.TextSize = 25
DaShowing.TextColor3 = Color3.new(255, 255, 255)
DaShowing.Font = Enum.Font.SourceSans
DaShowing.Transparency = 0.4
DaShowing.Visible = true

-- State and logic for the Dynamic Ladder
local RunService = game:GetService("RunService")
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

-- Настройки
local LADDER_DISTANCE = 4 -- Расстояние лестницы от игрока
local WALL_DISTANCE = 1.5 -- Расстояние до стены когда лестница активна
local LADDER_SIZE = Vector3.new(4, 20, 1) -- Размер лестницы (ширина, высота, толщина)
local WALL_DETECTION_DISTANCE = 6 -- Расстояние обнаружения стены

-- Создание лестницы (используем TrussPart для лазания)
local ladder = Instance.new("TrussPart")
ladder.Name = "DynamicLadder"
ladder.Size = LADDER_SIZE
ladder.Material = Enum.Material.Wood
ladder.Transparency = 1 -- Изначально невидимая
ladder.CanCollide = false -- Изначально неактивна
ladder.Anchored = true
ladder.BrickColor = BrickColor.new("Bright green")
ladder.Parent = workspace

local connection
local ladderEnabled = true

-- Функция проверки наличия стены впереди
local function checkForWall()
    if not character or not humanoidRootPart then return false end
    
    local raycastParams = RaycastParams.new()
    raycastParams.FilterDescendantsInstances = {character, ladder}
    raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
    
    local rayDirection = humanoidRootPart.CFrame.LookVector * WALL_DETECTION_DISTANCE
    local raycastResult = workspace:Raycast(humanoidRootPart.Position, rayDirection, raycastParams)
    
    return raycastResult ~= nil, raycastResult
end

-- Функция обновления позиции лестницы
local function updateLadder()
    if not ladderEnabled or not character or not humanoidRootPart then return end
    
    local hasWall, wallHit = checkForWall()
    
    -- Определяем расстояние до лестницы
    local distance = hasWall and WALL_DISTANCE or LADDER_DISTANCE
    
    -- Позиционируем лестницу перед игроком
    local playerPosition = humanoidRootPart.Position
    local playerDirection = humanoidRootPart.CFrame.LookVector
    local ladderPosition = playerPosition + playerDirection * distance
    
    -- Если есть стена, позиционируем лестницу так чтобы она заходила в стену
    if hasWall and wallHit then
        -- Помещаем лестницу прямо в точку стены, чтобы она заходила внутрь
        ladderPosition = wallHit.Position + playerDirection * 0.2
    end
    
    -- Обновляем позицию и ориентацию лестницы
    ladder.CFrame = CFrame.new(ladderPosition, ladderPosition + playerDirection)
    
    -- Включаем/выключаем возможность лазания
    ladder.CanCollide = hasWall
    ladder.Transparency = hasWall and 0.3 or 0.8
    
    if hasWall then
        ladder.BrickColor = BrickColor.new("Lime green")
        -- TrussPart автоматически позволяет лазать когда CanCollide = true
    else
        ladder.BrickColor = BrickColor.new("Bright green")
    end
end

-- Функция для переподключения к новому персонажу
local function onCharacterAdded(newCharacter)
    character = newCharacter
    humanoidRootPart = character:WaitForChild("HumanoidRootPart")
end

-- Функция очистки
local function cleanup()
    if connection then
        connection:Disconnect()
        connection = nil
    end
    if ladder and ladder.Parent then
        ladder:Destroy()
    end
end

-- Инициализация
connection = RunService.Heartbeat:Connect(updateLadder)

-- Обработка смены персонажа
player.CharacterAdded:Connect(onCharacterAdded)
player.CharacterRemoving:Connect(cleanup)

-- Toggles the ladder on/off
local function toggleLadder()
    ladderEnabled = not ladderEnabled
    
    if not ladderEnabled then
        ladder.CanCollide = false
        ladder.Transparency = 1
        EAbilityButtonReal.Text = "E"
        print("Лестница выключена")
    else
        EAbilityButtonReal.Text = "ACTIVE"
        print("Лестница включена")
    end
end

-- The "E" button now toggles the ladder.
EAbilityButtonReal.MouseButton1Click:Connect(toggleLadder)
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.E then
        toggleLadder()
    end
end)


-- Function to execute a remote script from a given URL
local function executeRemoteScript(url)
    if game:GetService("HttpService") then
        local success, result = pcall(function()
            return game:HttpGet(url, true)
        end)
        
        if success then
            local f = loadstring(result)
            if f then
                f()
                print("Remote script loaded and executed from:", url)
            else
                print("Failed to loadstring from fetched content.")
            end
        else
            warn("Failed to fetch script from URL:", url, "Error:", result)
        end
    else
        warn("HttpService is not enabled. Cannot execute remote script.")
    end
end

-- Control Logic: T key and T button (remains unchanged)
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.T then
        executeRemoteScript("https://raw.githubusercontent.com/Darklaw-game/Origin-Hub/refs/heads/main/Origin.lua")
    end
end)

TAbilityButtonReal.MouseButton1Click:Connect(function()
    executeRemoteScript("https://raw.githubusercontent.com/Darklaw-game/Origin-Hub/refs/heads/main/Origin.lua")
end)

-- Control Logic: F key and F button (remains unchanged)
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.F then
        executeRemoteScript("https://raw.githubusercontent.com/ltseverydayyou/Nameless-Admin/refs/heads/main/Source.lua")
    end
end)

FAbilityButtonReal.MouseButton1Click:Connect(function()
    executeRemoteScript("https://raw.githubusercontent.com/ltseverydayyou/Nameless-Admin/refs/heads/main/Source.lua")
end)

-- DaShowing button logic (remains unchanged)
DaShowing.MouseButton1Click:Connect(function()
    if DaShowing.Text == ">" then
        DaShowing.Text = "<"
        EAbilityButton.Visible = false
        TAbilityButton.Visible = false
        FAbilityButton.Visible = false
    else
        DaShowing.Text = ">"
        EAbilityButton.Visible = true
        TAbilityButton.Visible = true
        FAbilityButton.Visible = true
    end
end)
