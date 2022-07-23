
// Project: {project}
// Created: {date}

#Option_Explicit

#Constant False 0
#Constant True  1

#Constant AGK_ErrorMode_Ignore 0
#Constant AGK_ErrorMode_Report 1
#Constant AGK_ErrorMode_Stop   2
#Constant AGK_SyncRate_Save     0
#Constant AGK_SyncRate_Accurate 1

#Constant TAB$   = Chr(0x09)
#Constant LF$    = Chr(0x0A)
#Constant CR$    = Chr(0x0D)
#Constant CRLF$  = Chr(0x0D) + Chr(0x0A)
#Constant SPACE$ = Chr(0x20)
#Constant QUOT$  = Chr(0x22)
#Constant TIMES$ = Chr(0xD7)

SetErrorMode(AGK_ErrorMode_Stop)
SetWindowTitle("{project}")
SetWindowSize(1280, 720, False)
SetWindowAllowResize(True)
SetVirtualResolution(1920, 1080)
SetOrientationAllowed(True, True, True, True)
SetSyncRate(60, AGK_SyncRate_Accurate)
SetScissor(0, 0, 0, 0)
UseNewDefaultFonts(True)
SetPrintSize(32.0)
SetPrintColor(0xFF, 0xFF, 0xFF)
SetClearColor(0x40, 0x80, 0xC0)

pMouseX As Float
pMouseY As Float
mouseX As Float
mouseY As Float
mouseWheel As Float

SetViewZoom(1.0)
SetViewOffset(-960.0, -540.0)

Do
	
	pMouseX = mouseX
	pMouseY = mouseY
	mouseX = GetRawMouseX()
	mouseY = GetRawMouseY()
	mouseWheel = GetRawMouseWheelDelta()
	
	If GetRawMouseRightState()
		SetViewOffset(GetViewOffsetX() - (mouseX - pMouseX) / GetViewZoom(), GetViewOffsetY() - (mouseY - pMouseY) / GetViewZoom())
	EndIf
	
	If mouseWheel <> 0.0
		mouseX = ScreenToWorldX(mouseX)
		mouseY = ScreenToWorldY(mouseY)
		If mouseWheel < 0.0
			SetViewZoom(GetViewZoom() * 0.5)
		ElseIf mouseWheel > 0.0
			SetViewZoom(GetViewZoom() * 2.0)
		EndIf
		SetViewOffset(mouseX - GetRawMouseX() / GetViewZoom(), mouseY - GetRawMouseY() / GetViewZoom())
		mouseX = GetRawMouseX()
		mouseY = GetRawMouseY()
	EndIf
	
	DrawLine(WorldToScreenX(0.0), WorldToScreenY(0.0), WorldToScreenX(0.0) + 100.0, WorldToScreenY(0.0), 0xFF0000FF, 0xFF0000FF)
	DrawLine(WorldToScreenX(0.0), WorldToScreenY(0.0), WorldToScreenX(0.0), WorldToScreenY(0.0) + 100.0, 0xFF00FF00, 0xFF00FF00)
	
	Print("FPS: " + Str(ScreenFPS(), 1) + CRLF$)
	Print("View")
	Print(TAB$ + "offset: " + Str(GetViewOffsetX(), 2) + ", " + Str(GetViewOffsetY(), 2))
	Print(TAB$ + "zoom: " + TIMES$ + Str(GetViewZoom(), 4) + CRLF$)
	Print("Mouse")
	Print(TAB$ + "screen: " + Str(mouseX, 2) + ", " + Str(mouseY, 2))
	Print(TAB$ + "world: " + Str(ScreenToWorldX(mouseX), 2) + ", " + Str(ScreenToWorldY(mouseY), 2))
	
	Sync()
	
Loop
