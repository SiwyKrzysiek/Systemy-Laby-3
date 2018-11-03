@echo off
REM ---------------------------------
REM | Krzysztof Dabrowkski 293101    |
REM | Laboratoria 3                  |
REM | Skrypt na Systemy Operacyjne   |
REM | Wykozystanie komendy %@crc32[] |
REM | z powloki TCC w skrypcie .bat  |
REM ----------------------------------

Title Skrypt na Systemy Operacyjne

call :displayTaksInfo
call :displayShellName
call :checkIfHelpWanted %~1

goto :countAgruments
:returnCountAgruments

if "%shellName%"=="cmd" goto :cmd
if "%shellName%"=="TCC" goto :tcc

echo Niewspierana powloka. Skrypt jest przeznaczony do dzialania w TCC
echo Niektore funkcje sa rowniez dostepne w CMD

REM goto :test
:returnPointTest

REM Pause
rem Wyjdz ze skryptu
Exit /B %errorlevel%

:test
REM echo %~2
echo %@crc32["%comspec%"]
goto returnPointTest

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
echo Skrypt.bat (- ^| /)(h ^| help ^| ?) - wyswietla pomoc
echo Skrypt.bat -(crc ^| CRC) ciagZnakow - liczy sume kontrolna z podanego ciagu
Exit /B %errorlevel%

:displayShellName
rem Wydobycie nazwy powloki ze sciezki
for %%n in (%COMSPEC%) DO (
    rem echo %%~nn
    set shellName=%%~nn
)

echo Sykryp jest odpalony w powloce %shellName% & echo:
echo WYPISAC WERSJE POWLOKI (VER)
echo Zawartosc zmiennej COMSPEC to:
echo %COMSPEC%
echo ----------------------------------------------------- & echo:
Exit /B 0

:checkIfHelpWanted
if "%~1"=="-h" goto displayHelp
if "%~1"=="-help" goto displayHelp
if "%~1"=="--help" goto displayHelp
if "%~1"=="-?" goto displayHelp
if "%~1"=="/?" goto displayHelp
if "%~1"=="/h" goto displayHelp
if "%~1"=="/help" goto displayHelp
Exit /B 0

:countAgruments
set numberOfArguments=0
for %%x in (%*) do Set /A numberOfArguments+=1
goto :returnCountAgruments

:cmd
echo Wszystkie ciekawe funkcje dzialaja tylko w powloce TCC & echo:
REM goto :displayHelp
Exit /B %errorlevel%

:tcc
if "%~1"=="-crc" goto :doCRC
if "%~1"=="-CRC" goto :doCRC

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