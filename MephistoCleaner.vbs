Set objShell = CreateObject("Shell.Application")
objShell.ShellExecute "powershell.exe", "-NoProfile -ExecutionPolicy Bypass -WindowStyle Hidden -File """ & Replace(WScript.ScriptFullName, "MephistoCleaner.vbs", "MephistoCleaner.ps1") & """", "", "runas", 0
