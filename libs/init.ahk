; Created by 		Cristófano Varacolaci 
; For 			 	ObsessedDesigns Studios™, Inc.
; Version 			1.0.0
; Build             10:30 2021.11.20

/*
**********************
; OPTIMIZATIONS
**********************
*/
;http://ahkscript.org/boards/viewtopic.php?f=6&t=6413
SetWorkingDir, %A_ScriptDir%
#NoEnv
#MaxHotkeysPerInterval 99000000
#HotkeyInterval 99000000
#KeyHistory 0
ListLines Off
;Process, Priority, , H ;if unstable, comment or remove this line
SetBatchLines, -1
SetKeyDelay, -1, -1, Play
SetMouseDelay, -1
SetDefaultMouseSpeed, 0
SetWinDelay, -1
SetControlDelay, -1
SendMode Input
SetTitleMatchMode 2
SetTitleMatchMode Fast
FileEncoding, UTF-8

global ini_LANG := "" , H_Compiled := RegexMatch(Substr(A_AhkPath, Instr(A_AhkPath, "\", 0, 0)+1), "iU)^(RDO_SL).*(\.exe)$") && (!A_IsCompiled) ? 1 : 0
global mainIconPath := H_Compiled || A_IsCompiled ? A_AhkPath : "icons/icon.ico"

/*
**************************
PROGRAM VARIABLES GLOBALS
**************************
*/
global PROGNAME 	:= "RDO Solo Lobby"
global VERSION 		:= "1.0"
global RELEASEDATE 	:= "Nov 20, 2021"
global AUTHOR 		:= "Cristófano Varacolaci"
global ODESIGNS 	:= "obsessedDesigns Studios™, Inc."
global AUTHOR_PAGE 	:= "http://obsesseddesigns.com"
global AUTHOR_MAIL 	:= "cristo@obsesseddesigns.com"
global CONFIGURATION_FILE := "settings.ini"

;read ini file for VARIABLES
OPTIONS_exename := "RDR2.exe"
variablesFromIni(CONFIGURATION_FILE)

VERSION := SYSTEM_version
VERSION := ((!VERSION) ? ("1.0") : (VERSION))

ini_LANG := SYSTEM_lang
ini_LANG := ((!ini_LANG) ? ("english") : (ini_LANG))

/*
**********************
; INITIALIZATION
**********************
*/
#SingleInstance, Force
#Persistent
DetectHiddenText, on
DetectHiddenWindows, On
CoordMode, Mouse, Screen

Change_Icon(mainIconPath)
OnExit, END