// ======= Copyright (c) 2003-2011, Unknown Worlds Entertainment, Inc. All rights reserved. =======
//
// lua\GUIProtoBuyMenu.lua
//
// Created by: Andreas Urwalek (andi@unknownworlds.com)
//
// Manages the marine buy/purchase menu.
//
// ========= For more information, visit us at http://www.unknownworlds.com =====================
 
------------------------------------------ Easy reloading
do
    _CMD_CLIENTSCRIPT_VERSION = (_CMD_CLIENTSCRIPT_VERSION or 1)+1
    local v = _CMD_CLIENTSCRIPT_VERSION
    Event.Hook("Console_clientscript", function(path)
        if v ~= _CMD_CLIENTSCRIPT_VERSION then return end
        Script.Load(path)
    end)
end
------------------------------------------ Class definition
Script.Load("lua/GUIAnimatedScript.lua")
class 'GUIProtoBuyMenu' (GUIAnimatedScript)
------------------------------------------ Various handy variables
 GUIProtoBuyMenu.kContentBgBackTexture = "ui/menu/repeating_bg_black.dds"
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


GUIProtoBuyMenu.kBackgroundWidth = GUIScale(1000)
GUIProtoBuyMenu.kBackgroundHeight = GUIScale(800)
 GUIProtoBuyMenu.kBackgroundXOffset = GUIScale(20)
 
GUIProtoBuyMenu.kResourceDisplayHeight = GUIScale(64)
GUIProtoBuyMenu.kResourceIconHeight = GUIScale(32)
GUIProtoBuyMenu.kResourceIconWidth = GUIScale(32)

local kEquippedColor = Color(0.5, 0.5, 0.5, 0.5)

GUIProtoBuyMenu.kTextColor = Color(kMarineFontColor)
GUIProtoBuyMenu.kFont = "fonts/AgencyFB_small.fnt"
GUIProtoBuyMenu.kFont2 = "fonts/AgencyFB_small.fnt"

GUIProtoBuyMenu.kButtonWidth = GUIScale(160)
GUIProtoBuyMenu.kButtonHeight = GUIScale(64)
GUIProtoBuyMenu.kCloseButtonColor = Color(1, 1, 0, 1)

GUIProtoBuyMenu.kMenuWidth = GUIScale(190)
GUIProtoBuyMenu.kPadding = GUIScale(8)

------------------------------------------
local GetIsMouseOver -- ignore this
 


 
------------------------------------------ Where to create your stuff




function GUIProtoBuyMenu:Initialize()
   
    GUIAnimatedScript.Initialize(self)
    MarineBuy_OnOpen()
    self.GUIItems = {}
    self.buttonList = {}
  

    self.mouseOverStates = { }

    do self.background = GUIManager:CreateGraphicItem()
        self.background:SetSize(Vector(
            Client.GetScreenWidth(), Client.GetScreenHeight(), 0
        ))
        self.background:SetAnchor(
            GUIItem.Left, GUIItem.Top
        )
        self.background:SetColor(
            Color(0.05, 0.05, 0.1, 0.7)
        )
        self.background:SetLayer( kGUILayerPlayerHUDForeground4 )
    end
    
    do self.content = GUIManager:CreateGraphicItem()
        self.content:SetSize(Vector(
            GUIProtoBuyMenu.kBackgroundWidth, GUIProtoBuyMenu.kBackgroundHeight, 0
        ))
        self.content:SetAnchor(
            GUIItem.Middle, GUIItem.Center
        )
        self.content:SetPosition(Vector(
            (-GUIProtoBuyMenu.kBackgroundWidth / 2) + GUIProtoBuyMenu.kBackgroundXOffset, -GUIProtoBuyMenu.kBackgroundHeight / 2, 0
        ))
        self.content:SetTexture( "ui/menu/repeating_bg.dds" )
        self.content:SetTexturePixelCoordinates(
            0, 0, GUIProtoBuyMenu.kBackgroundWidth, GUIProtoBuyMenu.kBackgroundHeight
        )
        self.content:SetColor(
            Color(1,1,1,0.8)
        )
    end
    self.background:AddChild(self.content)
    
  
    local exoImage = GUIManager:CreateGraphicItem()
    exoImage:SetTexture( "ui/exo1.dds" )
    exoImage:SetColor(Color(       0, 0, 0, 1   ))
    exoImage:SetPosition(Vector(200, 150, 0))
    exoImage:SetSize(Vector( 400, 400, 0 ))
    exoImage:SetTexturePixelCoordinates( 0, 0, 399, 437 )
        
    self.content:AddChild(exoImage)
      
    local resourceDisplayBackground = GUIManager:CreateGraphicItem()
    resourceDisplayBackground:SetSize(Vector(GUIProtoBuyMenu.kBackgroundWidth, GUIProtoBuyMenu.kResourceDisplayHeight, 0))
    resourceDisplayBackground:SetPosition(Vector(0, -GUIProtoBuyMenu.kResourceDisplayHeight, 0))
    resourceDisplayBackground:SetTexture(GUIProtoBuyMenu.kContentBgBackTexture)
    resourceDisplayBackground:SetTexturePixelCoordinates(0, 0, GUIProtoBuyMenu.kBackgroundWidth, GUIProtoBuyMenu.kResourceDisplayHeight)
    self.content:AddChild(resourceDisplayBackground)
    
    local resourceDisplayIcon = GUIManager:CreateGraphicItem()
    resourceDisplayIcon:SetSize(Vector(GUIProtoBuyMenu.kResourceIconWidth, GUIProtoBuyMenu.kResourceIconHeight, 0))
    resourceDisplayIcon:SetAnchor(GUIItem.Right, GUIItem.Center)
    resourceDisplayIcon:SetPosition(Vector(-GUIProtoBuyMenu.kResourceIconWidth * 2.2, -GUIProtoBuyMenu.kResourceIconHeight / 2, 0))
    resourceDisplayIcon:SetTexture(GUIProtoBuyMenu.kResourceIconTexture)
    resourceDisplayIcon:SetColor(GUIProtoBuyMenu.kTextColor)
    resourceDisplayBackground:AddChild(resourceDisplayIcon)

    resourceDisplay = GUIManager:CreateTextItem()
    resourceDisplay:SetFontName(GUIProtoBuyMenu.kFont)
    resourceDisplay:SetFontIsBold(true)
    resourceDisplay:SetAnchor(GUIItem.Right, GUIItem.Center)
    resourceDisplay:SetPosition(Vector(-GUIProtoBuyMenu.kResourceIconWidth , 0, 0))
    resourceDisplay:SetTextAlignmentX(GUIItem.Align_Min)
    resourceDisplay:SetTextAlignmentY(GUIItem.Align_Center)
    resourceDisplay:SetColor(GUIProtoBuyMenu.kTextColor)
    //self.resourceDisplay:SetColor(GUIProtoBuyMenu.kTextColor)
    
    resourceDisplay:SetText("")
    resourceDisplayBackground:AddChild(resourceDisplay)
    
    currentDescription = GUIManager:CreateTextItem()
    currentDescription:SetFontName(GUIProtoBuyMenu.kFont)
    currentDescription:SetFontIsBold(true)
    currentDescription:SetAnchor(GUIItem.Right, GUIItem.Top)
    currentDescription:SetPosition(Vector(-GUIProtoBuyMenu.kResourceIconWidth * 3 , GUIProtoBuyMenu.kResourceIconHeight, 0))
    currentDescription:SetTextAlignmentX(GUIItem.Align_Max)
    currentDescription:SetTextAlignmentY(GUIItem.Align_Center)
    currentDescription:SetColor(GUIProtoBuyMenu.kTextColor)
    currentDescription:SetText(Locale.ResolveString("CURRENT"))
    
    resourceDisplayBackground:AddChild(currentDescription)   

    
    local closeButton = GUIManager:CreateGraphicItem()
    closeButton:SetAnchor(GUIItem.Right, GUIItem.Bottom)
    closeButton:SetSize(Vector(GUIProtoBuyMenu.kButtonWidth, GUIProtoBuyMenu.kButtonHeight, 0))
    closeButton:SetPosition(Vector(-GUIProtoBuyMenu.kButtonWidth, GUIProtoBuyMenu.kPadding, 0))
    closeButton:SetTexture(GUIProtoBuyMenu.kButtonTexture)
    closeButton:SetLayer(kGUILayerPlayerHUDForeground4)
    self.content:AddChild(closeButton)
    
    local closeButtonText = GUIManager:CreateTextItem()
    closeButtonText:SetAnchor(GUIItem.Middle, GUIItem.Center)
    closeButtonText:SetFontName(GUIProtoBuyMenu.kFont)
    closeButtonText:SetTextAlignmentX(GUIItem.Align_Center)
    closeButtonText:SetTextAlignmentY(GUIItem.Align_Center)
    closeButtonText:SetText(Locale.ResolveString("EXIT"))
    closeButtonText:SetFontIsBold(true)
    closeButtonText:SetColor(GUIProtoBuyMenu.kCloseButtonColor)
    closeButton:AddChild(closeButtonText)
        
        local confirmButton = GUIManager:CreateGraphicItem()
    confirmButton:SetAnchor(GUIItem.Right, GUIItem.Bottom)
    confirmButton:SetSize(Vector(GUIProtoBuyMenu.kButtonWidth, GUIProtoBuyMenu.kButtonHeight, 0))
    confirmButton:SetPosition(Vector(-GUIProtoBuyMenu.kButtonWidth*4, GUIProtoBuyMenu.kPadding*(-12), 0))
    confirmButton:SetTexture(GUIProtoBuyMenu.kButtonTexture)
    confirmButton:SetLayer(kGUILayerPlayerHUDForeground4)
    self.content:AddChild(confirmButton)
    
    local confirmButtonText = GUIManager:CreateTextItem()
    confirmButtonText:SetAnchor(GUIItem.Middle, GUIItem.Center)
    confirmButtonText:SetFontName(GUIProtoBuyMenu.kFont)
    confirmButtonText:SetTextAlignmentX(GUIItem.Align_Center)
    confirmButtonText:SetTextAlignmentY(GUIItem.Align_Center)
    confirmButtonText:SetText(Locale.ResolveString("Confirm"))
    confirmButtonText:SetFontIsBold(true)
    confirmButtonText:SetColor(GUIProtoBuyMenu.kCloseButtonColor)
    confirmButton:AddChild(confirmButtonText)
    
       local menu = GetGUIManager():CreateGraphicItem()
    menu:SetPosition(Vector( -GUIProtoBuyMenu.kMenuWidth - GUIProtoBuyMenu.kPadding, 0, 0))
    menu:SetTexture(GUIProtoBuyMenu.kContentBgTexture)
    menu:SetSize(Vector(GUIProtoBuyMenu.kMenuWidth, GUIProtoBuyMenu.kBackgroundHeight, 0))
    menu:SetTexturePixelCoordinates(0, 0, GUIProtoBuyMenu.kMenuWidth, GUIProtoBuyMenu.kBackgroundHeight)
    self.content:AddChild(menu)
    
    local menuHeader = GetGUIManager():CreateGraphicItem()
    menuHeader:SetSize(Vector(GUIProtoBuyMenu.kMenuWidth, GUIProtoBuyMenu.kResourceDisplayHeight, 0))
    menuHeader:SetPosition(Vector(0, -GUIProtoBuyMenu.kResourceDisplayHeight, 0))
    menuHeader:SetTexture(GUIProtoBuyMenu.kContentBgBackTexture)
    menuHeader:SetTexturePixelCoordinates(0, 0, GUIProtoBuyMenu.kMenuWidth, GUIProtoBuyMenu.kResourceDisplayHeight)
    menu:AddChild(menuHeader) 
    
    local menuHeaderTitle = GetGUIManager():CreateTextItem()
    menuHeaderTitle:SetFontName(GUIProtoBuyMenu.kFont)
    menuHeaderTitle:SetFontIsBold(true)
    menuHeaderTitle:SetAnchor(GUIItem.Middle, GUIItem.Center)
    menuHeaderTitle:SetTextAlignmentX(GUIItem.Align_Center)
    menuHeaderTitle:SetTextAlignmentY(GUIItem.Align_Center)
    menuHeaderTitle:SetColor(GUIProtoBuyMenu.kTextColor)
    menuHeaderTitle:SetText(Locale.ResolveString("BUY"))
    menuHeader:AddChild(menuHeaderTitle)
    
    local kSmallIconScale = 0.9
    GUIProtoBuyMenu.kSmallIconSize = GUIScale( Vector(100, 50, 0) )
    GUIProtoBuyMenu.kMenuIconSize = GUIScale( Vector(190, 80, 0) ) * kSmallIconScale
    GUIProtoBuyMenu.kSelectorSize = GUIScale( Vector(215, 110, 0) ) * kSmallIconScale
    GUIProtoBuyMenu.kIconTopOffset = 10
    GUIProtoBuyMenu.kArrowWidth = GUIScale(32)
    GUIProtoBuyMenu.kArrowHeight = GUIScale(32)
    GUIProtoBuyMenu.kArrowTexCoords = { 1, 1, 0, 0 }
        
    
    local selectorPosX = -GUIProtoBuyMenu.kSelectorSize.x + GUIProtoBuyMenu.kPadding
    local fontScaleVector = Vector(0.8, 0.8, 0)
    
   
 
     
    local graphicItem = GUIManager:CreateGraphicItem()
    graphicItem:SetSize(GUIProtoBuyMenu.kMenuIconSize)
    graphicItem:SetAnchor(GUIItem.Middle, GUIItem.Top)
    graphicItem:SetPosition(Vector(-GUIProtoBuyMenu.kMenuIconSize.x/ 2, GUIProtoBuyMenu.kIconTopOffset + (GUIProtoBuyMenu.kMenuIconSize.y)  - GUIProtoBuyMenu.kMenuIconSize.y, 0))
    graphicItem:SetTexture("ui/inventory_icons.dds")
    graphicItem:SetTexturePixelCoordinates(0,0,56, 1566)
    
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
    
    self.content:AddChild(graphicItem)



    
    self.modulePanelMap = {   
      
       leftArm = {
            title = "LEFT ARM",
            dimensionData = { x = 50, y = 150, width = 100, height = 50 },
            moduleButtonDataList = {
              { name = "Welder",
                powerCost = 10,
                texturePathMap = {
                  disabled = "ui/egg.dds",
                  normal = "ui/marine_welder.dds",
                  hover = "ui/egg.dds",
                  selected = "ui/egg.dds",
                },
              },
              { name = "Minigun",
                powerCost = 10,
                texturePathMap = {
                  disabled = "ui/egg.dds",
                  normal = "models/marine/exosuit/minigun.dds",
                  hover = "ui/egg.dds",
                  selected = "ui/egg.dds",
                },
              }, 
              { name = "Railgun",
                powerCost = 15,
                texturePathMap = {
                  disabled = "ui/egg.dds",
                  normal = "models/marine/exosuit/railgun.dds",
                  hover = "ui/egg.dds",
                  selected = "ui/egg.dds",
                },
              },
              { name = "Flamethrower",
                powerCost = 20,
                texturePathMap = {
                  disabled = "ui/egg.dds",
                  normal = "ui/FlamethrowerDisplay.dds",
                  hover = "ui/egg.dds",
                  selected = "ui/egg.dds",
                },
              },
            },
          },
        


        rightArm = {
            title = "RIGHT ARM",
            dimensionData = { x =700, y = 150, width = 100, height = 50 },
            moduleButtonDataList = {
              { name = "Welder",
                powerCost = 10,
                texturePathMap = {
                  disabled = "ui/egg.dds",
                  normal = "ui/marine_welder.dds",
                  hover = "ui/egg.dds",
                  selected = "ui/egg.dds",
                },
              },
              { name = "Minigun",
                powerCost = 10,
                texturePathMap = {
                  disabled = "ui/egg.dds",
                  normal = "models/marine/exosuit/minigun.dds",
                  hover = "ui/egg.dds",
                  selected = "ui/egg.dds",
                },
              },
              { name = "Railgun",
                powerCost = 15,
                texturePathMap = {
                  disabled = "ui/egg.dds",
                  normal = "models/marine/exosuit/railgun.dds",
                  hover = "ui/egg.dds",
                  selected = "ui/egg.dds",
                },
              },
              { name = "Flamethrower",
                powerCost = 20,
                texturePathMap = {
                  disabled = "ui/egg.dds",
                  normal = "ui/FlamethrowerDisplay.dds",
                  hover = "ui/egg.dds",
                  selected = "ui/egg.dds",
                },
               },
            },
          }, 
         
       powerOutput = {
            title = "POWER OUTPUT",
            dimensionData = { x = 100, y = 50, width = 120, height = 50},
            moduleButtonDataList = {
                  { name = "15",
                    powerCost = 15,
                    texturePathMap = {
                       disabled = "ui/egg.dds",
                       normal = "ui/marine_welder.dds",
                       hover = "ui/egg.dds",
                       selected = "ui/egg.dds",
                    },
                },
                  { name = "20",
                    powerCost = 20,
                    texturePathMap = {
                      disabled = "ui/egg.dds",
                      normal = "ui/marine_welder.dds",
                      hover = "ui/egg.dds",
                      selected = "ui/egg.dds",
                    },
                },
                  { name = "25",
                    powerCost = 25,
                    texturePathMap = {
                      disabled = "ui/egg.dds",
                      normal = "ui/marine_welder.dds",
                      hover = "ui/egg.dds",
                      selected = "ui/egg.dds",
                    },
                },
                  { name = "30",
                    powerCost = 30,
                    texturePathMap = {
                      disabled = "ui/egg.dds",
                      normal = "ui/marine_welder.dds",
                      hover = "ui/egg.dds",
                      selected = "ui/egg.dds",
                    },
                },
                  { name = "40",
                    powerCost = 40,
                    texturePathMap = {
                      disabled = "ui/egg.dds",
                      normal = "ui/marine_welder.dds",
                      hover = "ui/egg.dds",
                      selected = "ui/egg.dds",
                    },
                },
              },
            },
    
    }
    
    local eggsPerRow = 8
     
    for panelName, panelData in pairs(self.modulePanelMap) do
    
            local panelBox = GUIManager:CreateGraphicItem()
        panelBox:SetTexture( "ui/menu/repeating_bg.dds" )
        panelBox:SetColor(Color( 1, 1, 1, 1   ))
        panelBox:SetPosition(Vector(panelData.dimensionData.x , panelData.dimensionData.y, 0 ))
       panelBox:SetSize(Vector( panelData.dimensionData.width, panelData.dimensionData.height, 0 ))
        //boxButton:AddChild(eggImage)
       
        self.content:AddChild(panelBox)

        table.insert(self.GUIItems, panelBox)
        table.insert(self.modulePanelMap, panelBox)  
        
         local panelText = GUIManager:CreateTextItem()
        panelText:SetFontName( "fonts/AgencyFB_small.fnt" )
        panelText:SetFontIsBold(true)
        panelText:SetPosition(Vector(10, 40, 0))
        panelText:SetAnchor(        GUIItem.Left, GUIItem.Top        )
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
            
 
          
            // START HERE
    
    
end
 

 
------------------------------------------ Where to delete your stuff
function GUIProtoBuyMenu:Uninitialize()
    GUIAnimatedScript.Uninitialize(self)
    
    // todo
    GUI.DestroyItem(self.background)
    GUI.DestroyItem(self.content)
    GUI.DestroyItem(self.testText)
    GUI.DestroyItem(self.meowText)
    
    for itemNum, item in ipairs(self.GUIItems) do
        GUI.DestroyItem(item)
    end

    
    
end
 
 
------------------------------------------ Where you can update your stuff each frame
function GUIProtoBuyMenu:Update(deltaTime)
    GUIAnimatedScript.Update(self, deltaTime)
      
    for buttonNum, button in ipairs(self.buttonList) do
        
        if GetIsMouseOver(self, button) then
            button:SetColor( Color(0, 1, 0, 1) )
        else
            button:SetColor( Color(1, 0, 0, 1) )
        end
    
   end

    
    // todo
end
 
 
------------------------------------------
// Don't worry about anything below here for now!
function GUIProtoBuyMenu:SetHostStructure(hostStructure)
    self.hostStructure = hostStructure
end
function GUIProtoBuyMenu:OnClose()
    if not self.closingMenu then
        MarineBuy_OnClose()
    end
end
 
function GUIProtoBuyMenu:SendKeyEvent(key, down)
    local closeMenu = false
    local inputHandled = false
    
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
 
GetIsMouseOver = function(self, overItem)
    local mouseOver = GUIItemContainsPoint(overItem, Client.GetCursorPosScreen())
    if mouseOver and not self.mouseOverStates[overItem] then
        MarineBuy_OnMouseOver()
    end
    self.mouseOverStates[overItem] = mouseOver
    return mouseOver
end
