local function getInheritedWeapons(groupName, visited)
    visited = visited or {}
    if visited[groupName] then return {} end
    visited[groupName] = true

    local group = Config.WeaponGroups[groupName]
    if not group then return {} end

    local weapons = {}
    for _, weapon in ipairs(group.weapons) do
        weapons[weapon] = true
    end

    if Config.UseInheritance then
        local inheritedGroups = Config.Inheritance[groupName] or {}
        for _, inheritedGroup in ipairs(inheritedGroups) do
            for weapon, _ in pairs(getInheritedWeapons(inheritedGroup, visited)) do
                weapons[weapon] = true
            end
        end
    end

    return weapons
end

local function getPlayerGroups(source)
    local groups = {}
    local identifiers = GetPlayerIdentifiers(source)
    for _, id in ipairs(identifiers) do
        if string.find(id, "discord:") then
            local discordId = string.sub(id, 9)
            for groupName, groupData in pairs(Config.WeaponGroups) do
                if exports.discord_perms:IsRolePresent(source, groupData.roleId) then
                    table.insert(groups, groupName)
                end
            end
            break
        end
    end
    return groups
end

RegisterNetEvent('weaponRestrictions:checkPermission')
AddEventHandler('weaponRestrictions:checkPermission', function()
    local source = source
    local playerGroups = getPlayerGroups(source)
    local allowedWeapons = {}

    for _, groupName in ipairs(playerGroups) do
        local groupWeapons = getInheritedWeapons(groupName)
        for weapon, _ in pairs(groupWeapons) do
            allowedWeapons[weapon] = true
        end
    end

    TriggerClientEvent('weaponRestrictions:setPermission', source, allowedWeapons)
end)