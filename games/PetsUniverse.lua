if game.GameId ~= 10759638075 then return end
if getgenv().AlienitePetsLoaded then
    pcall(function()
        if getgenv().AlienitePetsLib then getgenv().AlienitePetsLib:Unload() end
    end)
    task.wait(0.5)
end
getgenv().AlienitePetsLoaded = true
getgenv().AlienitePetsGen = (getgenv().AlienitePetsGen or 0) + 1
local myGen = getgenv().AlienitePetsGen
local function genAlive()
    return myGen == getgenv().AlienitePetsGen
end
local function jitter(base, frac)
    return base
end
local function phase(maxWait)
    task.wait(math.random() * (maxWait or 1))
end
local Repo = "https://raw.githubusercontent.com/joustingmatch/ObsidianUltra/main/"
local HUB_NAME = "Alienite Hub"
local DISCORD_INVITE = "https://discord.gg/jzWT3uukXD"
local Library = loadstring(game:HttpGet(Repo .. "Library.lua"))()
local ThemeManager = loadstring(game:HttpGet(Repo .. "addons/ThemeManager.lua"))()
local SaveManager = loadstring(game:HttpGet(Repo .. "addons/SaveManager.lua"))()
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")
local LocalPlayer = Players.LocalPlayer
local Options = Library.Options
local Toggles = Library.Toggles
pcall(function()
    Library.Scheme.BackgroundColor = Color3.fromRGB(13, 13, 13)
    Library.Scheme.MainColor = Color3.fromRGB(40, 40, 40)
    Library.Scheme.OutlineColor = Color3.fromRGB(58, 58, 58)
    Library.Scheme.AccentColor = Color3.fromRGB(88, 101, 242)
    Library.Scheme.FontColor = Color3.fromRGB(255, 255, 255)
end)
local Window = Library:CreateWindow({
    Title = HUB_NAME,
    Icon = "gem",
    IconSize = UDim2.fromOffset(28, 28),
    Footer = { "Alienite Hub | ", { Text = "Pets Universe", Copyable = true } },
    CopyableFooter = true,
    DisableSearch = true,
    ToggleKeybind = Enum.KeyCode.RightShift,
    Minimizable = true,
    CornerRadius = 10,
    ShowCustomCursor = true,
    NotifySide = "Right",
})
pcall(function() Window:SetCornerRadius(10) end)
Library:OnUnload(function() getgenv().AlienitePetsLoaded = false end)
local Tabs = {
    Main = Window:AddTab({ Name = "Main", Description = "Overview", SingleColumn = true }),
    Activities = Window:AddTab({ Name = "Activities", Description = "Farming, fishing, and automation" }),
    Teleports = Window:AddTab({ Name = "Teleports", Description = "World travel" }),
    Tools = Window:AddTab({ Name = "Tools", Description = "Settings and utilities" }),
    About = Window:AddTab({ Name = "About", Description = "Community and release history" }),
}
local ActivityTabs = {
    Breakables = Tabs.Activities:AddSubTab("Breakables"),
    Playtime = Tabs.Activities:AddSubTab("Playtime"),
    Fishing = Tabs.Activities:AddSubTab("Fishing"),
    Hatching = Tabs.Activities:AddSubTab("Hatching & Pets"),
    Upgrades = Tabs.Activities:AddSubTab("Upgrades"),
    Items = Tabs.Activities:AddSubTab("Items"),
    MoonTree = Tabs.Activities:AddSubTab("Moon & Tree"),
    Events = Tabs.Activities:AddSubTab("Events"),
    Rebirth = Tabs.Activities:AddSubTab("Rebirth"),
}
local ToolTabs = {
    Settings = Tabs.Tools:AddSubTab("Settings"),
    Utilities = Tabs.Tools:AddSubTab("Utilities"),
}
do
    local DiscordGroup = Tabs.About:AddLeftGroupbox("Discord Server")
    DiscordGroup:AddLabel("Join the Alienite Hub Discord for updates, support, announcements, and community features.", true)
    DiscordGroup:AddButton({ Text = "Join Discord", Func = function()
        if DISCORD_INVITE == "" then
            Library:Notify({ Title = HUB_NAME, Description = "The official Discord invite has not been configured yet.", Time = 4, Type = "Warning" })
            return
        end
        if not (DISCORD_INVITE:match("^https://discord%.gg/[%w%-_]+$") or DISCORD_INVITE:match("^https://discord%.com/invite/[%w%-_]+$")) then
            Library:Notify({ Title = HUB_NAME, Description = "The configured Discord invite is not a valid HTTPS invite URL.", Time = 4, Type = "Warning" })
            return
        end
        local ok = pcall(function()
            game:GetService("GuiService"):OpenBrowserWindow(DISCORD_INVITE)
        end)
        if not ok then
            Library:Notify({ Title = HUB_NAME, Description = "This Roblox client could not open the invite link.", Time = 4, Type = "Warning" })
        end
    end })
    if DISCORD_INVITE == "" then
        DiscordGroup:AddLabel("Configure DISCORD_INVITE near the top of the script before release.", true)
    end
end
do
    local ChangeLogGroup = Tabs.About:AddLeftGroupbox("Alienite Hub — Change Log")
    local CHANGELOG = {
        {
            Version = "v1.2.1 — Fishing Controls",
            Date = "2026-10-04",
            NewFeatures = {
                "Added fishing spots for Spawn, Treasure Dunes, and Haunted.",
            },
            Changes = {
                "Removed the nonfunctional Fishing streak display and its session/event queries.",
                "Added Fast Reeling with one-second spacing between remote calls.",
                "Removed Fishing tooltips and explanatory notes.",
            },
            BugFixes = {},
        },
        {
            Version = "v1.2.0 — Event Targets & Fishing",
            Date = "2026-10-03",
            NewFeatures = {
                "Added Ruby Egg event choices for Spawn, Volcano, and The Moon.",
                "Added an integrated Fishing tab with guarded, rate-limited controls.",
            },
            Changes = {
                "Added Moon Chest as an automatic breakables target.",
            },
            BugFixes = {
                "Fixed the alien event egg click path when the egg is outside Breakables.",
            },
        },
        {
            Version = "v1.1.0 — Dashboard & Quick Actions",
            Date = "2026-10-03",
            NewFeatures = {
                "Added a live main-page automation and target dashboard.",
                "Added an accent-blue Discord invite button that copies the configured invite.",
                "Added a Stop All Automations quick action.",
            },
            Changes = {},
            BugFixes = {},
        },
        {
            Version = "v1.0.0 — Alienite Hub Update",
            Date = "2026-10-01",
            NewFeatures = {
                "Added Discord Server section and Join Discord button.",
                "Added a dedicated Change Log tab.",
            },
            Changes = {
                "Rebranded the hub as Alienite Hub.",
                "Organized existing features under Main, Automation, Teleports, Farming, Misc, and Settings.",
                "Retained Obsidian and its DPI scaling controls for desktop and compact screens.",
                "Updated the layout and config folders for the new branding.",
            },
            BugFixes = {
                "Removed the third-party analytics loader.",
            },
        },
    }
    for _, entry in ipairs(CHANGELOG) do
        ChangeLogGroup:AddLabel(entry.Version .. "  |  " .. entry.Date, true)
        ChangeLogGroup:AddLabel("New Features:", true)
        for _, item in ipairs(entry.NewFeatures) do
            ChangeLogGroup:AddLabel("• " .. item, true)
        end
        ChangeLogGroup:AddLabel("Changes:", true)
        for _, item in ipairs(entry.Changes) do
            ChangeLogGroup:AddLabel("• " .. item, true)
        end
        ChangeLogGroup:AddLabel("Bug Fixes:", true)
        for _, item in ipairs(entry.BugFixes) do
            ChangeLogGroup:AddLabel("• " .. item, true)
        end
    end
end
local SafeGet = require(ReplicatedStorage.Modules.SafeGetService)
local function GetSvc(name, methods)
    local ok, svc = pcall(SafeGet.Get, name, methods)
    if ok and svc then return svc end
    return nil
end
local EGG_LIST = { "Basic Egg", "Sprout Egg", "Grassy Egg", "Dried Egg", "Frost Egg", "Zombie Egg", "Castle Egg", "Universe Egg", "Mushroom Egg", "Volcano Egg", "Ruby Egg", "Ruby Egg 2x", "Ruby Egg 5x" }
local EVENT_EGG_WORLDS = {
    ["Ruby Egg"] = "Spawn",
    ["Ruby Egg 2x"] = "VolcanoHollow",
    ["Ruby Egg 5x"] = "TheMoon",
}
local EVENT_EGG_HATCH_KEYS = {
    ["Ruby Egg 2x"] = "Ruby Egg x2Luck",
    ["Ruby Egg 5x"] = "Ruby Egg x5Luck",
}
local EVENT_EGG_ALIASES = {
    ["Ruby Egg"] = { "Ruby Egg", "RubyEgg", "RubyEggSpawn" },
    ["Ruby Egg 2x"] = { "Ruby Egg x2Luck", "Ruby Egg 2x", "Ruby Egg x2", "RubyEgg2x", "RubyEggX2" },
    ["Ruby Egg 5x"] = { "Ruby Egg x5Luck", "Ruby Egg 5x", "Ruby Egg x5", "RubyEgg5x", "RubyEggX5" },
}
local MODE_LIST = { "Single", "Half", "Max" }
local WORLD_LIST = { "Spawn", "BirchForest", "TreasureDunes", "FrozenAlley", "HauntedHouse", "PetKingdom", "EnchantedGrove", "VolcanoHollow", "TheMoon" }
local MOON_INC_LIST = { "Damage", "MoreGems", "TapPower", "PetAttackSpeed", "CritDmg", "ChestTier", "Blackhole", "AstralBeeChance", "AstralBeeVariant" }
local MOON_PERM_LIST = { "CoinMultiplier", "RubiesMultiplier", "GemsMultiplier", "LuckMultiplier", "HatchSpeedMultiplier", "CritChance", "EggHatch", "PetEquip" }
local CRAFT_IDS = {}
pcall(function()
    local cfg = require(ReplicatedStorage.Modules:FindFirstChild("ItemCraftConfig"))
    for _, r in ipairs(cfg.Recipes) do
        if type(r.Id) == "string" then table.insert(CRAFT_IDS, r.Id) end
    end
    table.sort(CRAFT_IDS)
end)
if #CRAFT_IDS == 0 then
    CRAFT_IDS = { "Potion_Coins", "Potion_Rubies", "Potion_Luck", "Potion_Critical", "Potion_Hatch" }
end
local ITEM_LIST = {
    "Apple", "Banana", "Blueberry", "Kiwi", "Mango", "Taco",
    "CoinsPotion", "CoinsPotion2", "CoinsPotion3", "RubiesPotion", "RubiesPotion2", "RubiesPotion3",
    "LuckPotion", "LuckPotion2", "LuckPotion3", "HatchSpeedPotion", "HatchSpeedPotion2", "HatchSpeedPotion3",
    "CriticalPotion", "CriticalPotion2", "CriticalPotion3",
    "Ball", "Bone", "Cookie", "Squeaky",
}
local LUCKYBLOCK_LIST = { "BasicLuckyblock", "RareLuckyblock", "HackerLuckyblock" }
do
    Tabs.Main:AddPlayerInfo("MainBanner", {
        Title = "Welcome to <b>Alienite Hub</b>",
        Description = { "Pets Universe tools and session overview", "Farming = breakables | Automation = hatching, upgrades, items | Teleports = worlds" },
        ThumbnailType = "HeadShot",
        Height = 84,
    })
    local Info = Tabs.Main:AddGroupbox({ Name = "Session", Side = 1 })
    Info:AddLabel("Hub: Alienite Hub | Version: v1.2.0", true)
    Info:AddLabel("Game: Pets Universe", true)
    Info:AddButton({
        Text = DISCORD_INVITE,
        Tooltip = "Click to copy the configured Discord invite.",
        Func = function()
            local copy = setclipboard or toclipboard or writeclipboard
            if not copy and type(syn) == "table" then copy = syn.write_clipboard end
            if type(copy) ~= "function" then
                Library:Notify({ Title = HUB_NAME, Description = "Clipboard copy is unavailable in this executor.", Time = 4, Type = "Warning" })
                return
            end
            local ok = pcall(copy, DISCORD_INVITE)
            if ok then
                Library:Notify({ Title = HUB_NAME, Description = "Discord invite copied to clipboard.", Time = 4, Type = "Success" })
            else
                Library:Notify({ Title = HUB_NAME, Description = "Could not copy the Discord invite.", Time = 4, Type = "Warning" })
            end
        end,
    })

    local AUTOMATION_STATUS = {
        { "AutoClickBreakables", "Breakables" },
        { "AutoFishing", "Fishing" },
        { "AutoClaimPlaytime", "Playtime rewards" },
        { "AutoClaimPartyEgg", "Playtime egg" },
        { "AutoHatch", "Egg hatching" },
        { "AutoTpEgg", "Egg teleport" },
        { "AutoEquipBest", "Best-pet equip" },
        { "AutoGolden", "Golden crafting" },
        { "AutoDiamond", "Diamond crafting" },
        { "HatchWebhook", "Hatch webhook" },
        { "UpCoins", "Coin upgrades" },
        { "UpRubies", "Ruby upgrades" },
        { "UpLuck", "Luck upgrades" },
        { "UpHatch", "Hatch upgrades" },
        { "UpCrit", "Critical upgrades" },
        { "UpPetSpeed", "Pet-speed upgrades" },
        { "AutoBuyWorlds", "World purchases" },
        { "AutoUseItems", "Item use" },
        { "AutoCraftItems", "Item crafting" },
        { "AutoMoonInc", "Moon upgrades" },
        { "AutoMoonPerm", "Permanent Moon upgrades" },
        { "AutoSkillTree", "Skill tree" },
        { "AutoOpenBlocks", "Lucky Blocks" },
        { "AutoMoonRebirth", "Moon rebirth" },
    }
    local automationCountLbl = Info:AddLabel("Automations active: 0", true)
    local automationListLbl = Info:AddLabel("Running: None", true)
    local targetLbl = Info:AddLabel("Target: loading...", true)
    Info:AddButton({
        Text = "Stop All Automations",
        Func = function()
            local stopped = 0
            for _, item in ipairs(AUTOMATION_STATUS) do
                local toggle = Toggles[item[1]]
                if toggle and toggle.Value then
                    local ok = pcall(function()
                        if type(toggle.SetValue) == "function" then
                            toggle:SetValue(false)
                        else
                            toggle.Value = false
                        end
                    end)
                    if ok then stopped = stopped + 1 end
                end
            end
            Library:Notify({
                Title = HUB_NAME,
                Description = "Stopped " .. tostring(stopped) .. " automation(s).",
                Time = 4,
                Type = "Success",
            })
        end,
    })

    local clockLbl = Info:AddLabel("SessionTime: 00:00", true)
    local startT = os.clock()
    task.spawn(function()
        while not Library.Unloaded and genAlive() do
            task.wait(1)
            local el = math.floor(os.clock() - startT)
            local mm = string.format("%02d:%02d", math.floor(el / 60), el % 60)
            pcall(function() clockLbl:SetText("SessionTime: " .. mm) end)
            local active = {}
            for _, item in ipairs(AUTOMATION_STATUS) do
                local toggle = Toggles[item[1]]
                if toggle and toggle.Value then table.insert(active, item[2]) end
            end
            pcall(function() automationCountLbl:SetText("Automations active: " .. tostring(#active)) end)
            if #active == 0 then
                pcall(function() automationListLbl:SetText("Running: None") end)
            else
                local shown = {}
                for i = 1, math.min(#active, 3) do table.insert(shown, active[i]) end
                local extra = #active - #shown
                local suffix = extra > 0 and (", +" .. tostring(extra) .. " more") or ""
                pcall(function() automationListLbl:SetText("Running: " .. table.concat(shown, ", ") .. suffix) end)
            end
            local egg = Options.SelectedEgg and Options.SelectedEgg.Value or "—"
            local hatchMode = Options.HatchMode and Options.HatchMode.Value or "—"
            local world = Options.TeleportWorld and Options.TeleportWorld.Value or "—"
            pcall(function()
                targetLbl:SetText("Target: " .. tostring(egg) .. " • " .. tostring(hatchMode) .. " • " .. tostring(world))
            end)
        end
    end)
end
do
    local FishingGroup = ActivityTabs.Fishing:AddLeftGroupbox("Fishing Service")
    local fishingGeneration = 0
    local nextFishingStep = 1
    local maxFishingStep = 100000
    local fishingSpots = {
        Spawn = Vector3.new(-191, 13, -38),
        ["Treasure Dunes"] = Vector3.new(1110, 1, -1619),
        Haunted = Vector3.new(2408, 4, -2863),
    }
    local function teleportToFishingSpot(name)
        local position = fishingSpots[name]
        local character = LocalPlayer.Character
        local root = character and character:FindFirstChild("HumanoidRootPart")
        if root and position then
            root.CFrame = CFrame.new(position)
        end
    end
    local function invokeFishingRemote(remote, ...)
        local packed = table.pack(pcall(function(...)
            return remote:InvokeServer(...)
        end, ...))
        if not packed[1] then return false, nil end
        local result = { n = packed.n - 1 }
        for i = 2, packed.n do
            result[i - 1] = packed[i]
        end
        return true, result
    end
    local function findFishingChild(parent, name)
        if not parent then return nil end
        return parent:FindFirstChild(name) or parent:WaitForChild(name, 5)
    end
    local function getFishingRemotes()
        local packages = findFishingChild(ReplicatedStorage, "Packages")
        local knit = findFishingChild(packages, "Knit")
        local services = findFishingChild(knit, "Services")
        local service = findFishingChild(services, "FishingService")
        local remoteFolder = findFishingChild(service, "RF")
        return findFishingChild(remoteFolder, "StartFishing"),
            findFishingChild(remoteFolder, "SpeedUp")
    end
    local function isRemoteFunction(remote)
        return remote and remote:IsA("RemoteFunction")
    end
    FishingGroup:AddDropdown("FishingSpot", {
        Text = "Fishing Spot",
        Values = { "Spawn", "Treasure Dunes", "Haunted" },
        Default = 1,
        Callback = teleportToFishingSpot,
    })
    FishingGroup:AddToggle("AutoFishing", { Text = "Auto Fishing", Default = false })

    local function stopAutoFishing()
        fishingGeneration = fishingGeneration + 1
    end
    local function setAutoFishing(value)
        pcall(function()
            local toggle = Toggles.AutoFishing
            if type(toggle.SetValue) == "function" then
                toggle:SetValue(value)
            else
                toggle.Value = value
            end
        end)
    end
    local function turnOffAutoFishing()
        setAutoFishing(false)
    end
    local fishingWorkerRunning = false
    local function startAutoFishingWorker()
        if fishingWorkerRunning then return end
        fishingWorkerRunning = true
        task.spawn(function()
            while not Library.Unloaded and genAlive() and Toggles.AutoFishing.Value do
                local myGeneration = fishingGeneration
                local startRemote, speedRemote = getFishingRemotes()
                if not isRemoteFunction(startRemote) or not isRemoteFunction(speedRemote) then
                    turnOffAutoFishing()
                    break
                end
                local started = invokeFishingRemote(startRemote)
                if not started then
                    turnOffAutoFishing()
                    break
                end
                while not Library.Unloaded and genAlive() and Toggles.AutoFishing.Value and myGeneration == fishingGeneration do
                    if nextFishingStep > maxFishingStep then
                        turnOffAutoFishing()
                        break
                    end
                    task.wait(1)
                    if Library.Unloaded or not genAlive() or not Toggles.AutoFishing.Value or myGeneration ~= fishingGeneration then
                        break
                    end
                    local currentStep = nextFishingStep
                    local ok = invokeFishingRemote(speedRemote, currentStep, 1, 1)
                    if not ok then
                        turnOffAutoFishing()
                        break
                    end
                    nextFishingStep = currentStep + 1
                end
            end
            fishingWorkerRunning = false
            if not Library.Unloaded and genAlive() and Toggles.AutoFishing.Value then
                startAutoFishingWorker()
            end
        end)
    end
    FishingGroup:AddButton({ Text = "Fast Reeling", Func = function()
        setAutoFishing(true)
    end })
    Toggles.AutoFishing:OnChanged(function()
        if not Toggles.AutoFishing.Value then
            stopAutoFishing()
            return
        end
        fishingGeneration = fishingGeneration + 1
        if nextFishingStep > maxFishingStep then
            turnOffAutoFishing()
            return
        end
        startAutoFishingWorker()
    end)
end
do
    local BreakTab = ActivityTabs.Breakables
    local PlayTab = ActivityTabs.Playtime
    local G = BreakTab:AddLeftGroupbox("Breakables")
    G:AddToggle("AutoClickBreakables", { Text = "Auto Click Breakables", Default = false, Tooltip = "Clicks nearest + built-in auto" })
    G:AddSlider("ClickDelay", { Text = "Click Delay", Default = 150, Min = 50, Max = 1000, Rounding = 0, Suffix = "ms" })
    G:AddDropdown("TargetMode", { Text = "Target", Values = { "Nearest", "Gems First", "Alien Egg", "Moon Chest" }, Default = 1 })
    G:AddToggle("TpToEgg", { Text = "Teleport to Alien Egg", Default = true })
    G:AddToggle("BreakFruits", { Text = "Break Fruits", Default = true, Tooltip = "Fruits take 1 dmg per hit, 15 hits each" })
    local eggLbl = G:AddLabel("Alien Egg: unknown", true)
    G:AddLabel("Game caps clicks at 10/s - below 100ms gives no extra speed.", true)
    local SKIP_BREAKABLES = { Apple = true, Banana = true, Blueberry = true, Kiwi = true, Mango = true, Taco = true }
    local ALIEN_NAMES = { AlienEventEgg = true, UFOEgg = true }
    local function isAlienEgg(m)
        if not (m and m:IsA("Model")) then return false end
        if ALIEN_NAMES[m.Name] then return true end
        if m:GetAttribute("MaxHP") ~= nil and m:FindFirstChildWhichIsA("ClickDetector", true) then
            return true
        end
        return false
    end
    local function eggPart(egg)
        if not (egg and egg.Parent) then return nil end
        if egg:IsA("Model") then
            return egg.PrimaryPart or egg:FindFirstChildWhichIsA("BasePart", true)
        end
        return egg:IsA("BasePart") and egg or nil
    end
    local alienRef = nil
    local eggAway, eggHome, eggPos = false, nil, nil
    local function scanEgg()
        local found = nil
        for nm in pairs(ALIEN_NAMES) do
            local m = workspace:FindFirstChild(nm, true)
            if m and eggPart(m) then found = m break end
        end
        if not found then
            local active = false
            pcall(function()
                local svc = GetSvc("AlienEventService")
                local st = svc and svc.GetState and svc.GetState()
                active = st ~= nil and st ~= "Idle"
            end)
            if active then
                local br = workspace:FindFirstChild("Breakables")
                if br then
                    for _, d in ipairs(br:GetDescendants()) do
                        if d:IsA("ClickDetector") then
                            local m = d.Parent
                            while m and not m:IsA("Model") do m = m.Parent end
                            if m and m:IsA("Model") and not SKIP_BREAKABLES[m.Name] and isAlienEgg(m) then
                                found = m break
                            end
                        end
                    end
                end
            end
        end
        alienRef = found
        if not found and eggAway then
            eggAway = false
            pcall(function()
                local char = LocalPlayer.Character
                local hrp = char and char:FindFirstChild("HumanoidRootPart")
                if hrp and eggHome and eggPos and (hrp.Position - eggPos).Magnitude < 120 then
                    hrp.CFrame = eggHome
                    hrp.Velocity = Vector3.zero
                    hrp.RotVelocity = Vector3.zero
                end
            end)
        end
        local txt = "Alien Egg: not spawned"
        if alienRef then
            local char = LocalPlayer.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            local epp = eggPart(alienRef)
            if hrp and epp then
                txt = string.format("Alien Egg: %d studs", math.floor((epp.Position - hrp.Position).Magnitude))
            else
                txt = "Alien Egg: spawned"
            end
        end
        pcall(function() eggLbl:SetText(txt) end)
    end
    pcall(function()
        local eggsFolder = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Eggs")
        for _, rn in ipairs({ "AlienEggAnnounce", "AlienEggFall", "AlienEggUI" }) do
            local r = eggsFolder:FindFirstChild(rn)
            if r then r.OnClientEvent:Connect(function() task.spawn(scanEgg) end) end
        end
    end)
    task.spawn(function()
        while not Library.Unloaded and genAlive() do
            pcall(scanEgg)
            task.wait(2)
        end
    end)
    G:AddLabel("Alien Egg and Moon Chest take priority when found; select either in Target to focus it.", true)
    local function setBuiltInAuto(on)
        local svc = GetSvc("BreakableAreaService")
        if svc and svc.SetAutoBreaking then pcall(function() svc.SetAutoBreaking:Fire(on) end) end
    end
    Toggles.AutoClickBreakables:OnChanged(function()
        local on = Toggles.AutoClickBreakables.Value
        setBuiltInAuto(on)
        if not on then return end
        task.spawn(function()
            while not Library.Unloaded and genAlive() and Toggles.AutoClickBreakables and Toggles.AutoClickBreakables.Value do
                local delayMs = Options.ClickDelay and Options.ClickDelay.Value or 150
                local mode = Options.TargetMode and Options.TargetMode.Value or "Nearest"
                pcall(function()
                    local char = LocalPlayer.Character
                    local hrp = char and char:FindFirstChild("HumanoidRootPart")
                    local folder = workspace:FindFirstChild("Breakables")
                    if not hrp then return end
                    local function eggPartLocal()
                        if not (alienRef and alienRef.Parent) then return nil end
                        return eggPart(alienRef)
                    end
                    if Toggles.TpToEgg.Value then
                        local epp = eggPartLocal()
                        if epp then
                            if not eggAway then
                                eggAway = true
                                eggHome = hrp.CFrame
                                eggPos = epp.Position
                            end
                            if (epp.Position - hrp.Position).Magnitude > 40 then
                                hrp.CFrame = epp.CFrame + Vector3.new(0, 3, 8)
                                pcall(function()
                                    hrp.Velocity = Vector3.zero
                                    hrp.RotVelocity = Vector3.zero
                                end)
                            end
                        end
                    end
                    local cands = {}
                    local seen = {}
                    local breakFruits = Toggles.BreakFruits and Toggles.BreakFruits.Value
                    local function modelForDetector(det)
                        local model = det.Parent
                        while model and not model:IsA("Model") and model ~= workspace do model = model.Parent end
                        return model and model:IsA("Model") and model or nil
                    end
                    local function isMoonChestDetector(det)
                        local hasChest, hasMoon = false, false
                        local node = det
                        while node and node ~= workspace do
                            local lowered = node.Name:lower()
                            if lowered:find("chest", 1, true) then hasChest = true end
                            if lowered:find("moon", 1, true) or lowered:find("lunar", 1, true) then hasMoon = true end
                            node = node.Parent
                        end
                        return hasChest and hasMoon
                    end
                    for _, det in ipairs(folder and folder:GetDescendants() or {}) do
                        if det:IsA("ClickDetector") then
                            local m = modelForDetector(det)
                            if m and m:IsA("Model") and m:IsDescendantOf(folder) and (not SKIP_BREAKABLES[m.Name] or breakFruits) and not seen[m] then
                                seen[m] = true
                                local pp = m.PrimaryPart or m:FindFirstChildWhichIsA("BasePart", true)
                                if pp then
                                    local kind = "normal"
                                    if m == alienRef or ALIEN_NAMES[m.Name] then
                                        kind = "alien"
                                    elseif isMoonChestDetector(det) then
                                        kind = "moonChest"
                                    elseif m.Name:match("^RTier") then
                                        kind = "gem"
                                    end
                                    table.insert(cands, { det = det, d = (pp.Position - hrp.Position).Magnitude, kind = kind })
                                end
                            end
                        end
                    end
                    if mode == "Moon Chest" then
                        for _, det in ipairs(workspace:GetDescendants()) do
                            if det:IsA("ClickDetector") and isMoonChestDetector(det) then
                                local m = modelForDetector(det)
                                local target = m or det.Parent
                                if target and not seen[target] then
                                    local pp = m and (m.PrimaryPart or m:FindFirstChildWhichIsA("BasePart", true))
                                        or (det.Parent and det.Parent:IsA("BasePart") and det.Parent)
                                    if pp then
                                        seen[target] = true
                                        table.insert(cands, { det = det, d = (pp.Position - hrp.Position).Magnitude, kind = "moonChest" })
                                    end
                                end
                            end
                        end
                    end
                    if alienRef and alienRef.Parent and (not folder or not alienRef:IsDescendantOf(folder)) then
                        local det = alienRef:IsA("Model") and alienRef:FindFirstChildWhichIsA("ClickDetector", true) or nil
                        local epp = eggPart(alienRef)
                        if det and epp and not seen[alienRef] then
                            seen[alienRef] = true
                            table.insert(cands, { det = det, d = (epp.Position - hrp.Position).Magnitude, kind = "alien" })
                        end
                    end
                    if #cands == 0 then return end
                    local pick = nil
                    do
                        local bestD = math.huge
                        for _, c in ipairs(cands) do
                            if c.kind == "alien" and c.d < bestD then pick, bestD = c, c.d end
                        end
                    end
                    if not pick and mode ~= "Alien Egg" then
                        local bestD = math.huge
                        for _, c in ipairs(cands) do
                            if c.kind == "moonChest" and c.d < bestD then pick, bestD = c, c.d end
                        end
                    end
                    if not pick and mode == "Gems First" then
                        local bestD = math.huge
                        for _, c in ipairs(cands) do
                            if c.kind == "gem" and c.d < bestD then pick, bestD = c, c.d end
                        end
                    end
                    if not pick and mode ~= "Alien Egg" and mode ~= "Moon Chest" then
                        local bestD = math.huge
                        for _, c in ipairs(cands) do
                            if c.d < bestD then pick, bestD = c, c.d end
                        end
                    end
                    if pick then pcall(fireclickdetector, pick.det) end
                end)
                task.wait(jitter(math.clamp(delayMs / 1000, 0.1, 1)))
            end
            setBuiltInAuto(false)
        end)
    end)
    local R = PlayTab:AddLeftGroupbox("Playtime Rewards")
    R:AddToggle("AutoClaimPlaytime", { Text = "Auto Claim Playtime Rewards", Default = false, Tooltip = "ClaimGift:Fire(Gift1..Gift9) every 5s" })
    R:AddLabel("Claims all 9 playtime gifts when ready.", true)
    local E = PlayTab:AddRightGroupbox("Playtime Egg")
    E:AddToggle("AutoClaimPartyEgg", { Text = "Auto Claim Playtime Egg", Default = false, Tooltip = "PartyEggService.Claim:Fire() when ready" })
    E:AddButton({ Text = "Claim Egg Now", Func = function()
        local svc = GetSvc("PartyEggService")
        if svc and svc.Claim then pcall(function() svc.Claim:Fire() end) end
    end })
    E:AddLabel("Requires playtime elapsed (PartyEggModule).", true)
    Toggles.AutoClaimPlaytime:OnChanged(function()
        if not Toggles.AutoClaimPlaytime.Value then return end
        task.spawn(function()
            phase(5)
            while not Library.Unloaded and genAlive() and Toggles.AutoClaimPlaytime and Toggles.AutoClaimPlaytime.Value do
                pcall(function()
                    local svc = GetSvc("PlaytimeGiftsService")
                    if svc and svc.ClaimGift then
                        for i = 1, 9 do
                            svc.ClaimGift:Fire("Gift" .. i)
                            task.wait(0.25)
                        end
                    end
                end)
                task.wait(jitter(5, 0.3))
            end
        end)
    end)
    Toggles.AutoClaimPartyEgg:OnChanged(function()
        if not Toggles.AutoClaimPartyEgg.Value then return end
        task.spawn(function()
            phase(5)
            while not Library.Unloaded and genAlive() and Toggles.AutoClaimPartyEgg and Toggles.AutoClaimPartyEgg.Value do
                pcall(function()
                    local ready = true
                    local ok, mod = pcall(require, ReplicatedStorage.Modules:FindFirstChild("PartyEggModule"))
                    if ok and mod and mod.IsReady then
                        ready = mod.IsReady(LocalPlayer)
                    end
                    if ready then
                        local svc = GetSvc("PartyEggService")
                        if svc and svc.Claim then svc.Claim:Fire() end
                    end
                end)
                task.wait(jitter(5, 0.3))
            end
        end)
    end)
end
do
    local HatchTab = ActivityTabs.Hatching
    local UpgTab = ActivityTabs.Upgrades
    local WorldTab = Tabs.Teleports:AddSubTab("Worlds")
    local ItemsTab = ActivityTabs.Items
    local MoonTab = ActivityTabs.MoonTree
    local EventsTab = ActivityTabs.Events
    local function craftOnce(dataFolder, need, machineName, bulkKey, singleKey)
        pcall(function()
            local PlayerData = require(ReplicatedStorage.Modules.PlayerData)
            local PetDisplay = require(ReplicatedStorage.Modules.PetDisplay)
            local svc = GetSvc("CraftMachinesService")
            if not svc then return end
            local folder = PlayerData.Folder(LocalPlayer, "PetsData")
            local sub = folder and folder:FindFirstChild(dataFolder)
            if not sub then return end
            local ready = {}
            for _, pet in ipairs(sub:GetChildren()) do
                if PetDisplay.GetAvailable(LocalPlayer, pet.Name) >= need then
                    table.insert(ready, pet.Name)
                end
            end
            if #ready == 0 then return end
            local char = LocalPlayer.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            local map = workspace:FindFirstChild("Map")
            local machines = map and map:FindFirstChild("Machines")
            local machine = machines and machines:FindFirstChild(machineName)
            local pp = machine and (machine.PrimaryPart or machine:FindFirstChildWhichIsA("BasePart", true))
            if not hrp or not pp then return end
            local back = hrp.CFrame
            local moved = (pp.Position - hrp.Position).Magnitude > 20
            if moved then
                hrp.CFrame = pp.CFrame + Vector3.new(0, 3, 6)
                pcall(function()
                    hrp.Velocity = Vector3.zero
                    hrp.RotVelocity = Vector3.zero
                end)
                task.wait(jitter(1.5))
            end
            table.clear(ready)
            for _, pet in ipairs(sub:GetChildren()) do
                if PetDisplay.GetAvailable(LocalPlayer, pet.Name) >= need then
                    table.insert(ready, pet.Name)
                end
            end
            if #ready > 0 then
                table.sort(ready)
                if svc[bulkKey] then
                    svc[bulkKey]:Fire(ready)
                elseif svc[singleKey] then
                    for _, name in ipairs(ready) do svc[singleKey]:Fire(name) end
                end
                task.wait(1.5)
            end
            if moved then
                pcall(function()
                    local c = LocalPlayer.Character
                    local h = c and c:FindFirstChild("HumanoidRootPart")
                    if h then h.CFrame = back end
                end)
            end
        end)
    end
    local function craftGoldensOnce()
        craftOnce("NormalPetsData", 8, "GoldenMachine", "CraftBulkGolden", "CraftGolden")
    end
    local function craftDiamondsOnce()
        craftOnce("GoldenPetsData", 6, "DiamondMachine", "CraftBulkDiamond", "CraftDiamond")
    end
    local RARITY_RANK = { Basic = 1, Rare = 2, Epic = 3, Legendary = 4, Mythical = 5, Secret = 6 }
    local RARITY_COLORS = { Basic = 9807270, Rare = 3447003, Epic = 10181046, Legendary = 15844367, Mythical = 15105570, Secret = 16766720 }
    local function petRarity(petName)
        local base = tostring(petName):gsub("^Golden ", ""):gsub("^Diamond ", "")
        local ok, mod = pcall(require, ReplicatedStorage.NormalEggs:FindFirstChild("EggHandlerModule"))
        if not ok or type(mod) ~= "table" then return "Basic" end
        for _, entry in pairs(mod) do
            if type(entry) == "table" then
                for _, pet in ipairs(entry) do
                    if type(pet) == "table" and pet.Name == base then
                        return pet.Rarity or "Basic"
                    end
                end
            end
        end
        return "Basic"
    end
    local function sendWebhook(url, title, desc, color)
        pcall(function()
            if type(url) ~= "string" then return end
            local okUrl = url:match("^https://discord%.com/api/webhooks/") or url:match("^https://discordapp%.com/api/webhooks/")
            if not okUrl then return end
            local req = request or (http and http.request)
            if not req then return end
            req({
                Url = url,
                Method = "POST",
                Headers = { ["Content-Type"] = "application/json" },
                Body = json.encode({
            username = "Alienite Hub",
                    embeds = { { title = title, description = desc, color = color or 15844367 } },
                }),
            })
        end)
    end
    local function snapshotPets()
        local counts = {}
        pcall(function()
            local PlayerData = require(ReplicatedStorage.Modules.PlayerData)
            local folder = PlayerData.Folder(LocalPlayer, "PetsData")
            if folder then
                for _, sub in ipairs({ "NormalPetsData", "GoldenPetsData", "DiamondPetsData" }) do
                    local d = folder:FindFirstChild(sub)
                    if d then
                        for _, p in ipairs(d:GetChildren()) do
                            local a = p:FindFirstChild("Amount")
                            if a then counts[sub .. "/" .. p.Name] = a.Value end
                        end
                    end
                end
            end
        end)
        return counts
    end
    local H = HatchTab:AddLeftGroupbox("Egg Hatching")
    H:AddDropdown("SelectedEgg", { Text = "Egg", Values = EGG_LIST, Default = 1 })
    H:AddDropdown("HatchMode", { Text = "Mode", Values = MODE_LIST, Default = 3 })
    H:AddLabel("Event eggs: Ruby Egg at Spawn, Ruby Egg 2x at Volcano, Ruby Egg 5x at The Moon (last world).", true)
    H:AddToggle("AutoHatch", { Text = "Auto Hatch Eggs", Default = false, Tooltip = "Hatch:Fire(egg, mode) every 1s. Stand near egg." })
    H:AddLabel("Stand within egg range or hatch is rejected.", true)
    H:AddToggle("AutoTpEgg", { Text = "Auto Teleport to Egg", Default = true, Tooltip = "Returns you to the selected egg on a timer" })
    H:AddSlider("TpEggInterval", { Text = "Teleport Interval", Default = 30, Min = 10, Max = 60, Rounding = 0, Suffix = "s" })
    local function teleportToSelectedEgg(manual)
        pcall(function()
            if not manual and alienRef and alienRef.Parent then return end
            local eggName = Options.SelectedEgg and Options.SelectedEgg.Value or "Basic Egg"
            local function findSelectedEgg()
                local map = workspace:FindFirstChild("Map")
                local eggs = map and map:FindFirstChild("Eggs")
                if not eggs then return nil end
                local aliases = EVENT_EGG_ALIASES[eggName] or { eggName }
                for _, name in ipairs(aliases) do
                    local found = eggs:FindFirstChild(name, true)
                    if found then return found end
                end
                local wanted = tostring(eggName):lower():gsub("[^%w]", "")
                for _, candidate in ipairs(eggs:GetDescendants()) do
                    if candidate.Name:lower():gsub("[^%w]", "") == wanted then return candidate end
                end
                return nil
            end
            local egg = findSelectedEgg()
            if not egg and EVENT_EGG_WORLDS[eggName] then
                local svc = GetSvc("TeleportService")
                if svc and svc.GoTo then
                    svc.GoTo:Fire(EVENT_EGG_WORLDS[eggName])
                    task.wait(2)
                    egg = findSelectedEgg()
                end
            end
            if not egg then return end
            local pos = nil
            if egg:IsA("Model") then pos = egg:GetPivot().Position
            elseif egg:IsA("BasePart") then pos = egg.Position end
            if not pos then return end
            local char = LocalPlayer.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            if hrp and (pos - hrp.Position).Magnitude > 10 then
                hrp.CFrame = CFrame.new(pos + Vector3.new(0, 3, 6))
                pcall(function()
                    hrp.Velocity = Vector3.zero
                    hrp.RotVelocity = Vector3.zero
                end)
            end
        end)
    end
    H:AddButton({ Text = "Teleport to Egg Now", Func = function() teleportToSelectedEgg(true) end })
    local function tpEggLoop()
        task.spawn(function()
            while not Library.Unloaded and genAlive() and Toggles.AutoTpEgg and Toggles.AutoTpEgg.Value do
                teleportToSelectedEgg()
                local iv = Options.TpEggInterval and Options.TpEggInterval.Value or 30
                task.wait(jitter(math.clamp(iv, 10, 60)))
            end
        end)
    end
    Toggles.AutoTpEgg:OnChanged(function()
        if not Toggles.AutoTpEgg.Value then return end
        tpEggLoop()
    end)
    if Toggles.AutoTpEgg.Value then tpEggLoop() end
    local P = HatchTab:AddRightGroupbox("Pets")
    P:AddToggle("AutoEquipBest", { Text = "Auto Equip Best Pets", Default = false })
    P:AddSlider("EquipInterval", { Text = "Equip Interval", Default = 10, Min = 1, Max = 60, Rounding = 0, Suffix = "s" })
    P:AddButton({ Text = "Equip Best Now", Func = function()
        local svc = GetSvc("PetsService")
        if svc and svc.Action then pcall(function() svc.Action:Fire("EquipBest") end) end
    end })
    P:AddToggle("AutoGolden", { Text = "Auto Golden Pets", Default = false, Tooltip = "Bulk-crafts golden when 8+ of same pet" })
    P:AddButton({ Text = "Craft Goldens Now", Func = function()
        craftGoldensOnce()
    end })
    P:AddLabel("Needs 8 of the same pet. Teleports you to the machine briefly.", true)
    P:AddToggle("AutoDiamond", { Text = "Auto Diamond Pets", Default = false, Tooltip = "Bulk-crafts diamond when 6+ of same golden" })
    P:AddButton({ Text = "Craft Diamonds Now", Func = function()
        craftDiamondsOnce()
    end })
    P:AddInput("WebhookURL", { Text = "Discord Webhook", Placeholder = "https://discord.com/api/webhooks/...", Finished = true })
    P:AddDropdown("MinRarity", { Text = "Min Rarity", Values = { "Basic", "Rare", "Epic", "Legendary", "Mythical", "Secret" }, Default = 4 })
    P:AddToggle("HatchWebhook", { Text = "Hatch Webhook", Default = false, Tooltip = "Posts hatches at/above min rarity" })
    P:AddButton({ Text = "Test Webhook", Func = function()
        local url = Options.WebhookURL and Options.WebhookURL.Value or ""
        if url == "" then
            Library:Notify({ Title = HUB_NAME, Description = "Paste a webhook URL first.", Time = 3, Type = "Warning" })
            return
        end
        local minR = Options.MinRarity and Options.MinRarity.Value or "Legendary"
        local egg = Options.SelectedEgg and Options.SelectedEgg.Value or "?"
        sendWebhook(url, "Alienite Hub webhook test", "Connected. Min rarity: " .. minR .. " | Egg: " .. egg, 15844367)
        Library:Notify({ Title = HUB_NAME, Description = "Webhook test sent; check Discord.", Time = 3, Type = "Info" })
    end })
    Toggles.HatchWebhook:OnChanged(function()
        if not Toggles.HatchWebhook.Value then return end
        task.spawn(function()
            local last = snapshotPets()
            task.wait(3)
            while not Library.Unloaded and genAlive() and Toggles.HatchWebhook and Toggles.HatchWebhook.Value do
                task.wait(3)
                local cur = snapshotPets()
                local url = Options.WebhookURL and Options.WebhookURL.Value or ""
                local minR = Options.MinRarity and Options.MinRarity.Value or "Legendary"
                local minRank = RARITY_RANK[minR] or 4
                if url ~= "" then
                    for key, amt in pairs(cur) do
                        local prev = last[key] or 0
                        if amt > prev then
                            local petName = tostring(key):match("/(.+)$") or key
                            local rar = petRarity(petName)
                            if (RARITY_RANK[rar] or 1) >= minRank then
                                local egg = Options.SelectedEgg and Options.SelectedEgg.Value or ""
                                sendWebhook(url, rar .. " hatched: " .. petName,
                                    "**" .. LocalPlayer.Name .. "** hatched **" .. petName .. "** (" .. rar .. ") x" .. (amt - prev)
                                        .. (egg ~= "" and "\nEgg: " .. egg or ""),
                                    RARITY_COLORS[rar])
                            end
                        end
                    end
                end
                last = cur
            end
        end)
    end)
    Toggles.AutoHatch:OnChanged(function()
        if not Toggles.AutoHatch.Value then return end
        task.spawn(function()
            phase(1)
            while not Library.Unloaded and genAlive() and Toggles.AutoHatch and Toggles.AutoHatch.Value do
                pcall(function()
                    local svc = GetSvc("EggHatchService")
                    local egg = Options.SelectedEgg and Options.SelectedEgg.Value or "Basic Egg"
                    local mode = Options.HatchMode and Options.HatchMode.Value or "Max"
                    egg = EVENT_EGG_HATCH_KEYS[egg] or egg
                    if svc and svc.Hatch then svc.Hatch:Fire(egg, mode) end
                end)
                task.wait(jitter(1.2))
            end
        end)
    end)
    Toggles.AutoEquipBest:OnChanged(function()
        if not Toggles.AutoEquipBest.Value then return end
        task.spawn(function()
            while not Library.Unloaded and genAlive() and Toggles.AutoEquipBest and Toggles.AutoEquipBest.Value do
                pcall(function()
                    local svc = GetSvc("PetsService")
                    if svc and svc.Action then svc.Action:Fire("EquipBest") end
                end)
                local iv = Options.EquipInterval and Options.EquipInterval.Value or 10
                task.wait(jitter(math.clamp(iv, 1, 60)))
            end
        end)
    end)
    Toggles.AutoGolden:OnChanged(function()
        if not Toggles.AutoGolden.Value then return end
        task.spawn(function()
            while not Library.Unloaded and genAlive() and Toggles.AutoGolden and Toggles.AutoGolden.Value do
                craftGoldensOnce()
                task.wait(jitter(5, 0.3))
            end
        end)
    end)
    Toggles.AutoDiamond:OnChanged(function()
        if not Toggles.AutoDiamond.Value then return end
        task.spawn(function()
            while not Library.Unloaded and genAlive() and Toggles.AutoDiamond and Toggles.AutoDiamond.Value do
                craftDiamondsOnce()
                task.wait(jitter(5, 0.3))
            end
        end)
    end)
    local U = UpgTab:AddLeftGroupbox("Auto Upgrade")
    U:AddToggle("UpCoins", { Text = "Coins Boost", Default = false })
    U:AddToggle("UpRubies", { Text = "Rubies Boost", Default = false })
    U:AddToggle("UpLuck", { Text = "Luck Boost", Default = false })
    local U2 = UpgTab:AddRightGroupbox("Speed & Crit")
    U2:AddToggle("UpHatch", { Text = "Hatch Speed", Default = false })
    U2:AddToggle("UpCrit", { Text = "Critical %", Default = false })
    U2:AddToggle("UpPetSpeed", { Text = "Pets Speed", Default = false })
    U2:AddLabel("Buys with Rubies via BuyUpgrade:Fire(name).", true)
    local function bindUpgrade(toggleIdx, remoteName)
        Toggles[toggleIdx]:OnChanged(function()
            if not Toggles[toggleIdx].Value then return end
            task.spawn(function()
                phase(1.5)
                while not Library.Unloaded and genAlive() and Toggles[toggleIdx] and Toggles[toggleIdx].Value do
                    pcall(function()
                        local svc = GetSvc("UpgradesService")
                        if svc and svc.BuyUpgrade then svc.BuyUpgrade:Fire(remoteName) end
                    end)
                    task.wait(jitter(1.5))
                end
            end)
        end)
    end
    bindUpgrade("UpCoins", "CoinsUpgrades")
    bindUpgrade("UpRubies", "RubiesUpgrades")
    bindUpgrade("UpLuck", "LuckUpgrades")
    bindUpgrade("UpHatch", "HatchSpeedUpgrades")
    bindUpgrade("UpCrit", "CriticalUpgrades")
    bindUpgrade("UpPetSpeed", "PetSpeedUpgrades")
    local W = WorldTab:AddLeftGroupbox("Worlds")
    W:AddToggle("AutoBuyWorlds", { Text = "Auto Buy Worlds", Default = false, Tooltip = "Purchase:Fire every 1s" })
    W:AddDropdown("TeleportWorld", { Text = "Teleport To", Values = WORLD_LIST, Default = 1 })
    W:AddButton({ Text = "Teleport", Func = function()
        local svc = GetSvc("TeleportService")
        local w = Options.TeleportWorld and Options.TeleportWorld.Value or "Spawn"
        if svc and svc.GoTo then pcall(function() svc.GoTo:Fire(w) end) end
    end })
    W:AddLabel("Order: BirchForest > TreasureDunes > FrozenAlley > HauntedHouse > PetKingdom > EnchantedGrove > VolcanoHollow > TheMoon (Rubies).", true)
    Toggles.AutoBuyWorlds:OnChanged(function()
        if not Toggles.AutoBuyWorlds.Value then return end
        task.spawn(function()
            while not Library.Unloaded and genAlive() and Toggles.AutoBuyWorlds and Toggles.AutoBuyWorlds.Value do
                pcall(function()
                    local svc = GetSvc("TeleportService")
                    if svc and svc.Purchase then
                        svc.Purchase:Fire("Bought")
                        svc.Purchase:Fire("BoughtMoon")
                    end
                end)
                task.wait(jitter(1.5))
            end
        end)
    end)

    local function useSelectedItems()
        pcall(function()
            local sel = Options.SelectedItems and Options.SelectedItems.Value
            if sel == nil then return end
            local names = {}
            if type(sel) == "table" then
                for name, on in pairs(sel) do
                    if on then table.insert(names, name) end
                end
            elseif type(sel) == "string" then
                names = { sel }
            end
            if #names == 0 then return end
            local PlayerData = require(ReplicatedStorage.Modules.PlayerData)
            local svc = GetSvc("ConsumablesService")
            if not svc or not svc.UseItem then return end
            local function owned(name)
                for _, fname in ipairs({ "FruitsData", "PotionsData", "ToysData", "MiscData" }) do
                    local f = PlayerData.Folder(LocalPlayer, fname)
                    local v = f and f:FindFirstChild(name)
                    if v and v:IsA("IntValue") then return v.Value end
                    if v and typeof(v.Value) == "number" then return v.Value end
                end
                return 1
            end
            for _, name in ipairs(names) do
                if owned(name) > 0 then
                    local amt = Options.UseAmount and Options.UseAmount.Value or 1
                    svc.UseItem:Fire(name, math.clamp(amt, 1, 10))
                    task.wait(0.7)
                end
            end
        end)
    end
    local I = ItemsTab:AddLeftGroupbox("Auto Use")
    I:AddDropdown("SelectedItems", { Text = "Items", Values = ITEM_LIST, Default = 1, Multi = true, Searchable = true, SelectAllButtons = true })
    I:AddToggle("AutoUseItems", { Text = "Auto Use Selected Items", Default = false, Tooltip = "Uses items per interval" })
    I:AddSlider("UseAmount", { Text = "Amount Per Use", Default = 1, Min = 1, Max = 10, Rounding = 0 })
    I:AddSlider("UseInterval", { Text = "Use Interval", Default = 1, Min = 1, Max = 300, Rounding = 0, Suffix = "s" })
    I:AddButton({ Text = "Use Now", Func = function() useSelectedItems() end })
    I:AddLabel("Skips items you own 0 of. Potions re-use after expiry.", true)
    Toggles.AutoUseItems:OnChanged(function()
        if not Toggles.AutoUseItems.Value then return end
        task.spawn(function()
            while not Library.Unloaded and genAlive() and Toggles.AutoUseItems and Toggles.AutoUseItems.Value do
                useSelectedItems()
                local iv = Options.UseInterval and Options.UseInterval.Value or 1
                task.wait(math.clamp(iv, 1, 300))
            end
        end)
    end)

    local function craftStationOnce()
        pcall(function()
            local cfg = require(ReplicatedStorage.Modules:FindFirstChild("ItemCraftConfig"))
            local sel = Options.CraftRecipes and Options.CraftRecipes.Value
            if sel == nil then return end
            local ids = {}
            if type(sel) == "table" then
                for id, on in pairs(sel) do
                    if on then table.insert(ids, id) end
                end
            elseif type(sel) == "string" then
                ids = { sel }
            end
            if #ids == 0 then return end
            local svc = GetSvc("ItemCraftService", { "DoCraft", "Craft" })
            if not svc or not svc.Craft then return end
            local cap = cfg.MAX_CRAFT_PER_REQUEST or 100
            for _, id in ipairs(ids) do
                local ok, n = pcall(cfg.MaxCraftable, LocalPlayer, id)
                if ok and type(n) == "number" and n > 0 then
                    svc.Craft(id, math.min(n, cap))
                end
            end
        end)
    end
    local C = ItemsTab:AddLeftGroupbox("Item Crafting")
    C:AddDropdown("CraftRecipes", { Text = "Recipes", Values = CRAFT_IDS, Default = 1, Multi = true, Searchable = true, SelectAllButtons = true })
    C:AddToggle("AutoCraftItems", { Text = "Auto Craft Items", Default = false, Tooltip = "Crafts affordable potions II + charms" })
    C:AddButton({ Text = "Craft Now", Func = function() craftStationOnce() end })
    C:AddLabel("Crafts max affordable per pass. Server validates costs.", true)
    Toggles.AutoCraftItems:OnChanged(function()
        if not Toggles.AutoCraftItems.Value then return end
        task.spawn(function()
            while not Library.Unloaded and genAlive() and Toggles.AutoCraftItems and Toggles.AutoCraftItems.Value do
                craftStationOnce()
                task.wait(jitter(5, 0.3))
            end
        end)
    end)

    local function bindMoonShop(toggleIdx, serviceName, keyList)
        Toggles[toggleIdx]:OnChanged(function()
            if not Toggles[toggleIdx].Value then return end
            task.spawn(function()
                phase(1.5)
                while not Library.Unloaded and genAlive() and Toggles[toggleIdx] and Toggles[toggleIdx].Value do
                    pcall(function()
                        local svc = GetSvc(serviceName)
                        if svc and svc.BuyUpgrade then
                            for _, key in ipairs(keyList) do
                                svc.BuyUpgrade:Fire(key)
                                task.wait(0.25)
                            end
                        end
                    end)
                    task.wait(jitter(2.5))
                end
            end)
        end)
    end
    local MM = MoonTab:AddLeftGroupbox("Moon Upgrades")
    MM:AddToggle("AutoMoonInc", { Text = "Auto Upgrade Moon Upgrades", Default = false, Tooltip = "Buys all 9 incremental moon upgrades" })
    MM:AddToggle("AutoMoonPerm", { Text = "Auto Upgrade Permanent Moon Upgrades", Default = false, Tooltip = "Buys all 8 permanent moon upgrades" })
    MM:AddLabel("Requires The Moon unlocked. Server skips what you can't afford.", true)
    bindMoonShop("AutoMoonInc", "MoonUpgradesService", MOON_INC_LIST)
    bindMoonShop("AutoMoonPerm", "MoonPermUpgradesService", MOON_PERM_LIST)

    local function buyTreePass()
        pcall(function()
            local PlayerData = require(ReplicatedStorage.Modules.PlayerData)
            local ok, mod = pcall(require, ReplicatedStorage.UpgradeTree:FindFirstChild("UpgradeTreeData"))
            if not ok or type(mod) ~= "table" then return end
            local nums = {}
            for k in pairs(mod) do
                if type(k) == "number" then table.insert(nums, k) end
            end
            table.sort(nums)
            local byId = {}
            for _, k in ipairs(nums) do
                local e = mod[k]
                if type(e) == "table" and type(e.id) == "string" then byId[e.id] = e end
            end
            local stats = PlayerData.Folder(LocalPlayer, "Stats")
            local rubies = stats and stats:FindFirstChild("Rubies")
            local bal = (rubies and rubies.Value) or 0
            local tree = PlayerData.Folder(LocalPlayer, "TreeData")
            local svc = GetSvc("UpgradeTreeService")
            if not svc or not svc.BuyNode then return end
            local bought = 0
            for _, k in ipairs(nums) do
                if bought >= 5 then break end
                local e = mod[k]
                if type(e) == "table" and type(e.id) == "string" and e.id ~= "start" then
                    local owned = tree and tree:FindFirstChild(e.id)
                    if not (owned and owned.Value) then
                        local parentOk = not e.parent or (tree and tree:FindFirstChild(e.parent) and tree:FindFirstChild(e.parent).Value)
                        local cost = tonumber(e.cost) or 0
                        if parentOk and cost <= bal then
                            svc.BuyNode:Fire(e.id)
                            bought = bought + 1
                            bal = bal - cost
                        end
                    end
                end
            end
        end)
    end
    local ST = MoonTab:AddRightGroupbox("Skill Tree")
    ST:AddToggle("AutoSkillTree", { Text = "Auto Upgrade Skill Tree", Default = false, Tooltip = "Buys affordable nodes, parents first" })
    ST:AddButton({ Text = "Buy Affordable Nodes", Func = function() buyTreePass() end })
    ST:AddLabel("Spends Rubies, max 5 nodes per pass.", true)
    Toggles.AutoSkillTree:OnChanged(function()
        if not Toggles.AutoSkillTree.Value then return end
        task.spawn(function()
            while not Library.Unloaded and genAlive() and Toggles.AutoSkillTree and Toggles.AutoSkillTree.Value do
                buyTreePass()
                task.wait(jitter(3, 0.3))
            end
        end)
    end)

    local function openBlocksOnce()
        pcall(function()
            local PlayerData = require(ReplicatedStorage.Modules.PlayerData)
            local sel = Options.LuckyBlocks and Options.LuckyBlocks.Value
            if sel == nil then return end
            local names = {}
            if type(sel) == "table" then
                for name, on in pairs(sel) do
                    if on then table.insert(names, name) end
                end
            elseif type(sel) == "string" then
                names = { sel }
            end
            if #names == 0 then return end
            local svc = GetSvc("LuckyBlockService", { "Open" })
            if not svc or not svc.Open then return end
            local m = PlayerData.Folder(LocalPlayer, "MiscData")
            local perCall = Options.BlockAmount and Options.BlockAmount.Value or "8"
            local want = tonumber(perCall) or 8
            for _, name in ipairs(names) do
                local v = m and m:FindFirstChild(name)
                local owned = (v and v.Value) or 0
                if owned > 0 then
                    svc.Open:Fire(name, math.min(owned, want, 8))
                end
            end
        end)
    end
    local EV = EventsTab:AddLeftGroupbox("Lucky Blocks")
    EV:AddDropdown("LuckyBlocks", { Text = "Blocks", Values = LUCKYBLOCK_LIST, Default = 1 })
    EV:AddDropdown("BlockAmount", { Text = "Open Per Pass", Values = { "1", "3", "8" }, Default = 3 })
    EV:AddToggle("AutoOpenBlocks", { Text = "Auto Open Lucky Blocks", Default = false, Tooltip = "Opens Hacker + normal blocks" })
    EV:AddButton({ Text = "Open Now", Func = function() openBlocksOnce() end })
    EV:AddLabel("Hacker mutation comes from Hacker blocks/event hatches.", true)
    Toggles.AutoOpenBlocks:OnChanged(function()
        if not Toggles.AutoOpenBlocks.Value then return end
        task.spawn(function()
            while not Library.Unloaded and genAlive() and Toggles.AutoOpenBlocks and Toggles.AutoOpenBlocks.Value do
                openBlocksOnce()
                task.wait(jitter(5, 0.3))
            end
        end)
    end)
end
do
    local function doMoonRebirth()
        pcall(function()
            local cfg = require(ReplicatedStorage.Modules:WaitForChild("MoonUpgradesConfig"))
            local _, _, _, ready = cfg.GetRebirthProgress(LocalPlayer)
            if not ready then return end
            if cfg.HasRebirthsLeft and not cfg.HasRebirthsLeft(LocalPlayer) then return end
            local svc = GetSvc("MoonRebirthService")
            if svc and svc.DoRebirth then svc.DoRebirth:Fire() end
        end)
    end
    local RebirthTab = ActivityTabs.Rebirth
    local RB = RebirthTab:AddLeftGroupbox("Moon Rebirth")
    RB:AddToggle("AutoMoonRebirth", { Text = "Auto Moon Rebirth", Default = false, Tooltip = "Rebirths when all moon upgrades are maxed" })
    RB:AddButton({ Text = "Rebirth Now", Func = function() doMoonRebirth() end })
    RB:AddLabel("Requires all incremental moon upgrades maxed and rebirths left.", true)
    Toggles.AutoMoonRebirth:OnChanged(function()
        if not Toggles.AutoMoonRebirth.Value then return end
        task.spawn(function()
            while not Library.Unloaded and genAlive() and Toggles.AutoMoonRebirth and Toggles.AutoMoonRebirth.Value do
                doMoonRebirth()
                task.wait(jitter(5, 0.3))
            end
        end)
    end)
end
do
    local M = ToolTabs.Settings:AddLeftGroupbox("Menu")
    M:AddToggle("AntiAFK", { Text = "Anti-AFK", Default = true })
    M:AddLabel("Menu bind"):AddKeyPicker("MenuKeybind", { Default = "RightShift", NoUI = true, Text = "Menu keybind" })
    M:AddDropdown("DPIScale", { Text = "DPI Scale", Values = { "50%", "75%", "100%", "125%", "150%", "175%", "200%" }, Default = "100%", Callback = function(v) pcall(function() Library:SetDPIScale(tonumber((v:gsub("%%", "")))) end) end })
    M:AddSlider("CornerRadius", { Text = "Corner Radius", Default = 10, Min = 0, Max = 20, Rounding = 0, Callback = function(v) pcall(function() Window:SetCornerRadius(v) end) end })
    M:AddToggle("NoRender", { Text = "Disable 3D Rendering", Default = false, Tooltip = "Black screen except UI. Biggest FPS save." })
    M:AddLabel("Screen goes white except UI while enabled.", true)
    Toggles.NoRender:OnChanged(function()
        pcall(function()
            game:GetService("RunService"):Set3dRenderingEnabled(not Toggles.NoRender.Value)
        end)
    end)
    local lowGfxConn = nil
    local function setLowGfx(on)
        if lowGfxConn then pcall(function() lowGfxConn:Disconnect() end) lowGfxConn = nil end
        if not on then
            pcall(function() settings().Rendering.QualityLevel = Enum.QualityLevel.Automatic end)
            return
        end
        pcall(function()
            local RunService = game:GetService("RunService")
            local Lighting = game:GetService("Lighting")
            local Terrain = workspace:FindFirstChildWhichIsA("Terrain")
            if Terrain then
                Terrain.WaterWaveSize = 0
                Terrain.WaterWaveSpeed = 0
                Terrain.WaterReflectance = 0
                Terrain.WaterTransparency = 1
            end
            Lighting.GlobalShadows = false
            Lighting.FogEnd = 9e9
            Lighting.FogStart = 9e9
            settings().Rendering.QualityLevel = 1
            for _, v in pairs(game:GetDescendants()) do
                if v:IsA("BasePart") then
                    v.CastShadow = false
                    v.Material = "Plastic"
                    v.Reflectance = 0
                elseif v:IsA("Decal") then
                    v.Transparency = 1
                    v.Texture = ""
                elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
                    v.Lifetime = NumberRange.new(0)
                end
            end
            for _, v in pairs(Lighting:GetDescendants()) do
                if v:IsA("PostEffect") then v.Enabled = false end
            end
            lowGfxConn = workspace.DescendantAdded:Connect(function(child)
                task.spawn(function()
                    if child:IsA("ForceField") or child:IsA("Sparkles") or child:IsA("Smoke") or child:IsA("Fire") or child:IsA("Beam") then
                        RunService.Heartbeat:Wait()
                        child:Destroy()
                    elseif child:IsA("BasePart") then
                        child.CastShadow = false
                    end
                end)
            end)
        end)
    end
    M:AddToggle("LowGfx", { Text = "Low Graphics Mode", Default = false, Tooltip = "IY-style antilag. Rejoin fully restores visuals." })
    Toggles.LowGfx:OnChanged(function() setLowGfx(Toggles.LowGfx.Value) end)
    Library:OnUnload(function()
        getgenv().AlienitePetsLoaded = false
        pcall(function() game:GetService("RunService"):Set3dRenderingEnabled(true) end)
        if lowGfxConn then pcall(function() lowGfxConn:Disconnect() end) end
    end)
    local MiscActions = ToolTabs.Utilities:AddLeftGroupbox("Session")
    MiscActions:AddLabel("Close or unload the interface safely.", true)
    MiscActions:AddButton("Unload Alienite Hub", function() Library:Unload() end)
    Library.ToggleKeybind = Options.MenuKeybind
    local afkConn = nil
    local afkGen = 0
    local function KeepAlive()
        pcall(function()
            VirtualUser:CaptureController()
            VirtualUser:ClickButton2(Vector2.new())
        end)
        pcall(function()
            local svc = GetSvc("AutoRejoinService")
            if svc and svc.ReportActivity then svc.ReportActivity:Fire() end
        end)
    end
    local function setAFK(on)
        afkGen = afkGen + 1
        local gen = afkGen
        if afkConn then pcall(function() afkConn:Disconnect() end) afkConn = nil end
        if on then
            afkConn = LocalPlayer.Idled:Connect(function() KeepAlive() end)
            task.spawn(function()
                while not Library.Unloaded and genAlive() and gen == afkGen do
                    KeepAlive()
                    task.wait(20)
                end
            end)
        end
    end
    setAFK(true)
    Toggles.AntiAFK:OnChanged(function() setAFK(Toggles.AntiAFK.Value) end)
    ThemeManager:SetLibrary(Library)
    SaveManager:SetLibrary(Library)
    SaveManager:IgnoreThemeSettings()
    SaveManager:SetIgnoreIndexes({ "MenuKeybind" })
    ThemeManager:SetFolder("AlieniteHub")
    SaveManager:SetFolder("AlieniteHub/PetsUniverse")
    SaveManager:BuildConfigSection(ToolTabs.Settings)
    ThemeManager:ApplyToTab(ToolTabs.Settings)
    SaveManager:LoadAutoloadConfig()
end
Library:Notify({ Title = HUB_NAME, Description = "Pets Universe features loaded.", Time = 4, Type = "Success" })
if not genAlive() then
    pcall(function() Library:Unload() end)
    return
end
getgenv().AlienitePetsLib = Library
