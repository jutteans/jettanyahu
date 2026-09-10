local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local UserInputService = game:GetService("UserInputService")
local SoundService = game:GetService("SoundService")
local HttpService = game:GetService("HttpService")

local LocalPlayer = Players.LocalPlayer

-- Check R15
local function checkR15()
    local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local hum = char:WaitForChild("Humanoid")
    if hum.RigType ~= Enum.HumanoidRigType.R15 then
        pcall(function()
            LocalPlayer:Kick("This script only supports R15! Please switch to an R15 avatar.")
        end)
    end
end
checkR15()

-- ===============================
-- CONFIG FILE SYSTEM
-- ===============================
local CONFIG_FILE = "PhanhUIHub_SavedState.json"
local savedStates = {}

local function loadConfig()
    if readfile and isfile and isfile(CONFIG_FILE) then
        local success, result = pcall(function()
            return HttpService:JSONDecode(readfile(CONFIG_FILE))
        end)
        if success and type(result) == "table" then
            savedStates = result
        end
    end
end

local function saveConfig()
    if writefile then
        pcall(function()
            writefile(CONFIG_FILE, HttpService:JSONEncode(savedStates))
        end)
    end
end

loadConfig()

-- ===============================
-- CLICK SOUND SYSTEM
-- ===============================
local clickSound = Instance.new("Sound")
clickSound.Name = "ButtonClickSound"
clickSound.SoundId = "rbxassetid://115870885435280"
clickSound.Volume = 1
clickSound.Parent = SoundService

local function playClickSound()
    if clickSound.IsPlaying then
        clickSound:Stop()
    end
    clickSound:Play()
end

-- ===============================
-- CLEAR OLD GUI
-- ===============================
pcall(function()
    if CoreGui:FindFirstChild("PhanhUIHub") then
        CoreGui.PhanhUIHub:Destroy()
    end
    if LocalPlayer.PlayerGui:FindFirstChild("PhanhUIHub") then
        LocalPlayer.PlayerGui.PhanhUIHub:Destroy()
    end
end)

-- ===============================
-- CREATE UI SCREEN GUI
-- ===============================
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "PhanhUIHub"
screenGui.ResetOnSpawn = false
pcall(function() screenGui.Parent = CoreGui end)
if not screenGui.Parent then screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui") end

-- Font FredokaOne
local FontB = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Bold)

-- ===============================
-- FLOATING MENU ICON
-- ===============================
local iconBtn = Instance.new("TextButton")
iconBtn.Name = "OpenButton"
iconBtn.Size = UDim2.new(0, 42, 0, 42)
iconBtn.Position = UDim2.new(0.02, 0, 0.12, 0)
iconBtn.BackgroundColor3 = Color3.fromRGB(255, 192, 203)
iconBtn.BorderSizePixel = 0
iconBtn.Text = "☁"
iconBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
iconBtn.TextSize = 22
iconBtn.Font = Enum.Font.SourceSansBold
iconBtn.Active = true
iconBtn.Draggable = true
iconBtn.ZIndex = 100
iconBtn.Parent = screenGui

Instance.new("UICorner", iconBtn).CornerRadius = UDim.new(0, 10)
local ButtonStroke = Instance.new("UIStroke", iconBtn)
ButtonStroke.Color = Color3.fromRGB(255, 105, 180)
ButtonStroke.Thickness = 1.5

-- ===============================
-- MAIN HUB FRAME
-- ===============================
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 520, 0, 380)
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(255, 246, 249)
mainFrame.BackgroundTransparency = 0.05
mainFrame.BorderSizePixel = 0
mainFrame.Visible = false
mainFrame.Active = true
mainFrame.ClipsDescendants = false
mainFrame.Parent = screenGui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 12)
mainCorner.Parent = mainFrame

local chocolateStroke = Instance.new("UIStroke")
chocolateStroke.Color = Color3.fromRGB(92, 51, 23)
chocolateStroke.Thickness = 2.5
chocolateStroke.Parent = mainFrame

local topCornerDeco = Instance.new("ImageLabel")
topCornerDeco.Name = "TopRightSticker"
topCornerDeco.Size = UDim2.new(0, 75, 0, 75)
topCornerDeco.Position = UDim2.new(1, -75, 0, 0)
topCornerDeco.BackgroundTransparency = 1
topCornerDeco.Image = "rbxassetid://130820173728340" -- Cinnamoroll
topCornerDeco.ScaleType = Enum.ScaleType.Fit
topCornerDeco.ImageTransparency = 0.25
topCornerDeco.ZIndex = 1
topCornerDeco.Parent = mainFrame

local bottomCornerDeco = Instance.new("ImageLabel")
bottomCornerDeco.Name = "BottomRightSticker"
bottomCornerDeco.Size = UDim2.new(0, 75, 0, 75)
bottomCornerDeco.Position = UDim2.new(1, -55, 1, -55)
bottomCornerDeco.BackgroundTransparency = 1
bottomCornerDeco.Image = "rbxassetid://123066282804999" -- Mocha
bottomCornerDeco.ScaleType = Enum.ScaleType.Fit
bottomCornerDeco.ZIndex = 20
bottomCornerDeco.Parent = mainFrame

local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 45)
titleBar.BackgroundTransparency = 1
titleBar.Active = true
titleBar.ZIndex = 5
titleBar.Parent = mainFrame

local titleText = Instance.new("TextLabel")
titleText.Size = UDim2.new(1, -140, 1, 0)
titleText.Position = UDim2.new(0, 15, 0, 0)
titleText.BackgroundTransparency = 1
titleText.Text = "PHANH STAR CORE 🌟"
titleText.TextColor3 = Color3.fromRGB(255, 20, 147)
titleText.FontFace = FontB
titleText.TextSize = 13
titleText.TextXAlignment = Enum.TextXAlignment.Left
titleText.ZIndex = 6
titleText.Parent = titleBar

local fpsLabel = Instance.new("TextLabel")
fpsLabel.Size = UDim2.new(0, 60, 1, 0)
fpsLabel.Position = UDim2.new(1, -100, 0, 0)
fpsLabel.BackgroundTransparency = 1
fpsLabel.Text = "FPS: --"
fpsLabel.TextColor3 = Color3.fromRGB(255, 105, 180)
fpsLabel.FontFace = FontB
fpsLabel.TextSize = 12
fpsLabel.ZIndex = 6
fpsLabel.Parent = titleBar

local frameCount = 0
local lastCheck = tick()
RunService.RenderStepped:Connect(function()
    frameCount = frameCount + 1
    local currentTime = tick()
    if currentTime - lastCheck >= 1 then
        fpsLabel.Text = "FPS: " .. tostring(frameCount)
        frameCount = 0
        lastCheck = currentTime
    end
end)

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -38, 0, 7)
closeBtn.BackgroundColor3 = Color3.fromRGB(255, 240, 245)
closeBtn.BackgroundTransparency = 0
closeBtn.TextColor3 = Color3.fromRGB(255, 20, 147)
closeBtn.Text = "—"
closeBtn.FontFace = FontB
closeBtn.TextSize = 16
closeBtn.ZIndex = 10
closeBtn.Parent = titleBar
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 8)

local isOpen = false
iconBtn.MouseButton1Click:Connect(function()
    playClickSound()
    isOpen = not isOpen
    if isOpen then
        mainFrame.Visible = true
        mainFrame.Size = UDim2.new(0, 0, 0, 0)
        local tween = TweenService:Create(mainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 520, 0, 380)
        })
        tween:Play()
    else
        local tween = TweenService:Create(mainFrame, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            Size = UDim2.new(0, 0, 0, 0)
        })
        tween:Play()
        tween.Completed:Connect(function()
            if not isOpen then 
                mainFrame.Visible = false 
            end
        end)
    end
end)

closeBtn.MouseButton1Click:Connect(function()
    playClickSound()
    isOpen = false
    local tween = TweenService:Create(mainFrame, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        Size = UDim2.new(0, 0, 0, 0)
    })
    tween:Play()
    tween.Completed:Connect(function()
        mainFrame.Visible = false
    end)
end)

-- ===============================
-- SIDEBAR & CONTENT AREA
-- ===============================
local sidebarFrameBg = Instance.new("Frame")
sidebarFrameBg.Size = UDim2.new(0, 135, 1, -55)
sidebarFrameBg.Position = UDim2.new(0, 10, 0, 45)
sidebarFrameBg.BackgroundColor3 = Color3.fromRGB(255, 238, 243)
sidebarFrameBg.BackgroundTransparency = 0.3
sidebarFrameBg.Parent = mainFrame
Instance.new("UICorner", sidebarFrameBg).CornerRadius = UDim.new(0, 8)

local sidebarStroke = Instance.new("UIStroke")
sidebarStroke.Color = Color3.fromRGB(92, 51, 23)
sidebarStroke.Thickness = 1.5
sidebarStroke.Parent = sidebarFrameBg

local sidebar = Instance.new("ScrollingFrame")
sidebar.Size = UDim2.new(1, 0, 1, 0)
sidebar.BackgroundTransparency = 1
sidebar.BorderSizePixel = 0
sidebar.CanvasSize = UDim2.new(0, 0, 0, 0)
sidebar.ScrollBarThickness = 0
sidebar.Parent = sidebarFrameBg

local contentAreaBg = Instance.new("Frame")
contentAreaBg.Size = UDim2.new(1, -155, 1, -55)
contentAreaBg.Position = UDim2.new(0, 150, 0, 45)
contentAreaBg.BackgroundColor3 = Color3.fromRGB(255, 242, 247)
contentAreaBg.BackgroundTransparency = 0.3
contentAreaBg.Parent = mainFrame
Instance.new("UICorner", contentAreaBg).CornerRadius = UDim.new(0, 8)

local contentStroke = Instance.new("UIStroke")
contentStroke.Color = Color3.fromRGB(92, 51, 23)
contentStroke.Thickness = 1.5
contentStroke.Parent = contentAreaBg

local contentArea = Instance.new("Frame")
contentArea.Size = UDim2.new(1, -10, 1, -10)
contentArea.Position = UDim2.new(0, 5, 0, 5)
contentArea.BackgroundTransparency = 1
contentArea.Parent = contentAreaBg

local tabs = {}
local tabNames = {"SpeedGlitch", "Animations", "Custom Animations", "Quality & Audio", "The Mist", "Skybox", "Cursor", "Utilities", "About"}

for i, name in ipairs(tabNames) do
    local tabContent = Instance.new("ScrollingFrame")
    tabContent.Name = name .. "Tab"
    tabContent.Size = UDim2.new(1, 0, 1, 0)
    tabContent.BackgroundTransparency = 1
    tabContent.ScrollBarThickness = 4
    tabContent.CanvasSize = UDim2.new(0, 0, 0, 0)
    tabContent.Visible = (i == 1)
    tabContent.Parent = contentArea
    
    local layout = Instance.new("UIListLayout")
    layout.Parent = tabContent
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0, 8)
    
    layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        tabContent.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 10)
    end)
    
    tabs[name] = tabContent
end

for i, name in ipairs(tabNames) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -10, 0, 32)
    btn.Position = UDim2.new(0, 5, 0, (i - 1) * 36 + 5)
    btn.BackgroundColor3 = Color3.fromRGB(250, 220, 235)
    btn.BackgroundTransparency = 0.4
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(219, 112, 147)
    btn.FontFace = FontB
    btn.TextSize = 10
    btn.Parent = sidebar
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    btn.MouseButton1Click:Connect(function()
        playClickSound()
        for tabName, content in pairs(tabs) do
            content.Visible = (tabName == name)
        end
    end)
end

-- ===============================
-- CUSTOM ANIMATIONS TAB
-- ===============================
local customAnimsTab = tabs["Custom Animations"]
if customAnimsTab then
    local searchBox = Instance.new("TextBox")
    searchBox.Size = UDim2.new(1, -5, 0, 32)
    searchBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    searchBox.BackgroundTransparency = 0.2
    searchBox.PlaceholderText = "Search custom animations..."
    searchBox.Text = ""
    searchBox.TextColor3 = Color3.fromRGB(120, 20, 60)
    searchBox.PlaceholderColor3 = Color3.fromRGB(200, 150, 170)
    searchBox.FontFace = FontB
    searchBox.TextSize = 11
    searchBox.Parent = customAnimsTab
    Instance.new("UICorner", searchBox).CornerRadius = UDim.new(0, 8)

    local DefaultOriginalIDs = {}

    OriginalAnimations = {
        Idle = {
            ["Robot Animation"] = {"616088211", "616089559"},
            ["Adidas Community Animation"] = {"122257458498464", "102357151005774"},
            ["Catwalk Glam Animation"] = {"133806214992291", "94970088341563"},
            ["Knight Animation"] = {"657595757", "657568135"},
            ["Pirate Animation"] = {"750781874", "750782770"},
            ["Astronaut Animation"] = {"891621366", "891633237"},
            ["Cartoony Animation"] = {"742637544", "742638445"},
            ["Wicked (Popular) Animation"] = {"118832222982049", "76049494037641"},
            ["Mage Animation"] = {"707742142", "707855907"},
            ["Unboxed By Amazon Animation"] = {"98281136301627", "138183121662404"},
            ["R15 Reanimated Animation"] = {"4211217646", "4211218409"},
            ["2016 Animation Animation"] = {"387947158", "387947464"},
            ["Werewolf Animation"] = {"1083195517", "1083214717"},
            ["NFL Animation"] = {"92080889861410", "74451233229259"},
            ["Elder Animation"] = {"10921101664", "10921102574"},
            ["Bubbly Animation"] = {"910004836", "910009958"},
            ["Levitation Animation"] = {"616006778", "616008087"},
            ["Vampire Animation"] = {"1083445855", "1083450166"},
            ["Bold Animation"] = {"16738333868", "16738334710"},
            ["Zombie Animation"] = {"616158929", "616160636"},
            ["Ninja Animation"] = {"656117400", "656118341"},
            ["Wicked \"Dancing Through Life\" Animation"] = {"92849173543269", "132238900951109"},
            ["No Boundaries Animation"] = {"18747067405", "18747063918"},
            ["Realistic Animation"] = {"17172918855", "17173014241"},
            ["Glow Motion Animation"] = {"137764781910579", "96439737641086"},
            ["Rthro Animation"] = {"10921259953", "10921258489"},
            ["OldSchool Animation"] = {"10921230744", "10921232093"},
            ["Stylish Animation"] = {"616136790", "616138447"},
            ["Superhero Animation"] = {"10921288909", "10921290167"},
            ["Adidas Sports Animation"] = {"18537376492", "18537371272"},
            ["Toy Animation"] = {"782841498", "782845736"},
            ["Default Retarget Animation"] = {"95884606664820", "95884606664820"},
        },
        Walk = {
            ["Adidas Community Animation"] = "122150855457006",
            ["Levitation Animation"] = "616013216",
            ["Catwalk Glam Animation"] = "109168724482748",
            ["Knight Animation"] = "10921127095",
            ["Pirate Animation"] = "750785693",
            ["Bold Animation"] = "16738340646",
            ["Sports (Adidas) Animation"] = "18537392113",
            ["Zombie Animation"] = "616168032",
            ["Astronaut Animation"] = "891667138",
            ["Cartoony Animation"] = "742640026",
            ["Ninja Animation"] = "656121766",
            ["Wicked \"Dancing Through Life\" Animation"] = "73718308412641",
            ["Unboxed By Amazon Animation"] = "90478085024465",
            ["Glow Motion Animation"] = "85809016093530",
            ["Default Retarget Animation"] = "115825677624788",
            ["R15 Reanimated Animation"] = "4211223236",
            ["Toy Animation"] = "782843345",
            ["Rthro Animation"] = "10921269718",
            ["2016 Animation Animation"] = "387947975",
            ["No Boundaries Animation"] = "18747074203",
            ["Wicked Popular Animation"] = "92072849924640",
            ["Werewolf Animation"] = "1083178339",
            ["Superhero Animation"] = "10921298616",
            ["Stylish Animation"] = "616146177",
            ["Robot Animation"] = "616095330",
            ["NFL Animation"] = "110358958299415",
            ["OldSchool Animation"] = "10921244891",
            ["Elder Animation"] = "10921111375",
            ["Bubbly Animation"] = "910034870",
            ["Mage Animation"] = "707897309",
            ["Vampire Animation"] = "1083473930",
        },
        Run = {
            ["Robot Animation"] = "10921250460",
            ["Catwalk Glam Animation"] = "81024476153754",
            ["Adidas Community Animation"] = "82598234841035",
            ["Runaway Animation"] = "78510387198062",
            ["Knight Animation"] = "10921121197",
            ["Pirate Animation"] = "750783738",
            ["Bold Animation"] = "16738337225",
            ["Adidas Sports Animation"] = "18537384940",
            ["Zombie Animation"] = "616163682",
            ["Toy Animation"] = "10921306285",
            ["Cartoony Animation"] = "10921076136",
            ["Ninja Animation"] = "656118852",
            ["Wicked \"Dancing Through Life\" Animation"] = "135515454877967",
            ["Superhero Animation"] = "10921291831",
            ["Unboxed By Amazon Animation"] = "134824450619865",
            ["Glow Motion Animation"] = "101925097435036",
            ["Bubbly Animation"] = "10921057244",
            ["R15 Reanimated Animation"] = "4211220381",
            ["Rthro Animation"] = "10921261968",
            ["2016 Animation Animation"] = "387947975",
            ["No Boundaries Animation"] = "18747070484",
            ["Werewolf Animation"] = "10921336997",
            ["Stylish Animation"] = "10921276116",
            ["Levitation Animation"] = "616010382",
            ["Vampire Animation"] = "10921320299",
            ["NFL Animation"] = "117333533048078",
            ["OldSchool Animation"] = "10921240218",
            ["Mage Animation"] = "10921148209",
            ["Elder Animation"] = "10921104374",
            ["Wicked Popular Animation"] = "72301599441680",
            ["Astronaut Animation"] = "10921039308",
            ["Default Retarget Animation"] = "102294264237491",
        },
        Jump = {
            ["Robot Animation"] = "616090535",
            ["Adidas Community Animation"] = "75290611992385",
            ["Levitation Animation"] = "616008936",
            ["Catwalk Glam Animation"] = "116936326516985",
            ["Knight Animation"] = "910016857",
            ["Pirate Animation"] = "750782230",
            ["Bold Animation"] = "16738336650",
            ["Sports (Adidas) Animation"] = "18537380791",
            ["Zombie Animation"] = "616161997",
            ["Astronaut Animation"] = "891627522",
            ["Cartoony Animation"] = "742637942",
            ["Ninja Animation"] = "656117878",
            ["Wicked \"Dancing Through Life\" Animation"] = "78508480717326",
            ["Unboxed By Amazon Animation"] = "121454505477205",
            ["Glow Motion Animation"] = "74159004634379",
            ["R15 Reanimated Animation"] = "4211219390",
            ["Rthro Animation"] = "10921263860",
            ["No Boundaries Animation"] = "18747069148",
            ["Werewolf Animation"] = "1083218792",
            ["Toy Animation"] = "10921308158",
            ["Wicked Popular Animation"] = "104325245285198",
            ["Vampire Animation"] = "1083455352",
            ["Bubbly Animation"] = "910016857",
            ["NFL Animation"] = "119846112151352",
            ["OldSchool Animation"] = "10921242013",
            ["Stylish Animation"] = "616139451",
            ["Elder Animation"] = "10921107367",
            ["Superhero Animation"] = "10921294559",
            ["Mage Animation"] = "10921149743",
            ["Default Retarget Animation"] = "117150377950987",
        },
        Fall = {
            ["Robot Animation"] = "616087089",
            ["Adidas Community Animation"] = "98600215928904",
            ["Levitation Animation"] = "616005863",
            ["Catwalk Glam Animation"] = "92294537340807",
            ["Knight Animation"] = "10921122579",
            ["Pirate Animation"] = "750780242",
            ["Bold Animation"] = "16738333171",
            ["Adidas Sports Animation"] = "18537367238",
            ["Zombie Animation"] = "616157476",
            ["Astronaut Animation"] = "891617961",
            ["Cartoony Animation"] = "742637151",
            ["Ninja Animation"] = "656115606",
            ["Wicked \"Dancing Through Life\" Animation"] = "78147885297412",
            ["Unboxed By Amazon Animation"] = "94788218468396",
            ["Glow Motion Animation"] = "98070939608691",
            ["R15 Reanimated Animation"] = "4211216152",
            ["Rthro Animation"] = "10921262864",
            ["No Boundaries Animation"] = "18747062535",
            ["Werewolf Animation"] = "1083189019",
            ["Mage Animation"] = "707829716",
            ["Toy Animation"] = "782846423",
            ["Superhero Animation"] = "10921293373",
            ["Vampire Animation"] = "1083443587",
            ["NFL Animation"] = "129773241321032",
            ["OldSchool Animation"] = "10921241244",
            ["Elder Animation"] = "10921105765",
            ["Bubbly Animation"] = "910001910",
            ["Stylish Animation"] = "616134815",
            ["Wicked Popular Animation"] = "121152442762481",
            ["Default Retarget Animation"] = "110205622518029",
        },
        Climb = {
            ["Robot Animation"] = "616086039",
            ["Adidas Community Animation"] = "88763136693023",
            ["Levitation Animation"] = "10921132092",
            ["Catwalk Glam Animation"] = "119377220967554",
            ["Knight Animation"] = "10921125160",
            ["Bold Animation"] = "16738332169",
            ["Adidas Sports Animation"] = "18537363391",
            ["Zombie Animation"] = "616156119",
            ["Astronaut Animation"] = "10921032124",
            ["Cartoony Animation"] = "742636889",
            ["Ninja Animation"] = "656114359",
            ["Wicked \"Dancing Through Life\" Animation"] = "129447497744818",
            ["Unboxed By Amazon Animation"] = "121145883950231",
            ["Glow Motion Animation"] = "108236155509584",
            ["Rthro Animation"] = "10921257536",
            ["No Boundaries Animation"] = "18747060903",
            ["Mage Animation"] = "707826056",
            ["Vampire Animation"] = "1083439238",
            ["Toy Animation"] = "10921300839",
            ["NFL Animation"] = "134630013742019",
            ["OldSchool Animation"] = "10921229866",
            ["WereWolf Animation"] = "10921329322",
            ["Elder Animation"] = "845392038",
            ["SuperHero Animation"] = "10921286911",
            ["Stylish Animation"] = "10921271391",
            ["Reanimated R15 Animation"] = "4211214992",
            ["Wicked Popular Animation"] = "131326830509784",
        },
        SwimIdle = {
            ["SuperHero Animation"] = "10921297391",
            ["Adidas Community Animation"] = "109346520324160",
            ["Levitation Animation"] = "10921139478",
            ["Catwalk Glam Animation"] = "98854111361360",
            ["Knight Animation"] = "10921125935",
            ["Pirate Animation"] = "750785176",
            ["Bold Animation"] = "16738339817",
            ["Adidas Sports Animation"] = "18537387180",
            ["Astronaut Animation"] = "891663592",
            ["Cartoony Animation"] = "10921079380",
            ["Wicked Popular Animation"] = "113199415118199",
            ["Mage Animation"] = "707894699",
            ["Wicked \"Dancing Through Life\" Animation"] = "129183123083281",
            ["Unboxed By Amazon Animation"] = "129126268464847",
            ["Glow Motion Animation"] = "112946194103503",
            ["Rthro Animation"] = "10921265698",
            ["No Boundaries Animation"] = "18747073181",
            ["Werewolf Animation"] = "10921340419",
            ["NFL Animation"] = "132697394189921",
            ["OldSchool Animation"] = "10921243048",
            ["Stylish Animation"] = "10921281000",
            ["Elder Animation"] = "10921108971",
            ["Bubbly Animation"] = "910028158",
            ["Toy Animation"] = "10921309319",
            ["Ninja Animation"] = "656118341",
            ["Vampire Animation"] = "10921324408",
            ["Robot Animation"] = "10921253142",
        },
    }

    local createdButtons = {}
    local categoryActiveButtons = {}

    local function cacheOriginalIDs()
        pcall(function()
            local char = LocalPlayer.Character
            if not char then return end
            local animateScript = char:FindFirstChild("Animate")
            if not animateScript then return end
            
            for _, catName in ipairs({"Idle", "Walk", "Run", "Jump", "Fall", "Climb", "SwimIdle", "Swim"}) do
                local searchKey = string.lower(catName)
                if searchKey == "swimidle" then searchKey = "swim" end
                local catFolder = animateScript:FindFirstChild(searchKey)
                if catFolder and not DefaultOriginalIDs[catName] then
                    if catName == "Idle" then
                        local anim1 = catFolder:FindFirstChild("Animation1")
                        local anim2 = catFolder:FindFirstChild("Animation2")
                        DefaultOriginalIDs[catName] = {
                            anim1 and anim1.AnimationId or "",
                            anim2 and anim2.AnimationId or ""
                        }
                    else
                        local ids = {}
                        for _, child in ipairs(catFolder:GetChildren()) do
                            if child:IsA("Animation") then
                                table.insert(ids, child.AnimationId)
                            end
                        end
                        DefaultOriginalIDs[catName] = ids
                    end
                end
            end
        end)
    end

    local function applyAnimationToChar(catName, animId)
        pcall(function()
            local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
            local animateScript = char:WaitForChild("Animate", 3)
            if animateScript then
                local searchKey = string.lower(catName)
                if searchKey == "swimidle" then searchKey = "swim" end
                local catFolder = animateScript:FindFirstChild(searchKey)
                
                if catFolder then
                    if catName == "Idle" and type(animId) == "table" then
                        local anim1 = catFolder:FindFirstChild("Animation1")
                        local anim2 = catFolder:FindFirstChild("Animation2")
                        if anim1 then anim1.AnimationId = "rbxassetid://" .. tostring(animId[1]) end
                        if anim2 then anim2.AnimationId = "rbxassetid://" .. tostring(animId[2]) end
                    else
                        for _, child in ipairs(catFolder:GetChildren()) do
                            if child:IsA("Animation") then
                                child.AnimationId = "rbxassetid://" .. tostring(animId)
                            end
                        end
                    end
                end
            end
        end)
    end

    local function resetAnimationCategory(catName)
        pcall(function()
            local char = LocalPlayer.Character
            if not char then return end
            local animateScript = char:FindFirstChild("Animate")
            if not animateScript then return end

            local searchKey = string.lower(catName)
            if searchKey == "swimidle" then searchKey = "swim" end
            local catFolder = animateScript:FindFirstChild(searchKey)
            if not catFolder then return end

            local originalData = DefaultOriginalIDs[catName]
            if originalData then
                if catName == "Idle" and type(originalData) == "table" then
                    local anim1 = catFolder:FindFirstChild("Animation1")
                    local anim2 = catFolder:FindFirstChild("Animation2")
                    if anim1 and originalData[1] ~= "" then anim1.AnimationId = originalData[1] end
                    if anim2 and originalData[2] ~= "" then anim2.AnimationId = originalData[2] end
                else
                    local idx = 1
                    for _, child in ipairs(catFolder:GetChildren()) do
                        if child:IsA("Animation") and originalData[idx] then
                            child.AnimationId = originalData[idx]
                            idx = idx + 1
                        end
                    end
                end
            end
        end)
    end

    local orderedCategories = {"Idle", "Walk", "Run", "Jump", "Fall", "Climb", "SwimIdle", "Swim"}

    for _, catName in ipairs(orderedCategories) do
        local animList = OriginalAnimations[catName]
        if animList then
            local catLabel = Instance.new("TextLabel")
            catLabel.Size = UDim2.new(1, -5, 0, 24)
            catLabel.BackgroundTransparency = 1
            catLabel.Text = "— " .. catName .. " —"
            catLabel.TextColor3 = Color3.fromRGB(219, 112, 147)
            catLabel.FontFace = FontB
            catLabel.TextSize = 11
            catLabel.TextXAlignment = Enum.TextXAlignment.Left
            catLabel.Parent = customAnimsTab

            for animName, animId in pairs(animList) do
                local btn = Instance.new("TextButton")
                btn.Size = UDim2.new(1, -5, 0, 32)
                btn.BackgroundColor3 = Color3.fromRGB(255, 175, 188)
                btn.BackgroundTransparency = 0.4
                btn.TextColor3 = Color3.fromRGB(120, 20, 60)
                btn.Text = animName .. " [" .. catName .. "] [Off]"
                btn.FontFace = FontB
                btn.TextSize = 10
                btn.Parent = customAnimsTab
                Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)

                local entry = {Button = btn, Name = string.lower(animName), Category = catName, AnimId = animId}
                table.insert(createdButtons, entry)

                if savedStates["Custom_" .. catName] == animName then
                    categoryActiveButtons[catName] = entry
                    btn.BackgroundColor3 = Color3.fromRGB(255, 105, 180)
                    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
                    btn.Text = animName .. " [" .. catName .. "] [On]"
                    task.spawn(function()
                        task.wait(1)
                        cacheOriginalIDs()
                        applyAnimationToChar(catName, animId)
                    end)
                end
                btn.MouseButton1Click:Connect(function()
                    playClickSound()
                    cacheOriginalIDs()
                    local isCurrentlyOn = string.find(btn.Text, "%[On%]")
                    if isCurrentlyOn then
                        btn.BackgroundColor3 = Color3.fromRGB(255, 175, 188)
                        btn.TextColor3 = Color3.fromRGB(120, 20, 60)
                        btn.Text = animName .. " [" .. catName .. "] [Off]"
                        if categoryActiveButtons[catName] == entry then
                            categoryActiveButtons[catName] = nil
                        end
                        savedStates["Custom_" .. catName] = nil
                        resetAnimationCategory(catName)
                    else
                        if categoryActiveButtons[catName] then
                            local oldEntry = categoryActiveButtons[catName]
                            oldEntry.Button.BackgroundColor3 = Color3.fromRGB(255, 175, 188)
                            oldEntry.Button.TextColor3 = Color3.fromRGB(120, 20, 60)
                            local oldCleanName = string.match(oldEntry.Button.Text, "^(.-)%s*%[") or ""
                            oldEntry.Button.Text = oldCleanName .. " [" .. catName .. "] [Off]"
                        end
                        
                        btn.BackgroundColor3 = Color3.fromRGB(255, 105, 180)
                        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
                        btn.Text = animName .. " [" .. catName .. "] [On]"
                        categoryActiveButtons[catName] = entry
                        savedStates["Custom_" .. catName] = animName
                        applyAnimationToChar(catName, animId)
                    end
                    saveConfig()
                end)
            end
        end
    end
    LocalPlayer.CharacterAdded:Connect(function(newChar)
        task.wait(1)
        cacheOriginalIDs()
        for catName, entry in pairs(categoryActiveButtons) do
            applyAnimationToChar(catName, entry.AnimId)
        end
    end)

    task.spawn(function()
        task.wait(1)
        cacheOriginalIDs()
    end)

    local bottomBar = Instance.new("Frame")
    bottomBar.Size = UDim2.new(1, -5, 0, 38)
    bottomBar.BackgroundTransparency = 1
    bottomBar.Parent = customAnimsTab

    local resetAllBtn = Instance.new("TextButton")
    resetAllBtn.Size = UDim2.new(0, 110, 1, 0)
    resetAllBtn.Position = UDim2.new(0, 0, 0, 0)
    resetAllBtn.BackgroundColor3 = Color3.fromRGB(255, 105, 180) -- Hot Pink
    resetAllBtn.Text = "Reset All"
    resetAllBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    resetAllBtn.FontFace = FontB
    resetAllBtn.TextSize = 10
    resetAllBtn.Parent = bottomBar
    Instance.new("UICorner", resetAllBtn).CornerRadius = UDim.new(0, 8)
    searchBox:GetPropertyChangedSignal("Text"):Connect(function()
        local query = string.lower(searchBox.Text)
        for _, entry in ipairs(createdButtons) do
            if query == "" or string.find(entry.Name, query) then
                entry.Button.Visible = true
            else
                entry.Button.Visible = false
            end
        end
    end)
    resetAllBtn.MouseButton1Click:Connect(function()
        playClickSound()
        for _, entry in ipairs(createdButtons) do
            entry.Button.BackgroundColor3 = Color3.fromRGB(255, 175, 188)
            entry.Button.TextColor3 = Color3.fromRGB(120, 20, 60)
            local cleanName = string.match(entry.Button.Text, "^(.-)%s*%[") or ""
            entry.Button.Text = cleanName .. " [" .. entry.Category .. "] [Off]"
        end
        categoryActiveButtons = {}
        for _, catName in ipairs(orderedCategories) do
            savedStates["Custom_" .. catName] = nil
            resetAnimationCategory(catName)
        end
        saveConfig()
        resetAllBtn.Text = "Reset All ✓"
        task.delay(1, function() resetAllBtn.Text = "Reset All" end)
    end)
end

-- ===============================
-- CATEGORIZED SCRIPTS
-- ===============================
local categorizedScripts = {
    ["SpeedGlitch"] = {
        {name = "*SpeedGlitch Tracker", code = function() loadstring(game:HttpGet("https://pastefy.app/AGEUcVNO/raw"))() end},
        {name = "*SpeedGlitch Emotes", code = function() loadstring(game:HttpGet("https://pastefy.app/aGPsgtpc/raw"))() end},
        {name = "*SpeedGlitch Climb", code = function() loadstring(game:HttpGet("https://pastefy.app/PC1fXUB9/raw"))() end},
        {name = "SpeedGlitch Menu", code = function() loadstring(game:HttpGet("https://pastefy.app/uAmdRPLK/raw?part=Speed%20tur"))() end},
    },
    ["Animations"] = {
        {name = "*Animations", code = function() loadstring(game:HttpGet("https://api.rubis.app/v2/scrap/PwFrcMysMOIJuWAQ/raw"))() end},
        {name = "*FE Emotes", code = function() loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Fe-emotes-136121"))() end},
        {name = "Old Animation", code = function() game.Workspace.Retargeting = Enum.AnimatorRetargetingMode.Disabled end},
        {name = "Body Scales", code = function() loadstring(game:HttpGet("https://gist.githubusercontent.com/phanhhne20-pixel/33327a1177d7c47c3915e8ecd1f12db0/raw/8329ab3c7bae3be6a06cde673e6ef52210e1d525/BodyScale.lua"))() end},
        {name = "Headless Head", code = function() loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Headless-script-does-not-take-away-accessories-240674"))() end},
    },
    ["Quality & Audio"] = {
        {name = "*Quality Boost", code = function() loadstring(game:HttpGet("https://pastefy.app/xOWSgyn3/raw"))() end},
        {name = "*Matte Quality", code = function() loadstring(game:HttpGet("https://pastefy.app/kS2oIOgX/raw"))() end},
        {name = "2022 Quality", code = function() loadstring(game:HttpGet("https://pastefy.app/A1P0NDji/raw"))() end},
        {name = "Edit Audio", code = function() loadstring(game:HttpGet("https://pastefy.app/RVW7TOPW/raw"))() end},
        {name = "Gun Sound", code = function() loadstring(game:HttpGet("https://pastefy.app/DmiGQ5MU/raw"))() end},
        {name = "Night Colors", code = function() loadstring(game:HttpGet("https://pastefy.app/C1pldQZt/raw"))() end},
    },
    ["Utilities"] = {
        {name = "Fling Jump", code = function() loadstring(game:HttpGet("https://pastefy.app/KDhhMINJ/raw"))() end},
        {name = "Slot (2) Emotes (Only PC)", code = function() loadstring(game:HttpGet("https://pastefy.app/daAKZfHG/raw"))() end},
        {name = "*Fake Lag Wifi", code = function() loadstring(game:HttpGet("https://pastefy.app/lTL9XW4l/raw"))() end},
        {name = "*Shiftlock 2023", code = function() loadstring(game:HttpGet("https://pastefy.app/iyd3boez/raw"))() end},
        {name = "Anti Click", code = function() loadstring(game:HttpGet("https://pastefy.app/7uMgYcQB/raw"))() end},
        {name = "Anti Fling", code = function() loadstring(game:HttpGet("https://pastefy.app/G84qxync/raw"))() end},
        {name = "Gold Bomb Menu", code = function() loadstring(game:HttpGet("https://tinyurl.com/BombGoldLoader"))() end},
        {name = "Old Camera", code = function() loadstring(game:HttpGet("https://pastefy.app/YkSj9UbZ/raw"))() end},
        {name = "Edit Gun", code = function() loadstring(game:HttpGet("https://pastefy.app/PTLmM3jD/raw"))() end},
        {name = "Mobile Crosshair", code = function() loadstring(game:HttpGet("https://pastefy.app/2crSBSx4/raw"))() end},
        {name = "Old Throw", code = function() loadstring(game:HttpGet("https://pastefy.app/GyghlYOG/raw"))() end},
        {name = "Round Timer (Mobile)", code = function() loadstring(game:HttpGet("https://pastefy.app/lkMD3o5q/raw"))() end},
        {name = "Muzzle Flash", code = function() loadstring(game:HttpGet("https://pastefy.app/fOcKGJe9/raw"))() end},
        {name = "Kill Feed", code = function() loadstring(game:HttpGet("https://gist.githubusercontent.com/phanhhne20-pixel/11c0ccccb93ca6fd01a50d2686baa273/raw/KillFeed.lua"))() end},
    }
}

for catName, items in pairs(categorizedScripts) do
    local targetTab = tabs[catName]
    if targetTab then
        for _, item in ipairs(items) do
            local btn = Instance.new("TextButton")
            btn.Size = UDim2.new(1, -5, 0, 34)
            btn.BackgroundColor3 = Color3.fromRGB(255, 175, 188)
            btn.BackgroundTransparency = 0.4
            btn.TextColor3 = Color3.fromRGB(120, 20, 60)
            btn.Text = item.name .. " [Off]"
            btn.FontFace = FontB
            btn.TextSize = 10
            btn.Parent = targetTab
            Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)

            local isToggled = false
            if savedStates[item.name] == true then
                isToggled = true
                btn.BackgroundColor3 = Color3.fromRGB(255, 105, 180)
                btn.TextColor3 = Color3.fromRGB(255, 255, 255)
                btn.Text = item.name .. " [On]"
                pcall(item.code)
            end
            btn.MouseButton1Click:Connect(function()
                playClickSound()
                isToggled = not isToggled
                if isToggled then
                    btn.BackgroundColor3 = Color3.fromRGB(255, 105, 180)
                    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
                    btn.Text = item.name .. " [On]"
                    savedStates[item.name] = true
                    pcall(item.code)
                else
                    btn.BackgroundColor3 = Color3.fromRGB(255, 175, 188)
                    btn.TextColor3 = Color3.fromRGB(120, 20, 60)
                    btn.Text = item.name .. " [Off]"
                    savedStates[item.name] = false
                end
                saveConfig()
            end)
        end
    end
end

-- ===============================
-- THE MIST TAB
-- ===============================
local mistTab = tabs["The Mist"]
if mistTab then
    local F = false
    local FogV, FogM = 30, 1000

    local Fb = Instance.new("TextButton")
    Fb.Size = UDim2.new(1, -5, 0, 36)
    Fb.BackgroundColor3 = Color3.fromRGB(220, 220, 225)
    Fb.Text = "The Mist: Off"
    Fb.TextColor3 = Color3.fromRGB(255, 20, 147)
    Fb.FontFace = FontB
    Fb.TextSize = 11
    Fb.Parent = mistTab
    Instance.new("UICorner", Fb).CornerRadius = UDim.new(0, 8)

    local Cb = Instance.new("TextButton")
    Cb.Size = UDim2.new(1, -5, 0, 36)
    Cb.BackgroundColor3 = Color3.fromRGB(250, 220, 235)
    Cb.Text = "Mist Color: Rose"
    Cb.TextColor3 = Color3.fromRGB(255, 20, 147)
    Cb.FontFace = FontB
    Cb.TextSize = 11
    Cb.Parent = mistTab
    Instance.new("UICorner", Cb).CornerRadius = UDim.new(0, 8)

    local FSB = Instance.new("Frame")
    FSB.Size = UDim2.new(1, -5, 0, 10)
    FSB.BackgroundColor3 = Color3.fromRGB(230, 230, 235)
    FSB.Parent = mistTab
    Instance.new("UICorner", FSB).CornerRadius = UDim.new(0, 4)

    local FSF = Instance.new("Frame")
    FSF.Size = UDim2.new((FogV/FogM), 0, 1, 0)
    FSF.BackgroundColor3 = Color3.fromRGB(255, 105, 180)
    FSF.Parent = FSB
    Instance.new("UICorner", FSF).CornerRadius = UDim.new(0, 4)

    local Fbtn = Instance.new("TextButton")
    Fbtn.Size = UDim2.new(0, 18, 0, 18)
    Fbtn.Position = UDim2.new((FogV/FogM), -9, 0.5, -9)
    Fbtn.BackgroundColor3 = Color3.fromRGB(255, 20, 147)
    Fbtn.Text = ""
    Fbtn.ZIndex = 2
    Fbtn.Parent = FSB
    Instance.new("UICorner", Fbtn).CornerRadius = UDim.new(1, 0)

    local Fdrag = false
    Fbtn.MouseButton1Down:Connect(function() Fdrag = true end)
    Fbtn.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then Fdrag = true end
    end)
    UserInputService.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then Fdrag = false end
    end)

    local oEnd, oStart, oColor = Lighting.FogEnd, Lighting.FogStart, Lighting.FogColor
    local names = {"Rose", "Blood", "Aqua", "Viora", "Forest", "Lucid", "Shade"}
    local colors = {
        Color3.fromRGB(255, 105, 180), Color3.fromRGB(255, 0, 0), Color3.fromRGB(0, 191, 255),
        Color3.fromRGB(148, 0, 211), Color3.fromRGB(50, 205, 50), Color3.fromRGB(255, 255, 255), Color3.fromRGB(0, 0, 0)
    }
    local cIdx = 1

    local function UFog(v)
        FogV = math.clamp(v, 0, FogM)
        local pct = FogV / FogM
        FSF.Size = UDim2.new(pct, 0, 1, 0)
        Fbtn.Position = UDim2.new(pct, -9, 0.5, -9)
    end
    RunService.RenderStepped:Connect(function()
        if Fdrag then
            local pct = math.clamp((UserInputService:GetMouseLocation().X - FSB.AbsolutePosition.X) / FSB.AbsoluteSize.X, 0, 1)
            UFog(pct * FogM)
        end
    end)
    RunService.Heartbeat:Connect(function()
        if F then
            Lighting.FogEnd, Lighting.FogStart = FogV, 0
            Lighting.FogColor = colors[cIdx]
        end
    end)
    Fb.MouseButton1Click:Connect(function()
        playClickSound()
        F = not F
        if F then
            oEnd, oStart, oColor = Lighting.FogEnd, Lighting.FogStart, Lighting.FogColor
            Fb.Text, Fb.BackgroundColor3 = "The Mist: On", Color3.fromRGB(255, 105, 180)
            Fb.TextColor3 = Color3.fromRGB(255, 255, 255)
        else
            Lighting.FogEnd, Lighting.FogStart, Lighting.FogColor = oEnd, oStart, oColor
            Fb.Text, Fb.BackgroundColor3 = "The Mist: Off", Color3.fromRGB(220, 220, 225)
            Fb.TextColor3 = Color3.fromRGB(255, 20, 147)
        end
    end)
    Cb.MouseButton1Click:Connect(function()
        playClickSound()
        cIdx = cIdx % #colors + 1
        Cb.Text = "Mist Color: " .. names[cIdx]
    end)
end

-- ===============================
-- SKYBOX TAB
-- ===============================
local skyboxTab = tabs["Skybox"]
if skyboxTab then
    local function ApplySkybox(data)
        for _, v in ipairs(Lighting:GetChildren()) do
            if v:IsA("Sky") then
                v:Destroy()
            end
        end
        if data.Back == "" then return end
        local sky = Instance.new("Sky")
        sky.Name = data.Name or "DevySky"
        sky.SkyboxBk = data.Back
        sky.SkyboxDn = data.Down
        sky.SkyboxFt = data.Front
        sky.SkyboxLf = data.Left
        sky.SkyboxRt = data.Right
        sky.SkyboxUp = data.Up
        sky.CelestialBodiesShown = data.CelestialBodies ~= nil and data.CelestialBodies or true
        sky.StarCount = data.Stars or 0
        sky.SunAngularSize = data.Sun or 0
        sky.MoonAngularSize = data.Moon or 0
        sky.Parent = Lighting
    end

    local Skyboxes = {
        {Name = "Default Sky", Back = "", Down = "", Front = "", Left = "", Right = "", Up = "", Stars = 0, Sun = 0, Moon = 0},
        {Name = "Aurora Sky", Back = "rbxassetid://87940909296156", Down = "rbxassetid://103510771527492", Front = "rbxassetid://85585087312696", Left = "rbxassetid://130745713571518", Right = "rbxassetid://84365244722499", Up = "rbxassetid://70997945956227", CelestialBodies = true, Stars = 0, Sun = 21, Moon = 11},
        {Name = "Pink Devy Sky", Back = "rbxassetid://117346125840869", Down = "rbxassetid://129979364895446", Front = "rbxassetid://95669767832398", Left = "rbxassetid://123353691004734", Right = "rbxassetid://115925681097884", Up = "rbxassetid://93592540026214", Stars = 0, Sun = 0, Moon = 0},
        {Name = "Kitty Sanrio Sky", Back = "rbxassetid://135297280579161", Down = "rbxassetid://76872220095611", Front = "rbxassetid://133452089641107", Left = "rbxassetid://104464782805839", Right = "rbxassetid://88627908709078", Up = "rbxassetid://82728976669867", Stars = 0, Sun = 0, Moon = 0},
        {Name = "Blood Sky", Back = "rbxassetid://121591373356699", Down = "rbxassetid://88138687140149", Front = "rbxassetid://107744954040826", Left = "rbxassetid://80139878541433", Right = "rbxassetid://121436135506580", Up = "rbxassetid://92094842425715", Stars = 0, Sun = 0, Moon = 0},
        {Name = "Blue Devy Sky", Back = "rbxassetid://131095080505898", Down = "rbxassetid://101545571552918", Front = "rbxassetid://101301374438979", Left = "rbxassetid://96599132293937", Right = "rbxassetid://136207405616331", Up = "rbxassetid://94638659913346", Stars = 0, Sun = 0, Moon = 0},
        {Name = "Black Devy Sky", Back = "rbxassetid://100308006808093", Down = "rbxassetid://87757021838976", Front = "rbxassetid://134392249192671", Left = "rbxassetid://128847653087798", Right = "rbxassetid://111842342310442", Up = "rbxassetid://103728498188642", Stars = 0, Sun = 0, Moon = 0},
        {Name = "Purple Devy Sky", Back = "rbxassetid://87378222674385", Down = "rbxassetid://104355138301914", Front = "rbxassetid://126918111304742", Left = "rbxassetid://120958656125387", Right = "rbxassetid://81532301294796", Up = "rbxassetid://70907815296984", Stars = 0, Sun = 21, Moon = 11},
        {Name = "Red Devy Sky", Back = "rbxassetid://98649652374734", Down = "rbxassetid://77728445042356", Front = "rbxassetid://88692806904408", Left = "rbxassetid://110599061243112", Right = "rbxassetid://116081101138365", Up = "rbxassetid://84800078770918", Stars = 0, Sun = 21, Moon = 11}
    }

    for _, skyData in ipairs(Skyboxes) do
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, -5, 0, 36)
        btn.BackgroundColor3 = Color3.fromRGB(250, 220, 235)
        btn.BackgroundTransparency = 0.4
        btn.TextColor3 = Color3.fromRGB(219, 112, 147)
        btn.Text = skyData.Name
        btn.FontFace = FontB
        btn.TextSize = 11
        btn.Parent = skyboxTab
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)

        btn.MouseButton1Click:Connect(function()
            playClickSound()
            ApplySkybox(skyData)
            btn.BackgroundColor3 = Color3.fromRGB(46, 204, 113)
            btn.TextColor3 = Color3.fromRGB(255, 255, 255)
            btn.Text = skyData.Name .. " ✓"
            task.delay(0.8, function()
                if btn.Parent then
                    btn.BackgroundColor3 = Color3.fromRGB(250, 220, 235)
                    btn.TextColor3 = Color3.fromRGB(219, 112, 147)
                    btn.Text = skyData.Name
                end
            end)
        end)
    end
end

-- ===============================
-- CURSOR & SHIFTLOCK
-- ===============================
local cursorTab = tabs["Cursor"]
if cursorTab then
    local customShiftLockEnabled = false
    local cursorSize = 32
    local DefaultImages = {
        "rbxasset://textures/MouseLockedCursor.png",
        "rbxasset://textures/MouseLockedCursor@2x.png"
    }

    local Cursors = {
        {Name = "Snow", Id = "rbxassetid://131843855435385"},
        {Name = "Violet", Id = "rbxassetid://105227484929270"},
        {Name = "Funerose", Id = "rbxassetid://70807381747714"},
        {Name = "Moon", Id = "rbxassetid://134411152875782"},
        {Name = "Strawb", Id = "rbxassetid://101446374921049"},
        {Name = "Crystal", Id = "rbxassetid://94640444703376"},
        {Name = "Grass", Id = "rbxassetid://112063814299010"},
        {Name = "Ocean", Id = "rbxassetid://105472303240225"},
        {Name = "Deep Straw", Id = "rbxassetid://120423063723029"},
        {Name = "Spider Lily", Id = "rbxassetid://93953005352303"},
        {Name = "Mocha", Id = "rbxassetid://123066282804999"},
        {Name = "Cinnamoroll", Id = "rbxassetid://130820173728340"},
        {Name = "Star", Id = "rbxassetid://11716557686"},
        {Name = "Diamond", Id = "rbxassetid://86867462006638"},
        {Name = "Claret Diamond", Id = "rbxassetid://92104309771570"}
    }
    local currentCursorIdx = 1
    local ShiftlockObjects = {}
    local originalSizes = {}
    local originalImages = {}

    local function ScanShiftLock()
        ShiftlockObjects = {}
        for _, v in pairs(game:GetDescendants()) do
            if v:IsA("ImageLabel") or v:IsA("ImageButton") then
                if table.find(DefaultImages, v.Image)
                or string.find(string.lower(v.Name), "shift")
                or string.find(string.lower(v.Name), "lock") then
                    table.insert(ShiftlockObjects, v)
                    if not originalSizes[v] then
                        originalSizes[v] = v.Size
                        originalImages[v] = v.Image
                    end
                end
            end
        end
    end

    local function UpdateShiftLockVisuals()
        for _, v in pairs(ShiftlockObjects) do
            if v and v.Parent then
                if customShiftLockEnabled then
                    v.Image = Cursors[currentCursorIdx].Id
                    v.Size = UDim2.new(0, cursorSize, 0, cursorSize)
                    v.ImageTransparency = 0
                    v.BackgroundTransparency = 1
                    v.ScaleType = Enum.ScaleType.Fit
                else
                    v.Image = originalImages[v] or "rbxasset://textures/MouseLockedCursor.png"
                    v.Size = originalSizes[v] or UDim2.new(0, 32, 0, 32)
                    v.ImageTransparency = 0
                end
            end
        end
    end

    ScanShiftLock()

    local shiftlockToggleBtn = Instance.new("TextButton")
    shiftlockToggleBtn.Size = UDim2.new(1, -5, 0, 36)
    shiftlockToggleBtn.BackgroundColor3 = Color3.fromRGB(255, 175, 188)
    shiftlockToggleBtn.BackgroundTransparency = 0.4
    shiftlockToggleBtn.Text = "Shiftlock Cursor: Off"
    shiftlockToggleBtn.TextColor3 = Color3.fromRGB(120, 20, 60)
    shiftlockToggleBtn.FontFace = FontB
    shiftlockToggleBtn.TextSize = 11
    shiftlockToggleBtn.Parent = cursorTab
    Instance.new("UICorner", shiftlockToggleBtn).CornerRadius = UDim.new(0, 8)
    shiftlockToggleBtn.MouseButton1Click:Connect(function()
        playClickSound()
        customShiftLockEnabled = not customShiftLockEnabled
        shiftlockToggleBtn.Text = customShiftLockEnabled and "Shiftlock Cursor: On" or "Shiftlock Cursor: Off"
        shiftlockToggleBtn.BackgroundColor3 = customShiftLockEnabled and Color3.fromRGB(255, 105, 180) or Color3.fromRGB(255, 175, 188)
        shiftlockToggleBtn.TextColor3 = customShiftLockEnabled and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(120, 20, 60)
        UpdateShiftLockVisuals()
    end)

    local sizeLabel = Instance.new("TextLabel")
    sizeLabel.Size = UDim2.new(1, -5, 0, 20)
    sizeLabel.BackgroundTransparency = 1
    sizeLabel.Text = "Cursor Size: " .. cursorSize .. "px"
    sizeLabel.TextColor3 = Color3.fromRGB(219, 112, 147)
    sizeLabel.FontFace = FontB
    sizeLabel.TextSize = 11
    sizeLabel.TextXAlignment = Enum.TextXAlignment.Left
    sizeLabel.Parent = cursorTab

    local sizeSliderBar = Instance.new("Frame")
    sizeSliderBar.Size = UDim2.new(1, -5, 0, 10)
    sizeSliderBar.BackgroundColor3 = Color3.fromRGB(230, 230, 235)
    sizeSliderBar.Parent = cursorTab
    Instance.new("UICorner", sizeSliderBar).CornerRadius = UDim.new(0, 4)

    local sizeSliderFill = Instance.new("Frame")
    sizeSliderFill.Size = UDim2.new((cursorSize - 16) / (64 - 16), 0, 1, 0)
    sizeSliderFill.BackgroundColor3 = Color3.fromRGB(255, 105, 180)
    sizeSliderFill.Parent = sizeSliderBar
    Instance.new("UICorner", sizeSliderFill).CornerRadius = UDim.new(0, 4)

    local sizeSliderBtn = Instance.new("TextButton")
    sizeSliderBtn.Size = UDim2.new(0, 18, 0, 18)
    sizeSliderBtn.Position = UDim2.new((cursorSize - 16) / (64 - 16), -9, 0.5, -9)
    sizeSliderBtn.BackgroundColor3 = Color3.fromRGB(255, 20, 147)
    sizeSliderBtn.Text = ""
    sizeSliderBtn.ZIndex = 2
    sizeSliderBtn.Parent = sizeSliderBar
    Instance.new("UICorner", sizeSliderBtn).CornerRadius = UDim.new(1, 0)

    local sDrag = false
    sizeSliderBtn.MouseButton1Down:Connect(function() sDrag = true end)
    sizeSliderBtn.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then sDrag = true end
    end)
    UserInputService.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then sDrag = false end
    end)
    RunService.RenderStepped:Connect(function()
        if sDrag then
            local pct = math.clamp((UserInputService:GetMouseLocation().X - sizeSliderBar.AbsolutePosition.X) / sizeSliderBar.AbsoluteSize.X, 0, 1)
            cursorSize = math.floor(16 + pct * (64 - 16))
            sizeLabel.Text = "Cursor Size: " .. cursorSize .. "px"
            sizeSliderFill.Size = UDim2.new(pct, 0, 1, 0)
            sizeSliderBtn.Position = UDim2.new(pct, -9, 0.5, -9)
            UpdateShiftLockVisuals()
        end
    end)

    for idx, cursorData in ipairs(Cursors) do
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, -5, 0, 36)
        btn.BackgroundColor3 = Color3.fromRGB(250, 220, 235)
        btn.BackgroundTransparency = 0.4
        btn.TextColor3 = Color3.fromRGB(219, 112, 147)
        btn.FontFace = FontB
        btn.TextSize = 11
        btn.Parent = cursorTab
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)

        local imgIcon = Instance.new("ImageLabel")
        imgIcon.Size = UDim2.new(0, 24, 0, 24)
        imgIcon.Position = UDim2.new(0, 10, 0.5, -12)
        imgIcon.BackgroundTransparency = 1
        imgIcon.Image = cursorData.Id
        imgIcon.ScaleType = Enum.ScaleType.Fit
        imgIcon.ImageRectSize = Vector2.new(0, 0)
        imgIcon.Parent = btn

        local txtLabel = Instance.new("TextLabel")
        txtLabel.Size = UDim2.new(1, -45, 1, 0)
        txtLabel.Position = UDim2.new(0, 42, 0, 0)
        txtLabel.BackgroundTransparency = 1
        txtLabel.Text = cursorData.Name
        txtLabel.TextColor3 = Color3.fromRGB(219, 112, 147)
        txtLabel.FontFace = FontB
        txtLabel.TextSize = 11
        txtLabel.TextXAlignment = Enum.TextXAlignment.Left
        txtLabel.Parent = btn
        btn.MouseButton1Click:Connect(function()
            playClickSound()
            currentCursorIdx = idx
            customShiftLockEnabled = true
            shiftlockToggleBtn.Text = "Shiftlock Cursor: On"
            shiftlockToggleBtn.BackgroundColor3 = Color3.fromRGB(255, 105, 180)
            shiftlockToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            UpdateShiftLockVisuals()
        end)
    end
end

-- ===============================
-- ABOUT TAB
-- ===============================
local aboutTab = tabs["About"]
if aboutTab then
    local aboutCard = Instance.new("Frame")
    aboutCard.Size = UDim2.new(1, -5, 0, 160)
    aboutCard.BackgroundColor3 = Color3.fromRGB(255, 235, 242)
    aboutCard.BackgroundTransparency = 0.3
    aboutCard.Parent = aboutTab
    Instance.new("UICorner", aboutCard).CornerRadius = UDim.new(0, 10)

    local creditsLabel = Instance.new("TextLabel")
    creditsLabel.Size = UDim2.new(1, -10, 0, 65)
    creditsLabel.Position = UDim2.new(0, 5, 0, 5)
    creditsLabel.BackgroundTransparency = 1
    creditsLabel.Text = "Thanks for using Phanh Star Core Menu ! UI aggregated from various sources || @sparklecatts"
    creditsLabel.TextColor3 = Color3.fromRGB(120, 20, 60)
    creditsLabel.FontFace = FontB
    creditsLabel.TextSize = 11
    creditsLabel.TextWrapped = true
    creditsLabel.Parent = aboutCard

    local profileUrl = "https://www.roblox.com/users/3382617133/profile"
    local linkButton = Instance.new("TextButton")
    linkButton.Size = UDim2.new(0.95, 0, 0, 32)
    linkButton.Position = UDim2.new(0.025, 0, 0.48, 0)
    linkButton.BackgroundColor3 = Color3.fromRGB(255, 105, 180)
    linkButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    linkButton.Text = "Copy Roblox Profile Link"
    linkButton.FontFace = FontB
    linkButton.TextSize = 11
    linkButton.Parent = aboutCard
    Instance.new("UICorner", linkButton).CornerRadius = UDim.new(0, 6)
    linkButton.MouseButton1Click:Connect(function()
        playClickSound()
        if setclipboard then
            setclipboard(profileUrl)
            linkButton.Text = "Link Copied!"
            task.delay(2, function() linkButton.Text = "Copy Roblox Profile Link" end)
        else
            linkButton.Text = "Executor not supported!"
        end
    end)
end

-- ===============================
-- DRAGGABLE & TOGGLE KEYBINDS
-- ===============================
local dUI, dS, sP = false, nil, nil
titleBar.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
        dUI = true
        dS = i.Position
        sP = mainFrame.Position
    end
end)

UserInputService.InputChanged:Connect(function(i)
    if dUI and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
        local delta = i.Position - dS
        mainFrame.Position = UDim2.new(sP.X.Scale, sP.X.Offset + delta.X, sP.Y.Scale, sP.Y.Offset + delta.Y)
    end
end)

UserInputService.InputEnded:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
        dUI = false
    end
end)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.K then
        iconBtn.MouseButton1Click:Fire()
    end
end)
