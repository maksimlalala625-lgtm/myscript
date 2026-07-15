-- Загрузка красивой библиотеки интерфейса Rayfield
local Rayfield = loadstring(game:HttpGet('https://sirius.menu'))()

-- Создание главного окна чита
local Window = Rayfield:CreateWindow({
   Name = "tubeshub | Squid Game X",
   LoadingTitle = "Загрузка tubeshub...",
   LoadingSubtitle = "by ТвойНик",
   ConfigurationSaving = { Enabled = false }
})

-- Создание вкладки для функций Охранника
local GuardTab = Window:CreateTab("Guard Functions", 4483362458) -- иконка папки

-- Переменные для отслеживания включена функция или выключена
local AutoKillEnabled = false
local AutoCoffinEnabled = false
local AutoBurnEnabled = false
local AutoCookEnabled = false

-- Сервисы игры
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer

-- Вспомогательные функции (Телепорт и Кнопка E)
local function teleportTo(cframe)
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        LocalPlayer.Character.HumanoidRootPart.CFrame = cframe
        task.wait(0.1)
    end
end

local function activatePrompt(prompt)
    if prompt and prompt:IsA("ProximityPrompt") then
        fireproximityprompt(prompt, 10)
    end
end

-- ==================== СОЗДАНИЕ ПЕРЕКЛЮЧАТЕЛЕЙ В МЕНЮ ====================

-- 1. Переключатель: Auto-Kill
GuardTab:CreateToggle({
   Name = "Auto-Kill (Авто-убийство)",
   CurrentValue = false,
   Callback = function(Value)
      AutoKillEnabled = Value -- принимает true (вкл) или false (выкл)
      
      -- Запуск функции в фоновом режиме, если включили
      if AutoKillEnabled then
          task.spawn(function()
              while AutoKillEnabled do
                  for _, player in ipairs(Players:GetPlayers()) do
                      if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Humanoid") then
                          if player.Character.Humanoid.Health <= 0 or player:GetAttribute("Eliminated") == true then
                              teleportTo(player.Character.HumanoidRootPart.CFrame)
                              local tool = LocalPlayer.Character:FindFirstChildOfClass("Tool")
                              if tool then tool:Activate() end
                              task.wait(0.2)
                          end
                      end
                  end
                  task.wait(0.3)
              end
          end)
      end
   end,
})

-- 2. Переключатель: Auto-Coffin
GuardTab:CreateToggle({
   Name = "Auto-Coffin (Брать гроб)",
   CurrentValue = false,
   Callback = function(Value)
      AutoCoffinEnabled = Value
      
      if AutoCoffinEnabled then
          task.spawn(function()
              while AutoCoffinEnabled do
                  local hasCoffin = LocalPlayer.Character:FindFirstChild("Coffin") or LocalPlayer.Backpack:FindFirstChild("Coffin")
                  if not hasCoffin then
                      local CoffinPile = Workspace:FindFirstChild("CoffinPile", true) or Workspace:FindFirstChild("Coffins", true)
                      if CoffinPile then
                          local prompt = CoffinPile:FindFirstChildOfClass("ProximityPrompt", true)
                          if prompt then
                              teleportTo(prompt.Parent.CFrame * CFrame.new(0, 2, 0))
                              activatePrompt(prompt)
                          end
                      end
                  end
                  task.wait(0.5)
              end
          end)
      end
   end,
})

-- 3. Переключатель: Auto-Burn
GuardTab:CreateToggle({
   Name = "Auto-Burn (Сжигать гроб)",
   CurrentValue = false,
   Callback = function(Value)
      AutoBurnEnabled = Value
      
      if AutoBurnEnabled then
          task.spawn(function()
              while AutoBurnEnabled do
                  local hasCoffin = LocalPlayer.Character:FindFirstChild("Coffin") or LocalPlayer.Backpack:FindFirstChild("Coffin")
                  if hasCoffin then
                      local Furnace = Workspace:FindFirstChild("Furnace", true) or Workspace:FindFirstChild("Incinerator", true)
                      if Furnace then
                          local prompt = Furnace:FindFirstChildOfClass("ProximityPrompt", true)
                          if prompt then
                              teleportTo(prompt.Parent.CFrame * CFrame.new(0, 2, 0))
                              activatePrompt(prompt)
                          end
                      end
                  end
                  task.wait(0.5)
              end
          end)
      end
   end,
})

-- 4. Переключатель: Auto-Cook
GuardTab:CreateToggle({
   Name = "Auto-Cook (Авто-готовка)",
   CurrentValue = false,
   Callback = function(Value)
      AutoCookEnabled = Value
      
      if AutoCookEnabled then
          task.spawn(function()
              while AutoCookEnabled do
                  local Kitchen = Workspace:FindFirstChild("Kitchen", true)
                  if Kitchen then
                      local hasIng1 = LocalPlayer.Character:FindFirstChild("Ingredient1")
                      local hasIng2 = LocalPlayer.Character:FindFirstChild("Ingredient2")
                      local hasFood = LocalPlayer.Character:FindFirstChild("CookedFood")
                      
                      if not hasIng1 and not hasIng2 and not hasFood then
                          local Ing1 = Kitchen:FindFirstChild("Ingredient1Spawns", true)
                          if Ing1 then activatePrompt(Ing1:FindFirstChildOfClass("ProximityPrompt", true)) end
                          task.wait(0.5)
                          local Ing2 = Kitchen:FindFirstChild("Ingredient2Spawns", true)
                          if Ing2 then activatePrompt(Ing2:FindFirstChildOfClass("ProximityPrompt", true)) end
                      elseif (hasIng1 or hasIng2) and not hasFood then
                          local Stove = Kitchen:FindFirstChild("Stove", true)
                          if Stove then
                              local p = Stove:FindFirstChildOfClass("ProximityPrompt", true)
                              teleportTo(p.Parent.CFrame)
                              activatePrompt(p)
                              repeat task.wait(0.5) until Stove:GetAttribute("Status") == "Cooked" or not AutoCookEnabled
                              activatePrompt(p)
                          end
                      elseif hasFood then
                          local Fridge = Kitchen:FindFirstChild("Fridge", true)
                          if Fridge then activatePrompt(Fridge:FindFirstChildOfClass("ProximityPrompt", true)) end
                      end
                  end
                  task.wait(0.5)
              end
          end)
      end
   end,
})

Rayfield:Notify({
   Title = "tubeshub запущен!",
   Content = "Меню Guard успешно создано.",
   Duration = 5,
   Image = 4483362458,
})
