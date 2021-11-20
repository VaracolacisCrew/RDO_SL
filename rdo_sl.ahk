; Created by 		Cristófano Varacolaci 
; For 			 	ObsessedDesigns Studios™, Inc.
; Version 			1.0.0
; Build             10:30 2021.11.20
;#####################################################################################
; INCLUDES
;#####################################################################################
#Include, libs\init.ahk
#Include, libs\functions.ahk
#Include, libs\ui.ahk
Return

; creates the tray menu
Gosub, MENU

MAIN:
    if OPTIONS_snclose {
        Process_Suspend(OPTIONS_exename)
        Sleep, OPTIONS_time
        Process_Resume(OPTIONS_exename)
        Goto, END
    }
    Hotkey, %HOTKEYS_hotkey1%, SUSPEND
    Hotkey, %HOTKEYS_hotkey2%, END
Return

SUSPEND:
    ;MsgBox, , SETTINGS, % "exename = " . OPTIONS_exename . "`nsnclose = " . OPTIONS_snclose . "`ntime = " . OPTIONS_time
    Process_Suspend(OPTIONS_exename)
    Sleep, OPTIONS_time
    Process_Resume(OPTIONS_exename)
Return

END:
GuiEscape:
GuiClose:
ExitApp