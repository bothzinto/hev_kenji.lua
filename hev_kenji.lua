-- [[ Hev kenji Script - Steal an Egg (ភាសាខ្មែរ) ]]

local Players = game:GetService("Players")
local VirtualUser = game:GetService("VirtualUser")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- ==========================================
-- ១. មុខងារ ការពារកុំឱ្យ KICK (Anti-AFK ភាសាខ្មែរ)
-- ==========================================
LocalPlayer.Idled:Connect(function()
    VirtualUser:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
    task.wait(1)
    VirtualUser:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
    print("Hev kenji: កំពុងដំណើរការ Anti-AFK (ការពារការ Kick)")
end)

-- ==========================================
-- ២. ការកំណត់ (SETTINGS)
-- ==========================================
local Settings = {
    LouchPongLuen = true,  -- មុខងារលួចពងលឿនបំផុត (Fast Steal)
    LveopRoeut = 50,       -- ល្បឿនរត់ (WalkSpeed)
    BoekLveop = true       -- បើកប្រើប្រាស់ល្បឿនរត់
}

-- ==========================================
-- ៣. មុខងារ លួចពងមាន់លឿនបំផុត (Fast Steal Egg)
-- ==========================================
task.spawn(function()
    while task.wait(0.05) do -- ធ្វើការរៀងរាល់ 0.05 វិនាទី (លឿនខ្លាំង)
        if Settings.LouchPongLuen then
            pcall(function()
                local char = LocalPlayer.Character
                if char and char:FindFirstChild("HumanoidRootPart") then
                    local hrp = char.HumanoidRootPart
                    
                    -- ស្វែងរកពងមាន់ទាំងអស់នៅលើ Map
                    for _, obj in pairs(workspace:GetDescendants()) do
                        if obj:IsA("BasePart") and (obj.Name:lower():find("egg") or (obj.Parent and obj.Parent.Name:lower():find("egg"))) then
                            -- បញ្ជូនសញ្ញាប៉ះ (Touch) រហ័សបំផុតដើម្បីលួចយកពង
                            firetouchinterest(hrp, obj, 0)
                            firetouchinterest(hrp, obj, 1)
                        end
                    end
                end
            end)
        end
    end
end)

-- ==========================================
-- ៤. មុខងារ បង្កើនល្បឿនរត់ (Speed Boost)
-- ==========================================
RunService.Stepped:Connect(function()
    pcall(function()
        if Settings.BoekLveop and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = Settings.LveopRoeut
        end
    end)
end)

print("Hev kenji Script: បានដំណើរការដោយជោគជ័យ!")
