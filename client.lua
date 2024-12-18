local allowedWeapons = {}

RegisterNetEvent('weaponRestrictions:setPermission')
AddEventHandler('weaponRestrictions:setPermission', function(weapons)
    allowedWeapons = weapons
end)

Citizen.CreateThread(function()
    TriggerServerEvent('weaponRestrictions:checkPermission')
    
    while true do
        Citizen.Wait(0)
        local ped = PlayerPedId()
        
        for weaponHash, _ in pairs(allowedWeapons) do
            if not HasPedGotWeapon(ped, GetHashKey(weaponHash), false) then
                GiveWeaponToPed(ped, GetHashKey(weaponHash), 0, false, false)
            end
        end
        
        for _, weaponHash in ipairs(GetWeaponArrayFromLoadout()) do
            if not allowedWeapons[weaponHash] then
                RemoveWeaponFromPed(ped, GetHashKey(weaponHash))
                ShowNotification("You don't have permission to use " .. weaponHash)
            end
        end
    end
end)

function ShowNotification(message)
    if Config.NotificationSystem == 1 then
        -- Chat notification
        TriggerEvent('chat:addMessage', {
            color = {255, 0, 0},
            multiline = true,
            args = {"Weapon Restriction", Weapon Restricted!}
        })
    elseif Config.NotificationSystem == 2 then
        -- codem-notification
        TriggerEvent('codem-notification', Weapon Restricted!, Config.NotificationDuration, 'error', {})
    elseif Config.NotificationSystem == 3 then
        -- mythic_notify
        exports['mythic_notify']:DoHudText('error', Weapon Restricted!)
    else
        -- Chat notification
        TriggerEvent('chat:addMessage', {
            color = {255, 0, 0},
            multiline = true,
            args = {"Weapon Restriction", Weapon Restricted!}
        })
    end
end