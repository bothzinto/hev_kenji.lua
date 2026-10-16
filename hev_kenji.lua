-- [[ Hev kenji Script - Steal an Egg (Ghost Mode / No Detection) ]]

local Players = game:GetService("Players")
local VirtualUser = game:GetService("VirtualUser")
local LocalPlayer = Players.LocalPlayer

-- ==========================================
-- ១. មុខងារ ANTI-AFK (សុវត្ថិភាព 100%)
-- ==========================================
LocalPlayer.Idled:Connect(function()
    VirtualUser:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
    task.wait(1)
    VirtualUser:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
    print("Hev kenji: Anti-AFK Active")
end)

-- ==========================================
-- ២. បង្កើតប៊ូតុងលួចពងនៅលើអេក្រង់ (Manual Click Safe)
-- ==========================================
local ScreenGui = Instance.new("ScreenGui")
local Button = Instance.new("TextButton")

ScreenGui.Parent = game.CoreGui
ScreenGui.Name = "HevKenjiGui"

Button.Parent = ScreenGui
Button.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
Button.Position = UDim2.new(0.85, 0, 0.4, 0)
Button.Size = UDim2.new(0, 100, 0, 50)
Button.Text = "លួចពង"
Button.TextColor3 = Color3.fromRGB(255, 255, 255)
Button.TextSize = 18
Button.Active = true
Button.Draggable = true

-- នៅពេលចុចប៊ូតុង ទើបវាធ្វើការលួចពង 1 ដង (មិនប្រើ Loop)
Button.MouseButton1Click:Connect(function()
    pcall(function()
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            local hrp = char.HumanoidRootPart
            for _, obj in pairs(workspace:GetDescendants()) do
                if obj:IsA("BasePart") and (obj.Name:lower():find("egg") or (obj.Parent and obj.Parent.Name:lower():find("egg"))) then
                    if (hrp.Position - obj.Position).Magnitude <= 12 then
                        firetouchinterest(hrp, obj, 0)
                        task.wait(0.05)
                        firetouchinterest(hrp, obj, 1)
                    end
                end
            end
        end
    end)
end)

print("Hev kenji Script (Ghost Mode Loaded!)")
