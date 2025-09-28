-- Мобильное меню для Executor
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- Создаем ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MobileMenu"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Главное меню
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 250, 0, 200)
MainFrame.Position = UDim2.new(0.1, 0, 0.1, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true

-- Крестик закрыть
local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Size = UDim2.new(0, 25, 0, 25)
CloseButton.Position = UDim2.new(1, -30, 0, 5)
CloseButton.Text = "X"
CloseButton.BackgroundColor3 = Color3.fromRGB(220, 60, 60)
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)

-- Минус скрыть
local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Name = "MinimizeButton"
MinimizeButton.Size = UDim2.new(0, 25, 0, 25)
MinimizeButton.Position = UDim2.new(1, -60, 0, 5)
MinimizeButton.Text = "-"
MinimizeButton.BackgroundColor3 = Color3.fromRGB(255, 180, 60)
MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)

-- Кружок
local CircleButton = Instance.new("TextButton")
CircleButton.Name = "CircleButton"
CircleButton.Size = UDim2.new(0, 40, 0, 40)
CircleButton.Position = UDim2.new(0, 10, 0, 10)
CircleButton.Text = "⚲"
CircleButton.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
CircleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CircleButton.Visible = false

-- Таблица для ESP
local ESPEnabled = false
local ESPTable = {}

-- Функция ESP которая включает ВСЁ
local function toggleESP()
    ESPEnabled = not ESPEnabled
    
    if ESPEnabled then
        -- Включаем ESP и ESP Name для всех игроков
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= Player then
                local function setupESP(character)
                    if not character then return end
                    
                    local head = character:WaitForChild("Head", 3)
                    if not head then return end
                    
                    -- ESP Name (имя над головой)
                    local billboard = Instance.new("BillboardGui")
                    billboard.Name = "ESPName"
                    billboard.Adornee = head
                    billboard.Size = UDim2.new(0, 200, 0, 40)
                    billboard.StudsOffset = Vector3.new(0, 4, 0) -- Выше головы
                    billboard.AlwaysOnTop = true
                    
                    local nameLabel = Instance.new("TextLabel")
                    nameLabel.Text = player.Name
                    nameLabel.Size = UDim2.new(1, 0, 1, 0)
                    nameLabel.BackgroundTransparency = 1
                    nameLabel.TextColor3 = Color3.fromRGB(255, 255, 0)
                    nameLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
                    nameLabel.TextStrokeTransparency = 0
                    nameLabel.TextSize = 14
                    nameLabel.Font = Enum.Font.GothamBold
                    nameLabel.Parent = billboard
                    
                    billboard.Parent = head
                    
                    -- ESP (подсветка)
                    local highlight = Instance.new("Highlight")
                    highlight.Name = "ESPHighlight"
                    highlight.FillColor = Color3.fromRGB(255, 0, 0)
                    highlight.FillTransparency = 0.8
                    highlight.OutlineColor = Color3.fromRGB(255, 255, 0)
                    highlight.Parent = character
                    
                    ESPTable[player] = {billboard = billboard, highlight = highlight}
                end
                
                -- Настраиваем ESP
                if player.Character then
                    setupESP(player.Character)
                end
                
                player.CharacterAdded:Connect(function(character)
                    wait(1)
                    if ESPEnabled then
                        setupESP(character)
                    end
                end)
            end
        end
        print("ESP включен! Имена и подсветка активны!")
    else
        -- Выключаем всё
        for player, espData in pairs(ESPTable) do
            if espData.billboard then
                espData.billboard:Destroy()
            end
            if espData.highlight then
                espData.highlight:Destroy()
            end
        end
        ESPTable = {}
        print("ESP выключен!")
    end
end

-- Обработчики кнопок
CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

MinimizeButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    CircleButton.Visible = true
end)

CircleButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = true
    CircleButton.Visible = false
end)

-- ОДНА кнопка ESP
local ESPButton = Instance.new("TextButton")
ESPButton.Size = UDim2.new(0, 200, 0, 40)
ESPButton.Position = UDim2.new(0, 25, 0, 60)
ESPButton.Text = "ESP"
ESPButton.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
ESPButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ESPButton.MouseButton1Click:Connect(toggleESP)
ESPButton.Parent = MainFrame

-- Заголовок
local Title = Instance.new("TextLabel")
Title.Text = "MOBILE MENU"
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Position = UDim2.new(0, 0, 0, 0)
Title.BackgroundColor3 = Color3.fromRGB(25, 25, 40)
Title.TextColor3 = Color3.fromRGB(0, 200, 255)
Title.TextSize = 16
Title.Font = Enum.Font.GothamBold
Title.Parent = MainFrame

-- Собираем интерфейс
CircleButton.Parent = ScreenGui
CloseButton.Parent = MainFrame
MinimizeButton.Parent = MainFrame
MainFrame.Parent = ScreenGui
ScreenGui.Parent = PlayerGui

print("Меню загружено! Одна кнопка ESP включает всё!")
