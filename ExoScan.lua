// ======= Copyright (c) 2003-2012, Unknown Worlds Entertainment, Inc. All rights reserved. =====
//
// lua\ExoScan.lua
//
//    Created by:   Andreas Urwalek (a_urwa@sbox.tugraz.at)
//
// A Commander ability that gives LOS to marine team for a short time.
//
// ========= For more information, visit us at http://www.unknownworlds.com =====================

Script.Load("lua/Weapons/Weapon.lua")
Script.Load("lua/MapBlipMixin.lua")


class 'ExoScan' (Entity)

ExoScan.kMapName = "exoscan"

ExoScan.kScanEffect = PrecacheAsset("cinematics/marine/observatory/scan.cinematic")
ExoScan.kScanSound = PrecacheAsset("sound/NS2.fev/marine/commander/scan")

local scanConeAngle = math.rad(45)
ExoScan.kScanDistance = 1
local networkVars = { }

function ExoScan:OnCreate()

    Entity.OnCreate(self)
       
    StartSoundEffectOnEntity(ExoScan.kScanSound, self)
    
    
end


function ExoScan:OnScanButton()
	
	self:PerformScan()
end


function ExoScan:PerformScan()

 
	local player = self:GetParent()
	local exoViewAngles = player:GetViewAngles()
	local exoForwardCoords = exoViewAngles:GetCoords()
	local exoForwardVector = exoForwardCoords.zAxis
	local enemyPos = enemy:GetOrigin()
	local exoPos = player:GetViewPosition() 
	local enemyDirectionVector = (enemyPos-exoPos)	     
		enemyDirectionVector:Normalize()
		exoForwardVector.y = 0
		enemyDirectionVector.y = 0	
	 
	local owner = self:GetParent()
	local enemies = GetEntitiesWithMixinForTeamWithinRange("LOS", GetEnemyTeamNumber(owner:GetTeamNumber()), self:GetOrigin(), Scan.kScanDistance)
	
	for _, enemy in ipairs(enemies)  do
	
		enemy:SetIsSighted(true)
		
		// Allow entities to respond
		if enemy.OnScan then
		   enemy:OnScan()
		end
		
		if HasMixin(enemy, "Detectable") then
			enemy:SetDetected(true)
		end
		
	end
	
         
 end


    

    


Shared.LinkClassToMap("ExoScan", ExoScan.kMapName, networkVars)
