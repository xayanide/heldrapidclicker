#Requires AutoHotkey v2.0
#SingleInstance Prompt
; HeldRapidClicker
; A lightweight and straightforward AutoHotkey v2 script that allows the user to rapidly perform left-clicks while holding the left mouse button.
; It also includes a hotkey to toggle the macro on and off.
; Warning: Use this script with caution, always check if the macro is turned on or off. Rapid left-clicks may lead to unintended actions, such as accidentally clicking buttons.
; Disclaimer: I am not responsible for any consequences that may arise from the use of my script.

; ListLines(0)

global globals := Map()
globals["version"] := "v1.0.3"

; --------------------
; Configuration
; --------------------
; For the configuration changes to take effect, reload or restart the script.

globals["config"] := Map()

; MACRO_HOTKEY (String)
;   Hotkey for toggling the macro on or off.
;   You can set your own hotkey here
;   Refer to these links:
;   https://www.autohotkey.com/docs/v2/Hotkeys.htm
;   https://www.autohotkey.com/docs/v2/KeyList.htm
;   Original value is CTRL + E or ^e in AHK notation
;   Default value
;   ^e
globals["config"]["MACRO_HOTKEY"] := "^e"

; CLICK_INTERVAL (Number, Milliseconds)
;   The delay in between left clicks when the left mouse button is held.
;   Recommended values are 5 or 10. It's a good balance.
;   Okay values range from 1 and above
;   NOT RECOMMENDED values are 0 or -1
;   Reference https://www.autohotkey.com/docs/v2/lib/Sleep.htm
;   Default value
;   10
globals["config"]["CLICK_INTERVAL"] := 0

; USE_FAST_MODE (Boolean)
;   Enabling this will use another method to simulate clicks through direct use of the mouse event API of Windows.
;   This setting will still be affected by the value of CLICK_INTERVAL.
;   To simulate clicks as fast as possible (The only limiting factor is the hardware used):
;   Set USE_FAST_MODE to true and CLICK_INTERVAL set as 0 or -1.
;   WARNING: SETTING THE COMBINATION ABOVE IS NOT RECOMMENDED AS IT CAN SIGNIFICANTLY OVERWHELM YOUR SYSTEM'S INPUTS
;   Default value
;   false
globals["config"]["USE_FAST_MODE"] := false

; --------------------
; Script
; --------------------

globals["states"] := Map()
globals["states"]["isMacroToggle"] := false
globals["states"]["isTooltipVisible"] := false
globals["states"]["lastCursorTooltipText"] := ""
globals["states"]["tray"] := Map()
globals["states"]["tray"]["lastIconTooltipText"] := ""
globals["states"]["tray"]["lastIconNumber"] := 0

; Updates the script's system tray icon to reflect the macro's new state
; This helps visually show to the user whether the macro is on or off
updateSystemTrayIcon()
{
    updateSystemTrayIconTooltip()
    iconNumber := globals["states"]["isMacroToggle"] ? 233 : 230
    ; I will be using native Windows icons for this, I want it simple as possible
    ; imageres.dll https://renenyffenegger.ch/development/Windows/PowerShell/examples/WinAPI/ExtractIconEx/imageres.html
    ; shell32.dll https://renenyffenegger.ch/development/Windows/PowerShell/examples/WinAPI/ExtractIconEx/shell32.html
    filePath := "imageres.dll"
    if (globals["states"]["tray"]["lastIconNumber"] = iconNumber)
    {
        return
    }
    globals["states"]["tray"]["lastIconNumber"] := iconNumber
    TraySetIcon(filePath, iconNumber)
}

; Updates the script's system tray icon tooltip text
; Can be seen when user the hovers over the scripts's system tray icon
updateSystemTrayIconTooltip()
{
    toolTipText := globals["states"]["isMacroToggle"] ? Format("[ON] HeldRapidClicker {1}", globals["version"]) : Format("[OFF] HeldRapidClicker {1}", globals["version"])
    if (globals["states"]["tray"]["lastIconTooltipText"] = toolTipText)
    {
        return
    }
    ; Update system tray icon tooltip text based on the current state, hover on the system tray icon to see this
    globals["states"]["tray"]["lastIconTooltipText"] := toolTipText
    A_IconTip := toolTipText
}

; Display a tooltip text at the bottom right of the user's cursor to indicate the macro's new state
; Helps the user confirm that the macro state has changed
showCursorTooltip(duration)
{
    tooltipText := globals["states"]["isMacroToggle"] ? "[ON] HeldRapidClicker" : "[OFF] HeldRapidClicker"
    ; If the tooltip is already visible
    if (globals["states"]["isTooltipVisible"])
    {
        if (globals["states"]["lastCursorTooltipText"] = tooltipText)
        {
            return
        }
        ; Update it immediately
        globals["states"]["lastCursorTooltipText"] := tooltipText
        ToolTip(tooltipText)
        return
    }
    if (globals["states"]["lastCursorTooltipText"] != tooltipText)
    {
        globals["states"]["lastCursorTooltipText"] := tooltipText
        ; Show the tooltip
        ToolTip(tooltipText)
    }
    ; Set a timer to hide the tooltip after the duration is met
    SetTimer(hideCursorTooltip, duration)
}

; Hides any tooltip from the user's cursor
hideCursorTooltip()
{
    if (globals["states"]["lastCursorTooltipText"] != "")
    {
        globals["states"]["lastCursorTooltipText"] := ""
        ToolTip("")
    }
}

; Handles the behavior when the user presses and holds the Left Mouse Button (LButton)
; It simulates repeated left-clicks while the button is held down, with the configured delay between clicks
onUserLeftMouseButtonPress(*)
{
    ; Use a faster method by directly accessing the mouse event API of Windows if "USE_FAST_MODE" is enabled
    if (globals["config"]["USE_FAST_MODE"])
    {
        ; Remove the warning for HotkeyInterval
        A_HotkeyInterval := 0
        ; Enter a loop that continues as long as the Left Mouse Button (LButton) is physically pressed
        loop
        {
            ; Left mouse button is no longer pressed, do nothing
            if (!GetKeyState("LButton", "P"))
            {
                break
            }
            ; At the user's current cursor position:
            ; Simulate a single left mouse button press (Pressed down)
            DllCall("mouse_event", "UInt", 0x02)
            ; Simulate a single left mouse button release (Released up)
            DllCall("mouse_event", "UInt", 0x04)
            ; Wait for the configured interval between clicks.
            ; The delay duration is set based on the user-defined value in CLICK_INTERVAL
            Sleep(globals["config"]["CLICK_INTERVAL"])
        }
        ; End the function here to not touch the fallback method
        return
    }
    ; Fall back to standard AHK method
    ; Enter a loop that continues as long as the Left Mouse Button (LButton) is physically pressed
    while GetKeyState("LButton", "P")
    {
        ; Simulate a single left mouse button click at the user's current cursor position
        SendInput("{LButton Down}{LButton Up}")
        ; Wait for the configured interval between clicks.
        ; The delay duration is set based on the user-defined value in config["CLICK_INTERVAL"]
        Sleep(globals["config"]["CLICK_INTERVAL"])
    }
}

; Handles the behavior when the user presses the macro's configured hotkey
; It toggles the macro's state between ON and OFF, updates visual feedback like the system tray icon,
; and sets or removes the left mouse button hotkey based on the new state
onMacroToggle(*)
{
    ; Toggle the macro state
    ; If the macro is currently enabled (true), it will be disabled (false)
    ; If the macro is currently disabled (false), it will be enabled (true)
    globals["states"]["isMacroToggle"] := !globals["states"]["isMacroToggle"]

    updateSystemTrayIcon()
    showCursorTooltip(-1000)

    ; If the macro is now toggled ON
    if (globals["states"]["isMacroToggle"])
    {
        ; Define the left mouse button ("~LButton") as a hotkey
        ; This means when the user presses the left mouse button,
        ; the function onUserLeftMouseButtonPress will be executed
        Hotkey("~$LButton", onUserLeftMouseButtonPress, "On")
        ; I will just early return here, I don't like using else statements sometimes lol
        return
    }
    ; Reset A_HotkeyInterval back to default
    if (A_HotkeyInterval != 2000)
    {
        A_HotkeyInterval := 2000
    }
    ; If the macro is now toggled OFF
    ; Suspend (disable) the left mouse button hotkey
    ; This stops onUserLeftMouseButtonPress from running when the user clicks the left mouse button
    Hotkey("~$LButton", onUserLeftMouseButtonPress, "Off")
}

; Displays a neat startup message box with the applied settings
showStartupMsgBox()
{
    mainText := "Current settings:"
        . "`n[Hotkey to Toggle Macro]"
        . Format("`n{1}", globals["config"]["MACRO_HOTKEY"])
        . "`n"
        . "`n[Click Interval]"
        . Format("`n{1} ms", globals["config"]["CLICK_INTERVAL"])
        . "`n"
        . "`n[Fast Mode Enabled]"
        . Format("`n{1}", (globals["config"]["USE_FAST_MODE"] ? "Yes" : "No")) 

    if (globals["config"]["CLICK_INTERVAL"] <= 0 || (globals["config"]["USE_FAST_MODE"] && globals["config"]["CLICK_INTERVAL"] <= 0))
    {
        ; Append a warning text to the main text
        mainText .= "`n`n[WARNING]`n THESE SETTINGS CAN OVERWHELM YOUR SYSTEM'S INPUTS!"
        warningText := "Warning: The current settings can overwhelm your system's inputs!"
            . "`n[Click Interval]"
            . Format("`n{1}ms", globals["config"]["CLICK_INTERVAL"])
            . "`n[Fast Mode Enabled]"
            . Format("`n {1}", (globals["config"]["USE_FAST_MODE"] ? "Yes" : "No")) 
            . "`n`nWould you like to continue?"
        ; Show a separate warning message box
        userInput := MsgBox(warningText, Format("HeldRapidClicker {1}", globals["version"]), "YesNo")
        if (userInput = "No")
        {
            ExitApp()
        }
    }

    ; Append the rest of the message
    mainText .= "`n"
        . "`nInstructions:"
        . "`n1. Press " globals["config"]["MACRO_HOTKEY"] " to toggle the macro ON/OFF."
        . "`n2. When ON, hold down the left mouse button to perform rapid clicks."
        . "`n"
        . "`nNotes:"
        . "`n- Right-click the tray icon to exit the script."
        . "`n- Use responsibly. Rapid left-clicks may lead to unintended actions."
        . "`n"
        . "`nScript will continue running in the background."
        . "`nThis window will automatically close itself in 60 seconds."

    ; Display the main message box
    MsgBox(mainText, Format("HeldRapidClicker {1}", globals["version"]), "T60")
}

; On initial start up
main()
{
    updateSystemTrayIcon()
    showStartupMsgBox()
    ; Define what was configured as the hotkey for the macro
    Hotkey(globals["config"]["MACRO_HOTKEY"], onMacroToggle, "On")
}

SetMouseDelay(-1)
KeyHistory(0)
main()