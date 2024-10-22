## Features
- Hold your left mouse button to rapidly perform left-clicks with `10ms` of delay in between by default. In CPS tests, it can click as fast up to 60 CPS or more!
- Toggle the macro on or off with the keyboard shortcut `CTRL + E`, this is configurable!
- System tray icon and tooltip text that appears when hovered. This indicates whether the macro is turned on or off.
- A tooltip text that appears at the bottom right of the user's cursor right after the macro is toggled.

## Performance
In `v0.0.1`, the left mouse button (`LButton`) hotkey is always active, meaning the script is always listening for clicks. Even if the macro is off, AHK will still execute this polling logic in the background, although it does nothing at the end.

Starting in `v1.0`, the left mouse button (`LButton`) hotkey gets suspended when the macro is off since the `LButton` hotkey is dynamically removed, which saves a tiny bit of system resources.

## v1.0.1 changes
- feat: add USE_FAST_MODE as another method to simulate clicks 
- refactor: removal of all parentheses from all function calls
- refactor: explicit variable declarations

## v1.0.2 changes
- refactor: use of camel case for variable names
- docs: elaboration
- feat: neat startup message box, moved version somewhere else
- refactor: remove explicit variable scope declarations
- refactor: rewrap all function calls with parentheses

## v1.0.3 changes
- refactor: encapsulate global vars

## v1.0.4
- fix: remove architecture requirement on old script
- fix: prevent recursive triggering no matter what
- refactor: shorter memorable name
