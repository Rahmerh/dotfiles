Write-Host "Configuring power plan" -ForegroundColor "Cyan";
# AC: Alternating Current (Wall socket).
# DC: Direct Current (Battery).

# Set turn off disk timeout (in minutes / 0: never)
powercfg -change "disk-timeout-ac" 0;
powercfg -change "disk-timeout-dc" 0;

# Set hibernate timeout (in minutes / 0: never)
powercfg -change "hibernate-timeout-ac" 0;
powercfg -change "hibernate-timeout-dc" 0;

# Set sleep timeout (in minutes / 0: never)
powercfg -change "standby-timeout-ac" 0;
powercfg -change "standby-timeout-dc" 0;

# Set turn off screen timeout (in minutes / 0: never)
powercfg -change "monitor-timeout-ac" 0;
powercfg -change "monitor-timeout-dc" 0;

# Set turn off screen timeout on lock screen (in seconds / 0: never)
powercfg /SETACVALUEINDEX SCHEME_CURRENT SUB_VIDEO VIDEOCONLOCK 0;
powercfg /SETDCVALUEINDEX SCHEME_CURRENT SUB_VIDEO VIDEOCONLOCK 0;
powercfg /SETACTIVE SCHEME_CURRENT;

Write-Host "Power plan successfully updated." -ForegroundColor "Green";

Write-Host "Setting environment variables" -ForegroundColor "Cyan";

setx YAZI_FILE_ONE "C:\Users\bas\scoop\apps\git\current\usr\bin\file.exe"

Write-Host "Environment variables set." -ForegroundColor "Green";
