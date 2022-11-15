ESX = exports["es_extended"]:getSharedObject()

ESX.RegisterUsableItem(Config.switchItem, function(source)
    local inventory = Config.inventory
    local xPlayer = ESX.GetPlayerFromId(source)
    local weadurability = 0.0
    local weaslot = nil
    local hassingle = nil
    
    
    if inventory == 'default' then
        if xPlayer.getWeapon('WEAPON_COMBATPISTOL') then
            xPlayer.removeWeapon('WEAPON_COMBATPISTOL')
            hassingle = true
        end
    elseif inventory == 'ox_inventory' then
      
           local currentweapon =  exports.ox_inventory:GetCurrentWeapon(xPlayer.source)
            if currentweapon and currentweapon.name == 'WEAPON_COMBATPISTOL' then
                
                weadurability = currentweapon.metadata.durability
                weaslot = currentweapon.slot
                exports.ox_inventory:RemoveItem(xPlayer.source, 'WEAPON_COMBATPISTOL', 1, false, currentweapon.slot)
                xPlayer.removeInventoryItem(Config.switchItem, 1)               
                hassingle = true
            end     
        else
            xPlayer.showNotification('Please Select a Valid Inventory System in Config.')
        end

        if hassingle then
            xPlayer.triggerEvent('capy_switch:switchanimation',source)
            Citizen.Wait(Config.animduration*1000)
            giveweapon(source,'WEAPON_APPISTOL',weaslot,weadurability)
        else
            xPlayer.showNotification('You need Combat Pistol in Hand to use this item.')
        end

end)

--unswitch command
RegisterCommand(Config.unswitchcommand,function (source)
    local inventory = Config.inventory
    local xPlayer = ESX.GetPlayerFromId(source)
    local weadurability = 0.0
    local weaslot = nil
    local hassingle = nil

        if inventory == 'default' then
            if xPlayer.getWeapon('WEAPON_APPISTOL') then
                xPlayer.removeWeapon('WEAPON_APPISTOL')
                hassingle = true
            end
        elseif inventory == 'ox_inventory' then
           local currentweapon =  exports.ox_inventory:GetCurrentWeapon(xPlayer.source)
            if currentweapon and currentweapon.name == 'WEAPON_APPISTOL' then
                
                weadurability = currentweapon.metadata.durability
                weaslot = currentweapon.slot
                exports.ox_inventory:RemoveItem(xPlayer.source, 'WEAPON_APPISTOL', 1, false, currentweapon.slot)               
                hassingle = true
            end     
        else
            xPlayer.showNotification('Please Select a Valid Inventory System in Config.')
        end

        if hassingle then
            xPlayer.triggerEvent('capy_switch:switchanimation')
            Citizen.Wait(Config.animduration*1000)
            giveweapon(source,'WEAPON_COMBATPISTOL',weaslot,weadurability)
            xPlayer.addInventoryItem(Config.switchItem, 1)                               --give switch 
        else
            xPlayer.showNotification('You need AP PISTOL in Hand to use this command.')
        end
end)


--
function giveweapon(source,weaponName,slot,durability)
    local xPlayer = ESX.GetPlayerFromId(source)
    local inventory = Config.inventory
    if xPlayer then
        if inventory == 'default' then
            xPlayer.addWeapon(weaponName, 0)

        elseif inventory == 'ox_inventory' then
            SetCurrentPedWeapon(GetPlayerPed(source), GetHashKey('WEAPON_UNARMED'), true)       --set weapon unarmed
            exports.ox_inventory:AddItem(xPlayer.source, weaponName, 1, false, slot, false)
            exports.ox_inventory:SetDurability(xPlayer.source, slot, durability)           
        else
            xPlayer.showNotification('Please Select a Valid Inventory System in Config.')
        end
    else
        print('no xPlayer')
    end
end
  

