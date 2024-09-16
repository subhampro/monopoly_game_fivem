RegisterNUICallback('rollDice', function(data)
    local total = rollDice()
    SendNUIMessage({
        type = 'updatePlayerPosition',
        total = total
    })
end)
