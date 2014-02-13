// ======= Copyright (c) 2003-2011, Unknown Worlds Entertainment, Inc. All rights reserved. =======
//
// lua\GUIProtoBuyMenu.lua
//
// Created by: Andreas Urwalek (andi@unknownworlds.com)
//
// Manages the marine buy/purchase menu.
//
// ========= For more information, visit us at http://www.unknownworlds.com =====================

Script.Load("lua/GUIAnimatedScript.lua")

class 'GUIProtoBuyMenu' (GUIAnimatedScript)

GUIProtoBuyMenu.kBuyMenuTexture = "ui/marine_buy_textures.dds"
GUIProtoBuyMenu.kBuyHUDTexture = "ui/marine_buy_icons.dds"
GUIProtoBuyMenu.kRepeatingBackground = "ui/menu/grid.dds"
GUIProtoBuyMenu.kContentBgTexture = "ui/menu/repeating_bg.dds"
GUIProtoBuyMenu.kContentBgBackTexture = "ui/menu/repeating_bg_black.dds"
GUIProtoBuyMenu.kResourceIconTexture = "ui/pres_icon_big.dds"
GUIProtoBuyMenu.kBigIconTexture = "ui/marine_buy_bigicons.dds"
GUIProtoBuyMenu.kButtonTexture = "ui/marine_buymenu_button.dds"
GUIProtoBuyMenu.kMenuSelectionTexture = "ui/marine_buymenu_selector.dds"
GUIProtoBuyMenu.kScanLineTexture = "ui/menu/scanLine_big.dds"
GUIProtoBuyMenu.kArrowTexture = "ui/menu/arrow_horiz.dds"

GUIProtoBuyMenu.kFont = "fonts/AgencyFB_small.fnt"
GUIProtoBuyMenu.kFont2 = "fonts/AgencyFB_small.fnt"

GUIProtoBuyMenu.kDescriptionFontName = "fonts/AgencyFB_small.fnt"
GUIProtoBuyMenu.kDescriptionFontSize = GUIScale(20)

GUIProtoBuyMenu.kScanLineHeight = GUIScale(256)
GUIProtoBuyMenu.kScanLineAnimDuration = 5

GUIProtoBuyMenu.kArrowWidth = GUIScale(32)
GUIProtoBuyMenu.kArrowHeight = GUIScale(32)
GUIProtoBuyMenu.kArrowTexCoords = { 1, 1, 0, 0 }

// Big Item Icons
GUIProtoBuyMenu.kBigIconSize = GUIScale( Vector(400, 256, 0) )
GUIProtoBuyMenu.kBigIconOffset = GUIScale(20)

local kEquippedMouseoverColor = Color(1, 1, 1, 1)
local kEquippedColor = Color(0.5, 0.5, 0.5, 0.5)

local gBigIconIndex = nil
local bigIconWidth = 400
local bigIconHeight = 300
local function GetBigIconPixelCoords(techId, researched)

    if not gBigIconIndex then
    
        gBigIconIndex = {}
        gBigIconIndex[kTechId.Axe] = 0
        gBigIconIndex[kTechId.Pistol] = 1
        gBigIconIndex[kTechId.Rifle] = 2
        gBigIconIndex[kTechId.Shotgun] = 3
        gBigIconIndex[kTechId.GrenadeLauncher] = 4
        gBigIconIndex[kTechId.Flamethrower] = 5
        gBigIconIndex[kTechId.Jetpack] = 6
        gBigIconIndex[kTechId.Exosuit] = 7
        gBigIconIndex[kTechId.Welder] = 8
        gBigIconIndex[kTechId.LayMines] = 9
        gBigIconIndex[kTechId.DualMinigunExosuit] = 10
        gBigIconIndex[kTechId.UpgradeToDualMinigun] = 10
        gBigIconIndex[kTechId.ClawRailgunExosuit] = 11
        gBigIconIndex[kTechId.DualRailgunExosuit] = 11
        gBigIconIndex[kTechId.UpgradeToDualRailgun] = 11
        
        gBigIconIndex[kTechId.ClusterGrenade] = 12
        gBigIconIndex[kTechId.GasGrenade] = 13
        gBigIconIndex[kTechId.PulseGrenade] = 14
        
    
    end
    
    local index = gBigIconIndex[techId]
    if not index then
        index = 0
    end
    
    local x1 = 0
    local x2 = bigIconWidth
    
    if not researched then
    
        x1 = bigIconWidth
        x2 = bigIconWidth * 2
        
    end
    
    local y1 = index * bigIconHeight
    local y2 = (index + 1) * bigIconHeight
    
    return x1, y1, x2, y2

end

// Small Item Icons
local kSmallIconScale = 0.9
GUIProtoBuyMenu.kSmallIconSize = GUIScale( Vector(100, 50, 0) )
GUIProtoBuyMenu.kMenuIconSize = GUIScale( Vector(190, 80, 0) ) * kSmallIconScale
GUIProtoBuyMenu.kSelectorSize = GUIScale( Vector(215, 110, 0) ) * kSmallIconScale
GUIProtoBuyMenu.kIconTopOffset = 10
GUIProtoBuyMenu.kItemIconYOffset = {}

GUIProtoBuyMenu.kEquippedIconTopOffset = 58

local smallIconHeight = 64
local smallIconWidth = 128
local gSmallIconIndex = nil
local function GetSmallIconPixelCoordinates(itemTechId)

    if not gSmallIconIndex then
    
        gSmallIconIndex = {}
        gSmallIconIndex[kTechId.Axe] = 4
        gSmallIconIndex[kTechId.Pistol] = 3
        gSmallIconIndex[kTechId.Rifle] = 1
        gSmallIconIndex[kTechId.Shotgun] = 5
        gSmallIconIndex[kTechId.GrenadeLauncher] = 8
        gSmallIconIndex[kTechId.Flamethrower] = 6
        gSmallIconIndex[kTechId.Jetpack] = 24
        gSmallIconIndex[kTechId.Exosuit] = 26
        gSmallIconIndex[kTechId.Welder] = 10
        gSmallIconIndex[kTechId.LayMines] = 21
        gSmallIconIndex[kTechId.DualMinigunExosuit] = 26
        gSmallIconIndex[kTechId.UpgradeToDualMinigun] = 26
        gSmallIconIndex[kTechId.ClawRailgunExosuit] = 38
        gSmallIconIndex[kTechId.DualRailgunExosuit] = 38
        gSmallIconIndex[kTechId.UpgradeToDualRailgun] = 38
        
        gSmallIconIndex[kTechId.ClusterGrenade] = 42
        gSmallIconIndex[kTechId.GasGrenade] = 43
        gSmallIconIndex[kTechId.PulseGrenade] = 44
    
    end
    
    local index = gSmallIconIndex[itemTechId]
    if not index then
        index = 0
    end
    
    local y1 = index * smallIconHeight
    local y2 = (index + 1) * smallIconHeight
    
    return 0, y1, smallIconWidth, y2

end
                            
GUIProtoBuyMenu.kTextColor = Color(kMarineFontColor)

GUIProtoBuyMenu.kMenuWidth = GUIScale(190)
GUIProtoBuyMenu.kPadding = GUIScale(8)

GUIProtoBuyMenu.kEquippedWidth = GUIScale(128)

GUIProtoBuyMenu.kBackgroundWidth = GUIScale(1000)
GUIProtoBuyMenu.kBackgroundHeight = GUIScale(710)
// We want the background graphic to look centered around the circle even though there is the part coming off to the right.
GUIProtoBuyMenu.kBackgroundXOffset = GUIScale(0)

GUIProtoBuyMenu.kPlayersTextSize = GUIScale(24)
GUIProtoBuyMenu.kResearchTextSize = GUIScale(24)

GUIProtoBuyMenu.kResourceDisplayHeight = GUIScale(64)

GUIProtoBuyMenu.kResourceIconWidth = GUIScale(32)
GUIProtoBuyMenu.kResourceIconHeight = GUIScale(32)

GUIProtoBuyMenu.kMouseOverInfoTextSize = GUIScale(20)
GUIProtoBuyMenu.kMouseOverInfoOffset = Vector(GUIScale(-30), GUIScale(-20), 0)
GUIProtoBuyMenu.kMouseOverInfoResIconOffset = Vector(GUIScale(-40), GUIScale(-60), 0)

GUIProtoBuyMenu.kDisabledColor = Color(0.5, 0.5, 0.5, 0.5)
GUIProtoBuyMenu.kCannotBuyColor = Color(1, 0, 0, 0.5)
GUIProtoBuyMenu.kEnabledColor = Color(1, 1, 1, 1)

GUIProtoBuyMenu.kCloseButtonColor = Color(1, 1, 0, 1)

GUIProtoBuyMenu.kButtonWidth = GUIScale(160)
GUIProtoBuyMenu.kButtonHeight = GUIScale(64)

GUIProtoBuyMenu.kItemNameOffsetX = GUIScale(28)
GUIProtoBuyMenu.kItemNameOffsetY = GUIScale(256)

GUIProtoBuyMenu.kItemDescriptionOffsetY = GUIScale(300)
GUIProtoBuyMenu.kItemDescriptionSize = GUIScale( Vector(450, 180, 0) )

function GUIProtoBuyMenu:SetHostStructure(hostStructure)

    self.hostStructure = hostStructure
    self:_InitializeItemButtons()
    
end

function GUIProtoBuyMenu:OnClose()

    // Check if GUIProtoBuyMenu is what is causing itself to close.
    if not self.closingMenu then
        // Play the close sound since we didn't trigger the close.
        MarineBuy_OnClose()
    end

end

function GUIProtoBuyMenu:Initialize()

    GUIAnimatedScript.Initialize(self)

    self.mouseOverStates = { }
    self.equipped = { }
    
    self.selectedItem = kTechId.None
    
    self:_InitializeBackground()
    self:_InitializeContent()
    self:_InitializeResourceDisplay()
    self:_InitializeCloseButton()
    self:_InitializeEquipped()    
    self:_InitializeConfirmButton()
    self:_InitializeExoButtons()
    // note: items buttons get initialized through SetHostStructure()
    MarineBuy_OnOpen()
    
end

/**
 * Checks if the mouse is over the passed in GUIItem and plays a sound if it has just moved over.
 */
local function GetIsMouseOver(self, overItem)

    local mouseOver = GUIItemContainsPoint(overItem, Client.GetCursorPosScreen())
    if mouseOver and not self.mouseOverStates[overItem] then
        MarineBuy_OnMouseOver()
    end
    self.mouseOverStates[overItem] = mouseOver
    return mouseOver
    
end

local function UpdateEquipped(self, deltaTime)

    self.hoverItem = nil
    for i = 1, #self.equipped do
    
        local equipped = self.equipped[i]
        if GetIsMouseOver(self, equipped.Graphic) then
        
            self.hoverItem = equipped.TechId
            equipped.Graphic:SetColor(kEquippedMouseoverColor)
            
        else
            equipped.Graphic:SetColor(kEquippedColor)
        end
        
    end
    
end

function GUIProtoBuyMenu:Update(deltaTime)

    GUIAnimatedScript.Update(self, deltaTime)

    UpdateEquipped(self, deltaTime)
    self:_UpdateItemButtons(deltaTime)
    self:_UpdateContent(deltaTime)
    self:_UpdateResourceDisplay(deltaTime)
    self:_UpdateCloseButton(deltaTime)
    self:_UpdateConfirmButton(deltaTime)
    self:_UpdateExoButtons()
end

function GUIProtoBuyMenu:Uninitialize()

    GUIAnimatedScript.Uninitialize(self)

    self:_UninitializeItemButtons()
    self:_UninitializeBackground()
    self:_UninitializeContent()
    self:_UninitializeResourceDisplay()
    self:_UninitializeCloseButton()
    self:_UninitializeConfirmButton()
    self:_UninitializeExoButtons()
end

local function MoveDownAnim(script, item)

    item:SetPosition( Vector(0, -GUIProtoBuyMenu.kScanLineHeight, 0) )
    item:SetPosition( Vector(0, Client.GetScreenHeight() + GUIProtoBuyMenu.kScanLineHeight, 0), GUIProtoBuyMenu.kScanLineAnimDuration, "MARINEBUY_SCANLINE", AnimateLinear, MoveDownAnim)

end

function GUIProtoBuyMenu:_InitializeBackground()

    // This invisible background is used for centering only.
    self.background = GUIManager:CreateGraphicItem()
    self.background:SetSize(Vector(Client.GetScreenWidth(), Client.GetScreenHeight(), 0))
    self.background:SetAnchor(GUIItem.Left, GUIItem.Top)
    self.background:SetColor(Color(0.05, 0.05, 0.1, 0.7))
    self.background:SetLayer(kGUILayerPlayerHUDForeground4)
    
    self.repeatingBGTexture = GUIManager:CreateGraphicItem()
    self.repeatingBGTexture:SetSize(Vector(Client.GetScreenWidth(), Client.GetScreenHeight(), 0))
    self.repeatingBGTexture:SetTexture(GUIProtoBuyMenu.kRepeatingBackground)
    self.repeatingBGTexture:SetTexturePixelCoordinates(0, 0, Client.GetScreenWidth(), Client.GetScreenHeight())
    self.background:AddChild(self.repeatingBGTexture)
    
    self.content = GUIManager:CreateGraphicItem()
    self.content:SetSize(Vector(GUIProtoBuyMenu.kBackgroundWidth, GUIProtoBuyMenu.kBackgroundHeight, 0))
    self.content:SetAnchor(GUIItem.Middle, GUIItem.Center)
    self.content:SetPosition(Vector((-GUIProtoBuyMenu.kBackgroundWidth / 2) + GUIProtoBuyMenu.kBackgroundXOffset, -GUIProtoBuyMenu.kBackgroundHeight / 2, 0))
    self.content:SetTexture(GUIProtoBuyMenu.kContentBgTexture)
    self.content:SetTexturePixelCoordinates(0, 0, GUIProtoBuyMenu.kBackgroundWidth, GUIProtoBuyMenu.kBackgroundHeight)
    self.content:SetColor( Color(1,1,1,0.8) )
    self.background:AddChild(self.content)
    
    self.scanLine = self:CreateAnimatedGraphicItem()
    self.scanLine:SetSize( Vector( Client.GetScreenWidth(), GUIProtoBuyMenu.kScanLineHeight, 0) )
    self.scanLine:SetTexture(GUIProtoBuyMenu.kScanLineTexture)
    self.scanLine:SetLayer(kGUILayerPlayerHUDForeground4)
    self.scanLine:SetIsScaling(false)
    
    self.scanLine:SetPosition( Vector(0, -GUIProtoBuyMenu.kScanLineHeight, 0) )
    self.scanLine:SetPosition( Vector(0, Client.GetScreenHeight() + GUIProtoBuyMenu.kScanLineHeight, 0), GUIProtoBuyMenu.kScanLineAnimDuration, "MARINEBUY_SCANLINE", AnimateLinear, MoveDownAnim)

end

function GUIProtoBuyMenu:_UninitializeBackground()

    GUI.DestroyItem(self.background)
    self.background = nil
    
    self.content = nil
    
end

function GUIProtoBuyMenu:_InitializeEquipped()

    self.equippedBg = GetGUIManager():CreateGraphicItem()
    self.equippedBg:SetAnchor(GUIItem.Right, GUIItem.Top)
    self.equippedBg:SetPosition(Vector( GUIProtoBuyMenu.kPadding, -GUIProtoBuyMenu.kResourceDisplayHeight, 0))
    self.equippedBg:SetSize(Vector(GUIProtoBuyMenu.kEquippedWidth, GUIProtoBuyMenu.kBackgroundHeight + GUIProtoBuyMenu.kResourceDisplayHeight, 0))
    self.equippedBg:SetColor(Color(0,0,0,0))
    self.content:AddChild(self.equippedBg)
    
    self.equippedTitle = GetGUIManager():CreateTextItem()
    self.equippedTitle:SetFontName(GUIProtoBuyMenu.kFont)
    self.equippedTitle:SetFontIsBold(true)
    self.equippedTitle:SetAnchor(GUIItem.Middle, GUIItem.Top)
    self.equippedTitle:SetTextAlignmentX(GUIItem.Align_Center)
    self.equippedTitle:SetTextAlignmentY(GUIItem.Align_Center)
    self.equippedTitle:SetColor(kEquippedColor)
    self.equippedTitle:SetPosition(Vector(0, GUIProtoBuyMenu.kResourceDisplayHeight / 2, 0))
    self.equippedTitle:SetText(Locale.ResolveString("EQUIPPED"))
    self.equippedBg:AddChild(self.equippedTitle)
    
    self.equipped = { }
    
    local equippedTechIds = MarineBuy_GetEquipped()
    local selectorPosX = -GUIProtoBuyMenu.kSelectorSize.x + GUIProtoBuyMenu.kPadding
    
    for k, itemTechId in ipairs(equippedTechIds) do
    
        local graphicItem = GUIManager:CreateGraphicItem()
        graphicItem:SetSize(GUIProtoBuyMenu.kSmallIconSize)
        graphicItem:SetAnchor(GUIItem.Middle, GUIItem.Top)
        graphicItem:SetPosition(Vector(-GUIProtoBuyMenu.kSmallIconSize.x/ 2, GUIProtoBuyMenu.kEquippedIconTopOffset + (GUIProtoBuyMenu.kSmallIconSize.y) * k - GUIProtoBuyMenu.kSmallIconSize.y, 0))
        graphicItem:SetTexture(kInventoryIconsTexture)
        graphicItem:SetTexturePixelCoordinates(GetSmallIconPixelCoordinates(itemTechId))
        
        self.equippedBg:AddChild(graphicItem)
        table.insert(self.equipped, { Graphic = graphicItem, TechId = itemTechId } )
    
    end
    
end

function GUIProtoBuyMenu:_InitializeItemButtons()
    
    self.menu = GetGUIManager():CreateGraphicItem()
    self.menu:SetPosition(Vector( -GUIProtoBuyMenu.kMenuWidth - GUIProtoBuyMenu.kPadding, 0, 0))
    self.menu:SetTexture(GUIProtoBuyMenu.kContentBgTexture)
    self.menu:SetSize(Vector(GUIProtoBuyMenu.kMenuWidth, GUIProtoBuyMenu.kBackgroundHeight, 0))
    self.menu:SetTexturePixelCoordinates(0, 0, GUIProtoBuyMenu.kMenuWidth, GUIProtoBuyMenu.kBackgroundHeight)
    self.content:AddChild(self.menu)
    
    self.menuHeader = GetGUIManager():CreateGraphicItem()
    self.menuHeader:SetSize(Vector(GUIProtoBuyMenu.kMenuWidth, GUIProtoBuyMenu.kResourceDisplayHeight, 0))
    self.menuHeader:SetPosition(Vector(0, -GUIProtoBuyMenu.kResourceDisplayHeight, 0))
    self.menuHeader:SetTexture(GUIProtoBuyMenu.kContentBgBackTexture)
    self.menuHeader:SetTexturePixelCoordinates(0, 0, GUIProtoBuyMenu.kMenuWidth, GUIProtoBuyMenu.kResourceDisplayHeight)
    self.menu:AddChild(self.menuHeader) 
    
    self.menuHeaderTitle = GetGUIManager():CreateTextItem()
    self.menuHeaderTitle:SetFontName(GUIProtoBuyMenu.kFont)
    self.menuHeaderTitle:SetFontIsBold(true)
    self.menuHeaderTitle:SetAnchor(GUIItem.Middle, GUIItem.Center)
    self.menuHeaderTitle:SetTextAlignmentX(GUIItem.Align_Center)
    self.menuHeaderTitle:SetTextAlignmentY(GUIItem.Align_Center)
    self.menuHeaderTitle:SetColor(GUIProtoBuyMenu.kTextColor)
    self.menuHeaderTitle:SetText(Locale.ResolveString("BUY"))
    self.menuHeader:AddChild(self.menuHeaderTitle)
    
    self.itemButtons = { }
    
    local itemTechIdList = self.hostStructure:GetItemList(Client.GetLocalPlayer())
    local selectorPosX = -GUIProtoBuyMenu.kSelectorSize.x + GUIProtoBuyMenu.kPadding
    local fontScaleVector = Vector(0.8, 0.8, 0)
    
    for k, itemTechId in ipairs(itemTechIdList) do
    
        local graphicItem = GUIManager:CreateGraphicItem()
        graphicItem:SetSize(GUIProtoBuyMenu.kMenuIconSize)
        graphicItem:SetAnchor(GUIItem.Middle, GUIItem.Top)
        graphicItem:SetPosition(Vector(-GUIProtoBuyMenu.kMenuIconSize.x/ 2, GUIProtoBuyMenu.kIconTopOffset + (GUIProtoBuyMenu.kMenuIconSize.y) * k - GUIProtoBuyMenu.kMenuIconSize.y, 0))
        graphicItem:SetTexture(kInventoryIconsTexture)
        graphicItem:SetTexturePixelCoordinates(GetSmallIconPixelCoordinates(itemTechId))
        
        local graphicItemActive = GUIManager:CreateGraphicItem()
        graphicItemActive:SetSize(GUIProtoBuyMenu.kSelectorSize)
        
        graphicItemActive:SetPosition(Vector(selectorPosX, -GUIProtoBuyMenu.kSelectorSize.y / 2, 0))
        graphicItemActive:SetAnchor(GUIItem.Right, GUIItem.Center)
        graphicItemActive:SetTexture(GUIProtoBuyMenu.kMenuSelectionTexture)
        graphicItemActive:SetIsVisible(false)
        
        graphicItem:AddChild(graphicItemActive)
        
        local costIcon = GUIManager:CreateGraphicItem()
        costIcon:SetSize(Vector(GUIProtoBuyMenu.kResourceIconWidth * 0.8, GUIProtoBuyMenu.kResourceIconHeight * 0.8, 0))
        costIcon:SetAnchor(GUIItem.Right, GUIItem.Bottom)
        costIcon:SetPosition(Vector(-32, -GUIProtoBuyMenu.kResourceIconHeight * 0.5, 0))
        costIcon:SetTexture(GUIProtoBuyMenu.kResourceIconTexture)
        costIcon:SetColor(GUIProtoBuyMenu.kTextColor)
        
        local selectedArrow = GUIManager:CreateGraphicItem()
        selectedArrow:SetSize(Vector(GUIProtoBuyMenu.kArrowWidth, GUIProtoBuyMenu.kArrowHeight, 0))
        selectedArrow:SetAnchor(GUIItem.Left, GUIItem.Center)
        selectedArrow:SetPosition(Vector(-GUIProtoBuyMenu.kArrowWidth - GUIProtoBuyMenu.kPadding, -GUIProtoBuyMenu.kArrowHeight * 0.5, 0))
        selectedArrow:SetTexture(GUIProtoBuyMenu.kArrowTexture)
        selectedArrow:SetColor(GUIProtoBuyMenu.kTextColor)
        selectedArrow:SetTextureCoordinates(unpack(GUIProtoBuyMenu.kArrowTexCoords))
        selectedArrow:SetIsVisible(false)
        
        graphicItem:AddChild(selectedArrow) 
        
        local itemCost = GUIManager:CreateTextItem()
        itemCost:SetFontName(GUIProtoBuyMenu.kFont)
        itemCost:SetFontIsBold(true)
        itemCost:SetAnchor(GUIItem.Right, GUIItem.Center)
        itemCost:SetPosition(Vector(0, 0, 0))
        itemCost:SetTextAlignmentX(GUIItem.Align_Min)
        itemCost:SetTextAlignmentY(GUIItem.Align_Center)
        itemCost:SetScale(fontScaleVector)
        itemCost:SetColor(GUIProtoBuyMenu.kTextColor)
        itemCost:SetText(ToString(LookupTechData(itemTechId, kTechDataCostKey, 0)))
        
        costIcon:AddChild(itemCost)  
        
        graphicItem:AddChild(costIcon)  
        
        self.menu:AddChild(graphicItem)
        table.insert(self.itemButtons, { Button = graphicItem, Highlight = graphicItemActive, TechId = itemTechId, Cost = itemCost, ResourceIcon = costIcon, Arrow = selectedArrow } )
    
    end
    
    // to prevent wrong display before the first update
    self:_UpdateItemButtons(0)

end

local gResearchToWeaponIds = nil
local function GetItemTechId(researchTechId)

    if not gResearchToWeaponIds then
    
        gResearchToWeaponIds = { }
        gResearchToWeaponIds[kTechId.ShotgunTech] = kTechId.Shotgun
        gResearchToWeaponIds[kTechId.AdvancedWeaponry] = { kTechId.GrenadeLauncher, kTechId.Flamethrower }
        gResearchToWeaponIds[kTechId.WelderTech] = kTechId.Welder
        gResearchToWeaponIds[kTechId.MinesTech] = kTechId.LayMines
        gResearchToWeaponIds[kTechId.JetpackTech] = kTechId.Jetpack
        gResearchToWeaponIds[kTechId.ExosuitTech] = kTechId.Exosuit
        gResearchToWeaponIds[kTechId.DualMinigunTech] = kTechId.DualMinigunExosuit
        gResearchToWeaponIds[kTechId.ClawRailgunTech] = kTechId.ClawRailgunExosuit
        gResearchToWeaponIds[kTechId.DualRailgunTech] = kTechId.DualRailgunExosuit
        
    end
    
    return gResearchToWeaponIds[researchTechId]
    
end

function GUIProtoBuyMenu:_UpdateItemButtons(deltaTime)

    for i, item in ipairs(self.itemButtons) do
    
        if GetIsMouseOver(self, item.Button) then
        
            item.Highlight:SetIsVisible(true)
            self.hoverItem = item.TechId
            
        else
            item.Highlight:SetIsVisible(false)
        end
        
        local useColor = Color(1, 1, 1, 1)
        
        // set grey if not researched
        if not MarineBuy_IsResearched(item.TechId) then
            useColor = Color(0.5, 0.5, 0.5, 0.4)
        // set red if can't afford
        elseif PlayerUI_GetPlayerResources() < MarineBuy_GetCosts(item.TechId) then
           useColor = Color(1, 0, 0, 1)
        // set normal visible
        else

            local newResearchedId = GetItemTechId( PlayerUI_GetRecentPurchaseable() )
            local newlyResearched = false 
            if type(newResearchedId) == "table" then
                newlyResearched = table.contains(newResearchedId, item.TechId)
            else
                newlyResearched = newResearchedId == item.TechId
            end
            
            if newlyResearched then
            
                local anim = math.cos(Shared.GetTime() * 9) * 0.4 + 0.6
                useColor = Color(1, 1, anim, 1)
                
            end
           
        end
        
        item.Button:SetColor(useColor)
        item.Highlight:SetColor(useColor)
        item.Cost:SetColor(useColor)
        item.ResourceIcon:SetColor(useColor)
        item.Arrow:SetIsVisible(self.selectedItem == item.TechId)
        
    end

end

function GUIProtoBuyMenu:_UninitializeItemButtons()

    for i, item in ipairs(self.itemButtons) do
        GUI.DestroyItem(item.Button)
    end
    self.itemButtons = nil

end


GUIProtoBuyMenu.slotTypePanelData = {   
      
       kExoModuleSlots.LeftArm  = {
			title = "LEFT ARM",
            dimensionData = { x = 50, y = 150, width = 120, height = 50 },
          },

       kExoModuleSlots.LeftArm
 = {
            title = "RIGHT ARM",
            dimensionData = { x =700, y = 150, width = 120, height = 50 },

          }, 
         
       kExoModuleSlots.PowerSupply = {
            title = "POWER OUTPUT",
            dimensionData = { x = 100, y = 50, width = 120, height = 50},
          },
		  
		  
}


function GUIProtoBuyMenu:_InitializeExoButtons()
   
    self.GUIItems = {}
    self.buttonList = {}

    
    local eggsPerRow = 8
     
    for panelName, panelData in pairs(GUIProtoBuyMenu.modulePanelMap) do
    
		local panelBox = GUIManager:CreateGraphicItem()
			panelBox:SetTexture( GUIProtoBuyMenu.kContentBgTexture )
			panelBox:SetColor( GUIProtoBuyMenu.kTextColor)
			panelBox:SetPosition(Vector(panelData.dimensionData.x , panelData.dimensionData.y, 0 ))
			panelBox:SetSize(Vector( panelData.dimensionData.width, panelData.dimensionData.height, 0 ))
			//boxButton:AddChild(eggImage)
		   
			self.content:AddChild(panelBox)

        table.insert(self.GUIItems, panelBox)
        table.insert(GUIProtoBuyMenu.modulePanelMap, panelBox)  
        
		local panelText = GUIManager:CreateTextItem()
			panelText:SetFontName( "fonts/AgencyFB_small.fnt" )
			panelText:SetFontIsBold(true)
			panelText:SetPosition(Vector(10, 40, 0))
			panelText:SetAnchor( GUIItem.Left, GUIItem.Top )
			panelText:SetTextAlignmentX(GUIItem.Align_Min)
			panelText:SetTextAlignmentY(GUIItem.Align_Max)
			panelText:SetColor(Color(kMarineFontColor))
			panelText:SetText(panelData.title)
			panelBox:AddChild(panelText)
			table.insert(self.GUIItems, panelText)
        
       
      for moduleButtonNum, moduleButtonData in ipairs(panelData.moduleButtonDataList) do
        
        if panelData.title == "RIGHT ARM" then
		  PosX = 700
		  PosY = 250
		  offsetX = 0
		  offsetY = ((moduleButtonNum-1)%eggsPerRow)*80 
		  
        elseif panelData.title == "POWER OUTPUT" then
		  PosX =  250
		  PosY = 75
		  offsetX = ((moduleButtonNum-1)%eggsPerRow)*100 
		  offsetY = 0
		  
        elseif panelData.title == "LEFT ARM" then
		  PosX = 50
		  PosY = 250
		  offsetX = 0
		  offsetY = ((moduleButtonNum-1)%eggsPerRow)*80 
		  
        end
            
         
        local boxButton = GUIManager:CreateGraphicItem()
        boxButton:SetTexture( "ui/menu/repeating_bg.dds" )
        boxButton:SetColor(kEquippedColor)
        boxButton:SetPosition(Vector(PosX + offsetX, PosY + offsetY, 0 ))
        boxButton:SetSize(Vector( 50, 50, 0 ))
        self.content:AddChild(boxButton)

        
        table.insert(self.GUIItems, boxButton)
        table.insert(self.buttonList, boxButton)

 
        
        local moduleText = GUIManager:CreateTextItem()
        moduleText:SetFontName( "fonts/AgencyFB_small.fnt" )
        moduleText:SetFontIsBold(true)
        moduleText:SetPosition(Vector(0, 0, 0))
        moduleText:SetAnchor(        GUIItem.Left, GUIItem.Top        )
        moduleText:SetTextAlignmentX(GUIItem.Align_Min)
        moduleText:SetTextAlignmentY(GUIItem.Align_Max)
        moduleText:SetColor(Color(kMarineFontColor))
        moduleText:SetText(moduleButtonData.name)
        boxButton:AddChild(moduleText)

       /*   local powoutText = GUIManager:CreateTextItem()
        powoutText:SetFontName( "fonts/AgencyFB_small.fnt" )
        powoutText:SetFontIsBold(true)
        powoutText:SetPosition(Vector(0, 0, 0))
        powoutText:SetAnchor(        GUIItem.Left, GUIItem.Top        )
        powoutText:SetTextAlignmentX(GUIItem.Align_Min)
        powoutText:SetTextAlignmentY(GUIItem.Align_Max)
        powoutText:SetColor(Color(kMarineFontColor))
        powoutText:SetText(moduleButtonData.powername)
        boxButton:AddChild(powoutText)*/
        
        table.insert(self.GUIItems, moduleText)

                local powerText = GUIManager:CreateTextItem()
        powerText:SetFontName( "fonts/AgencyFB_small.fnt" )
        powerText:SetFontIsBold(true)
        powerText:SetPosition(Vector(25, 12.5, 0))
        powerText:SetAnchor(        GUIItem.Left, GUIItem.Top        )
        powerText:SetTextAlignmentX(GUIItem.Align_Center)
        powerText:SetTextAlignmentY(GUIItem.Align_Center)
        powerText:SetColor(Color(kMarineFontColor))
        powerText:SetText(tostring(moduleButtonData.powerCost))
        boxButton:AddChild(powerText)

        table.insert(self.GUIItems, powerText)
        
        

        
      end
    end    

end    
    
function GUIProtoBuyMenu:_InitializeContent()

    self.itemName = GUIManager:CreateTextItem()
    self.itemName:SetFontName(GUIProtoBuyMenu.kFont)
    self.itemName:SetFontIsBold(true)
    self.itemName:SetAnchor(GUIItem.Left, GUIItem.Top)
    self.itemName:SetPosition(Vector(GUIProtoBuyMenu.kItemNameOffsetX , GUIProtoBuyMenu.kItemNameOffsetY , 0))
    self.itemName:SetTextAlignmentX(GUIItem.Align_Min)
    self.itemName:SetTextAlignmentY(GUIItem.Align_Min)
    self.itemName:SetColor(GUIProtoBuyMenu.kTextColor)
    self.itemName:SetText("no selection")
    
    self.content:AddChild(self.itemName)
    
    self.portrait = GetGUIManager():CreateGraphicItem()
    self.portrait:SetAnchor(GUIItem.Middle, GUIItem.Top)
    self.portrait:SetPosition(Vector(-GUIProtoBuyMenu.kBigIconSize.x/2, GUIProtoBuyMenu.kBigIconOffset, 0))
    self.portrait:SetSize(GUIProtoBuyMenu.kBigIconSize)
    self.portrait:SetTexture(GUIProtoBuyMenu.kBigIconTexture)
    self.portrait:SetTexturePixelCoordinates(GetBigIconPixelCoords(kTechId.Axe))
    self.portrait:SetIsVisible(false)
    self.content:AddChild(self.portrait)
    
    self.itemDescription = GetGUIManager():CreateTextItem()
    self.itemDescription:SetFontName(GUIProtoBuyMenu.kDescriptionFontName)
    self.itemDescription:SetAnchor(GUIItem.Middle, GUIItem.Top)
    self.itemDescription:SetPosition(Vector(-GUIProtoBuyMenu.kItemDescriptionSize.x / 2, GUIProtoBuyMenu.kItemDescriptionOffsetY, 0))
    self.itemDescription:SetTextAlignmentX(GUIItem.Align_Min)
    self.itemDescription:SetTextAlignmentY(GUIItem.Align_Min)
    self.itemDescription:SetColor(GUIProtoBuyMenu.kTextColor)
    self.itemDescription:SetTextClipped(true, GUIProtoBuyMenu.kItemDescriptionSize.x - 2* GUIProtoBuyMenu.kPadding, GUIProtoBuyMenu.kItemDescriptionSize.y - GUIProtoBuyMenu.kPadding)
    
    self.content:AddChild(self.itemDescription)
    
end

function GUIProtoBuyMenu:_UpdateContent(deltaTime)

    local techId = self.hoverItem
    if not self.hoverItem then
        techId = self.selectedItem
    end
    
    if techId then
    
        local researched, researchProgress, researching = self:_GetResearchInfo(techId)
        
        local itemCost = MarineBuy_GetCosts(techId)
        local canAfford = PlayerUI_GetPlayerResources() >= itemCost

        local color = Color(1, 1, 1, 1)
        if not canAfford and researched then
            color = Color(1, 0, 0, 1)
        elseif not researched then
            // Make it clear that we can't buy this
            color = Color(0.5, 0.5, 0.5, .6)
        end
    
        self.itemName:SetColor(color)
        self.portrait:SetColor(color)        
        self.itemDescription:SetColor(color)

        self.itemName:SetText(MarineBuy_GetDisplayName(techId))
        self.portrait:SetTexturePixelCoordinates(GetBigIconPixelCoords(techId, researched))
        self.itemDescription:SetText(MarineBuy_GetWeaponDescription(techId))
        self.itemDescription:SetTextClipped(true, GUIProtoBuyMenu.kItemDescriptionSize.x - 2* GUIProtoBuyMenu.kPadding, GUIProtoBuyMenu.kItemDescriptionSize.y - GUIProtoBuyMenu.kPadding)

    end
    
    local contentVisible = techId ~= nil and techId ~= kTechId.None
    
    self.portrait:SetIsVisible(contentVisible)
    self.itemName:SetIsVisible(contentVisible)
    self.itemDescription:SetIsVisible(contentVisible)
    
end

function GUIProtoBuyMenu:_UninitializeContent()

    GUI.DestroyItem(self.itemName)

end

function GUIProtoBuyMenu:_InitializeResourceDisplay()
    
    self.resourceDisplayBackground = GUIManager:CreateGraphicItem()
    self.resourceDisplayBackground:SetSize(Vector(GUIProtoBuyMenu.kBackgroundWidth, GUIProtoBuyMenu.kResourceDisplayHeight, 0))
    self.resourceDisplayBackground:SetPosition(Vector(0, -GUIProtoBuyMenu.kResourceDisplayHeight, 0))
    self.resourceDisplayBackground:SetTexture(GUIProtoBuyMenu.kContentBgBackTexture)
    self.resourceDisplayBackground:SetTexturePixelCoordinates(0, 0, GUIProtoBuyMenu.kBackgroundWidth, GUIProtoBuyMenu.kResourceDisplayHeight)
    self.content:AddChild(self.resourceDisplayBackground)
    
    self.resourceDisplayIcon = GUIManager:CreateGraphicItem()
    self.resourceDisplayIcon:SetSize(Vector(GUIProtoBuyMenu.kResourceIconWidth, GUIProtoBuyMenu.kResourceIconHeight, 0))
    self.resourceDisplayIcon:SetAnchor(GUIItem.Right, GUIItem.Center)
    self.resourceDisplayIcon:SetPosition(Vector(-GUIProtoBuyMenu.kResourceIconWidth * 2.2, -GUIProtoBuyMenu.kResourceIconHeight / 2, 0))
    self.resourceDisplayIcon:SetTexture(GUIProtoBuyMenu.kResourceIconTexture)
    self.resourceDisplayIcon:SetColor(GUIProtoBuyMenu.kTextColor)
    self.resourceDisplayBackground:AddChild(self.resourceDisplayIcon)

    self.resourceDisplay = GUIManager:CreateTextItem()
    self.resourceDisplay:SetFontName(GUIProtoBuyMenu.kFont)
    self.resourceDisplay:SetFontIsBold(true)
    self.resourceDisplay:SetAnchor(GUIItem.Right, GUIItem.Center)
    self.resourceDisplay:SetPosition(Vector(-GUIProtoBuyMenu.kResourceIconWidth , 0, 0))
    self.resourceDisplay:SetTextAlignmentX(GUIItem.Align_Min)
    self.resourceDisplay:SetTextAlignmentY(GUIItem.Align_Center)
    
    self.resourceDisplay:SetColor(GUIProtoBuyMenu.kTextColor)
    //self.resourceDisplay:SetColor(GUIProtoBuyMenu.kTextColor)
    
    self.resourceDisplay:SetText("")
    self.resourceDisplayBackground:AddChild(self.resourceDisplay)
    
    self.currentDescription = GUIManager:CreateTextItem()
    self.currentDescription:SetFontName(GUIProtoBuyMenu.kFont)
    self.currentDescription:SetFontIsBold(true)
    self.currentDescription:SetAnchor(GUIItem.Right, GUIItem.Top)
    self.currentDescription:SetPosition(Vector(-GUIProtoBuyMenu.kResourceIconWidth * 3 , GUIProtoBuyMenu.kResourceIconHeight, 0))
    self.currentDescription:SetTextAlignmentX(GUIItem.Align_Max)
    self.currentDescription:SetTextAlignmentY(GUIItem.Align_Center)
    self.currentDescription:SetColor(GUIProtoBuyMenu.kTextColor)
    self.currentDescription:SetText(Locale.ResolveString("CURRENT"))
    
    self.resourceDisplayBackground:AddChild(self.currentDescription) 

end

function GUIProtoBuyMenu:_UpdateResourceDisplay(deltaTime)

    self.resourceDisplay:SetText(ToString(PlayerUI_GetPlayerResources()))
    
end

function GUIProtoBuyMenu:_UninitializeResourceDisplay()

    GUI.DestroyItem(self.resourceDisplay)
    self.resourceDisplay = nil
    
    GUI.DestroyItem(self.resourceDisplayIcon)
    self.resourceDisplayIcon = nil
    
    GUI.DestroyItem(self.resourceDisplayBackground)
    self.resourceDisplayBackground = nil
    
end

function GUIProtoBuyMenu:_InitializeCloseButton()

    self.closeButton = GUIManager:CreateGraphicItem()
    self.closeButton:SetAnchor(GUIItem.Right, GUIItem.Bottom)
    self.closeButton:SetSize(Vector(GUIProtoBuyMenu.kButtonWidth, GUIProtoBuyMenu.kButtonHeight, 0))
    self.closeButton:SetPosition(Vector(-GUIProtoBuyMenu.kButtonWidth, GUIProtoBuyMenu.kPadding, 0))
    self.closeButton:SetTexture(GUIProtoBuyMenu.kButtonTexture)
    self.closeButton:SetLayer(kGUILayerPlayerHUDForeground4)
    self.content:AddChild(self.closeButton)
    
    self.closeButtonText = GUIManager:CreateTextItem()
    self.closeButtonText:SetAnchor(GUIItem.Middle, GUIItem.Center)
    self.closeButtonText:SetFontName(GUIProtoBuyMenu.kFont)
    self.closeButtonText:SetTextAlignmentX(GUIItem.Align_Center)
    self.closeButtonText:SetTextAlignmentY(GUIItem.Align_Center)
    self.closeButtonText:SetText(Locale.ResolveString("EXIT"))
    self.closeButtonText:SetFontIsBold(true)
    self.closeButtonText:SetColor(GUIProtoBuyMenu.kCloseButtonColor)
    self.closeButton:AddChild(self.closeButtonText)
    
end

function GUIProtoBuyMenu:_InitializeConfirmButton()

     self.confirmButton = GUIManager:CreateGraphicItem()
    self.confirmButton:SetAnchor(GUIItem.Right, GUIItem.Bottom)
    self.confirmButton:SetSize(Vector(GUIProtoBuyMenu.kButtonWidth, GUIProtoBuyMenu.kButtonHeight, 0))
    self.confirmButton:SetPosition(Vector(-GUIProtoBuyMenu.kButtonWidth*4, GUIProtoBuyMenu.kPadding*(-12), 0))
    self.confirmButton:SetTexture(GUIProtoBuyMenu.kButtonTexture)
    self.confirmButton:SetLayer(kGUILayerPlayerHUDForeground4)
    self.content:AddChild(self.confirmButton)
    
    self.confirmButtonText = GUIManager:CreateTextItem()
    self.confirmButtonText:SetAnchor(GUIItem.Middle, GUIItem.Center)
    self.confirmButtonText:SetFontName(GUIProtoBuyMenu.kFont)
    self.confirmButtonText:SetTextAlignmentX(GUIItem.Align_Center)
    self.confirmButtonText:SetTextAlignmentY(GUIItem.Align_Center)
    self.confirmButtonText:SetText(Locale.ResolveString("Confirm"))
    self.confirmButtonText:SetFontIsBold(true)
    self.confirmButtonText:SetColor(GUIProtoBuyMenu.kCloseButtonColor)
    self.confirmButton:AddChild(self.confirmButtonText)
end    

function GUIProtoBuyMenu:_UpdateConfirmButton(deltaTime)

    if GetIsMouseOver(self, self.confirmButton) then
        self.confirmButton:SetColor(Color(1, 1, 1, 1))
    else
        self.confirmButton:SetColor(Color(0.5, 0.5, 0.5, 1))
    end
    
end

function GUIProtoBuyMenu:_UpdateCloseButton(deltaTime)

    if GetIsMouseOver(self, self.closeButton) then
        self.closeButton:SetColor(Color(1, 1, 1, 1))
    else
        self.closeButton:SetColor(Color(0.5, 0.5, 0.5, 1))
    end
    
end

function GUIProtoBuyMenu:_UpdateExoButtons(deltaTime)

    for buttonNum, button in ipairs(self.buttonList) do

        if GetIsMouseOver(self, button) then
            button:SetColor(Color(1, 1, 1, 1))
        else
            button:SetColor(Color(0.5, 0.5, 0.5, 1))
        end
   end 
end

function GUIProtoBuyMenu:_UninitializeCloseButton()
    
    GUI.DestroyItem(self.closeButton)
    self.closeButton = nil

end

function GUIProtoBuyMenu:_UninitializeExoButtons()
    
    for itemNum, item in ipairs(self.GUIItems) do
        GUI.DestroyItem(item)
    end

end

function GUIProtoBuyMenu:_UninitializeConfirmButton()
    
    GUI.DestroyItem(self.confirmButton)
    self.confirmButton = nil

end

function GUIProtoBuyMenu:_GetResearchInfo(techId)

    local researched = MarineBuy_IsResearched(techId)
    local researchProgress = 0
    local researching = false
    
    if not researched then    
        researchProgress = MarineBuy_GetResearchProgress(techId)        
    end
    
    if not (researchProgress == 0) then
        researching = true
    end
    
    return researched, researchProgress, researching
end

local function HandleItemClicked(self, mouseX, mouseY)

    for i = 1, #self.itemButtons do
    
        local item = self.itemButtons[i]
        if GetIsMouseOver(self, item.Button) then
        
            local researched, researchProgress, researching = self:_GetResearchInfo(item.TechId)
            local itemCost = MarineBuy_GetCosts(item.TechId)
            local canAfford = PlayerUI_GetPlayerResources() >= itemCost
            local hasItem = PlayerUI_GetHasItem(item.TechId)
            
            if researched and canAfford and not hasItem then
            
                MarineBuy_PurchaseItem(item.TechId)
                MarineBuy_OnClose()
                
                return true, true
                
            end
            
        end
        
    end
    
    return false, false
    
end

function GUIProtoBuyMenu:SendKeyEvent(key, down)

    local closeMenu = false
    local inputHandled = false
    
    if key == InputKey.MouseButton0 and self.mousePressed ~= down then
    
        self.mousePressed = down
        
        local mouseX, mouseY = Client.GetCursorPosScreen()
        if down then
        
            inputHandled, closeMenu = HandleItemClicked(self, mouseX, mouseY)
            
            if not inputHandled then
            
                // Check if the close button was pressed.
                if GetIsMouseOver(self, self.closeButton) then
                
                    closeMenu = true
                    MarineBuy_OnClose()
                    
                end
                
            end
            
        end
        
    end
    
    // No matter what, this menu consumes MouseButton0/1.
    if key == InputKey.MouseButton0 or key == InputKey.MouseButton1 then
        inputHandled = true
    end
    
    if InputKey.Escape == key and not down then
    
        closeMenu = true
        inputHandled = true
        MarineBuy_OnClose()
        
    end
    
    if closeMenu then
    
        self.closingMenu = true
        MarineBuy_Close()
        
    end
    
    return inputHandled
    
end
