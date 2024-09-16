local players = {}

function registerPlayer(playerId)
    players[playerId] = {
        position = 1,
        money = Config.StartingMoney,
        properties = {},
        inJail = false
    }
    print("Player " .. playerId .. " registered with $" .. Config.StartingMoney)
    TriggerClientEvent('monopoly:setupPlayer', playerId, players[playerId])
end

function rollDice(playerId)
    local dice1 = math.random(1, 6)
    local dice2 = math.random(1, 6)
    local total = dice1 + dice2

    players[playerId].position = (players[playerId].position + total) % 40
    TriggerClientEvent('monopoly:movePlayer', playerId, players[playerId].position, dice1, dice2)
end

function buyProperty(playerId, propertyId, propertyPrice)
    local player = players[playerId]
    if player.money >= propertyPrice then
        player.money = player.money - propertyPrice
        table.insert(player.properties, propertyId)
        print("Player " .. playerId .. " bought property " .. propertyId)
        TriggerClientEvent('monopoly:updateMoney', playerId, player.money)
    else
        print("Player " .. playerId .. " does not have enough money to buy.")
    end
end

RegisterCommand('startMonopoly', function(source)
    local playerId = source
    registerPlayer(playerId)
    TriggerClientEvent('monopoly:startGame', -1)
end)

RegisterCommand('rollDice', function(source)
    local playerId = source
    rollDice(playerId)
end)

RegisterCommand('buyProperty', function(source, args)
    local playerId = source
    local propertyId = tonumber(args[1])
    local propertyPrice = tonumber(args[2])
    buyProperty(playerId, propertyId, propertyPrice)
end)
