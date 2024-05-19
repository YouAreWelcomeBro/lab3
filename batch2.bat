@echo off
chcp 65001 > nul

:input_directories
set /p "directories=Введіть шляхи до каталогів (розділені символом ';'): "

if "%directories%"=="" (
    echo Потрібно вказати шляхи до каталогів.
    goto input_directories
)

for %%d in (%directories%) do (
    call :process_directory %%d
)

pause
exit /b 0

:process_directory
if not exist "%1" (
    echo Каталог "%1" не існує.
    exit /b 1
)


set /p "subdirectories=Введіть імена підкаталогів для каталогу %1 (розділені символом ';'): "

if "%subdirectories%"=="" (
    echo Потрібно вказати імена підкаталогів.
    goto process_directory
)

for %%s in (%subdirectories%) do (
    call :process_subdirectory %1 "%%s"
)

exit /b 0

:process_subdirectory
if not exist "%1\%~2" (
    echo Підкаталог з ім'ям "%~2" не знайдено у каталозі "%1".
    exit /b 1
)

set "size=0"
for /r "%1\%~2" %%A in (*) do (
    set /a size+=%%~zA
)

set "folderCount=0"
for /f %%F in ('dir /b /a:d "%1\%~2" ^| find /c /v ""') do set "folderCount=%%F"

rem Підрахунок кількості скритих папок у каталозі
set "hiddenFolderCount=0"
for /f %%F in ('dir /b /a:hd "%1\%~2" ^| find /c /v ""') do set "hiddenFolderCount=%%F"

echo -----------------------------
echo Обсяг підкаталогу "%~2" у каталозі "%1": %size% байт
echo Кількість папок у каталозі "%1\%~2": %folderCount%
echo Кількість скритих папок у каталозі "%1\%~2": %hiddenFolderCount%

exit /b 0


