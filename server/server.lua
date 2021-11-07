QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)


RegisterServerEvent('lucid-dogsitter:rewardPlayer')
AddEventHandler('lucid-dogsitter:rewardPlayer', function(price)
    local src = source
    local player = QBCore.Functions.GetPlayer(src)
    TriggerClientEvent('QBCore:Notify', src, 'You receive $'.. price.. ' from job', 'primary', 3000)
    player.Functions.AddMoney('cash', price, 'dog job')
end)


