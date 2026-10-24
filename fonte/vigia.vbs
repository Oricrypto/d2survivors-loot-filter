' Roda o vigia.bat sem abrir janela (a tarefa agendada chama este arquivo com wscript).
Set sh = CreateObject("WScript.Shell")
Set fso = CreateObject("Scripting.FileSystemObject")
dir = fso.GetParentFolderName(WScript.ScriptFullName)
sh.Run """" & dir & "\vigia.bat""", 0, True
