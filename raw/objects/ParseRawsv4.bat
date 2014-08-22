echo off
REM s/\][^]]*/&\n/g doesn't work right
REM to remove [[ and ]] s/\][^]]*/&\n/g; s/\[[^[]*/&\n/g
REM to split up ][
REM for /f %%a in ('dir /b *.txt') do sed -e "s/\]\[/\]\n\[/g" %%~na.txt > %%~na.out
REM put tokens on their own line
for /f %%a in ('dir /b *.txt') do sed -e "s/\[[^][]*\]/\n&\n/g" %%~na.txt > %%~na.out
REM remove tabs
for /f %%a in ('dir /b *.out') do sed -r "s/\t//g" %%~na.out > %%~na.out2
REM for /f %%a in ('dir /b *.out') do sed -r "s/\t//g;s/([^]].+)\[/\1\n[/g;s/\]([^[].+)$/]\n\1/g" %%~na.out > %%~na.out2
REM remove all blanklines
for /f %%a in ('dir /b *.out2') do sed -e "s/^ *//; s/ *$//; /^$/d; s/\r//; /^\s*$/d" %%~na.out2 > %%~na.out3
REM cleanup
erase *.txt
ren *.out3 *.txt
erase *.out
echo on