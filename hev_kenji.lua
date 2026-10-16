-- [[ Hev kenji Script - Steal an Egg (Anti BAC-3511 Bypass) ]]

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
-- ២. មុខងារ លួចពងបែបធម្មជាតិ (Safe Walk Steal)
-- ==========================================
local SafeStealActive = true

task.spawn(function()
    while task.wait(1.5) do -- រង់ចាំ ១.៥ វិនាទីម្តង
        if SafeStealActive then
            pcall(function()
                local char = LocalPlayer.Character
                if char and char:FindFirstChild("HumanoidRootPart") and char:FindFirstChild("Humanoid") then
                    local hrp = char.HumanoidRootPart
                    local humanoid = char.Humanoid
                    
                    -- ស្វែងរកពងមាន់ដែលនៅជិតបំផុត
                    for _, obj in pairs(workspace:GetDescendants()) do
                        if obj:IsA("BasePart") and (obj.Name:lower():find("egg") or (obj.Parent and obj.Parent.Name:lower():find("egg"))) then
                            local dist = (hrp.Position - obj.Position).Magnitude
                            
                            -- បើសិនជានៅជិត (ក្រោម ១០ studs) បញ្ជាឱ្យតួអង្គដើរទៅបុកពងដោយផ្ទាល់
                            if dist <= 10 then
                                humanoid:MoveTo(obj.Position)
                                task.wait(0.5)
                            end
                        end
                    end
                end
            end)
        end
    end
end)

print("Hev kenji Script (Anti BAC-3511 Bypass): បានដំណើរការដោយជោគជ័យ!")
