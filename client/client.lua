local playerData = {}

local isUIOpen = false

function openMonopolyUI()
    SetNuiFocus(true, true)
    SendNUIMessage({ action = "openUI" })
    isUIOpen = true
end

function closeMonopolyUI()
    SetNuiFocus(false, false)
    SendNUIMessage({ action = "closeUI" })
    isUIOpen = false
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if IsControlJustReleased(0, 288) then
            if isUIOpen then
                closeMonopolyUI()
            else
                openMonopolyUI()
            end
        end
    end
end)

RegisterNUICallback('close', function(data, cb)
    closeMonopolyUI()
    cb('ok')
end)

RegisterNUICallback('rollDice', function(data, cb)
    local diceRoll = math.random(1, 6)
    print("Dice Rolled: " .. diceRoll)
    cb({ result = diceRoll })
end)


RegisterNetEvent('monopoly:setupPlayer')
AddEventHandler('monopoly:setupPlayer', function(data)
    playerData = data
    SendNUIMessage({
        type = "setupPlayer",
        data = playerData
    })
end)

RegisterNetEvent('monopoly:movePlayer')
AddEventHandler('monopoly:movePlayer', function(position, dice1, dice2)
    playerData.position = position
    SendNUIMessage({
        type = "movePlayer",
        position = position,
        dice1 = dice1,
        dice2 = dice2
    })
end)

RegisterNetEvent('monopoly:updateMoney')
AddEventHandler('monopoly:updateMoney', function(money)
    playerData.money = money
    SendNUIMessage({
        type = "updateMoney",
        money = money
    })
end)

RegisterNetEvent('monopoly:buyProperty')
AddEventHandler('monopoly:buyProperty', function(propertyId, propertyPrice)
    TriggerServerEvent('monopoly:buyProperty', propertyId, propertyPrice)
end)
