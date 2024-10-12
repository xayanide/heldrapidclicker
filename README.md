# Momentary Switch Rapid Clicker Macro
A straightforward toggleable AutoHotkey V2 macro script that allows the user to rapidly perform left-clicks as long as the left mouse button is held down.
> [!WARNING]
> Use this script with caution, always check if the macro is turned on or off. Rapid left-clicks may lead to unintended actions, such as accidentally clicking buttons.

> [!NOTE]
> Disclaimer: I am not responsible for any consequences that may arise from the use of my script.

## Features
- Hold your left mouse button to rapidly perform left-clicks with `10ms` of delay in between by default. In 5 seconds CPS tests, it can click as fast up to 60 CPS max.
- Toggle the macro on or off with the keyboard shortcut `CTRL + E`, this is configurable!
- System tray icon and tooltip text that appears when hovered. This indicates whether the macro is turned on or off.
- A cursor tooltip that appears at the bottom right of the user's cursor right when the macro is toggled.

### Credits
- https://www.autohotkey.com/docs/v2

## Prerequisites
- AutoHotkey V2.0 or later versions.

## Installation

There are several methods to install these kind of scripts from GitHub; however, we'll just focus on the most commonly used method.

This method involves creating and saving a new file to the location you want.
1. Copy everything, all the code from this link
- https://raw.githubusercontent.com/xayanide/momentary-switch-rapid-clicker-macro/refs/heads/master/momentary-switch-rapid-clicker-macro.ahk
 
1. Open up `Notepad`, `Notepad++` or any other text editor you're comfortable using.
 
2. Paste the code you have copied (ensure you have copied and pasted everything)
> [!TIP]
> You can modify configuration while you're at it. Only if you know what you're doing.
 
3. On your text editor, there should be `File` at the top-left, hover your mouse cursor over that then left-click on `Save it as`.

4. A window will pop-up, choose where you want to save the file. Below are the things you can input
**File Name:** Any name will work, but make sure the file's name ends with `.ahk`
**Save as type:** All Files (*.*)
> [!TIP]
> - Save it somewhere you can easily find and remember, such us the Desktop.
> - There are keyboard shortcuts to `Save` or `Save as` text documents.
> - **.ahk** is the file extension for AutoHotkey files.

> [!NOTE]
> Please do not confuse `Save it as` from `Save`. 
> - If you’re working on a document or file that has already been saved previously, selecting `Save` will overwrite the current version of that file with your new changes.
> - When you select `Save As` the application will prompt you to specify a new file name and location, allowing you to create a copy of the file or overwrite an existing file.
 
## Usage

**Running the script**

- Double left-click the `.ahk` file to run the script or right-click the `.ahk` file then left-click `Run script`.
> [!TIP]
> The script will continue running in the background until the user shutdowns the computer or manually exits out the script.

**Using the script**

- Toggle it on and off by pressing the keyboard combination `CTRL + E`. This is configurable.
- Hold press your left mouse button.
> [!WARNING]
> - Be cautious on where you click while the macro is toggled on!

**Closing the script**

To close the script completely, navigate to your system's taskbar, find and right-click its system tray icon and left-click on `Exit`

## Contributing
Anything meaningful would be great! Make sure the checks are passing, and there are no reasons to deny your pull request.
