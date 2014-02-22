Script.Load("lua/Weapons/Marine/Minigun.lua")
Script.Load("lua/Weapons/Marine/Railgun.lua")
Script.Load("lua/Weapons/Marine/Claw.lua")
Script.Load("lua/Weapons/Marine/ExoWelder.lua")
Script.Load("lua/Weapons/Marine/ExoFlamer.lua")
Script.Load("lua/Weapons/Marine/ExoScanner.lua")
Script.Load("lua/Weapons/Marine/ExoShield.lua")
Script.Load("lua/Exo.lua")
Script.Load("lua/Mixins/JumpMoveMixin.lua")

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
        powerSupply = 15,
        resourceCost = 20,
    },
    [kExoModuleTypes.Power2] = {
        label = "EXO_POWER_2", tooltip = "EXO_POWER_2_TOOLTIP",
        category = kExoModuleCategories.PowerSupply,
        powerSupply = 20,
        resourceCost = 30,
    },
    [kExoModuleTypes.Power3] = {
        label = "EXO_POWER_3", tooltip = "EXO_POWER_3_TOOLTIP",
        category = kExoModuleCategories.PowerSupply,
        powerSupply = 25,
        resourceCost = 40,
    },
    [kExoModuleTypes.Power4] = {
        label = "EXO_POWER_4", tooltip = "EXO_POWER_4_TOOLTIP",
        category = kExoModuleCategories.PowerSupply,
        powerSupply = 30,
        resourceCost = 50,
    },
    [kExoModuleTypes.Power5] = {
        label = "EXO_POWER_5", tooltip = "EXO_POWER_5_TOOLTIP",
        category = kExoModuleCategories.PowerSupply,
        powerSupply = 40,
        resourceCost = 60,
    },

	[kExoModuleTypes.Power6] = {
        label = "EXO_POWER_6", tooltip = "EXO_POWER_6_TOOLTIP",
        category = kExoModuleCategories.PowerSupply,
        powerSupply = 50,
        resourceCost = 70,
    },
   
	[kExoModuleTypes.Claw] = {
        label = "Claw", tooltip = "EXO_WEAPON_CLAW_TOOLTIP",
        category = kExoModuleCategories.Weapon,
        powerCost = 5,
        mapName = Claw.kMapName,
        armType = kExoArmTypes.Claw,

    },
     [kExoModuleTypes.Welder] = {
        label = "Welder", tooltip = "EXO_WEAPON_WELDER_TOOLTIP",
        category = kExoModuleCategories.Weapon,
        powerCost = 15,
        mapName = ExoWelder.kMapName,
        armType = kExoArmTypes.Railgun,

    }, 
    [kExoModuleTypes.Shield] = {
        label = "Shield", tooltip = "EXO_WEAPON_SHIELD_TOOLTIP",
        category = kExoModuleCategories.Weapon,
        powerCost = 15,
        mapName = ExoShield.kMapName,
        armType = kExoArmTypes.Claw,
    },     
	[kExoModuleTypes.Minigun] = {
        label = "Minigun", tooltip = "EXO_WEAPON_MMINIGUN_TOOLTIP",
        category = kExoModuleCategories.Weapon,
        powerCost = 15,
        mapName = Minigun.kMapName,
        armType = kExoArmTypes.Minigun,
    }, 
	[kExoModuleTypes.Railgun] = {
        label = "Railgun", tooltip = "EXO_WEAPON_RAILGUN_TOOLTIP",
        category = kExoModuleCategories.Weapon,
        powerCost = 15,
        mapName = Railgun.kMapName,
        armType = kExoArmTypes.Railgun,
    },
    [kExoModuleTypes.Flamethrower] = {
        label = "Flamethrower", tooltip = "EXO_WEAPON_FLAMETHROWER_TOOLTIP",
        category = kExoModuleCategories.Weapon,
        powerCost = 15,
        mapName = ExoFlamer.kMapName,
        armType = kExoArmTypes.Railgun,
    },


    [kExoModuleTypes.Armor1] = {
        label = "EXO_ARMOR_1", tooltip = "EXO_ARMOR_1_TOOLTIP",
        category = kExoModuleCategories.Armor,
        powerCost = 3,
        armorBonus = 100,
    },
    [kExoModuleTypes.Armor2] = {
        label = "EXO_ARMOR_2", tooltip = "EXO_ARMOR_2_TOOLTIP",
        category = kExoModuleCategories.Armor,
        powerCost = 3,
        armorBonus = 100,
    },
	[kExoModuleTypes.Armor3] = {
        label = "EXO_ARMOR_3", tooltip = "EXO_ARMOR_3_TOOLTIP",
        category = kExoModuleCategories.Armor,
        powerCost = 3,
        armorBonus = 100,
    },
    [kExoModuleTypes.Damage1] = {
        label = "EXO_DAMAGE_1", tooltip = "EXO_DAMAGE_1_TOOLTIP",
        category = kExoModuleCategories.Damage,
        powerCost = 3,
        damageScale = 1.1,
    },
	[kExoModuleTypes.Damage2] = {
        label = "EXO_DAMAGE_2", tooltip = "EXO_DAMAGE_2_TOOLTIP",
        category = kExoModuleCategories.Damage,
        powerCost = 3,
        damageScale = 1.1,
    },
	[kExoModuleTypes.Damage3] = {
        label = "EXO_DAMAGE_3", tooltip = "EXO_DAMAGE_3_TOOLTIP",
        category = kExoModuleCategories.Damage,
        powerCost = 3,
        damageScale = 1.1,
    },
    [kExoModuleTypes.Scanner] = {
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
            worldAnimGraph  = "models/marine/exosuit/exosuit_mm.animation_graph",
            viewModel  = "models/marine/exosuit/exosuit_mm_view.model",
			viewAnimGraph = "models/marine/exosuit/exosuit_mm_view.animation_graph",
        },
        [kExoArmTypes.Claw] = {
            worldModel = "models/marine/exosuit/exosuit_cm.model",
            worldAnimGraph  = "models/marine/exosuit/exosuit_cm.animation_graph",
            viewModel  = "models/marine/exosuit/exosuit_cm_view.model",
			viewAnimGraph   = "models/marine/exosuit/exosuit_cm_view.animation_graph",
        },
    },
    [kExoArmTypes.Railgun] = {
        [kExoArmTypes.Railgun] = {
		    worldModel = "models/marine/exosuit/exosuit_rr.model",
            worldAnimGraph  = "models/marine/exosuit/exosuit_rr.animation_graph",
            viewModel  = "models/marine/exosuit/exosuit_rr_view.model",
			viewAnimGraph   = "models/marine/exosuit/exosuit_rr_view.animation_graph",

        },
        [kExoArmTypes.Claw] = {
            worldModel = "models/marine/exosuit/exosuit_cr.model",
            worldAnimGraph  = "models/marine/exosuit/exosuit_cr.animation_graph",
            viewModel  = "models/marine/exosuit/exosuit_cr_view.model",
			viewAnimGraph   = "models/marine/exosuit/exosuit_cr_view.animation_graph",

        },
    },
    [kExoArmTypes.Claw] = {
        [kExoArmTypes.Claw] = {
           // Sewlek's model stuff
        },
    },
}

local networkVars = {

	rightArmModuleType = "enum kExoModuleTypes",
	leftArmModuleType = "enum kExoModuleTypes",
	hasThrusters = "boolean",
    armorBonus = "float (0 to 2045 by 1)",
}

AddMixinNetworkVars(JumpMoveMixin, networkVars)

local orig_Exo_OnCreate = Exo.OnCreate
function Exo:OnCreate()
	
	orig_Exo_OnCreate(self)
    
    InitMixin(self, JumpMoveMixin)

	self.rightArmModuleType = kExoModuleTypes.Minigun
	self.leftArmModuleType = kExoModuleTypes.Minigun
	self.hasThrusters = false

end

local orig_Exo_GetCanJump = Exo.GetCanJump 
function Exo:GetCanJump()
    
	return not self.hasThrusters

end

local orig_Exo_GetIsThrusterAllowed = Exo.GetIsThrusterAllowed
function Exo:GetIsThrusterAllowed()

	if not self.hasThrusters then
		return false
	end

	return orig_Exo_GetIsThrusterAllowed(self)
end

local orig_Exo_GetArmorAmount = Exo.GetArmorAmount 
function Exo:GetArmorAmount()
	return 1000 //kExosuitArmor + self.armorBonus
end

local orig_Exo_InitExoModel = Exo.InitExoModel
function Exo:InitExoModel()
	
    local leftArmType = kExoModuleTypesData[self.leftArmModuleType].armType
    local rightArmType = kExoModuleTypes[self.rightArmModuleType].armType
    local modelInfo = kExoWeaponRightLeftComboModels[rightArmType][leftArmType]
    local modelName = modelInfo.worldModel
    local graphName = modelInfo.worldAnimGraph
    self:SetModel(modelName, graphName)
    self.viewModelName = modelData.viewModel
    self.viewModelGraphName = modelData.viewAnimGraph


end

local orig_Exo_InitWeapons = Exo.InitWeapons
function Exo:InitWeapons()

    Player.InitWeapons(self)
    
    local weaponHolder = self:GetWeapon(ExoWeaponHolder.kMapName)
    
    if not weaponHolder then
        weaponHolder = self:GiveItem(ExoWeaponHolder.kMapName, false)   
    end    
    
    local leftArmModuleTypeData = kExoModuleTypesData[self.leftArmModuleType]
    local rightArmModuleTypeData = kExoModuleTypesData[self.rightArmModuleType]

    
    Print("Warning: incorrect layout set for exosuit")
    weaponHolder:SetWeapons(leftArmModuleTypeData.kMapName, rightArmModuleTypeData.kMapName)
        
   
    
    weaponHolder:TriggerEffects("exo_login")
    self.inventoryWeight = weaponHolder:GetInventoryWeight(self)
    self:SetActiveWeapon(ExoWeaponHolder.kMapName)
    StartSoundEffectForPlayer(kDeploy2DSound, self)


Class_Reload("Exo", networkVars)

local orig_ExoWeaponHolder_GetViewModelName = ExoWeaponHolder.GetViewModelName
function ExoWeaponHolder:GetViewModelName()

    local player = self:GetParent()
    
    return player.viewModelName
    
end

local orig_ExoWeaponHolder_GetAnimationGraphName = ExoWeaponHolder.GetAnimationGraphName
function ExoWeaponHolder:GetAnimationGraphName()

    local player = self:GetParent()

    return player.viewModelGraphName

end

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
