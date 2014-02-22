Script.Load("lua/Weapons/Marine/Minigun.lua")
Script.Load("lua/Weapons/Marine/Railgun.lua")
Script.Load("lua/Weapons/Marine/Claw.lua")
Script.Load("lua/Weapons/Marine/ExoWelder.lua")
Script.Load("lua/Weapons/Marine/ExoFlamer.lua")
Script.Load("lua/Weapons/Marine/ExoScan.lua")
Script.Load("lua/Weapons/Marine/ExoShield.lua")
Script.Load("lua/Exo.lua")
Script.Load("lua/Mixins/JumpMoveMixin.lua")
Script.Load("lua/Exo_ModularData.lua")

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

	self.rightArmModuleType = kExoModuleTypes.Welder
	self.leftArmModuleType = kExoModuleTypes.Welder
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
    local rightArmType = kExoModuleTypesData[self.rightArmModuleType].armType
    local modelData = kExoWeaponRightLeftComboModels[rightArmType][leftArmType]
    local modelName = modelData.worldModel
    local graphName = modelData.worldAnimGraph
    self:SetModel(modelName, graphName)
    self.viewModelName = modelData.viewModel
    self.viewModelGraphName = modelData.viewAnimGraph


end


local kDeploy2DSound = PrecacheAsset("sound/NS2.fev/marine/heavy/deploy_2D")
local orig_Exo_InitWeapons = Exo.InitWeapons
function Exo:InitWeapons()

    Player.InitWeapons(self)
    
    local weaponHolder = self:GetWeapon(ExoWeaponHolder.kMapName)
    
    if not weaponHolder then
        weaponHolder = self:GiveItem(ExoWeaponHolder.kMapName, false)   
    end    
    
    local leftArmModuleTypeData = kExoModuleTypesData[self.leftArmModuleType]
    local rightArmModuleTypeData = kExoModuleTypesData[self.rightArmModuleType]

    
    weaponHolder:SetWeapons(leftArmModuleTypeData.mapName, rightArmModuleTypeData.mapName)
         
    weaponHolder:TriggerEffects("exo_login")
    self.inventoryWeight = weaponHolder:GetInventoryWeight(self)
    self:SetActiveWeapon(ExoWeaponHolder.kMapName)
    StartSoundEffectForPlayer(kDeploy2DSound, self)
    
end

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
