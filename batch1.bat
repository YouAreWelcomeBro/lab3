@echo off
chcp 65001 > nul

mkdir "Прихована папка"
mkdir "Не прихована папка"

attrib +h "Прихована папка"

echo Використання xcopy:
echo. 
xcopy /? > "Не прихована папка\copyhelp.txt"

xcopy "Не прихована папка\copyhelp.txt" "Прихована папка\copied_copyhelp.txt" /Y
