-- THG2 MM2 ESP (DELTA FIX VERSION)
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local function CreateESP(player)
    local function Setup(char)
        if not char:FindFirstChild("Head") then return end
        
        -- Xóa ESP cũ nếu có
        if char.Head:FindFirstChild("THG2_ESP") then
            char.Head.THG2_ESP:Destroy()
        end

        -- Tạo Billboard ESP
        local gui = Instance.new("BillboardGui")
        gui.Name = "THG2_ESP"
        gui.Size = UDim2.new(0, 120, 0, 40)
        gui.AlwaysOnTop = true
        gui.StudsOffset = Vector3.new(0, 2.5, 0)
        gui.Parent = char.Head

        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1, 0, 1, 0)
        label.BackgroundTransparency = 1
        label.TextScaled = true
        label.Font = Enum.Font.SourceSansBold
        label.Parent = gui

        -- Update liên tục
        RunService.Heartbeat:Connect(function()
            if not player or not player.Parent then return end
            if not char or not char.Parent then return end

            local role = "Innocent"
            local color = Color3.fromRGB(0,255,0)

            if player.Backpack:FindFirstChild("Knife") or char:FindFirstChild("Knife") then
                role = "Murderer"
                color = Color3.fromRGB(255,0,0)
            elseif player.Backpack:FindFirstChild("Gun") or char:FindFirstChild("Gun") then
                role = "Sheriff"
                color = Color3.fromRGB(0,0,255)
            end

            label.Text = player.Name .. " [" .. role .. "]"
            label.TextColor3 = color
        end)
    end

    if player.Character then Setup(player.Character) end
    player.CharacterAdded:Connect(Setup)
end

-- Apply cho tất cả player
for _,p in pairs(Players:GetPlayers()) do
    if p ~= LocalPlayer then
        CreateESP(p)
    end
end

Players.PlayerAdded:Connect(CreateESP)

-- WalkSpeed
LocalPlayer.CharacterAdded:Connect(function(char)
    char:WaitForChild("Humanoid").WalkSpeed = 22
end)
if LocalPlayer.Character then
    LocalPlayer.Character.Humanoid.WalkSpeed = 22
end

print("THG2 ESP Loaded!")