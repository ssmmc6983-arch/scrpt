-- КРАСИВОЕ ESP МЕНЮ С РАССТОЯНИЕМ
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Player = Players.LocalPlayer

-- Создаем ПРЕМИУМ интерфейс
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ESPMenu"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 280, 0, 200)
MainFrame.Position = UDim2.new(0.5, -140, 0.5, -100)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
MainFrame.BackgroundTransparency = 0.05
MainFrame.Active = true
MainFrame.Draggable = true

-- Неоновая рамка
local FrameGlow = Instance.new("Frame")
FrameGlow.Size = UDim2.new(1, 0, 0, 3)
FrameGlow.Position = UDim2.new(0, 0, 0, 0)
FrameGlow.BackgroundColor3 = Color3.fromRGB(0, 200, 255)
FrameGlow.BorderSizePixel = 0
FrameGlow.Parent = MainFrame

local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 25, 0, 25)
CloseButton.Position = UDim2.new(1, -30, 0, 10)
CloseButton.Text = "×"
CloseButton.BackgroundColor3 = Color3.fromRGB(45, 45, 65)
CloseButton.TextColor3 = Color3.fromRGB(255, 100, 100)
CloseButton.TextSize = 18
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Parent = MainFrame

local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Size = UDim2.new(0, 25, 0, 25)
MinimizeButton.Position = UDim2.new(1, -60, 0, 10)
MinimizeButton.Text = "−"
MinimizeButton.BackgroundColor3 = Color3.fromRGB(45, 45, 65)
MinimizeButton.TextColor3 = Color3.fromRGB(255, 180, 60)
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeButton.TextSize = 18
MinimizeButton.Font = Enum.Font.GothamBold
MinimizeButton.Parent = MainFrame

local CircleButton = Instance.new("TextButton")
CircleButton.Size = UDim2.new(0, 45, 0, 45)
CircleButton.Position = UDim2.new(0, 15, 0, 15)
CircleButton.Text = "👁️"
CircleButton.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
CircleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CircleButton.TextSize = 18
CircleButton.Visible = false
CircleButton.Parent = ScreenGui

-- Стильный заголовок
local Title = Instance.new("TextLabel")
Title.Text = "VISION ESP"
Title.Size = UDim2.new(1, 0, 0, 50)
Title.Position = UDim2.new(0, 0, 0, 5)
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.fromRGB(0, 255, 255)
Title.TextSize = 16
Title.Font = Enum.Font.GothamBold
Title.TextStrokeTransparency = 0.8
Title.Parent = MainFrame

-- Переменные
local ESPEnabled = false
local ESPTable = {}

-- Стильная функция создания кнопки
local function createStyledButton(text, yPos, callback)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0, 240, 0, 40)
    button.Position = UDim2.new(0, 20, 0, yPos)
    button.Text = text
    button.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.AutoButtonColor = false
    button.TextSize = 13
    button.Font = Enum.Font.Gotham
    
    -- Градиентный эффект при наведении
    button.MouseEnter:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(60, 60, 80),
            TextColor3 = Color3.fromRGB(0, 255, 255)
        }):Play()
    end)
    
    button.MouseLeave:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(40, 40, 60),
            TextColor3 = Color3.fromRGB(255, 255, 255)
        }):Play()
    end)
    
    button.MouseButton1Click:Connect(callback)
    button.Parent = MainFrame
    return button
end

-- КРАСИВЫЙ ESP С РАССТОЯНИЕМ И ХАЙЛАЙТАМИ
local function toggleVisionESP()
    ESPEnabled = not ESPEnabled
    
    if ESPButton then
        if ESPEnabled then
            ESPButton.BackgroundColor3 = Color3.fromRGB(0, 150, 100)
            ESPButton.TextColor3 = Color3.fromRGB(255, 255, 255)
            ESPButton.Text = "VISION ESP [ACTIVE]"
        else
            ESPButton.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
            ESPButton.TextColor3 = Color3.fromRGB(255, 255, 255)
            ESPButton.Text = "VISION ESP [INACTIVE]"
        end
    end
    
    if ESPEnabled then
        -- Включаем красивый ESP
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= Player then
                local function setupVisionESP(character)
                    if not character then return end
                    
                    local head = character:FindFirstChild("Head")
                    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
                    if not head or not humanoidRootPart then return end
                    
                    -- Стильный хайлайт с градиентом
                    local highlight = Instance.new("Highlight")
                    highlight.Name = "VisionHighlight"
                    highlight.FillColor = Color3.fromRGB(255, 50, 150)
                    highlight.FillTransparency = 0.8
                    highlight.OutlineColor = Color3.fromRGB(0, 255, 255)
                    highlight.OutlineTransparency = 0.1
                    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                    highlight.Parent = character
                    
                    -- Красивое имя игрока
                    local nameBillboard = Instance.new("BillboardGui")
                    nameBillboard.Name = "VisionName"
                    nameBillboard.Adornee = head
                    nameBillboard.Size = UDim2.new(0, 200, 0, 30)
                    nameBillboard.StudsOffset = Vector3.new(0, 3.2, 0)
                    nameBillboard.AlwaysOnTop = true
                    nameBillboard.MaxDistance = 200
                    
                    local nameLabel = Instance.new("TextLabel")
                    nameLabel.Text = "「 " .. player.Name .. " 」"
                    nameLabel.Size = UDim2.new(1, 0, 1, 0)
                    nameLabel.BackgroundTransparency = 1
                    nameLabel.TextColor3 = Color3.fromRGB(255, 255, 150)
                    nameLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
                    nameLabel.TextStrokeTransparency = 0.2
                    nameLabel.TextSize = 12
                    nameLabel.Font = Enum.Font.GothamBold
                    nameLabel.Parent = nameBillboard
                    
                    nameBillboard.Parent = head
                    
                    -- Дистанция с иконкой
                    local distanceBillboard = Instance.new("BillboardGui")
                    distanceBillboard.Name = "VisionDistance"
                    distanceBillboard.Adornee = head
                    distanceBillboard.Size = UDim2.new(0, 150, 0, 25)
                    distanceBillboard.StudsOffset = Vector3.new(0, 2.0, 0)
                    distanceBillboard.AlwaysOnTop = true
                    distanceBillboard.MaxDistance = 200
                    
                    local distanceLabel = Instance.new("TextLabel")
                    distanceLabel.Text = "📏 0m"
                    distanceLabel.Size = UDim2.new(1, 0, 1, 0)
                    distanceLabel.BackgroundTransparency = 1
                    distanceLabel.TextColor3 = Color3.fromRGB(150, 255, 255)
                    distanceLabel.TextStrokeTransparency = 0.5
                    distanceLabel.TextSize = 11
                    distanceLabel.Font = Enum.Font.Gotham
                    distanceLabel.Parent = distanceBillboard
                    
                    distanceBillboard.Parent = head
                    
                    -- Здоровье (если есть)
                    local healthBillboard = Instance.new("BillboardGui")
                    healthBillboard.Name = "VisionHealth"
                    healthBillboard.Adornee = head
                    healthBillboard.Size = UDim2.new(0, 120, 0, 20)
                    healthBillboard.StudsOffset = Vector3.new(0, 1.2, 0)
                    healthBillboard.AlwaysOnTop = true
                    healthBillboard.MaxDistance = 150
                    
                    local healthLabel = Instance.new("TextLabel")
                    healthLabel.Text = "❤️ 100%"
                    healthLabel.Size = UDim2.new(1, 0, 1, 0)
                    healthLabel.BackgroundTransparency = 1
                    healthLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
                    healthLabel.TextStrokeTransparency = 0.5
                    healthLabel.TextSize = 10
                    healthLabel.Font = Enum.Font.Gotham
                    healthLabel.Parent = healthBillboard
                    
                    healthBillboard.Parent = head
                    
                    -- Обновление дистанции и здоровья
                    local connection
                    connection = RunService.Heartbeat:Connect(function()
                        if not character or not character.Parent then
                            connection:Disconnect()
                            return
                        end
                        
                        -- Обновление дистанции
                        local playerRoot = Player.Character and Player.Character:FindFirstChild("HumanoidRootPart")
                        if playerRoot then
                            local distance = (playerRoot.Position - humanoidRootPart.Position).Magnitude
                            distanceLabel.Text = "📏 " .. math.floor(distance) .. "m"
                            
                            -- Меняем цвет в зависимости от дистанции
                            if distance < 20 then
                                distanceLabel.TextColor3 = Color3.fromRGB(255, 50, 50)
                            elseif distance < 50 then
                                distanceLabel.TextColor3 = Color3.fromRGB(255, 255, 100)
                            else
                                distanceLabel.TextColor3 = Color3.fromRGB(150, 255, 255)
                            end
                        end
                        
                        -- Обновление здоровья
                        local humanoid = character:FindFirstChild("Humanoid")
                        if humanoid then
                            local healthPercent = math.floor((humanoid.Health / humanoid.MaxHealth) * 100)
                            healthLabel.Text = "❤️ " .. healthPercent .. "%"
                            
                            -- Меняем цвет здоровья
                            if healthPercent < 25 then
                                healthLabel.TextColor3 = Color3.fromRGB(255, 50, 50)
                            elseif healthPercent < 50 then
                                healthLabel.TextColor3 = Color3.fromRGB(255, 150, 50)
                            else
                                healthLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
                            end
                        end
                    end)
                    
                    ESPTable[player] = {
                        highlight = highlight,
                        nameBillboard = nameBillboard,
                        distanceBillboard = distanceBillboard,
                        healthBillboard = healthBillboard,
                        connection = connection
                    }
                end
                
                -- Настраиваем для существующего персонажа
                if player.Character then
                    setupVisionESP(player.Character)
                end
                
                -- Настраиваем для нового персонажа
                player.CharacterAdded:Connect(function(character)
                    wait(1.5) -- Ждем полной загрузки
                    if ESPEnabled then
                        setupVisionESP(character)
                    end
                end)
            end
        end
    else
        -- Выключаем ESP
        for player, espData in pairs(ESPTable) do
            if espData.highlight then espData.highlight:Destroy() end
            if espData.nameBillboard then espData.nameBillboard:Destroy() end
            if espData.distanceBillboard then espData.distanceBillboard:Destroy() end
            if espData.healthBillboard then espData.healthBillboard:Destroy() end
            if espData.connection then espData.connection:Disconnect() end
        end
        ESPTable = {}
    end
end

-- Создаем стильную кнопку ESP
local ESPButton = createStyledButton("VISION ESP [INACTIVE]", 60, toggleVisionESP)

-- Кнопка скрытия с иконкой
local hideBtn = createStyledButton("🔒 Скрыть панель", 110, function()
    MainFrame.Visible = false
    CircleButton.Visible = true
end)

-- Обработчики
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

-- Собираем интерфейс
MainFrame.Parent = ScreenGui
ScreenGui.Parent = Player.PlayerGui

print("=== VISION ESP MENU LOADED ===")
print("👁️ Стильный ESP с расстоянием и здоровьем")
print("🎨 Красивый дизайн с анимациями")
print("📏 Дистанция с цветовой индикацией")
print("❤️ Отображение здоровья игроков")
