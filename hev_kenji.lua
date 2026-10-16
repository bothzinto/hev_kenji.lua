-- [[ Hev kenji Script - Steal an Egg (Ultimate Anti-Ban & Anti-Kick) ]]

local Players = game:GetService("Players")
local VirtualUser = game:GetService("VirtualUser")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- ==========================================
-- ១. មុខងារ ការពារកុំឱ្យ KICK ពី Server
-- ==========================================
LocalPlayer.Idled:Connect(function()
    VirtualUser:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
    task.wait(1)
    VirtualUser:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
    print("Hev kenji: Anti-AFK កំពុងដំណើរការ")
end)

-- ទប់ស្កាត់ការបញ្ជា Kick ពី Admin ឬ Anti-Cheat របស់ Game
pcall(function()
    local mt = getrawmetatable(game)
    local old = mt.__namecall
    setreadonly(mt, false)
    mt.__namecall = newcclosure(function(self, ...)
        local method = getnamecallmethod()
        if tostring(method):lower() == "kick" then
            print("Hev kenji: បានទប់ស្កាត់ការ Kick ដោយជោគជ័យ!")
            return nil
        end
        return old(self, ...)
    end)
    setreadonly(mt, true)
end)

-- ==========================================
-- ២. ការកំណត់ (SETTINGS)
-- ==========================================
local Settings = {
    LouchPongLuen = true,  -- មុខងារលួចពងមាន់
    LveopRoeut = 28,       -- ល្បឿនរត់មានសុវត្ថិភាព (មិនលឿនហួសហេតុពេក)
    BoekLveop = true,      -- បើកដំណើរការល្បឿនរត់
    SafeDelay = 0.5        -- រយៈពេលរង់ចាំសុវត្ថិភាព (ការពារ Server Detect)
}

-- ==========================================
-- ៣. មុខងារ លួចពងមាន់សុវត្ថិភាព (Safe Fast Steal)
-- ==========================================
task.spawn(function()
    while task.wait(Settings.SafeDelay) do
        if Settings.LouchPongLuen then
            pcall(function()
                local char = LocalPlayer.Character
                if char and char:FindFirstChild("HumanoidRootPart") then
                    local hrp = char.HumanoidRootPart
                    
                    for _, obj in pairs(workspace:GetDescendants()) do
                        if obj:IsA("BasePart") and (obj.Name:lower():find("egg") or (obj.Parent and obj.Parent.Name:lower():find("egg"))) then
                            -- ឆែកចម្ងាយសុវត្ថិភាពមុនពេល Touch
                            if (hrp.Position - obj.Position).Magnitude < 25 then
                                firetouchinterest(hrp, obj, 0)
                                task.wait(0.02)
                                firetouchinterest(hrp, obj, 1)
                            end
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

print("Hev kenji Script (Anti-Cheat Bypass): បានដំណើរការដោយជោគជ័យ!")
