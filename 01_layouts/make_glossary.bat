@echo off
for %%f in (*.tex) do (
    rem if "%%~xf"==".tex" echo %%f
	if "%%~xf"==".tex" makeglossaries %%~nf
)
pause