@ECHO OFF
REM  QBFC Project Options Begin
REM HasVersionInfo: Yes
REM Companyname: ��֮��
REM Productname: sublime�ƽ⸨��
REM Filedescription: ����gist��sublime�Զ��ƽ⹤��
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
) else echo %no_path_found_tip% ��"%subpath%"��

if "%subpath%"=="" exit /b
:patherror
if not exist "%subpath%" (
	cls
	echo %path_now% ��%subpath%����
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
	set any_key=�����
	set continue=!any_key!����
	set read=�������Ķ���������!continue!����������ͬ�����������������밴!continue!
	set no_path_found=δ��ȡ�� sublime text ·����~���ֶ������ַ��������ק exe ������̨��~���� ��Ctrl + C�� �� ֱ�Ӱ��س� �˳�
	set no_path_found_tip=sublime_text.exe ·��Ϊ��
	set path_now=��ǰ·��Ϊ��
	set no_path_exist=�ļ�������
	set folder_open_failed=���ļ���ʧ��
	set backfile_existed=���ڱ����ļ��������Ѿ����������~�������ִ�лḲ�Ǳ����ļ�~������������˳���ֱ�ӹر�
	set file_md5=��ǰ�ļ� MD5 Ϊ��
	set start_to_fetch=��ʼ���������ļ���gist��
	set sorry=�ܱ�Ǹ��
	set exit=!any_key!�˳�
	set gist_link=���ӣ�https://gist.githubusercontent.com/raw/feaa63c35f4c2baab24c9aaf9b3f4e47
	set fetch_failed=!sorry!�����ļ����ش���~��ȷ������������������������githubusercontent��~!gist_link!~!exit!
	set patch_code_found_failed=!sorry!δ�ҵ����ļ�MD5��Ӧ�Ĳ�����~��ȷ�����������������ļ�δ�޸Ĺ�~����Ѿ�ȷ�ϣ������gist����ҳ���Ӧ�汾���Ƿ��и���~!gist_link!~!exit!
	set patch_failed=Ӧ�ò���ʱ��������ԭʼ�����ѻָ�
	set patch_finished=������ɣ�ԭ�ļ��ѱ���Ϊsublime_text.exe_bak
	set first_time_tip=���ǵ�һ�δ򲹶�����[����-ע��]�����������⼤������м���
        set tao=PowerBy:��֮��@�ᰮ�ƽ�~������bat^&js���^&�������~����ɽű������Բ��Ժ�ɾ�����ű������Ƴ��޸ĺ��sublime_text.exe~�����ϲ��sublime text���빺�����档~~����gist�Զ����޸�~!gist_link!
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
        set tao=PowerBy:��֮��@�ᰮ�ƽ�~For mixed script with bat^&js and packaging tests only~Please delete this script and remove the modified sublime_text.exe after completing the script compatibility test~If you like sublime text, please purchase the official version.~~Automated crack based on gist~!gist_link!
)
goto :eof
