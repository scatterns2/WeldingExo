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
 
GUIProtoBuyMenu.kBackgroundWidth = GUIScale(600)
GUIProtoBuyMenu.kBackgroundHeight = GUIScale(710)
 GUIProtoBuyMenu.kBackgroundXOffset = GUIScale(0)
------------------------------------------
local GetIsMouseOver -- ignore this
 
 
 
------------------------------------------ Where to create your stuff
function GUIProtoBuyMenu:Initialize()
    GUIAnimatedScript.Initialize(self)
    MarineBuy_OnOpen()
    
    
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
    
    do self.testText = GUIManager:CreateTextItem()
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
    self.content:AddChild(self.testText)
    
    
    do self.meowText = GUIManager:CreateTextItem()
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
    
    self.content:AddChild(self.meowText)
    
    
    local buttonDataList = {}
    
    for buttonNum, buttonData in ipairs(buttonDataList) do

    local eggButton = GUIManager:CreateGraphicItem()

    
    buttonDataList[1] = { col = Color(1, 0, 0, 1), texture = "ui/Egg.dds" }
    buttonDataList[2] = { col = Color(1, 1, 1, 1), texture = "ui/Egg.dds" }
    
    eggButton:SetPosition(Vector(50+ ((buttonNum-1)%eggsPerRow)*25, 50+math.floor((buttonNum-1)/eggsPerRow)*25, 0 ))
    eggButton:SetColor( buttonData.col )
    eggButton:SetSize(Vector( 25, 25, 0 ))
    eggButton:SetTexturePixelCoordinates( 0, 0, 384, 192 )
          
    self.content:AddChild(eggButton)

    table.insert(buttonDataList, buttonNum)
   
    end
   
   
   
    /*self.eggButtonList = {}

    for buttonNum = 1, 50 do
    
        local eggButton = GUIManager:CreateGraphicItem()
        
        local eggsPerRow = 8

        
        eggButton:SetTexture( "ui/egg.dds" )
        eggButton:SetPosition(Vector(50+ ((buttonNum-1)%eggsPerRow)*25, 50+math.floor((buttonNum-1)/eggsPerRow)*25, 0 ))
        eggButton:SetColor( Color( 1, 1, 1, 1 ) )
        eggButton:SetSize(Vector( 25, 25, 0 ))
        eggButton:SetTexturePixelCoordinates( 0, 0, 384, 192 )
        
        self.content:AddChild(eggButton)

     
    table.insert(self.eggButtonList, eggButton)
    
    end*/
    
   /* do self.egg = GUIManager:CreateGraphicItem()
             
        self.egg:SetTexture( "ui/egg.dds" )
        self.egg:SetPosition(Vector(100, 100, 0 ))
        self.egg:SetColor( Color( 1, 1, 1, 1 ) )
        self.egg:SetSize(Vector( 384*2, 192, 0 ))
        self.egg:SetTexturePixelCoordinates( 0, 0, 384*2, 192 )



       
    end
    self.content:AddChild(self.egg)*/
    
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
    
    
    
end
 
 
------------------------------------------ Where you can update your stuff each frame
function GUIProtoBuyMenu:Update(deltaTime)
    GUIAnimatedScript.Update(self, deltaTime)
    
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
