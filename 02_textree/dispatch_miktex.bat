REM add option clone repository from github
sour = c:\checkouts\LatexInstallation\MiKTeX\
dest = c:\Users\chavarri\AppData\Roaming\MiKTeX\
REM alternatively, copy from Jan Mooiman's Bulletin
REM add flag with user location

rem copy to MiKTeX ProgramData directory

rem copy from Jan Mooiman's Bulletin to (do not use, copy from Bulletin to tree in repository)
rem xcopy /s n:\Deltabox\Bulletin\mooiman\latex_installation\MiKTeX  c:\Users\<user>\AppData\Roaming\MiKTeX\

rem copy from local tree to user folder (replace <user> by your user name)
xcopy /s ..\02_textree  c:\Users\<user>\AppData\Roaming\MiKTeX\

rem not necessary, better to use user folder
rem xcopy /s n:\Deltabox\Bulletin\mooiman\latex_installation\MiKTeX  c:\ProgramData\MiKTeX
