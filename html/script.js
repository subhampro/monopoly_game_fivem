window.addEventListener('message', function(event) {
    const data = event.data;

    if (data.type === 'setupPlayer') {
        document.getElementById('money').textContent = `Money: $${data.data.money}`;
        document.getElementById('position').textContent = `Position: ${data.data.position}`;
    } else if (data.type === 'movePlayer') {
        document.getElementById('position').textContent = `Position: ${data.position}`;
        document.getElementById('dice1').textContent = data.dice1;
        document.getElementById('dice2').textContent = data.dice2;
    } else if (data.type === 'updateMoney') {
        document.getElementById('money').textContent = `Money: $${data.money}`;
    }
});

document.getElementById('rollDice').addEventListener('click', function() {
    fetch(`https://${GetParentResourceName()}/rollDice`, {
        method: 'POST',
        body: JSON.stringify({})
    });
});

document.getElementById('closeBtn').addEventListener('click', function() {
    fetch(`https://monopoly/close`, { method: 'POST' })
        .then(resp => console.log("Closed"))
        .catch(err => console.error("Error:", err));
});
document.getElementById('rollDiceBtn').addEventListener('click', function() {
    fetch(`https://monopoly/rollDice`, { method: 'POST' })
        .then(resp => console.log("Dice rolled"))
        .catch(err => console.error("Error:", err));
});