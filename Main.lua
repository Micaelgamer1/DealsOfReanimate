-- Loop Respawn para Open FE (Krypton)
-- Execute este script DEPOIS de iniciar o Open FE e clicar em "Reanimate" uma vez.

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Função que chama a reanimação do Open FE
local function ReaplicarReanimacao()
    -- Espera o personagem novo carregar completamente
    local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    char:WaitForChild("Humanoid")
    
    -- Espera um pouco para o jogo estabilizar (evita bugs)
    task.wait(1.5)
    
    -- Verifica se o Open FE ainda está carregado na memória
    if getgenv().Configuration and getgenv().OpenFE then
        -- Chama a função Reanimate() que está no escopo do Main.lua
        -- Como o Main.lua usa loadstring, a função fica no ambiente global
        if Reanimate then
            Reanimate()
            print("[LoopRespawn] Reanimação reaplicada com sucesso.")
        else
            warn("[LoopRespawn] Função Reanimate() não encontrada. O Open FE foi fechado?")
        end
    else
        warn("[LoopRespawn] Open FE não parece estar carregado corretamente.")
    end
end

-- Conecta ao evento de respawn
LocalPlayer.CharacterAdded:Connect(function()
    -- Delay para dar tempo do servidor criar o personagem
    task.wait(2)
    ReaplicarReanimacao()
end)

-- Aplica imediatamente no personagem atual (caso você já esteja vivo)
ReaplicarReanimacao()

print("[LoopRespawn] Loop de respawn ativado. Agora você não perde a reanimação ao morrer.")
