local playerLimits = {}

RegisterNetEvent('giveItemToPlayer')
AddEventHandler('giveItemToPlayer', function(item)
    local playerId = source
    if not playerLimits[playerId] then
        playerLimits[playerId] = { count = 0, resetTime = os.time() + Config.LimitInterval }
    end

    local playerData = playerLimits[playerId]

    if os.time() > playerData.resetTime then
        playerData.count = 0
        playerData.resetTime = os.time() + Config.LimitInterval
    end

    if playerData.count >= Config.ItemLimit then
        TriggerClientEvent('ox_lib:notify', playerId, { title = 'Error', description = 'You have exceeded the item limit, you can get more in 60 seconds!', type = 'error' })
        return
    end

    exports.ox_inventory:AddItem(playerId, item, 1)
    playerData.count = playerData.count + 1
    local itemName
    if item == Config.FoodItem then
        itemName = 'Pretzel'
    elseif item == Config.DrinkItem then
        itemName = 'PepsiCola'
    else
        itemName = item  
    end

    TriggerClientEvent('ox_lib:notify', playerId, { title = 'Success', description = 'You got a ' .. itemName .. '!', type = 'success' })
end)
