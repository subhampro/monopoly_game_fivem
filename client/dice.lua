function rollDice()
    local dice1 = math.random(1, 6)
    local dice2 = math.random(1, 6)
    local total = dice1 + dice2

    SendNUIMessage({
        type = "diceRoll",
        dice1 = dice1,
        dice2 = dice2,
        total = total
    })

    return total
end
