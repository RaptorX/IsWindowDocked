#Include ..\IsWindowDocked.ahk

main := Gui()
main.Show('w200 h200')
return

f1::MsgBox IsWindowDocked(main) ? 'docked' : 'not docked'