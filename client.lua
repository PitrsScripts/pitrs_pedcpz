local function giveItem(item)
    TriggerServerEvent('giveItemToPlayer', item)
end

local function openContextMenu()
    lib.registerContext({
        id = 'npc_interaction',
        title = 'NPC Interaction',
        options = {
            {
                title = 'Get Food',
                description = 'Take something to eat',
                icon = 'fas fa-bread-slice',
                onSelect = function()
                    giveItem(Config.FoodItem)
                end
            },
            {
                title = 'Get Drink',
                description = 'Take something to drink',
                icon = 'fas fa-glass-water',
                onSelect = function()
                    giveItem(Config.DrinkItem)
                end
            }
        }
    })
    lib.showContext('npc_interaction')
end


Citizen.CreateThread(function()
    local npcModel = GetHashKey(Config.NPCModel)
    RequestModel(npcModel)
    while not HasModelLoaded(npcModel) do
        Wait(500)
    end

    for _, pos in ipairs(Config.NPCPositions) do
        local npcPed = CreatePed(0, npcModel, pos.x, pos.y, pos.z, pos.heading, false, true)
        FreezeEntityPosition(npcPed, true)
        SetEntityAsMissionEntity(npcPed, true, false)
        SetBlockingOfNonTemporaryEvents(npcPed, true)


        exports.ox_target:addLocalEntity(npcPed, {
            {
                name = 'npc_interact',
                icon = 'fas fa-handshake',
                label = 'Interaction',
                onSelect = function()
                    openContextMenu()
                end
            }
        })
    end
end)
