@echo off
REM ---------------------------------
REM | Krzysztof Dabrowkski 293101    |
REM | Laboratoria 3                  |
REM | Skrypt na Systemy Operacyjne   |
REM | Wykozystanie komendy %@crc32[] |
REM | z powloki TCC w skrypcie .bat  |
REM ----------------------------------

REM Title Skrypt na Systemy Operacyjne
set fileName=Skrypt.bat
set errorlevel=0

call :displayTaksInfo
call :displayShellInfo
goto :checkIfHelpWanted
:returnCheckIfHelpWanted

goto :countAgruments
:returnCountAgruments

if "%shellName%"=="TCC" goto :tcc
if "%shellName%"=="cmd" goto :cmd

echo Niewspierana powloka. Skrypt jest przeznaczony do dzialania w TCC
echo Niektore funkcje sa rowniez dostepne w CMD

Exit /B %errorlevel%

:displayTaksInfo
echo ---------------------------------
echo ^| Cwiczenie 3                   ^|
echo ^| Przedmiot: Systemy Operacyjne ^|
echo ^| Autor: Krzysztof Dabrowkski   ^|
echo ---------------------------------
echo: & echo:
Exit /B 0

:displayHelp
echo POMOC
echo ----------------------------------------------------- & echo:
echo Uzycie:
echo %fileName% (- ^| /)(h ^| help ^| ?) - wyswietla pomoc
echo %fileName% -(crc ^| CRC) ciagZnakow - liczy sume kontrolna CRC32 z podanego ciagu
echo %fileName% -(crcf ^| CRCF) sciezkaDoPliku - liczy sume kontrolna CRC32 z wskazanego pliku
echo %fileName% -(sha ^| SHA) ciagZnakow - liczy sume kontrolna SHA256 z podanego ciagu
echo %fileName% -(md5 ^| MD5) ciagZnakow - liczy sume kontrolna MD5 z podanego ciagu
echo %fileName% -(md5f ^| MD5F) sciezkaDoPliku - liczy sume kontrolna MD5 z wskazanego pliku

echo %fileName% -(date ^| DATE) - wyswietla aktualna date

echo:
echo Przyklady:
echo Skrypt.bat -md5f "C:\windows\explorer.exe"
echo Skrypt.bat -crc Ludwik
echo Skrypt.bat -CRC "Ala ma kota."
Exit /B %errorlevel%

:displayShellInfo
rem Wydobycie nazwy powloki ze sciezki
for %%n in (%COMSPEC%) DO (
    rem echo %%~nn
    set shellName=%%~nn
)

rem Wykrycie TCC w inny sposob
if "%@abs[-1]"=="1" (
    set shellName=TCC
)

rem Jak nie jestem w TCC i cmd to muszę być w DOSIE
if %shellName% NEQ TCC (
    if %shellName% NEQ ^cmd (
        set shellName=COMMAND
    )
)

echo Sykryp jest odpalony w powloce %shellName% & echo:
call :displayShellVersion
echo Zawartosc zmiennej COMSPEC to:
echo %COMSPEC%
echo ----------------------------------------------------- & echo:
Exit /B 0

:displayShellVersion
if "%shellName%"=="cmd" (
    echo Wersja powloki:
    ver
    echo:
)
if "%shellName%"=="TCC" (
    echo Wersja powloki:
    ver
    echo:
)
if "%shellName%"=="PowerShell" (
    $PSVersionTable
    echo:
)
if "%shellName%"=="powershell" (
    $PSVersionTable
    echo:
)
if "%shellName%"=="POWERSHELL" (
    $PSVersionTable
    echo:
)
if "%shellName%"=="command" (
    ver
    echo:
)
if "%shellName%"=="COMMAND" (
    ver
    echo:
)
Exit /B 0

:checkIfHelpWanted
if "%~1"=="-h" goto :displayHelp
if "%~1"=="-help" goto :displayHelp
if "%~1"=="--help" goto :displayHelp
if "%~1"=="-?" goto :displayHelp
if "%~1"=="/?" goto :displayHelp
if "%~1"=="/h" goto :displayHelp
if "%~1"=="/help" goto :displayHelp
goto :returnCheckIfHelpWanted

rem Ustawia zmienna numberOfArguments na liczbe argumentow skryptu
:countAgruments
set numberOfArguments=0
for %%x in (%*) do Set /A numberOfArguments+=1
goto :returnCountAgruments

:cmd
if "%~1"=="-date" goto :displayDate
if "%~1"=="-DATE" goto :displayDate

echo Nieprawidlowe argumenty & echo:
set /A errorlevel=1
goto :displayHelp

Exit /B %errorlevel%

:tcc
if "%~1"=="-crc" goto :doCRC
if "%~1"=="-CRC" goto :doCRC

if "%~1"=="-crcf" goto :doCRCFromFile
if "%~1"=="-CRCF" goto :doCRCFromFile

if "%~1"=="-sha" goto :doSHA
if "%~1"=="-SHA" goto :doSHA

if "%~1"=="-md5" goto :doMD5
if "%~1"=="-MD5" goto :doMD5

if "%~1"=="-md5f" goto :doMD5FromFile
if "%~1"=="-MD5F" goto :doMD5FromFile

if "%~1"=="-date" goto :displayDate
if "%~1"=="-DATE" goto :displayDate

echo Nieprawidlowe argumenty & echo:
set /A errorlevel=1
goto :displayHelp

Exit /B %errorlevel%

:doCRC
if %numberOfArguments% NEQ 2 (
    echo Nieprawidlowa liczba argumentow.
    echo Spodziewana ilosc: 2 & echo:
    set /A errorlevel=1
    goto :displayHelp
)

echo Suma kontrolna dla %~2
echo %@crc32[s, "%~2"]
Exit /B %errorlevel%

:doCRCFromFile
if %numberOfArguments% NEQ 2 (
    echo Nieprawidlowa liczba argumentow.
    echo Spodziewana ilosc: 2 & echo:
    set /A errorlevel=1
    goto :displayHelp
)

rem Sprawdzenie czy funkcja dziala
if %@crc32[f, "%~2"] EQU -1 (
    echo Nie udalo sie odnalezc wskazanego pliku & echo:
    goto :displayHelp
)

echo Suma kontrolna dla pliku %~2
echo %@crc32[f, "%~2"]
Exit /B %errorlevel%

:doSHA
if %numberOfArguments% NEQ 2 (
    echo Nieprawidlowa liczba argumentow.
    echo Spodziewana ilosc: 2 & echo:
    set /A errorlevel=1
    goto :displayHelp
)

echo Suma kontrolna dla %~2
echo %@SHA256[s, "%~2"]
Exit /B %errorlevel%

:doMD5
if %numberOfArguments% NEQ 2 (
    echo Nieprawidlowa liczba argumentow.
    echo Spodziewana ilosc: 2 & echo:
    set /A errorlevel=1
    goto :displayHelp
)

echo Suma kontrolna dla %~2
echo %@MD5[s, "%~2"]
Exit /B %errorlevel%

:doMD5FromFile
if %numberOfArguments% NEQ 2 (
    echo Nieprawidlowa liczba argumentow.
    echo Spodziewana ilosc: 2 & echo:
    set /A errorlevel=1
    goto :displayHelp
)

rem Sprawdzenie czy funkcja dziala
if %@MD5[f, "%~2"] EQU -1 (
    echo Nie udalo sie odnalezc wskazanego pliku & echo:
    goto :displayHelp
)

echo Suma kontrolna dla pliku %~2
echo %@MD5[f, "%~2"]
Exit /B %errorlevel%

:displayDate
echo Dzisiejsza data to:
date /T
Exit /B %errorlevel%