-- This script combines the Luna UI framework with the functionality
-- from the WindUI script ("SkyHubMe.txt"). All tabs, buttons, and
-- toggles from the WindUI script have been refactored to work
-- with the Luna library.

-- ================================================================
-- WINDUI SCRIPT UTILITIES
-- ================================================================
-- This section contains utility code from the WindUI script
-- that is needed for the buttons to work.

-- Discord webhook URL and function to send a message.
local webhook_url = "https://canary.discord.com/api/webhooks/1397774789782802512/9Elh1LPcHKChTlQ8sey8KvGkXPKp9iKdlgTp1VP5RlETVIzDVonxPehORsRcKnOgFhtR"
local function sendToWebhook(message)
    local HttpService = game:GetService("HttpService")
    local payload = {
        content = message
    }
    local options = {
        Url = webhook_url,
        Body = HttpService:JSONEncode(payload),
        Method = "POST",
        Headers = {
            ["Content-Type"] = "application/json"
        }
    }
    local response = HttpService:RequestAsync(options)
    if response.StatusCode == 204 then
        print("Message sent successfully!")
    else
        warn("Failed to send message. HTTP code: " .. response.StatusCode)
        warn("Response: " .. response.Body)
    end
end

-- Get the player's username and send the "ran script" message.
local player = game.Players.LocalPlayer
local playerUsername = player.Name
sendToWebhook(playerUsername .. " Has ran Sky Hub")

-- Load the 'Nex' script for various functions.
local Nex = loadstring(game:HttpGet("https://pastefy.app/IRNCydXd/raw",true))()

-- ================================================================
-- LUNA UI SETUP
-- ================================================================
-- This section is the original Luna script from WINDTEST (4).lua
-- The tabs and buttons from the WindUI script will be added to this window.
local Luna = loadstring(game:HttpGet("https://raw.githubusercontent.com/Nebula-Softworks/Luna-Interface-Suite/refs/heads/master/source.lua", true))()
local Window = Luna:CreateWindow({
    Name = "Origin Hub",
    Subtitle = "V0.1",
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
        Nex.NPC()
    end
})
UniversalTab:CreateButton({
    Name = "Telekensis tool",
    Description = "Gives you a telekinesis tool.",
    Callback = function()
        Nex.TELEKENESIS()
    end
})
UniversalTab:CreateButton({
    Name = "Teleport Tool",
    Description = "Gives you a tool to teleport where you click.",
    Callback = function()
        local mouse = game.Players.LocalPlayer:GetMouse()
        local tool = Instance.new("Tool")
        tool.RequiresHandle = false
        tool.Name = "Tp tool(Equip to Click TP)"
        tool.Activated:connect(function()
            local pos = mouse.Hit + Vector3.new(0, 2.5, 0)
            pos = CFrame.new(pos.X, pos.Y, pos.Z)
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = pos
        end)
        tool.Parent = game.Players.LocalPlayer.Backpack
        
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
        Nex.Nameless()
    end
})
UniversalTab:CreateButton({
    Name = "InfinteYield",
    Description = "Infinite Yield is the best known admin commands containing over 600 commands.",
    Callback = function()
        Nex.IY()
    end
})
UniversalTab:CreateButton({
    Name = "QuizBot",
    Description = "Runs a quiz bot script.",
    Callback = function()
        local CustomCategoryManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/Damian-11/quizbot/master/quizbot.luau"))()
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
        if state then
            game:GetService("Workspace").CurrentCamera.FieldOfView = modifiedFOV
        else
            game:GetService("Workspace").CurrentCamera.FieldOfView = defaultFOV
        end
    end
})
UniversalTab:CreateToggle({
    Name = "Speed",
    Description = "Changes the character's speed.",
    Callback = function(state)
        if state then
            game.Players.LocalPlayer.Character:WaitForChild("Humanoid").WalkSpeed = 50
        else
            game.Players.LocalPlayer.Character:WaitForChild("Humanoid").WalkSpeed = 16
        end
    end
})


--[[ Game-Specific Tabs ]]

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
                local r = c:WaitForChild("HumanoidRootPart")
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
            f(lp.Character)
            lp.CharacterAdded:Connect(f)
        end
    })
    
    -- New teleport buttons for NDS
    TabNDS:CreateButton({
        Name = "Teleport to Lobby",
        Description = "Teleports you to the main lobby.",
        Callback = function()
            local PlayerCharacter = player.Character
            if PlayerCharacter and PlayerCharacter:FindFirstChild("HumanoidRootPart") then
                PlayerCharacter.HumanoidRootPart.CFrame = CFrame.new(-279.034241, 179.880035, 341.404175, -0.806028, -0.000000, -0.591878, -0.000000, 1.000000, -0.000000, 0.591878, -0.000000, -0.806028)
            end
        end
    })

    TabNDS:CreateButton({
        Name = "Teleport to Map",
        Description = "Teleports you to the current map.",
        Callback = function()
            local PlayerCharacter = player.Character
            if PlayerCharacter and PlayerCharacter:FindFirstChild("HumanoidRootPart") then
                PlayerCharacter.HumanoidRootPart.CFrame = CFrame.new(-130.610031, 47.580109, 8.014925, 0.009443, 0.000000, -0.999955, -0.000000, 1.000000, 0.000000, 0.999955, 0.000000, 0.009443)
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
            local player = Players.LocalPlayer

            local screenGui = Instance.new("ScreenGui")
            screenGui.Name = "AutoFarmGUI"
            screenGui.ResetOnSpawn = false
            screenGui.Parent = player:WaitForChild("PlayerGui")

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
                while true do
                    hue = (hue + 0.01) % 1
                    credit.TextColor3 = Color3.fromHSV(hue, 1, 1)
                    task.wait(0.05)
                end
            end)

            task.spawn(function()
                local grow = true
                while true do
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
                advancedTab.Visible = not advancedTab.Visible
            end)

            local targetCFrame = CFrame.new(1, 1.99864733, 1629.78101) * CFrame.Angles(0, math.rad(180), 0)
            local touching = false
            local stopLoop = false

            local function getCharacter()
                repeat task.wait() until player.Character and player.Character:FindFirstChild("HumanoidRootPart")
                return player.Character
            end

            local function circleMotion(rootPart, totalDistance, radius, speed)
                local angleStep = math.rad(10)
                local numSteps = math.floor(totalDistance / (radius * angleStep))
                local center = rootPart.Position


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
                button.Text = "Stop AutoFarm"

                local character = getCharacter()
                local rootPart = character:WaitForChild("HumanoidRootPart")

                while touching and not stopLoop do
                    -- Check if the UI elements still exist
                    if not radiusBox or not speedBox or not distanceBox then
                        touching = false
                        stopLoop = true
                        button.Text = "Start AutoFarm"
                        return
                    end
                    
                    local radius = tonumber(radiusBox.Text) or 10
                    local speed = tonumber(speedBox.Text) or 1000
                    local distance = tonumber(distanceBox.Text) or 1000

                    radiusLabel.Text = "Radius: " .. tostring(radius)
                    speedLabel.Text = "Speed: " .. tostring(speed)
                    distanceLabel.Text = "Distance: " .. tostring(distance)
                    
                    -- Check if character and rootPart still exist before using them
                    if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then
                        touching = false
                        stopLoop = true
                        button.Text = "Start AutoFarm"
                        return
                    end

                    circleMotion(rootPart, distance, radius, speed)
                    task.wait(0.1)

                    if stopLoop then break end

                    rootPart.CFrame = targetCFrame + Vector3.new(0, 3, 0)
                    task.wait(0.3)

                    local rayOrigin = rootPart.Position
                    local rayDir = Vector3.new(0, -5, 0)
                    local result = workspace:Raycast(rayOrigin, rayDir)

                    if result and result.Instance then
                        local part = result.Instance
                        firetouchinterest(rootPart, part, 0)
                        task.wait(0.1)
                        firetouchinterest(rootPart, part, 1)
                    end


                    task.wait(1)
                end

                touching = false
                button.Text = "Start AutoFarm"
            end

            button.MouseButton1Click:Connect(function()
                if touching then
                    stopLoop = true
                else
                    startLoop()
                end
            end)
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
        ts:Teleport(game.PlaceId, p)
    end
})

-- ================================================================
-- MODIFICATIONS
-- ================================================================

-- Create a Dev tab if the player is a developer
-- Change "Bloxwatch_H3ck" and "TheCorruptDarklaw" to your Roblox usernames to enable this tab.
local devUsername = "Bloxwatch_H3ck"
local DevUsernameB = "TheCorruptDarklaw"

if player.Name == devUsername or player.Name == DevUsernameB then
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
            local cframe = player.Character.HumanoidRootPart.CFrame
            local x, y, z, R00, R01, R02, R10, R11, R12, R20, R21, R22 = cframe:components()
            local formattedCFrame = string.format("CFrame.new(%f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f)", x, y, z, R00, R01, R02, R10, R11, R12, R20, R21, R22)

            setclipboard(formattedCFrame)
            Window:CreateNotification({
                Name = "CFrame Copied",
                Description = "Player's CFrame has been copied to the clipboard.",
                Duration = 5
            })
        end
    })
end
