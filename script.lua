-- Script para Roblox en Lua
-- Funcionalidad:
-- - Auto patear lucky block
-- - Auto hacer fuerza (auto weight) rapidísimo
-- - WalkSpeed máximo
-- - Recoger dinero automáticamente
-- - Botones para activar/desactivar el script
-- - Mostrar nombre del creador

-- CONFIGURACIÓN --
local VELOCIDAD_MAXIMA = 100 -- Velocidad máxima al caminar
local INTERVALO_PATADA = 0.1 -- Tiempo entre cada pateada (segundos)
local INTERVALO_FUERZA = 0.05 -- Intervalo para hacer fuerza rápido
local RECOGER_DISTANCIA = 15 -- Distancia máxima para recoger dinero

-- VARIABLES DE CONTROL
local activo = false
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoide = character:WaitForChild("Humanoid")
local RunService = game:GetService("RunService")

-- GUI --
local ScreenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
ScreenGui.Name = "LuckyBlockScriptGUI"

local frame = Instance.new("Frame", ScreenGui)
frame.Position = UDim2.new(0.7, 0, 0.3, 0)
frame.Size = UDim2.new(0, 220, 0, 200)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.BackgroundTransparency = 0.3
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true

local titulo = Instance.new("TextLabel", frame)
titulo.Text = "Script Lucky Block"
titulo.Size = UDim2.new(1, 0, 0, 30)
titulo.BackgroundTransparency = 1
titulo.TextColor3 = Color3.new(1,1,1)
titulo.Font = Enum.Font.SourceSansBold
titulo.TextSize = 20

local function crearBoton(texto, posicionY)
    local boton = Instance.new("TextButton", frame)
    boton.Text = texto
    boton.Size = UDim2.new(0.9, 0, 0, 35)
    boton.Position = UDim2.new(0.05, 0, 0, posicionY)
    boton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    boton.TextColor3 = Color3.new(1, 1, 1)
    boton.Font = Enum.Font.GothamBold
    boton.TextSize = 18
    boton.AutoButtonColor = true
    return boton
end

local botonActivar = crearBoton("Activar Script", 40)
local botonDesactivar = crearBoton("Desactivar Script", 85)

local labelCreador = Instance.new("TextLabel", frame)
labelCreador.Text = "Creador: JoseAngel_Blox"
labelCreador.Size = UDim2.new(1, 0, 0, 25)
labelCreador.Position = UDim2.new(0, 0, 0, 145)
labelCreador.BackgroundTransparency = 1
labelCreador.TextColor3 = Color3.new(1, 1, 1)
labelCreador.Font = Enum.Font.Gotham
labelCreador.TextSize = 16
labelCreador.TextXAlignment = Enum.TextXAlignment.Center

-- FUNCIONES DEL SCRIPT --

-- Cambia velocidad del jugador
local function ajustarWalkSpeed(valor)
    if humanoide and humanoide.Parent then
        humanoide.WalkSpeed = valor
    end
end

-- Auto patear lucky blocks
local function autoPatear()
    while activo do
        for _, obj in pairs(workspace:GetChildren()) do
            if obj.Name == "LuckyBlock" or obj:FindFirstChild("LuckyBlock") then
                local clickDetector = obj:FindFirstChildOfClass("ClickDetector")
                if clickDetector then
                    clickDetector:FireClick(player)
                else
                    if character and character:FindFirstChild("HumanoidRootPart") then
                        character.HumanoidRootPart.CFrame = obj.CFrame + Vector3.new(0, 3, 0)
                    end
                end
            end
        end
        wait(INTERVALO_PATADA)
    end
end

-- Auto hacer fuerza (auto weight)
local function autoFuerza()
    while activo do
        -- Aquí debes adaptarlo según cómo se haga la fuerza en
