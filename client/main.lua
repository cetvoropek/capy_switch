
ESX = exports["es_extended"]:getSharedObject()

RegisterNetEvent('esx:playerLoaded') -- Store the players data
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
	ESX.PlayerLoaded = true
end)

RegisterNetEvent('esx:playerLogout') -- When a player logs out (multicharacter), reset their data
AddEventHandler('esx:playerLogout', function()
	ESX.PlayerLoaded = false
	ESX.PlayerData = {}
end)

-- These two functions can perform the same task
RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

RegisterNetEvent('capy_switch:switchanimation')
AddEventHandler('capy_switch:switchanimation',function()
    
    local playerPed = PlayerPedId()
    local animDict = Config.animDict
    local animName = Config.animName
    local animduration = Config.animduration          --in seconds
    RequestAnimDict(animDict)
        while not HasAnimDictLoaded(animDict) do 
                Citizen.Wait(100)
        end
    if Config.useprogressbar then
                                            --use here proghressbar code
        exports['progressBars']:startUI(animduration*1000, "Enabling Swith in Pistol..")
    end 

    TaskPlayAnim(playerPed, animDict, animName, 4.0, 4.0, animduration*1000, 50, 0, false, false, false)
    print ('aniation should work here')
    Citizen.Wait(animduration*1000)
    ClearPedTasks(playerPed) 
end)
