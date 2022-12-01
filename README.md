# IsWindowDocked(window)

v1.0.0 | By iPhilip | [AHK Forum Post](https://www.autohotkey.com/boards/viewtopic.php?t=34821)
v0.1.0 | Converted By RaptorX | [AHK Forum Post]()

---

Determines if a window is docked
Tested with: AHK 2.0-rc.1 32/64 bit
Tested on:   Win 10 (64bit)

---

### Parameters:

- `window` - the window object or handle of the window being tested

### Returns:

- `loc`  - the resulting location of the docked window:
  - `-1`    - if the window is docked on the left
  - `0`     - if the window is docked on the top and bottom
  - `1`     - if the window is docked on the right
  - `blank` - if the window is not docked

### Examples:

##### Passing an object

```
main := Gui()
main.Show('w200 h200')
return

f1::
{
	MsgBox IsWindowDocked(main)
}
```

##### Passing a Window Hwnd

```
Run 'Notepad.exe'
WinWaitActive 'Untitled - Notepad'

f1::
{
	MsgBox IsWindowDocked(WinExist()) ? 'docked' : 'not docked'
}
```
