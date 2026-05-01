-- MM2 SCRIPT: FULL BODY CHAMS ESP (BÁM SÁT THÂN NGƯỜI)
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

-- Hàm tạo Chams bám sát thân người
local function CreateFullBodyChams(Player)
    local function UpdateChams()
        if Player.Character and Player.Character:FindFirstChild("Humanoid") then
            local char = Player.Character
            
            -- Tạo hoặc lấy đối tượng Highlight cũ (Chams)
            local highlight = char:FindFirstChild("MM2_Chams")
            if not highlight then
                highlight = Instance.new("Highlight")
                highlight.Name = "MM2_Chams"
                highlight.Parent = char
                highlight.Adornee = char -- Áp dụng lên toàn bộ Model nhân vật
                highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop -- Nhìn xuyên tường
                highlight.OutlineTransparency = 0 -- Độ đậm của viền (0 là rõ nhất)
                highlight.OutlineColor = Color3.fromRGB(255, 255, 255) -- Màu viền trắng
                highlight.FillTransparency = 0.5 -- Độ trong suốt của màu phủ (0.5 là vừa)
            end

            -- Cập nhật màu phủ dựa trên vai trò để bám sát thân
            if Player.Backpack:FindFirstChild("Knife") or char:FindFirstChild("Knife") then
                highlight.FillColor = Color3.fromRGB(255, 0, 0) -- Màu đỏ: Murderer
            elseif Player.Backpack:FindFirstChild("Gun") or char:FindFirstChild("Gun") then
                highlight.FillColor = Color3.fromRGB(0, 0, 255) -- Màu xanh dương: Sheriff
            else
                highlight.FillColor = Color3.fromRGB(0, 255, 0) -- Màu xanh lá: Innocent
            end
        end
    end
    
    -- Cập nhật liên tục để đảm bảo màu đúng khi vai trò thay đổi
    local conn
    conn = RunService.Heartbeat:Connect(function()
        if not Player or not Player.Parent then conn:Disconnect() return end
        UpdateChams()
    end)
end

-- Áp dụng cho mọi người chơi hiện tại và người mới vào
for _, p in pairs(Players:GetPlayers()) do
    if p ~= Players.LocalPlayer then CreateFullBodyChams(p) end
end
Players.PlayerAdded:Connect(CreateFullBodyChams)

-- 3. TĂNG TỐC ĐỘ DI CHUYỂN (TÙY CHỌN - MẶC ĐỊNH 22)
Players.LocalPlayer.CharacterAdded:Connect(function(char)
    char:WaitForChild("Humanoid").WalkSpeed = 22
end)
if Players.LocalPlayer.Character then Players.LocalPlayer.Character.Humanoid.WalkSpeed = 22 end

print("MM2 Full Body Chams đã kích hoạt!")
