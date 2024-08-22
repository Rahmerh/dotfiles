function Test-PathRegistryKey {
  [CmdletBinding()]
  param (
    [Parameter( Position = 0, Mandatory = $TRUE)]
    [String]
    $Path,

    [Parameter( Position = 1, Mandatory = $TRUE)]
    [String]
    $Name
  )

  try {
    $Reg = Get-ItemPropertyValue -Path $Path -Name $Name;
    Return $TRUE;
  }
  catch {
    Return $FALSE;
  }
}

function Get-WindowsFeature-Installation-Status {
  [CmdletBinding()]
  param(
    [Parameter(Position = 0, Mandatory = $TRUE)]
    [string]
    $FeatureName
  )

  if ((Get-WindowsOptionalFeature -FeatureName $FeatureName -Online).State -eq "Enabled") {
    return $TRUE;
  }
  else {
    return $FALSE;
  }
}

function Uninstall-AppPackage {
  [CmdletBinding()]
  param (
    [Parameter( Position = 0, Mandatory = $TRUE)]
    [String]
    $Name
  )

  try {
    Get-AppxPackage $Name -AllUsers | Remove-AppxPackage;
    Get-AppXProvisionedPackage -Online | Where-Object DisplayName -like $Name | Remove-AppxProvisionedPackage -Online;    
  }
  catch {
    
  }  
}

function Disable-WindowsFeature {
  [CmdletBinding()]
  param (
    [Parameter( Position = 0, Mandatory = $TRUE)]
    [String]
    $FeatureKey,

    [Parameter( Position = 1, Mandatory = $TRUE)]
    [String]
    $FeatureName
  )

  if (Get-WindowsFeature-Installation-Status $FeatureKey) {
    Write-Host "Disabling" $FeatureName ":" -ForegroundColor "Green";
    Disable-WindowsOptionalFeature -FeatureName $FeatureKey -Online -NoRestart;
  }
  else {
    Write-Host $FeatureName "is already disabled." -ForegroundColor "Green";
  }
}

function Enable-WindowsFeature {
  [CmdletBinding()]
  param (
    [Parameter( Position = 0, Mandatory = $TRUE)]
    [String]
    $FeatureKey,

    [Parameter( Position = 1, Mandatory = $TRUE)]
    [String]
    $FeatureName
  )

  if (-not (Get-WindowsFeature-Installation-Status $FeatureKey)) {
    Write-Host "Enabling" $FeatureName ":" -ForegroundColor "Green";
    Enable-WindowsOptionalFeature -FeatureName $FeatureKey -Online -All -NoRestart;
  }
  else {
    Write-Host $FeatureName "is already enabled." -ForegroundColor "Green";
  }
}

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

setx YAZI_FILE_ONE "$HOME\scoop\apps\git\current\usr\bin\file.exe"

Write-Host "Environment variables set." -ForegroundColor "Green";

Write-Host "Configuring start folder of Windows File Explorer" -ForegroundColor "Cyan";

$RegPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced";

if (-not (Test-PathRegistryKey -Path $RegPath -Name "LaunchTo")) {
    New-ItemProperty -Path $RegPath -Name "LaunchTo" -PropertyType DWord;
}

Set-ItemProperty -Path $RegPath -Name "LaunchTo" -Value 1; # [This PC: 1], [Quick access: 2], [Downloads: 3]

Write-Host "Now starts at 'This PC'." -ForegroundColor "Green";

Write-Host "Misc changes" -ForegroundColor "Cyan";

Disable-WindowsFeature "WindowsMediaPlayer" "Windows Media Player";
Disable-WindowsFeature "Internet-Explorer-Optional-amd64" "Internet Explorer";
Disable-WindowsFeature "Printing-XPSServices-Features" "Microsoft XPS Document Writer";
Disable-WindowsFeature "WorkFolders-Client" "WorkFolders-Client";

Uninstall-AppPackage "Microsoft.Getstarted";
Uninstall-AppPackage "Microsoft.GetHelp";
Uninstall-AppPackage "Microsoft.WindowsFeedbackHub";
Uninstall-AppPackage "Microsoft.MicrosoftSolitaireCollection";

Write-Host "Done." -ForegroundColor "Green";
