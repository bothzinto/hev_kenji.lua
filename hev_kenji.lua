-- [[ Hev kenji Script - Steal an Egg (Super Safe Edition) ]]

local Players = game:GetService("Players")
local VirtualUser = game:GetService("VirtualUser")
local LocalPlayer = Players.LocalPlayer

-- ==========================================
-- ១. មុខងារ ANTI-AFK (ការពារការ KICK ពេលទុកចោល)
-- ==========================================
LocalPlayer.Idled:Connect(function()
    VirtualUser:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
    task.wait(1)
    VirtualUser:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
    print("Hev kenji: Anti-AFK កំពុងដំណើរការ")
end)

-- ==========================================
-- ២. ការកំណត់សុវត្ថិភាព (SAFE SETTINGS)
-- ==========================================
local Settings = {
    LouchPong = true,      -- បើកមុខងារលួចពងសុវត្ថិភាព
    SafeDelay = 1.0        -- រង់ចាំ ១ វិនាទីម្តង (កុំឱ្យ Anti-Cheat ចាប់បាន)
}

-- ==========================================
-- ៣. មុខងារ លួចពងមាន់សុវត្ថិភាព (Safe Steal)
-- ==========================================
task.spawn(function()
    while task.wait(Settings.SafeDelay) do
        if Settings.LouchPong then
            pcall(function()
                local char = LocalPlayer.Character
                if char and char:FindFirstChild("HumanoidRootPart") then
                    local hrp = char.HumanoidRootPart
                    
                    for _, obj in pairs(workspace:GetDescendants()) do
                        if obj:IsA("BasePart") and (obj.Name:lower():find("egg") or (obj.Parent and obj.Parent.Name:lower():find("egg"))) then
                            -- លួចតែពងណាដែលនៅជិតខ្លួនខ្លាំង (ចម្ងាយក្រោម ១៥)
                            if (hrp.Position - obj.Position).Magnitude <= 15 then
                                firetouchinterest(hrp, obj, 0)
                                task.wait(0.1)
                                firetouchinterest(hrp, obj, 1)
                            end
                        end
                    end
                end
            end)
        end
    end
end)

print("Hev kenji Script (Super Safe): បានដំណើរការដោយជោគជ័យ!")
