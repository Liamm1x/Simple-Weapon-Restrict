Config = {}

Config.UseInheritance = true

Config.WeaponGroups = {
    ["Member"] = {
        roleId = "123456789", -- Discord Role ID
        weapons = {"WEAPON_PISTOL", "WEAPON_BAT", "WEAPON_KNIFE"}
    },
    ["LEO"] = {
        roleId = "123456789",
        weapons = {"WEAPON_COMBATPISTOL", "WEAPON_STUNGUN", "WEAPON_NIGHTSTICK"}
    },
}

-- Notification System Selection
-- 1 = Chat
-- 2 = codem-notification
-- 3 = mythic_notify
Config.NotificationSystem = 1

Config.NotificationDuration = 5000 -- Duration of the notification in milliseconds

-- Inheritance
Config.Inheritance = {
    ["LEO"] = {"Member"},
    ["Owner"] = {"Co-Owner", "LEO"} -- Just an example
}