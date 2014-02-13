kExoModuleCategories = enum{
    "PowerSupply",
    "Weapon",
    "Armor",
    "Damage",
    "Utility",
}
kExoModuleSlots = enum{
    "PowerSupply",
    "RightArm",
    "LeftArm",
    "Armor",
    "Damage",
    "Utility",
}
kExoModuleSlotsData = {
    [kExoModuleSlots.PowerSupply] = {
        label = "EXO_MODULESLOT_POWERSUPPLY", 
        category = kExoModuleCategories.PowerSupply,
        required = true,
    },
    [kExoModuleSlots.LeftArm] = {
        label = "EXO_MODULESLOT_LEFT_ARM",
        category = kExoModuleCategories.Weapon,
        required = true,
    },
    [kExoModuleSlots.RightArm] = {
        label = "EXO_MODULESLOT_RIGHT_ARM",
        category = kExoModuleCategories.Weapon,
        required = true,
    },
    [kExoModuleSlots.Armor] = {
        label = "EXO_MODULESLOT_ARMOR",
        category = kExoModuleCategories.Armor,
        required = false,
    },
    [kExoModuleSlots.Damage] = {
        label = "EXO_MODULESLOT_DAMAGE",
        category = kExoModuleCategories.Damage,
        required = false,
    },
    [kExoModuleSlots.Utility] = {
        label = "EXO_MODULESLOT_UTILITY", 
        category = kExoModuleCategories.Utility,
        required = false,
    },
}

kExoModuleTypes = enum{
    "Power1",
    "Power2",
    "Power3",
    "Power4",
    "Power5",
    "Power6",
    "Claw",
    "Minigun",
    "Railgun",
    "Welder",
    "Flamethrower",
    "Shield",
    "Armor1",
    "Armor2",
    "Armor3",
    "Damage1",
    "Damage2",
    "Damage3",
    "Scanner",
   
}

kExoArmTypes = enum{
    "Claw",
    "Minigun",
    "Railgun",
}

kExoModuleTypesData = {
    [kExoModuleTypes.Power1] = {
        label = "EXO_POWER_1", tooltip = "EXO_POWER_1_TOOLTIP",
        category = kExoModuleCategories.PowerSupply,
        powerSupply = 20,
        resourceCost = 20,
    },
    [kExoModuleTypes.Power2] = {
        label = "EXO_POWER_2", tooltip = "EXO_POWER_2_TOOLTIP",
        category = kExoModuleCategories.PowerSupply,
        powerSupply = 20,
        resourceCost = 20,
    },
    [kExoModuleTypes.Power3] = {
        label = "EXO_POWER_3", tooltip = "EXO_POWER_3_TOOLTIP",
        category = kExoModuleCategories.PowerSupply,
        powerSupply = 20,
        resourceCost = 20,
    },
    [kExoModuleTypes.Power4] = {
        label = "EXO_POWER_4", tooltip = "EXO_POWER_4_TOOLTIP",
        category = kExoModuleCategories.PowerSupply,
        powerSupply = 20,
        resourceCost = 20,
    },
    [kExoModuleTypes.Power5] = {
        label = "EXO_POWER_5", tooltip = "EXO_POWER_5_TOOLTIP",
        category = kExoModuleCategories.PowerSupply,
        powerSupply = 20,
        resourceCost = 20,
    },
     [kExoModuleTypes.Minigun] = {
        label = "EXO_WEAPON_MINIGUN", tooltip = "EXO_WEAPON_MMINIGUN_TOOLTIP",
        category = kExoModuleCategories.Weapon,
        powerCost = 15,
        mapName = Minigun.kMapName,
    },
	[kExoModuleTypes.Power6] = {
        label = "EXO_POWER_6", tooltip = "EXO_POWER_6_TOOLTIP",
        category = kExoModuleCategories.PowerSupply,
        powerSupply = 20,
        resourceCost = 20,
    },
   
	[kExoModuleTypes.Claw] = {
        label = "EXO_WEAPON_CLAW", tooltip = "EXO_WEAPON_CLAW_TOOLTIP",
        category = kExoModuleCategories.Weapon,
        powerCost = 5,
        mapName = Claw.kMapName,
    },
    [kExoModuleTypes.Railgun] = {
        label = "EXO_WEAPON_RAILGUN", tooltip = "EXO_WEAPON_RAILGUN_TOOLTIP",
        category = kExoModuleCategories.Weapon,
        powerCost = 15,
    },
    [kExoModuleTypes.Flamethrower] = {
        label = "EXO_WEAPON_FLAMETHROWER", tooltip = "EXO_WEAPON_FLAMETHROWER_TOOLTIP",
        category = kExoModuleCategories.Weapon,
        powerCost = 15,
    },
    [kExoModuleTypes.Welder] = {
        label = "EXO_WEAPON_WELDER", tooltip = "EXO_WEAPON_WELDER_TOOLTIP",
        category = kExoModuleCategories.Weapon,
        powerCost = 15,
    },
    [kExoModuleTypes.Shield] = {
        label = "EXO_WEAPON_SHIELD", tooltip = "EXO_WEAPON_SHIELD_TOOLTIP",
        category = kExoModuleCategories.Weapon,
        powerCost = 15,
        armType = kExoArmTypes.Claw,
    },
    [kExoModulesTypes.Armor1] = {
        label = "EXO_ARMOR_1", tooltip = "EXO_ARMOR_1_TOOLTIP",
        category = kExoModuleCategories.Armor,
        powerCost = 3,
        armorBonus = 100,
    },
    [kExoModulesTypes.Armor2] = {
        label = "EXO_ARMOR_2", tooltip = "EXO_ARMOR_2_TOOLTIP",
        category = kExoModuleCategories.Armor,
        powerCost = 3,
        armorBonus = 100,
    },
	[kExoModulesTypes.Armor3] = {
        label = "EXO_ARMOR_3", tooltip = "EXO_ARMOR_3_TOOLTIP",
        category = kExoModuleCategories.Armor,
        powerCost = 3,
        armorBonus = 100,
    },
    [kExoModulesTypes.Damage1] = {
        label = "EXO_DAMAGE_1", tooltip = "EXO_DAMAGE_1_TOOLTIP",
        category = kExoModuleCategories.Damage,
        powerCost = 3,
        damageScale = 1.1,
    },
	[kExoModulesTypes.Damage2] = {
        label = "EXO_DAMAGE_2", tooltip = "EXO_DAMAGE_2_TOOLTIP",
        category = kExoModuleCategories.Damage,
        powerCost = 3,
        damageScale = 1.1,
    },
	[kExoModulesTypes.Damage3] = {
        label = "EXO_DAMAGE_3", tooltip = "EXO_DAMAGE_3_TOOLTIP",
        category = kExoModuleCategories.Damage,
        powerCost = 3,
        damageScale = 1.1,
    },
    [kExoModulesTypes.Scanner] = {
        label = "EXO_UTILITY_SCANNER", tooltip = "EXO_UTILITY_SCANNER_TOOLTIP",
        category = kExoModuleCategories.Utility,
        powerCost = 20,
        mapName = ExoScanner.kMapName,
    },
}

kExoWeaponRightLeftComboModels = {
    [kExoArmTypes.Minigun] = {
        [kExoArmTypes.Minigun] = {
            worldModel = "models/marine/exosuit/exosuit_mm.model",
            animGraph  = "models/marine/exosuit/exosuit_mm.animation_graph",
          //  viewModel  = not sure..,
        },
        [kExoArmTypes.Claw] = {
           // worldModel = etc
            //animGraph  = etc
            //viewModel  = etc,
        },
    },
    [kExoArmTypes.Railgun] = {
        [kExoArmTypes.Railgun] = {
		   // worldModel = etc
           // animGraph  = etc
           // viewModel  = etc,
        },
        [kExoArmTypes.Claw] = {
		   // worldModel = etc
           // animGraph  = etc
           // viewModel  = etc,
        },
    },
    [kExoArmTypes.Claw] = {
        [kExoArmTypes.Claw] = {
           // Sewlek's model stuff
        },
    },
}


/*local exoConfig = {
    [kExoModuleSlots.PowerSupply] = kExoModuleTypes.Power1,
    [kExoModuleSlots.RightArm   ] = kExoModuleTypes.Minigun,
    [kExoModuleSlots.LeftArm    ] = kExoModuleTypes.Claw,
    [kExoModuleslots.Armor      ] = kExoModuleTypes.Armor1,
    --[kExoModuleslots.Damage     ] = kExoModuleTypes.Damage1,
    [kExoModuleslots.Utility    ] = kExoModuleTypes.Scanner,
}
*/

function Exo_Modular_GetIsConfigValid(config)
    local powerCost = 0
    local powerSupply = nil -- We don't know yet
    local leftArmType = nil
    local rightArmType = nil
    for slotType, slotTypeData in pairs(kExoModuleSlotsData) do
        local moduleType = config[slotType]
        if moduleType == nil then
            if slotTypeData.required then
                -- The config MUST give a module type for this slot type
                return false -- not a valid config
            else
                -- This slot type is optional, so it's OK to leave it out
            end
        else
            -- The config has module type for this slot type
            local moduleTypeData = kExoModuleTypesData[moduleType]
            if moduleTypeData.category ~= slotTypeData.category then
                -- They have provided the wrong category of module type for this slot type
                -- For example, an armor module in a weapon slot
                return false -- not a valid config
            end
            -- Here, we can safely assume that the type is right (else the above would have returned)
            if moduleTypeData.powerCost then
                -- This module type uses power
                powerCost = powerCost+moduleTypeData.powerCost
            elseif moduleTypeData.powerSupply then
                -- This module type supplies power
                if powerSupply ~= nil then
                    -- We've already seen a module that supplies power!
                    return false 
                else
                    -- We know our power supply!
                    powerSupply = moduleTypeData.powerSupply
                end
            end
            if slotType == kExoModuleSlots.LeftArm then
                leftArmType = moduleTypeData.armType
            elseif slotType == kExoModuleSlots.RightArm then
                rightArmType = moduleTypeData.armType
            end
        end
    end
    -- Ok, we've iterated over certain module types and it seems OK
    if powerCost > powerSupply then
        -- This config uses more power than the supply can handle!
        return false
    end
    local exoTexturePath = nil
    local modelDataForRightArmType = kExoWeaponRightLeftComboModels[rightArmType]
    if modelDataForRightArmType == nil then
        -- This means we don't have model data for the situation where the arm type is on the right
        -- Which means, this isn't a valid config! (e.g: claw selected for right arm)
        return false
    else
        local modelData = modelDataForRightArmType[leftArmType]
        if modelData == nil then
            -- The left arm type is not supported for the given right arm type
            return false
        else
            -- This combo of right and left arm types is supported!
            exoTexturePath = modelData.imageTexturePath
        end
    end
    -- This config is valid
    -- Return true, to indicate that
    -- Also return the power supply and power cost, in case the GUI needs those values
    -- Also return the image texture path, in case the GUI needs that!
    return true, powerSupply, powerCost, exoTexturePath
end
