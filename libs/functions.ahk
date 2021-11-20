; Created by 		Josué Alba 
; For 			 	ObsessedDesigns Studios™, Inc.
; Version 			0.1.0.0
; Build 			16:30 2021.10.22
; ==================================================================================================================================
; Function:       variablesFromIni
; Description     read all variables in an ini and store in variables
; Usage:          variablesFromIni(_SourcePath, _VarPrefixDelim = "_")
; Parameters:
;  _SourcePath    	-  path to the ini file ["config/main.ini"]
;  _VarPrefixDelim 	-  This specifies the separator between section name and key name.
; 						All section names and key names are merged into single name.
; Return values:  
;     Variables from the ini, named after SECTION Delimiter KEY
; Change history:
;     1.0.00.00/2020-04-02
; Remarks:
;     oresult -> operation result
variablesFromIni(_SourcePath, _VarPrefixDelim = "_")
{
    Global
    Local FileContent, CurrentPrefix, CurrentVarName, CurrentVarContent, DelimPos
    FileRead, FileContent, %_SourcePath%
    If ErrorLevel = 0
    {
        Loop, Parse, FileContent, `n, `r%A_Tab%%A_Space%
        {
            If A_LoopField Is Not Space
            {
                If (SubStr(A_LoopField, 1, 1) = "[")
                {
                    StringTrimLeft, CurrentPrefix, A_LoopField, 1
                    StringTrimRight, CurrentPrefix, CurrentPrefix, 1
                    CurrentVarName = %CurrentVarName%
                }
                Else
                {
                    DelimPos := InStr(A_LoopField, "=")
                    StringLeft, CurrentVarName, A_LoopField, % DelimPos - 1
                    StringTrimLeft, CurrentVarContent, A_LoopField, %DelimPos%
                    %CurrentPrefix%%_VarPrefixDelim%%CurrentVarName% = %CurrentVarContent%
                }
            }
        }
    }
}
; ==================================================================================================================================

; Created by      Josué Alba 
; For             ObsessedDesigns Studios™, Inc.
; Version         0.1.0.0
; Build        01:12-2018.08.13
; ==================================================================================================================================
; Function:       Ini_write
; Description     writes a value into an ini file
; Usage:          Ini_write(inifile, section, key)
; Parameters:
;  inifile        -  path to the ini file ["config/main.ini"]
;  section        -  section of the ini to read the key from
;  key            -  the key to delete from the ini file
;  value          -  the value to write on
; Return values:  
;     True on success, fail otherwise
; Change history:
;     1.0.00.00/2016-08-13
; Remarks:
;     oresult -> operation result
Ini_write(inifile, section, key, value="", ifblank=false) {
	;ifblank means if the key doesn't exist
	Iniread, v,% inifile,% section,% key

	if ifblank && (v == "ERROR")
		IniWrite,% value,% inifile,% section,% key
   oresult := ErrorLevel ? False : True
	if !ifblank
		IniWrite,% value,% inifile,% section,% key
   oresult := ErrorLevel ? False : True
   Return oresult
}
; ==================================================================================================================================
; Function:       Ini_read
; Description     Reads a value from an ini file
; Usage:          Ini_read(inifile, section, key)
; Parameters:
;  inifile        -  path to the ini file ["config/main.ini"]
;  section        -  section of the ini to read the key from
;  key            -  the key to delete from the ini file
; Return values:  
;     value of the searched key
; Change history:
;     1.0.00.00/2016-08-13
; Remarks:
Ini_read(inifile, section, key){
	Iniread, v, % inifile,% section,% key, %A_space%
	if v = %A_temp%
		v := ""
	return v
}
; ==================================================================================================================================
; Function:       Ini_delete
; Description     Deletes value in an ini file
; Usage:          Ini_delete(inifile, section, key)
; Parameters:
;  inifile        -  path to the ini file ["config/main.ini"]
;  section        -  section of the ini to read the key from
;  key            -  the key to delete from the ini file
; Return values:  
;     True on success, fail otherwise
; Change history:
;     1.0.00.00/2016-08-13
; Remarks:
;     oresult -> operation result
Ini_delete(inifile, section, key){
	IniDelete, % inifile, % section, % key
   oresult := ErrorLevel ? False : True
   Return oresult
}
; ==================================================================================================================================
; Function:       Change_Icon
; Description     Set the icon to the tray depending if it's compiled or not
; Usage:          changeIcon(file)
; Parameters:
;  file           -  path to the icon file ["icons/icon.ico"]
; Return values:  
;     nothing
; Change history:
;     1.0.00.00/2016-08-13
; Remarks:
;     Nothing
Change_Icon(file){
	if A_IsCompiled or H_Compiled 		; H_Compiled is a user var created if compiled with ahk_h
		Menu, tray, icon, % A_AhkPath
	else
		Menu, tray, icon, % file
}

; ==================================================================================================================================
; Function:       Process_Suspend
; Description     suspends an application
; Usage:          Process_Suspend(PID_or_Name)
; Parameters:
;  PID_or_Name    PID or Name for the target  application 
; Return values:  
;     nothing
; Change history:
;     1.0.00.00/2021.11.20
; Remarks:
;     Nothing

Process_Suspend(PID_or_Name){

    PID := (InStr(PID_or_Name,".")) ? ProcExist(PID_or_Name) : PID_or_Name

    h:=DllCall("OpenProcess", "uInt", 0x1F0FFF, "Int", 0, "Int", pid)

    If !h   

        Return -1

    DllCall("ntdll.dll\NtSuspendProcess", "Int", h)

    DllCall("CloseHandle", "Int", h)

}

; ==================================================================================================================================
; Function:       Process_Resume
; Description     Resumes an application
; Usage:          Process_Resume(PID_or_Name)
; Parameters:
;  PID_or_Name    PID or Name for the target  application 
; Return values:  
;     nothing
; Change history:
;     1.0.00.00/2021.11.20
; Remarks:
;     Nothing

Process_Resume(PID_or_Name){

    PID := (InStr(PID_or_Name,".")) ? ProcExist(PID_or_Name) : PID_or_Name

    h:=DllCall("OpenProcess", "uInt", 0x1F0FFF, "Int", 0, "Int", pid)

    If !h   

        Return -1

    DllCall("ntdll.dll\NtResumeProcess", "Int", h)

    DllCall("CloseHandle", "Int", h)

}

; ==================================================================================================================================
; Function:       ProcExist
; Description     Check if a process exist (is running)
; Usage:          ProcExist(PID_or_Name)
; Parameters:
;  PID_or_Name    PID or Name for the target  application 
; Return values:  
;     nothing
; Change history:
;     1.0.00.00/2021.11.20
; Remarks:
;     Nothing


ProcExist(PID_or_Name=""){

    Process, Exist, % (PID_or_Name="") ? DllCall("GetCurrentProcessID") : PID_or_Name

    Return Errorlevel

}