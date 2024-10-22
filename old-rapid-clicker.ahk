; Momentary Switch Rapid Clicker Macro v0.0.1 - 10/4/2024
; NOTE: This is an older version of the script I wrote that does exactly the same thing in the latest version, except:
; - There is a delay between toggles because of the Sleep function used for hiding the cursor tooltip after 1 second.
; Due to this, the user is always limited to toggling the macro 1 second at a time.
; - The hotkeys are always defined for as long as the script runs.
; This also means the script actively listens for Left Mouse Button presses even when the macro is toggled on or off, it is not a problem however because I set it to do nothing if the macro is toggled off.
; - No system tray icon and system tray icon tooltip
; It still gets the job done though and is much more simple

#Requires AutoHotkey v2.0
#SingleInstance Prompt

; Removes delays between mouse events
SetMouseDelay(-1)
; Remove delays between script lines (Disabled, no longer needed in AHK v2.0)
; Because as of AHK v2, all scripts run at full speed:
; https://www.autohotkey.com/boards/viewtopic.php?style=1&t=121942
; https://www.autohotkey.com/docs/v2/v2-changes.htm#default-settings
; SetBatchLines -1

isMacroToggle := false

; Ctrl + E is pressed
^E::
{
    global isMacroToggle
    isMacroToggle := !isMacroToggle
    ToolTip(isMacroToggle ? "[ON] Momentary activation" : "[OFF] Momentary activation")
    ; Wait for 1 second before removing the cursor tooltip
    Sleep(1000)
    ToolTip("")
    return
}

; Left mouse button is pressed
~$LButton::
{
    global isMacroToggle
    ; Macro is disabled, do nothing
    if (!isMacroToggle)
    {
        return
    }
    ; Macro is enabled
    ; While the left mouse button is pressed, rapidly perform a left-click again and again
    ; until the user releases the left mouse button.
    while GetKeyState("LButton", "P")
    {
        Click()
        Sleep(10)
    }
}
