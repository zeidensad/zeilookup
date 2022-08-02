@echo off
title zeilookup
color 4
setlocal ENABLEDELAYEDEXPANSION
set webclient=webclient
if exist "%temp%\%webclient%.vbs" del "%temp%\%webclient%.vbs" /f /q /s >nul
if exist "%temp%\response.txt" del "%temp%\response.txt" /f /q /s >nul
:menu
cls
echo zeilookup/

cls
echo.
echo -----------------------------------CONTATCTE-----------------------------------              
echo                                DISCORD : zeiden.web#5073
echo.
set ip=127.0.0.1
set /p ip=Entree l'ip : 
echo sUrl = "http://ipinfo.io/%ip%/json" > %temp%\%webclient%.vbs
:localip
cls
echo set oHTTP = CreateObject("MSXML2.ServerXMLHTTP.6.0") >> %temp%\%webclient%.vbs
echo oHTTP.open "GET", sUrl,false >> %temp%\%webclient%.vbs
echo oHTTP.setRequestHeader "Content-Type", "application/x-www-form-urlencoded" >> %temp%\%webclient%.vbs
echo oHTTP.setRequestHeader "Content-Length", Len(sRequest) >> %temp%\%webclient%.vbs
echo oHTTP.send sRequest >> %temp%\%webclient%.vbs
echo HTTPGET = oHTTP.responseText >> %temp%\%webclient%.vbs
echo strDirectory = "%temp%\response.txt" >> %temp%\%webclient%.vbs
echo set objFSO = CreateObject("Scripting.FileSystemObject") >> %temp%\%webclient%.vbs
echo set objFile = objFSO.CreateTextFile(strDirectory) >> %temp%\%webclient%.vbs
echo objFile.Write(HTTPGET) >> %temp%\%webclient%.vbs
echo objFile.Close >> %temp%\%webclient%.vbs
echo Wscript.Quit >> %temp%\%webclient%.vbs
start %temp%\%webclient%.vbs
set /a requests=0
echo.
rem echo Waiting for API response. . .
echo  Recherche de l'adresse IP ...
:checkresponseexists
if %requests% gtr 7 goto failed
IF EXIST "%temp%\response.txt" (
goto response_exist
) ELSE (
ping 127.0.0.1 -n 2 -w 1000 >nul
goto checkresponseexists
)
color 4
:failed
taskkill /f /im wscriptput .exe >nul
del "%temp%\%webclient%.vbs" /f /q /s >nul
echo.
echo L'api na pas recue sa réponse .
echo.
pause
goto menu
:response_exist
cls
echo.
echo   ERREUR 404 contacter zeiden
color %num%
for /f "delims= 	" %%i in ('findstr /i "," %temp%\response.txt') do (
        set data=%%i
        set data=!data:,=!
	set data=!data:""=Not Listed!
	set data=!data:"=!
	set data=!data:ip:=IP:		!
	set data=!data:hostname=nom d'hote:	!
	set data=!data:org:=ISP:		!
	set data=!data:city:=ville:		!
	set data=!data:region:=etat:	!
	set data=!data:country:=pays:	!
	set data=!data:postal:=code postal:	!
	set data=!data:loc:=localisation:	!
	set data=!data:timezone:=fuseau horraire:	!
        echo !data!
)
echo.
del "%temp%\%webclient%.vbs" /f /q /s >nul
del "%temp%\response.txt" /f /q /s >nul
pause
if '%ip%'=='' goto menu
goto zeilookup
pause
goto crée par zeiden 