;===================================================================================


;IGNORE

#NoEnv 
#persistent
#MaxThreadsPerHotkey 2
#KeyHistory 0
ListLines Off
SetBatchLines, -1
SetKeyDelay, -1, -1
SetMouseDelay, -1
SetDefaultMouseSpeed, 0
SetWinDelay, -1
SetControlDelay, -1
SendMode Input
CoordMode, Pixel, Screen
SoundBeep, 300, 200
SoundBeep, 400, 200

;===================================================================================


;here is where you change your keybinds

;HOTKEYS & MODES
key_stay_on	:= 	"F1"		; will constantly shoot for you		
key_hold_mode	:= 	"8"		; will only shoot when you hold "key_hold"
key_fastclick 	:= 	"F3"		; self explanatory (on/off beep sound only)
key_off		:= 	"F4"		; off	
key_gui_hide	:=	"9"		; hides gui (gui)		
key_exit	:= 	"0"		; closes script		
key_hold	:=	"XButton1" 	; key that you hold to shoot for you	

;SETTINGS
pixel_box	:=	2		; MIN- 3      MAX- 8	
pixel_sens	:=	50		; higher = more color sensitive; less = less color sensitive 		
pixel_color	:=	0xFEFE40 	; yellow="0xFEFE40", purple="0xA145A3", red="0xB82C29"
tap_time	:=	230	; Delay in MS between shots

;recommended settings 
;pixel_box - 2
;pixel_sens - 50-70	
;pixel_colour - up to you
;tap_time - up to you

;===================================================================================

































;===================================================================================


;DO NOT TOUCH
Gui,2:Font,Cdefault,Fixedsys
Gui,2:Color,Black
Gui,2:Color, EEAA99
Gui,2:Add,Progress, x10 y20 w100 h23 Disabled BackgroundBlack vC3
Gui,2:Add,Text, xp yp wp hp cWhite BackgroundTrans Center 0x200 vB3 gStart,constant
Gui,2:Add,Progress, x10 y20 w100 h23 Disabled BackgroundBlack vC2
Gui,2:Add,Text, xp yp wp hp cWhite BackgroundTrans Center 0x200 vB2 gStart,hold %key_hold%
Gui,2:Add,Progress, xp yp wp hp Disabled BackgroundBlack vC1
Gui,2:Add,Text, xp yp wp hp cWhite BackgroundTrans Center 0x200 vB1 gStart,MSIAfterburner
Gui,2: Show, x10 y20 w100 h60
Gui 2:+LastFound +ToolWindow +AlwaysOnTop -Caption
WinSet, TransColor, EEAA99
2Guiescape:
2Guiclose:
leftbound:= A_ScreenWidth/2-pixel_box
rightbound:= A_ScreenWidth/2+pixel_box
topbound:= A_ScreenHeight/2-pixel_box
bottombound:= A_ScreenHeight/2+pixel_box 
hotkey, %key_stay_on%, stayon
hotkey, %key_hold_mode%, holdmode
hotkey, %key_off%, offloop
hotkey, %key_gui_hide%, guihide
hotkey, %key_exit%, terminate
Hotkey, % key_fastclick, fastclick
return
start:
gui,2:submit,nohide
terminate:
SoundBeep, 300, 200
SoundBeep, 200, 200
Sleep 400
exitapp
stayon:
SoundBeep, 300, 200
settimer, loop2, off
settimer, loop1, 100
GuiControl,2: hide,B1
GuiControl,2: hide,C1
GuiControl,2: hide,B2
GuiControl,2: hide,C2
GuiControl,2: show,B3
GuiControl,2: show,C3
return
holdmode:
SoundBeep, 300, 200
settimer, loop1, off
settimer, loop2, 100
GuiControl,2: hide,B1
GuiControl,2: hide,C1
GuiControl,2: show,B2
GuiControl,2: show,C2
GuiControl,2: hide,B3
GuiControl,2: hide,C3
return
offloop:
SoundBeep, 300, 200
settimer, loop1, off
settimer, loop2, off
GuiControl,2: show,B1
GuiControl,2: show,C1
GuiControl,2: hide,B2
GuiControl,2: hide,C2
GuiControl,2: hide,B3
GuiControl,2: hide,C3
return
guihide:
GuiControl,2: hide,B1
GuiControl,2: hide,C1
GuiControl,2: hide,B2
GuiControl,2: hide,C2
GuiControl,2: hide,B3
GuiControl,2: hide,C3
return

loop1:
PixelSearch()
return

loop2:
While GetKeyState(key_hold, "P"){
PixelSearch()
}
return

fastclick:
SoundBeep, 300, 200
toggle := !toggle
return
#if toggle
*~$LButton::
sleep 1
While GetKeyState("LButton", "P"){
Click
sleep 1
}
return
#if

PixelSearch() {
global
PixelSearch, FoundX, FoundY, leftbound, topbound, rightbound, bottombound, pixel_color, pixel_sens, Fast RGB
If !(ErrorLevel)
{
If !GetKeyState("LButton")
{
click
sleep %tap_time%
}
}
return
}