#Requires Autohotkey v2.0-

/**
 * v1.0.0 | By iPhilip | [AHK Forum Post](https://www.autohotkey.com/boards/viewtopic.php?t=34821)  
 * v1.0.0 | Converted By RaptorX | [AHK Forum Post](https://www.autohotkey.com/boards/viewtopic.php?t=111036)
 *
 * ---
 *
 * Determines if a window is docked  
 * Tested with: AHK 2.0-rc.1 32/64 bit  
 * Tested on:   Win 10 (64bit)
 *
 * #### MSDN links:
 * - [GetWindowPlacement function](https://msdn.microsoft.com/en-us/library/windows/desktop/ms633518(v=vs.85).aspx)
 * - [WINDOWPLACEMENT structure](https://msdn.microsoft.com/en-us/library/windows/desktop/ms632611(v=vs.85).aspx)
 * ---
 *
 * ### Parameters:
 * - `window` - the window object or handle of the window being tested
 *
 * ### Returns:
 * - `loc`  - the resulting location of the docked window:
 *	- `-1`    - if the window is docked on the left
 *	- `0`     - if the window is docked on the top and bottom
 *	- `1`     - if the window is docked on the right
 *	- `blank` - if the window is not docked
 *
 * ### Examples:
 *
 * #### Passing a Window Hwnd
 * ```
 f1::MsgBox IsWindowDocked(WinExist('Untitled - Notepad'))
 * ```
 *
 * #### Passing an object
 * ```
 main := Gui()
 main.Show('w200 h200')
 return

 f1::MsgBox IsWindowDocked(main) ? 'docked' : 'not docked'
 * ```
 */
IsWindowDocked(window)
{
	static SW_SHOWNORMAL := 1
	WP := Buffer(44)
	if !DllCall("GetWindowPlacement", "Ptr", IsObject(window) ?  window.hwnd : window, "Ptr", WP)
		throw Error('Couldn`'t get the window placement.', A_ThisFunc, A_LastError)

	sw := NumGet(WP,  8, "UInt")       ; showCmds         - current show state of the window
	x0 := NumGet(WP, 28, "Int")        ; rcNormalPosition - x coordinate of the window in its restored state
	y0 := NumGet(WP, 32, "Int")        ; rcNormalPosition - y coordinate of the window in its restored state
	w0 := NumGet(WP, 36, "Int") - x0   ; rcNormalPosition - width of the window in its restored state
	h0 := NumGet(WP, 40, "Int") - y0   ; rcNormalPosition - height of the window in its restored state

	if IsObject(window)
		window.GetPos &x1, &y1, &w1, &h1
	else
		WinGetPos &x1, &y1, &w1, &h1, "ahk_id" window

	; Determine if the window is docked by comparing coordinates and sizes
	docked := sw = SW_SHOWNORMAL ? (x0 != x1 || y0 != y1 || w0 != w1 || h0 != h1) : ""

	; Determine how the window is docked by examining the left/right side of the window
	loc := docked ? (x1 <= 0 ? -1 : (x1 + w1 >= A_ScreenWidth ? 1 : 0)) : ""
	Return loc
}