repeat wait() until game:IsLoaded()
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local NPCs = workspace.Game.Players
local punchType
local combo = 1
local lp = game:GetService("Players").LocalPlayer


local function GetClosest() -- GETS CLOSEST ENEMY
    local Character = LocalPlayer.Character
    local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
    if not (HumanoidRootPart) then return end
    local TargetDistance = 250
    local Target
    
    for i,v in pairs(NPCs:GetChildren()) do
        if v.Name ~= LocalPlayer.Name and v:FindFirstChild("HumanoidRootPart") then
            local TargetHRP = v.HumanoidRootPart
            local mag = (HumanoidRootPart.Position - TargetHRP.Position).magnitude
            if mag < TargetDistance then
                TargetDistance = mag
                Target = v
            end
        end
    end

    return Target
end

-- NOCLIP
getgenv().nclip = false
getgenv().NoPlatformNoclip = false -- the patched platformnoclip unpatched thanks to the two lines below credits to Panda
getgenv().CanCollide = true -- basic everyday noclip

if setfflag then
    setfflag("HumanoidParallelRemoveNoPhysics", "False") -- thank you panda your hot UwU
    setfflag("HumanoidParallelRemoveNoPhysicsNoSimulate2", "False")
end

game:GetService("RunService").Stepped:Connect(
    function()
        if getgenv().nclip then
            for i, v in pairs(lp.Character:GetChildren()) do
                if v:IsA("BasePart") and getgenv().CanCollide then
                    v.CanCollide = false-- boring old CanCollide Right?
                elseif v:IsA("Humanoid") and getgenv().NoPlatformNoclip then
                    v:ChangeState(11) -- sexy
                end
            end
        end
    end
)



for i,v in pairs(getconnections(game.Players.LocalPlayer.Idled)) do
v:Disable()
end


getgenv().ColorSettings = {
    Color3.fromRGB();
    Color3.fromRGB();
    Color3.fromRGB();
    Color3.fromRGB();
    Color3.fromRGB()
}

getgenv().GUISettings = {
    ["SchemeColor"] = ColorSettings[1],
    ["Background"] = ColorSettings[2],
    ["Header"] = ColorSettings[3],
    ["TextColor"] = ColorSettings[4],
    ["ElementColor"] = ColorSettings[5]
}




-- VARIABLES
local mobs = {} -- MOBS TABLE
local npcs = {}
local locations = {} 
local meditationspots = {}


local isFarming = false
getgenv().mob = nil -- SELECTED MOB
getgenv().npc = nil -- SELECTED NPC
getgenv().shadow = nil -- SELECTED SHADOW
getgenv().location = nil -- SELECTED LOCATION
getgenv().punchspeed = nil -- SELECTED PUNCH SPEED
getgenv().AutoEat = nil
getgenv().AutoShake = nil 
getgenv().farmdistance = nil
getgenv().serverTime = true


-- MOBS
for _,v in ipairs(game:GetService("Workspace").Game.Players:GetChildren()) do -- LOOPS THROUGH ALL MOBS
    insert = true -- VALUE TO CHECK THE MOB
    for _,v2 in pairs(mobs) do if v2 == v.Name then insert = false end end -- CHECKS IF MOB IS ALREADY IN THE TABLE
    if insert and v.Name ~= game.Players.LocalPlayer.Name then table.insert(mobs, v.Name) end -- IF THE MOB ISNT INSERTED THEN INSERT IT
end

-- NPCS
for _,v in ipairs(game:GetService("Workspace").Game.Trainers:GetChildren()) do -- LOOPS THROUGH ALL MOBS
    insert = true -- VALUE TO CHECK THE MOB
    for _,v2 in pairs(npcs) do if v2 == v.Name then insert = false end end -- CHECKS IF MOB IS ALREADY IN THE TABLE
    if insert and v:FindFirstChild("HumanoidRootPart") then table.insert(npcs, v.Name) end -- IF THE MOB ISNT INSERTED THEN INSERT IT
end

-- LOCATION
for _,v in ipairs(game:GetService("Workspace").Game.DoorTeleports:GetChildren()) do -- LOOPS THROUGH ALL MOBS
    insert = true -- VALUE TO CHECK THE MOB
    for _,v2 in pairs(locations) do if v2 == v.Name then insert = false end end -- CHECKS IF MOB IS ALREADY IN THE TABLE
    if insert then table.insert(locations, v.Name) end -- IF THE MOB ISNT INSERTED THEN INSERT IT
end

-- MEDITATION
for _,v in ipairs(game:GetService("Workspace").Game.Trainers:GetChildren()) do -- LOOPS THROUGH ALL MOBS
    if v.Name == "MeditationSpot" then
        local name = v:FindFirstChild("Level").Value
        insert = true -- VALUE TO CHECK THE MOB
        for _,v2 in pairs(meditationspots) do if v2 == v.Level.Value then insert = false end end -- CHECKS IF MOB IS ALREADY IN THE TABLE
        if insert then table.insert(meditationspots, v.Level.Value) end -- IF THE MOB ISNT INSERTED THEN INSERT IT
    end
end

    table.sort(locations, function(a, b)
        return a:lower() < b:lower()
    end)
    table.sort(npcs, function(a, b)
        return a:lower() < b:lower()
    end)
     table.sort(meditationspots, function(a, b)
        return a:lower() < b:lower()
    end)

-- UI LIBRARY
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))() -- GETS THE UI LIBRARY
local Window = Library.CreateLib("dahL-hub", Midnight) -- CREATES THE WINDOW

-- GUI-SETUP
local Main = Window:NewTab("Main") -- CREATES THE MAIN TAB
local Shadow = Window:NewTab("Shadow")
local Raid = Window:NewTab("Raid")
local Misc = Window:NewTab("Misc") -- CREATES THE MISC TAB
local Customize = Window:NewTab("Customize")
local Info = Window:NewTab("Info") -- CREATES THE INFO TAB

local MobFarmSection = Main:NewSection("Mob Farm") -- CREATES THE MOB FARM SECTION
local RaidSection = Raid:NewSection("Raid")
local RaidMiscSection = Raid:NewSection("Misc")
local CombatSection = Main:NewSection("Combat")
local ShadowSection = Shadow:NewSection("Shadow Farm")
local shadowImplantSection = Shadow:NewSection("Shadow Implant")
local TeleportSection = Misc:NewSection("Teleport Trainers")
local TeleportSection2 = Misc:NewSection("Teleport Place")
local InfoSection = Info:NewSection("Made By DahL")
local MiscSection = Misc:NewSection("Misc")
local CustomizeSection = Customize:NewSection("Customize GUI")
local KeybindSection = Customize:NewSection("Keybinds")

-- MAIN

local serverTimer = lp.PlayerGui.MainGui.Main.Settings.Uptime
local timerLabel = InfoSection:NewLabel(serverTimer.Text)
local function updateTimer()
    timerLabel:UpdateLabel(serverTimer.Text)
end

serverTimer.Changed:Connect(updateTimer)
    

KeybindSection:NewKeybind("Toggle UI", "toggles ui", Enum.KeyCode.RightControl, function()
	Library:ToggleUI()
end)


KeybindSection:NewKeybind("Toggle Noclip", "Bind for Noclip", Enum.KeyCode.G, function()
    if getgenv().nclip == false then
        getgenv().nclip = true
    elseif getgenv().nclip == true then
        getgenv().nclip = false
    end
end)

local mobdropdown = MobFarmSection:NewDropdown("Choose Mob", "Chooses the mob to autofarm", mobs, function(v) -- CREATES A MOB DROPDOWN TO CHOOSE THE MOBS (USES THE TABLE FROM THE MOBS SECTION ABOVE)
    getgenv().mob = v
end)

local m1dropdown = CombatSection:NewDropdown("Punch Speed", "Chooses your m1 speed ", {0.1,0.2,0.3,0.4,0.5}, function(v) -- CREATES A MOB DROPDOWN TO CHOOSE THE MOBS (USES THE TABLE FROM THE MOBS SECTION ABOVE)
    getgenv().punchspeed = v
end)

local npcdropdown = TeleportSection:NewDropdown("Choose NPC", "Chooses the npc you want to teleport to", npcs, function(v) -- CREATES A MOB DROPDOWN TO CHOOSE THE MOBS (USES THE TABLE FROM THE MOBS SECTION ABOVE)
    getgenv().npc = v
end)

local locationdropdown = TeleportSection2:NewDropdown("Choose location", "Chooses the location you want to teleport to", locations, function(v) -- CREATES A MOB DROPDOWN TO CHOOSE THE MOBS (USES THE TABLE FROM THE MOBS SECTION ABOVE)
    getgenv().location = v
end)

local shadowdropdown = ShadowSection:NewDropdown("Choose shadow", "Chooses shadow level type", meditationspots, function(v) -- CREATES A MOB DROPDOWN TO CHOOSE THE MOBS (USES THE TABLE FROM THE MOBS SECTION ABOVE)
    getgenv().shadow = v
end)

--[[local customizedropdown = CustomizeSection:NewDropdown("Choose Themes", "Chooses the theme of the GUI", themes, function(v)
    getgenv().selectedT = v
end)

local changeTheme = CustomizeSection:NewButton("Change Theme","Changes the theme", function()
    local Window = Library:CreateLib("dahL-hub", getgenv().selectedT)
end)--]]

MobFarmSection:NewSlider("Farm Distance", "Changes the distance you farm the enemy at", 17, 8, function(v) -- 500 (MaxValue) | 0 (MinValue)
    farmdistance = v
end)


for theme, color in pairs(GUISettings) do
    CustomizeSection:NewColorPicker(theme, "Change your "..theme, color, function(color3)
        Library:ChangeColor(theme, color3)
    end)
end





MiscSection:NewToggle("Auto eat", "Toggles auto eat", function(v)
    getgenv().AutoEat = v
    local wantBuy = nil
    while wait() do
        if getgenv().AutoEat == false then return end
        local calories = game.Players.LocalPlayer.PlayerGui.MainGui.Main.Bars.Calories
        if calories.AbsoluteSize.X <= 180 then
            if game.Players.LocalPlayer.Backpack:FindFirstChild("Noodle Bowl") then
                wantBuy = false
                if wantBuy == false then
                    game.Players.LocalPlayer.Character.Humanoid:EquipTool(game.Players.LocalPlayer.Backpack:FindFirstChild("Noodle Bowl"))
                    mouse1click()
                    wait(5)
                    wantBuy = true
                end
                
            else
                wantBuy = true
                if wantBuy then
                    local args = {
                    [1] = workspace.Game.Shop.Restaurant:FindFirstChild("Noodle Bowl")}
                    game:GetService("ReplicatedStorage").Remotes.ClientToServer.Shop:InvokeServer(unpack(args))
                    wait(1)
                    wantBuy = false
                else
                    
                end
            end
        end
    end
end)

MiscSection:NewToggle("Auto Shake", "Buys Protain shakes for xp boost", function(v)
    getgenv().AutoShake = v
    local wantBuy = nil
    while wait() do
        if getgenv().AutoShake == false then return end
        local timeLeft = game.Players.LocalPlayer.Data.BoosterEXP.TimeLeft.Value
        if timeLeft == 0 then
            wantBuy = true
            if game.Players.LocalPlayer.Backpack:FindFirstChild("Protein Shake") then
                game.Players.LocalPlayer.Character.Humanoid:EquipTool(game.Players.LocalPlayer.Backpack:FindFirstChild("Protein Shake"))
                mouse1click()
            else
                if wantBuy == true then
                    local args = {
                    [1] = workspace.Game.Shop.Other:FindFirstChild("Protein Shake")}
                    game:GetService("ReplicatedStorage").Remotes.ClientToServer.Shop:InvokeServer(unpack(args))
                    wait(1)
                else
                    
                end
                
            end
        else
        wait() end
    end
end)


MiscSection:NewToggle("Auto Trinket", "Auto pickups trinkets around the map", function(v)
    getgenv().AutoTrinket = v
    local TrinketGui = lp.PlayerGui.Artifact
    while wait() do
       if AutoTrinket then
            for _, trinket in pairs(game.Workspace.Game.Trinkets.Spawned:GetChildren()) do
                if trinket == nil then return else
                    if trinket:FindFirstChild("TouchInterest") then
                    lp.Character.HumanoidRootPart.CFrame = trinket.CFrame * CFrame.new(0,3,0)
                    firesignal(TrinketGui.main.yes.MouseButton1Down)
                end
                end
                
            end
        else
            break
        end
    end
end)

-- MOB FARM SECTION
MobFarmSection:NewToggle("Mob Farm", "Toggles autofarm for mobs", function(v) -- CREATES THE START / STOP TOGGLE
    getgenv().autofarmmobs = v
    while wait() do -- INFINITE LOOP
        if getgenv().autofarmmobs == false then -- IF THE TOGGLE IS OFF THEN STOP THE LOOP
            workspace:FindFirstChild("AirWalk"):Destroy()
            getgenv().nclip = false 
            return 
        end 
        if getgenv().mob == nil then -- IF THE MOB ISNT SELECTED
            game.StarterGui:SetCore("SendNotification", { -- SHOW NOTIFIACTION
                Title = "Error!", -- NOTIFICACTION LABEL
                Text = "You havent selected a mob with the dropdown above\nUntoggle this toggle!", -- NOTIFICATION DESCRIPTION / TEXT
                Icon = "", -- ICON (NO ICON)
                Duration = 2.5 -- DURATION OF THE NOTIFIACTIOn
            })
            getgenv().autofarmmobs = false -- TURN OFF THE AUTO FARM
            return -- MAKE SURE IT DOESNT EXECUTE ANYTHING UNDER // FULLY TURN OFF THE LOOP
        end
        local mob = game:GetService("Workspace").Game.Players:FindFirstChild(getgenv().mob)
        if mob == nil then
            game.StarterGui:SetCore("SendNotification", { -- SHOW NOTIFIACTION
                Title = "Info!", -- NOTIFICACTION LABEL
                Text = "There is currently no spawned mobs of this type!\nJust wait until they spawn", -- NOTIFICATION DESCRIPTION / TEXT
                Icon = "", -- ICON (NO ICON)
                Duration = 2.5 -- DURATION OF THE NOTIFIACTIOn
            })
            while wait() do -- LOOP WHICH REPEATS UNTIL THE UNTIL IS TRUE / DONE
                wait() -- WAIT SO WE DONT CRASH
                if getgenv().autofarmmobs == false then return end -- IF THE TOGGLE IS OFF THEN STOP THE LOOP
                if game:GetService("Workspace").Game.Players:FindFirstChild(getgenv().mob) ~= nil then break; end
            
            end -- IF THE MOB IS SPAWNED THEN GO ON WITH THE AUTOFARM
        else
            local mob2 = mob
            
            if workspace:FindFirstChild("AirWalk") then
                
            else
                getgenv().airwalk = Instance.new("Part", workspace)
                airwalk.Size = Vector3.new(10,1,10)
                airwalk.Name = "AirWalk"
                airwalk.Anchored = true
                airwalk.Transparency = 1
            end
           
            getgenv().nclip = true
         
            while wait() do
                mob = game:GetService("Workspace").Game.Players:FindFirstChild(getgenv().mob)
                if mob ~= mob2 then break; end
                if getgenv().autofarmmobs == false then return end -- IF THE TOGGLE IS OFF THEN STOP THE LOOP
                if mob ~= nil then
                    if mob:FindFirstChild("Humanoid") then
                        if mob.Humanoid.Health == 0 then wait(0.1) mob:Destroy() break; end -- IF THE MOB IS DEAD THEN JUST DESTROY IT FOR FASTER FARMING
                    end
                    if mob:FindFirstChild("HumanoidRootPart") then
                        airwalk.CFrame = mob.HumanoidRootPart.CFrame * CFrame.new(0,farmdistance,0)
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = airwalk.CFrame * CFrame.new(0,2.9,0) -- TELEPORT TO THE MOB
                    end
                end
                wait() -- WAIT SO WE DONT CRASH
            end
        end
    end
end)

RaidSection:NewToggle("Yasha Ape", "Starts Yasha Ape quest", function(v)
    getgenv().autoYasha = v
    
    while wait() do
        if autoYasha == false then
            workspace:FindFirstChild("AirWalk"):Destroy()
            getgenv().nclip = false
            break;
        else
            while isFarming == false do
            for _, s in pairs(game.Workspace.Game.Trainers:GetChildren()) do
                if s.Name == "Owen" then
                    if autoYasha == false then return end
                    local Dialogue = game.Players.LocalPlayer.PlayerGui.Dialogue
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = s.HumanoidRootPart.CFrame * CFrame.new(0,0,-2)
                    local clickd = s.ClickDetector
                    fireclickdetector(clickd)
                    wait(4)
                    for i,v in pairs(getconnections(Dialogue.Path1.MouseButton1Click)) do
                         v:Fire()
                    end
                    for _, v in pairs(game.Workspace.Game.Players:GetChildren()) do
                        if v.Name == "Yasha Ape" then
                            getgenv().foundMob = v.HumanoidRootPart
                            print(foundMob)
                            isFarming = true
                            getgenv().nclip = true
                        end
                    end
                    
                end
            end
        end
        
            if isFarming == true then
                if workspace:FindFirstChild("AirWalk") then
                    
                else
                    getgenv().airwalk = Instance.new("Part", workspace)
                    airwalk.Size = Vector3.new(10,1,10)
                    airwalk.Name = "AirWalk"
                    airwalk.Anchored = true
                    airwalk.Transparency = 1
                end
                airwalk.CFrame = foundMob.CFrame * CFrame.new(0,farmdistance,0)
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = airwalk.CFrame * CFrame.new(0,2.9,0)
                if foundMob.Parent.Humanoid.Health == 0 then wait(5) isFarming = false end
            end
        end
        
    end
end)

getgenv().WaveLabel = nil 

function updateWave()
    if getgenv().Wave == nil then
        return
    else
        getgenv().WaveLabel:UpdateLabel("Bosses Defeated: "..getgenv().Wave)
    end
    
end

RaidSection:NewToggle("Boss rush", "Auto farrms the boss rush raid", function(v)
    getgenv().autoBossRush = v
    getgenv().rushActive = false
    local Apple = game.Workspace.Game.Trainers:FindFirstChild("Apple")
    local TeleportPad = game.Workspace:FindFirstChild("SpireBox")
    local clickd = Apple:FindFirstChild("ClickDetector")
    local Dialogue = game.Players.LocalPlayer.PlayerGui.Dialogue
    getgenv().Wave = "Boss Progress (Activates when boss rush)"
    getgenv().closestBoss = nil
    while wait() do
        getgenv().closestBoss = GetClosest()
        if autoBossRush then
            if getgenv().rushActive == false then
                if TeleportPad.BillboardGui.Enabled == false then
                    lp.Character.HumanoidRootPart.CFrame = Apple.HumanoidRootPart.CFrame * CFrame.new(0,0,-3)
                    fireclickdetector(clickd)
                    for i,v in pairs(getconnections(Dialogue.Path1.MouseButton1Click)) do
                         v:Fire()
                    end
                else
                    lp.Character.HumanoidRootPart.CFrame = TeleportPad.CFrame
                    if TeleportPad.BillboardGui.TextLabel.Text == "0" then
                        getgenv().rushActive = true
                    end
                end
               
            else
                if workspace:FindFirstChild("AirWalk") then
                    
                else
                    getgenv().airwalk = Instance.new("Part", workspace)
                    airwalk.Size = Vector3.new(10,1,10)
                    airwalk.Name = "AirWalk"
                    airwalk.Anchored = true
                    airwalk.Transparency = 1
                end
                
                
                
                while wait() do
                    getgenv().Wave = string.gsub(game.Players.LocalPlayer.PlayerGui.MainGui.Main.Alert.Text, "%D", "")
                    updateWave()
                    if getgenv().closestBoss == nil and getgenv().rushActive == true then
                        GetClosest()
                        getgenv().closestBoss = GetClosest()
                        wait()
                    else
                        getgenv().nclip = true
                        airwalk.CFrame = getgenv().closestBoss.HumanoidRootPart.CFrame * CFrame.new(0,farmdistance,0)
                        lp.Character.HumanoidRootPart.CFrame = airwalk.CFrame * CFrame.new(0,2.8,0)
                        if getgenv().Wave == "25" then
                            lp.Character.Humanoid.Health = 0
                        end
                        if lp.Character.Humanoid.Health <= 0 then 
                            getgenv().rushActive = false 
                        end
                        if getgenv().closestBoss:FindFirstChild("Humanoid") then
                            if getgenv().closestBoss.Humanoid.Health == 0 then wait(0.1) getgenv().closestBoss:Destroy() break; end -- IF THE MOB IS DEAD THEN JUST DESTROY IT FOR FASTER FARMING
                        end
                    end
                    wait()
                end
            end
        else
            getgenv().nclip = false
            workspace:FindFirstChild("AirWalk"):Destroy()
            break;
        end
    end
end)

RaidMiscSection:NewToggle("Auto Dodge lethal attack", "Auto dodges lethal attacks in boss rush", function(v)
    getgenv().autoDodge = v
    local skillsFolder = game:GetService("Players").LocalPlayer.Data.Skills
    while wait() do
        if autoDodge then
                if getgenv().closestBoss.Torso.Transparency == 1 then
                    print("JASON!!")
                    repeat wait() until getgenv().closestBoss.Torso.Transparency ~= 1
                    if skillsFolder.Skill3.OnCooldown.Value == true then
                        game:GetService("ReplicatedStorage").Remotes.ClientToServer.Skill:FireServer(skillsFolder.Skill5.Value)
                    else
                        game:GetService("ReplicatedStorage").Remotes.ClientToServer.Skill:FireServer(skillsFolder.Skill2.Value)
                    end
                    wait()
                end
        else
           break; 
        end
    end
end)

RaidMiscSection:NewToggle("Auto Boost", "Auto uses awakening and heal\n Note: Requires Ohma Niko", function(v)
    getgenv().autoBoostSkill = v
    local skillsFolder = game:GetService("Players").LocalPlayer.Data.Skills
    -- Script generated by SimpleSpy - credits to exx#9394

    local args = {
        [1] = "Implant",
        [2] = "Heart Pump"
    }

    while wait() do
        if autoBoostSkill then
            if getgenv().rushActive then
                if game.Players.LocalPlayer.Character.Humanoid.Health <= game.Players.LocalPlayer.Character.Humanoid.MaxHealth * 0.50 then
                    
                else
                    game:GetService("ReplicatedStorage").Remotes.ClientToServer.Skill:FireServer("Rage")
                    game:GetService("ReplicatedStorage").Remotes.ClientToServer.Skill:FireServer(unpack(args))
                    wait(1)
                end
                
                if game.Players.LocalPlayer.Character.Humanoid.Health <= game.Players.LocalPlayer.Character.Humanoid.MaxHealth *0.80 then
                    game:GetService("ReplicatedStorage").Remotes.ClientToServer.Skill:FireServer(skillsFolder.Skill3.Value)
                    wait(1)
                end
            else
                break;
            end
        else
           break; 
        end
    end
end)

getgenv().WaveLabel = RaidMiscSection:NewLabel("Boss Progress (Activates when boss rush)")








-- COMBAT SECTION

CombatSection:NewToggle("Auto Punch", "Enables auto punch for autofarm", function(v)
    getgenv().autopunch = v
    local index1 = 1
    local Closest
    while wait() do
        if getgenv().autopunch == false then break; end
        Closest = GetClosest()
        if getgenv().punchspeed == nil then
            game.StarterGui:SetCore("SendNotification", { -- SHOW NOTIFIACTION
                Title = "Error!", -- NOTIFICACTION LABEL
                Text = "You havent selected punch speed!", -- NOTIFICATION DESCRIPTION / TEXT
                Icon = "", -- ICON (NO ICON)
                Duration = 2.5 -- DURATION OF THE NOTIFIACTIOn
            })
            getgenv().autopunch = false
            return
        end
        
        if Closest == nil then
            wait(1)
            GetClosest()
            Closest = GetClosest()
            wait()
        end
        if Closest ~= nil then
            
            combo = combo + 1
            if combo == 5 then
                
                if index1 == 5 then
                    punchType = "HeavyPunch"
                    wait(1.5)
                    index1 = 1
                end
                combo = 1 
                index1 = index1 + 1
            else
                punchType = "LightPunch" 
            end
            local args = {
                [1] = punchType,
                [2] = combo,
                [3] = Closest.Humanoid
            }
            game:GetService("ReplicatedStorage").Remotes.ClientToServer.BasicCombat:FireServer(unpack(args))
        end
        wait(getgenv().punchspeed)
    end
end)





ShadowSection:NewToggle("Start farm", "Enables shadow auto farm", function(v)
    getgenv().shadowfarm = v
    local YujiroSpecial = false
    while wait() do
        if getgenv().shadowfarm == false then
            workspace:FindFirstChild("AirWalk"):Destroy()
            getgenv().nclip = false
            return
        end
        if getgenv().shadow == nil then
             game.StarterGui:SetCore("SendNotification", { -- SHOW NOTIFIACTION
                Title = "Error!", -- NOTIFICACTION LABEL
                Text = "You havent selected a shadow with the dropdown above\nUntoggle this toggle!", -- NOTIFICATION DESCRIPTION / TEXT
                Icon = "", -- ICON (NO ICON)
                Duration = 2.5 -- DURATION OF THE NOTIFIACTIOn
            })
            getgenv().shadowfarm = false -- TURN OFF THE AUTO FARM
            return -- MAKE SURE IT DOESNT EXECUTE ANYTHING UNDER // FULLY TURN OFF THE LOOP
        end
        while isFarming == false do
            for _, s in pairs(game.Workspace.Game.Trainers:GetChildren()) do
                if s.Name == "MeditationSpot" then
                    if s.Level.Value == shadow then
                        if shadowfarm == false then break; end
                        local Dialogue = game.Players.LocalPlayer.PlayerGui.Dialogue
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = s.Part.CFrame * CFrame.new(0,3,0)
                        local clickd = s.ClickDetector
                        fireclickdetector(clickd)
                        wait(4)
                        for i,v in pairs(getconnections(Dialogue.Path1.MouseButton1Click)) do
                             v:Fire()
                        end
                        for _, v in pairs(game.Workspace.Game.Players:GetChildren()) do
                            if string.find(v.Name, "Shadow") or string.find(v.Name, "Yujiro") or string.find(v.Name, "Musashi") then
                                if string.find(v.Name, "Yujiro") then
                                    YujiroSpecial = true
                                else
                                    YujiroSpecial = false
                                end
                                getgenv().foundMob = v.HumanoidRootPart
                                print(foundMob)
                                isFarming = true
                                getgenv().nclip = true
                            end
                        end
                    end
                end
            end
        end
        if isFarming == true then
            if workspace:FindFirstChild("AirWalk") then
                
            else
                getgenv().airwalk = Instance.new("Part", workspace)
                airwalk.Size = Vector3.new(10,1,10)
                airwalk.Name = "AirWalk"
                airwalk.Anchored = true
                airwalk.Transparency = 1
            end
            if YujiroSpecial == true then
                local HealthP = game.Players.LocalPlayer.Character.Humanoid.MaxHealth * 0.25
                if game.Players.LocalPlayer.Character.Humanoid.Health <= game.Players.LocalPlayer.Character.Humanoid.MaxHealth - HealthP then
                    airwalk.CFrame = foundMob.CFrame * CFrame.new(0,farmdistance,0)
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = airwalk.CFrame * CFrame.new(0,2.9,0)
                    if foundMob.Parent.Humanoid.Health == 0 then wait(5) isFarming = false end
                else
                    airwalk.CFrame = foundMob.CFrame * CFrame.new(0,-4,4)
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = airwalk.CFrame * CFrame.new(0,2.9,0)
                end
            else
                 airwalk.CFrame = foundMob.CFrame * CFrame.new(0,farmdistance,0)
                 game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = airwalk.CFrame * CFrame.new(0,2.9,0)
                 if foundMob.Parent.Humanoid.Health == 0 then wait(5) isFarming = false end
            end
            
        end
    end
end)


shadowImplantSection:NewToggle("Auto shadow implant", "Auto get shadow implant\n  Note: You have to be in prison server", function(v)
    getgenv().AutoShadowImplant = v
    
    while wait() do
       if AutoShadowImplant then
            
        else
            break;
        end
    end
end)

--TeleportSection
TeleportSection:NewButton("Teleport", "Teleports to the npc you selected", function(v)
    local TPNPC = game:GetService("Workspace").Game.Trainers:FindFirstChild(getgenv().npc)
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = TPNPC.HumanoidRootPart.CFrame * CFrame.new(0,0,-4)
end)

TeleportSection2:NewButton("Teleport", "Teleports to the location you selected", function(v)
    local TPLOCATION = game:GetService("Workspace").Game.DoorTeleports:FindFirstChild(getgenv().location)
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = TPLOCATION.CFrame
end)

TeleportSection:NewButton("TP City 1/2", "Quickly tp between city 1 or 2\n Note: Will kill you", function()
    if workspace.Game:FindFirstChild("Map1") then
        workspace.Game.Map1.Parent = game.ReplicatedStorage
        game.ReplicatedStorage.Map2.Parent = workspace.Game
        wait()
        game.Players.LocalPlayer.Character.Humanoid.Health = 0
    elseif workspace.Game:FindFirstChild("Map2") then
        workspace.Game.Map2.Parent = game.ReplicatedStorage
        game.ReplicatedStorage.Map1.Parent = workspace.Game
        wait()
        game.Players.LocalPlayer.Character.Humanoid.Health = 0
    end
end)





-- UPDATING THE MOBS

game:GetService("Workspace").Game.Players.ChildAdded:Connect(function() -- WHEN MOB SPAWNS
    for _,v2 in pairs(mobs) do table.remove(mobs, _) end -- REMOVES ALL THE OLD MOBS
    -- ADDS THE NEW MOBS
    for _,v in pairs(game:GetService("Workspace").Game.Players:GetChildren()) do -- LOOPS THROUGH ALL MOBS
        insert = true -- VALUE TO CHECK THE MOB
        for _,v2 in pairs(mobs) do if v2 == v.Name then insert = false end end -- CHECKS IF MOB IS ALREADY IN THE TABLE
        if insert and v.Name ~= game.Players.LocalPlayer.Name then table.insert(mobs, v.Name) end -- IF THE MOB ISNT INSERTED THEN INSERT IT
        table.sort(mobs, function(a, b)
            return a:lower() < b:lower()
        end)
        table.sort(npcs, function(a, b)
            return a:lower() < b:lower()
        end)
    end
    mobdropdown:Refresh(mobs)
end)

game:GetService("Workspace").Game.Players.ChildRemoved:Connect(function() -- WHEN MOB DIES / GETS REMOVED
    for _,v2 in pairs(mobs) do table.remove(mobs, _) end -- REMOVES ALL THE OLD MOBS
    -- ADDS THE NEW MOBS
    for _,v in pairs(game:GetService("Workspace").Game.Players:GetChildren()) do -- LOOPS THROUGH ALL MOBS
        insert = true -- VALUE TO CHECK THE MOB
        for _,v2 in pairs(mobs) do if v2 == v.Name then insert = false end end -- CHECKS IF MOB IS ALREADY IN THE TABLE
        if insert then table.insert(mobs, v.Name) end -- IF THE MOB ISNT INSERTED THEN INSERT IT
        table.sort(mobs, function(a, b)
            return a:lower() < b:lower()
        end)
        table.sort(npcs, function(a, b)
            return a:lower() < b:lower()
        end)
    end
   
    mobdropdown:Refresh(mobs)
end)

