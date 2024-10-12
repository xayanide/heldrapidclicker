; Momentary Switch Rapid Clicker Macro v1.0
; A straightforward toggleable AutoHotkey v2.0 macro script that allows the user to rapidly perform left-clicks as long as the left mouse button is held down.
; Warning: Use this script with caution, always check if the macro is turned on or off. Rapid left-clicks may lead to unintended actions, such as accidentally clicking buttons.
; Disclaimer: I am not responsible for any consequences that may arise from the use of my script.

; A directive for the script to require AutoHotkey v2.0
#Requires AutoHotkey v2.0 64-bit
; A directive to prompt if there is already a running instance, so that only one instance of this script can be run at the same time
#SingleInstance Prompt

; --------------------
; Configuration
; --------------------
; For the configuration changes to take effect, reload or restart the script.

config := Map()

; MACRO_HOTKEY (String)
;   Hotkey for toggling the macro on or off.
;   You can set your own hotkey here
;   Refer to these links:
;   https://www.autohotkey.com/docs/v2/Hotkeys.htm
;   https://www.autohotkey.com/docs/v2/KeyList.htm
;   Original value is CTRL + E or ^e in AHK notation
;   Default value
;   ^e
config["MACRO_HOTKEY"] := "^e"

; CLICK_INTERVAL (Number, Milliseconds)
;   The delay in between left clicks when the left mouse button is held.
;   Recommended values are 5 or 10. It's a good balance.
;   Okay values range from 1 and above
;   NOT RECOMMENDED values are 0 or -1
;   Reference https://www.autohotkey.com/docs/v2/lib/Sleep.htm
;   Default value
;   10
config["CLICK_INTERVAL"] := 10

; USE_FAST_MODE (Boolean)
;   Enabling this will use another method to simulate clicks through direct use of the mouse event API of Windows.
;   This setting will still be affected by the value of CLICK_INTERVAL.
;   To simulate clicks as fast as possible (The only limiting factor is the hardware used):
;   Set USE_FAST_MODE to true and CLICK_INTERVAL set as 0 or -1.
;   WARNING: SETTING THE COMBINATION ABOVE IS NOT RECOMMENDED AS IT CAN SIGNIFICANTLY OVERWHELM YOUR SYSTEM'S INPUTS
;   Default value
;   false
config["USE_FAST_MODE"] := false

; --------------------
; Script
; --------------------
; Removes delays between mouse events https://www.autohotkey.com/docs/v2/lib/SetMouseDelay.htm
SetMouseDelay -1

states := Map()
states["isMacroToggle"] := false
states["isTooltipVisible"] := false

; Updates the script's system tray icon to reflect the macro's new state
; This helps visually show to the user whether the macro is on or off
UpdateSystemTrayIcon()
{
    UpdateSystemTrayIconTooltip()
    iconNumber := states["isMacroToggle"] ? 233 : 230
    ; I will be using native Windows icons for this, I want it simple as possible
    ; imageres.dll https://renenyffenegger.ch/development/Windows/PowerShell/examples/WinAPI/ExtractIconEx/imageres.html
    ; shell32.dll https://renenyffenegger.ch/development/Windows/PowerShell/examples/WinAPI/ExtractIconEx/shell32.html
    FilePath := "imageres.dll"
    TraySetIcon FilePath, iconNumber
}

; Updates the script's system tray icon tooltip text
; Can be seen when the hovers over the scritp's system tray icon
UpdateSystemTrayIconTooltip()
{
    ; Update system tray icon tooltip text based on the current state, hover on the system tray icon to see this
    A_IconTip := states["isMacroToggle"] ? "[ON] Momentary Switch Rapid Clicker Macro" :
        "[OFF] Momentary Switch Rapid Clicker Macro"
}

; Display a tooltip text at the bottom right of the user's cursor to indicate the macro's new state
; Helps the user confirm that the macro state has changed
ShowCursorTooltip()
{
    local TooltipText := states["isMacroToggle"] ? "[ON] Momentary Switch Rapid Clicker" :
        "[OFF] Momentary Switch Rapid Clicker"
    ; If the tooltip is already visible
    if (states["isTooltipVisible"])
    {
        ; Update it immediately
        ToolTip TooltipText
        return
    }
    ; Show the tooltip
    ToolTip TooltipText
    ; Set a timer to hide the tooltip after 1 second
    SetTimer HideCursorTooltip, 1000
}

; Hides any tooltip from the user's cursor
HideCursorTooltip()
{
    ToolTip ""
    ; Remove the timer after hiding the tooltip
    SetTimer HideCursorTooltip, 0
}

; Handles the behavior when the user presses and holds the Left Mouse Button (LButton)
; It simulates repeated left-clicks while the button is held down, with the configured delay between clicks
OnUserLeftMouseButtonPress(*)
{
    ; Use a faster method by directly accessing the mouse event API of Windows if "USE_FAST_MODE" is enabled
    if (config["USE_FAST_MODE"])
    {
        ; Remove the warning for HotkeyInterval
        A_HotkeyInterval := 0
        loop
        {
            ; Left mouse button is no longer pressed, do nothing
            if (!GetKeyState("LButton", "P")) {
                break
            }
            ; Simulate a single left mouse button press (Pressed down)
            DllCall "mouse_event", "UInt", 0x02
            ; Simulate a single left mouse button release (Released up)
            DllCall "mouse_event", "UInt", 0x04
            ; Wait for the configured interval between clicks.
            ; The delay duration is set based on the user-defined value in config["CLICK_INTERVAL"]
            Sleep config["CLICK_INTERVAL"]
        }
        ; Ends the function here to not touch the fallback method
        return
    }
    ; Fall back to standard AHK method
    ; Enter a loop that continues as long as the Left Mouse Button (LButton) is physically pressed
    while GetKeyState("LButton", "P")
    {
        ; Simulate a single left mouse button click at the user's current cursor position
        Click
        ; Wait for the configured interval between clicks.
        ; The delay duration is set based on the user-defined value in config["CLICK_INTERVAL"]
        Sleep config["CLICK_INTERVAL"]
    }
}

; Handles the behavior when the user presses the macro's configured hotkey
; It toggles the macro's state between ON and OFF, updates visual feedback like the system tray icon,
; and sets or removes the left mouse button hotkey based on the new state
OnMacroToggle(*)
{
    ; Toggle the macro state
    ; If the macro is currently enabled (true), it will be disabled (false)
    ; If the macro is currently disabled (false), it will be enabled (true)
    states["isMacroToggle"] := !states["isMacroToggle"]

    UpdateSystemTrayIcon()
    ShowCursorTooltip()

    ; If the macro is now toggled ON
    if (states["isMacroToggle"])
    {
        ; Define the left mouse button ("~LButton") as a hotkey
        ; This means when the user presses the left mouse button,
        ; the function OnUserLeftMouseButtonPress will be executed
        Hotkey "~LButton", OnUserLeftMouseButtonPress, "On"
        ; I will just early return here, I don't like using else statements sometimes lol
        return
    }
    ; If the macro is now toggled OFF
    ; Undefine (disable) the left mouse button hotkey
    ; This stops OnUserLeftMouseButtonPress from running when the user clicks the left mouse button
    ; Reset A_HotkeyInterval back to default
    A_HotkeyInterval := 2000
    Hotkey "~LButton", OnUserLeftMouseButtonPress, "Off"
}

; On initial start up
main()
{
    global config, states
    ; Define what was configured as the hotkey for the macro
    Hotkey config["MACRO_HOTKEY"], OnMacroToggle, "On"
    UpdateSystemTrayIcon()
    MsgBox "AutoHotkey macro is now running in the background!`nPlease press " config["MACRO_HOTKEY"] " to toggle it on and off.`n`nTo close the script, right-click its tray icon and click on exit.`n`n`Refer to the AutoHotkey Documentation for reference on setting your own hotkeys:`nhttps://www.autohotkey.com/docs/v2/Hotkeys.htm`nhttps://www.autohotkey.com/docs/v2/KeyList.htm`nThis window will automatically close in 15 seconds.`n- xayanide :)",
        "Momentary Switch Rapid Clicker", "T15"
}
main()
