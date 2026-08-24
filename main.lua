local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local VirtualInputManager = game:GetService("VirtualInputManager")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

-- Thông số cài đặt
local BALL_NAME = "Ball" -- Thay đổi tên này nếu game đặt tên bóng khác
local PARRY_RANGE = 15 -- Bán kính vòng tròn (Độ rộng của vòng màu xanh bạn vẽ)
local isAutoBlockEnabled = false

-- 1. Tạo giao diện (UI) Bật/Tắt
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = game:GetService("CoreGui") -- Dùng CoreGui để chống phát hiện

local toggleButton = Instance.new("TextButton")
toggleButton.Size = UDim2.new(0, 120, 0, 40)
toggleButton.Position = UDim2.new(0.5, -60, 0, 20)
toggleButton.Text = "AUTO BLOCK: OFF"
toggleButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
toggleButton.Parent = screenGui

toggleButton.MouseButton1Click:Connect(function()
    isAutoBlockEnabled = not isAutoBlockEnabled
    toggleButton.Text = isAutoBlockEnabled and "AUTO BLOCK: ON" or "AUTO BLOCK: OFF"
    toggleButton.BackgroundColor3 = isAutoBlockEnabled and Color3.fromRGB(50, 255, 50) or Color3.fromRGB(255, 50, 50)
end)

-- 2. Tạo vòng tròn trực quan quanh nhân vật
local rangeCircle = Instance.new("Part")
rangeCircle.Shape = Enum.PartType.Cylinder
rangeCircle.Size = Vector3.new(0.2, PARRY_RANGE * 2, PARRY_RANGE * 2)
rangeCircle.Material = Enum.Material.ForceField
rangeCircle.Color = Color3.fromRGB(85, 85, 255) -- Màu xanh lam mờ
rangeCircle.Anchored = false
rangeCircle.CanCollide = false
rangeCircle.Massless = true
rangeCircle.Parent = workspace

-- Hàm gắn vòng tròn vào nhân vật
local function attachCircle(char)
    local rootPart = char:WaitForChild("HumanoidRootPart")
    local weld = Instance.new("WeldConstraint")
    weld.Part0 = rangeCircle
    weld.Part1 = rootPart
    weld.Parent = rangeCircle
    rangeCircle.CFrame = rootPart.CFrame * CFrame.Angles(0, 0, math.rad(90))
end
attachCircle(character)

player.CharacterAdded:Connect(function(newChar)
    character = newChar
    attachCircle(newChar)
end)

-- 3. Vòng lặp phát hiện bóng & Bấm màn hình
RunService.Stepped:Connect(function()
    if not isAutoBlockEnabled or not character or not character:FindFirstChild("HumanoidRootPart") then return end
    
    local rootPart = character.HumanoidRootPart
    
    -- Tìm bóng trong workspace (có thể cần điều chỉnh đường dẫn tùy game)
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj.Name == BALL_NAME and obj:IsA("BasePart") then
            -- Tính toán khoảng cách từ người đến bóng
            local distance = (rootPart.Position - obj.Position).Magnitude
            
            if distance <= PARRY_RANGE then
                -- Mô phỏng thao tác bấm vào nút Block (hoặc giữa màn hình)
                -- Tọa độ x, y ở đây mô phỏng thao tác tap trên màn hình cảm ứng
                local screenSize = workspace.CurrentCamera.ViewportSize
                local tapX = screenSize.X / 2
                local tapY = screenSize.Y / 2
                
                VirtualInputManager:SendMouseButtonEvent(tapX, tapY, 0, true, game, 1)
                VirtualInputManager:SendMouseButtonEvent(tapX, tapY, 0, false, game, 1)
                
                -- Tạo độ trễ siêu nhỏ để chống spam quá mức gây crash
                task.wait(0.01) 
            end
        end
    end
end)
