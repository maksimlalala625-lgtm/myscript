-- ==========================================
-- ФУНКЦИЯ 1: Приветственное уведомление
-- ==========================================
local function startNotification()
    print("Скрипт успешно запущен!")
    -- Здесь код для вывода красивого сообщения на экран
end

-- ==========================================
-- ФУНКЦИЯ 2: Изменение скорости персонажа
-- ==========================================
local function setCharacterSpeed(targetSpeed)
    local player = game.Players.LocalPlayer
    if player and player.Character and player.Character:FindFirstChildOfClass("Humanoid") then
        player.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = targetSpeed
    end
end

-- ==========================================
-- ФУНКЦИЯ 3: Изменение высоты прыжка
-- ==========================================
local function setJumpPower(targetPower)
    local player = game.Players.LocalPlayer
    if player and player.Character and player.Character:FindFirstChildOfClass("Humanoid") then
        player.Character:FindFirstChildOfClass("Humanoid").JumpPower = targetPower
    end
end

-- ==========================================
-- ФУНКЦИЯ 4: Бесконечная энергия / Сброс параметров
-- ==========================================
local function resetModifications()
    local player = game.Players.LocalPlayer
    if player and player.Character and player.Character:FindFirstChildOfClass("Humanoid") then
        player.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = 16   -- Стандартная скорость
        player.Character:FindFirstChildOfClass("Humanoid").JumpPower = 50   -- Стандартный прыжок
    end
end

-- ==========================================
-- ЗАПУСК ФУНКЦИЙ (Основной блок выполнения)
-- ==========================================

startNotification()       -- Сначала запускается функция 1
setCharacterSpeed(32)     -- Затем функция 2 (делает персонажа в 2 раза быстрее)
setJumpPower(100)         -- Затем функция 3 (увеличивает прыжок)

