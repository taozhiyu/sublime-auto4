@ECHO OFF
REM  QBFC Project Options Begin
REM HasVersionInfo: Yes
REM Companyname: 涛之雨
REM Productname: sublime破解辅助
REM Filedescription: 基于gist的sublime自动破解工具
REM Copyrights: 
REM Trademarks: 
REM Originalname: 
REM Comments: 
REM Productversion:  0. 1. 2. 0
REM Fileversion:  0. 1. 2. 0
REM Internalname: 
REM ExeType: consoleold
REM Architecture: x86
REM Appicon: sublime_text.ico
REM AdministratorManifest: Yes
REM Embeddedfile: msys-2.0.dll
REM Embeddedfile: xxd.exe
REM Embeddedfile: getcode.js
REM  QBFC Project Options End
@ECHO ON
@echo off
Setlocal EnableDelayedExpansion
set subpath=
call :setlang

call :print tao
echo.
echo %read%
where timeout 2>nul|find "timeout">nul 2>&1 &&timeout /t 10 /nobreak||ping 127.1 -n 3 -w 500 >nul 2>&1
echo %continue%
pause>nul
set self="%~0"
for /f tokens^=2^ delims^=^" %%a in ('REG QUERY "HKEY_CLASSES_ROOT\com.sublimehq.sublimetext.build-system\shell\open\command" 2^>nul') do set subpath=%%a

if "%subpath%"=="" ( 
	cls
	:getnewpath
	call :print no_path_found
	set /p subpath=%no_path_found_tip%
) else echo %no_path_found_tip% “"%subpath%"”

if "%subpath%"=="" exit /b
:patherror
if not exist "%subpath%" (
	cls
	echo %path_now% “%subpath%”，
	echo %no_path_exist%
	set subpath=
	goto :getnewpath
)

for %%I in ("%subpath%") do cd /d %%~dpI || (
	echo %folder_open_failed%
	echo %exit%
	pause>nul&&exit /b
)

if exist "sublime_text.exe_bak" (
	call :print backfile_existed
)

certutil -hashfile sublime_text.exe md5 | find /v ":" >"%myfiles%\tao_md5.txt"
set /p md5=<"%myfiles%\tao_md5.txt"
del /q /s "%myfiles%\tao_md5.txt" > nul 2>&1
if "%md5%" equ "" set subpath=&&goto :patherror
echo %file_md5% %md5% 
echo %start_to_fetch%

del /q /s "patchbat.bat" > nul 2>&1
cscript -nologo -e:jscript "%myfiles%\getcode.js" >"%myfiles%\tao_html.txt"
if %errorlevel% equ 1 (
	rd /q /s "%myfiles%\"
	cls
	call :print fetch_failed
	echo %exit%
	pause>nul&exit /b
)

set startline=0
set linecount=0
for /f "skip=20 delims=" %%a in ('type "%myfiles%\tao_html.txt"') do (
	if !linecount! equ 0 (
		echo "%%a" | findstr /i %md5% >nul && set linecount=1 || set /a startline+=1
	) else (
		if "%%a" == "```" (goto :found) else (
			set /a linecount+=1
			echo %%a>>"patchbat.bat"
		)
	)
    if !startline! GEQ 100 goto :found
    if !linecount! GEQ 10 set linecount=0&&goto :found
)
:found
if %linecount% equ 0 (
	rd /q /s "%myfiles%\"
	cls
	call :print patch_code_found_failed
	pause>nul&exit /b
)

del /q /s "%myfiles%\tao_html.txt" > nul 2>&1

copy /y "%myfiles%\xxd.exe" .\xxd.exe > nul 2>&1
copy /y "%myfiles%\msys-2.0.dll" .\msys-2.0.dll > nul 2>&1
copy /y "sublime_text.exe" "sublime_text.exe_bak" > nul 2>&1

call "patchbat.bat"
if %errorlevel% equ 1 (
	mshta vbscript:window.execScript("alert('%patch_failed%');","javascript"^)(window.close^)
	copy /y "sublime_text.exe_bak" "sublime_text.exe"
)
del /q /s "xxd.exe" > nul 2>&1
del /q /s "msys-2.0.dll" > nul 2>&1
del /q /s "patchbat.bat" > nul 2>&1
rd /q /s "%myfiles%\"
mshta vbscript:window.execScript("alert('%patch_finished%\n%first_time_tip%');","javascript"^)(window.close^)

echo.
call :print tao
echo.
echo %exit%
pause>nul&exit /b

:print
setlocal ENABLEDELAYEDEXPANSION
set _myvar=!%1!
:FORLOOP
For /F "tokens=1* delims=~" %%A IN ("%_myvar%") DO (
    echo %%A
    set _myvar=%%B
    if "%%B" neq "" goto FORLOOP
)
endlocal
goto :eof


:setlang
For /F "Delims=" %%G in ('powershell -c "(Get-WinUserLanguageList)[0].EnglishName"')Do Set "lan=%%G"

if "%lan%" equ "Chinese" (
	set any_key=任意键
	set continue=!any_key!继续
	set read=请认真阅读，看到【!continue!】字样后，如同意上述免责声明，请按!continue!
	set no_path_found=未获取到 sublime text 路径，~请手动输入地址（可以拖拽 exe 到控制台）~按下 “Ctrl + C” 或 直接按回车 退出
	set no_path_found_tip=sublime_text.exe 路径为：
	set path_now=当前路径为：
	set no_path_exist=文件不存在
	set folder_open_failed=打开文件夹失败
	set backfile_existed=存在备份文件，可能已经打过补丁，~如果继续执行会覆盖备份文件~任意键继续，退出请直接关闭
	set file_md5=当前文件 MD5 为：
	set start_to_fetch=开始请求配置文件（gist）
	set sorry=很抱歉，
	set exit=!any_key!退出
	set gist_link=链接：https://gist.githubusercontent.com/raw/feaa63c35f4c2baab24c9aaf9b3f4e47
	set fetch_failed=!sorry!配置文件下载错误~请确保网络正常（可以正常访问githubusercontent）~!gist_link!~!exit!
	set patch_code_found_failed=!sorry!未找到该文件MD5对应的补丁，~请确保网络正常，并且文件未修改过~如果已经确认，请检查该gist发布页面对应版本号是否有更新~!gist_link!~!exit!
	set patch_failed=应用补丁时发生错误，原始数据已恢复
	set patch_finished=补丁完成，原文件已备份为sublime_text.exe_bak
	set first_time_tip=如是第一次打补丁，在[帮助-注册]中请输入任意激活码进行激活
        set tao=PowerBy:涛之雨@吾爱破解~仅用于bat^&js混编^&打包测试~请完成脚本兼容性测试后删除本脚本并且移除修改后的sublime_text.exe~如果您喜欢sublime text，请购买正版。~~基于gist自动化修改~!gist_link!
) else (
	set any_key=press any key to
	set continue=!any_key! continue
	set read=Please read carefully and !continue! if you agree to the above disclaimer after seeing the words [!continue!].
	set no_path_found=Sublime text path not found, ~please enter the path manually (you can drag and drop the exe to the console^) ~"Ctrl + C" or just press enter to exit
	set no_path_found_tip=Path of sublime_text.exe is:
	set path_now=The current path is:
	set no_path_exist=File does not exist
	set folder_open_failed=Failed to open folder
	set backfile_existed=A backup file exists, it may have been patched, ~If continue it will be overwritten ~Any key to continue; To EXIT please CLOSE directly
	set file_md5=MD5 of the current file is:
	set start_to_fetch=Start requesting a configuration file (gist^)
	set sorry=Sorry,
	set exit=!any_key! exit
	set gist_link=link: https://gist.githubusercontent.com/raw/feaa63c35f4c2baab24c9aaf9b3f4e47
	set fetch_failed=!sorry! the configuration file was downloaded incorrectly ~please make sure your network is working (access githubusercontent normally^) ~!gist_link!~!exit!
	set patch_code_found_failed=!sorry!No patch code matched the MD5 of this file, ~please ensure that the network is working and that the file has not been modified ~after all above have been confirmed, please check if the version number corresponding to this gist release page has been updated~!gist_link!~!exit!
	set patch_failed=An error occurred while applying the patch and the original data was restored
	set patch_finished=Patch complete, original file backed up as sublime_text.exe_bak
	set first_time_tip=If this is the first time you applied patch, please enter any activation code in [Help - Registration] to activate it
        set tao=PowerBy:涛之雨@吾爱破解~For mixed script with bat^&js and packaging tests only~Please delete this script and remove the modified sublime_text.exe after completing the script compatibility test~If you like sublime text, please purchase the official version.~~Automated crack based on gist~!gist_link!
)
goto :eof
