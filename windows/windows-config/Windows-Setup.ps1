function Set-Power-Configuration
{
    Write-Host "Configuring power plan:" -ForegroundColor "Green";
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
    powercfg -change "monitor-timeout-ac" 10;
    powercfg -change "monitor-timeout-dc" 10;

    # Set turn off screen timeout on lock screen (in seconds / 0: never)
    powercfg /SETACVALUEINDEX SCHEME_CURRENT SUB_VIDEO VIDEOCONLOCK 30;
    powercfg /SETDCVALUEINDEX SCHEME_CURRENT SUB_VIDEO VIDEOCONLOCK 30;
    powercfg /SETACTIVE SCHEME_CURRENT;

    Write-Host "Power plan successfully updated." -ForegroundColor "Green";
}
}
