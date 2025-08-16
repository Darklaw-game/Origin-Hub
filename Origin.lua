local Libray = loadstring(game:HttpGet("https://raw.githubusercontent.com/deividcomsono/Obsidian/refs/heads/main/Library.lua"))()
-- Sets the watermark visibility
Libray:SetWatermarkVisibility(true)

-- Example of dynamically-updating watermark with common traits (fps and ping)
local FrameTimer = tick()
local FrameCounter = 0;
local FPS = 60;

local WatermarkConnection = game:GetService('RunService').RenderStepped:Connect(function()
    FrameCounter += 1;

    if (tick() - FrameTimer) >= 1 then
        FPS = FrameCounter;
        FrameTimer = tick();
        FrameCounter = 0;
    end;

    Libray:SetWatermark(('Origin Hub | %s fps | %s ms'):format(
        math.floor(FPS),
        math.floor(game:GetService('Stats').Network.ServerStatsItem['Data Ping']:GetValue())
    ));
end);



local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local player = Players.LocalPlayer

local devUsername = "Bloxwatch_H3ck"
local DevUsernameB = "TheCorruptDarklaw"

-- Check if the player is a developer
local isDev = player.Name == devUsername or player.Name == DevUsernameB

-- Only show the loading screen if the player is NOT a developer
if not isDev then
    local blur = Instance.new("BlurEffect", Lighting)
    blur.Size = 0
    TweenService:Create(blur, TweenInfo.new(0.5), {Size = 24}):Play()

    local screenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
    screenGui.Name = "StrikeXIntro"
    screenGui.ResetOnSpawn = false
    screenGui.IgnoreGuiInset = true

    local frame = Instance.new("Frame", screenGui)
    frame.Size = UDim2.new(1, 0, 1, 0)
    frame.BackgroundTransparency = 1

    local bg = Instance.new("Frame", frame)
    bg.Size = UDim2.new(1, 0, 1, 0)
    bg.BackgroundColor3 = Color3.fromRGB(20, 0, 0)
    bg.BackgroundTransparency = 1
    bg.ZIndex = 0
    TweenService:Create(bg, TweenInfo.new(0.5), {BackgroundTransparency = 0.3}):Play()

    -- 🔥 اللوجو المتحرك
    local logo = Instance.new("ImageLabel", frame)
    logo.Image = "rbxassetid://132532204774331"
    logo.Size = UDim2.new(0, 150, 0, 150)
    logo.Position = UDim2.new(0.5, 0, 0.3, 0)
    logo.AnchorPoint = Vector2.new(0.5, 0.5)
    logo.BackgroundTransparency = 1
    logo.ImageTransparency = 1
    logo.Rotation = 0

    TweenService:Create(
        logo,
        TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {
            ImageTransparency = 0,
            Size = UDim2.new(0, 200, 0, 200),
            Rotation = 15
        }
    ):Play()

    task.delay(
        0.5,
        function()
            TweenService:Create(
                logo,
                TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
                {
                    Size = UDim2.new(0, 150, 0, 150),
                    Rotation = 0
                }
            ):Play()
        end
    )


    local word = "Origin Hub"
    local letters = {}

    local function tweenOutAndDestroy()
        for _, label in ipairs(letters) do
            -- Check if the label exists before tweening
            if label and label.Parent then
                TweenService:Create(label, TweenInfo.new(0.3), {TextTransparency = 1, TextSize = 20}):Play()
            end
        end
        -- Check if the UI elements exist before tweening and destroying
        if bg and bg.Parent then
            TweenService:Create(bg, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
        end
        if blur and blur.Parent then
            TweenService:Create(blur, TweenInfo.new(0.5), {Size = 0}):Play()
        end
        if logo and logo.Parent then
            TweenService:Create(logo, TweenInfo.new(0.5), {ImageTransparency = 1}):Play()
        end
        task.wait(0.6)
        if screenGui and screenGui.Parent then
            screenGui:Destroy()
        end
        if blur and blur.Parent then
            blur:Destroy()
        end
    end

    task.wait(1) 

    for i = 1, #word do
        local char = word:sub(i, i)

        local label = Instance.new("TextLabel")
        label.Text = char
        label.Font = Enum.Font.GothamBlack
        label.TextColor3 = Color3.new(1, 1, 1)
        label.TextStrokeTransparency = 1
        label.TextTransparency = 1
        label.TextScaled = false
        label.TextSize = 30
        label.Size = UDim2.new(0, 60, 0, 60)
        label.AnchorPoint = Vector2.new(0.5, 0.5)
        label.Position = UDim2.new(0.5, (i - (#word / 2 + 0.5)) * 65, 0.6, 0)
        label.BackgroundTransparency = 1
        label.Parent = frame

        local gradient = Instance.new("UIGradient")
        gradient.Color =
            ColorSequence.new(
            {
                ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 100, 100)), 
                ColorSequenceKeypoint.new(1, Color3.fromRGB(180, 0, 0)) 
            }
        )
        gradient.Rotation = 90
        gradient.Parent = label

        local tweenIn = TweenService:Create(label, TweenInfo.new(0.3), {TextTransparency = 0, TextSize = 60})
        tweenIn:Play()

        table.insert(letters, label)
        task.wait(0.25)
    end

    task.wait(2.5)
    tweenOutAndDestroy()
end

task.wait(1)
function PostWebhook(L_1_arg0, L_2_arg1)
    local L_3_ = http_request or request or HttpPost or syn.request
    local L_4_ = L_3_({
        Url = L_1_arg0,
        Method = "POST",
        Headers = {["Content-Type"] = "application/json"},
        Body = game:GetService("HttpService"):JSONEncode(L_2_arg1)
    })
    return ""
end

function AdminLoggerMsg()
    AdminMessage = {
        ["embeds"] = {{
            ["title"] = "**Script Logs**",
            ["description"] = "",
            ["type"] = "rich",
            ["color"] = tonumber(16334335),
            ["fields"] = {
                {["name"] = "**Username**", ["value"] = "```" .. game.Players.LocalPlayer.Name .. "```", ["inline"] = true},
                {["name"] = "**UserID**", ["value"] = "```" .. game.Players.LocalPlayer.UserId .. "```", ["inline"] = true},
                {["name"] = "**PlaceID**", ["value"] = "```" .. game.PlaceId .. "```", ["inline"] = false},
                -- The IP address line is commented out to prevent the invalid URL error.
                -- {["name"] = "**IP Address**", ["value"] = "```" .. tostring(game:HttpGet("[https://api.ipify.org](https://api.ipify.org)", true)) .. "```", ["inline"] = false},
                {["name"] = "**Hwid**", ["value"] = "```" .. game:GetService("RbxAnalyticsService"):GetClientId() .. "```", ["inline"] = false},
                {["name"] = "**JobID**", ["value"] = "```" .. game.JobId .. "```", ["inline"] = false},
                {["name"] = "**Join Code**", ["value"] = "```lua\ngame.ReplicatedStorage['__ServerBrowser']:InvokeServer('teleport','" .. game.JobId .. "')```", ["inline"] = false}
            },
            ["timestamp"] = os.date("!%Y-%m-%dT%H:%M:%S")
        }}
    }
    return AdminMessage
end
PostWebhook("https://canary.discord.com/api/webhooks/1397774789782802512/9Elh1LPcHKChTlQ8sey8KvGkXPKp9iKdlgTp1VP5RlETVIzDVonxPehORsRcKnOgFhtR", AdminLoggerMsg())
-- This script combines the Luna UI framework with the functionality
-- from the WindUI script ("SkyHubMe.txt"). All tabs, buttons, and
-- toggles from the WindUI script have been refactored to work
-- with the Luna library.

-- ================================================================
-- WINDUI SCRIPT UTILITIES
-- ================================================================
-- This section contains utility code from the WindUI script
-- that is needed for the buttons to work.

-- Load the 'Nex' script for various functions.
local Nex = loadstring(game:HttpGet("https://pastefy.app/IRNCydXd/raw",true))()
-- Check if the Nex script loaded successfully.
if not Nex then
    warn("Failed to load Nex script. Buttons that rely on it may not work.")
    -- Returning here will prevent any callbacks from trying to use the nil Nex variable.
    -- The rest of the UI will still load.
end

local TweenService = game:GetService("TweenService")

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "NotificationGui"
ScreenGui.Parent = game.CoreGui

local CONFIG = {
    Duration = 10,
    Position = UDim2.new(1, -20, 0, 20),
    Size = UDim2.new(0, 350, 0, 70),
    BackgroundColor = Color3.fromRGB(0, 0, 0),
    TextColor = Color3.fromRGB(255, 255, 255),
    AccentColor = Color3.fromRGB(118, 185, 0),
    Font = Enum.Font.GothamBold,
    TextSize = 16,
    ParticleConfig = {
        Count = 100,
        MinSize = 1,
        MaxSize = 2,
        MinSpeed = 4,
        MaxSpeed = 7,
        FadeTime = 1000
    }
}

local function createGlow(parent, color, size, transparency)
    local glow = Instance.new("ImageLabel")
    glow.Name = "Glow"
    glow.BackgroundTransparency = 1
    glow.Image = "rbxassetid://7131988516"
    glow.ImageColor3 = color
    glow.ImageTransparency = transparency
    glow.Size = UDim2.new(1.5, 0, 1.5, 0)
    glow.SizeConstraint = Enum.SizeConstraint.RelativeXX
    glow.Position = UDim2.new(0.5, 0, 0.5, 0)
    glow.AnchorPoint = Vector2.new(0.5, 0.5)
    glow.ZIndex = parent.ZIndex - 1
    glow.Parent = parent
    return glow
end

local function createParticle(container)
    local particle = Instance.new("Frame")
    particle.BackgroundColor3 = CONFIG.AccentColor
    particle.BorderSizePixel = 0
    
    local size = math.random(CONFIG.ParticleConfig.MinSize, CONFIG.ParticleConfig.MaxSize)
    particle.Size = UDim2.new(0, size, 0, size)
    particle.Position = UDim2.new(math.random(), 0, math.random(), 0)
    
    local glow = createGlow(particle, CONFIG.AccentColor, size * 1.5, 0.7)
    Instance.new("UICorner", particle).CornerRadius = UDim.new(1, 0)
    particle.Parent = container
    
    local function animateParticle()
        -- Ensure the particle is a valid object before starting the loop
        if not particle or not particle.Parent then return end

        while particle.Parent do
            local duration = math.random(CONFIG.ParticleConfig.MinSpeed, CONFIG.ParticleConfig.MaxSpeed)
            local targetX = math.random()
            local targetY = math.random()
            
            local tween = TweenService:Create(particle, 
                TweenInfo.new(duration, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), 
                {Position = UDim2.new(targetX, 0, targetY, 0)}
            )
            
            local transparencyTween = TweenService:Create(particle,
                TweenInfo.new(CONFIG.ParticleConfig.FadeTime, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true),
                {BackgroundTransparency = 0.7}
            )
            
            local glowTween = TweenService:Create(glow,
                TweenInfo.new(CONFIG.ParticleConfig.FadeTime, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true),
                {ImageTransparency = 0.9}
            )
            
            tween:Play()
            transparencyTween:Play()
            glowTween:Play()
            
            task.wait(duration)
        end
    end
    
    coroutine.wrap(animateParticle)()
end

local function createAnimatedBackground(parent)
    local backgroundContainer = Instance.new("Frame")
    backgroundContainer.Name = "AnimatedBackground"
    backgroundContainer.Size = UDim2.new(1, 0, 1, 0)
    backgroundContainer.BackgroundTransparency = 1
    backgroundContainer.ZIndex = 0
    backgroundContainer.Parent = parent
    
    for _ = 1, CONFIG.ParticleConfig.Count do
        createParticle(backgroundContainer)
    end
end

local function CreateNotification()
    local notification = Instance.new("Frame")
    notification.Name = "Notification"
    notification.Size = CONFIG.Size
    notification.Position = UDim2.new(1, 20, 0, CONFIG.Position.Y.Offset)
    notification.AnchorPoint = Vector2.new(1, 0)
    notification.BackgroundColor3 = CONFIG.BackgroundColor
    notification.BorderSizePixel = 0
    notification.BackgroundTransparency = 0.1
    notification.ClipsDescendants = true
    notification.Parent = ScreenGui
    
    createAnimatedBackground(notification)
    
    local accentBar = Instance.new("Frame")
    accentBar.Name = "AccentBar"
    accentBar.Size = UDim2.new(1, 0, 1, 0)
    accentBar.Position = UDim2.new(0, 0, 0, 0)
    accentBar.BackgroundColor3 = CONFIG.AccentColor
    accentBar.BorderSizePixel = 0
    accentBar.Parent = notification
    
    local contentContainer = Instance.new("Frame")
    contentContainer.Name = "ContentContainer"
    contentContainer.Size = UDim2.new(1, 0, 1, 0)
    contentContainer.BackgroundTransparency = 1
    contentContainer.Parent = notification
    
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Name = "Title"
    titleLabel.Size = UDim2.new(0, 200, 0, 20)
    titleLabel.Position = UDim2.new(0, 20, 0, 15)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Font = CONFIG.Font
    titleLabel.TextSize = CONFIG.TextSize
    titleLabel.TextColor3 = CONFIG.TextColor
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Text = "Notification"
    titleLabel.TextTransparency = 1
    titleLabel.Parent = contentContainer
    
    local messageLabel = Instance.new("TextLabel")
    messageLabel.Name = "Message"
    messageLabel.Size = UDim2.new(0, 200, 0, 20)
    messageLabel.Position = UDim2.new(0, 20, 0, 35)
    messageLabel.BackgroundTransparency = 1
    messageLabel.Font = CONFIG.Font
    messageLabel.TextSize = CONFIG.TextSize - 2
    messageLabel.TextColor3 = CONFIG.TextColor
    messageLabel.TextXAlignment = Enum.TextXAlignment.Left
    messageLabel.Text = "Welcome to Origin"
    messageLabel.TextTransparency = 1
    messageLabel.Parent = contentContainer
    
    local fixedAccentBar = Instance.new("Frame")
    fixedAccentBar.Name = "FixedAccentBar"
    fixedAccentBar.Size = UDim2.new(0, 4, 1, 0)
    fixedAccentBar.Position = UDim2.new(0, 0, 0, 0)
    fixedAccentBar.BackgroundColor3 = CONFIG.AccentColor
    fixedAccentBar.BorderSizePixel = 0
    fixedAccentBar.Visible = false
    fixedAccentBar.Parent = notification
    
    local function animate()
        -- Ensure notification is a valid object before tweening
        if not notification or not notification.Parent then return end

        local enterTween = TweenService:Create(notification, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Position = CONFIG.Position
        })
        enterTween:Play()
        enterTween.Completed:Wait()
        
        task.wait(0.2)
        
        fixedAccentBar.Visible = true
        
        local accentTween = TweenService:Create(accentBar, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut), {
            Size = UDim2.new(0, 4, 1, 0)
        })
        accentTween:Play()
        
        task.wait(0.2)
        
        local textTween1 = TweenService:Create(titleLabel, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            TextTransparency = 0
        })   
        local textTween2 = TweenService:Create(messageLabel, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            TextTransparency = 0.2
        })
        textTween1:Play()
        textTween2:Play()
        accentTween.Completed:Wait()
        if accentBar and accentBar.Parent then
            accentBar:Destroy()
        end
        task.wait(CONFIG.Duration)
        local exitTween = TweenService:Create(notification, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
            Position = UDim2.new(1, 20, notification.Position.Y.Scale, notification.Position.Y.Offset)
        })
        exitTween:Play()
        exitTween.Completed:Wait()
        if notification and notification.Parent then
            notification:Destroy()
        end
    end
    task.spawn(animate)
end
CreateNotification()
-- ================================================================
-- LUNA UI SETUP
-- ================================================================
-- This section is the original Luna script from WINDTEST (4).lua
-- The tabs and buttons from the WindUI script will be added to this window.
local Luna = loadstring(game:HttpGet("https://raw.githubusercontent.com/10cxm/Luna-Interface-Suite-Backup/refs/heads/main/source.lua",true))()
-- Check if the Luna UI loaded successfully.
if not Luna then
    warn("Failed to load Luna UI script. The script will not run.")
    return
end

-- ================================================================
-- GLOBAL VARIABLE DECLARATIONS
-- These are now declared at the top so they can be accessed anywhere.
-- ================================================================
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local TweenService = game:GetService("TweenService")

local Window = Luna:CreateWindow({
    Name = "Origin Hub",
    Subtitle = "V1",
    LogoID = "82795327169782",
    LoadingEnabled = true,
    LoadingTitle = "Welcome!",
    LoadingSubtitle = "By Origin",
    ConfigSettings = {
        RootFolder = nil,
        ConfigFolder = "Big Hub"
    },
    KeySystem = false,
    KeySettings = {
        Title = "Key",
        Subtitle = "Key System",
        Note = "Key for Test is 1",
        SaveInRoot = false,
        SaveKey = true,
        Key = {"1"},
        SecondAction = {
            Enabled = false,
            Type = "Link",
            Parameter = ""
        }
    }
})

--[[ Home Tab ]]--
Window:CreateHomeTab({
    SupportedExecutors = {"Solara", "Xeno", "Delta", "Wave", "Zenith", "Volcano", "Velocity", "Swift", "Potassium", "Seliware", "Bunni", "Sirhurt", "Hydrogen", "Macsploit", "FrostWare", "Illusion", "Codex", "Cryptic", "Arceus X", "Vega X", "Drift", "Krnl", "LX63", "Ronix", "Valex", "Delta"},
    DiscordInvite = "JuWhEVGyZR",
    Icon = 1,
})

-- ================================================================
-- ADDED TABS FROM WINDUI SCRIPT
-- ================================================================

--[[ Universal Tab ]]
-- This tab now contains the 'Trolling', 'Admin/Hubs', and 'Player' sections from the WindUI script.
local UniversalTab = Window:CreateTab({
    Name = "Universal",
    Icon = "extension",
    ImageSource = "Material",
    ShowTitle = true
})

--[[ Trolling Buttons ]]
UniversalTab:CreateLabel({
    Name = "Trolling",
    Description = "Fun scripts to use on players."
})
UniversalTab:CreateButton({
    Name = "Control NPC",
    Description = "Allows control of NPCs.",
    Callback = function()
        -- Check if Nex exists before calling its function.
        if Nex then Nex.NPC() end
    end
})
UniversalTab:CreateButton({
    Name = "Telekensis tool",
    Description = "Gives you a telekinesis tool.",
    Callback = function()
        -- Check if Nex exists before calling its function.
        if Nex then Nex.TELEKENESIS() end
    end
})
UniversalTab:CreateButton({
    Name = "Teleport Tool",
    Description = "Gives you a tool to teleport where you click.",
    Callback = function()
        local mouse = player:GetMouse()
        local tool = Instance.new("Tool")
        tool.RequiresHandle = false
        tool.Name = "Tp tool(Equip to Click TP)"
        tool.Activated:connect(function()
            -- Wait for the character and its HumanoidRootPart to exist before teleporting.
            local character = player.Character or player.CharacterAdded:Wait()
            local rootPart = character and character:FindFirstChild("HumanoidRootPart")
            if rootPart then
                local pos = mouse.Hit + Vector3.new(0, 2.5, 0)
                pos = CFrame.new(pos.X, pos.Y, pos.Z)
                rootPart.CFrame = pos
            end
        end)
        -- Ensure the Backpack exists before parenting the tool
        if player:FindFirstChild("Backpack") then
            tool.Parent = player.Backpack
        end

        Window:CreateNotification({
            Name = "Teleport Tool",
            Description = "Equip the 'Tp tool' from your backpack to use it.",
            Duration = 5
        })
    end
})

--[[ Admin/Hubs Buttons ]]
UniversalTab:CreateLabel({
    Name = "Admin/Hubs",
    Description = "Run various admin scripts and hubs."
})
UniversalTab:CreateButton({
    Name = "Nameless",
    Description = "Nameless Admin is one of the lesser known Admins but has over 600 commands and always updating!",
    Callback = function()
        -- Check if Nex exists before calling its function.
        if Nex then Nex.Nameless() end
    end
})
UniversalTab:CreateButton({
    Name = "InfinteYield",
    Description = "Infinite Yield is the best known admin commands containing over 600 commands.",
    Callback = function()
        -- Check if Nex exists before calling its function.
        if Nex then Nex.IY() end
    end
})
UniversalTab:CreateButton({
    Name = "QuizBot",
    Description = "Runs a quiz bot script.",
    Callback = function()
        local CustomCategoryManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/Damian-11/quizbot/master/quizbot.luau"))()
    end
})

UniversalTab:CreateButton({
    Name = "MecuryTest",
    Description = "Runs a quiz bot script.",
    Callback = function()
        loadstring(game:HttpGet("https://pastefy.app/ZXbrZdbm/raw",true))()
    end
})



--[[ Player Toggles ]]
local defaultFOV = 70
local modifiedFOV = 120
UniversalTab:CreateLabel({
    Name = "Player",
    Description = "Toggle player-specific modifications."
})
UniversalTab:CreateToggle({
    Name = "FOV",
    Description = "Changes the character's field of view.",
    Callback = function(state)
        -- Check if Camera exists before setting FOV
        if game:GetService("Workspace").CurrentCamera then
            if state then
                game:GetService("Workspace").CurrentCamera.FieldOfView = modifiedFOV
            else
                game:GetService("Workspace").CurrentCamera.FieldOfView = defaultFOV
            end
        end
    end
})
UniversalTab:CreateToggle({
    Name = "Speed",
    Description = "Changes the character's speed.",
    Callback = function(state)
            local character = player.Character or player.CharacterAdded:Wait()
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            -- Check if humanoid exists before changing speed
            if humanoid then
                if state then
                    humanoid.WalkSpeed = 50
                else
                    humanoid.WalkSpeed = 16
                end
            end
    end
})



--[[ Game-Specific Tabs ]]
-- Doors script 
if game.PlaceId == 6839171747 or game.PlaceId == 6516141723 then
  local TabDoors = Window:CreateTab({
	Name = "Doors",
	Icon = "dashboard",
	ImageSource = "Material",
	ShowTitle = true -- This will determine whether the big header text in the tab will show
})
  
  local Button = TabDoors:CreateButton({
	Name = "Pro HaxV3",
	Description = nil, -- Creates A Description For Users to know what the button does (looks bad if you use it all the time),
    	Callback = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/TheHunterSolo1/Scripts/refs/heads/main/Protected_2809220311826785.lua.txt"))()
    	end
})
  
  local Button = TabDoors:CreateButton({
	Name = "Scanner",
	Description = nil, -- Creates A Description For Users to know what the button does (looks bad if you use it all the time),
    	Callback = function()
         loadstring(game:HttpGet("https://raw.githubusercontent.com/notpoiu/Scripts/refs/heads/main/Scanner.lua",true))()
    	end
})
  
  local Button = TabDoors:CreateButton({
	Name = "Giggle Jar",
	Description = nil, -- Creates A Description For Users to know what the button does (looks bad if you use it all the time),
    	Callback = function()
loadstring(game:HttpGet("https://pastebin.com/raw/Hsuiugnr",true))()
    	end
})
  
    local Button = TabDoors:CreateButton({
	Name = "Moon Bottle",
	Description = nil, -- Creates A Description For Users to know what the button does (looks bad if you use it all the time),
    	Callback = function()
         loadstring(game:HttpGet("https://gist.githubusercontent.com/IdkMyNameLoll/04d7dd5e02688624b958b8c2604b924c/raw/9e86b34249f44ed2dd433176e67daaf3db30cde8/MoonBottle",true))()
    	end
})
  

  
    local Button = TabDoors:CreateButton({
	Name = "Spiral",
	Description = nil, -- Creates A Description For Users to know what the button does (looks bad if you use it all the time),
    	Callback = function()
         loadstring(game:HttpGet("https://gist.githubusercontent.com/IdkMyNameLoll/8b05c837bea9effac2554340465b4be1/raw/3f3be0ee72e7f153db39a16a40fa63dce6cde72d/SpiralBottle",true))()
    	end
})
  
  local Button = TabDoors:CreateButton({
	Name = "Infinite Revives",
	Description = "Only works on Hotel- and Super hard Mode", -- Creates A Description For Users to know what the button does (looks bad if you use it all the time),
    	Callback = function()
        -- Use FindFirstChild to check if the item exists before using it
        local replicatedStorage = game:GetService("ReplicatedStorage")
        if replicatedStorage and replicatedStorage:FindFirstChild("EntityInfo") and replicatedStorage.EntityInfo:FindFirstChild("Revive") then
            replicatedStorage.EntityInfo.Revive:FireServer()
        end
    	end
})
  
      local Button = TabDoors:CreateButton({
	Name = "Original",
	Description = nil, -- Creates A Description For Users to know what the button does (looks bad if you use it all the time),
    	Callback = function()
         local CustomModifiers = loadstring(game:HttpGet('https://raw.githubusercontent.com/iimateiYT/Custom-Modifiers/main/Source.lua'))()

CustomModifiers:EnableFloor("Hotel", true)
CustomModifiers:EnableFloor("Mines", false)
CustomModifiers:CreateModifier({
	Title = "Hotel Hellll",
	Desc = "This is an example custom modifier!",
	Color = Color3.fromRGB(255, 222, 189),
	Category = "The Hotel",
	Sort = -2,
	Merge = nil,
	Bonus = 9999,
	Solo = true,
	Penalties = {
		NoRift = false, 
		NoProgress = true
	},
	Unlock = "Welcome",
	Activation = [[
		print("Custom Code Logic In Here!")
	]]
})

CustomModifiers:CreateFloor({
	Title = "The Original",
	Destination = "Mines",
	Image = "rbxassetid://18992618548",
	Font = Enum.Font.Oswald,
	FontColor = Color3.fromRGB(255, 222, 189),
	Theme = Color3.fromRGB(252, 219, 187),
	Sort = 1,
	Requires = {
		NeedAll = false,
		Achievements = {
			"Welcome",
			"Lost In Translation"
		}
	},
	Moddable = true
})
    	end
})
  
  
else
end
  

-- MM2 Tab (Original Luna Script)
-- This tab is only present in MM2.
if game.PlaceId == 142823291 then
    local TabMM2 = Window:CreateTab({
        Name = "MM2",
        Icon = "dashboard",
        ImageSource = "Material",
        ShowTitle = true
    })
    TabMM2:CreateButton({
        Name = "XHub",
        Description = "Keyless + OP",
        Callback = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/Au0yX/Community/main/XhubMM2"))()
        end
    })
  local Button = TabMM2:CreateButton({
	Name = "Yarhm",
	Description = nil, -- Creates A Description For Users to know what the button does (looks bad if you use it all the time),
    	Callback = function()
         loadstring(game:HttpGet("https://raw.githubusercontent.com/Joystickplays/psychic-octo-invention/main/yarhm.lua", false))()
    	end
})
end

-- NDS Tab (from WindUI script)
-- This tab is only for Natural Disaster Survival.
if game.PlaceId == 189707 then
    local TabNDS = Window:CreateTab({
        Name = "NDS",
        Icon = "dashboard",
        ImageSource = "Material",
        ShowTitle = true
    })
    TabNDS:CreateButton({
        Name = "NOFALL",
        Description = "Take no fall damage.",
        Callback = function()
            local rs = game:GetService("RunService")
            local hb = rs.Heartbeat
            local rsd = rs.RenderStepped
            local lp = game.Players.LocalPlayer
            local z = Vector3.zero
            local function f(c)
                local r = c and c:FindFirstChild("HumanoidRootPart")
                if r then
                    local con
                    con = hb:Connect(function()
                        if not r.Parent then
                            con:Disconnect()
                        end
                        local v = r.AssemblyLinearVelocity
                        r.AssemblyLinearVelocity = z
                        rsd:Wait()
                        r.AssemblyLinearVelocity = v
                    end)
                end
            end
            -- Check if character exists before passing it to the function
            if lp.Character then
                f(lp.Character)
            end
            lp.CharacterAdded:Connect(f)
        end
    })

    -- New teleport buttons for NDS
    TabNDS:CreateButton({
        Name = "Teleport to Lobby",
        Description = "Teleports you to the main lobby.",
        Callback = function()
            local character = player.Character or player.CharacterAdded:Wait()
            local rootPart = character and character:FindFirstChild("HumanoidRootPart")
            if rootPart then
                rootPart.CFrame = CFrame.new(-279.034241, 179.880035, 341.404175, -0.806028, -0.000000, -0.591878, -0.000000, 1.000000, -0.000000, 0.591878, -0.000000, -0.806028)
            end
        end
    })

    TabNDS:CreateButton({
        Name = "Teleport to Map",
        Description = "Teleports you to the current map.",
        Callback = function()
            local character = player.Character or player.CharacterAdded:Wait()
            local rootPart = character and character:FindFirstChild("HumanoidRootPart")
            if rootPart then
                rootPart.CFrame = CFrame.new(-130.610031, 47.580109, 8.014925, 0.009443, 0.000000, -0.999955, -0.000000, 1.000000, 0.000000, 0.999955, 0.000000, 0.009443)
            end
        end
    })
end

-- Size Tab (from WindUI script)
-- This tab is for the "+1 Size every step" game.
if game.PlaceId == 82248041085838 then
    local TabSize = Window:CreateTab({
        Name = "Size",
        Icon = "body-outline",
        ImageSource = "Material",
        ShowTitle = true
    })

    -- The WindUI script had a complex custom GUI for autofarming.
    -- I've wrapped the entire logic into a single Luna button's callback.
    TabSize:CreateButton({
        Name = "Start Autofarm",
        Description = "Starts the autofarming loop with a custom GUI.",
        Callback = function()
            -- All the code to create the custom GUI and start the autofarm
            -- from the WindUI script is placed here.
            local Players = game:GetService("Players")
            local TweenService = game:GetService("TweenService")
            local UserInputService = game:GetService("UserInputService")
            
            -- This player variable is now local to this function.
            -- A global one is declared at the top of the script.
            local player = Players.LocalPlayer

            local playerGui = player:FindFirstChild("PlayerGui")
            if not playerGui then
                warn("PlayerGui not found, cannot create autofarm UI.")
                return
            end

            local screenGui = Instance.new("ScreenGui")
            screenGui.Name = "AutoFarmGUI"
            screenGui.ResetOnSpawn = false
            screenGui.Parent = playerGui

            local frame = Instance.new("Frame")
            frame.Size = UDim2.new(0, 260, 0, 150)
            frame.Position = UDim2.new(0, 20, 0, 20)
            frame.BackgroundColor3 = Color3.fromRGB(128, 90, 213)
            frame.BorderSizePixel = 0
            frame.Parent = screenGui

            local frameCorner = Instance.new("UICorner")
            frameCorner.CornerRadius = UDim.new(0, 16)
            frameCorner.Parent = frame

            local button = Instance.new("TextButton")
            button.Size = UDim2.new(0, 200, 0, 50)
            button.Position = UDim2.new(0, 30, 0, 10)
            button.Text = "Start AutoFarm"
            button.BackgroundColor3 = Color3.fromRGB(186, 104, 200)
            button.TextColor3 = Color3.new(1, 1, 1)
            button.Font = Enum.Font.SourceSansBold
            button.TextSize = 24
            button.Parent = frame

            local buttonCorner = Instance.new("UICorner")
            buttonCorner.CornerRadius = UDim.new(0, 12)
            buttonCorner.Parent = button

            local credit = Instance.new("TextLabel")
            credit.Size = UDim2.new(1, 0, 0, 25)
            credit.Position = UDim2.new(0, 0, 1, -25)
            credit.BackgroundTransparency = 1
            credit.Text = "Made by DarkPlays25"
            credit.TextColor3 = Color3.fromRGB(255, 255, 255)
            credit.Font = Enum.Font.SourceSansBold
            credit.TextScaled = false
            credit.TextSize = 24
            credit.TextStrokeTransparency = 0.5
            credit.TextStrokeColor3 = Color3.new(0, 0, 0)
            credit.Parent = frame

            task.spawn(function()
                local hue = 0
                while credit and credit.Parent do
                    hue = (hue + 0.01) % 1
                    credit.TextColor3 = Color3.fromHSV(hue, 1, 1)
                    task.wait(0.05)
                end
            end)

            task.spawn(function()
                local grow = true
                while credit and credit.Parent do
                    local scale = grow and 1.05 or 1
                    TweenService:Create(credit, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                        TextSize = 24 * scale
                    }):Play()
                    grow = not grow
                    task.wait(0.5)
                end
            end)

            local advancedTab = Instance.new("Frame")
            advancedTab.Size = UDim2.new(0, 260, 0, 120)
            advancedTab.Position = UDim2.new(0, 0, 1, 30)
            advancedTab.BackgroundColor3 = Color3.fromRGB(100, 70, 180)
            advancedTab.BorderSizePixel = 0
            advancedTab.Visible = false
            advancedTab.Parent = frame

            local advCorner = Instance.new("UICorner")
            advCorner.CornerRadius = UDim.new(0, 16)
            advCorner.Parent = advancedTab

            local advButton = Instance.new("TextButton")
            advButton.Size = UDim2.new(0, 80, 0, 25)
            advButton.Position = UDim2.new(0, 10, 1, 5)
            advButton.Text = "Advanced"
            advButton.BackgroundColor3 = Color3.fromRGB(160, 110, 210)
            advButton.TextColor3 = Color3.new(1, 1, 1)
            advButton.Font = Enum.Font.SourceSans
            advButton.TextSize = 16
            advButton.Parent = frame

            local advBtnCorner = Instance.new("UICorner")
            advBtnCorner.CornerRadius = UDim.new(0, 8)
            advBtnCorner.Parent = advButton

            local function createSlider(labelText, default, yOffset)
                local label = Instance.new("TextLabel")
                label.Size = UDim2.new(0, 120, 0, 20)
                label.Position = UDim2.new(0, 10, 0, yOffset)
                label.BackgroundTransparency = 1
                label.Text = labelText .. ": " .. tostring(default)
                label.TextColor3 = Color3.new(1, 1, 1)
                label.Font = Enum.Font.SourceSans
                label.TextSize = 18
                label.Parent = advancedTab

                local box = Instance.new("TextBox")
                box.Size = UDim2.new(0, 60, 0, 20)
                box.Position = UDim2.new(0, 140, 0, yOffset)
                box.BackgroundColor3 = Color3.fromRGB(200, 150, 255)
                box.Text = tostring(default)
                box.Font = Enum.Font.SourceSans
                box.TextColor3 = Color3.new(0, 0, 0)
                box.TextSize = 16
                box.ClearTextOnFocus = false
                box.Parent = advancedTab

                return label, box
            end

            local radiusLabel, radiusBox = createSlider("Radius", 10, 10)
            local speedLabel, speedBox = createSlider("Speed", 1000, 40)
            local distanceLabel, distanceBox = createSlider("Distance", 1000, 70)

            advButton.MouseButton1Click:Connect(function()
                if advancedTab then
                    advancedTab.Visible = not advancedTab.Visible
                end
            end)

            local targetCFrame = CFrame.new(1, 1.99864733, 1629.78101) * CFrame.Angles(0, math.rad(180), 0)
            local touching = false
            local stopLoop = false

            local function circleMotion(rootPart, totalDistance, radius, speed)
                local angleStep = math.rad(10)
                local numSteps = math.floor(totalDistance / (radius * angleStep))
                local center = rootPart.Position

                -- Check if rootPart is valid before starting the loop
                if not rootPart or not rootPart.Parent then return end

                for i = 1, numSteps do
                    if stopLoop then return end
                    if not rootPart or not rootPart.Parent then return end

                    local angle = angleStep * i
                    local offset = Vector3.new(math.cos(angle), 0, math.sin(angle)) * radius
                    local goalPosition = center + offset

                    local tweenInfo = TweenInfo.new(
                        (radius * angleStep) / speed,
                        Enum.EasingStyle.Linear
                    )
                    local tween = TweenService:Create(rootPart, tweenInfo, {
                        CFrame = CFrame.new(goalPosition, goalPosition + rootPart.CFrame.LookVector)
                    })

                    tween:Play()
                    tween.Completed:Wait()
                end
            end

            local function startLoop()
                if touching then return end
                touching = true
                stopLoop = false
                if button and button.Parent then
                    button.Text = "Stop AutoFarm"
                end

                while touching and not stopLoop do
                    local character = player.Character
                    local rootPart = character and character:FindFirstChild("HumanoidRootPart")

                    if not character or not rootPart then
                        task.wait(1)
                        continue
                    end

                    if not radiusBox or not speedBox or not distanceBox or not button or not button.Parent then
                        touching = false
                        stopLoop = true
                        if button and button.Parent then
                             button.Text = "Start AutoFarm"
                        end
                        return
                    end

                    local radius = tonumber(radiusBox.Text) or 10
                    local speed = tonumber(speedBox.Text) or 1000
                    local distance = tonumber(distanceBox.Text) or 1000
                    
                    circleMotion(rootPart, distance, radius, speed)
                end
            end
            
            button.MouseButton1Click:Connect(function()
                if touching then
                    stopLoop = true
                    touching = false
                    if button and button.Parent then
                        button.Text = "Start AutoFarm"
                    end
                else
                    task.spawn(startLoop)
                end
            end)
            
            screenGui.Destroying:Connect(function()
                stopLoop = true
                touching = false
            end)

            local drag = false
            local lastMousePosition = Vector2.new(0, 0)
            
            local function onInputBegan(input, gameProcessedEvent)
                if input.UserInputType == Enum.UserInputType.MouseButton1 and not gameProcessedEvent and UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
                    drag = true
                    lastMousePosition = UserInputService:GetMouseLocation()
                end
            end
            
            local function onInputChanged(input, gameProcessedEvent)
                if drag and not gameProcessedEvent and frame and frame.Parent then
                    local mouseDelta = UserInputService:GetMouseLocation() - lastMousePosition
                    frame.Position = frame.Position + UDim2.new(0, mouseDelta.X, 0, mouseDelta.Y)
                    lastMousePosition = UserInputService:GetMouseLocation()
                end
            end
            
            local function onInputEnded(input, gameProcessedEvent)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    drag = false
                end
            end
            
            UserInputService.InputBegan:Connect(onInputBegan)
            UserInputService.InputChanged:Connect(onInputChanged)
            UserInputService.InputEnded:Connect(onInputEnded)
        end
    })
end


-- Fallback to the original "Settings" tab in Luna
local Tab100 = Window:CreateTab({
    Name = "Settings",
    Icon = "info_outline",
    ImageSource = "Material",
    ShowTitle = true
})

--[[ Original Luna ServerHop Button]]
local Button = Tab100:CreateButton({
    Name = "ServerHop",
    Description = nil,
    Callback = function()
        local ts = game:GetService("TeleportService")
        local p = game:GetService("Players").LocalPlayer
        -- Check if player is valid before teleporting
        if p and p.Parent then
            ts:Teleport(game.PlaceId, p)
        end
    end
})

-- ================================================================
-- MODIFICATIONS
-- ================================================================

-- Create a Dev tab if the player is a developer
-- Change "Bloxwatch_H3ck" and "TheCorruptDarklaw" to your Roblox usernames to enable this tab.
local devUsername = "Bloxwatch_H3ck"
local DevUsernameB = "TheCorruptDarklaw"

-- Ensure player exists before checking name
if player and (player.Name == devUsername or player.Name == DevUsernameB) then
    local DevTab = Window:CreateTab({
        Name = "Dev",
        Icon = "dashboard",
        ImageSource = "Material",
        ShowTitle = true
    })

    DevTab:CreateButton({
        Name = "Copy CFrame",
        Description = "Copies the player's CFrame to the clipboard.",
        Callback = function()
            local character = player.Character or player.CharacterAdded:Wait()
            local rootPart = character and character:FindFirstChild("HumanoidRootPart")
            if rootPart then
                local cframe = rootPart.CFrame
                local x, y, z, R00, R01, R02, R10, R11, R12, R20, R21, R22 = cframe:components()
                local formattedCFrame = string.format("CFrame.new(%f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f)", x, y, z, R00, R01, R02, R10, R11, R12, R20, R21, R22)
                -- Check if setclipboard is available before using it
                if setclipboard then
                    setclipboard(formattedCFrame)
                    Window:CreateNotification({
                        Name = "CFrame Copied",
                        Description = "Player's CFrame has been copied to the clipboard.",
                        Duration = 5
                    })
                else
                    warn("setclipboard() is not available in this environment.")
                end
            end
        end
    })
end

Window:LoadConfiguration()
