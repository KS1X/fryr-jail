local QBCore = exports['qb-core']:GetCoreObject()

RegisterCommand('jailplayer', function(source, args)
    local serverId = tonumber(args[1])
    local jailTime = tonumber(args[2])
    local citizenid = QBCore.Functions.GetPlayerData().citizenid
    print(citizenid)
    if serverId and jailTime then
        TriggerServerEvent("fryr:server:updatetime", citizenid, jailTime)
        QBCore.Functions.Notify('Player with server id '..serverId..' has been jailed for '..jailTime..' miniutes', 'error', 10000)
        local coords = PlayerPedId()
        SetEntityCoords(coords, 1763.88, 2550.55, 45.56, false, false, false, false)
    else
        QBCore.Functions.Notify('Invalid arguments. Usage: /jail [server id] [jail time in seconds]', 'error', 10000)
    end
end, false)


RegisterCommand('unjail', function(source, args)
    local serverId = tonumber(args[1])
    local citizenid = QBCore.Functions.GetPlayerData().citizenid
    if serverId then
        TriggerServerEvent("fryr:server:updatetime", citizenid, 0)
        QBCore.Functions.Notify('Player with server id '..serverId..' has been released early', 'error', 10000)
        print("Player with Citizenid " .. citizenid .. " Has been updated to 0, player released")
        local coords = PlayerPedId()
        SetEntityCoords(coords, 1850.34, 2585.95, 45.67, false, false, false, false)
    else
        QBCore.Functions.Notify('Invalid arguments. Usage: /unjail [server id]', 'error', 10000)
    end
end, false)


RegisterNetEvent("fryr:client:FreePlayer")
AddEventHandler("fryr:client:FreePlayer", function(citizenid)

    citizenid = QBCore.Functions.GetPlayerData().citizenid
    local playerCitizenid = citizenid
    -- check if the player's citizenid matches the citizenid from the server event
    if playerCitizenid == citizenid then
        -- notify the player that they have been released from jail
        QBCore.Functions.Notify('You have been released from jail', 'error', 10000)
        -- teleport the player to the jail exit
        local coords = PlayerPedId()
        SetEntityCoords(coords, 1850.34, 2585.95, 45.67, false, false, false, false)
    end
end)


