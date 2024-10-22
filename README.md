# HeldRapidClicker (Momentary Switch Rapid Clicker Macro)
A lightweight and straightforward AutoHotkey v2 script that allows the user to rapidly perform left-clicks while holding the left mouse button. It also includes a hotkey to toggle the macro on and off.
> [!WARNING]
> Use this script with caution especially while doing important stuff, always check if the script is active or its macro is turned on or off. Rapid left-clicks may lead to unintended actions, such as accidentally clicking buttons you're not aware of and closing applications.

> [!NOTE]
> Disclaimer: I am not responsible for any consequences that may arise from the use of my script.

## Features
- Hold your left mouse button to rapidly perform left-clicks with `10ms` of delay in between by default. In CPS tests, it can click as fast up to 60 CPS or more!
- Toggle the macro on or off with the keyboard shortcut `CTRL + E`, this is configurable!
- System tray icon and tooltip text that appears when hovered. This indicates whether the macro is turned on or off.
- A tooltip text that appears at the bottom right of the user's cursor right after the macro is toggled.

### Credits
- https://www.autohotkey.com/docs/v2

## Prerequisites
- [AutoHotkey v2](https://www.autohotkey.com/v2) or later versions. (Download the installer here: https://www.autohotkey.com/download/ahk-v2.exe)

## Installation

There are several methods to install these kind of scripts from GitHub; however, we'll just focus on the most commonly used methods.

**METHOD 1**
> Direct download method

**1.** Download the latest script directly from this link

https://github.com/xayanide/heldrapidclicker/releases/latest/download/heldrapidclicker.ahk

**2.** Proceed to [Usage](#usage) section.

**METHOD 2**
> This method involves creating and saving a new file to the location you want.

**1.** Copy everything, all the code from this link

https://raw.githubusercontent.com/xayanide/heldrapidclicker/refs/heads/master/heldrapidclicker.ahk

**2.** Open up `Notepad`, `Notepad++` or any other text editor you're comfortable using.

**3.** Paste the code you have copied (ensure you have copied and pasted everything)
> [!TIP]
> You can modify the configuration while you're at it. Only if you know what you're doing.

**4.** On your text editor, there should be `File` at the top-left, hover your mouse cursor over that then left-click on `Save it as`.

**5.** A window will pop-up, choose where you want to save the file. Below are the things you can modify

`File Name:` Choose your desired name for the file, but make sure the file's name ends with `.ahk`
`Save as type:` All Files (*.*)

> [!TIP]
> - Save it somewhere you can easily find and remember, such us the Desktop.
> - There are keyboard shortcuts to `Save` or `Save as` text documents.
> - **.ahk** is the file extension for AutoHotkey files.

**6.** Proceed to [Usage](#usage) section.

> [!NOTE]
> Please do not confuse `Save it as` from `Save`. 
> - If you’re working on a document or file that has already been saved previously, selecting `Save` will overwrite the current version of that file with your new changes.
> - When you select `Save As` the application will prompt you to specify a new file name and location, allowing you to create a copy of the file or overwrite an existing file.


## Usage

**Running the script**

**1.** Double left-click the `.ahk` file to run the script or right-click the `.ahk` file then left-click `Run script`.
> [!TIP]
> The script will continue running in the background until the user shutdowns the computer or manually exits out the script.

**Using the script**

**1.** Toggle it on and off by pressing the keyboard combination `CTRL + E`. This is configurable.

**2.** Hold press your left mouse button.
> [!WARNING]
> - Be cautious on where you click while the macro is toggled on!

**Closing the script**

**1.** Navigate to your system's taskbar, find and right-click its system tray icon and left-click on `Exit`

## Bannable?
It depends on where you're using it and the program you're running it on. AutoHotkey doesn't try to hide itself, so be careful if the platform bans macros!

## Contributing
Anything meaningful would be great! Make sure the checks are passing, and there are no reasons to deny your pull request.
