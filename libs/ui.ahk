MENU:
	Menu, Tray, DeleteAll
	Menu, Tray, NoStandard
	Menu, Tray, Add, % PROGNAME WinName, ABOUT
	Menu, Tray, Default, % PROGNAME WinName
	Menu, Tray, Add,
    Menu, Tray, Add, &Settings...,SETTINGS
	Menu, Tray, Add, &About...,ABOUT
	Menu, Tray, Add, &Exit, END
	Menu, Tray, Tip, % PROGNAME VERSION
    Gosub, MAIN
Return

; [MENU ABOUT]
ABOUT:
    Gui,2:Destroy
	Gui 2:Font, s13 w600 c0x333333, Segoe UI
	Gui 2:Add, Text, x55 y3 w167 h23 +0x200, % PROGNAME
	Gui 2:Font
	Gui 2:Font, s8 c0x333333, Segoe UI
	Gui 2:Add, Text, x26 y22 w165 h23 +0x200, % ODESIGNS
	Gui 2:Font
	Gui 2:Font, s9 c0x333333
	Gui 2:Add, Text, x30 y50 w120 h23 +0x200, % "File Version:`t" VERSION
	Gui 2:Add, Text, x30 y70 w160 h23 +0x200, % "Release Date:`t" RELEASEDATE
	Gui 2:Font
	Gui 2:Font, s9 c0x808080, Segoe UI
	Gui 2:Add, Link, x46 y100 w171 h23, % "<a href=""" PROGNAME """>" AUTHOR "</a>"
	Gui 2:Font
	Gui 2:Add, Button, x83 y123 w44 h23 gGuiClose2, &OK

	Gui 2:Show, w210 h150, % "About"
Return

SETTINGS:
    Hotkey, %HOTKEYS_hotkey1%, Off
    Hotkey, %HOTKEYS_hotkey2%, Off
    Gui,2:Destroy
    Gui,2:-MinimizeBox -MaximizeBox
    Gui,2:Add, GroupBox, x8 y10 w144 h54, Suspend on Launch
    Gui,2:Add, CheckBox, x25 y32 w120 h23 vSnC +Checked, Suspend and Close
    Gui,2:Add, GroupBox, x9 y74 w144 h54, Suspension Time (ms)
    Gui,2:Add, Edit, vSuspTime x20 y95 w120 h21 vSuspensionTime, % OPTIONS_time
    Gui,2:Font, s10
    Gui,2:Add, GroupBox, x8 y138 w144 h174, HotKeys
    Gui,2:Font
    Gui,2:Add, GroupBox, x8 y160 w144 h80, Suspend
    Gui,2:Add, Hotkey, x20 y180 w120 h21  vhotkey1 , % HOTKEYS_hotkey1
    Gui,2:Add, Text, x22 y202 w120 h23 +0x200, % "Current: " . HOTKEYS_hotkey1
    Gui,2:Add, GroupBox, x8 y232 w144 h80, Terminate
    Gui,2:Add, Hotkey, x20 y252 w120 h21 vhotkey2 , % HOTKEYS_hotkey2
    Gui,2:Add, Text, x22 y274 w120 h23 +0x200, % "Current: " . HOTKEYS_hotkey2

    Gui,2:Add, Button, xm y+20 w66 Default gSETTINGSOK, &OK
    Gui,2:Add, Button, x+8 yp w66 gSETTINGSCANCEL, &CANCEL

    if ( OPTIONS_snclose ) {
            GuiControl,2:, SnC, 1
            OPTIONS_snclose := 0
        } else {
            GuiControl,2:, SnC, 0
            OPTIONS_snclose := 1
    }

    Gui,2:Show, w160 h360, Settings
Return

SETTINGSOK:
    Gui,2:Submit
    GuiControlGet, SuspendnClose, , SnC,
    OPTIONS_time := SuspensionTime
    Ini_write(CONFIGURATION_FILE, "OPTIONS", "time", SuspensionTime)
    Ini_write(CONFIGURATION_FILE, "OPTIONS", "snclose", SuspendnClose)

    If hotkey1<>
    {
        New_hotkey1 := hotkey1
        Ini_write(CONFIGURATION_FILE, "HOTKEYS", "hotkey1", New_hotkey1)
    }
    If hotkey2<>
    {
        New_hotkey2 := hotkey2
        Ini_write(CONFIGURATION_FILE, "HOTKEYS", "hotkey2", New_hotkey2)
    }
    Hotkey, %New_hotkey1%, SUSPEND
    Hotkey, %New_hotkey2%, END
Return

SETTINGSCANCEL:
    Gui,2:Destroy
    Hotkey, %HOTKEYS_hotkey1%, SUSPEND
    Hotkey, %HOTKEYS_hotkey2%, END
Return

GUICLOSE2:
	Gui 2:Hide
Return
