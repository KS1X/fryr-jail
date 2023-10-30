local QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent("fryr:server:updatetime", function(citizenid, jailtime)
    local oxmysql = exports.oxmysql
    local query = "UPDATE fryr_prison SET jailtime = ? WHERE citizenid = ?"

    oxmysql:execute(query, {jailtime, citizenid}, function(results)
        print("Jailtime for citizenid " .. citizenid .. " updated to " .. jailtime)
    end, function(error)
        print("oxmysql error: " .. error)
    end)
end)


RegisterServerEvent("fryr:server:freeplayer")
AddEventHandler("fryr:server:freeplayer", function(citizenid)

    local oxmysql = exports.oxmysql
    local query = "UPDATE fryr_prison SET jailtime = ? WHERE citizenid = ?"

    oxmysql:execute(query, {0, citizenid}, function(results)
        print("Jailtime for citizenid " .. citizenid .. " updated to 0, player released")
        TriggerClientEvent("fryr:client:FreePlayer", citizenid)
    end, function(error)
        print("oxmysql error: " .. error)
    end)
end)


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(60000) -- Check every min

        local oxmysql = exports.oxmysql
        local query = "SELECT * FROM fryr_prison"

        oxmysql:execute(query, {}, function(results)
            for _, result in ipairs(results) do
                local jailtime = result.jailtime
                local citizenid = result.citizenid
                if jailtime > 0 then
                    jailtime = jailtime - 1
                    if jailtime == 0 then
                        local query = "UPDATE fryr_prison SET jailtime = ? WHERE citizenid = ?"
                        oxmysql:execute(query, {0, citizenid}, function(results)
                            print("Jailtime for citizenid " .. citizenid .. " updated to 0, player has finished their sentence")
                            TriggerClientEvent("fryr:client:UnjailPlayer", citizenid)
                        end, function(error)
                            print("oxmysql error: " .. error)
                        end)
                    else
                        local query = "UPDATE fryr_prison SET jailtime = ? WHERE citizenid = ?"
                        oxmysql:execute(query, {jailtime, citizenid}, function(results)
                            print("Jailtime for citizenid " .. citizenid .. " updated to " .. jailtime)
                        end, function(error)
                            print("oxmysql error: " .. error)
                        end)
                    end
                end
            end
        end, function(error)
            print("oxmysql error: " .. error)
        end)
    end
end)


RegisterServerEvent("fryr:server:releaseplayer")
AddEventHandler("fryr:server:releaseplayer", function(citizenid)
    local oxmysql = exports.oxmysql
    local query = "UPDATE fryr_prison SET jailtime = ? WHERE citizenid = ?"
    oxmysql:execute(query, {0, citizenid}, function(results)
        print("Jailtime for citizenid " .. citizenid .. " updated to 0")
    end, function(error)
        print("oxmysql error: " .. error)
    end)
end)


