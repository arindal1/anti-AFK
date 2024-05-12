@echo off
setlocal

REM Configurable parameters
set "idle_threshold=10"
set "mouse_move_range=-20,20"
set "punch_characters=abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!@#$%^&*()_+-=[]{}|;:,.<>?"

REM Start PowerShell script to perform anti-AFK actions
powershell.exe -Command "& { .\AntiAFK.ps1 -IdleThreshold %idle_threshold% -MouseMoveRange %mouse_move_range% -PunchCharacters '%punch_characters%' }"
