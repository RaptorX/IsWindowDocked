#Include ..\IsWindowDocked.ahk

if !WinExist('Untitled - Notepad')
{
	Run 'Notepad.exe'
	WinWaitActive 'Untitled - Notepad'
}
return

f1::
{
	loc := IsWindowDocked(WinExist('Untitled - Notepad'))
	switch loc {
		case -1: loc := 'docked left'
		case 0:  loc := 'docked top/bottom'
		case 1:  loc := 'docked right'
		default: loc := 'not docked'
	}
 	MsgBox loc
	return
}