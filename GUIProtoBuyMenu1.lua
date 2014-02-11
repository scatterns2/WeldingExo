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
 
GUIProtoBuyMenu.kBackgroundWidth = GUIScale(800)
GUIProtoBuyMenu.kBackgroundHeight = GUIScale(800)
 GUIProtoBuyMenu.kBackgroundXOffset = GUIScale(0)
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
    
  /*  do self.testText = GUIManager:CreateTextItem()
        self.testText:SetFontName( "fonts/AgencyFB_small.fnt" )
        self.testText:SetFontIsBold(true)
        self.testText:SetPosition(Vector(
            20, 20, 0
        ))
        self.testText:SetAnchor(
            GUIItem.Left, GUIItem.Top
        )
        self.testText:SetTextAlignmentX(GUIItem.Align_Min)
        self.testText:SetTextAlignmentY(GUIItem.Align_Max)
        self.testText:SetColor(Color(
            0, 1, 0, 1
        ))
        self.testText:SetText("Hello!")
    end
    self.content:AddChild(self.testText)*/
    
    
    /*do self.meowText = GUIManager:CreateTextItem()
        self.meowText:SetFontName( "fonts/AgencyFB_small.fnt" )
        self.meowText:SetFontIsBold(true)
        self.meowText:SetPosition(Vector(
            300, 500, 0         ))
        self.meowText:SetAnchor(
            GUIItem.Left, GUIItem.Top
        )
        self.meowText:SetTextAlignmentX(GUIItem.Align_Center)
        self.meowText:SetTextAlignmentY(GUIItem.Align_Center)
        
        self.meowText:SetColor(Color(
            0, 1, 0, 1
        ))
        self.meowText:SetText("Meow!")
    end
    
    self.content:AddChild(self.meowText)*/
    
    

    self.modulePanelMap = {   
    
     
        leftArm = {
            title = "LEFT ARM",
            dimensionData = { x = 10, y = 10, width = 40, height = 90 },
            moduleButtonDataList = {
              { name = "Welder",
                powerCost = 50,
                texturePathMap = {
                  disabled = "ui/egg.dds",
                  normal = "ui/marine_welder.dds",
                  hover = "ui/egg.dds",
                  selected = "ui/egg.dds",
                },
              },
              { name = "Minigun",
                powerCost = 50,
                texturePathMap = {
                  disabled = "ui/egg.dds",
                  normal = "models/marine/exosuit/minigun.dds",
                  hover = "ui/egg.dds",
                  selected = "ui/egg.dds",
                },
              }, 
              { name = "Railgun",
                powerCost = 50,
                texturePathMap = {
                  disabled = "ui/egg.dds",
                  normal = "models/marine/exosuit/railgun.dds",
                  hover = "ui/egg.dds",
                  selected = "ui/egg.dds",
                },
              },
              { name = "Flamethrower",
                powerCost = 50,
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
            dimensionData = { x =500, y = 10, width = 70, height = 50 },
            moduleButtonDataList = {
              { name = "Welder",
                powerCost = 50,
                texturePathMap = {
                  disabled = "ui/egg.dds",
                  normal = "ui/marine_welder.dds",
                  hover = "ui/egg.dds",
                  selected = "ui/egg.dds",
                },
              },
              { name = "Minigun",
                powerCost = 50,
                texturePathMap = {
                  disabled = "ui/egg.dds",
                  normal = "models/marine/exosuit/minigun.dds",
                  hover = "ui/egg.dds",
                  selected = "ui/egg.dds",
                },
              },
              { name = "Railgun",
                powerCost = 50,
                texturePathMap = {
                  disabled = "ui/egg.dds",
                  normal = "models/marine/exosuit/railgun.dds",
                  hover = "ui/egg.dds",
                  selected = "ui/egg.dds",
                },
              },
              { name = "Flamethrower",
                powerCost = 50,
                texturePathMap = {
                  disabled = "ui/egg.dds",
                  normal = "ui/FlamethrowerDisplay.dds",
                  hover = "ui/egg.dds",
                  selected = "ui/egg.dds",
                },
               },
            },
          },
          
    }

    local eggsPerRow = 5
     
    for panelName, panelData in pairs(self.modulePanelMap) do
        print(panelData.title)
    
            local panelBox = GUIManager:CreateGraphicItem()
        panelBox:SetTexture( "ui/menu/repeating_bg.dds" )
        panelBox:SetColor(Color( 1, 0, 0, 1   ))
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
        
        local boxButton = GUIManager:CreateGraphicItem()
        boxButton:SetTexture( "ui/menu/repeating_bg.dds" )
        boxButton:SetColor(Color(       1, 0, 0, 1   ))
        boxButton:SetPosition(Vector(10+ math.floor((moduleButtonNum-1)/eggsPerRow)*500, 50+((moduleButtonNum-1)%eggsPerRow)*75, 0 ))
        boxButton:SetSize(Vector( 50, 50, 0 ))
        self.content:AddChild(boxButton)

        
        table.insert(self.GUIItems, boxButton)
        table.insert(self.buttonList, boxButton)

 
        
        local moduleText = GUIManager:CreateTextItem()
        moduleText:SetFontName( "fonts/AgencyFB_small.fnt" )
        moduleText:SetFontIsBold(true)
        moduleText:SetPosition(Vector(10, 40, 0))
        moduleText:SetAnchor(        GUIItem.Left, GUIItem.Top        )
        moduleText:SetTextAlignmentX(GUIItem.Align_Min)
        moduleText:SetTextAlignmentY(GUIItem.Align_Max)
        moduleText:SetColor(Color(kMarineFontColor))
        moduleText:SetText(moduleButtonData.name)
        boxButton:AddChild(moduleText)

        table.insert(self.GUIItems, moduleText)

                local powerText = GUIManager:CreateTextItem()
        powerText:SetFontName( "fonts/AgencyFB_small.fnt" )
        powerText:SetFontIsBold(true)
        powerText:SetPosition(Vector(30, 70, 0))
        powerText:SetAnchor(        GUIItem.Right, GUIItem.Top        )
        powerText:SetTextAlignmentX(GUIItem.Align_Min)
        powerText:SetTextAlignmentY(GUIItem.Align_Max)
        powerText:SetColor(Color(kMarineFontColor))
        powerText:SetText(tostring(moduleButtonData.powerCost))
        boxButton:AddChild(powerText)

        table.insert(self.GUIItems, powerText)
        
        
        local buttonImage = GUIManager:CreateGraphicItem()
        buttonImage:SetTexture( moduleButtonData.texturePathMap.normal )
        buttonImage:SetColor(Color(       1, 1, 1, 1   ))
        //buttonImage:SetPosition(Vector(10+ ((buttonNum-1)%eggsPerRow)*150, 10+math.floor((buttonNum-1)/eggsPerRow)*150, 0 ))
        buttonImage:SetSize(Vector( 50, 50, 0 ))
        buttonImage:SetTexturePixelCoordinates( 0, 0, 384*2, 192 )
        
        boxButton:AddChild(buttonImage)

        
        table.insert(self.GUIItems, buttonImage)
        
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
