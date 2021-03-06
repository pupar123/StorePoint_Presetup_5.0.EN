<#
.NOTES 
  Created with: SAPIEN Technologies, Inc., PowerShell Studio 2012 v3.1.32
  Created on:   2014-04-08 17:20
  Created by:   Dennis Lindqvist
  Organization: 
  Filename: 

  Requirements:
	o	PowerShell 2.0
	o	$MyName needs to be defined in including script

  Dependencies:
	[Dependencies here]

  Aliases used:
	[ICC4 specific registry settings used by the script]

  Known issues:
	Scheduled task is not generic. Hardcoded folder!!

  Online Help: 
	http://technet.microsoft.com/en-us/magazine/hh500719.aspx

  Rev 0.1.0.1	17:20 2014-04-08	Collected Add-Log() and Get-RegValueData()
  Rev 0.1.0.2	17:32 2014-04-08	Collected Remove-RegKey(), Start-MyProcess() and Wake-Idem()
  Rev 0.1.0.3	17:36 2014-04-08	Collected Get-ScheduleService(), New-ScheduledTaskObject(), Get-ScheduledTaskFolder()
									New-ScheduledTaskFolder(), Remove-ScheduledTaskFolder(), New-ScheduledTask()
									and Remove-ScheduledTask()
  Rev 0.1.0.4	17:43 2014-04-08	Collected Set-RegValueData(), Remove-RegValue(), Apply-RegFile()
									and Expand-ZipFile()
  Rev 0.1.0.5	18:06 2014-04-08	Collected Get-ICCAlias()
  Rev 0.1.0.6	19:58 2014-04-09	Forget to set log path variable
  Rev 0.1.0.9	20:08 2014-04-09	Added Hive location verification for HKLM and HKCU
  Rev 0.1.0.10	22:04 2014-04-09	Added $Argument to logging for Start-MyProcess()
  Rev 0.1.0.13	22:38 2014-04-09	Collected Get-MyExecutablePath()
  Rev 0.1.0.14	16:22 2014-04-10	Added $WorkingDir to Start-MyProcess()
  Rev 0.1.0.15	17:26 2014-04-10	Added support for cscript args in Start-MyProcess()
  Rev 0.1.0.18	15:44 2014-04-11	Added Apply-IdemLogon() and Apply-IdemLogoff()
  Rev 0.1.0.19	17:01 2014-05-08	Relabeled Apply-IdemLogonScript() and Apply-IdemLogoffScript()
  Rev 0.1.0.20	19:30 2014-05-08	Log file folder isn't always OPOS
  Rev 0.1.0.21	20:01 2014-05-08	Readded $RestrainingKey as parameter $BlockString to Apply-RegFile()
  Rev 0.1.0.27	20:51 2014-05-12	Trouble shooting function Expand-ZipFile()
  Rev 0.1.0.28	10:59 2014-06-03	Added Get-FileshareLock()
  Rev 0.1.0.29	15:47 2014-06-03	Added Get-FileShareSession()
  Rev 0.1.0.30	18:16 2014-06-04	Added Get-ClientOuCollection()
  Rev 0.1.0.31	13:55 2014-06-09	Fixed Apply-RegFile(). Didn't reset $RemoveRegkey
  Rev 0.1.0.32	15:58 2014-06-09	Fixed Apply-RegFile(). $Filterstring wasn't set to $global:RestrainingKey if missing
  Rev 0.1.0.33	16:38 2014-06-09	Extended Apply-RegFile(). Delete value command added.
  Rev 0.1.0.34	18:55 2014-06-09	Added Get-LocalAlias() to handle the ValueData "To be specified".
  Rev 0.1.0.35	15:17 2014-06-10	Extended Start-MyProcess() with $Argument logging and $ProcessRunTime
  Rev 0.1.0.36	17:55 2014-06-10	Added Get-Memory()
  Rev 0.1.0.37	10:37 2014-06-11	Comment syntax error fixed
  Rev 0.1.0.38	11:43 2014-06-11	Changed debug level to diagnostic level in most functions
  Rev 0.1.0.39	13:34 2014-06-11	Added fallback params for Add-Log()
  Rev 0.1.0.40	13:43 2014-06-11	Adjusted debug level for Start-MyProcess()
  Rev 0.2.0.42	14:30 2014-06-11	Added $CheckTime to Start-MyProcess()
									Added $CheckTime to Apply-IdemLogonScript()
  Rev 0.3.0.43	10:33 2014-06-12	Added Get-TSsession()
  Rev 0.4.0.44	14:50 2014-07-22	Added Split-AddressPort(), Get-NetworkStatistics
  Rev 0.4.0.45	12:54 2014-07-28	Removed Import-Module typo in section Global Constants
  Rev 0.5.0.48	16:07 2014-08-12	Added more strict control of -Filterstring in Apply-RegFile()
									Fixed Apply-RegFile() to handle = signs in value data
  									Fixed Apply-RegFile() to handle \\ escape signs
  Rev 0.6.0.49	10:41 2014-08-14	Added Run-ScheduledTask()
  Rev 0.7.0.52	15:31 2014-08-14	Added Parse-Commandline()
  Rev 0.7.0.53	17:51 2014-08-14	Changed Parse-Commandline() to use plain hashtables
  Rev 0.7.0.54	10:22 2014-08-15	Hiding some expected errors from Run-ScheduledTask()
  Rev 0.8.0.55	13:36 2014-08-19	Added Get-COMlist()
  Rev 0.8.0.58	13:41 2014-08-19	Added Set-ComPort() ***NEEDS SYSTEM PERMISSION***
  Rev 0.8.0.60	14:54 2014-08-19	Updated Set-ComPort to handle COM ports in use
  Rev 0.8.0.61	15:57 2014-08-19	Added function Get-ComDevice() that returns the device collection
  Rev 0.8.0.62	16:22 2014-08-19	Add param $HardwareId to Set-ComPort()
  Rev 0.9.0.63	15:09 2014-08-28	Added Get-HostName()
  Rev 0.9.0.65	11:12 2014-09-01	Added Debug to Get-HostName()
  Rev 0.10.0.66	21:36 2014-10-01	Fixed ICCGet-Alias() returning "To be specified" as value
  Rev 0.11.0.67	13:59 2014-10-03	Added Prefix to Add-Log()
  Rev 0.11.0.68	20:36 2014-10-06	Small logging adjustment with regards to DEBUG: and DIAG: prefixes
  Rev 0.12.0.69	16:12 2014-10-17	Added Get-IpAddress()
  Rev 1.0.0.70	12:29 2015-02-06	Added ComputerName to logfile
  Rev 1.0.0.71	19:20 2015-02-19	Fixed logfile archiving
  Rev 1.0.0.73	14:02 2015-02-23	Fixed logfile archiving of legacy log files
  Rev 1.0.0.74	23:00 2015-02-24	Get-RegValueData() Log file clarification for missing registry keys
  Rev 1.0.0.75	18:26 2015-05-04	Added Set-DACL(), Remove-DACL
  Rev 1.0.0.76	20:06 2015-05-21	Added Place-Windows(), Set-WindowState()
  Rev 1.0.0.77	22:55 2015-05-25	Added Set-Pointer()
  Rev 1.0.0.78	11:05 2015-05-26	Added -Silent switch to Set-RegValueData()
									Added -Silent switch to Get-RegValueData()
  Rev 1.0.0.79	13:02 2015-05-27	Added -VerySilent switch as well
  Rev 1.0.0.80	19:25 2015-05-27	Added default hash tables to Set-Pointer()
  Rev 1.0.0.81	09:50 2015-05-29	Added Blank and Dot scheme to Set-Pointer()
  Rev 1.0.0.85	22:13 2015-06-01	Fixed Set-Pointer() Dot
  Rev 1.0.0.86	09:23 2015-06-03	Changed Get-LocalAlias() to fetch registry silently on errors
  Rev 1.0.0.90	10:44 2015-06-03	Added -Mandatory switch to Get-LocalAlias()
  Rev 1.0.0.91	13:13 2015-09-22	Added function Set-LogLevel()
  Rev 1.0.0.92	17:18 2015-09-22	Added function Get-ExecutionTime()
  Rev 1.0.0.93	17:38 2015-09-28	Added function Test-UniqueProcess()
  Rev 1.0.0.94	20:32 2015-09-28	Added function Set-ShadowPolicy()
  Rev 1.0.0.95	19:21 2015-09-29	Moved COM-functions back to COM-script
  Rev 1.0.0.97	22:34 2015-09-29	Added function Get-OrderedDictionaryFromString()
  Rev 1.0.0.98	14:34 2015-10-06	Fixed Get-ExecutionTime()
  Rev 1.0.0.99	15:15 2015-10-09	Removed duplicate and errornus Get-NetworksStatistics()
  Rev 1.0.0.101	11:24 2015-10-29	Added function Get-LastBootTime()
 									Added function Invoke-BootDelay()
  Rev 1.0.0.102	10:46 2015-11-09	Added function Invoke-AliasUpdate()
  Rev 1.0.0.103	10:59 2015-11-09	Added function Invoke-AsAdmin()
  Rev 1.0.0.104 12:44 2015-11-13    Fixed Set-RegValueData() to handle registry path "HKLM:\SOFTWARE\Classes\`*"
  Rev 1.0.0.105	18:05 2015-11-13	Added function Get-ChildProcess()
  Rev 1.0.0.106	12:35 2015-11-16	Updated function Set-WindowState() to handle multiple objects.
									Expanded function Set-WindowState() params.
  Rev 1.0.0.107	15:47 2015-11-16	Updated function Set-WindowPosition() to handle multiple processes.
  Rev 1.0.0.108	22:15 2015-11-16	Fixed Set-DACL to work wo changing ownership.
									TODO: Get-DACL doen't work if access denied
  Rev 1.0.0.109	19:43 2015-11-24	Added function Get-FunctionDef()
  Rev 1.0.0.110	11:18 2015-11-27	Added function Get-Base64String(), Get-ScriptBlock()
  Rev 1.0.0.111	10:54 2015-11-30	Add function New-ThreaderType(), Suspend-Process(), Resume-Process(),
									Suspend-Thread(), Resume-Thread()
  Rev 1.0.0.112	14:18 2015-11-30	Replaced function Set-Owner()
  Rev 1.0.0.113	14:41 2015-11-30	Fixed .GetAccessControl in Set-DACL() and Remove-DACL()
  Rev 1.0.0.114	21:30 2015-11-30	Added functions New-Share(), Remove-Share()
  Rev 1.0.0.115	12:33 2015-12-04	Added functions Get-WoW6432Env(), Get-ComputerRegAlias()
  Rev 1.0.1.116	14:37 2015-12-08	Added more documentation
  Rev 1.0.0.117	08:24 2015-12-10	Removed function Get-ScheduleService() as it only defines a type
  Rev 1.0.0.118	11:34 2015-12-10	Renamed function Get-TSsession() to Get-RDPsession()
									Added paramter -Protocol to Get-RDPsession()
  Rev 1.0.0.119	12:19 2015-12-10	Moved function Split-AddressPort() into function Get-NetworkStatistics()
  Rev 1.0.0.120	12:58 2015-12-10	Added -State filtering to Get-NetworkStatistics()
  Rev 1.0.0.121	17:53 2015-12-10	Removed Suspend and Resume process functions
  Rev 1.0.0.122	10:56 2015-12-11	Added function Get-DotNetVersion()
  Rev 1.0.0.125	10:17 2015-12-22	Added function Test-ProcessResponse()
  Rev 1.0.0.126	11:19 2016-01-07	Added function New-MessageBox()
  Rev 1.0.0.127	09:40 2016-01-11	Fixed missing StopWatch handling in Get-ExecutionTime()
  Rev 1.0.0.128	12:00 2016-01-15	Added function Set-KeyPress()
  Rev 1.0.0.129	21:39 2016-01-28	Added ConvertTo-YAML() and ConvertTo-PSON()
  Rev 1.0.0.130	15:57 2016-03-15	Added New-CustomObject()
  Rev 1.1.0.131	16:52 2016-03-17	Changed Get-IpAddress() to Get-IPv4Address()
  Rev 1.1.0.133	13:01 2016-03-23	Added Set-ListView()
  Rev 1.1.0.134	21:44 2016-04-04	Added Get-WmiEventLog()
  Rev 1.1.0.135 16:59 2016-04-26	Added Get-ComputerAdAttribute()
  Rev 1.1.0.136	12:04 2016-04-29	Simplified New-CustomObject()
  Rev 1.1.0.137	17:03 2016-05-02	Fixed Get-WmiEventLog() missing (Get-Date)
									Get-WmiEventLog(), EventCode multivalues added
  Rev 1.1.0.138	15:44 2016-05-03	Get-ComputerAdAttribute() to handle more than 1000 hits
  Rev 1.2.0.139	20:37 2016-05-26	Added Remote Registry from http://psremoteregistry.codeplex.com/
  Rev 1.2.0.140	12:38 2016-06-09	Relabeld old Reg functions not used any more
  Rev 1.2.0.141	13:38 2016-06-09	Changed Remove-RegValue() to accept hive in key name as well
  Rev 1.2.0.142	15:45 2016-06-09	Changed Remove-RegKey() and New-RegKey() to accept hive in key name as well
  Rev 1.2.0.143	12:09 2016-06-14	Rebuilt Get-RegPathParts() to handle ValueNames properly
									Adjusted Remove-RegKey(), Remove-RegValue() and New-RegKey
  Rev 1.2.0.144	10:39 2016-06-17	Adjusted argements to Get-RegPathParts() in Remove-RegKey()
  Rev 2.0.0.145 13:38 2016-08-03	Moved WinForms functions to WinFormsLib (but keps Display-MessageBox)
  Rev 2.0.0.146	12:07 2016-08-15	Fixed Start-MyProcess() to truly wait for all duplicate processes
  Rev 2.0.0.148	18:10 2016-10-17	Extended Get-WmiEventLog() with EventType
  Rev 2.0.0.149	19:44 2017-02-02	Added param alias RegKey to  Remove-RegKey()
									Updated Apply-RegFile() with Remove-RegKey -Force
									Updated Set-Pointer() with Remove-RegKey -Force
  Rev 2.0.0.150	16:19 2017-02-03	Added Param Alias to all Generic -Reg() functions

.SYNOPSIS
  Include this file to get access to all functions defined.

.DESCRIPTION
  Dot source this file (i.e. . .\IFS-PSlib.ps1) use it as a module (.psm1) or configure property 
  Command Extension = True if part of a Sapien Project.

.PARAMETER [None]
  [Parameters and syntax for script]

.EXAMPLE
  [Examples of using script]
  [Just add more EXAMPLE]


.INPUTS 
  [Type of input data required] 
 
.OUTPUTS 
  [Output data generated]
#>


# Global Constants
	[string]$global:IfsPsLibVer = "2.0.0.150"
#	[string]$global:MyLogFileFolder = "C:\IKEALogs\IFS" # set LogFolder in Global instead!

	[string]$global:ProgramData = [Environment]::GetFolderPath('CommonApplicationData')
	[string]$global:ProgramFiles = [Environment]::GetFolderPath('ProgramFiles')
	[string]$global:AliasRegKey = "HKLM:SOFTWARE\IKEA\IDEM\Config\Aliases"

	# should actually use 
	# Set-Variable global:MyVersion -Value ([string]"0,3,0,8") -option Constant
	# but that's to messy to read :(

# Global variables
	[int]$global:LogLevel = 1 # set required level to basic if alias is missing


# Functions
function Set-LogLevel
	{
	<#
		.SYNOPSIS
			Sets the global variable LogLevel
	
		.DESCRIPTION
			Gets the alias POS_Logging and sets varaible $global:LogLevel to the same value.
			If alias POS_Logging is empty or doesn't exist, default to previous value.
	
		.EXAMPLE
			Set-LogLevel
	
		.INPUTS
			None
	
		.OUTPUTS
			None
	
		.NOTES
			$LogLevel is used with the function Add-Log()
	
	#>
	
	$LoggingValueData = (Get-RegValueData -RegKey $AliasRegKey -ValueName POS_Logging)
	if ($LoggingValueData) {$Global:LogLevel = [int]$LoggingValueData} # protect variable from $null values and characters
	Add-Log ("Log level set to " + $LogLevel) -Level 1
# end function Set-LogLevel
}



function Add-Log
	{<#
		.SYNOPSIS
			Add an entry to a logfile.
	
		.DESCRIPTION
			Use Add-Log to add entries to a logfile. Entries are only added if they match the 
	        global variable $global:LogLevel
	
		.PARAMETER  -Entry
			The string being added to the log file.
	
		.PARAMETER  -Level
			The log level required to add the entry to the log file.
			Will default to Level 1.
	
		.PARAMETER -LogFileName
			The file name of the logfile used for the log file entry.
			Will default to global variable $LogFileName
	
		.EXAMPLE -LogFileFolder
			The folder path to where the logfile resides.
	
		.EXAMPLE
			Get-Something 'One value' 32
	
		.INPUTS
			System.String,System.Int32
	
		.OUTPUTS
			System.String
	
		.NOTES
			Additional information about the function go here.
	
		.LINK
			about_functions_advanced
	
		.LINK
			about_comment_based_help
	
	#>
	
	param (
	[parameter(Mandatory=$true)]
	[string]$Entry,
	# 0 - None
	# 1 - Light (default)
	# 2 - Normal
	# 3 - Verbose
	# 4 - Diagnostic
	# 5 - Debug
	
	[ValidateRange(1,5)]
	[int]$Level = 1, # set desired level to Basic if option -Level omitted
	
	[string]$LogFileName = "Unnamed",
	[string]$LogFileFolder = "C:\IKEALogs"
)
	
	if (!$LogLevel) {$LogLevel = 4}
	if ($Level -gt $LogLevel) {return} # if logging level required is higher than global level
	if (!($global:MyName)) {$MyName = $LogFileName} # handle missing variable
	if (!($global:MyLogFileFolder)) {$MyLogFileFolder = $LogFileFolder} # handle missing variable
	
	# Get todays date each time writing to the log to make sure changing log if new day
	$Today = (Get-Date -Uformat "%Y%m%d").ToString()
	$MyLogFileName = $ENV:COMPUTERNAME + "_" + $MyName + "__" + $Today + ".log"
	$MyLogFile = $MyLogFileFolder + "\" + $MyLogFileName
	
	# Check if new log file is needed
	if (!(Test-Path $MyLogFile) -or $Entry -like "Start")
		{
		ni $MyLogFileFolder -Type Directory -ErrorAction 'SilentlyContinue'
		ni $MyLogFile -Type File -ErrorAction 'SilentlyContinue'
		
		"" | Out-File $MyLogFile -Width 160 -Append
		"****************************" | Out-File $MyLogFile -Width 160 -Append
		$ENV:COMPUTERNAME + "   " + (Get-Date -Format g).ToString() | Out-File $MyLogFile -Width 160 -Append
		$MyName + "   Version: " + $MyVersion | Out-File $MyLogFile -Width 160 -Append
		"****************************" | Out-File $MyLogFile -Width 160 -Append
		
		#Housekeeping, Move all old log files to archive
		$ArchiveFolder = $MyLogFileFolder + "\Archive"
		if (!(Test-Path $ArchiveFolder)) {ni $ArchiveFolder -Type Directory -ErrorAction 'SilentlyContinue'}
		
		$colLogFile = dir -Path $MyLogFileFolder | `
		? {$_.Name -like "*$MyName*" -and $_.Name -notlike ("*$Today.log") -and -not $_.PSIsContainer}
		if ($colLogFile) {foreach ($file in $colLogFile) {$file.CopyTo("$ArchiveFolder\$file"); $file.Delete()}}
		rv colLogFile
		
		#Housekeeping, Delete old log files from arhive
		$10daysago = $(get-date) - $(new-timespan -days 10)
		
		$colArchiveFile = dir -Path $ArchiveFolder | `
		? {$_.LastWriteTime -lt $10daysago -and -not $_.PSIsContainer}
		if ($colArchiveFile) {foreach ($file in $colArchiveFile) {$file.Delete()}}
		rv colArchiveFile
	}
	
	switch ($Level) 
		{
		"4" {$Prefix = "DIAG:   "}
		"5" {$Prefix = "DEBUG:   "}
		default {$Prefix = ""}
	}# end switch
	
	(Get-Date -Format u).ToString() + " - " + $Prefix + $Entry | Out-File $MyLogFile -Width 160 -Append

# end function Add-Log	
} 



function Get-RegValueData
	{
	<#
		.SYNOPSIS
			Gets the data of a registry key value.
	
		.DESCRIPTION
			Gets the data of a registry key value.
	
		.PARAMETER  RegKey
			The regkey path name the get the reg value data from.
	
		.PARAMETER  ValueName
			The name of the registry key value.
	
		.PARAMETER  Silent
			Don't log any errors.
	
		.PARAMETER  VerySilent
			Don't log anything (i.e. data is some what sensitive and shouldn't be written to the logs.)
	
		.EXAMPLE
			Get-RegValueData -RegKey "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion" -ValueName "ProductName"
	
			> Windows 7 Enterprise
	
		.EXAMPLE
			Get-RegValueData -RegKey "HKLM:\SYSTEM\CurrentControlSet\Control\Power\User\Default\PowerSchemes " - ValueName "ActivePowerScheme"
	
		.INPUTS
			System.String,System.Switch
	
		.OUTPUTS
			System.String
	
		.NOTES
			Some registry keys might be protected from access. This functions doesn't detect such errors.
	
		.LINK
			https://technet.microsoft.com/en-us/library/cc781906%28v=ws.10%29.aspx
	
		.LINK
			https://technet.microsoft.com/en-us/library/cc740136%28v=ws.10%29.aspx
	
	#>
	
	
	param (
		[string]$RegKey,
		[string]$ValueName,
		[switch]$Silent,
		[switch]$VerySilent
	)
	
	if ($VerySilent){
		$Silent = $true
	}
	
	$Hive = $RegKey.split(":")[0]
	if ($Hive -notlike "HKLM" -and $Hive -notlike "HKCU"){
		Add-Log "ERROR:   Registry hive reference invalid!" -Level 1
		Add-Log "ERROR:   in $RegKey" -Level 3
		
		Return -1
	}# endif
		
	$ValueData = (gp -Path $RegKey -Name $ValueName -ErrorAction 'SilentlyContinue').$ValueName

		if (!$ValueData -and !$Silent){# output error only if not Silent
			Add-Log ("WARNING!   Registry not present: " + $RegKey + "::" + $ValueName) -Level 1
		}
		else { 
			if (!$VerySilent) {# No logs with VerySilent
				Add-Log ("Registry value " + $ValueName + " is: " + $ValueData) -Level 3
				}
		}# end else
	
	return $ValueData

# end function Get-RegValueData
} 



function Set-RegValueData
	{
	<#
		.SYNOPSIS
			Sets the data of a registry key value.
	
		.DESCRIPTION
			Sets the data of a registry key value.
	
		.PARAMETER  RegKey
			The regkey path name the get the reg value data from.
	
		.PARAMETER  ValueName
			The name of the registry key value.
		
		.PARAMETER  ValueData
			The data to be written to the registry.
	
		.PARAMETER  $Type
			The data type to create when writing to the registry.
	
		.PARAMETER  Silent
			Don't log any errors.
	
		.PARAMETER  VerySilent
			Don't log anything (i.e. data is some what sensitive and shouldn't be written to the logs.)
	
		.EXAMPLE
			Set-RegValueData -RegKey "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion" -ValueName "RegisteredOwner" -ValueData "The Geek" -Type ExpandString
	
		.EXAMPLE
			Set-RegValueData -RegKey "HKLM:\SOFTWARE\Classes\`*\shell\Open with Notepad\Command" -ValueData "notepad %1" -Type ExpandString
    
    		This will set the default value.
			For usage on prompt, escape the backtick as well (``).
	
		.INPUTS
			System.String,Microsoft.Win32.RegistryValueKind,Switch
	
		.OUTPUTS
			System.String
	
		.LINK
			https://technet.microsoft.com/en-us/library/cc781906%28v=ws.10%29.aspx
	
		.LINK
			https://technet.microsoft.com/en-us/library/cc740136%28v=ws.10%29.aspx
	
	#>
	
	
	param (
		[System.String]$RegKey,
		[System.String]$ValueName,
		$ValueData,
		[Microsoft.Win32.RegistryValueKind]$Type,
		[switch]$Silent,
		[switch]$VerySilent
	)
	
    $bt = [char]96 #The backtick character `
    
	if ($VerySilent){
		$Silent = $true
	}
	
	$Hive = $RegKey.split(":")[0]
	if ($Hive -notlike "HKLM" -and $Hive -notlike "HKCU")
		{
		Add-Log "ERROR:   Registry hive reference invalid!" -Level 1
		Add-Log "ERROR:   in $RegKey" -Level 3
		
		Return -1
	}
	
	if (!(Test-Path $RegKey)) {
		if (!$Silent) {
			Add-Log "Trying to create registry key $RegKey" -Level 5
		}
		ni $RegKey.Replace("$bt","") -ItemType Registry -Force
	} 
	
	if (!$ValueName) #(default) value is set by New-Item or Set-Item
		{
		if (!$Silent) {
			Add-Log "Valuename not specified. Will apply data as default value for regkey." -Level 5
		}
		si $RegKey -Value $ValueData -Force
	}
	else #Named data is set by New-ItemProperty
		{
		New-ItemProperty $RegKey -Name $ValueName -Value $ValueData -PropertyType $Type -Force
	}
	if (!$Silent){
		Add-Log ("Registry data updated: " + $RegKey + " :: " + $ValueName + " :: " + $ValueData) -Level 3
	}

# end function Set-RegValueData
} 


function Remove-RegValue.old
	{
	<#
		.SYNOPSIS
			Removes a Registry Value.
	
		.DESCRIPTION
			Removes a Registry Value.
	
		.PARAMETER  RegKey
			The regkey path name the remove the reg value data from.
	
		.PARAMETER  ValueName
			The name of the registry key value.
	
		.EXAMPLE
			Remove-RegValue -RegKey "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion" -ValueName "RegisteredOwner"
	
		.INPUTS
			System.String
	
		.OUTPUTS
			None
	
		.LINK
			https://technet.microsoft.com/en-us/library/cc781906%28v=ws.10%29.aspx
	
		.LINK
			https://technet.microsoft.com/en-us/library/cc740136%28v=ws.10%29.aspx
	
	#>
	
	param (
		[string]$RegKey,
		[string]$ValueName
	)
	
	$Hive = $RegKey.split(":")[0]
	
	if ($Hive -notlike "HKLM" -and $Hive -notlike "HKCU")
		{
		Add-Log "ERROR:   Registry hive reference invalid!" -Level 1
		Add-Log "ERROR:   in $RegKey" -Level 3
		
		Return -1
	}
	
	if (Test-Path $RegKey) 
		{ 
		Remove-ItemProperty $RegKey -Name $ValueName -Force
		Add-Log ("Registry value deleted: " + $RegKey + " :: " + $ValueName) -Level 3
	}

# end function Remove-RegValue
} 



function Remove-RegKey.old
	{
		<#
		.SYNOPSIS
			Removes a Registry Key.
	
		.DESCRIPTION
			Removes a Registry Key.
	
		.PARAMETER  RegKey
			The regkey path name for key deletion..
	
		.EXAMPLE
			Remove-RegKey -RegKey "HKLM:\SOFTWARE\Classes\`*\shell\Open with Notepad"
    
    		For usage on prompt, escape the backtick as well (``).
	
		.INPUTS
			System.String
	
		.OUTPUTS
			None
	
		.LINK
			https://technet.microsoft.com/en-us/library/cc781906%28v=ws.10%29.aspx
	
		.LINK
			https://technet.microsoft.com/en-us/library/cc740136%28v=ws.10%29.aspx
	
	#>

	param (
		[string]$RegKey
	)
	
	$Hive = $RegKey.split(":")[0]
	
	if ($Hive -notlike "HKLM" -and $Hive -notlike "HKCU")
		{
		Add-Log "ERROR:   Registry hive reference invalid!" -Level 1
		Add-Log "ERROR:   in $RegKey" -Level 3
		
		Return -1
	}
	
	if (Test-Path $RegKey) 
		{ 
		del $RegKey -Recurse -Force
	
		Add-Log ("Registry key deleted: " + $RegKey) -Level 3
	}

# end function Remove-RegKey
} 



function Apply-RegFile
	{
	<#
		.SYNOPSIS
			Applies a reg-file to the registry.
	
		.DESCRIPTION
			Parses a registry (.reg) file and applies the content based on a path filter.
	
		.PARAMETER  RegFile
			Path to registry file to apply.
	
		.PARAMETER  FilterString
			Filter used to check what content will be applied based on registry path.
	
		.EXAMPLE
			Get-Something -ParameterA 'One value' -ParameterB 32
	
		.INPUTS
			System.String
	
		.OUTPUTS
			None
	
		.NOTES
			Sometimes a registry file must be chekced not to apply changes outside of a preapproved subkey path.
	
		.LINK
			https://technet.microsoft.com/en-us/library/cc781906%28v=ws.10%29.aspx
	
		.LINK
			https://technet.microsoft.com/en-us/library/cc740136%28v=ws.10%29.aspx
	
		.LINK
			https://support.microsoft.com/en-us/kb/310516
	
	#>
	
	param (
	[string]$RegFile,
	[string]$FilterString
)
	
	if (!(Test-Path $Regfile))
		{
		Add-Log ("ERROR:   Parser can't find " + $RegFile) -Level 1
		Add-Log ("ERROR:   Parsing of file aborted.") -Level 2
		Return -1 # if regfile isn't there
	}
	
	if (!$FilterString) # Addhere to previous parameter handling in function
		{$FilterString = $global:RestrainingKey}
	if (!$FilterString) # still no filter, break out
		{
		Add-Log 'Parameter $FilterString is missing.' -Level 5
		Add-Log "ERROR:   Aborting regfile parsing." -Level 1
		Return -1 # if $FilterString is missing
	}
	
	$RegFileContent = cat $RegFile
	$RegFileName = ($RegFile.Split("\"))[-1]
	Add-Log ("Parsing " + $RegFileName) -Level 2

	if (!($RegFileContent[0] -like "Windows Registry Editor*"))
		{Add-Log ("ERROR:  " + $RegFileName + "is not a true Registry File. Aborting parsing.") -Level 1
		Return -1 # if regfile can't be parsed
	}
	
	for ($Line=1; $Line -le $RegFileContent.Count; $Line++)
		{
		# Set $RegKey if a regkey line
		if ($RegFileContent[$Line] -like "*HKEY_LOCAL_MACHINE*")
			{
			$RegKey = $RegFileContent[$Line]
			
			#Fix up syntax
			$RegKey = $RegKey.Trim("`[`]")
			$RegKey = $RegKey.Replace("HKEY_LOCAL_MACHINE\","HKLM:")
			
			#Check for delete syntax
			if ($RegKey[0] -eq "-")
				{
				$RemoveRegkey = $true
				$RegKey = $RegKey.Trimstart("-")
			}
			else
				{
				$RemoveRegkey = $false
			}
			
			# Delete regkey
			if ($RemoveRegkey -and ($RegKey -like $FilterString))
				{Remove-RegKey $RegKey -Force}
			
			Continue #with next line. No need for further parsing as this is a HKEY-line. 
		}
		# Skip empty lines
		if (!$RegFileContent[$Line]) {continue} #with next line if this line is empty
		
		# Check if RegKey is something else than $FilterString then don't use reg key data
		if (!($RegKey -like $FilterString))
			{
			Add-Log ("ERROR:   " + $RegFileName + " in line " + $Line) -Level 1
			Add-Log "ERROR:   Registry file contains protected registry settings." -Level 3
			Add-Log ("ERROR:   " + $RegKey + " DATA: " + $RegFileContent[$Line]) -Level 3
			Add-Log "ERROR:   Parsing of line ABORTED!" -Level 1
			Continue # with next $Line
		}
		
		# Get reg key data
		$LineContentArr = $RegFileContent[$Line].Split("=") # Note. Valuedata may also contain =-signs
		$ValueName = ($LineContentArr[0]).trim("`"")
		
		# Check for default value and fix syntax
		if ($ValueName -like "@") 
			{$ValueName =""}
		
		# Check for delete value command
		if ($LineContentArr[1] -eq '-')
			{
			Remove-RegValue -RegKey $RegKey -ValueName $ValueName
			Continue # with next line
		}
		
		$ValueData = ($LineContentArr[1..99] -join "=").trim("`"") # remove " and readd =-signs if needed
		if (!$ValueData) {continue} #If the line is empty or dosen't contain "=" continue with next line
		$ValueData = $ValueData.replace("\\","\") #remove \-escape if present
				
		# Check if DataType is something else than String
		if ($ValueData -eq $LineContentArr[1])
			{
			$ValueType  =($ValueData.Split(":"))[0]
			$ValueDword = ($ValueData.Split(":"))[1]
			if ($ValueType -like "dword")
				{
				# Convert Dword from Hex to Integer
				$ValueDword = [Convert]::ToInt32($ValueDword,16)
				Set-RegValueData -RegKey $RegKey -ValueName $ValueName -ValueData $ValueDword -Type dword
				Continue # with next line
			}
			Add-Log ("ERROR:   " + $RegFileName + " in line " + $Line) -Level 1
			Add-Log "ERROR:   Registry file contains data types not handled by the Config parser." -Level 3
			Add-Log ("ERROR:   " + $RegKey + " DATA: " + $RegFileContent[$Line]) -Level 3
			Add-Log "ERROR:   Parsing of line aborted!" -Level 1
			Continue # with next $Line
		}
		# Last expression in parser
		Set-RegValueData -RegKey $RegKey -ValueName $ValueName -ValueData $ValueData -Type string
	}

# end function Apply-RegFile
} 



function Start-MyProcess
	{
	<#
		.SYNOPSIS
			Starts a new process.
	
		.DESCRIPTION
			Starts a new process with some error handling.
	
		.PARAMETER  StartProcessPath
			Path to exectable to start.
	
		.PARAMETER  Argument
			Arguments to be used by the executable.
	
		.PARAMETER  WorkingDir
			The directory that the executable should start with as current directory.
	
		.PARAMETER  $CheckTime
			Add a warning to the log file if the runtime exsceeds this amount of seconds.
	
		.EXAMPLE
			Get-Something -ParameterA 'One value' -ParameterB 32
	
		.EXAMPLE
			Get-Something 'One value' 32
	
		.INPUTS
			System.String,System.Int32
	
		.OUTPUTS
			None
	
		.NOTES
			This function will control if the process was actually launched succesfully using .Net Win32_Process.
			It will properly handle cscript arguments.
			If a process with the same name is already running it will wait for the first instance to finnish.
			When the process is launched, the function will wait for the process to end, logging the end time.
			The function doesn't wait for any spawned child processes.
	
		.LINK
			about_functions_advanced
	
		.LINK
			about_comment_based_help
	
	#>
	
	param (
		[String]$StartProcessPath,
		[String]$Argument = "",
		[String]$WorkingDir,
		[INT]$CheckTime #warn if Runtime exceeds $CheckTime
	)
	
	if (!(Test-Path $StartProcessPath)){
		Add-Log ("WARNING!    The file " + $StartProcessPath + " doesn't exist.") -Level 2
		Add-Log "WARNING!    Cant start the process. Aborting!" -Level 1
		Return
	}
	
		
	# Check if Process is already running
	$StartProcessFile = Get-Item -Path $StartProcessPath
	$StartProcessFileName = $StartProcessFile.Name
    $StartProcessName = $StartProcessFile.BaseName
	Remove-Variable -Name StartProcessFile -ErrorAction 'SilentlyContinue' # breaks connection to file object
	Remove-Variable -Name DuplicateProcess -ErrorAction 'SilentlyContinue' # make sure nothing left from before
   
	if ($StartProcessName -like "cscript") {# then add actual "-signs to the argument
		$Argument = [char]34 + $Argument + [char]34
	}
	
	# Wait if an instance is found
	while (Get-Process $StartProcessName -ErrorAction 'SilentlyContinue'){
		$DuplicateProcess = Get-Process $StartProcessName -ErrorAction SilentlyContinue
		foreach ($Process in $DuplicateProcess) {
			Add-Log ("WARNING:   A process named " + $StartProcessName + " with PID: " + $Process.Id + " is already running.") -Level 3
			Add-Log ("Waiting for process " + $Process.Id + " to end...") -Level 3
			Wait-Process -Id $Process.Id -ErrorAction 'SilentlyContinue'
		}# end foreach process
	}# end while

	#	$ErrorActionPreference = "stop"
		
	try {
		$win32_proc = [WMICLASS]"Win32_Process"
		if ($WorkingDir)
			{$process = $win32_proc.create("$StartProcessPath $Argument",$WorkingDir)}
		else
			{$process = $win32_proc.create("$StartProcessPath $Argument")}
	}

	finally 
		{
		# This is apperantly not a system error
		$ProcessStartTime = [DateTime]::Now
		$return = $process.ReturnValue
		
		switch ($return) 
			{
			0 {$errmsg = "Succesful Completion"}
			2 {$errmsg = "Access Denied"}
			3 {$errmsg = "Insuficient Privilege"}
			8 {$errmsg = "Unknown failure"}
			9 {$errmsg = "Path Not Found"}
			21 {$errmsg = "Invalid Parameter"}
		}
		
		$processObj = Get-Process -Id $process.ProcessId
		Add-Log ("Trying to start " + $processObj.Name + " $Argument with PID: " + $processObj.Id) -Level 4
		if ($WorkingDir) {Add-Log "Working directory set to $WorkingDir" -Level 4}
		
		if ($return -ne 0)
			{
			$msg = "Could not start: `r" + $StartProcessPath + " `r`r"	+ "Return code: " + $process.ReturnValue + ". " + $errmsg
			Add-Log ("ERROR:   " + $msg) -Level 1
		}
		
		if ($return -eq 0) {Add-Log ("STARTED:   $StartProcessName $Argument") -Level 2}
		
		Add-Log "Waiting for process to end..." -Level 3
		Wait-Process -Id $process.ProcessId
		$ProcessEndTime = [DateTime]::Now
		$ProcessRunTime = $ProcessEndTime.Subtract($ProcessStartTime)
	}# end finally

	
	Add-Log ("WAITED:   " + $ProcessRunTime.TotalSeconds + " seconds.") -Level 3
	if ($ProcessRunTime.TotalSeconds -ge $CheckTime -and $CheckTime)
		{Add-Log "WARNING:   Run time exceeds $CheckTime seconds."}

# end function Start-MyProcess
} 



function Wake-Idem()
	{
	<#
		.SYNOPSIS
			Not used in any script.
	
		.DESCRIPTION
			Not used in any script.
	
	#>
	
	# Don't run if IDEM isn't there
	if (!(Test-Path "C:\Program Files\IKEA\IDEMAgent\IdemAgent.exe")) {Return -1}
	
	# Don't run if IDEM is already running
	if (gps IdemAgent -ErrorAction 'SilentlyContinue') {Return 0}
		
#	# Check if user is running as Admin or not
#	$IsAdmin = ([Security.Principal.WindowsPrincipal] `
#	[Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")
#	
#	if ($IsAdmin){
#		Start-MyProcess -StartProcessPath "C:\Program Files\IKEA\IDEMAgent\IdemAgent.exe" -Arguments "-run"
#	}
#	else
#		{
#		Start-MyProcess -StartProcessPath "C:\Program Files\IKEA\IDEMAgent\Wakeup.exe"
#	
#		# Wait for IdemAgent to be woken and then get ProcessId
#		while (!($IdemAgentProcess = get-process IdemAgent -ErrorAction 'SilentlyContinue')){sleep 1}
#		Add-Log ("IDEMagent started with PID: " + $IdemAgentProcess.Id) -Level 2
#		
#		# Wait for IdemAgent to finish
#		Add-Log "Waiting..." -Level 3
#		while (!$IdemAgentProcess.HasExited) {sleep 1}
#		Add-Log "Exiting wait state." -Level 3
#	}
	
	# Always run Wakeup as Basic User on ICC4
	Add-Log "Waking Idem..." -Level 1
	
	$OSver = [System.Environment]::OSVersion.Version.Major + [System.Environment]::OSVersion.Version.Minor/10
	if ($OSver -ge 6.1)
		{
		Start-MyProcess -StartProcessPath "C:\Windows\System32\runas.exe" -Argument '/trustlevel:0x10000 "C:\Program Files\IKEA\IDEMAgent\Wakeup.exe"'
	}
	else
		{
		Start-MyProcess -StartProcessPath "C:\Program Files\IKEA\IDEMAgent\Wakeup.exe"
	}

	# Wait for IdemAgent to be woken and then get ProcessId
	while (!($IdemAgentProcess = gps IdemAgent -ErrorAction 'SilentlyContinue')){sleep 1}
	Add-Log ("IDEMagent started with PID: " + $IdemAgentProcess.Id) -Level 2
	
	# Wait for IdemAgent to finish
	Add-Log "Waiting for IDEM Agent..." -Level 3
	while (!$IdemAgentProcess.HasExited) {sleep 1}
	Add-Log "Exiting wait state." -Level 3

# end Wake-Idem
}



Function New-ScheduledTaskObject
	{ 
	<#
		.SYNOPSIS
			Creates a taskfolder object
	
		.DESCRIPTION
			Creates and returns a taskfolder object
	
		.PARAMETER  Path
			Scheduled task folder path to connect to.
	
		.EXAMPLE
			New-ScheduledTaskObject -Path "\Test"
	
		.INPUTS
			System.String
	
		.OUTPUTS
			Schedule.Service.Object
	
		.NOTES
			No additional notes.
	
		.LINK
			https://msdn.microsoft.com/en-us/library/windows/desktop/aa394601%28v=vs.85%29.aspx
	
	#>
	
	param (
		[string]$Path = "\"
	)
	
	$ScheduledTaskObject = New-Object -ComObject schedule.service
	$ScheduledTaskObject.Connect()
	
	$ScheduledTaskObject.GetFolder($Path)

# end New-ScheduledTaskObject
}



Function Get-ScheduledTaskFolder
	{
	<#
		.SYNOPSIS
			Returns path to Scheduled folder.
	
		.DESCRIPTION
			Returns a string representing the path to a scheduled task folder.
	
		.PARAMETER  objFolder
			Scheduled task folder path to connect to.
	
		.PARAMETER  Recurse
			Set switch if folders should be found recursively.
	
		.EXAMPLE
			Get-ScheduledTaskFolder -objFolder $ScheduledFolder
	
		.INPUTS
			Schedule.Service.Object
	
		.OUTPUTS
			System.String
	
		.NOTES
			No additional notes.
	
		.LINK
			https://msdn.microsoft.com/en-us/library/windows/desktop/aa394601%28v=vs.85%29.aspx
	
	#>
	
	param (
		$objFolder,
		[switch]$Recurse
	)
	
	if($recurse)
		{
		$colFolders = $objFolder.GetFolders(0)
			foreach($item in $colFolders)
				{
				$item.path
				$subFolder = (New-ScheduledTaskObject -path $item.path)
				Get-ScheduledTaskFolder -folder $subFolder -recurse
			}
	} #end if
	else
		{
		$objFolder.GetFolders(0) |
		% { $_.path }
	} #end else

# end Get-ScheduledTaskFolder
}


Function New-ScheduledTaskFolder
	{ 
	<#
		.SYNOPSIS
			Creates a Scheduled folder.
	
		.DESCRIPTION
			Creates and returns a scheduled task folder.
	
		.PARAMETER  objFolder
			Scheduled task folder object to create new scheduled task folder in.
	
		.PARAMETER  Path
			Path to create new folder.
	
		.EXAMPLE
			New-ScheduledTaskFolder -objFolder $ScheduledFolder -Path "Test"
	
		.INPUTS
			Schedule.Service.Object,System.String
	
		.OUTPUTS
			Schedule.Service.Object
	
		.NOTES
			No additional notes.
	
		.LINK
			https://msdn.microsoft.com/en-us/library/windows/desktop/aa394601%28v=vs.85%29.aspx
	
	#>
	param (
		$objFolder,
		[string]$path
	)
	
	$objFolder.createFolder($path)

# end New-ScheduledTaskFolder
}



Function Remove-ScheduledTaskFolder
	{
	<#
		.SYNOPSIS
			Removes a Scheduled folder.
	
		.DESCRIPTION
			Removes a scheduled task folder.
	
		.PARAMETER  objFolder
			Scheduled task folder object to create new scheduled task folder in.
	
		.PARAMETER  Path
			Path to folder to remove.
	
		.EXAMPLE
			Remove-ScheduledTaskFolder -objFolder $ScheduledFolder -Path "Test"
	
		.INPUTS
			Schedule.Service.Object,System.String
	
		.OUTPUTS
			Schedule.Service.Object
	
		.NOTES
			No additional notes.
	
		.LINK
			https://msdn.microsoft.com/en-us/library/windows/desktop/aa394601%28v=vs.85%29.aspx
	
	#>
	
	param (
		$objFolder,
		[string]$path
	)
	
	$objFolder.DeleteFolder($path,$null)

#end Remove-ScheduledTaskFolder
}




Function New-ScheduledTask
	{
	<#
		.SYNOPSIS
			Creates new scheduled task.
	
		.DESCRIPTION
			Creates new scheduled task.
	
		.PARAMETER  Name
			Name of new Scheduled task.
	
		.PARAMETER  Description
			Description of new Scheduled task.
	
		.PARAMETER  Trigger
			Trigger for starting Scheduled task.
	
		.PARAMETER  Path
			Path to executable to add to Scheduled task.
	
		.PARAMETER  Argument
			Argument for executable.
	
		.PARAMETER  WorkingDir
			Path to default woring directory for executable. May conatin DLL:s or other components
			required to be present by the executable.
	
		.EXAMPLE
			New-ScheduledTaskFolder
	
		.INPUTS
			System.String
	
		.OUTPUTS
			Schedule.Service.Object
	
		.NOTES
			The function currently defaults to \IFS
	
		.LINK
			https://msdn.microsoft.com/en-us/library/windows/desktop/aa394601%28v=vs.85%29.aspx
	
	#>
	
	param (
		[string]$Name,
		[string]$Description,
	
		[ValidateSet("Daily","Boot","Logon")]
		[string]$Trigger,
	
		[string]$Path,
		[string]$Argument,
		[string]$WorkingDir
	)
	
	# Connect to Folder
	$objSchTask = New-Object -ComObject schedule.service
	$objSchTask.Connect()
	$objSchTask_Folder = $objSchTask.GetFolder('\IFS')

	# Add Sync Task / Defintion
	$objSchTaskDef = $objSchTask.NewTask(0)

	# Registration
	$objSchTaskDef_RegInfo = $objSchTaskDef.RegistrationInfo

	$objSchTaskDef.RegistrationInfo.Description = $description

	# Settings
	$objSchTask_Settings = $objSchTaskDef.Settings

	$objSchTask_Settings.Enabled = $true
	$objSchTask_Settings.StartWhenAvailable = $true
	$objSchTask_Settings.Hidden = $false
	$objSchTask_Settings.StopIfGoingOnBatteries = $false
	$objSchTask_Settings.DisallowStartIfOnBatteries = $false

	# Triggers
	switch ($trigger)
		{
		"Daily" 
			{
				$objSchTask_Triggers = $objSchTaskDef.Triggers
				$objSchTask_Trigger = $objSchTask_Triggers.Create(2)
				$objSchTask_Trigger.StartBoundary = "2013-10-29T01:00:00"
				$objSchTask_Trigger.DaysInterval = 1
				$objSchTask_Trigger.Id = "DailyTriggerId"
				$objSchTask_Trigger.Repetition.Interval = "PT15M"
				$objSchTask_Trigger.Repetition.Duration = "P1D"
				$objSchTask_Trigger.Enabled = $true
		}
		"Boot" 
			{
				$objSchTask_Triggers = $objSchTaskDef.Triggers
				$objSchTask_Trigger = $objSchTask_Triggers.Create(8)
				$objSchTask_Trigger.Id = "BootTrigger"
				$objSchTask_Trigger.Enabled = $true
		}
		"Logon" 
			{
				$objSchTask_Triggers = $objSchTaskDef.Triggers
				$objSchTask_Trigger = $objSchTask_Triggers.Create(9)
				$objSchTask_Trigger.Id = "LogonTrigger"
				$objSchTask_Trigger.Enabled = $true
		}
	}

	# Action
	$objSchTask_Action = $objSchTaskDef.Actions.Create(0)
	$objSchTask_Action.Path = $path
	$objSchTask_Action.Arguments = $argument
	$objSchTask_Action.WorkingDirectory = $workingdir

	# Create Task
	$objSchTask_Folder.RegisterTaskDefinition($name, $objSchTaskDef, 6, "System", $null , 5) | out-null

# end New-ScheduledTask
}



Function Remove-ScheduledTask
	{
	<#
		.SYNOPSIS
			Removes scheduled task.
	
		.DESCRIPTION
			Removes all scheduled task from \IFS
	
		.EXAMPLE
			Remove-ScheduledTask
	
		.INPUTS
			System.String
	
		.OUTPUTS
			Schedule.Service.Object
	
		.NOTES
			The function currently defaults to \IFS
	
		.LINK
			https://msdn.microsoft.com/en-us/library/windows/desktop/aa394601%28v=vs.85%29.aspx
	
	#>
	
	# Connect to Folder
	$objSchTask = New-Object -ComObject schedule.service
	$objSchTask.Connect()
	$objSchTask_Folder = $objSchTask.GetFolder('\IFS')
	
	# Get Tasks and delete all # Maybe we should wait for them to finish? Dont know.
	$objSchTasks = $objSchTask_Folder.GetTasks(0)
	
	foreach ($Task in $objSchTasks)
		{
		$objSchTask_Folder.DeleteTask($Task.Name,0)
	}

# end Remove-ScheduledTask
}



function Invoke-ScheduledTask
	{
	<#
		.SYNOPSIS
			Invokes scheduled task.
	
		.DESCRIPTION
			Runs a scheduled task by name.
	
		.PARAMETER  Name
	
		.PARAMTER  Folder
	
		.EXAMPLE
			Invoke-ScheduledTask -Folder "\IFS" -Name "OPOS Config"
	
		.INPUTS
			System.String
	
		.OUTPUTS
			None
	
		.NOTES
			Triggers a scheduled task to be run.
	
		.LINK
			https://msdn.microsoft.com/en-us/library/windows/desktop/aa394601%28v=vs.85%29.aspx
	
	#>
	
	param (
		[String]$Name,
		[String]$Folder
	)
	
	$Unknown = 0
	$Disabled = 1
	$Queued = 2
	$Ready = 3
	$Running = 4

	$objTask = New-Object -ComObject schedule.service
	$objTask.Connect()
	$objTask_IfsFolder = $objTask.GetFolder($Folder)

	$objTask_IfsFolder.GetTask($Name).Run(0)

	Add-Log ("Starting Scheduled Task: " + $Name) -Level 2
	Add-Log "Waiting..." -Level 3
	while ($objTask_IfsFolder.GetTask($Name).State -like $Running) {sleep 1}
	sleep 1 # let TaskScheduler stabilize the next state before polling
	
	clv strResult -ErrorAction 'SilentlyContinue'
	clv intResult -ErrorAction 'SilentlyContinue'
	$intResult = $objTask_IfsFolder.GetTask($Name).LastTaskResult
	
	switch ($intResult)
		{
		0 {$Status = "OK:   "; $strResult = "completed succesfully"}
		1 {$Status = "ERROR:   "; $strResult = "is incorrect or unkonwn function"}
		10 {$Status = "ERROR:   "; $strResult = "has incorrect environment"}
	}
	
	Add-Log ($Status + "Scheduled Task: " + $Name + " run last: " + $objTask_IfsFolder.GetTask($Name).LastRunTime + "; " + $strResult) -Level 1

# end function Run-ScheduledTask
}



function Expand-ZipFile
	{
	<#
		.SYNOPSIS
			Expand Zip-file
	
		.DESCRIPTION
			Expand Zipfile using Ionic DotNetZip DLL
	
		.PARAMETER  ZipFile
			Zip file including path to extract.
	
		.PARAMETER  Destination
			Destination path to extract contecnt of Zip file.
	
		.EXAMPLE
			Expand-ZipFile -ZipFile "C:\Users\Public\Downloads\MyFile.zip" -Destination "C:\ProgramData\IKEA\Module"
	
		.INPUTS
			System.String
	
		.OUTPUTS
			None
	
		.NOTES
			Can't use built in extract function of Explorer.exe as that process ins't running in ICC 
			kiosked mode.
	
		.LINK
			http://dotnetzip.codeplex.com/wikipage?title=PS-Examples
	
	#>
	
	Param (
		[string]$ZipFile, 
		[string]$Destination
	)
	
	# Check if zipped folder already exists
	Add-Log "Zipfile: $ZipFile" -Level 4
	Add-Log "Destination: $Destination" -Level 4
	$ZipFileName = ($ZipFile.Split("\"))[-1]
	Add-Log "ZipFileName: $ZipFileName" -Level 4
	$ZipFolderName = ($ZipFileName.Split("."))[0]
	Add-Log "ZipFolderName: $ZipFolderName" -Level 4

	if (!(Test-Path $ZipFile))
		{
		Add-Log ("ERROR:   " + $ZipFile + " not found.") -Level 2
		Add-Log "ERROR:   Couldn't start extraction." -Level 1
		Return
	}

	if (!(Test-Path ($Destination + "\" + $ZipFolderName)))
		{
		Add-Log ("Starting to extract " + $ZipFileName) -Level 2
		Add-Log "Extracting files to $Destination\$ZipFolderName\" -Level 4
		if (!$MyExecutablePathDir)
			{$MyExecutablePathDir = Get-MyExecutablePath}
		Add-Log "MyExecutablePathDir: $MyExecutablePathDir" -Level 4
		Add-Type -Path $MyExecutablePathDir\Ionic.Zip.Reduced.dll
		$ZipObject = [Ionic.Zip.ZipFile]::Read($ZipFile) 
		$ZipObject | % {# Code block must start on this line due to synyax bug!!
			$_.Extract($Destination)
			Add-Log "Extracting $_" -Level 4
		}

		$ZipObject.Dispose()
	}
	else
		{
		Add-Log ("ERROR!   Destination " + ($Destination + "\" + $ZipFolderName) + " already exists.") -Level 1
		Add-Log ("ERROR!   Aborting extraction of " + $ZipFileName) -Level 1
	}

# end Expand-ZipFile
}



function Get-ICCAlias
	{
	<#
		.SYNOPSIS
			Gets ICC alias from Active Directory.
	
		.DESCRIPTION
			Gets ICC alias from Active Directory.
	
		.PARAMETER  ComputerName
			Name of Computer object to look for the alias in AD.
	
		.PARAMETER  AliasName
			Name of alias to find in AD.
	
		.EXAMPLE
			Get-ICCAlias -AliasName POS_Logging
	
		.EXAMPLE
			Get-ICCAlias -ComputerName RETSE268-IF0008 -ICCAlias POS_STP_TerminalId
	
		.INPUTS
			System.String
	
		.OUTPUTS
			System.String
	
		.NOTES
			Function doesn't do recursion and will only find alias on computer object.
	
		.LINK
			https://icchandbook.ikea.com/kb/SitePages/DisplayPopUpPage.aspx?KBID=121&IsDlg=1
	
		.LINK
			https://icchandbook.ikea.com/kb/SitePages/DisplayPopUpPage.aspx?KBID=120&IsDlg=1
	
	#>
	
	param (
		[string]$ComputerName = $ENV:COMPUTERNAME,
		[string]$AliasName
	) 
	$Alias = @{} # Empty the Alias hash table
	$Alias.Clear()
	
	$ComputerName = $ComputerName.ToUpper()
	
	$LdapFilter = "(&(|(objectCategory=computer)(objectCategory=person))(cn=$ComputerName))" # both computer and placeholder
#	$LdapFilter = "(&(objectCategory=computer)(objectClass=computer)(cn=$ComputerName))" # only computer
	[ARRAY]$DNgroupCol = ([adsisearcher]$LdapFilter).FindOne().Properties.memberof
	
	ForEach ($DNGroup in $DNgroupCol) # Traverse through each group found for the computer
		{
		$AliasContainer=[ADSI]("LDAP://CN=Aliases,$DNgroup")
		$AliasCol = $AliasContainer.PSbase.Children
		
		foreach ($AliasObj in $AliasCol) # Populate the $alias hash with each new alias and value
			{$Alias[$AliasObj.Name.Tostring()] = $AliasObj.Description.Tostring()}
	} # End traversing computer groups for aliases
	
	$DNComputer = ([adsisearcher]$LdapFilter).FindOne().properties.distinguishedname
	$ComputerAliasContainer = [ADSI]("LDAP://CN=Aliases,$DNComputer")
	$ComputerAliasCol = $ComputerAliasContainer.PSbase.Children
	
	foreach ($AliasObj in $ComputerAliasCol) # Populate the $alias hash with each new alias and value
		{$Alias[$AliasObj.Name.Tostring()] = $AliasObj.Description.Tostring()}
	
	if ($AliasName) 
		{
		if ($Alias[$AliasName] -like "*To be specified*") # not designated a specific value
			{
			Add-Log "WARNING:   Alias $AliasName not configured! Will default to empty value." -Level 1
			Return $null
		}# end if not set
		
		Return $Alias[$AliasName]}
	else
		{Return $Alias} # end if $AliasName

# end function ICCGet-Alias
}



function Get-MyExecutablePath
	{
	<#
		.SYNOPSIS
			Get path to the PoSH executable.
	
		.DESCRIPTION
			Get path to the executable handling the PoSH runtime environment.
	
		.EXAMPLE
			Get-MyExecutablePath
	
		.INPUTS
			None
	
		.OUTPUTS
			System.String
	
		.NOTES
			In some cases we need to find out if the script is running wrapped or plain.
	
		.LINK
			http://software.dell.com/products/powergui-freeware/
	
		.LINK
			https://gallery.technet.microsoft.com/PS2EXE-Convert-PowerShell-9e4e07f1
	
		.LINK
			https://www.sapien.com/software/powershell_studio
	
	#>
	
	$MyExecutablePath = (gps -Id $Pid).path
	$MyExecutable = $MyExecutablePath.Split("\")[-1]
	if ($MyExecutable -like "powershell.exe") # run as script
		{
		$MyInvocationPath = $MyInvocation.MyCommand.Path
		if ($MyInvocationPath) # run from PS console there will be no script path
			{return [System.IO.Path]::GetDirectoryName($MyInvocationPath.ToString())}
	}
	else # we are running as a packaged executable
		{
		return [System.IO.Path]::GetDirectoryName($MyExecutablePath)
	}

# end function Get-MyExecutablePath
}



function Display-MessageBox
	{
	<#
		.SYNOPSIS
			Display MessageBox.
	
		.DESCRIPTION
			Displays a Message box.
	
		.PARAMETER  Message
			Message of the message box.
	
		.PARAMETER  Title
			Title of the message box.
	
		.PARAMETER  Type
			Type of message box.
			0 - OK, 1 - OKCancel, 2 - AbortRetryIgnore, 3 - YesNoCancel, 4 - YesNo, 5 - RetryCancel
	
		.EXAMPLE
			Display-MessageBox -Title "Information" -Message "Read this message `r now!" -Type 0
	
		.EXAMPLE
			$Button = Display-MessageBox -Title "Attention" -Message "Abort Operation?" -Type 2
	
		.INPUTS
			System.String,System.Int32
	
		.OUTPUTS
			System.String
	
		.NOTES
			The function will return the result of what button was pressed.
	
		.LINK
			https://msdn.microsoft.com/en-us/library/tk4wkzwk%28v=vs.90%29.aspx
	
	#>
	
	
	param (
		[string]$Message = "",
		[string]$Title = "",
		[ValidateRange(0,5)][int]$Type = 0
	)
	
	[System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") 
	$msgBox = [System.Windows.Forms.MessageBox]
	$msgBox::Show($Message,$Title,$Type)

# end function Display-MessageBox
}



function Apply-IdemLogonScript
	{
<#
		.SYNOPSIS
			Applies IDEM Log On scripts.
	
		.DESCRIPTION
			Runs the scripts applied by IDEM at log on.
	
		.PARAMETER  Filter
			Not implemented.
	
		.PARAMETER
			Not implemented.
	
		.EXAMPLE
			Apply-IdemLogonScript
	
		.INPUTS
			None
	
		.OUTPUTS
			None
	
		.NOTES
			The IDEM agent runs some ICC scripts at log on.
	
		.LINK
			https://icchandbook.ikea.com/kb/SitePages/DisplayPopUpPage.aspx?KBID=127&IsDlg=1
		
	#>

	param (
		[array]$Filter, # used to filter out scripts not to be run. Not implemented yet!
		[INT]$CheckTime = 9999
	)
	
	$colLogonFile = Get-ChildItem -Path "c:\Program Files\IKEA\Logon" | `
	where {$_.Name -like "*.vbs" -and -not $_.PSIsContainer} | sort
	foreach ($script in $colLogonFile) 
		{
		Start-MyProcess -StartProcessPath "c:\Windows\System32\cscript.exe" -Argument $script -WorkingDir "c:\Program Files\IKEA\Logon" -CheckTime $CheckTime
	}
	Remove-Variable colLogonFile

# end function Apply-IdemLogonScript
}



function Apply-IdemLogoffScript
	{
	<#
		.SYNOPSIS
			Applies IDEM Log Off scripts.
	
		.DESCRIPTION
			Runs the scripts applied by IDEM at log off.
	
		.EXAMPLE
			Apply-IdemLogoffScript
	
		.INPUTS
			None
	
		.OUTPUTS
			None
	
		.NOTES
			The IDEM agent runs some ICC scripts at log off.
	
		.LINK
			https://icchandbook.ikea.com/kb/SitePages/DisplayPopUpPage.aspx?KBID=127&IsDlg=1
		
	#>
	
	$colLogoffFile = Get-ChildItem -Path "c:\Program Files\IKEA\Logoff" | `
	where {$_.Name -like "*.vbs" -and -not $_.PSIsContainer} | sort
	foreach ($script in $colLogoffFile) 
		{
		Start-MyProcess -StartProcessPath "c:\Windows\System32\cscript.exe" -Argument $script -WorkingDir "c:\Program Files\IKEA\Logoff"
	}
	Remove-Variable colLogoffFile

# end function Apply-IdemLogoffScript
}


function Get-FileShareLock
	{
	<#
		.SYNOPSIS
			Get locked files in a share.
	
		.DESCRIPTION
			Get all locked files in a share for one or more computers.
	
		.PARAMETER  ComputerName
			Computers to investigate.
	
		.PARAMETER  Verbose
			Output some extra information.
	
		.EXAMPLE
			$locks = Get-FileShareLock -Computer $RETSE268-NT4010
	
		.INPUTS
			System.String
	
		.OUTPUTS
			System.Object
		
		.LINK
			https://support.microsoft.com/en-us/kb/313472
	
		.LINK
			https://msdn.microsoft.com/en-us/library/windows/desktop/aa365203%28v=vs.85%29.aspx
	
	#>
	
	param
	(
		$computername = @($env:computername),
		$verbose = $false
	)
	
	$collection = @()
	
	foreach ($computer in $computername)
		{
		$netfile = [ADSI]"WinNT://$computer/LanmanServer"

		$netfile.Invoke("Resources") | foreach { # must start at this line
			try{
				$collection += New-Object PsObject -Property @{
					Id = $_.GetType().InvokeMember("Name", 'GetProperty', $null, $_, $null)
					itemPath = $_.GetType().InvokeMember("Path", 'GetProperty', $null, $_, $null)
					UserName = $_.GetType().InvokeMember("User", 'GetProperty', $null, $_, $null)
					LockCount = $_.GetType().InvokeMember("LockCount", 'GetProperty', $null, $_, $null)
					Server = $computer
				}
			}
			catch{
				if ($verbose){write-warning $error[0]}
			}
		}
	}
	
	Return $collection

# end function Get-FileShareLock
}



function Get-FileShareSession
	{
	<#
		.SYNOPSIS
			Get active sessions for a share.
	
		.DESCRIPTION
			Get all active sessions for a share on one or more computers.
	
		.PARAMETER  ComputerName
			Computers to investigate.
	
		.PARAMETER  Verbose
			Output some extra information.
	
		.EXAMPLE
			$sessions = Get-FileShareSession -Computer $RETSE268-NT4010
	
		.INPUTS
			System.String
	
		.OUTPUTS
			System.Object
	
		.NOTES
			Additional information about the function go here.
	
		.LINK
			https://technet.microsoft.com/en-us/library/cc725689.aspx
	
		.LINK
			https://technet.microsoft.com/en-us/library/bb490711.aspx
	
	#>
	
	param (
		$computername = @($ENV:COMPUTERNAME),
		$verbose = $false
	)
	
 	$SessionCollection = @() 

	foreach ($computer in $computername)
	{
	$netfile = [ADSI]"WinNT://$computer/LanmanServer"

	$netfile.Invoke("Sessions") | foreach { # must start at this line
			try{
				$SessionCollection += New-Object PsObject -Property @{
					Id = $_.GetType().InvokeMember("Name", 'GetProperty', $null, $_, $null)
                    User = $_.GetType().InvokeMember("User","GetProperty",$null,$_,$null) 
                    Computer = $_.GetType().InvokeMember("Computer","GetProperty",$null,$_,$null) 
                    ConnectTime = $_.GetType().InvokeMember("ConnectTime","GetProperty",$null,$_,$null) 
                    IdleTime = $_.GetType().InvokeMember("IdleTime","GetProperty",$null,$_,$null)
					Server = $computer
				}
			}
			catch{
				if ($verbose){write-warning $error[0]}
			}
		}
	}
	
	Return $SessionCollection

# end function Get-FileShareSession
}



function Get-ClientOuCollection
	{
	<#
		.SYNOPSIS
			Get ICC clients in a Busieness Unit.
	
		.DESCRIPTION
			A detailed description of the function.
	
		.PARAMETER  ClientOuName
			Name of ICC business unit to find clients in. If not provided will use the same business
			unit as the calling computer.
	
		.PARAMETER  ComputerFilter
			Type of clients to find. Will default to -IF0.
	
		.PARAMETER  Attribute
			AD object attribute to return.
	
		.EXAMPLE
			$col = Get-ClientOuCollection
	
		.EXAMPLE
			$col = Get-ClientOuCollection -ClientOUName "RETSE268" -Attribute 'manager'
	
		.INPUTS
			System.String
	
		.OUTPUTS
			System.Object
	
		.NOTES
			Additional information about the function go here.
	
		.LINK
			https://technet.microsoft.com/en-us/library/cc758565%28v=ws.10%29.aspx
	
		.LINK
			https://msdn.microsoft.com/en-us/library/bb727067.aspx
	
	#>
	
	param (
		[string]$ClientOuName = ($ENV:COMPUTERNAME).Split("-")[0],
	
		[string]$ComputerFilter = "-IF0",
	
		[ValidateSet("cn","description","displayName","distinguishedName","info","instancetype","manager",
		"name","objectCategory","objectClass","objectGUID","objectSid","operatingSystem",
		"operatingSystemServicePack","operatingSystemVersion","primaryGroupID","pwdLastSet","sAMAccountName",
		"sAMAccountType","servicePrincipleName","userAccountControl","whenChanged","whenCreated")]
		[string]$Attribute
	)
	
	# GetMyDN
	$LdapFilter = "(&(objectCategory=computer)(objectClass=computer)(cn=$ClientOuName*))"
	[string]$DNstr = ([adsisearcher]$LdapFilter).FindOne().Properties.distinguishedname

	# Construct Clients OU
	$OUstr = "OU=Clients," + ($DNstr.split(",")[2..99] -join ",")

	# Get all clients in OU
	$OU = [ADSI]("LDAP://"+$OUstr)
	$ClientCollection = $ou.PSbase.Children | where {$_.Name -like "*$ComputerFilter*" -and ($_.ObjectCategory -like "*computer*" -or $_.ObjectCategory -like "*person*")}

	if (!$Attribute)
		{Return $ClientCollection
	}
	else
		{Return ($ClientCollection | foreach {$_.$Attribute})
	}

# end function Get-ClientOuCollection
} 



function Get-LocalAlias
	{
	<#
		.SYNOPSIS
			Get ICC alias from local system.
	
		.DESCRIPTION
			Get ICC alias stored in registry of local system host.
	
		.PARAMETER  Alias
			Name of ICC alias to retrieve.
	
		.PARAMETER  Mandatory
			Adds additional error handling if the alias is mandatory for the usage intended.
	
		.EXAMPLE
			Get-LocalAlias -Alias POS_Logging
	
		.EXAMPLE
			Get-LocalAlias -Alias POS_STP_ServerName -Mandatory
	
		.INPUTS
			System.String,System.Switch
	
		.OUTPUTS
			System.String
	
		.NOTES
			ICC aliases are parameters set in the AD using the IMU tool and pulled by the IDEM agent
			on all ICC hosts.
	
		.LINK
			https://icchandbook.ikea.com/kb/SitePages/DisplayPopUpPage.aspx?KBID=121&IsDlg=1
	
		.LINK
			https://icchandbook.ikea.com/kb/SitePages/DisplayPopUpPage.aspx?KBID=120&IsDlg=1
	
	#>
	
	param (
		[string]$Alias,
		[switch]$Mandatory
	)
	
	$AliasValueData = (Get-RegValueData -RegKey "HKLM:\SOFTWARE\IKEA\IDEM\Config\Aliases" -ValueName $Alias -Silent)
	
	if ($AliasValueData -like "*To be specified*" -or !$AliasValueData) {# unspecified
		if ($Mandatory){
			Add-Log "ERROR:   Alias $Alias is missing but are set as Mandatory!" -Level 1
		}# end Mandatory check
		else {
			Add-Log "Alias $Alias not specified. Will default to empty value." -Level 1
		}
		return $null
	}# end if
	else {
		return $AliasValueData
	}

# end function Get-LocalAlias
}



function Get-Memory
	{
	<#
		.SYNOPSIS
			Get memory usage.
	
		.DESCRIPTION
			Get memory usage of the system.
	
		.PARAMETER  Detailed
			Get a more detailed output.
	
		.PARAMETER  Format
			Outputs result as human readable.
	
		.EXAMPLE
			Get-Memory
	
		.EXAMPLE
			Get-Memory -Detailed -Format
	
		.INPUTS
			System.String
	
		.OUTPUTS
			System.String
	
		.NOTES
			Displays various aspects of system memory usage.
	
		.LINK
			https://msdn.microsoft.com/en-us/library/windows/desktop/ms684879%28v=vs.85%29.aspx
	
		.LINK
			https://support.microsoft.com/en-us/kb/2160852
	
	#>
	
	[CmdletBinding()]
	param (
		[switch]$Detailed,
		[switch]$Format
	)

$signature = @'
/*
* Item: Windows PSAPI GetPerformanceInfo C# Wrapper
* Source: http://www.antoniob.com/windows-psapi-getperformanceinfo-csharp-wrapper.html
* Author: Antonio Bakula
*/
using System;
using System.Runtime.InteropServices;
	
public struct PerfomanceInfoData
{
	public Int64 CommitTotalPages;
	public Int64 CommitLimitPages;
	public Int64 CommitPeakPages;
	public Int64 PhysicalTotalBytes;
	public Int64 PhysicalAvailableBytes;
	public Int64 SystemCacheBytes;
	public Int64 KernelTotalBytes;
	public Int64 KernelPagedBytes;
	public Int64 KernelNonPagedBytes;
	public Int64 PageSizeBytes;
	public int HandlesCount;
	public int ProcessCount;
	public int ThreadCount;
}
	
public static class PsApiWrapper
{
	[DllImport("psapi.dll", SetLastError = true)]
	[return: MarshalAs(UnmanagedType.Bool)]
	private static extern bool
	GetPerformanceInfo([Out] out PsApiPerformanceInformation PerformanceInformation,
	[In] int Size);
	
	[StructLayout(LayoutKind.Sequential)]
	public struct PsApiPerformanceInformation
	{
		public int Size;
		public IntPtr CommitTotal;
		public IntPtr CommitLimit;
		public IntPtr CommitPeak;
		public IntPtr PhysicalTotal;
		public IntPtr PhysicalAvailable;
		public IntPtr SystemCache;
		public IntPtr KernelTotal;
		public IntPtr KernelPaged;
		public IntPtr KernelNonPaged;
		public IntPtr PageSize;
		public int HandlesCount;
		public int ProcessCount;
		public int ThreadCount;
	}
	
	public static PerfomanceInfoData GetPerformanceInfo()
	{
		PerfomanceInfoData data = new PerfomanceInfoData();
		PsApiPerformanceInformation perfInfo = new PsApiPerformanceInformation();
		if (GetPerformanceInfo(out perfInfo, Marshal.SizeOf(perfInfo)))
		{
			Int64 pageSize = perfInfo.PageSize.ToInt64();
			// data in bytes data.CommitTotalPages = perfInfo.CommitTotal.ToInt64() * pageSize;
			data.CommitLimitPages = perfInfo.CommitLimit.ToInt64() * pageSize;
			data.CommitPeakPages = perfInfo.CommitPeak.ToInt64() * pageSize;
			data.PhysicalTotalBytes = perfInfo.PhysicalTotal.ToInt64() * pageSize;
			data.PhysicalAvailableBytes = perfInfo.PhysicalAvailable.ToInt64() * pageSize;
			data.KernelPagedBytes = perfInfo.KernelPaged.ToInt64() * pageSize;
			data.KernelNonPagedBytes = perfInfo.KernelNonPaged.ToInt64() * pageSize;
		}
		return data;
	}
}
'@
	
	function Format-HumanReadable
	{
		param ($size)
		switch ($size)
		{
			{$_ -ge 1PB}{"{0:#.#'P'}" -f ($size / 1PB); break}
			{$_ -ge 1TB}{"{0:#.#'T'}" -f ($size / 1TB); break}
			{$_ -ge 1GB}{"{0:#.#'G'}" -f ($size / 1GB); break}
			{$_ -ge 1MB}{"{0:#.#'M'}" -f ($size / 1MB); break}
			{$_ -ge 1KB}{"{0:#'K'}" -f ($size / 1KB); break}
			default {"{0}" -f ($size) + "B"}
		}
	}
	
	# Create PerformanceInfoData object
	Add-Type -TypeDefinition $signature
	[PerfomanceInfoData]$w32perf =
	[PsApiWrapper]::GetPerformanceInfo()
	
	if ($Detailed)
	{
		try
		{
			# Create Win32_PerfRawData_PerfOS_Memory object
			$query = 'SELECT * FROM Win32_PerfRawData_PerfOS_Memory'
			$wmimem = gwmi -Query $query -ErrorAction Stop
			
			# Create "detailed" PS memory object
			# Value in bytes for memory attributes
			$memd = New-Object -TypeName PSObject -Property @{
				TotalPhysicalMem=$w32perf.PhysicalTotalBytes
				AvailPhysicalMem=$w32perf.PhysicalAvailableBytes
				CacheWorkingSet=[long]$wmimem.CacheBytes
				KernelWorkingSet=[long]$wmimem.SystemCodeResidentBytes
				DriverWorkingSet=[long]$wmimem.SystemDriverResidentBytes
				CommitCurrent=$w32perf.CommitTotalPages
				CommitLimit=$w32perf.CommitLimitPages
				CommitPeak=$w32perf.CommitPeakPages
				PagedWorkingSet=[long]$wmimem.PoolPagedResidentBytes
				PagedVirtual=$w32perf.KernelPagedBytes
				Nonpaged=$w32perf.KernelNonPagedBytes
				Computer=$env:COMPUTERNAME
			}
		}
		catch
		{
			$msg = ("Error: {0}" -f $_.Exception.Message)
			Write-Warning $msg
		}
		
		if ($Format)
		{
			# Format output in human-readable form
			# End of PS pipeline/format right rule option
			echo '-------------'
			echo 'Commit Charge'
			echo '-------------'
			"Current : $(Format-HumanReadable $memd.CommitCurrent)"
			"Limit`t : $(Format-HumanReadable $memd.CommitLimit)"
			"Peak`t : $(Format-HumanReadable $memd.CommitPeak)"
			"Peak/Limit : $("{0:P2}" `
			-f ($memd.CommitPeak / $memd.CommitLimit))"
			"Curr/Limit : $("{0:P2}" `
			-f ($memd.CommitCurrent / $memd.CommitLimit))"
			[Environment]::NewLine
			
			echo '---------------'
			echo 'Physical Memory'
			echo '---------------'
			"Total`t : $(Format-HumanReadable $memd.TotalPhysicalMem)"
			"Available : $(Format-HumanReadable $memd.AvailPhysicalMem)"
			"CacheWS`t : $(Format-HumanReadable $memd.CacheWorkingSet)"
			"KernelWS : $(Format-HumanReadable $memd.KernelWorkingSet)"
			"DriverWS : $(Format-HumanReadable $memd.DriverWorkingSet)"
			[Environment]::NewLine 
			
			echo '-------------'
			echo 'Kernel Memory'
			echo '-------------'
			"PagedWS : $(Format-HumanReadable $memd.PagedWorkingSet)"
			"PagedVirt : $(Format-HumanReadable $memd.PagedVirtual)"
			"Nonpaged : $(Format-HumanReadable $memd.Nonpaged)"
			[Environment]::NewLin
		}
		else
		{
			$memd.PSObject.TypeNames.Insert(0,'BinaryNature.MemoryDetailed')
			echo $memd
		}
	}
	else
	{
		# Create custom "core" memory object
		# Value in bytes for memory attributes
		$memb = New-Object -TypeName PSObject -Property @{
			TotalPhysicalMem=$w32perf.PhysicalTotalBytes
			AvailPhysicalMem=$w32perf.PhysicalAvailableBytes
			Computer=$env:COMPUTERNAME
		}
		
		if ($Format)
		{
			$memb | select @{n="Name";
			e={$_.Computer}},
			@{n="Total";
			e={Format-HumanReadable $_.TotalPhysicalMem}},
			@{n="InUse";
			e={Format-HumanReadable ($_.TotalPhysicalMem - `
			$_.AvailPhysicalMem)}},
			@{n="Avail";
			e={Format-HumanReadable $_.AvailPhysicalMem}},
			@{n="Use%";
			e={[int]((($_.TotalPhysicalMem - `
			$_.AvailPhysicalMem) / $_.TotalPhysicalMem) * 100)}}
		}
		else
		{
			$memb.PSObject.TypeNames.Insert(0,'BinaryNature.Memory')
			echo $memb
		}
	}

# end function Get-Memory
}



function Get-RDPsession
	{
	<#
		.SYNOPSIS
			Get RDP or Citrix sessions.
	
		.DESCRIPTION
			Get the active RDP or Citrix sessions of a Windows host.
	
		.PARAMETER  Session
			Name of session, user or Id.
	
		.PARAMETER  Computer
			Computer to be queried.
	
		.PARAMETER  Protocol
			What remote protocol to look for (RDP or ICA). If omitted allt types will be returned.
	
		.PARAMETER  Mode
			Displays current comunication line setting.
	
		.PARAMETER  Flow
			Displays current communication flow control setting.
	
		.PARAMETER  Connect
			Displays current communication connect setting.
	
		.PARAMETER  Counter
			Displays session counter information.
	
		.EXAMPLE
			Get-RDPsession -Computer retse268-nt1010 -Protocol ICA |ft

			SessionName         UserName            ID                  State               Type                Device
			-----------         --------            --                  -----               ----                ------
			ica-tcp#1           l-ptag-u-retse268   2                   Active              wdica
			ica-tcp#3           cakin4              4                   Active              wdica
			ica-tcp#5           alsjo2              6                   Active              wdica
			ica-tcp#6           jaank               7                   Active              wdica
			ica-tcp#2           sojoh9              8                   Active              wdica
			ica-tcp#0           nitir1              9                   Active              wdica
			ica-tcp#4           emts                10                  Active              wdica
			ica-tcp#7           johsv               11                  Active              wdica
			ica-tcp#8           katy                13                  Active              wdica
			ica-tcp#9           emher5              14                  Active              wdica
	
		.EXAMPLE
			Get-RDPsession -Computer retse012-nt4000 |ft

			SessionName         UserName            ID                  State               Type                Device
			-----------         --------            --                  -----               ----                ------
			rdp-tcp#1           suaic2              1                   Active              rdpwd
	
		.INPUTS
			System.String
	
		.OUTPUTS
			System.Object.Array
	
		.NOTES
			This cmdlet wraps the command qwinsta (query session) and sends the corresponing 
			parameters to it. The result is returned as a PoSH array object.
	
		.LINK
			https://technet.microsoft.com/en-us/library/cc785434.aspx
	
		.LINK
			https://technet.microsoft.com/en-us/library/cc755399%28v=ws.10%29.aspx
	
	#>
	
	param (	
		[string]$Session, # sessionname, username or sessionid
		[string]$Computer, # server to be quiried. - Generates error.
	
		[ValidateSet("rdp","ica")]
		[string]$Protocol, # remote session protocol to query
	
		[string]$Mode, # Display Line setting. - Formating wrong.
		[string]$Flow, # Display flow setting. - Formating wrong.
		[string]$Connect, # Display connect setting. - Formating wrong.
		[string]$Counter # Display TS counter information. - Formating wrong.
	)
	
	if ($Computer) {$Computer = "/Server:$Computer"}
	if ($Mode) {$Mode = "/Mode"}
	if ($Flow) {$Flow = "/Flow"}
	if ($Connect) {$Connect = "/Connect"}
	if ($Counter) {$Counter = "/Counter"}
	
	$Properties = 'SessionName','UserName','ID', 
				  'State','Type','Device' 
	$qwinstaEntries = qwinsta $Session $Computer $Mode $Flow $Connect $Counter | Select-String -Pattern "$Protocol-tcp#"
	
	foreach($SessionPropertyLine in $qwinstaEntries) 
		{
	    ($SessionName, $UserName, $ID, $State, $Type, $Device) = $SessionPropertyLine.line.split(" ",[System.StringSplitOptions]::RemoveEmptyEntries) 
			
		New-Object PSObject -Property @{ 
            SessionName = $SessionName
			UserName = $UserName
			ID = $ID
			State = $State
			Type = $Type
			Device = $Device 
        } | select -Property $Properties
    }# end for-each 

# end Get-RDPsession
}



function Get-NetworkStatistics
	{
	<#
	.Synopsis
		Wrappes NetStat in PoSH.
	
	.DESCRIPTION
		Wrappes netstat in PoSH and provides filtering options.
	
	.PARAMETER  ProcessName
		Filter result based on ProcessName.
	
	.PARAMETER  Adress
		Filter result based on IP Address.
	
	.PARAMETER  Port
		Filter result based on TCP/UDP Port number.
	
	.PARAMETER  ProcessId
		Filter result based on ProcessId.
	
	.PARAMETER  State
		Filter result based on network TCP session state.
	
	.Example
		Get-NetworkStatistics skype | ft -AutoSize
	
	.Example	
		Get-NetworkStatistics -ProcessName system
	
	.Example	
		Get-NetworkStatistics -Address 192.168.1.1
	
	.Example	
		Get-NetworkStatistics -Port 80
	
	.EXAMPLE
		Get-NetworkStatistics -Port 21 -State ESTABLISHED
	
	.NOTE
		PowerShellized netstat. Building on Shay Levy's work
			Shay Levy's Blog => http://blogs.microsoft.co.il/blogs/scriptfanatic/
	
		Filtering on State was added by Dennis Lindqvist
	
		TODO: Filter on local vs remote
	
	.LINK
		http://blogs.microsoft.co.il/blogs/scriptfanatic/
	
	.LINK
		https://technet.microsoft.com/en-us/library/bb490947.aspx
	
	#>
	
	param (	
		[string]$ProcessName, 
		[net.ipaddress]$Address, 
		[int]$Port = -1,
		[int]$ProcessId = -1,
		[ValidateSet("LISTENING","ESTABLISHED","CLOSE_WAIT")]
		[string]$State = "-1"
	)
	
	function Split-AddressPort
		{
		<#
		.Synopsis
			Splits an ipaddress string from 'netstat' into its respective address/port parts.
		.Example
			PS> Split-AddressPort [fe80::4442:f854:4707:3c0f%15]:1900
			fe80::4442:f854:4707:3c0f%15
			1900
		#>
		
		param (
			[string]$IPaddressAsString
		)
		
		$IPaddress = $IPaddressAsString -as [ipaddress]
		
		if ($IPaddress.AddressFamily -eq 'InterNetworkV6') 
	    	{ 
	       $retvalAddress = $IPaddress.IPAddressToString 
	       $retvalPort = $IPaddressAsString.split('\]:')[-1] 
	    } 
	    else 
	    	{ 
	        $retvalAddress = $IPaddressAsString.split(':')[0] 
	        $retvalPort = $IPaddressAsString.split(':')[-1] 
	    }  
		
		return @($retvalAddress, $retvalPort);
	} # end Split-AddressPort
	
	
	$properties = 'Protocol','LocalAddress','LocalPort', 
				  'RemoteAddress','RemotePort','State','ProcessName','PID' 
	$netstatEntries = netstat -ano | Select-String -Pattern '\s+(TCP|UDP)'
	
	foreach($_ in $netstatEntries) 
		{
	    $item = $_.line.split(" ",[System.StringSplitOptions]::RemoveEmptyEntries) 

		if($item[1] -notmatch '^\[::') 
        	{            
			($localAddress, $localPort) = Split-AddressPort($item[1])			
			($remoteAddress, $remotePort) = Split-AddressPort($item[2])
			$netProcessName = (gps -Id $item[-1] -ErrorAction SilentlyContinue).Name
						
			# apply ProcessName filter
			if(![string]::IsNullOrEmpty($ProcessName) -and 
				[string]::Compare($ProcessName, $netProcessName, $true) -ne 0) 
				{
				continue
			}
			
			# apply Port filter
			if($Port -ne -1 -and $localPort -ne $Port -and $remotePort -ne $Port) 
				{
				continue
			}
			
			# apply Address filter
			if($Address -ne $null -and $localAddress -ne $Address -and $remoteAddress -ne $Address) 
				{
				continue
			}
			
			# apply State filter
			$netState = $item[3]
			if($State -ne -1 -and $State -ne $netState)
				{
				continue
			}
			
			# apply PID filter
			$netPID = $item[-1]
			if($ProcessId -ne -1 -and $ProcessId -ne $netPID) 
				{
				continue
			}
			
			New-Object PSObject -Property @{ 
                PID = $netPID 
                ProcessName = $netProcessName 
                Protocol = $item[0] 
                LocalAddress = $localAddress 
                LocalPort = $localPort 
                RemoteAddress = $remoteAddress 
                RemotePort = $remotePort 
                State = if($item[0] -eq 'tcp') {$item[3]} else {$null} 
            } | select -Property $properties
			
        }# end if item 
    }# end for-each 

# end Get-NetworkStatistics
}



function Parse-Commandline 
	{ 
	<#
	.SYNOPSIS
		Parses the command line of a package executable
	.DESCRIPTION
		Parses the command line of a package executable.
	.PARAMETER  Commandline
		The command line of the package executable as a dictionary
	.EXAMPLE
		$argument = Parse-Commandline -Commandline $Commandline
		if ($argument.ContainsKey["key"]) {}
	.INPUTS
		System.String as '"-arg" "value"' etc
	.OUTPUTS
		Hashtable of parameters
	.NOTES
	Todo: Can't return value as System.Collections.Specialized.StringDictionary?
	#>

#	[OutputType([System.Collections.Specialized.StringDictionary])]
	param (
		[string]$CommandLine
	)

	[Array]$CommandArr = $CommandLine.split('"') # split up the string in an array of substrings
	$CommandArr += "-","" # Pad the array with an empty param to handle $index + 2 (end of param)

#	$Argument = New-Object System.Collections.Specialized.StringDictionary
	$Argument = @{}

	$switch = "-"

	for ($index = 1; $index -lt ($CommandArr.Count -2); $index = $index +2)
	{
		#Detect stand alone arg
		if ($CommandArr[$index][0] -eq $switch -and $CommandArr[$index +2][0] -eq $switch)
			{
			Add-Log ("Parsing:   " + $CommandArr[$index]) -Level 5
			$Argument[$CommandArr[$index]] = ""
			continue # with next arg
		} # end if
		
		# Detect arg + value
		if ($CommandArr[$index][0] -eq $switch -and $CommandArr[$index +2][0] -ne $switch)
			{
			Add-Log ("Parsing:   " + $CommandArr[$index] + " " + $CommandArr[$index +2]) -Level 5
			$Argument[$CommandArr[$index]] = $CommandArr[$index +2]
			$index = $index +2
			continue # with next arg
		} # end if
		
		#Detect stand alone values
		if ($CommandArr[$index][0] -ne $switch)
			{
			Add-Log ("ERROR: " + $CommandArr[$index] + "value is missing a corresponding switch!") -Level 5
			continue # with next arg
		} # end if
		
		# Catch rest of cases
		Add-Log ('ERROR: $CommandLine:' + $CommandLine) -Level 5
		Add-Log ("ERROR: contains unparsed parameters.") -Level 5

	} # end traverse array
	
	return $Argument

# end function Parse-Commandline
}



function New-LockFile
	{
	<#
		.SYNOPSIS
			Crates a new lock file.
	
		.DESCRIPTION
			Creates a lock file in a folder.
	
		.PARAMETER  FilePath
			Folder path to create a lock file in.
	
		.EXAMPLE
			New-LockFile -FilePath c:\IKEAlogs
	
		.INPUTS
			System.String
	
		.OUTPUTS
			System.IO.File
	
		.NOTES
			Used to create a file that can only be removed when the lock is removed.
	
		.LINK
			https://msdn.microsoft.com/en-us/library/d3wke8tz%28v=vs.110%29.aspx
	
	#>
	
	param (
		[string]$FilePath
	)
	
	$FilePath = $FilePath.TrimEnd("\") # we don't need any ending "\"
	
	# Create Lock File
	$LockFile = "$FilePath\.lock"
	Add-Log "Lock file parameter is $LockFile" -Level 5
	
	if (!(Test-Path $FilePath))
		{
		Add-Log "ERROR:   File path $FilePath doesn't exist." -Level 1
		Add-Log "ERROR:   Aborting function." -Level 1
		Return -1
	}
	
	ni $LockFile -Type 'File'
	
	$LockFileHandle = [System.IO.File]::Open($LockFile,'Open','Read','Read')
	
	Return $LockFileHandle

# end function New-LockFile
}



function Remove-LockFile # NOT FINISHED. DON'T USE
	{
	<#
		.SYNOPSIS
			Remove lock file.
	
		.DESCRIPTION
			Removes a lock file from a folder.
	
		.PARAMETER  FilePath
			Folder path to remove lock file from.
	
		.EXAMPLE
			Remove-LockFile -FilePath c:\IKEAlogs
	
		.INPUTS
			System.String
	
		.OUTPUTS
			None
	
		.NOTES
			Removes a lock file created with New-LockFile
	
		.LINK
			https://msdn.microsoft.com/en-us/library/d3wke8tz%28v=vs.110%29.aspx
	
	#>
	
	Param (
		[String]$FilePath
	)
	
	$FilePath = $FilePath.TrimEnd("\") # we don't need any ending "\"
	
	$LockFile = "$FilePath\.lock"
	Add-Log "Lock file parameter is $LockFile" -Level 5
	
	if (!(Test-Path $LockFile))
		{
		Add-Log "ERROR:   File lock $LockFile doesn't exist." -Level 1
		Add-Log "ERROR:   Aborting function." -Level 1
		Return -1
	}
	
	$LockFileHandle = [System.IO.File]::Open($LockFile,'Open','Read','ReadWrite')
	$LockFileHandle.Close()
	
	del $LockFile -Force -ErrorAction 'SilentlyContinue'
	
	if (Test-Path $LockFile)
		{
		Add-Log "ERROR:   Lock file couldn't be removed" -Level 1
		Add-Log "ERROR:   Aborting execution" -Level 1
		Return -1
	}
	Return 0

# end function Remove-LockFile
}



function Close-Lockfile #NOT FINISHED. DON'T USE
	{
	<#
		.SYNOPSIS
			Close lock file.
	
		.DESCRIPTION
			Closes and removes a lock file from a folder.
	
		.PARAMETER  FilePath
			Folder path to close and remove lock file from.
	
		.EXAMPLE
			Close-LockFile -FilePath c:\IKEAlogs
	
		.INPUTS
			System.IO.File
	
		.OUTPUTS
			None
	
		.NOTES
			Additional information about the function go here.
	
		.LINK
			https://msdn.microsoft.com/en-us/library/d3wke8tz%28v=vs.110%29.aspx
	
	#>
	
	Param (
		$FileHandle
	)
	
#	$FilePath = $FilePath.TrimEnd("\") # we don't need any ending "\"
#	
#	$LockFile = "$FilePath\lock"
#	Add-Log "Lock file parameter is $LockFile" -Level 5
#	
#	if (!(Test-Path $LockFile))
#		{
#		Add-Log "ERROR:   File lock $LockFile doesn't exist." -Level 1
#		Add-Log "ERROR:   Aborting function." -Level 1
#		Return -1
#	}
#	
#	$LockFileHandle = [System.IO.File]::Open($LockFile,'Open','Read','ReadWrite')
	$FileHandle.Close()
	
	del $LockFile -Force -ErrorAction 'SilentlyContinue'
	
	if (Test-Path $LockFile)
		{
		Add-Log "ERROR:   Lock file couldn't be removed" -Level 1
		Add-Log "ERROR:   Aborting execution" -Level 1
		Return -1
	}
	Return 0

# end function Close-Lockfile
}



function Get-Hostname
	{
	<#
		.SYNOPSIS
			Get name of host.
	
		.DESCRIPTION
			Get name of host from IP address.
	
		.PARAMETER  IpAddress
			IP address to resolve to host name.
	
		.PARAMETER  FQDN
			Specifies to return host name as Fully Qualified Domain Name.
	
		.EXAMPLE
			Get-Hostname -IpAddress 10.59.230.163
	
			ITSEELM-LX4607
	
		.EXAMPLE
			Get-Hostname -IpAddress 10.59.230.163 -FQDN

			ITSEELM-LX4607.ikea.com
	
		.INPUTS
			System.Net.IPAddress,System.Boolean
	
		.OUTPUTS
			System.String
	
		.NOTES
			Wrappes nslookup to do a reverse name lookup of an IP address.
	
		.LINK
			https://technet.microsoft.com/en-us/library/cc730980.aspx
	
		.LINK
			https://technet.microsoft.com/en-us/library/bb490721.aspx
	
	#>
	
	Param (
		[ipaddress]$IpAddress,
		[switch]$FQDN
	)

	# [ValidateScript({$_ -match "^([01]?\d\d?|2[0-4]\d|25[0-5])\.([01]?\d\d?|2[0-4]\d|25[0-5])\.([01]?\d\d?|2[0-4]\d|25[0-5])\.([01]?\d\d?|2[0-4]\d|25[0-5])$"})]
	#$HostName = [System.Net.Dns]::GetHostEntry($session.Computer).HostName #[System.Net.Dns] is buggy!
	
	$nslookup = (&nslookup $IpAddress)
	$nslookup = $nslookup[3..99]
	
	if ($nslookup.Count -ne 0)
		{
		$ResolvedName = ($nslookup|where {$_ -match "^Name:"}).Split(":")[1].Trim()
		Add-Log "$IPaddress resolved to $ResolvedName" -Level 5
		if (!($FQDN)) {$ResolvedName = $ResolvedName.Split(".")[0]} # Keep only SQDN of FQDN
				
		Return $ResolvedName
	}
	else
		{
		Add-Log "ERROR:   $IPaddress couldn't be resolved." -Level 1
		Return $False}

# end function Get-Hostname
}



function Get-IPv4Address
	{
	<#
		.SYNOPSIS
			Get IP Address of host.
	
		.DESCRIPTION
			Get IP v4 Address of host from host name.
	
		.PARAMETER  Hostname
			Host name to resolve to IP address.
	
		.EXAMPLE
			Get-IPv4Address -Hostname retse268-nt4010

			10.107.195.13
	
		.INPUTS
			System.String
	
		.OUTPUTS
			System.Net.IPAddress
	
		.NOTES
			Wrappes nslookup to do a host name lookup of IP address.
	
		.LINK
			https://technet.microsoft.com/en-us/library/cc730980.aspx
	
		.LINK
			https://technet.microsoft.com/en-us/library/bb490721.aspx
	
	#>
	
	Param (
		[Parameter(Mandatory=$true)]
		[String]$Hostname
	)
	
	#$HostName = [System.Net.Dns]::GetHostEntry($session.Computer).HostName #[System.Net.Dns] is buggy!
	
	$nslookup = (&nslookup $Hostname)
	$nslookup = $nslookup[3..99]
	
	if ($nslookup.Count -ne 0)
		{
		$ResolvedAddress = ($nslookup|where {$_ -match "^Address:"}).Split(":")[1].Trim()
		Add-Log "$HostName resolved to $ResolvedAddress" -Level 5
						
		Return [ipaddress]$ResolvedAddress
	}
	else
		{
		Add-Log "ERROR:   $HostName couldn't be resolved." -Level 1
		Return $False}

# end function Get-IPv4Address
}



function Set-DACL{
	<#
		.SYNOPSIS
			Set the DACL of a file obejct.
	
		.DESCRIPTION
			Adds a SAMid (user/group) to a file obejct with certain access rigyht.
	
		.PARAMETER  Path
			Path to file.
	
		.PARAMETER  AccesType
			Type of access to set (Allow/Deny).

		.PARAMETER  Inehritance
			If and how the access right should be inherited.
	
		.PARAMETER  Propagation
			If and how the access type should be propogated.
	
		.PARAMETER  SAMid
			Name of user or group to set access to.
	
		.PARAMETER  AccessRight
			What access right to assign the user/group at the object.
	
		.EXAMPLE
			Set-DACL -Path "C:\Users\Public\Videos\Sample Videos\Wildlife.wmv" -AccessType Deny -SAMid Everone -AccessRights Read
	
		.EXAMPLE
			Get-Something 'One value' 32
	
		.INPUTS
			System.String,System.Int32
	
		.OUTPUTS
			System.String
	
		.NOTES
			Useful to prevent execution of a binary until a later time.
			If permissions doesn't allow for setting a new DACL, then function will try take ownership.
	
		.LINK
			about_functions_advanced
	
		.LINK
			about_comment_based_help
	
	#>
	
	
	Param (
		[Parameter(Mandatory=$true)]
		[string]$Path	# File path (i.e "c:\myfile.txt")
		,
		[Parameter(Mandatory=$true)]
		[ValidateSet("Allow","Deny")]
		[System.Security.AccessControl.AccessControlType]$AccessType = "Allow"
		,
		[ValidateSet("ContainerInherit","ObjectInherit","None")]
		$Inhertitence = "None" # only for folders
		,
		[ValidateSet("InheritOnly","NoPropagateInherit","None")]
		[string]$Propagation = "None" # only for folders
		,
		[Parameter(Mandatory=$true)]
		[string]$SAMid	# SAM ID name of group or user (i.e. "Domain Users")
		,
		[Parameter(Mandatory=$true)]
		[ValidateSet("AppendData","ChangePermissions","CreateDirectories","CreateFiles","Delete",
		"DeleteSubdirectoriesAndFiles","ExecuteFile","FullControl","ListDirectory","Modify",
		"Read","ReadAndExecute","ReadAttributes","ReadData","ReadExtendedAttributes",
		"ReadPermissions","Synchronize","TakeOwnership","Traverse","Write","WriteAttributes",
		"WriteData","WriteExtendedAttributes")]
		[System.Security.AccessControl.FileSystemRights]$AccessRights
	)
	
	if (!(Test-Path $Path))
		{
		Add-Log ("WARNING!   " + $Path + " doesn't exist.") -Level 2
		Add-Log "WARNING!    Cant process ACL. Aborting!" -Level 1
		Return
	}
	
	$objUser = New-Object System.Security.Principal.NTAccount($SAMid)
	$objACE = New-Object System.Security.AccessControl.FileSystemAccessRule `
    	($objUser, $AccessRights, $Inhertitence, $Propagation, $AccessType)
	
	# $objACL = Get-Acl $Path # will include ownership as well, can't be used
	$objACL = (Get-Item $Path).GetAccessControl('Access')
	
	if (!$objACL) {# no permission to read ownership, then take ownership
		Add-Log "WARNING!   Can't access file ACL of $path" -Level 1
		Add-Log "Trying to set Ownership to BUILTIN\Administrators using current credentials." -Level 3
		Set-Owner -Path $Path -SAMid "BUILTIN\Administrators"
		$objACL = (Get-Item $Path).GetAccessControl('Access')
	}
	
	$objACL.AddAccessRule($objACE)
	Set-Acl $Path $objACL

# end function Set-DACL
}



function Remove-DACL{
	<#
		.SYNOPSIS
			Removes DACL for user/group.
	
		.DESCRIPTION
			Removes the DACL for a user/group of a file object.
	
		.PARAMETER  Path
			Path to file.
	
		.PARAMETER  SAMid
			SAM ID of user or group.
	
		.EXAMPLE
			Remove-DACL -Path -SAMid
	
		.EXAMPLE
			Get-Something 'One value' 32
	
		.INPUTS
			System.String,System.Int32
	
		.OUTPUTS
			System.String
	
		.NOTES
			Additional information about the function go here.
	
		.LINK
			about_functions_advanced
	
		.LINK
			about_comment_based_help
	
	#>
	
	Param (
		[Parameter(Mandatory=$true)]
		[string]$Path	# File path (i.e "c:\myfile.txt")
		,
		[Parameter(Mandatory=$true)]
		[string]$SAMid	# SAM ID name of group or user (i.e. "Domain Users")
	)
	
	if (!(Test-Path $Path))
		{
		Add-Log ("WARNING!    " + $Path + " doesn't exist.") -Level 2
		Add-Log "WARNING!    Cant remove ACL. Aborting!" -Level 1
		Return
	}
	
	# $objACL = Get-Acl $Path #this includes ownership :/
	$objACL = (gi $Path).GetAccessControl('Access')
	
		if (!$objACL) {# no permission to read ownership, then take ownership
		Add-Log "WARNING!   Can't access file ACL of $path" -Level 1
		Add-Log "Trying to set Ownership to BUILTIN\Administrators using current credentials." -Level 3
		Set-Owner -Path $Path -SAMid "BUILTIN\Administrators"
		$objACL = (gi $Path).GetAccessControl('Access')
	}
	
	$objUser = New-Object System.Security.Principal.NTAccount($SAMid)
	$objACE = New-Object System.Security.AccessControl.FileSystemAccessRule `
    	($objUser, "Read", "None", "None", "Allow")
		
	$objACL.RemoveAccessRuleAll($objACE)
	Set-Acl $Path $objACL
	
	$objACE = New-Object System.Security.AccessControl.FileSystemAccessRule `
    	($objUser, "Read", "None", "None", "Deny")
	
	$objACL.RemoveAccessRuleAll($objACE)
	Set-Acl $Path $objACL

# end function Remove-DACL
}



function Set-Owner.BAD
	{
	param (
		[Parameter(Mandatory=$true)]
		[string]$Path	# File path (i.e "c:\myfile.txt")
		,
		[Parameter(Mandatory=$true)]
		[string]$SAMid	# SAM ID name of group or user (i.e. "Domain Users")
	)
	
	$objUser = New-Object System.Security.Principal.NTAccount($SAMid)
	$objSecurity = New-Object System.Security.AccessControl.FileSecurity
	
	$objSecurity.SetOwner($objUser)
	
	[System.IO.File]::SetAccessControl($Path, $objSecurity)

# end function Set-Owner
}



Function Set-Owner 
	{
    <#
        .SYNOPSIS
            Changes owner of a file or folder to another user or group.

        .DESCRIPTION
            Changes owner of a file or folder to another user or group.

        .PARAMETER Path
            The folder or file that will have the owner changed.

        .PARAMETER Account
            Optional parameter to change owner of a file or folder to specified account.

            Default value is 'Builtin\Administrators'

        .PARAMETER Recurse
            Recursively set ownership on subfolders and files beneath given folder.

        .NOTES
            Name: Set-Owner
            Author: Boe Prox
            Version History:
                 1.0 - Boe Prox
                    - Initial Version

        .EXAMPLE
            Set-Owner -Path C:\temp\test.txt

            Description
            -----------
            Changes the owner of test.txt to Builtin\Administrators

        .EXAMPLE
            Set-Owner -Path C:\temp\test.txt -Account 'Domain\bprox

            Description
            -----------
            Changes the owner of test.txt to Domain\bprox

        .EXAMPLE
            Set-Owner -Path C:\temp -Recurse 

            Description
            -----------
            Changes the owner of all files and folders under C:\Temp to Builtin\Administrators

        .EXAMPLE
            Get-ChildItem C:\Temp | Set-Owner -Recurse -Account 'Domain\bprox'

            Description
            -----------
            Changes the owner of all files and folders under C:\Temp to Domain\bprox
    #>
    [cmdletbinding(
        SupportsShouldProcess = $True
    )]
    Param (
        [parameter(ValueFromPipeline=$True,ValueFromPipelineByPropertyName=$True)]
        [Alias('FullName')]
        [string[]]$Path,
        [parameter()]
        [string]$SAMid = 'Builtin\Administrators',
        [parameter()]
        [switch]$Recurse
    )
    Begin {
        #Prevent Confirmation on each Write-Debug command when using -Debug
        If ($PSBoundParameters['Debug']) {
            $DebugPreference = 'Continue'
        }
        Try {
            [void][TokenAdjuster]
        } Catch {
            $AdjustTokenPrivileges = @"
            using System;
            using System.Runtime.InteropServices;

             public class TokenAdjuster
             {
              [DllImport("advapi32.dll", ExactSpelling = true, SetLastError = true)]
              internal static extern bool AdjustTokenPrivileges(IntPtr htok, bool disall,
              ref TokPriv1Luid newst, int len, IntPtr prev, IntPtr relen);
              [DllImport("kernel32.dll", ExactSpelling = true)]
              internal static extern IntPtr GetCurrentProcess();
              [DllImport("advapi32.dll", ExactSpelling = true, SetLastError = true)]
              internal static extern bool OpenProcessToken(IntPtr h, int acc, ref IntPtr
              phtok);
              [DllImport("advapi32.dll", SetLastError = true)]
              internal static extern bool LookupPrivilegeValue(string host, string name,
              ref long pluid);
              [StructLayout(LayoutKind.Sequential, Pack = 1)]
              internal struct TokPriv1Luid
              {
               public int Count;
               public long Luid;
               public int Attr;
              }
              internal const int SE_PRIVILEGE_DISABLED = 0x00000000;
              internal const int SE_PRIVILEGE_ENABLED = 0x00000002;
              internal const int TOKEN_QUERY = 0x00000008;
              internal const int TOKEN_ADJUST_PRIVILEGES = 0x00000020;
              public static bool AddPrivilege(string privilege)
              {
               try
               {
                bool retVal;
                TokPriv1Luid tp;
                IntPtr hproc = GetCurrentProcess();
                IntPtr htok = IntPtr.Zero;
                retVal = OpenProcessToken(hproc, TOKEN_ADJUST_PRIVILEGES | TOKEN_QUERY, ref htok);
                tp.Count = 1;
                tp.Luid = 0;
                tp.Attr = SE_PRIVILEGE_ENABLED;
                retVal = LookupPrivilegeValue(null, privilege, ref tp.Luid);
                retVal = AdjustTokenPrivileges(htok, false, ref tp, 0, IntPtr.Zero, IntPtr.Zero);
                return retVal;
               }
               catch (Exception ex)
               {
                throw ex;
               }
              }
              public static bool RemovePrivilege(string privilege)
              {
               try
               {
                bool retVal;
                TokPriv1Luid tp;
                IntPtr hproc = GetCurrentProcess();
                IntPtr htok = IntPtr.Zero;
                retVal = OpenProcessToken(hproc, TOKEN_ADJUST_PRIVILEGES | TOKEN_QUERY, ref htok);
                tp.Count = 1;
                tp.Luid = 0;
                tp.Attr = SE_PRIVILEGE_DISABLED;
                retVal = LookupPrivilegeValue(null, privilege, ref tp.Luid);
                retVal = AdjustTokenPrivileges(htok, false, ref tp, 0, IntPtr.Zero, IntPtr.Zero);
                return retVal;
               }
               catch (Exception ex)
               {
                throw ex;
               }
              }
             }
"@
            Add-Type $AdjustTokenPrivileges
        }

        #Activate necessary admin privileges to make changes without NTFS perms
        [void][TokenAdjuster]::AddPrivilege("SeRestorePrivilege") #Necessary to set Owner Permissions
        [void][TokenAdjuster]::AddPrivilege("SeBackupPrivilege") #Necessary to bypass Traverse Checking
        [void][TokenAdjuster]::AddPrivilege("SeTakeOwnershipPrivilege") #Necessary to override FilePermissions
    }
    Process {
        ForEach ($Item in $Path) {
            Write-Verbose "FullName: $Item"
            #The ACL objects do not like being used more than once, so re-create them on the Process block
            $DirOwner = New-Object System.Security.AccessControl.DirectorySecurity
            $DirOwner.SetOwner([System.Security.Principal.NTAccount]$SAMid)
            $FileOwner = New-Object System.Security.AccessControl.FileSecurity
            $FileOwner.SetOwner([System.Security.Principal.NTAccount]$SAMid)
            $DirAdminAcl = New-Object System.Security.AccessControl.DirectorySecurity
            $FileAdminAcl = New-Object System.Security.AccessControl.DirectorySecurity
            $AdminACL = New-Object System.Security.AccessControl.FileSystemAccessRule('Builtin\Administrators','FullControl','ContainerInherit,ObjectInherit','InheritOnly','Allow')
            $FileAdminAcl.AddAccessRule($AdminACL)
            $DirAdminAcl.AddAccessRule($AdminACL)
            Try {
                $Item = gi -LiteralPath $Item -Force -ErrorAction Stop
                If (-NOT $Item.PSIsContainer) {
                    If ($PSCmdlet.ShouldProcess($Item, 'Set File Owner')) {
                        Try {
                            $Item.SetAccessControl($FileOwner)
                        } Catch {
                            Write-Warning "Couldn't take ownership of $($Item.FullName)! Taking FullControl of $($Item.Directory.FullName)"
                            $Item.Directory.SetAccessControl($FileAdminAcl)
                            $Item.SetAccessControl($FileOwner)
                        }
                    }
                } Else {
                    If ($PSCmdlet.ShouldProcess($Item, 'Set Directory Owner')) {                        
                        Try {
                            $Item.SetAccessControl($DirOwner)
                        } Catch {
                            Write-Warning "Couldn't take ownership of $($Item.FullName)! Taking FullControl of $($Item.Parent.FullName)"
                            $Item.Parent.SetAccessControl($DirAdminAcl) 
                            $Item.SetAccessControl($DirOwner)
                        }
                    }
                    If ($Recurse) {
                        [void]$PSBoundParameters.Remove('Path')
                        dir $Item -Force | Set-Owner @PSBoundParameters
                    }
                }
            } Catch {
                Write-Warning "$($Item): $($_.Exception.Message)"
            }
        }
    }
    End {  
		#Remove priviledges that had been granted
		[void][TokenAdjuster]::RemovePrivilege("SeRestorePrivilege") 
		[void][TokenAdjuster]::RemovePrivilege("SeBackupPrivilege") 
		[void][TokenAdjuster]::RemovePrivilege("SeTakeOwnershipPrivilege")     
	}

# end function Set-Owner
}



function Set-WindowPosition {
	<#
		.SYNOPSIS
			Sets Window position and size.
	
		.DESCRIPTION
			Sets Windows postion and size.
	
		.PARAMETER  ProcessName
			Name of process having a window to be handled.
	
		.PARAMETER  WindowHandle
			Integer pointer to Window to be handled.
	
		.PARAMETER xpos
			New X position of window.
	
		.PARAMETER ypos
			New Y position of window.
	
		.PARAMETER width
			New width of window.
	
		.PARAMETER height
			New height of window.
	
		.EXAMPLE
			Set-WindowPosition -ProcessName notepad -xpos 10 -ypos 10 -width 250 -height 100
	
		.EXAMPLE
			Get-Something 'One value' 32
	
		.INPUTS
			System.String,System.Int32,System.IntPtr
	
		.OUTPUTS
			None
	
		.NOTES
			Using negative coordinates will have the window restored by Windows when connecting remotly.
	
		.LINK
			https://gallery.technet.microsoft.com/scriptcenter/Demo-of-calling-C-and-6ef0cd2b
	
		.LINK
			https://msdn.microsoft.com/en-us/library/windows/desktop/ms633534%28v=vs.85%29.aspx
	
	#>
	
	param (
		[string]$ProcessName,
		
		[intptr]$WindowHandle,
		
		[Parameter(Mandatory=$true)]
		[int]$xpos,
		
		[Parameter(Mandatory=$true)]
		[int]$ypos,
		
		[Parameter(Mandatory=$true)]
		[int]$width,
		
		[Parameter(Mandatory=$true)]
		[int]$height
	)
	
	# Add static methods to this PowerShell session
	Add-Type @"
using System;
using System.Runtime.InteropServices;
public class Win32 {
[DllImport("user32.dll")]
[return: MarshalAs(UnmanagedType.Bool)]
public static extern bool MoveWindow(IntPtr hWnd, int X, int Y, int nWidth, int nHeight, bool bRepaint);
}
"@
	
	if ($ProcessName) {
		$ProcessObject = (gps $ProcessName -ErrorAction 'SilentlyContinue')
	}
	
	foreach ($Process in $ProcessObject) { # will step through once even if empty
		$Handle = $Process.MainWindowHandle
		
		if ($Handle) {
			$WindowHandle = $Handle
		}
		
		if (!$WindowHandle) {
			Return
		}
		
		[win32]::MoveWindow($WindowHandle, $xpos, $ypos, $width, $height, $true)
		Add-Log "Placed Window $WindowHandle at TopLeft X: $xpos, TopLeft Y: $ypos using Width: $width, Height: $height" -Level 5
		
	}# end foreach

# end function Set-WindowPosition
}



function Set-WindowState {
	<#
		.SYNOPSIS
			Sets the state of a Window.
	
		.DESCRIPTION
			Set the state such as hidden, maximzed, etc. of a Window.
	
		.PARAMETER  WindowCaption
			The caption (name) of a Window to be manipulated.
	
		.PARAMETER  ProcessObject
			The process object having a Window to be manipulated.
	
		.PARAMETER  WindowAction
			The new desired state of the Window.
	
		.EXAMPLE
			Set-WindowState -WindowCaption "Untitled - Notepad" -WindowAction "Minimize"
	
		.EXAMPLE
			et-WindowState -WindowCaption "Untitled - Notepad" -WindowAction "Normalize"
	
		.EXAMPLE
			$Handle Set-WindowState -ProcessObject (Get-Porcess Notepad) -WindowAction "Hide"
	
		.EXAMPLE
			Set-WindowState -ProcessObject $Handle -WindowAction "Normalize"
	
		.INPUTS
			System.String,System.ComponentModel.Process
	
		.OUTPUTS
			System.Array, System.ComponentModel.Process
	
		.NOTES
			Additional information about the function go here.
	
		.LINK
			https://gallery.technet.microsoft.com/scriptcenter/Demo-of-calling-C-and-6ef0cd2b
	
		.LINK
			https://msdn.microsoft.com/en-us/library/windows/desktop/ms633548%28v=vs.85%29.aspx
	
	#>
	
	param (
		[string]$WindowCaption,
		$ProcessObject,
		[ValidateSet("hide","normalize","minimize","maximize","restore","recent","show","show_na","minimize_na","minimize_nx","default","force_min")]
		[string]$WindowAction
	)
	
	switch ($WindowAction)
		{
		"hide"		{$action = 0} 	# $SW_HIDE = 0				Hides the window and activates another window.
		"normalize"	{$action = 1} 	# $SW_SHOWNORMAL = 1		Activates and displays a window
		"minimize" 	{$action = 2} 	# $SW_SHOWMINIMIZED = 2		Activates the window and displays it as a minimized window.
		"maximize" 	{$action = 3} 	# $SW_SHOWMAXIMIZED = 3		Activates the window and displays it as a maximized window.
		"recent" 	{$action = 4} 	# $SW_SHOWNOACTIVATE = 4	Displays a window in its most recent size and position.
		"show" 		{$action = 5}	# SW_SHOW = 5				Activates the window and displays it in its current size and position. 
		"minimize_nx" {$action = 6}	# SW_MINIMIZE = 6			Minimizes the specified window and activates the next top-level window in the Z order
		"minimize_na" {$action = 7}	# SW_SHOWMINNOACTIVE = 7	Displays the window as a minimized window.
		"show_na"	{$action = 8}	# SW_SHOWNA = 8				Displays the window in its current size and position.
		"restore"	{$action = 9}	# SW_RESTORE = 9			Activates and displays the window to its original size and position. 
		"default"	{$action = 10}	# $SW_SHOWDEFAULT = 10		Sets the show state based on the SW_ value specified in the STARTUPINFO structure.
		"force_min"	{$action = 11}	# $SW_FORCEMINIMIZE = 11	Minimizes a window, even if the thread that owns the window is not responding.
	}

	# C# signature for ShowWindowAsync
	$csharpsign = @"
[DllImport("user32.dll")]
public static extern bool ShowWindowAsync(IntPtr hWnd, int nCmdShow);
"@
	
	# Add static methods to this PowerShell session
	$showWindowAsync = Add-Type -MemberDefinition $csharpsign -Name "Win32ShowWindowAsync" -Namespace Win32Functions -PassThru

	if (!$ProcessObject)
		{
		$ProcessObject = (gps | where {$_.mainwindowtitle -eq $WindowCaption -and $_.Name -ne 'dwm'})
	}
	
	foreach ($Object in $ProcessObject) {
		$showWindowAsync::ShowWindowAsync($Object.MainWindowHandle, $action)
	}
	
	return $ProcessObject # to make normalize possible

# end function Set-WindowState
}



function Set-Pointer {
	<#
		.SYNOPSIS
			Sets the pointer scheme.
	
		.DESCRIPTION
			Set the pointer the one of a named scheme or uses a custom scheme.
	
		.PARAMETER  SchemeName
			Name of scheme to use or Custom.
	
		.PARAMETER  SchemeData
			Array with all paramters needed for a Custom Scheme.
	
		.EXAMPLE
			Set-Pointer -SchemeName "WindowsAero"
	
		.INPUTS
			System.String,System.Hastable
	
		.OUTPUTS
			None
	
		.NOTES
			The scheme is implemented using C# code to avoid requering a reboot.
			The call doesn't affect the cursor shadow however.
	
		.LINK
			https://gallery.technet.microsoft.com/scriptcenter/Demo-of-calling-C-and-6ef0cd2b
	
	#>
	
	param (
	[validateSet("WindowsAero","WindowsBlack","Blank","Dot","Custom")]
	[string]$SchemeName,
	
	[hashtable]$SchemeData = @{"Arrow"="";"Help"="";"Hand"="";"AppStarting"="";"Wait"="";"NWPen"="";
		"No"="";"SizeNS"="";"SizeWE"="";"SizeNWSE"="";"SizeNESW"="";"SizeAll"="";"UpArrow"="";
		"Crosshair"="";"IBeam"="";"Scheme Source"=1}
	)
		
	# Set up variables
	[hashtable]$WindowsAero = @{
		"AppStarting"="aero_working.ani";
		"Arrow"="aero_arrow.cur";
		"Crosshair"="";
		"Hand"="aero_link.cur";
		"Help"="aero_helpsel.cur";
		"IBeam"="";
		"No"="aero_unavail.cur";
		"NWPen"="aero_pen.cur";
		"Scheme Source"=2;
		"SizeAll"="aero_move.cur";
		"SizeNWSE"="aero_nesw.cur";
		"SizeNS"="aero_ns.cur";
		"SizeNESW"="aero_nwse.cur";
		"SizeWE"="aero_ew.cur";
		"UpArrow"="aero_up.cur";
		"Wait"="aero_busy.ani"
	}
	
	[hashtable]$WindowsBlack = @{
		"AppStarting"="wait_r.cur";
		"Arrow"="arrow_r.cur";
		"Crosshair"="cross_r.cur";
		"Hand"="";
		"Help"="help_r.cur";
		"IBeam"="beam_r.cur";
		"No"="no_r.cur";
		"NWPen"="pen_r.cur";
		"Scheme Source"=2;
		"SizeAll"="move_r.cur";
		"SizeNWSE"="size1_r.cur";
		"SizeNS"="size4_r.cur";
		"SizeNESW"="size2_r.cur";
		"SizeWE"="size3_r.cur";
		"UpArrow"="up_r.cur";
		"Wait"="busy_r.cur"
	}
	
	[hashtable]$Blank = @{
		"AppStarting"="BLANK.cur";
		"Arrow"="BLANK.cur";
		"Crosshair"="BLANK.cur";
		"Hand"="BLANK.cur";
		"Help"="BLANK.cur";
		"IBeam"="BLANK.cur";
		"No"="BLANK.cur";
		"NWPen"="BLANK.cur";
		"Scheme Source"=1;
		"SizeAll"="BLANK.cur";
		"SizeNWSE"="BLANK.cur";
		"SizeNS"="BLANK.cur";
		"SizeNESW"="BLANK.cur";
		"SizeWE"="BLANK.cur";
		"UpArrow"="BLANK.cur";
		"Wait"="BLANK.cur"
	}
	
	[hashtable]$Dot = @{
		"AppStarting"="cursor1.cur";
		"Arrow"="cursor1.cur";
		"Crosshair"="cursor1.cur";
		"Hand"="cursor1.cur";
		"Help"="cursor1.cur";
		"IBeam"="cursor1.cur";
		"No"="cursor1.cur";
		"NWPen"="cursor1.cur";
		"Scheme Source"=1;
		"SizeAll"="cursor1.cur";
		"SizeNWSE"="cursor1.cur";
		"SizeNS"="cursor1.cur";
		"SizeNESW"="cursor1.cur";
		"SizeWE"="cursor1.cur";
		"UpArrow"="cursor1.cur";
		"Wait"="cursor1.cur"
	}
	
	[hashtable]$SchemeTable = @{
		"WindowsAero" = $WindowsAero;
		"WindowsBlack" = $WindowsBlack;
		"Blank" = $Blank;
		"Dot" = $Dot
	}
	
	if ($SchemeName -ne "Custom"){# use a predifned cursor scheme
		$SchemeData = $SchemeTable[$SchemeName]
		Add-Log "The cursor scheme $SchemeName was selected" -Level 4
	}
		
	# Apply the hash to the registry
	Remove-RegKey -RegKey "HKCU:Control Panel\Cursors" -Force
	
	Set-RegValueData -RegKey "HKCU:Control Panel\Cursors" -ValueData $SchemeName
	Add-Log "Setting cursor scheme to $SchemeName" -Level 1
	
	foreach ($key in $SchemeData.Keys) {
		Set-RegValueData -RegKey "HKCU:Control Panel\Cursors" -ValueName $key `
			-ValueData ("%SystemRoot%\cursors\" + $SchemeData.Item($key)) -Type 'ExpandString' -VerySilent
		if ($key -like "Scheme Source"){# don't use path
			Set-RegValueData -RegKey "HKCU:Control Panel\Cursors" -ValueName $key `
				-ValueData ($SchemeData.Item($key)) -Type 'DWord' -VerySilent
		}# end if
	}
	
	# Following settings won't apply until next reboot
	$PrefMaskArr = Get-RegValueData -RegKey "HKCU:\Control Panel\Desktop" -ValueName "UserPreferencesMask" -VerySilent
	$PrefMaskArr[1] = 0x1e # Hide Arrow Shaddow
	Set-RegValueData -RegKey "HKCU:\Control Panel\Desktop" `
		-ValueName "UserPreferencesMask" -ValueData $PrefMaskArr -Type 'Binary' -VerySilent
	Set-RegValueData -RegKey "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes" `
		-ValueName "ThemeChangesMousePointers" -ValueData 0 -Type 'DWord' -VerySilent
	
	# Apply the registry settings
	$CSharpSig = @'
[DllImport("user32.dll", EntryPoint = "SystemParametersInfo")]
public static extern bool SystemParametersInfo(
                 uint uiAction,
                 uint uiParam,
                 uint pvParam,
                 uint fWinIni);
'@
	
	$CursorRefresh = Add-Type -MemberDefinition $CSharpSig -Name WinAPICall -Namespace SystemParamInfo –PassThru
	
	$CursorRefresh::SystemParametersInfo(0x0057,0,$null,0)

# end function Set-Pointer
}



function Get-UserSessionName {
	<#
		.SYNOPSIS
			Gets the user session name.
	
		.DESCRIPTION
			Gets the session name of the user like when querying QWINSTA or QUERY SESSION to differntiate
			if logged on to a computer on the console or via an RDP sessiion.
	
		.EXAMPLE
			Get-UserSessionName
			
			On a console, this will return CONOSLE
			In a RDP session, this will return the RDP session name.
	
		.INPUTS
			None
	
		.OUTPUTS
			System.String
	
		.NOTES
			This will only work with the currently logged on user.
	
		.LINK
			https://technet.microsoft.com/en-us/library/cc785434.aspx
	
	#>
	
	[string]$SessionNumber = (gi "HKCU:\Volatile Environment").GetSubkeyNames()
	[string]$SessionName = Get-RegValueData -RegKey ("HKCU:\Volatile Environment\$SessionNumber") -ValueName "SessionName" -VerySilent
	
	return $SessionName

# end function Get-UserSessionName
}



function Get-ExecutionTime {
	<#
		.SYNOPSIS
			Get time since StopWatch was started.
	
		.DESCRIPTION
			Returns the time since a StopWatch object was started. Either in seconds or days, hours, seconds.
	
		.PARAMETER  -StopWatchObj
			A currently running stop watch object.
	
		.EXAMPLE
			$StopWatch = [System.Diagnostics.StopWatch]::StartNew()
			Get-ExecutionTime -StopWatchObj $StopWatch
	
		.INPUTS
			System.Diagnostics.StopWatch
	
		.OUTPUTS
			System.String
	
		.NOTES
			Only works if a StopWatch object has been created first.
	
		.LINK
			https://msdn.microsoft.com/en-us/library/system.diagnostics.stopwatch%28v=vs.90%29.aspx
	
	#>
	
	param (
	[System.Diagnostics.StopWatch]$StopWatch
	)
	
	if (!$StopWatch){
		return "ERROR!   Stop Watch missing. Execution time couldn't be calculated"
	}
	
	if ($StopWatch.Elapsed.TotalSeconds -gt 3600)
		{
		return ("Execution time: " + $StopWatch.Elapsed.Days + " days, "`
		+ $StopWatch.Elapsed.Hours + " hours, "`
		+ $StopWatch.Elapsed.Minutes + " minutes, "`
		+ $StopWatch.Elapsed.Seconds + " seconds.")
	}
	else
		{
		return ("Execution time: " + $StopWatch.Elapsed.TotalSeconds + " seconds.")
	}

# end function Get-ExecutionTime
}



function Test-UniqueProcess {
	<#
		.SYNOPSIS
			Check if current process is unique.
	
		.DESCRIPTION
			Check if current powerhsell process name is unique.
			Returns $True if unique.
	
		.EXAMPLE
			Test-UniqueProcess
	
		.INPUTS
			None
	
		.OUTPUTS
			System.Boolean, Null
	
		.NOTES
	
		.LINK
	
	#>
	
	$MyExecutable = (gps -Id $Pid).Name
	
	# Check if more instances of this wrapped code is running
	if (!($MyExecutable -like "powershell")) 
		{
		$instances = gps $MyExecutable
		if ($instances.Count -gt 1) # count doesn't register single instances in PoSH v2
			{
			return $false
		}# end if running
		else
			{return $true}
	}# end if powershell

# end function Test-UniqueProcess
}



function Set-ShadowPolicy {
	<#
		.SYNOPSIS
			Set Shadow Policy
	
		.DESCRIPTION
			Sets the RDP policy to ensure that Shadow.exe can be used without user intervention.
	
		.EXAMPLE
			Set-ShadowPolicy
	
		.INPUTS
			None
	
		.OUTPUTS
			None
	
		.NOTES
			Shadow.exe only works when first being in a RDP session.
	
		.LINK
			https://technet.microsoft.com/en-us/library/cc772355.aspx
	
	#>
	

	$ShadowPol = Get-RegValueData -RegKey "HKLM:SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" -ValueName "Shadow" -VerySilent
	if (!$ShadowPol){
		Set-RegValueData -RegKey "HKLM:SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" -ValueName "Shadow" -ValueData 2 -Type 'DWord' -VerySilent
		Add-Log "Local RDP Shadowing Group Policy enabled. Will take effect during next reboot." -Level 1
	}
	
	$RemoteRPC = Get-RegValueData -RegKey  "HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server" -ValueName "AllowRemoteRPC" -VerySilent
	if (!$RemoteRPC){
		Set-RegValueData -RegKey "HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server" -ValueName "AllowRemoteRPC" -ValueData 1 -Type 'DWord' -VerySilent
		Add-Log "Potential RemoteRPC with shadowing issue fixed" -Level 4 
	}

# end function Set-RdpPolicy
}



function Get-OrderedDictionaryFromString {
	<#
		.SYNOPSIS
			Creates an Ordered Dictionery.
	
		.DESCRIPTION
			Creates an Ordered Dictionary from a string or here-string.
	
		.PARAMETER  String
			A string containing the paired values to be converted to a ordered dictionary.
			"Person1 = Adam; Person2 = Dave".
	
		.EXAMPLE
			$MyOrderedList = Set-OrderedDictionary -String "Person1 = Adam; Person2 = Dave"
	
		.EXAMPLE
			
			$MyHereString = @"
			Person1 = Adam;
			Person2 = Dave
			"@
	
			$MyOrderedList = Set-OrderedDictionary -String $MyHereString
	
		.EXAMPLE
			
			$MyString = "
			Person1 = Adam;
			Person2 = Dave
			"
	
			$MyOrderedList = Set-OrderedDictionary -String $MyString
	
		.INPUTS
			System.String
	
		.OUTPUTS
			System.Collections.Specialized.OrderedDictionary
	
		.NOTES
			Ordered Dictionaries are prefered to hash tables when the order in the table matters.
			However, Powershell v2 has no easy syntax to create ordered dictionaries as in
			Powershell v3.
	
		.LINK
			https://technet.microsoft.com/en-us/library/hh847780%28v=wps.620%29.aspx
	
	#>
	
	param(
		[string]$String
	)
	
	$String = $String.Replace("`r","") # remove carrige return
	$String = $String.Replace("`n","") # remove new line
	$String = $String.Replace(" ","") # remove empty space
	$String = $String.Replace("`t","") # remove tabs
	
	$Dictionary = New-Object System.Collections.Specialized.OrderedDictionary
	
	foreach ($line in ($String.Split(";"))){
		$Dictionary.add($line.split("=")[0],$line.split("=")[1])
	}
	
	return $Dictionary
	
# end function Get-OrderedDictionaryFromString
}



function Get-DN {
	<#
		.SYNOPSIS
			Get distinguished name.
	
		.DESCRIPTION
			Gets the distinguished name of an Active Directory object.
	
		.PARAMETER  cnName
			The name of the object to look up.
	
		.PARAMETER  cnCategory
			The objectCategory of the object to look up.
	
		.EXAMPLE
			Get-DN -cnName "dtpset11" -cnCategory "computer"
	
		.EXAMPLE
			Get-Something 'One value' 32
	
		.INPUTS
			System.String
	
		.OUTPUTS
			System.String
	
		.NOTES
			If more than one object exists, only the forst found will be returned.
	
		.LINK
			http://social.technet.microsoft.com/wiki/contents/articles/5392.active-directory-ldap-syntax-filters.aspx
	
		.LINK
			https://technet.microsoft.com/en-us/library/ff730967.aspx
	
	#>
	
	param(
		[parameter(Mandatory=$true)]
		[string]$cnName,
		[parameter(Mandatory=$true)]
		[ValidateSet("person","computer","user","contact","group","organizationalPerson")]
		[string]$cnCategory
	)
	
	$LdapFilter = "(&(objectCategory=$cnCategory)(cn=$cnName*))"
	return ([adsisearcher]$LdapFilter).FindOne().Properties.distinguishedname

# end function Get-DN
}



function Get-LastBootTime {
	<#
		.SYNOPSIS
			Gets the boot time.
	
		.DESCRIPTION
			Returns the last boot time.
	
		.EXAMPLE
			$BootTime = Get-LastBootTime
	
		.INPUTS
			None
	
		.OUTPUTS
			System.DateTime
	
	#>
	
	[Management.ManagementDateTimeConverter]::ToDateTime((gwmi win32_operatingsystem).LastBootUpTime)

# end function Get-LastBootTime
}



function Invoke-BootDelay {
	<#
		.SYNOPSIS
			Invokes a delay after boot.
	
		.DESCRIPTION
			Invokes a delay counting from the boot time. If the dealy time has already occured no
			delay will occur.
	
		.PARAMETER  Delay
			Time in seconds to wait after the boot has occured.
	
		.EXAMPLE
			Invoke-BootDelay -Delay 20
	
		.INPUTS
			System.Int32
	
		.OUTPUTS
			None
	
	#>
	
	param (
		[int]$Delay
	)
	$LastBootTime = Get-LastBootTime
	Add-Log "LastBootTime: $LastBootTime" -Level 5
	$DelayTime = $LastBootTime.AddSeconds($Delay)

	Add-Log "Execution will be dayled until $DelayTime if not already there." -Level 1
	
	while (((get-date) - $LastBootTime).totalseconds -le $Delay) {
		sleep 1
	}

# end function BootDelay
}



function Invoke-AliasUpdate {
	<#
		.SYNOPSIS
			Updates the local ICC aliases.
	
		.DESCRIPTION
			Updates the local registry with the lastes ICC aliases from the Logon server.
	
		.EXAMPLE
			Invoke-AliasUpdate
	
		.INPUTS
			None
	
		.OUTPUTS
			None
	
		.NOTES
			Must be run in administrator context.
	
	#>
	
	Add-Log "Invoking ICC alias update scripts." -Level 1
	
	. "C:\Program Files\IKEA\bin\AliasUpdateComputer.ps1"
	. 'C:\Program Files\ikea\bin\ICCScriptResource.ps1' "ComputerStartup"
	. 'C:\Program Files\ikea\bin\ICCScriptResource.ps1' "Logon"

# end function Invoke-AliasUpdate
}



function Invoke-AsAdmin {
	<#
		.SYNOPSIS
			Invokes a program as administrator.
	
		.DESCRIPTION
			Invokes or starts a program as administrator, launching UAC if necessary.
	
		.PARAMETER  Program
			The description of the ParameterA parameter.
	
		.PARAMETER  ArgumentString
			Argument for the progrsam to use.
	
		.PARAMETER  WaitForExit
			Have the function wait for the progeam to exit before continuing.
	
		.EXAMPLE
			Invoke-AsAdmin -Program cmd.exe 
	
		.EXAMPLE
			Invoke-AsAdmin -Program cscript -ArgumentString '"C:\Windows\System32\Printing_Admin_Scripts\en-US\prnmngr.vbs" -l'
	
		.INPUTS
			System.String,System.Switch
	
		.OUTPUTS
			None
	
		.NOTES
			Use for commands that can only bee run as administrator. Only works in interactive mode as user will prompted by UAC.
	
		.LINK
			https://msdn.microsoft.com/en-us/library/system.diagnostics.processstartinfo%28v=vs.90%29.aspx
	
	#>
	
    param ( 
		[string]$Program = $(throw "Please specify a program" ),
		[string]$ArgumentString = "",
		[switch]$WaitForExit 
	)
	
    $ProcessStartInfo = New-Object "Diagnostics.ProcessStartInfo"
	
    $ProcessStartInfo.FileName = $Program 
    $ProcessStartInfo.Arguments = $ArgumentString
    $ProcessStartInfo.Verb = "runas"
	
	Add-Log "Trying to launch as admin: $Program $ArgumentString" -Level 4
	
    $Process = [Diagnostics.Process]::Start($ProcessStartInfo)
    if ( $WaitForExit ) {
        $Process.WaitForExit();
    }

# end function Invoke-AsAdmin
}



function Get-ChildProcess {
	<#
		.SYNOPSIS
			Gets all child processes.
	
		.DESCRIPTION
			Gets all spawned child processes using the parent PID.
	
		.PARAMETER  ID
			The PID of the parent.
	
		.EXAMPLE
			Get-ChildProcess -ID 4428
	
		.EXAMPLE
			Get-ChildProcess -ID 4428 | Stop-Process -whatif
	
		.EXAMPLE
			Get-ChildProcess -ID (Get-Process wininit)[0].ID
	
		.INPUTS
			System.Int32
	
		.OUTPUTS
			System.Object
	
		.NOTES
			The function also finds the child-process of child-processes recursively.
	
		.LINK
			https://msdn.microsoft.com/en-us/library/aa394372%28v=vs.85%29.aspx
	
		.LINK
			about_comment_based_help
	
	#>
	
	param (
		[int]$ID = $PID
	) 
 
    $CustomColumnID = @{ 
        Name = 'Id' 
        Expression = { [Int[]]$_.ProcessID } 
    } 
 
    $result = gwmi -Class Win32_Process -Filter "ParentProcessID=$ID" | 
      select -Property ProcessName, $CustomColumnID, CommandLine 
 
    $result 
    $result |  
        ? { $_.ID -ne $null } |  
        % { 
        Get-ChildProcess -id $_.Id 
    }

# end function Get-ChildProcess
} 



function Get-FunctionDef
	{
	<#
		.SYNOPSIS
			Get defintion of function.
	
		.DESCRIPTION
			Get the definition af an advanced function.
	
		.PARAMETER  FunctionName
			Name of function.
	
		.EXAMPLE
			PS U:\> function Set-HelloWorld
			>> {
			>> # This will say hi to the World ;)
			>> param(
			>> $World
			>> )
			>>
			>> # Greeting the World
			>>
			>> write-host "Hello $World"
			>>
			>> }
	
			Get-FunctionDef -FunctionName Set-HelloWorld
	
			param(
			$World
			)
			write-host "Hello $World"
	
		.INPUTS
			System.String
	
		.OUTPUTS
			System.String
	
		.NOTES
			Get funtion as a @-string with all comments stripped out.
	
		.LINK
			about_functions_advanced
	
		.LINK
			about_comment_based_help
	
	#>
	
	param (
		[string]$FunctionName
	)
	
	$function_def = (get-item Function:$FunctionName).definition
	$function_def = ($function_def -split "#>")[-1]
	return $function_def -replace "#.*",""

# end function Get-FunctionDef
}



function Get-Base64String
	{
	<#
		.SYNOPSIS
			Get Base64 string.
	
		.DESCRIPTION
			Encodes an UniCode string into Base64.
	
		.PARAMETER  ConvertString
			UniCode string to convert.
	
		.EXAMPLE
			Get-Base64String kalle
			awBhAGwAbABlAA==
	
		.EXAMPLE
			$kalle = Get-Base64String {Write-Host "kalle"}
	
			$kalle
			VwByAGkAdABlAC0ASABvAHMAdAAgACIAawBhAGwAbABlACIA

			PowerShell.exe -EncodedCommand $kalle
			kalle
	
		.INPUTS
			System.String
	
		.OUTPUTS
			System.String
	
		.NOTES
			Converting a string into Base64 will ease passing complex syntaxes in Power Shell.
	
		.LINK
			https://msdn.microsoft.com/en-us/library/dhx0d524%28v=vs.90%29.aspx
	
		.LINK
			about_comment_based_help
	
	#>
	
	param (
		$ConvertString
	)
	
	$Bytes = [System.Text.Encoding]::Unicode.GetBytes($ConvertString)
	$EncodedString = [Convert]::ToBase64String($Bytes)
	
	return $EncodedString

# end function Get-Base64String
}



function Get-ScriptBlock
	{
	<#
		.SYNOPSIS
			Returns a script block to be used with job-start or start-process.
	
		.DESCRIPTION
			When starting a new PowerShell process, current functions and code are not available
			for the new process.
			Use this function to pass along functions and code needed as a variable to start-job
			or start-process PowerShell.
	
		.PARAMETER  FunctionName
			Name of functions to include in ScriptBlock
	
		.PARAMETER  ScriptBlock
			Block of script to be run when script block returned is used.
	
		.PARAMETER  Base64String
			Switch to retrun script block encoded as Base64String. Needed with start-process Powershell.
	
		.EXAMPLE
			Get-Something -ParameterA 'One value' -ParameterB 32
	
		.EXAMPLE
			Get-Something 'One value' 32
	
		.INPUTS
			System.String,System.Switch
	
		.OUTPUTS
			System.ScriptBlock,System.Base64String
	
		.NOTES
			Additional information about the function go here.
	
		.LINK
			about_functions_advanced
	
		.LINK
			about_comment_based_help
	
	#>
	
	param (
		[string[]]$FunctionName,
		[string]$ScriptBlock,	
		[switch]$Base64String
	)
	
	foreach ($Function in $FunctionName){
		$CodeBlock += "function $Function {" + (Get-FunctionDef -FunctionName $Function) + "}`n"
	}
	
	$CodeBlock += $ScriptBlock

	$CodeBlock = [scriptblock]::Create($CodeBlock)
	
	if ($Base64String){
		$CodeBlock = Get-Base64String -ConvertString $CodeBlock
	}

	return $CodeBlock

# end function Get-ScriptBlock
}



function New-Share.NOTDONE
	{<#
		.SYNOPSIS
			Creates a new file share.
	
		.DESCRIPTION
			Creates a new file share on local computer.
	
		.PARAMETER  FolderPath
			Path to folder to share.
	
		.PARAMETER  ShareName
			Name of share to create.
	
		.PARAMETER  SAMid
			Windows account name to assign share permissions.
	
		.PARAMETER  SharePermission
			Share permissions to assign the share.
	
		.PARAMETER  Description
			Description of share to create.
	
		.PARAMETER  MaxNumber
			Maximum number of share sessions to allow.
	
		.EXAMPLE
			New-Share -FolderPath "C:\IKEALogs\IFS" -ShareName "IFS" -Description "IFS Share"
	
		.EXAMPLE
			New-Share -FolderPath "C:\IKEALogs\IFS" -ShareName "IFS" -SAMid "Users" -SharePermission - Change -Description "IFS Share" -MaxNumber 10
	
		.INPUTS
			System.String
	
		.OUTPUTS
			System.String
	
		.NOTES
			In some cases the share will be setup but will break the admin tools when accessing the 
			share properties.
	
		.LINK
			https://msdn.microsoft.com/en-us/library/windows/desktop/aa389393%28v=vs.85%29.aspx
	
		.LINK
			https://technet.microsoft.com/en-us/library/bb490712.aspx
	
	#>
	
	param (
		[parameter(Mandatory = $true)]
		[string]$FolderPath,
	
		[parameter(Mandatory = $true)]
		[string]$ShareName,
	
		[string]$SAMid = "AUTHENTICATED USERS",
	
		[string]$SharePermission = "Read",
	
		[string]$Description = "",
	
		[string]$MaxNumber = $null
	)
	
	Remove-Share -ShareName $ShareName
	
	# Create new folder if necessary
	ni $FolderPath -Type Directory -ErrorAction 'SilentlyContinue' -ErrorVariable FolderError
	switch ($FolderError[0].CategoryInfo.Category) {
		"ObjectNotFound" {
			Add-Log "ERROR:   Couldn't create $FolderPath" -Level 1
			Return $FolderError
		}
		"ResourceExists" {
			Add-Log "WARNING:   Folder $FolderPath already exists" -Level 3
		}
		default {
			Add-Log "Created $FolderPath" -Level 4
		}
	}# end switch
	
	
	# Build Win32 security descriptor structure
	$wmiSD = ([WMIClass]"Win32_SecurityDescriptor").CreateInstance()
	$wmiACE = ([WMIClass]"Win32_ACE").CreateInstance()
	$wmiTrustee = ([WMIClass]"Win32_Trustee").CreateInstance()

	$wmiTrustee.Name = "EVERYONE"
	$wmiTrustee.Domain = $Null
	$wmiTrustee.SID = @(1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0)

	switch ($SharePermission) {
		"Full" {
			$wmiACE.AccessMask = 2032127
		}
		"Change" {
			$wmiACE.AccessMask = 1245631
		}
		"Read" {
			$wmiACE.AccessMask = 1179817
		}
		default {
			$wmiACE.AccessMask = 1179817
		}
	}

	$wmiACE.AceFlags = 3
	$wmiACE.AceType = 0
	$wmiACE.Trustee = $wmiTrustee

	$wmiSD.DACL += $wmiACE.psObject.baseobject 

	# Build wmiShare parameter structure
	$wmiShare = [WMIClass]"Win32_Share"

	$shareParam = $wmiShare.psbase.GetMethodParameters("Create")
	$shareParam.Access = $wmiSD
	$shareParam.Description = $Description
	$shareParam.MaximumAllowed = $MaxNumber
	$shareParam.Name = $ShareName
	$shareParam.Password = $Null
	$shareParam.Path = $FolderPath
	$shareParam.Type = [uint32]0
	
	# Create share
	$wmiShare.PSBase.InvokeMethod("Create", $shareParam, $Null)
	
	# Alternative syntax
	# $wmiShare.Create($FolderPath, $ShareName, 0, $false, $description, $null, $wmiSD)
	Add-Log "Folder $FolderPath shared as $ShareName" -Level 2

# end function New-Share
}



function Remove-Share
	{
	<#
		.SYNOPSIS
			Description of the function.
	
		.DESCRIPTION
			A detailed description of the function.
	
		.PARAMETER  ParameterA
			The description of the ParameterA parameter.
	
		.PARAMETER  ParameterB
			The description of the ParameterB parameter.
	
		.EXAMPLE
			Get-Something -ParameterA 'One value' -ParameterB 32
	
		.EXAMPLE
			Get-Something 'One value' 32
	
		.INPUTS
			System.String,System.Int32
	
		.OUTPUTS
			System.String
	
		.NOTES
			Additional information about the function go here.
	
		.LINK
			about_functions_advanced
	
		.LINK
			about_comment_based_help
	
	#>
	
	param (
		[string]$ShareName
	)
	if (Get-WmiObject Win32_Share -Filter "name = '$ShareName'")
		{
		Add-Log "Disabling ColdStart share." -Level 4
		(Get-WmiObject Win32_Share -Filter "name = '$ShareName'").Delete()
	}

# end function Remove-Share
}



function Get-WoW6432Env
	{
	<#
		.SYNOPSIS
			Returns WoW6432 setting for a server.
	
		.DESCRIPTION
			Returns WoW6432 setting based on the server queried beeing a 32- och 64-bit setup.
	
		.PARAMETER  Server
			Server to query for 32-bit or 64-bit OS.
	
		.EXAMPLE
			$WoW6432 = Get-WoW6432Env -Server RETSE012-NT4000
	
		.INPUTS
			System.String
	
		.OUTPUTS
			System.String
	
		.NOTES
			When remote accessing registry settings for a 32-bit program it's necessary to know if
			the system accessed is running a 32- or 64-bit OS due to 32-bit registry redirection (WoW6432).
	
			This is also affected by the querying application beeing 32- or 64-bit itself.
	
		.LINK
			https://msdn.microsoft.com/en-us/library/windows/desktop/aa384253%28v=vs.85%29.aspx
	
		.LINK
			https://msdn.microsoft.com/en-us/library/windows/desktop/ms724072%28v=vs.85%29.aspx
	
	#>
	
	param (
		[string]$Server
	)
	
	$ServerType = (Get-WmiObject win32_ComputerSystem -ComputerName $Server).SystemType
	
	if ([IntPtr]::size -eq 8 -and $ServerType -eq "x64-based PC") {# 8 bytes means executing on 64 bit
		$WoW6432Node = "\\WoW6432Node"
	}
	if ([IntPtr]::size -eq 4 -or $ServerType -eq "X86-based PC") {# 4 bytes means executing on 32 bit
		$WoW6432Node = $null
	}
	
	return $WoW6432Node

# end function Get-WoW6432Env
}



function Get-ComputerRegAlias
	{
	<#
		.SYNOPSIS
			Get ICC alias from remote ICC computer.
	
		.DESCRIPTION
			Get ICC alias from remote ICC computer registry.
	
		.PARAMETER  Computer
			Computer to query.
	
		.PARAMETER  Alias
			One ore more alias to fetch.
	
		.EXAMPLE
			Get-ComputerRegAlias -Computer RETSE012-NT4000 -Alias POS_Logging
	
		.EXAMPLE
			Get-ComputerRegAlias -Computer RETSE012-NT4000 -Alias POS_STP_
	
		.INPUTS
			System.String
	
		.OUTPUTS
			System.String
	
		.NOTES
			In some instances, the alias set in IMU is not applied to the ICC computer alias registry.
			This simplifies alias troubleshooting.
	
			The function might need administrative permissions on the target system.
	
		.LINK
			https://icchandbook.ikea.com/kb/SitePages/DisplayPopUpPage.aspx?KBID=120&IsDlg=1
	
		.LINK
			about_comment_based_help
	
	#>
	
	param (
		[string]$Computer,
		[array]$Alias
	)
	
	
	begin {
		Remove-Variable AliasCollection -ErrorAction 'SilentlyContinue'
		$AliasCollection = New-Object System.Collections.Specialized.OrderedDictionary # Create an empty ordered dictionary

		$RemoteRegistry = [Microsoft.Win32.RegistryKey]::OpenRemoteBaseKey("LocalMachine",$Computer)
		$SubKey = $RemoteRegistry.OpenSubKey("SOFTWARE\\IKEA\\IDEM\\Config\\Aliases")
		
		$Alias = $Alias | sort
	
	}# end begin
	
	
	process {
		foreach ($Name in $Alias) {
			$AliasCollection.Add($Name,$SubKey.GetValue($Name))
		}# end foreach
		
	}# end process
	
	
	end {
		return $AliasCollection
	}# end

# end function Get-ComputerRegAlias
}



function Get-DotNetVersion
	{
	<#
		.SYNOPSIS
			Get .Net version installed.
	
		.DESCRIPTION
			Get .Net version installed.
	
		.EXAMPLE
			Get-DotNetVersion
	
		.INPUTS
			None
	
		.OUTPUTS
			System.Array
	
		.NOTES
			Finds all version of .Net installed on the local computer.
	
		.LINK
			https://msdn.microsoft.com/en-us/library/bb822049%28v=vs.110%29.aspx
	
	#>
	
	Get-ChildItem 'HKLM:\SOFTWARE\Microsoft\NET Framework Setup\NDP' -recurse |
	Get-ItemProperty -name Version,Release -ErrorAction 'SilentlyContinue' |
	Where { $_.PSChildName -match '^(?!S)\p{L}'} |
	Select PSChildName, Version, Release

# end function Get-DotNetVersion
}



function Test-ProcessResponse
	{
	<#
		.SYNOPSIS
			Test if a process is in the state unresponsive.
	
		.DESCRIPTION
			Test if a process is in the state unresponsive on a computer.
	
		.PARAMETER  ProcessName
			The description of the ParameterB parameter.
	
		.PARAMETER  ProcessId
			ProcessID of process to query.
	
		.EXAMPLE
			Test-ProcessResponce
	
		.EXAMPLE
			Test-ProcessResponce -ComputerName RETSE268-IF0014
	
		.INPUTS
			System.String,System.Int32
	
		.OUTPUTS
			None
	
		.NOTES
			The property 'Responding' only works on local computers..
	
		.LINK
			https://technet.microsoft.com/en-us/library/hh849832%28v=wps.620%29.aspx
	
	#>
	
	Param (
		[string]$ProcessName,
		[int]$ProcessId
	)            

	try {
		$Processes = Get-Process -ErrorAction 'Stop'            
		$NoResponseProcesses = @($Processes | where { $_.Responding -eq $false })
	}
	catch {            
 		Write-Error (Get-Date -Format g).ToString() "   Failed to query processes. $_"
	}
	
	if($NoResponseProcesses) {
		foreach($NoResponseProcess in $NoResponseProcesses) {
			Write-Host (Get-Date -Format g).ToString()
			$NoResponseProcess | select Name, id, MainWindowTitle, Responding
		}            
	}# endif

# end function Test-ProcessResponse
}



function Set-KeyPress {
	<#
		.SYNOPSIS
			Press key.
	
		.DESCRIPTION
			Presses or releases a key on the keyboard.
	
		.PARAMETER  $Key
			Key to press, specified numericaly.
	
		.PARAMETER  $Scan
			Hardware scan code, always use default value of 0x45
	
		.PARAMETER $KeyUp
			Set switch to release key.
	
		.PARAMETER ExtraInfo
			Aditional value to add to each key stroke.
	
		.EXAMPLE
			Set-KeyPress -Key 0x12
	
			Press and hold left ALT key.
	
		.EXAMPLE
			Set-KeyPress -Key 0x12 -KeyUp
	
			Release left ALT key.
	
		.INPUTS
			System.Byte,System.Int64,System.Switch
	
		.OUTPUTS
			None
	
		.NOTES
			Be careful to always release the keys eventually that's been pressed.
	
		.LINK
			https://msdn.microsoft.com/en-us/library/windows/desktop/ms646304(v=vs.85).aspx
	
		.LINK
			https://msdn.microsoft.com/en-us/library/windows/desktop/dd375731(v=vs.85).aspx
	
	#>
	
	param (
		[Parameter(Mandatory=$true)]
		[Byte]$Key,
	
		[Byte]$Scan = 0x45,
	
		[Switch]$KeyUp,
		[Int64]$ExtraInfo = 0
	)
	
	Add-Type @"
using System;                                                                     
using System.Runtime.InteropServices;
public class User32 {
[DllImport("user32.dll")]                                                            
public static extern void keybd_event(byte bVk, byte bScan, uint dwFlags, int dwExtraInfo);}
"@   
	
	switch ($KeyUp) {
		$false {# Press key
			[User32]::keybd_event($Key, $Scan, 0x0, $ExtraInfo)
		}
		
		$true {# Release key
			[User32]::keybd_event($Key, $Scan, 0x2, $ExtraInfo)
		}
		
	}# end switch
	
# end function Set-KeyPress
}



function ConvertTo-YAML
{
<#
 .SYNOPSIS
   creates a YAML description of the data in the object
 .DESCRIPTION
   This produces YAML from any object you pass to it. It isn't suitable for the huge objects produced by some of the cmdlets such as Get-Process, but fine for simple objects
 .EXAMPLE
   $array=@()
   $array+=Get-Process wi* |  Select-Object Handles,NPM,PM,WS,VM,CPU,Id,ProcessName 
   ConvertTo-YAML $array

 .PARAMETER Object 
   the object that you want scripted out
 .PARAMETER Depth
   The depth that you want your object scripted to
 .PARAMETER Nesting Level
   internal use only. required for formatting
#>
	
	[CmdletBinding()]
	param (
		[parameter(Position = 0, Mandatory = $true, ValueFromPipeline = $true)][AllowNull()] $inputObject,
		[parameter(Position = 1, Mandatory = $false, ValueFromPipeline = $false)] [int] $depth = 16,
		[parameter(Position = 2, Mandatory = $false, ValueFromPipeline = $false)] [int] $NestingLevel = 0,
		[parameter(Position = 3, Mandatory = $false, ValueFromPipeline = $false)] [int] $XMLAsInnerXML = 0
	)
	
	BEGIN { }
	PROCESS
	{
		If ($inputObject -eq $Null) { $p += 'null'; return $p } # if it is null return null
		if ($NestingLevel -eq 0) { '---' }
		
		$padding = [string]'  ' * $NestingLevel # lets just create our left-padding for the block
		try
		{
			$Type = $inputObject.GetType().Name # we start by getting the object's type
			if ($Type -ieq 'Object[]') { $Type = "$($inputObject.GetType().BaseType.Name)" } #what it really is
			if ($depth -ilt $NestingLevel) { $Type = 'OutOfDepth' } #report the leaves in terms of object type
			elseif ($Type -ieq 'XmlDocument' -or $Type -ieq 'XmlElement')
			{
				if ($XMLAsInnerXML -ne 0) { $Type = 'InnerXML' }
				else
				{ $Type = 'XML' }
			} # convert to PS Alias
			# prevent these values being identified as an object
			if (@('boolean', 'byte', 'char', 'datetime', 'decimal', 'double', 'float', 'single', 'guid', 'int', 'int32',
			'int16', 'long', 'int64', 'OutOfDepth', 'RuntimeType', 'PSNoteProperty', 'regex', 'sbyte', 'string',
			'timespan', 'uint16', 'uint32', 'uint64', 'uri', 'version', 'void', 'xml', 'datatable', 'List`1',
			'SqlDataReader', 'datarow', 'ScriptBlock', 'type') -notcontains $type)
			{
				if ($Type -ieq 'OrderedDictionary') { $Type = 'HashTable' }
				elseif ($Type -ieq 'PSCustomObject') { $Type = 'PSObject' } #
				elseif ($inputObject -is "Array") { $Type = 'Array' } # whatever it thinks it is called
				elseif ($inputObject -is "HashTable") { $Type = 'HashTable' } # for our purposes it is a hashtable
				elseif (($inputObject | gm -membertype Properties |
				Select name | Where name -like 'Keys') -ne $null) { $Type = 'generic' } #use dot notation
				elseif (($inputObject | gm -membertype Properties | Select name).count -gt 1) { $Type = 'Object' }
			}
			write-verbose "$($padding)Type:='$Type', Object type:=$($inputObject.GetType().Name), BaseName:=$($inputObject.GetType().BaseType.Name) "
			
			switch ($Type)
			{
				'ScriptBlock'{ "{$($inputObject.ToString())}" }
				'InnerXML'        { "|`r`n" + ($inputObject.OuterXMl.Split("`r`n") | foreach{ "$padding$_`r`n" }) }
				'DateTime'   { $inputObject.ToString('s') } # s=SortableDateTimePattern (based on ISO 8601) using local time
				'Boolean' {
					"$(&{
						if ($inputObject -eq $true) { '`true' }
						Else { '`false' }
					})"
				}
				'string' {
					$String = "$inputObject"
					if ($string -match '[\r\n]' -or $string.Length -gt 80)
					{
						# right, we have to format it to YAML spec.
						">`r`n" # signal that we are going to use the readable 'newlines-folded' format
						$string.Split("`n") | foreach {
							$bits = @(); $length = $_.Length; $IndexIntoString = 0; $wrap = 80
							while ($length -gt $IndexIntoString + $Wrap)
							{
								$earliest = $_.Substring($IndexIntoString, $wrap).LastIndexOf(' ')
								$latest = $_.Substring($IndexIntoString + $wrap).IndexOf(' ')
								$BreakPoint = &{
									if ($earliest -gt ($wrap + $latest)) { $earliest }
									else { $wrap + $latest }
								}
								if ($earliest -lt (($BreakPoint * 10)/100)) { $BreakPoint = $wrap } # in case it is a string without spaces
								$padding + $_.Substring($IndexIntoString, $BreakPoint).Trim() + "`r`n"
								$IndexIntoString += $BreakPoint
							}
							if ($IndexIntoString -lt $length) { $padding + $_.Substring($IndexIntoString).Trim() + "`r`n" }
							else { "`r`n" }
						}
					}
					else { "'$($string -replace '''', '''''')'" }
				}
				'Char'     { "([int]$inputObject)" }
				{
					@('byte', 'decimal', 'double', 'float', 'single', 'int', 'int32', 'int16', `
					'long', 'int64', 'sbyte', 'uint16', 'uint32', 'uint64') -contains $_
				}
				{ "$inputObject" } # rendered as is without single quotes
				'PSNoteProperty' { "$(ConvertTo-YAML -inputObject $inputObject.Value -depth $depth -NestingLevel ($NestingLevel + 1))" }
				'Array'    { "$($inputObject | ForEach { "`r`n$padding- $(ConvertTo-YAML -inputObject $_ -depth $depth -NestingLevel ($NestingLevel + 1))" })" }
				'HashTable'{
					("$($inputObject.GetEnumerator() | ForEach {
						"`r`n$padding  $($_.Name): " +
						(ConvertTo-YAML -inputObject $_.Value -depth $depth -NestingLevel ($NestingLevel + 1))
					})")
				}
				'PSObject' { ("$($inputObject.PSObject.Properties | ForEach { "`r`n$padding $($_.Name): " + (ConvertTo-YAML -inputObject $_ -depth $depth -NestingLevel ($NestingLevel + 1)) })") }
				'generic'  { "$($inputObject.Keys | ForEach { "`r`n$padding  $($_):  $(ConvertTo-YAML -inputObject $inputObject.$_ -depth $depth -NestingLevel ($NestingLevel + 1))" })" }
				'Object'   { ("$($inputObject | Get-Member -membertype properties | Select-Object name | ForEach { "`r`n$padding $($_.name):   $(ConvertTo-YAML -inputObject $inputObject.$($_.name) -depth $NestingLevel -NestingLevel ($NestingLevel + 1))" })") }
				'XML'   { ("$($inputObject | Get-Member -membertype properties | where-object { @('xml', 'schema') -notcontains $_.name } | Select-Object name | ForEach { "`r`n$padding $($_.name):   $(ConvertTo-YAML -inputObject $inputObject.$($_.name) -depth $depth -NestingLevel ($NestingLevel + 1))" })") }
				'DataRow'   { ("$($inputObject | Get-Member -membertype properties | Select-Object name | ForEach { "`r`n$padding $($_.name):  $(ConvertTo-YAML -inputObject $inputObject.$($_.name) -depth $depth -NestingLevel ($NestingLevel + 1))" })") }
				#  'SqlDataReader'{$all = $inputObject.FieldCount; while ($inputObject.Read()) {for ($i = 0; $i -lt $all; $i++) {"`r`n$padding $($Reader.GetName($i)): $(ConvertTo-YAML -inputObject $($Reader.GetValue($i)) -depth $depth -NestingLevel ($NestingLevel+1))"}}
				default { "'$inputObject'" }
			}
		}
		catch
		{
			write-error "Error'$($_)' in script $($_.InvocationInfo.ScriptName) $($_.InvocationInfo.Line.Trim()) (line $($_.InvocationInfo.ScriptLineNumber)) char $($_.InvocationInfo.OffsetInLine) executing $($_.InvocationInfo.MyCommand) on $type object '$($inputObject)' Class: $($inputObject.GetType().Name) BaseClass: $($inputObject.GetType().BaseType.Name) "
		}
		finally { }
	}
	
	END { }
# end function ConvertTo-YAML
}



function ConvertTo-PSON
{
<#
 .SYNOPSIS
   creates a powershell object-notation script that generates the same object data
 .DESCRIPTION
   This produces 'PSON', the powerShell-equivalent of JSON from any object you pass to it. It isn't suitable for the huge objects produced by some of the cmdlets such as Get-Process, but fine for simple objects
 .EXAMPLE
   $array=@()
   $array+=Get-Process wi* |  Select-Object Handles,NPM,PM,WS,VM,CPU,Id,ProcessName 
   ConvertTo-PSON $array

 .PARAMETER Object 
   the object that you want scripted out
 .PARAMETER Depth
   The depth that you want your object scripted to
 .PARAMETER Nesting Level
   internal use only. required for formatting
#>
	
	[CmdletBinding()]
	param (
		[parameter(Position = 0, Mandatory = $true, ValueFromPipeline = $true)][AllowNull()] $inputObject,
		[parameter(Position = 1, Mandatory = $false, ValueFromPipeline = $false)] [int] $depth = 16,
		[parameter(Position = 2, Mandatory = $false, ValueFromPipeline = $false)] [int] $NestingLevel = 1,
		[parameter(Position = 3, Mandatory = $false, ValueFromPipeline = $false)] [int] $XMLAsInnerXML = 0
	)
	
	BEGIN { }
	PROCESS
	{
		If ($inputObject -eq $Null) { $p += '$Null'; return $p } # if it is null return null
		$padding = [string]'  ' * $NestingLevel # lets just create our left-padding for the block
        $ArrayEnd=0; #until proven false
		try
		{
			$Type = $inputObject.GetType().Name # we start by getting the object's type
			if ($Type -ieq 'Object[]') { $Type = "$($inputObject.GetType().BaseType.Name)" } # see what it really is
			if ($depth -ilt $NestingLevel) { $Type = 'OutOfDepth' } #report the leaves in terms of object type
			elseif ($Type -ieq 'XmlDocument' -or $Type -ieq 'XmlElement')
			{
				if ($XMLAsInnerXML -ne 0) { $Type = 'InnerXML' }
				else
				{ $Type = 'XML' }
			} # convert to PS Alias
				# prevent these values being identified as an object
			if (@('boolean', 'byte', 'char', 'datetime', 'decimal', 'double', 'float', 'single', 'guid', 'int', 'int32',
			'int16', 'long', 'int64', 'OutOfDepth', 'RuntimeType', 'PSNoteProperty', 'regex', 'sbyte', 'string',
			'timespan', 'uint16', 'uint32', 'uint64', 'uri', 'version', 'void', 'xml', 'datatable', 'List`1',
			'SqlDataReader', 'datarow', 'ScriptBlock', 'type') -notcontains $type)
			{
				if ($Type -ieq 'OrderedDictionary') { $Type = 'HashTable' }
				elseif ($Type -ieq 'PSCustomObject') { $Type = 'PSObject' } #
				elseif ($inputObject -is "Array") { $Type = 'Array' } # whatever it thinks it is called
				elseif ($inputObject -is "HashTable") { $Type = 'HashTable' } # for our purposes it is a hashtable
				elseif (($inputObject | gm -membertype Properties | Select name | Where name -like 'Keys') -ne $null) { $Type = 'generic' } #use dot notation
				elseif (($inputObject | gm -membertype Properties | Select name).count -gt 1) { $Type = 'Object' }
			}
			write-verbose "$($padding)Type:='$Type', Object type:=$($inputObject.GetType().Name), BaseName:=$($inputObject.GetType().BaseType.Name) $NestingLevel "
			switch ($Type)
			{
				'ScriptBlock'{ "[$type] {$($inputObject.ToString())}" }
				'InnerXML'        { "[$type]@'`r`n" + ($inputObject.OuterXMl) + "`r`n'@`r`n" } # just use a 'here' string
				'DateTime'   { "[datetime]'$($inputObject.ToString('s'))'" } # s=SortableDateTimePattern (based on ISO 8601) local time
				'Boolean'    {
					"[bool] $(&{
						if ($inputObject -eq $true) { "`$True" }
						Else { "`$False" }
					})"
				}
				'string'     {
					if ($inputObject -match '[\r\n]') { "@'`r`n$inputObject`r`n'@" }
					else { "'$($inputObject -replace '''', '''''')'" }
				}
				'Char'       { [int]$inputObject }
				{ @('byte', 'decimal', 'double', 'float', 'single', 'int', 'int32', 'int16', 'long', 'int64', 'sbyte', 'uint16', 'uint32', 'uint64') -contains $_ }
				{ "$inputObject" } # rendered as is without single quotes
				'PSNoteProperty' { "$(ConvertTo-PSON -inputObject $inputObject.Value -depth $depth -NestingLevel ($NestingLevel))" }
				'Array'      { "`r`n$padding@(" + ("$($inputObject | ForEach {$ArrayEnd=1; ",$(ConvertTo-PSON -inputObject $_ -depth $depth -NestingLevel ($NestingLevel + 1))" })".Substring($ArrayEnd)) + "`r`n$padding)" }
				'HashTable'  { "`r`n$padding@{" + ("$($inputObject.GetEnumerator() | ForEach {$ArrayEnd=1; "; '$($_.Name)' = " + (ConvertTo-PSON -inputObject $_.Value -depth $depth -NestingLevel ($NestingLevel + 1)) })".Substring($ArrayEnd) + "`r`n$padding}") }
				'PSObject'   { "`r`n$padding[pscustomobject]@{" + ("$($inputObject.PSObject.Properties | ForEach {$ArrayEnd=1; "; '$($_.Name)' = " + (ConvertTo-PSON -inputObject $_ -depth $depth -NestingLevel ($NestingLevel + 1)) })".Substring($ArrayEnd) + "`r`n$padding}") }
				'Dictionary' { "`r`n$padding@{" + ($inputObject.item | ForEach {$ArrayEnd=1; '; ' + "'$_'" + " = " + (ConvertTo-PSON -inputObject $inputObject.Value[$_] -depth $depth -NestingLevel $NestingLevel+1) }) + '}' }
				'Generic'    { "`r`n$padding@{" + ("$($inputObject.Keys | ForEach {$ArrayEnd=1; ";  $_ =  $(ConvertTo-PSON -inputObject $inputObject.$_ -depth $depth -NestingLevel ($NestingLevel + 1))" })".Substring($ArrayEnd) + "`r`n$padding}") }
				'Object'     { "`r`n$padding@{" + ("$($inputObject | Get-Member -membertype properties | Select-Object name | ForEach {$ArrayEnd=1; ";  $($_.name) =  $(ConvertTo-PSON -inputObject $inputObject.$($_.name) -depth $NestingLevel -NestingLevel ($NestingLevel + 1))" })".Substring($ArrayEnd) + "`r`n$padding}") }
				'XML'        { "`r`n$padding@{" + ("$($inputObject | Get-Member -membertype properties | where name -ne 'schema' | Select-Object name | ForEach {$ArrayEnd=1; ";  $($_.name) =  $(ConvertTo-PSON -inputObject $inputObject.$($_.name) -depth $depth -NestingLevel ($NestingLevel + 1))" })".Substring($ArrayEnd) + "`r`n$padding}") }
				'Datatable'  { "`r`n$padding@{" + ("$($inputObject.TableName)=`r`n$padding @(" + "$($inputObject | ForEach {$ArrayEnd=1; ",$(ConvertTo-PSON -inputObject $_ -depth $depth -NestingLevel ($NestingLevel + 1))" })".Substring($ArrayEnd) + "`r`n$padding  )`r`n$padding}") }
				'DataRow'    { "`r`n$padding@{" + ("$($inputObject | Get-Member -membertype properties | Select-Object name | ForEach {$ArrayEnd=1; "; $($_.name)=  $(ConvertTo-PSON -inputObject $inputObject.$($_.name) -depth $depth -NestingLevel ($NestingLevel + 1))" })".Substring($ArrayEnd) + "}") }
				default { "'$inputObject'" }
			}
		}
		catch
		{
			write-error "Error'$($_)' in script $($_.InvocationInfo.ScriptName) $($_.InvocationInfo.Line.Trim()) (line $($_.InvocationInfo.ScriptLineNumber)) char $($_.InvocationInfo.OffsetInLine) executing $($_.InvocationInfo.MyCommand) on $type object '$($inputObject.Name)' Class: $($inputObject.GetType().Name) BaseClass: $($inputObject.GetType().BaseType.Name) "
		}
		finally { }
	}
	END { }

# end function ConvertTo-PSON
}



function New-CustomObjectOld
	{
	<#
		.SYNOPSIS
			Creates a Custom Object
	
		.DESCRIPTION
			Creates an empty Custom Object with defined properties.
	
		.PARAMETER  Property
			An array of properties to be used by the object.
	
		.EXAMPLE
			New-CustomObject -Property "First","Last","Phone"
	
		.EXAMPLE
			$Kalle = New-CustomObject -Property "First","Last","Phone"
	
			$Kalle.First = "Kalle"
	
			$Kalle.Last = "Svensson"
	
			$Kalle.Phone = "555-555555"
	
		.INPUTS
			System.Array
	
		.OUTPUTS
			System.PSObject
	
		.NOTES
			Takes away the cumbersome way of creating objects in PowerShell v2.
	
		.LINK
			https://technet.microsoft.com/en-us/magazine/hh750381.aspx
	
	#>
	
	
	param (
		[Parameter(Mandatory=$true)]
		[array]$Property
	)

	$Object = New-Object PSObject
	
	foreach ($ItemProperty in $Property){
		$Object | Add-Member -MemberType 'NoteProperty' -Name $ItemProperty -Value $null
	}
	
	return $Object
	
# end function New-CustomObjectOld
}



function New-CustomObject
	{
	<#
		.SYNOPSIS
			Creates a Custom Object
	
		.DESCRIPTION
			Creates an empty Custom Object with defined properties.
	
		.PARAMETER  Property
			An array of properties to be used by the object.
	
		.EXAMPLE
			New-CustomObject -Property "First","Last","Phone"
	
		.EXAMPLE
			$Kalle = New-CustomObject -Property "First","Last","Phone"
	
			$Kalle.First = "Kalle"
	
			$Kalle.Last = "Svensson"
	
			$Kalle.Phone = "555-555555"
	
		.INPUTS
			System.Array
	
		.OUTPUTS
			System.PSObject
	
		.NOTES
			Takes away the cumbersome way of creating objects in PowerShell v2.
	
		.LINK
			https://technet.microsoft.com/en-us/magazine/hh750381.aspx
	
	#>
	
	
	param (
		[Parameter(Mandatory=$true)]
		[array]$Property
	)

	$arrProperty = @{}
	
	foreach ($ItemProperty in $Property){
		$arrProperty.$ItemProperty = $nul
	}
	
	return $Object = New-Object PSObject -Property $arrProperty | Select-Object $Property
	
# end function New-CustomObject
}



function Get-WmiEventLog {
	<#
		.SYNOPSIS
			Gets eventlog entries from remote computer.
	
		.DESCRIPTION
			Gets eventlog from remote computer not running PoSH using WMI.
	
		.PARAMETER  Computer
			Computer name to send a WMI query to.
	
		.PARAMETER  LogFile
			The LogFile to query.
			I.e. SYSTEM, APPLICATION, SECURITY
	
		.PARAMETER SourceName
			Name of the event Source to filter the query.
	
		.PARAMETER EventCode
			EventId/s to filter the query.
	
		.PARAMETER EventType
			Type Information, Warning or Error or a combination of them all.
	
		.PARAMETER ExcludeEvent
			Switch for excluding EventCode instead of including them in filter.
	
		.PARAMETER Days
			Limit search to amount of Days (default is 7).
	
		.PARAMETER DropDays
			Doesn't remember.
	
		.EXAMPLE
			Get-WmiEventLog -Computer "retse268-if0010" -LogFile SYSTEM -SourceName eventlog -EventCode 6009 -ExcludeEvent
	
		.EXAMPLE
			Get-WmiEventLog -Computer "retse268-if0010" -LogFile SYSTEM -SourceName eventlog -EventCode "6005","6006"
	
		.EXAMPLE
			Get-WmiEventLog -Computer "retse268-if0010" -LogFile SYSTEM -SourceName eventlog -EventType "Error"
	
		.INPUTS
			System.String,System.Int32
	
		.OUTPUTS
			System.String
	
		.NOTES
			Additional information about the function go here.
	
		.LINK
			about_functions_advanced
	
		.LINK
			about_comment_based_help
	
	#>
	
	param (
		[string]$Computer = $ENV:COMPUTERNAME,
	
		[Parameter(Mandatory=$true)]
		[string]$LogFile,
	
		[string]$SourceName,
	
		[array]$EventCode,
	
		[array]$EventType,
	
		[switch]$ExcludeEvent,
	
		[int]$Days = 7,
	
		[switch]$DropDays
	)
	
	# Build query string
	$query = "SELECT * FROM Win32_NTLogEvent WHERE (logfile = '$LogFile')"
	
	if ($SourceName){
		$query = $query + " AND (SourceName = '$SourceName')"
	}
	
	if ($EventCode -and !$ExcludeEvent){# Event that shouldn't be dropped
				
		if ($EventCode.Count -eq 1){# single EventCode
			$query = $query +  " AND (EventCode = '$EventCode')"
		}# end single event
		
		else {# multiple EventCodes
			$query = $query + " AND ("
			
			for ($i=0; $i -lt  $EventCode.Count; $i++){
				$query = $query + "(EventCode = " + $EventCode[$i] + ")"
				if ($i + 1 -ne $EventCode.Count){# if not the last event
					$query = $query + " OR "
				}
			}# end for each event
			$query = $query + ")"
		}# end multiple events
		
	}# end include all events
	
	if ($EventCode -and $ExcludeEvent){# events that should be dropped
		foreach ($EventId in $EventCode){
			$query = $query +  " AND (EventCode != '$EventId')"
		}# end foreach
	}# end event exclude
	
	
	if ($EventType) {# event type
		if ($EventType.Count -eq 1){# single EventType
			$query = $query +  " AND (Type = '$EventType')"
		}
		
		else {# multiple Event Types
			$query = $query + " AND ("
			
			for ($i=0; $i -lt  $EventType.Count; $i++){
				$query = $query + "(Type = " + $EventType[$i] + ")"
				if ($i + 1 -ne $EventCode.Count){# if not the last event
					$query = $query + " OR "
				}
			}# end for each Type
			$query = $query + ")"
		}# end multiple Types
		
	}# end include all Types
	
	$TimeFilter = (get-date).adddays(-$Days).Tostring("yyyyMMddHHmmss") + ".000000+060"
	if (!$DropDays){
		$query = $query + " AND (TimeGenerated > '$TimeFilter')"
	}
	
	return Get-WmiObject -ComputerName $Computer -query $query | sort RecordNumber
	
# end function Get-WmiEventLog
}



function Get-ComputerAdAttribute {
	<#
		.SYNOPSIS
			Returns AD attributes of a computer object.
	
		.DESCRIPTION
			A detailed description of the function.
	
		.PARAMETER  Name
			Name of computer.
	
		.PARAMETER  Attribute
			Computer Attribute/s to return.
	
		.PARAMETER  All
			Switch to find all occurences (most likely needed when using wildcards).
	
		.EXAMPLE
			$computer = Get-ComputerAdAttribute -Name itsehbg* -All
	
		.EXAMPLE
			$computer = Get-ComputerAdAttribute -Name itsehbg-dn0715
	
		.INPUTS
			System.String,System.Int32
	
		.OUTPUTS
			System.String
	
		.NOTES
			Additional information about the function go here.
	
		.LINK
			about_functions_advanced
	
		.LINK
			about_comment_based_help
	
	#>
	
param (
		[string]$Name = ($ENV:COMPUTERNAME),
	
		[ValidateSet("cn","description","displayName","distinguishedName","info","instancetype","manager",
		"name","objectCategory","objectClass","objectGUID","objectSid","operatingSystem",
		"operatingSystemServicePack","operatingSystemVersion","primaryGroupID","pwdLastSet","sAMAccountName",
		"sAMAccountType","servicePrincipleName","userAccountControl","whenChanged","whenCreated")]
		[string]$Attribute,
	
		[switch]$All
	)
	
	$LdapFilter = "(&(objectCategory=computer)(objectClass=computer)(cn=$Name)(sAMAccountType=$(0x30000001)))"
	
	if ($All){# looking for more then one computer
		$ldapsearch = ([adsisearcher]$LdapFilter)
		$ldapsearch.PageSize = 1000 # get all items in batches of 1000
		$ldap = $ldapsearch.FindAll()
	}
	else {
		$ldap = ([adsisearcher]$LdapFilter).FindOne()
	}
	
	$colComp = @()
	foreach ($ldapItem in $ldap){
		$colComp = $colComp + [adsi]$ldapItem.path
	}
	
	if (!$Attribute){
		return $colComp
	}
	else {
		return $colComp.$Attribute
	}
	
# end function Get-ComputerAdAttribute
}



#region Remote Registry

function Get-RegPathParts {
	
	<#
		.SYNOPSIS
			Splits a regpath in Hive, Key, ValueName and Value.
	
		.DESCRIPTION
			Helper function that takes a string formated either in PoSH regpath syntax,
			reg file syntax, Leeann simplified syntax or cmd reg syntax and splits it in 
			the different parts.
	
			Object returned contains the Properties
			.Hive
			.Key
			.ValueName
			.Value
			.Type
			.RegArg
			.Syntax
	
		.PARAMETER  -RegPath
			Registry path.
	
		.EXAMPLE
			Get-RegPathParts "HKLM\SOFTWARE\Wow6432Node\Positive\Test \\"

			Hive      : LocalMachine
			Key       : SOFTWARE\Wow6432Node\Positive\Test
			ValueName :
			Value     :
			Type      : String
			RegArg    : HKLM\SOFTWARE\Wow6432Node\Positive\Test \\
			Syntax    : Leeann
	
		.EXAMPLE
			Get-RegPathParts "HKLM\SOFTWARE\Wow6432Node\Positive\Test=Testing \\"

			Hive      : LocalMachine
			Key       : SOFTWARE\Wow6432Node\Positive
			ValueName : Test
			Value     : Testing
			Type      : String
			RegArg    : HKLM\SOFTWARE\Wow6432Node\Positive\Test=Testing \\
			Syntax    : Leeann
	
		.EXAMPLE
			Get-RegPathParts "HKLM\SOFTWARE\Wow6432Node\Positive\Test= \\"

			Hive      : LocalMachine
			Key       : SOFTWARE\Wow6432Node\Positive
			ValueName : Test
			Value     :
			Type      : String
			RegArg    : HKLM\SOFTWARE\Wow6432Node\Positive\Test= \\
			Syntax    : Leeann
	
		.EXAMPLE
			Get-RegPathParts "HKLM\SOFTWARE\Wow6432Node\Positive\Test /v Testing /d None"
			
			Hive      : LocalMachine
			Key       : SOFTWARE\Wow6432Node\Positive\Test
			ValueName : Testing
			Value     : None
			Type      : String
			RegArg    : HKLM\SOFTWARE\Wow6432Node\Positive\Test /v Testing /d None
			Syntax    : Reg CMD (default)
	
		.EXAMPLE
			Get-RegPathParts "HKLM\SOFTWARE\Wow6432Node\Positive\Test /v Testing /d 10 /t REG_DWORD"

			Hive      : LocalMachine
			Key       : SOFTWARE\Wow6432Node\Positive\Test
			ValueName : Testing
			Value     : 10
			Type      : REG_DWORD
			RegArg    : HKLM\SOFTWARE\Wow6432Node\Positive\Test /v Testing /d 10 /t REG_DWORD
			Syntax    : Reg CMD (default)
				
		.INPUTS
			System.String
	
		.OUTPUTS
			System.PSCustomObject
	
		.NOTES
			If omitting Hive name in string, function will default to LocalMachine
	
		.LINK
			about_functions_advanced
	
		.LINK
			about_comment_based_help
	
	#>
	
	
	param(
		[string]$RegArg
	)
	
	$RegObj = New-CustomObject -Property "Hive","Key","ValueName","Value","Type","RegArg","Syntax"
	$RegObj.Type = "String"
	$RegObj.RegArg = $RegArg
	
	switch -wildcard ($RegArg) {
		"*:*"  {# PoSH Syntax type
			$RegObj.Syntax = "PoSH"
			$RegObj.Key = $RegArg.Split(":")[-1]
			$HiveName = $RegArg.Split(":")[0]	
		}# end if PoSH syntax
		
		"*]*" {# .reg syntax type
			$RegObj.Syntax = "RegFile"
			$RegObj.Value = $Data.Split("=")[-1].Split(":")[-1]
			$RegObj.Type = $Data.Split("=")[-1].Split(":")[0]
			if ($RegObj.Type = $RegObj.Value){# no type specified
				$RegObj.Type = "String"
			}# end if notype
		
		}# end elseif .reg syntax
		
		"*\\*" {# Leeann simplified syntax
			$RegObj.Syntax = "Leeann"
			$RegArgs = $RegArg.Trim(" \\")
			$HiveName = $RegArgs.Split("=")[0].Split("\")[0].ToUpper()
			$KeyLength = $RegArgs.Length - $HiveName.Length -1
			
			$RegObj.Value = $RegArgs.Split("=")[-1]
			if ($RegObj.Value -eq $RegArgs) {
				$RegObj.Value = ""
			}
			if ($RegArgs.Contains("=")){
				$KeyLength = $KeyLength - $RegObj.Value.Length -1
				
				$RegObj.ValueName = $RegArgs.Split("=")[0].Split("\")[-1]
				$KeyLength = $KeyLength - $RegObj.ValueName.Length -1
			}
			
			$RegObj.Key = $RegArgs.Substring($HiveName.Length + 1, $KeyLength)
		}
		
		default {# assume reg cmd syntax type
			$RegObj.Syntax = "Reg CMD (default)"
			
			$RegArgs = $RegArg.Split("/").Trim(" ")
			
			$Path = $RegArgs[0].Trim("""")
			$Value = $RegArgs -like "v *"
			$Data = $RegArgs -like "d *"
			$Type = $RegArgs -like "t *"
			
			$HiveName = $Path.Split("\")[0].ToUpper()
					
			$RegObj.ValueName = $Value.Split(" ")[-1].Trim("""")
			$RegObj.Value = $Data.Split(" ")[-1].Trim("""")
			$RegObj.Type = $Type.Split(" ")[-1].Trim("""")
			if (!$RegObj.Type){# set default
				$RegObj.Type = "REG_SZ"
			}# end if default
			
			$RegObj.Key = $Path.Substring($HiveName.Length + 1, $Path.Length - $HiveName.Length -1)	
		}# end assume reg syntax
		
	}# end switch RegArg
	
	
	
	switch ($HiveName) {
		"HKLM" {
			$RegObj.Hive = 'LocalMachine'
		}
		
		"HKEY_LOCAL_MACHINE" {
			$RegObj.Hive = 'LocalMachine'
		}
		
		"HKCU" {
			$RegObj.Hive = 'CurrentUser'
		}
		
		"HKEY_CURRENT_USER" {
			$RegObj.Hive = 'CurrentUser'
		}
		
		"HKU" {
			$RegObj.Hive = 'Users'
		}
		
		"HKEY_USERS" {
			$RegObj.Hive = 'Users'
		}
		
		"HKCR" {
			$RegObj.Hive= 'ClassesRoot'
		}
		
		"HKEY_CLASSES_ROOT" {
			$RegObj.Hive= 'ClassesRoot'
		}
		
		default {
			$RegObj.Key = $HiveName + "\" + $RegObj.Key
			$RegObj.Hive = 'LocalMachine'
		}
	}# end switch HiveName
	
	return $RegObj
	
# end function Get-RegPathParts
}


# http://psremoteregistry.codeplex.com/

function Get-RegBinary {
	<#
	.SYNOPSIS
	       Retrieves a binary data registry value (REG_BINARY) from local or remote computers.

	.DESCRIPTION
	       Use Get-RegBinary to retrieve a binary data registry value (REG_BINARY) from local or remote computers.
	       
	.PARAMETER ComputerName
	    	An array of computer names. The default is the local computer.

	.PARAMETER Hive
	   	The HKEY to open, from the RegistryHive enumeration. The default is 'LocalMachine'.
	   	Possible values:
	   	
		- ClassesRoot
		- CurrentUser
		- LocalMachine
		- Users
		- PerformanceData
		- CurrentConfig
		- DynData	   	

	.PARAMETER Key
	       The path of the registry key to open.  

	.PARAMETER Value
	       The name of the registry value.

	.PARAMETER Ping
	       Use ping to test if the machine is available before connecting to it. 
	       If the machine is not responding to the test a warning message is output.

	.EXAMPLE	  
		$Key = "SOFTWARE\Microsoft\Internet Explorer\Registration"
		Get-RegBinary -Key $Key -Value DigitalProductId

		ComputerName Hive            Key                  Value              Data                 Type
		------------ ----            ---                  -----              ----                 ----
		COMPUTER1    LocalMachine    SOFTWARE\Microsof... IE Installed Date  {114, 76, 180, 17... Binary		
		
		Description
		-----------
		The command gets the DigitalProductId binary value from the local computer.
		The name of ComputerName parameter, which is optional, is omitted.		
		
	.EXAMPLE	
		"SERVER1","SERVER2","SERVER3" | Get-RegBinary -Key $Key -Value DigitalProductId -Ping
		
		ComputerName Hive         Key                                               Value            Data              Type
		------------ ----         ---                                               -----            ----              ----
		SERVER1      LocalMachine SOFTWARE\Microsoft\Internet Explorer\Registration DigitalProductId {164, 0, 0, 0...} Binary
		SERVER2      LocalMachine SOFTWARE\Microsoft\Internet Explorer\Registration DigitalProductId {164, 0, 0, 0...} Binary
		SERVER3      LocalMachine SOFTWARE\Microsoft\Internet Explorer\Registration DigitalProductId {164, 0, 0, 0...} Binary

		Description
		-----------
		The command gets the DigitalProductId binary value from remote computers. 
		When the Switch parameter Ping is specified the command issues a ping test to each computer. 
		If the computer is not responding to the ping request a warning message is written to the console and the computer is not processed.

	.EXAMPLE	
		Get-Content servers.txt | Get-RegBinary -Key $Key -Value DigitalProductId
		
		ComputerName Hive         Key                                               Value            Data              Type
		------------ ----         ---                                               -----            ----              ----
		SERVER1      LocalMachine SOFTWARE\Microsoft\Internet Explorer\Registration DigitalProductId {164, 0, 0, 0...} Binary
		SERVER2      LocalMachine SOFTWARE\Microsoft\Internet Explorer\Registration DigitalProductId {164, 0, 0, 0...} Binary
		SERVER3      LocalMachine SOFTWARE\Microsoft\Internet Explorer\Registration DigitalProductId {164, 0, 0, 0...} Binary

		Description
		-----------
		The command uses the Get-Content cmdlet to get the server names from a text file.

	.EXAMPLE	
		Get-RegString -Hive LocalMachine -Key $Key -Value DigitalProductId | Test-RegValue -ComputerName SERVER1,SERVER2 -Ping
		True
		True

		Description
		-----------
		he command gets the DigitalProductId binary value from the local computer.
		The output is piped to the Test-RegValue function to check if the value exists on two remote computers.
		When the Switch parameter Ping is specified the command issues a ping test to each computer. 
		If the computer is not responding to the ping request a warning message is written to the console and the computer is not processed.	
	
	.OUTPUTS
		PSFanatic.Registry.RegistryValue (PSCustomObject)

	.NOTES
		Author: Shay Levy
		Blog  : http://blogs.microsoft.co.il/blogs/ScriptFanatic/
		
	.LINK
		http://code.msdn.microsoft.com/PSRemoteRegistry

	.LINK
		Set-RegBinary
		Get-RegValue
		Remove-RegValue
		Test-RegValue


	#>
	
	
	[OutputType('PSFanatic.Registry.RegistryValue')]
	[CmdletBinding(DefaultParameterSetName="__AllParameterSets")]
	
	param( 
		[Parameter(
			Position=0,
			ValueFromPipeline=$true,
			ValueFromPipelineByPropertyName=$true,
			HelpMessage="An array of computer names. The default is the local computer."
		)]		
		[Alias("CN","__SERVER","IPAddress")]
		[string[]]$ComputerName="",
		
		[Parameter(
			Position=1,
			ValueFromPipelineByPropertyName=$true,
			HelpMessage="The HKEY to open, from the RegistryHive enumeration. The default is 'LocalMachine'."
		)]
		[ValidateSet("ClassesRoot","CurrentUser","LocalMachine","Users","PerformanceData","CurrentConfig","DynData")]
		[string]$Hive="LocalMachine",
		
		[Parameter(
			Mandatory=$true,
			Position=2,
			ValueFromPipelineByPropertyName=$true,
			HelpMessage="The path of the subkey to open."
		)]
		[Alias("RegKey")]
		[string]$Key,

		[Parameter(
			Mandatory=$true,
			Position=3,
			ValueFromPipelineByPropertyName=$true,
			HelpMessage="The name of the value to get."
		)]
		[string]$Value,
		
		[switch]$Ping
	) 
	

	process	{
    	Write-Verbose "Enter process block..."
		
		foreach($c in $ComputerName) {	
			try	{				
				if($c -eq "") {
					$c=$env:COMPUTERNAME
					Write-Verbose "Parameter [ComputerName] is not present, setting its value to local computer name: [$c]."
					
				}# endif
				
				if($Ping) {
					Write-Verbose "Parameter [Ping] is present, initiating Ping test"
					
					if( !(Test-Connection -ComputerName $c -Count 1 -Quiet))
					{
						Write-Warning "[$c] doesn't respond to ping."
						return
					}
				}# endif

				
				Write-Verbose "Starting remote registry connection against: [$c]."
				Write-Verbose "Registry Hive is: [$Hive]."
				$reg = [Microsoft.Win32.RegistryKey]::OpenRemoteBaseKey([Microsoft.Win32.RegistryHive]$Hive,$c)		
				
				Write-Verbose "Open remote subkey: [$Key]"
				$subKey = $reg.OpenSubKey($Key)				

				if(!$subKey) {
					Throw "Key '$Key' doesn't exist."
				}# endif
					
				Write-Verbose "Get value name : [$Value]"
				$rv = $subKey.GetValue($Value,-1)
				
				if($rv -eq -1) {
					Write-Error "Cannot find value [$Value] because it does not exist."
				}
				else {
					Write-Verbose "Create PSFanatic registry value custom object."
					$pso = New-Object PSObject -Property @{
						ComputerName=$c
						Hive=$Hive
						Value=$Value
						Key=$Key
						Data=$rv
						Type=$subKey.GetValueKind($Value)
					}

					Write-Verbose "Adding format type name to custom object."
					$pso.PSTypeNames.Clear()
					$pso.PSTypeNames.Add('PSFanatic.Registry.RegistryValue')
					$pso
				}# endif		

				Write-Verbose "Closing remote registry connection on: [$c]."
				$subKey.close()
			}# end try
			
			catch {
				Write-Error $_
			}# end catch
			
		}# end foreach 
		
		Write-Verbose "Exit process block..."
	}# end process
	
# end function Get-RegBinary
}



function Get-RegDefault {
	<#
	.SYNOPSIS
	       Retrieves registry default string (REG_SZ) value from local or remote computers.

	.DESCRIPTION
	       Use Get-RegDefault to retrieve registry default string (REG_SZ) value from local or remote computers.
	       
	.PARAMETER ComputerName
	    	An array of computer names. The default is the local computer.

	.PARAMETER Hive
	   	The HKEY to open, from the RegistryHive enumeration. The default is 'LocalMachine'.
	   	Possible values:
	   	
		- ClassesRoot
		- CurrentUser
		- LocalMachine
		- Users
		- PerformanceData
		- CurrentConfig
		- DynData	   	

	.PARAMETER Key
	       The path of the registry key to open. 

	.EXAMPLE
		$Key = "SOFTWARE\MyCompany"
		"SERVER1","SERVER2","SERVER3" | Set-RegDefault -Key $Key -Ping
		
		ComputerName Hive            Key                  Value      Data            Type
		------------ ----            ---                  -----      ----            ----
		SERVER1      LocalMachine    SOFTWARE\MyCompany   (Default)  MyDefaultValue  String		
		SERVER2      LocalMachine    SOFTWARE\MyCompany   (Default)  MyDefaultValue  String		
		SERVER3      LocalMachine    SOFTWARE\MyCompany   (Default)  MyDefaultValue  String		
		
		Description
		-----------
		Gets the reg default value of the SOFTWARE\MyCompany subkey on three remote computers local machine hive (HKLM) .
		Ping each server before setting the value.

	.OUTPUTS
		PSFanatic.Registry.RegistryValue (PSCustomObject)
		
	.NOTES
		Author: Shay Levy
		Blog  : http://blogs.microsoft.co.il/blogs/ScriptFanatic/
		
	.LINK
		http://code.msdn.microsoft.com/PSRemoteRegistry

	.LINK
		Set-RegDefault
		Get-RegValue
	#>
	
	
	[OutputType('PSFanatic.Registry.RegistryValue')]
	[CmdletBinding(DefaultParameterSetName="__AllParameterSets")]
	
	param( 
		[Parameter(
			Position=0,
			ValueFromPipeline=$true,
			ValueFromPipelineByPropertyName=$true,
			HelpMessage="An array of computer names. The default is the local computer."
		)]		
		[Alias("CN","__SERVER","IPAddress")]
		[string[]]$ComputerName="",		
		
		[Parameter(
			Position=1,
			ValueFromPipelineByPropertyName=$true,
			HelpMessage="The HKEY to open, from the RegistryHive enumeration. The default is 'LocalMachine'."
		)]
		[ValidateSet("ClassesRoot","CurrentUser","LocalMachine","Users","PerformanceData","CurrentConfig","DynData")]
		[string]$Hive="LocalMachine",
		
		[Parameter(
			Mandatory=$true,
			Position=2,
			ValueFromPipelineByPropertyName=$true,
			HelpMessage="The path of the subkey to open."
		)]
		[Alias("RegKey")]
		[string]$Key,

		[switch]$Ping
	) 
	

	process	{
	    Write-Verbose "Enter process block..."
		
		foreach($c in $ComputerName) {	
			try {				
				if($c -eq "") {
					$c=$env:COMPUTERNAME
					Write-Verbose "Parameter [ComputerName] is not present, setting its value to local computer name: [$c]."
					
				}# end if
				
				if($Ping) {
					Write-Verbose "Parameter [Ping] is present, initiating Ping test"
					
					if( !(Test-Connection -ComputerName $c -Count 1 -Quiet)) {
						Write-Warning "[$c] doesn't respond to ping."
						return
					}# end if
				}# end if

				
				Write-Verbose "Starting remote registry connection against: [$c]."
				Write-Verbose "Registry Hive is: [$Hive]."
				$reg = [Microsoft.Win32.RegistryKey]::OpenRemoteBaseKey([Microsoft.Win32.RegistryHive]$Hive,$c)		
				
				Write-Verbose "Open remote subkey: [$Key]."
				$subKey = $reg.OpenSubKey($Key)
				
				if(!$subKey) {
					Throw "Key '$Key' doesn't exist."
				}# end if
				
				$pso = New-Object PSObject -Property @{
					ComputerName=$c
					Hive=$Hive
					Value="(Default)"
					Key=$Key
					Data=$subKey.GetValue($null)
					Type=$subKey.GetValueKind($Value)
				}
					
				Write-Verbose "Adding format type name to custom object."
				$pso.PSTypeNames.Clear()
				$pso.PSTypeNames.Add('PSFanatic.Registry.RegistryValue')
				$pso

				Write-Verbose "Closing remote registry connection on: [$c]."
				$subKey.close()
			}# end try
			
			catch {
				Write-Error $_
			}# end catch
		}# end foreach 
		
		Write-Verbose "Exit process block..."
	}# end process
	
# end function Get-RegDefault
}



function Get-RegDWord {

	<#
	.SYNOPSIS
	       Retrieves a 32-bit binary number (REG_DWORD) registry value from local or remote computers.

	.DESCRIPTION
	       Use Get-RegDWord to retrieve a 32-bit binary number (REG_DWORD) registry value from local or remote computers.
	       
	.PARAMETER ComputerName
	    	An array of computer names. The default is the local computer.

	.PARAMETER Hive
	   	The HKEY to open, from the RegistryHive enumeration. The default is 'LocalMachine'.
	   	Possible values:
	   	
		- ClassesRoot
		- CurrentUser
		- LocalMachine
		- Users
		- PerformanceData
		- CurrentConfig
		- DynData	   	

	.PARAMETER Key
	       The path of the registry key to open.  

	.PARAMETER Value
	       The name of the registry value.

	.PARAMETER AsHex
	       Returnes the value in HEX notation.

	.PARAMETER Ping
	       Use ping to test if the machine is available before connecting to it. 
	       If the machine is not responding to the test a warning message is output.

	.EXAMPLE
		$Key = "System\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp"
		Get-RegDWord -ComputerName SERVER1 -Hive LocalMachine -Key $Key -Value PortNumber

		ComputerName Hive            Key                  Value       Data  Type
		------------ ----            ---                  -----       ----  ----
		SERVER1      LocalMachine    System\CurrentCon... PortNumber  3389  DWord


		Description
		-----------
	   	The command gets the Terminal Server's listening port from SERVER1 server.	   
	   
	.EXAMPLE	   
		Get-RegDWord -ComputerName SERVER1 -Key $Key -Value PortNumber

		ComputerName Hive            Key                  Value       Data  Type
		------------ ----            ---                  -----       ----  ----
		SERVER1      LocalMachine    System\CurrentCon... PortNumber  3389  DWord


		Description
		-----------
	   	The command gets the Terminal Server's listening port from SERVER1 server. 
	   	You can omit the -Hive parameter (which is optional), if the registry Hive the key resides in is LocalMachine (HKEY_LOCAL_MACHINE).

	.EXAMPLE
		Get-RegDWord -CN SERVER1,SERVER2 -Key $Key -Value PortNumber -AsHex

		ComputerName Hive            Key                  Value       Data   Type
		------------ ----            ---                  -----       ----   ----
		SERVER1      LocalMachine    System\CurrentCon... PortNumber  0xd3d  DWord
		SERVER2      LocalMachine    System\CurrentCon... PortNumber  0xd3d  DWord


		Description
		-----------
	   	This command gets the Terminal Server's listening port from SERVER1 and SERVER2.
	   	The command uses the ComputerName parameter alias 'CN' to specify a collection of computer names. 
	   	When the AsHex Switch Parameter is used, the value's data returnes in HEX notation.

	.OUTPUTS
		PSFanatic.Registry.RegistryValue (PSCustomObject)

	.NOTES
		Author: Shay Levy
		Blog  : http://blogs.microsoft.co.il/blogs/ScriptFanatic/

	.LINK
		http://code.msdn.microsoft.com/PSRemoteRegistry

	.LINK
		Set-RegQWord
		Get-RegValue
		Remove-RegValue
		Test-RegValue
	#>
	
	
	[OutputType('PSFanatic.Registry.RegistryValue')]
	[CmdletBinding(DefaultParameterSetName="__AllParameterSets")]
	
	param( 
		[Parameter(
			Position=0,
			ValueFromPipeline=$true,
			ValueFromPipelineByPropertyName=$true,
			HelpMessage="An array of computer names. The default is the local computer."
		)]		
		[Alias("CN","__SERVER","IPAddress")]
		[string[]]$ComputerName="",		
		
		[Parameter(
			Position=1,
			ValueFromPipelineByPropertyName=$true,
			HelpMessage="The HKEY to open, from the RegistryHive enumeration. The default is 'LocalMachine'."
		)]
		[ValidateSet("ClassesRoot","CurrentUser","LocalMachine","Users","PerformanceData","CurrentConfig","DynData")]
		[string]$Hive="LocalMachine",
		
		[Parameter(
			Mandatory=$true,
			Position=2,
			ValueFromPipelineByPropertyName=$true,
			HelpMessage="The path of the subkey to open."
		)]
		[Alias("RegKey")]
		[string]$Key,

		[Parameter(
			Mandatory=$true,
			Position=3,
			ValueFromPipelineByPropertyName=$true,
			HelpMessage="The name of the value to get."
		)]
		[string]$Value,
		
		[switch]$AsHex,
		
		[switch]$Ping
	) 
	

	process	{
	    Write-Verbose "Enter process block..."
		
		foreach($c in $ComputerName) {	
			try {				
				if($c -eq "") {
					$c=$env:COMPUTERNAME
					Write-Verbose "Parameter [ComputerName] is not present, setting its value to local computer name: [$c]."
					
				}# end if
				
				if($Ping) {
					Write-Verbose "Parameter [Ping] is present, initiating Ping test"
					
					if( !(Test-Connection -ComputerName $c -Count 1 -Quiet)) {
						Write-Warning "[$c] doesn't respond to ping."
						return
					}# end if
				}# end if

				
				Write-Verbose "Starting remote registry connection against: [$c]."
				Write-Verbose "Registry Hive is: [$Hive]."
				$reg = [Microsoft.Win32.RegistryKey]::OpenRemoteBaseKey([Microsoft.Win32.RegistryHive]$Hive,$c)		
				
				Write-Verbose "Open remote subkey: [$Key]"
				$subKey = $reg.OpenSubKey($Key)
				
				if(!$subKey) {
					Throw "Key '$Key' doesn't exist."
				}# end if		
				
				Write-Verbose "Get value name : [$Value]"
				$rv = $subKey.GetValue($Value,-1)
				
				if($rv -eq -1) {
					Write-Error "Cannot find value [$Value] because it does not exist."
				}
				else {
					if($AsHex) {
						Write-Verbose "Parameter [AsHex] is present, return value as HEX."
						$rv = "0x{0:x}" -f $rv
					}
					else {
						Write-Verbose "Parameter [AsHex] is not present, return value as INT."
					}# end if
					
					
					Write-Verbose "Create PSFanatic registry value custom object."
					$pso = New-Object PSObject -Property @{
						ComputerName=$c
						Hive=$Hive
						Value=$Value
						Key=$Key
						Data=$rv
						Type=$subKey.GetValueKind($Value)
					}
					
					Write-Verbose "Adding format type name to custom object."
					$pso.PSTypeNames.Clear()
					$pso.PSTypeNames.Add('PSFanatic.Registry.RegistryValue')
					$pso					
					
				}# end if		

				Write-Verbose "Closing remote registry connection on: [$c]."
				$subKey.close()
			}# end try
			
			catch {
				Write-Error $_
			}# end catch
		}# end forech
		
		Write-Verbose "Exit process block..."
	}# end process
	
# end function Get-RegDWord
}



function Get-RegExpandString {

	<#
	.SYNOPSIS
	       Retrieves a null-terminated string that contains unexpanded references to environment variables (REG_EXPAND_SZ) from local or remote computers.

	.DESCRIPTION
	       Use Get-RegExpandString to retrieve a null-terminated string that contains unexpanded references to environment variables (REG_EXPAND_SZ) from local or remote computers.
	       
	.PARAMETER ComputerName
	    	An array of computer names. The default is the local computer.

	.PARAMETER Hive
	   	The HKEY to open, from the RegistryHive enumeration. The default is 'LocalMachine'.
	   	Possible values:
	   	
		- ClassesRoot
		- CurrentUser
		- LocalMachine
		- Users
		- PerformanceData
		- CurrentConfig
		- DynData	   	

	.PARAMETER Key
	       The path of the registry key to open.  

	.PARAMETER Value
	       The name of the registry value.

	.PARAMETER ExpandEnvironmentNames
	      Expands values containing references to environment variables using data from the local environment.

	.PARAMETER Ping
	       Use ping to test if the machine is available before connecting to it. 
	       If the machine is not responding to the test a warning message is output.

	.EXAMPLE
		$Key = "SOFTWARE\Microsoft\Windows\CurrentVersion"
		Get-RegExpandString -Key $Key -Value ProgramFilesPath

		ComputerName Hive            Key                  Value             Data            Type
		------------ ----            ---                  -----             ----            ----
		COMPUTER1    LocalMachine    SOFTWARE\Microsof... ProgramFilesPath  %ProgramFiles%  ExpandString
		

		Description
		-----------
		The command gets the registry ProgramFilesPath ExpandString value from the local computer. 
		The returned value contains unexpanded references to environment variables.
		
	.EXAMPLE
		Get-RegExpandString -Key $Key -Value ProgramFilesPath -ComputerName SERVER1,SERVER2,SERVER3 -ExpandEnvironmentNames -Ping

		ComputerName Hive            Key                  Value             Data              Type
		------------ ----            ---                  -----             ----              ----
		SERVER1      LocalMachine    SOFTWARE\Microsof... ProgramFilesPath  C:\Program Files  ExpandString
		SERVER2      LocalMachine    SOFTWARE\Microsof... ProgramFilesPath  C:\Program Files  ExpandString
		SERVER3      LocalMachine    SOFTWARE\Microsof... ProgramFilesPath  C:\Program Files  ExpandString
		
		
		Description
		-----------
		The command gets the registry ProgramFilesPath ExpandString value from three remote computers. 
		When the ExpandEnvironmentNames Switch parameter is used, the data of the value is expnaded based on the environment variables data from the local environment.
		When the Switch parameter Ping is specified the command issues a ping test to each computer. 
		If the computer is not responding to the ping request a warning message is written to the console and the computer is not processed.

	.OUTPUTS
		PSFanatic.Registry.RegistryValue (PSCustomObject)

	.NOTES
		Author: Shay Levy
		Blog  : http://blogs.microsoft.co.il/blogs/ScriptFanatic/

	.LINK
		http://code.msdn.microsoft.com/PSRemoteRegistry

	.LINK
		Set-RegExpandString
		Get-RegValue
		Remove-RegValue
		Test-RegValue

	#>
	
	
	[OutputType('PSFanatic.Registry.RegistryValue')]
	[CmdletBinding(DefaultParameterSetName="__AllParameterSets")]
	
	param( 
		[Parameter(
			Position=0,
			ValueFromPipeline=$true,
			ValueFromPipelineByPropertyName=$true,
			HelpMessage="An array of computer names. The default is the local computer."
		)]		
		[Alias("CN","__SERVER","IPAddress")]
		[string[]]$ComputerName="",		
		
		[Parameter(
			Position=1,
			ValueFromPipelineByPropertyName=$true,
			HelpMessage="The HKEY to open, from the RegistryHive enumeration. The default is 'LocalMachine'."
		)]
		[ValidateSet("ClassesRoot","CurrentUser","LocalMachine","Users","PerformanceData","CurrentConfig","DynData")]
		[string]$Hive="LocalMachine",
		
		[Parameter(
			Mandatory=$true,
			Position=2,
			ValueFromPipelineByPropertyName=$true,
			HelpMessage="The path of the subkey to open."
		)]
		[Alias("RegKey")]
		[string]$Key,

		[Parameter(
			Mandatory=$true,
			Position=3,
			ValueFromPipelineByPropertyName=$true,
			HelpMessage="The name of the value to get."
		)]
		[string]$Value,
		
		[switch]$ExpandEnvironmentNames,
		
		[switch]$Ping
	) 
	

	process {
		Write-Verbose "Enter process block..."
		
		foreach($c in $ComputerName) {	
			try {				
				if($c -eq "") {
					$c=$env:COMPUTERNAME
					Write-Verbose "Parameter [ComputerName] is not present, setting its value to local computer name: [$c]."					
				}# end if
				
				if($Ping) {
					Write-Verbose "Parameter [Ping] is present, initiating Ping test"
					
					if( !(Test-Connection -ComputerName $c -Count 1 -Quiet)) {
						Write-Warning "[$c] doesn't respond to ping."
						return
					}# end if
				}# end if

				
				Write-Verbose "Starting remote registry connection against: [$c]."
				Write-Verbose "Registry Hive is: [$Hive]."
				$reg = [Microsoft.Win32.RegistryKey]::OpenRemoteBaseKey([Microsoft.Win32.RegistryHive]$Hive,$c)		
				
				Write-Verbose "Open remote subkey: [$Key]"
				$subKey = $reg.OpenSubKey($Key)	

				if(!$subKey) {
					Throw "Key '$Key' doesn't exist."
				}# end if
				
				if($ExpandEnvironmentNames) {
					Write-Verbose "Parameter [ExpandEnvironmentNames] is present, expanding value of environamnt strings."
					Write-Verbose "Get value name : [$Value]"
					$rv = $subKey.GetValue($Value,-1)
				}
				else {
					Write-Verbose "Parameter [ExpandEnvironmentNames] is not present, environamnt strings are not expanded."
					Write-Verbose "Get value name : [$Value]"
					$rv = $subKey.GetValue($Value,-1,[Microsoft.Win32.RegistryValueOptions]::DoNotExpandEnvironmentNames)
				}# end if
				
				if($rv -eq -1) {
					Write-Error "Cannot find value [$Value] because it does not exist."
				}
				else {
					Write-Verbose "Create PSFanatic registry value custom object."
					$pso = New-Object PSObject -Property @{
						ComputerName=$c
						Hive=$Hive
						Value=$Value
						Key=$Key
						Data=$rv
						Type=$subKey.GetValueKind($Value)
					}

					Write-Verbose "Adding format type name to custom object."
					$pso.PSTypeNames.Clear()
					$pso.PSTypeNames.Add('PSFanatic.Registry.RegistryValue')
					$pso
				}# end if

				Write-Verbose "Closing remote registry connection on: [$c]."
				$subKey.close()
			}# end try
			
			catch {
				Write-Error $_
			}# end catch
		}# end foreach
		
		Write-Verbose "Exit process block..."
	}# end process
	
# end function Get-RegExpandString
}



function Get-RegKey {

	<#
	.SYNOPSIS
	       Gets the registry keys on local or remote computers.

	.DESCRIPTION
	       Use Get-RegKey to get registry keys on local or remote computers
	       
	.PARAMETER ComputerName
	    	An array of computer names. The default is the local computer.

	.PARAMETER Hive
	   	The HKEY to open, from the RegistryHive enumeration. The default is 'LocalMachine'.
	   	Possible values:
	   	
		- ClassesRoot
		- CurrentUser
		- LocalMachine
		- Users
		- PerformanceData
		- CurrentConfig
		- DynData	   	

	.PARAMETER Key
	       The path of the registry key to open.  

	.PARAMETER Name
	       The name of the registry key, Wildcards are permitted.
		
	.PARAMETER Recurse
	   	Gets the registry values of the specified registry key and its sub keys.

	.PARAMETER Ping
	       Use ping to test if the machine is available before connecting to it. 
	       If the machine is not responding to the test a warning message is output.
      		
	.EXAMPLE	   
		Get-RegKey -Key SOFTWARE\Microsoft\PowerShell\1 -Name p* 

		ComputerName Hive         Key                                                      SubKeyCount ValueCount
		------------ ----         ---                                                      ----------- ----------
		COMPUTER1    LocalMachine SOFTWARE\Microsoft\PowerShell\1\PowerShellEngine         0           6
		COMPUTER1    LocalMachine SOFTWARE\Microsoft\PowerShell\1\PowerShellSnapIns        5           0
		COMPUTER1    LocalMachine SOFTWARE\Microsoft\PowerShell\1\PSConfigurationProviders 1           0

	   	
	   	Description
	   	-----------
	   	Gets all keys from the PowerShell subkey on the local computer with names starts with the letter 'p'.

	.EXAMPLE
		Get-RegKey -Key SOFTWARE\Microsoft\PowerShell\1 -Name p* -Recurse

		ComputerName Hive         Key                                                            SubKeyCount ValueCount
		------------ ----         ---                                                            ----------- ----------
		COMPUTER1    LocalMachine SOFTWARE\Microsoft\PowerShell\1\PowerShellEngine               0           6
		COMPUTER1    LocalMachine SOFTWARE\Microsoft\PowerShell\1\PowerShellSnapIns              5           0
		COMPUTER1    LocalMachine SOFTWARE\Microsoft\PowerShell\1\PowerShellSnapIns\PowerGUI_Pro 0           7
		COMPUTER1    LocalMachine SOFTWARE\Microsoft\PowerShell\1\PSConfigurationProviders       1           0

	   	Description
	   	-----------
	   	Gets all keys and subkeys from the PowerShell subkey on the local computer with names starts with the letter 'p'.

	.EXAMPLE
		Get-RegKey -ComputerName SERVER1 -Key SOFTWARE\Microsoft\PowerShell\1 -Name p* | Get-RegValue

		ComputerName Hive            Key                  Value                     Data                 Type
		------------ ----            ---                  -----                     ----                 ----
		SERVER1      LocalMachine    SOFTWARE\Microsof... ApplicationBase           C:\Windows\System... String
		SERVER1      LocalMachine    SOFTWARE\Microsof... PSCompatibleVersion       1.0, 2.0             String
		SERVER1      LocalMachine    SOFTWARE\Microsof... RuntimeVersion            v2.0.50727           String
		SERVER1      LocalMachine    SOFTWARE\Microsof... ConsoleHostAssemblyName   Microsoft.PowerSh... String
		SERVER1      LocalMachine    SOFTWARE\Microsof... ConsoleHostModuleName     C:\Windows\System... String
		SERVER1      LocalMachine    SOFTWARE\Microsof... PowerShellVersion         2.0                  String

	   	Description
	   	-----------
	   	Gets all keys and subkeys from the PowerShell subkey on the remote server SERVER1 with names starts with the letter 'p'.
	   	Pipe the results to Get-RegValue to get all value types under these keys.

	.OUTPUTS
		PSFanatic.Registry.RegistryKey (PSCustomObject)

	.NOTES
		Author: Shay Levy
		Blog  : http://blogs.microsoft.co.il/blogs/ScriptFanatic/
		
	.LINK
		http://code.msdn.microsoft.com/PSRemoteRegistry

	.LINK
		New-RegKey
		Remove-RegKey
		Test-RegKey

	#>
		

	[OutputType('PSFanatic.Registry.RegistryKey')]
	[CmdletBinding(DefaultParameterSetName="__AllParameterSets")]
	
	param( 
		[Parameter(
			Position=0,
			ValueFromPipeline=$true,
			ValueFromPipelineByPropertyName=$true
		)]		
		[Alias("CN","__SERVER","IPAddress")]
		[string[]]$ComputerName="",		

		[Parameter(
			Position=1,
			ValueFromPipelineByPropertyName=$true,
			HelpMessage="The HKEY to open, from the RegistryHive enumeration. The default is 'LocalMachine'."
		)]
		[ValidateSet("ClassesRoot","CurrentUser","LocalMachine","Users","PerformanceData","CurrentConfig","DynData")]
		[string]$Hive="LocalMachine",

		[Parameter(
			Mandatory=$true,
			Position=2,
			ValueFromPipelineByPropertyName=$true,
			HelpMessage="The path of the subkey to open."
		)]
		[Alias("RegKey")]
		[string]$Key,
		
		[Parameter(
			Mandatory=$false,
			Position=3,
			ValueFromPipelineByPropertyName=$true,
			HelpMessage="The name of the value to set."
		)]	
		[string]$Name="*",		
	
		[switch]$Ping,
		
		[switch]$Recurse
	) 

	begin {
		Write-Verbose "Enter begin block..."
	
		function Recurse($Key) {
		
			Write-Verbose "Start recursing, key is [$Key]"

			try {
			
				$subKey = $reg.OpenSubKey($key)
				
				if(!$subKey) {
					Throw "Key '$Key' doesn't exist."
				}# end if
				
			
				foreach ($k in $subKey.GetSubKeyNames()) {							
					if($k -like $Name) {
						$child = $subKey.OpenSubKey($k)
						$pso = New-Object PSObject -Property @{
							ComputerName=$c
							Hive=$Hive
							Key="$Key\$k"								
							ValueCount=$child.ValueCount
							SubKeyCount=$child.SubKeyCount
						}

						Write-Verbose "Recurse: Adding format type name to custom object."
						$pso.PSTypeNames.Clear()
						$pso.PSTypeNames.Add('PSFanatic.Registry.RegistryKey')
						$pso
					}# end if
						
					Recurse "$Key\$k"		
				}# end foreach
				
			}# end try
			
			catch {
				Write-Error $_
			}# end catch
			
			Write-Verbose "Ending recurse, key is [$Key]"
			
		# end function Recurse
		}
		
		Write-Verbose "Exit begin block..."
	}# end begin
	

	process	{
		Write-Verbose "Enter process block..."
		
		foreach($c in $ComputerName) {	
			try {				
				if($c -eq "") {
					$c=$env:COMPUTERNAME
					Write-Verbose "Parameter [ComputerName] is not present, setting its value to local computer name: [$c]."
					
				}# end if
				
				if($Ping) {
					Write-Verbose "Parameter [Ping] is present, initiating Ping test"
					
					if( !(Test-Connection -ComputerName $c -Count 1 -Quiet)) {
						Write-Warning "[$c] doesn't respond to ping."
						return
					}# end if
				}# end if
				
				
				Write-Verbose "Starting remote registry connection against: [$c]."
				Write-Verbose "Registry Hive is: [$Hive]."
				$reg = [Microsoft.Win32.RegistryKey]::OpenRemoteBaseKey([Microsoft.Win32.RegistryHive]$Hive,$c)		
	
								
				if($Recurse) {
					Write-Verbose "Parameter [Recurse] is present, calling Recurse function."
					Recurse $Key
				}
				else {					
					Write-Verbose "Open remote subkey: [$Key]."			
					$subKey = $reg.OpenSubKey($Key)
					
					if(!$subKey) {
						Throw "Key '$Key' doesn't exist."
					}# end if
					
					Write-Verbose "Start get remote subkey: [$Key] keys."
					foreach ($k in $subKey.GetSubKeyNames()) {
						if($k -like $Name) {						
							$child = $subKey.OpenSubKey($k)
							$pso = New-Object PSObject -Property @{
								ComputerName=$c
								Hive=$Hive
								Key="$Key\$k"								
								ValueCount=$child.ValueCount
								SubKeyCount=$child.SubKeyCount
							}

							Write-Verbose "Recurse: Adding format type name to custom object."
							$pso.PSTypeNames.Clear()
							$pso.PSTypeNames.Add('PSFanatic.Registry.RegistryKey')
							$pso
						}# end if
					}# end foreach	
				}# end if
				
				Write-Verbose "Closing remote registry connection on: [$c]."
				$reg.close()
			}# end try
			
			catch {
				Write-Error $_
			}# end catch
		}# end foreach 
	
		Write-Verbose "Exit process block..."
	}# end process
	
# end function Get-RegKey
}



function Get-RegMultiString {

	<#
	.SYNOPSIS
	       Retrieves an array of null-terminated strings (REG_MULTI_SZ) from local or remote computers.

	.DESCRIPTION
	       Use Get-RegMultiString to retrieve an array of null-terminated strings (REG_MULTI_SZ) from local or remote computers.
	       
	.PARAMETER ComputerName
	    	An array of computer names. The default is the local computer.

	.PARAMETER Hive
	   	The HKEY to open, from the RegistryHive enumeration. The default is 'LocalMachine'.
	   	Possible values:
	   	
		- ClassesRoot
		- CurrentUser
		- LocalMachine
		- Users
		- PerformanceData
		- CurrentConfig
		- DynData	   	

	.PARAMETER Key
	       The path of the registry key to open.  

	.PARAMETER Value
	       The name of the registry value.

	.PARAMETER Ping
	       Use ping to test if the machine is available before connecting to it. 
	       If the machine is not responding to the test a warning message is output.


	.EXAMPLE	
		$Key = "SYSTEM\CurrentControlSet\services\LanmanServer\Shares"
		Get-RegMultiString -Key $Key -Value Drivers

		ComputerName Hive         Key                                                   Value   Data
		------------ ----         ---                                                   -----   ----
		COMPUTER1    LocalMachine SYSTEM\CurrentControlSet\services\LanmanServer\Shares Drivers {CSCFlags=0, MaxUses=429496729...


		Description
		-----------
		The command gets the flags of the Drivers system shared folder from the local computer.
		The name of ComputerName parameter, which is optional, is omitted.		
		
	.EXAMPLE	
		"DC1","DC2" | Get-RegString -Key $Key -Value Sysvol -Ping
		
		ComputerName Hive         Key                                                   Value  Data
		------------ ----         ---                                                   -----  ----
		DC1          LocalMachine SYSTEM\CurrentControlSet\services\LanmanServer\Shares Sysvol {CSCFlags=256, MaxUses=429496...
		DC2          LocalMachine SYSTEM\CurrentControlSet\services\LanmanServer\Shares Sysvol {CSCFlags=256, MaxUses=429496...

		Description
		-----------
		The command gets the flags of the Sysvol system shared folder from two DC computers. 
		When the Switch parameter Ping is specified the command issues a ping test to each computer. 
		If the computer is not responding to the ping request a warning message is written to the console and the computer is not processed.

	.EXAMPLE	
		Get-Content servers.txt | Get-RegString -Key $Key -Value Sysvol
		
		ComputerName Hive         Key                                                   Value  Data
		------------ ----         ---                                                   -----  ----
		DC1          LocalMachine SYSTEM\CurrentControlSet\services\LanmanServer\Shares Sysvol {CSCFlags=256, MaxUses=429496...
		DC2          LocalMachine SYSTEM\CurrentControlSet\services\LanmanServer\Shares Sysvol {CSCFlags=256, MaxUses=429496...

		Description
		-----------
		The command uses the Get-Content cmdlet to get the DC names from a text file.

	.OUTPUTS
		PSFanatic.Registry.RegistryValue (PSCustomObject)

	.NOTES
		Author: Shay Levy
		Blog  : http://blogs.microsoft.co.il/blogs/ScriptFanatic/
		
	.LINK
		http://code.msdn.microsoft.com/PSRemoteRegistry

	.LINK
		Set-RegMultiString
		Get-RegValue
		Remove-RegValue
		Test-RegValue
	#>
	

	[OutputType('PSFanatic.Registry.RegistryValue')]
	[CmdletBinding(DefaultParameterSetName="__AllParameterSets")]
	
	param( 
		[Parameter(
			Position=0,
			ValueFromPipeline=$true,
			ValueFromPipelineByPropertyName=$true,
			HelpMessage="An array of computer names. The default is the local computer."
		)]		
		[Alias("CN","__SERVER","IPAddress")]
		[string[]]$ComputerName="",		
		
		[Parameter(
			Position=1,
			ValueFromPipelineByPropertyName=$true,
			HelpMessage="The HKEY to open, from the RegistryHive enumeration. The default is 'LocalMachine'."
		)]
		[ValidateSet("ClassesRoot","CurrentUser","LocalMachine","Users","PerformanceData","CurrentConfig","DynData")]
		[string]$Hive="LocalMachine",

		[Parameter(
			Mandatory=$true,
			Position=2,
			ValueFromPipelineByPropertyName=$true,
			HelpMessage="The path of the subkey to open."
		)]
		[Alias("RegKey")]
		[string]$Key,

		[Parameter(
			Mandatory=$true,
			Position=3,
			ValueFromPipelineByPropertyName=$true,
			HelpMessage="The name of the value to get."
		)]
		[string]$Value,
		
		[switch]$Ping
	) 
	

	process {
		Write-Verbose "Enter process block..."
		
		foreach($c in $ComputerName) {	
			try {				
				if($c -eq "") {
					$c=$env:COMPUTERNAME
					Write-Verbose "Parameter [ComputerName] is not present, setting its value to local computer name: [$c]."
					
				}# end if
				
				if($Ping) {
					Write-Verbose "Parameter [Ping] is present, initiating Ping test"
					
					if( !(Test-Connection -ComputerName $c -Count 1 -Quiet)) {
						Write-Warning "[$c] doesn't respond to ping."
						return
					}# end if
				}# end if

				
				Write-Verbose "Starting remote registry connection against: [$c]."
				Write-Verbose "Registry Hive is: [$Hive]."
				$reg = [Microsoft.Win32.RegistryKey]::OpenRemoteBaseKey([Microsoft.Win32.RegistryHive]$Hive,$c)	
		
				Write-Verbose "Open remote subkey: [$Key]"
				$subKey = $reg.OpenSubKey($Key)	
				
				if(!$subKey) {
					Throw "Key '$Key' doesn't exist."
				}# end if	
				
				Write-Verbose "Get value name : [$Value]"
				$rv = $subKey.GetValue($Value,-1)
				
				if($rv -eq -1) {
					Write-Error "Cannot find value [$Value] because it does not exist."
				}
				else {
					Write-Verbose "Create PSFanatic registry value custom object."
					$pso = New-Object PSObject -Property @{
						ComputerName=$c
						Hive=$Hive
						Value=$Value
						Key=$Key
						Data=$rv
						Type=$subKey.GetValueKind($Value)
					}

					Write-Verbose "Adding format type name to custom object."
					$pso.PSTypeNames.Clear()
					$pso.PSTypeNames.Add('PSFanatic.Registry.RegistryValue')
					$pso
				}# end if
				
				Write-Verbose "Closing remote registry connection on: [$c]."
				$subKey.close()
			}# end try
			
			catch {
				Write-Error $_
			}# end catch
		}# end foreach
		
		Write-Verbose "Exit process block..."
	}# end process
	
# end function Get-RegMultiString
}



function Get-RegQWord {

	<#
	.SYNOPSIS
	      Retrieves a 64-bit binary number registry value (REG_QWORD) from local or remote computers.

	.DESCRIPTION
	       Use Get-RegQWord to retrieve a 64-bit binary number registry value (REG_QWORD) from local or remote computers.
	       
	.PARAMETER ComputerName
	    	An array of computer names. The default is the local computer.

	.PARAMETER Hive
	   	The HKEY to open, from the RegistryHive enumeration. The default is 'LocalMachine'.
	   	Possible values:
	   	
		- ClassesRoot
		- CurrentUser
		- LocalMachine
		- Users
		- PerformanceData
		- CurrentConfig
		- DynData	   	

	.PARAMETER Key
	       The path of the registry key to open.  

	.PARAMETER Value
	       The name of the registry value.

	.PARAMETER AsHex
	       Returnes the value in HEX notation.
	       
	.PARAMETER Ping
	       Use ping to test if the machine is available before connecting to it. 
	       If the machine is not responding to the test a warning message is output.
			
	.EXAMPLE
		$Key = "SOFTWARE\MyCompany"
		Get-RegQWord -ComputerName SERVER1 -Hive LocalMachine -Key $Key -Value SystemLastStartTime

		ComputerName Hive            Key                  Value                Data                Type
		------------ ----            ---                  -----                ----                ----
		SERVER1      LocalMachine    SOFTWARE\MyCompany   SystemLastStartTime  129057765227436584  QWord


		Description
		-----------
	   	The command gets the SystemLastStartTime value from SERVER1 server.	   
	   
	.EXAMPLE	   
		Get-RegQWord -ComputerName SERVER1 -Key $Key -Value QWordValue

		ComputerName Hive            Key                  Value                Data                Type
		------------ ----            ---                  -----                ----                ----
		SERVER1      LocalMachine    SOFTWARE\MyCompany   SystemLastStartTime  129057765227436584  QWord


		Description
		-----------
	   	The command gets the SystemLastStartTime value from SERVER1 server. 
	   	You can omit the -Hive parameter (which is optional), if the registry Hive the key resides in is LocalMachine (HKEY_LOCAL_MACHINE).

	.EXAMPLE
		Get-RegQWord -CN SERVER1,SERVER2 -Key $Key -Value QWordValue -AsHex

		ComputerName Hive            Key                  Value                Data               Type
		------------ ----            ---                  -----                ----               ----
		SERVER1      LocalMachine    SOFTWARE\MyCompany   SystemLastStartTime  0x1ca815a8be31a28  QWord
		SERVER2      LocalMachine    SOFTWARE\MyCompany   SystemLastStartTime  0x1ca815a8be31a28  QWord


		Description
		-----------
	   	This command gets the SystemLastStartTime value from SERVER1 and SERVER2.
	   	The command uses the ComputerName parameter alias 'CN' to specify a collection of computer names. 
	   	When the AsHex Switch Parameter is used, the value's data returnes in HEX notation.

	.OUTPUTS
		PSFanatic.Registry.RegistryValue (PSCustomObject)

	.NOTES
		Author: Shay Levy
		Blog  : http://blogs.microsoft.co.il/blogs/ScriptFanatic/

	.LINK
		http://code.msdn.microsoft.com/PSRemoteRegistry
	
	.LINK
		Set-RegQWord
		Get-RegValue
		Remove-RegValue
		Test-RegValue
	#>
	
	
	[OutputType('PSFanatic.Registry.RegistryValue')]
	[CmdletBinding(DefaultParameterSetName="__AllParameterSets")]
	
	param( 
		[Parameter(
			Position=0,
			ValueFromPipeline=$true,
			ValueFromPipelineByPropertyName=$true,
			HelpMessage="An array of computer names. The default is the local computer."
		)]		
		[Alias("CN","__SERVER","IPAddress")]
		[string[]]$ComputerName="",		
		
		[Parameter(
			Position=1,
			ValueFromPipelineByPropertyName=$true,
			HelpMessage="The HKEY to open, from the RegistryHive enumeration. The default is 'LocalMachine'."
		)]
		[ValidateSet("ClassesRoot","CurrentUser","LocalMachine","Users","PerformanceData","CurrentConfig","DynData")]
		[string]$Hive="LocalMachine",
		
		[Parameter(
			Mandatory=$true,
			Position=2,
			ValueFromPipelineByPropertyName=$true,
			HelpMessage="The path of the subkey to open."
		)]
		[Alias("RegKey")]
		[string]$Key,

		[Parameter(
			Mandatory=$true,
			Position=3,
			ValueFromPipelineByPropertyName=$true,
			HelpMessage="The name of the value to get."
		)]
		[string]$Value,
		
		[switch]$AsHex,
		
		[switch]$Ping
	) 
	
	process {
		Write-Verbose "Enter process block..."
		
		foreach($c in $ComputerName) {	
			try {				
				if($c -eq "") {
					$c=$env:COMPUTERNAME
					Write-Verbose "Parameter [ComputerName] is not present, setting its value to local computer name: [$c]."
					
				}# end if
				
				if($Ping) {
					Write-Verbose "Parameter [Ping] is present, initiating Ping test"
					
					if( !(Test-Connection -ComputerName $c -Count 1 -Quiet)) {
						Write-Warning "[$c] doesn't respond to ping."
						return
					}# end if
				}# end if

				
				Write-Verbose "Starting remote registry connection against: [$c]."
				Write-Verbose "Registry Hive is: [$Hive]."
				$reg = [Microsoft.Win32.RegistryKey]::OpenRemoteBaseKey([Microsoft.Win32.RegistryHive]$Hive,$c)		
				
				Write-Verbose "Open remote subkey: [$Key]"
				$subKey = $reg.OpenSubKey($Key)
				
				if(!$subKey) {
					Throw "Key '$Key' doesn't exist."
				}# end if	
				
				Write-Verbose "Get value name : [$Value]"
				$rv = $subKey.GetValue($Value,-1)
				
				if($rv -eq -1) {
					Write-Error "Cannot find value [$Value] because it does not exist."
				}
				else {
					if($AsHex) {
						Write-Verbose "Parameter [AsHex] is present, return value as HEX."
						$rv = "0x{0:x}" -f $rv
					}
					else {
						Write-Verbose "Parameter [AsHex] is not present, return value as INT."
					}# end if

					Write-Verbose "Create PSFanatic registry value custom object."
					$pso = New-Object PSObject -Property @{
						ComputerName=$c
						Hive=$Hive
						Value=$Value
						Key=$Key
						Data=$rv
						Type=$subKey.GetValueKind($Value)
					}

					Write-Verbose "Adding format type name to custom object."
					$pso.PSTypeNames.Clear()
					$pso.PSTypeNames.Add('PSFanatic.Registry.RegistryValue')
					$pso
				}# end if

				Write-Verbose "Closing remote registry connection on: [$c]."
				$subKey.close()
			}# end try
			
			catch {
				Write-Error $_
			}# end catch
		}# end foreach 
		
		Write-Verbose "Exit process block..."
	}# end process
	
# end function Get-RegQWord
}



function Get-RegString {

	<#
	.SYNOPSIS
		Retrieves a registry string (REG_SZ) value from local or remote computers.

	.DESCRIPTION
		Use Get-RegString to retrieve a registry string (REG_SZ) value from local or remote computers.
	       
	.PARAMETER ComputerName
	    	An array of computer names. The default is the local computer.

	.PARAMETER Hive
		The HKEY to open, from the RegistryHive enumeration. The default is 'LocalMachine'.
	   	Possible values:
	   	
		- ClassesRoot
		- CurrentUser
		- LocalMachine
		- Users
		- PerformanceData
		- CurrentConfig
		- DynData	   	

	.PARAMETER Key
	       The path of the registry key to open.  

	.PARAMETER Value
	       The name of the registry value.

	.PARAMETER Ping
	       Use ping to test if the machine is available before connecting to it. 
	       If the machine is not responding to the test a warning message is output.
	       
	.EXAMPLE	  
		Get-RegString -Hive LocalMachine -Key SOFTWARE\Microsoft\DataAccess -Value FullInstallVer

		ComputerName Hive         Key                           Value          Data           Type
		------------ ----         ---                           -----          ----           ----
		COMPUTER1    LocalMachine SOFTWARE\Microsoft\DataAccess FullInstallVer 6.1.7600.16385 String
		
		
		Description
		-----------
		The command gets the installed version of Microsoft Data Access Components (MDAC) from the local computer.
		The name of ComputerName parameter, which is optional, is omitted.		
		
	.EXAMPLE	
		"SERVER1","SERVER2","SERVER3" | Get-RegString -Key SOFTWARE\Microsoft\DataAccess -Value FullInstallVer -Ping
		
		ComputerName Hive         Key                           Value          Data        Type
		------------ ----         ---                           -----          ----        ----
		SERVER1      LocalMachine SOFTWARE\Microsoft\DataAccess FullInstallVer 2.82.3959.0 String
		SERVER2      LocalMachine SOFTWARE\Microsoft\DataAccess FullInstallVer 2.82.3959.0 String
		SERVER3      LocalMachine SOFTWARE\Microsoft\DataAccess FullInstallVer 2.82.1830.0 String

		Description
		-----------
		The command gets the installed version of Microsoft Data Access Components (MDAC) from remote computers. 
		When the Switch parameter Ping is specified the command issues a ping test to each computer. 
		If the computer is not responding to the ping request a warning message is written to the console and the computer is not processed.

	.EXAMPLE	
		Get-Content servers.txt | Get-RegString -Key SOFTWARE\Microsoft\DataAccess -Value FullInstallVer
		
		ComputerName Hive         Key                           Value          Data        Type
		------------ ----         ---                           -----          ----        ----
		SERVER1      LocalMachine SOFTWARE\Microsoft\DataAccess FullInstallVer 2.82.3959.0 String
		SERVER2      LocalMachine SOFTWARE\Microsoft\DataAccess FullInstallVer 2.82.3959.0 String
		SERVER3      LocalMachine SOFTWARE\Microsoft\DataAccess FullInstallVer 2.82.1830.0 String

		Description
		-----------
		The command uses the Get-Content cmdlet to get the server names from a text file.

	.EXAMPLE	
		Get-RegString -Hive LocalMachine -Key SOFTWARE\Microsoft\DataAccess -Value FullInstallVer | Test-RegValue -ComputerName SERVER1,SERVER2 -Ping
		True
		True

		Description
		-----------
		This command gets the installed version of Microsoft Data Access Components (MDAC) from the local computer.
		The output is piped to the Test-RegValue function to check if the value exists on two remote computers.
		When the Switch parameter Ping is specified the command issues a ping test to each computer. 
		If the computer is not responding to the ping request a warning message is written to the console and the computer is not processed.		

	.OUTPUTS
		PSFanatic.Registry.RegistryValue (PSCustomObject)

	.NOTES
		Author: Shay Levy
		Blog  : http://blogs.microsoft.co.il/blogs/ScriptFanatic/

	.LINK
		http://code.msdn.microsoft.com/PSRemoteRegistry

	.LINK
		Set-RegString
		Get-RegValue
		Remove-RegValue
		Test-RegValue
	#>
	
	[OutputType('PSFanatic.Registry.RegistryValue')]
	[CmdletBinding(DefaultParameterSetName="__AllParameterSets")]
	
	param( 
		[Parameter(
			Position=0,
			ValueFromPipeline=$true,
			ValueFromPipelineByPropertyName=$true,
			HelpMessage="An array of computer names. The default is the local computer."
		)]		
		[Alias("CN","__SERVER","IPAddress")]
		[string[]]$ComputerName="",		
		
		[Parameter(
			Position=1,
			ValueFromPipelineByPropertyName=$true,
			HelpMessage="The HKEY to open, from the RegistryHive enumeration. The default is 'LocalMachine'."
		)]
		[ValidateSet("ClassesRoot","CurrentUser","LocalMachine","Users","PerformanceData","CurrentConfig","DynData")]
		[string]$Hive="LocalMachine",
		
		[Parameter(
			Mandatory=$true,
			Position=2,
			ValueFromPipelineByPropertyName=$true,
			HelpMessage="The path of the subkey to open."
		)]
		[Alias("RegKey")]
		[string]$Key,

		[Parameter(
			Mandatory=$true,
			Position=3,
			ValueFromPipelineByPropertyName=$true,
			HelpMessage="The name of the value to get."
		)]
		[string]$Value,
		
		[switch]$Ping
	) 
	

	process {
		Write-Verbose "Enter process block..."
	    	
	    foreach($c in $ComputerName) {	
			try {				
				if($c -eq "") {
					$c=$env:COMPUTERNAME
					Write-Verbose "Parameter [ComputerName] is not present, setting its value to local computer name: [$c]."
					
				}# end if
				
				if($Ping) {
					Write-Verbose "Parameter [Ping] is present, initiating Ping test"
					
					if( !(Test-Connection -ComputerName $c -Count 1 -Quiet)) {
						Write-Warning "[$c] doesn't respond to ping."
						return
					}# end if
				}# end if

				
				Write-Verbose "Starting remote registry connection against: [$c]."
				Write-Verbose "Registry Hive is: [$Hive]."
				$reg = [Microsoft.Win32.RegistryKey]::OpenRemoteBaseKey([Microsoft.Win32.RegistryHive]$Hive,$c)		
				
				Write-Verbose "Open remote subkey: [$Key]"
				$subKey = $reg.OpenSubKey($Key)
				
				if(!$subKey) {
					Throw "Key '$Key' doesn't exist."
				}# end if	
				
				Write-Verbose "Get value name : [$Value]"
				$rv = $subKey.GetValue($Value,-1)
				
				if($rv -eq -1) {
					Write-Error "Cannot find value [$Value] because it does not exist."
				}
				else {
					Write-Verbose "Create PSFanatic registry value custom object."
					
					$pso = New-Object PSObject -Property @{
						ComputerName=$c
						Hive=$Hive
						Value=$Value
						Key=$Key
						Data=$rv
						Type=$subKey.GetValueKind($Value)
					}

					Write-Verbose "Adding format type name to custom object."
					$pso.PSTypeNames.Clear()
					$pso.PSTypeNames.Add('PSFanatic.Registry.RegistryValue')
					$pso
				}# end if
				
				Write-Verbose "Closing remote registry connection on: [$c]."
				$subKey.close()
			}# end try
			
			catch {
				Write-Error $_
			}# end catch
		}# end foreach
		
		Write-Verbose "Exit process block..."
	}# end process
	
# end function Get-RegString
}



function Get-RegValue {

	<#
	.SYNOPSIS
	       Sets the default value (REG_SZ) of the registry key on local or remote computers.

	.DESCRIPTION
	       Use Get-RegValue to set the default value (REG_SZ) of the registry key on local or remote computers.
	       
	.PARAMETER ComputerName
	    	An array of computer names. The default is the local computer.

	.PARAMETER Hive
	   	The HKEY to open, from the RegistryHive enumeration. The default is 'LocalMachine'.
	   	Possible values:
	   	
		- ClassesRoot
		- CurrentUser
		- LocalMachine
		- Users
		- PerformanceData
		- CurrentConfig
		- DynData	   	

	.PARAMETER Key
	       The path of the registry key to open.  

	.PARAMETER Value
	       The name of the registry value, Wildcards are permitted.

	   .PARAMETER Type

	   	A collection of data types of registry values, from the RegistryValueKind enumeration.
	   	Possible values:

		- Binary
		- DWord
		- ExpandString
		- MultiString
		- QWord
		- String
		
		When the parameter is not specified all types are returned, Wildcards are permitted.
		
	   .PARAMETER Recurse
	   	Gets the registry values of the specified registry key and its sub keys.

	.PARAMETER Ping
	       Use ping to test if the machine is available before connecting to it. 
	       If the machine is not responding to the test a warning message is output.
       		
	.EXAMPLE	   
		Get-RegValue -Key SOFTWARE\Microsoft\PowerShell\1 -Recurse

		ComputerName Hive            Key                  Value                     Data                 Type
		------------ ----            ---                  -----                     ----                 ----
		COMPUTER1    LocalMachine    SOFTWARE\Microsof... Install                   1                    DWord
		COMPUTER1    LocalMachine    SOFTWARE\Microsof... PID                       89383-100-0001260... String
		COMPUTER1    LocalMachine    SOFTWARE\Microsof... Install                   1                    DWord
		COMPUTER1    LocalMachine    SOFTWARE\Microsof... ApplicationBase           C:\Windows\System... String
		COMPUTER1    LocalMachine    SOFTWARE\Microsof... PSCompatibleVersion       1.0, 2.0             String
		COMPUTER1    LocalMachine    SOFTWARE\Microsof... RuntimeVersion            v2.0.50727           String
		(...)
		
		
		Description
		-----------
		Gets all values of the PowerShell subkey on the local computer regardless of their type.		

	.EXAMPLE
		"SERVER1" | Get-RegValue -Key SOFTWARE\Microsoft\PowerShell\1 -Type String,DWord -Recurse -Ping

		ComputerName Hive            Key                  Value                     Data                 Type
		------------ ----            ---                  -----                     ----                 ----
		SERVER1      LocalMachine    SOFTWARE\Microsof... Install                   1                    DWord
		SERVER1      LocalMachine    SOFTWARE\Microsof... PID                       89383-100-0001260... String
		SERVER1      LocalMachine    SOFTWARE\Microsof... Install                   1                    DWord
		SERVER1      LocalMachine    SOFTWARE\Microsof... ApplicationBase           C:\Windows\System... String
		SERVER1      LocalMachine    SOFTWARE\Microsof... PSCompatibleVersion       1.0, 2.0             String
		(...)
	
		Description
		-----------
		Gets all String and DWord values of the PowerShell subkey and its subkeys from remote computer SERVER1, ping the remote server first.				

	.EXAMPLE
		Get-RegValue -ComputerName SERVER1 -Key SOFTWARE\Microsoft\PowerShell -Type MultiString -Value t* -Recurse

		ComputerName Hive            Key                  Value  Data                 Type
		------------ ----            ---                  -----  ----                 ----
		SERVER1      LocalMachine    SOFTWARE\Microsof... Types  {virtualmachinema... MultiString
		SERVER1      LocalMachine    SOFTWARE\Microsof... Types  {C:\Program Files... MultiString

		Description
		-----------
		Gets all MultiString value names, from the subkey and its subkeys, that starts with the 't' letter from remote computer SERVER1.				

	.OUTPUTS
		System.Boolean
		PSFanatic.Registry.RegistryValue (PSCustomObject)

	.NOTES
		Author: Shay Levy
		Blog  : http://blogs.microsoft.co.il/blogs/ScriptFanatic/
	
	.LINK
		http://code.msdn.microsoft.com/PSRemoteRegistry

	.LINK
		Set-RegValue
		Test-RegValue
		Remove-RegValue	

	#>	
	

	[OutputType('System.Boolean','PSFanatic.Registry.RegistryValue')]
	[CmdletBinding(DefaultParameterSetName="__AllParameterSets")]
	
	param( 
		[Parameter(
			Position=0,
			ValueFromPipeline=$true,
			ValueFromPipelineByPropertyName=$true
		)]		
		[Alias("CN","__SERVER","IPAddress")]
		[string[]]$ComputerName="",		

		[Parameter(
			Position=1,
			ValueFromPipelineByPropertyName=$true,
			HelpMessage="The HKEY to open, from the RegistryHive enumeration. The default is 'LocalMachine'."
		)]
		[ValidateSet("ClassesRoot","CurrentUser","LocalMachine","Users","PerformanceData","CurrentConfig","DynData")]
		[string]$Hive="LocalMachine",

		[Parameter(
			Mandatory=$true,
			Position=2,
			ValueFromPipelineByPropertyName=$true,
			HelpMessage="The path of the subkey to open."
		)]
		[Alias("RegKey")]
		[string]$Key,
		
		[Parameter(
			Mandatory=$false,
			Position=3,
			ValueFromPipelineByPropertyName=$true,
			HelpMessage="The name of the value to set."
		)]	
		[string]$Value="*",		

		[Parameter(
			Mandatory=$false,
			Position=4,
			ValueFromPipelineByPropertyName=$true,
			HelpMessage="The data type of the registry value."
		)]
		[ValidateSet("String","ExpandString","Binary","DWord","MultiString","QWord")]
		[string[]]$Type="*",
		
		[switch]$Ping,
		
		[switch]$Recurse
	) 

	begin {
		Write-Verbose "Enter begin block..."
	
		function Recurse($Key){
			Write-Verbose "Start recursing, key is [$Key]"

			try {
				$subKey = $reg.OpenSubKey($key)
				
				if(!$subKey) {
					Throw "Key '$Key' doesn't exist."
				}# end if
				

				foreach ($v in $subKey.GetValueNames()) {
					$vk = $subKey.GetValueKind($v)
					
					foreach($t in $Type) {	
						if($v -like $Value -AND $vk -like $t) {						
							$pso = New-Object PSObject -Property @{
								ComputerName=$c
								Hive=$Hive
								Value=if(!$v) {"(Default)"} else {$v}
								Key=$Key
								Data=$subKey.GetValue($v)
								Type=$vk
							}

							Write-Verbose "Recurse: Adding format type name to custom object."
							$pso.PSTypeNames.Clear()
							$pso.PSTypeNames.Add('PSFanatic.Registry.RegistryValue')
							$pso
						}# end if
					}# end foreach
				}# end foreach
				
				foreach ($k in $subKey.GetSubKeyNames()) {
					Recurse "$Key\$k"		
				}# end foreach
				
			}# end try
			
			catch {
				Write-Error $_
			}# end catch
			
			Write-Verbose "Ending recurse, key is [$Key]"
		}# end function
		
		Write-Verbose "Exit begin block..."
	}# end begin
	

	process	{
		Write-Verbose "Enter process block..."
		
		foreach($c in $ComputerName) {	
			try {				
				if($c -eq "") {
					$c=$env:COMPUTERNAME
					Write-Verbose "Parameter [ComputerName] is not present, setting its value to local computer name: [$c]."
				}# end if
				
				if($Ping) {
					Write-Verbose "Parameter [Ping] is present, initiating Ping test"
					
					if( !(Test-Connection -ComputerName $c -Count 1 -Quiet)) {
						Write-Warning "[$c] doesn't respond to ping."
						return
					}# end if
				}# end if
				
				Write-Verbose "Starting remote registry connection against: [$c]."
				Write-Verbose "Registry Hive is: [$Hive]."
				$reg = [Microsoft.Win32.RegistryKey]::OpenRemoteBaseKey([Microsoft.Win32.RegistryHive]$Hive,$c)		
	
								
				if($Recurse) {
					Write-Verbose "Parameter [Recurse] is present, calling Recurse function."
					Recurse $Key
				}
				else {
					Write-Verbose "Open remote subkey: [$Key]."			
					$subKey = $reg.OpenSubKey($Key)
					
					if(!$subKey) {
						Throw "Key '$Key' doesn't exist."
					}# end if
					
					Write-Verbose "Start get remote subkey: [$Key] values."
					foreach ($v in $subKey.GetValueNames()) {						
						$vk = $subKey.GetValueKind($v)
						
						foreach($t in $Type) {					
							if($v -like $Value -AND $vk -like $t) {														
								$pso = New-Object PSObject -Property @{
									ComputerName=$c
									Hive=$Hive
									Value= if(!$v) {"(Default)"} else {$v}
									Key=$Key
									Data=$subKey.GetValue($v)
									Type=$vk
								}

								Write-Verbose "Adding format type name to custom object."
								$pso.PSTypeNames.Clear()
								$pso.PSTypeNames.Add('PSFanatic.Registry.RegistryValue')
								$pso
							}# end if
						}# end foreach
					}# end foreach		
				}# end if
				
				Write-Verbose "Closing remote registry connection on: [$c]."
				$reg.close()
			}# end try
			
			catch {
				Write-Error $_
			}# end catch
		}# end foreach 
	
		Write-Verbose "Exit process block..."
	}# end process
	
# end function Get-RegValue
}



function New-RegKey {

	<#
	.SYNOPSIS
	       Creates a new registry key on local or remote machines.

	.DESCRIPTION
	       Use New-RegKey to create a new registry key on local or remote machines.
	       
	.PARAMETER ComputerName
	    	An array of computer names. The default is the local computer.

	.PARAMETER Hive
	   	The HKEY to open, from the RegistryHive enumeration. The default is 'LocalMachine'.
	   	Possible values:
	   	
		- ClassesRoot
		- CurrentUser
		- LocalMachine
		- Users
		- PerformanceData
		- CurrentConfig
		- DynData	   	

	.PARAMETER Key
	       The path of the registry key.  

	.PARAMETER Name
	       The name of the new key to create. 

	.PARAMETER Ping
	       Use ping to test if the machine is available before connecting to it. 
	       If the machine is not responding to the test a warning message is output.

	.PARAMETER PassThru
	       Passes the newly custom object to the pipeline. By default, this function does not generate any output.
       		
	.EXAMPLE
		$Key = "SOFTWARE\MyCompany"
		New-RegKey -ComputerName SERVER1,SERVER2 -Key $Key -Name NewSubKey -PassThru

		ComputerName Hive            Key                       SubKeyCount ValueCount
		------------ ----            ---                       ----------- ----------
		SERVER1      LocalMachine    SOFTWARE\MyCompany\New... 0           0		
		SERVER2      LocalMachine    SOFTWARE\MyCompany\New... 0           0		


		Description
		-----------
		The command creates new regitry key on two remote computers. 
		When PassThru is present the command returns the registry key custom object.
		
	.EXAMPLE
		Get-Content servers.txt | New-RegKey -Key $Key -Name NewSubKey -PassThru | Set-RegString -Value TestValue -Data TestData -Force -PassThru

		ComputerName Hive            Key                  Value       Data     Type
		------------ ----            ---                  -----       ----     ----
		SERVER1      LocalMachine    SOFTWARE\MyCompan... TestValue   TestData String
		SERVER2      LocalMachine    SOFTWARE\MyCompan... TestValue   TestData String
		SERVER3      LocalMachine    SOFTWARE\MyCompan... TestValue   TestData String


		Description
		-----------
		The command uses the Get-Content cmdlet to get the server names from a text file. The names are piped into
		New-RegKey which creates the key in the remote computers. 
		The result of New-RegKey is piped into Set-RegString which creates a new String value under the new key and sets its data.

	.OUTPUTS
		PSFanatic.Registry.RegistryKey (PSCustomObject)

	.NOTES
		Author: Shay Levy
		Blog  : http://blogs.microsoft.co.il/blogs/ScriptFanatic/

	.LINK
		http://code.msdn.microsoft.com/PSRemoteRegistry
	.LINK
		Get-RegKey
		Remove-RegKey
		Test-RegKey

	#>


	[OutputType('PSFanatic.Registry.RegistryKey')]
	[CmdletBinding(DefaultParameterSetName="__AllParameterSets")]
	
	param( 
		[Parameter(
			Position=0,
			ValueFromPipeline=$true,
			ValueFromPipelineByPropertyName=$true,
			HelpMessage="An array of computer names. The default is the local computer."
		)]		
		[Alias("CN","__SERVER","IPAddress")]
		[string[]]$ComputerName="",		
		
		[Parameter(
			Position=1,
			ValueFromPipelineByPropertyName=$true,
			HelpMessage="The HKEY to open, from the RegistryHive enumeration. The default is 'LocalMachine'."
		)]
		[ValidateSet("ClassesRoot","CurrentUser","LocalMachine","Users","PerformanceData","CurrentConfig","DynData")]
		[string]$Hive="LocalMachine",
		
		[Parameter(
			Mandatory=$true,
			Position=2,
			ValueFromPipelineByPropertyName=$true,
			HelpMessage="The path of the subkey to open."
		)]
		[Alias("RegKey")]
		[string]$Key,

		[Parameter(Position=3,ValueFromPipelineByPropertyName=$true)]
		[string]$Name,
		
		[switch]$Ping,
		[switch]$PassThru
	) 
	
	begin {
		Write-Verbose "Enter begin block..."
		
		$RegObj = Get-RegPathParts -RegPath $Key
		
		if ($Hive -ne $RegObj.Hive){# Real Hive specified in $Hive
			$_Hive = $Hive
			$_Key = $Key
		}
		else {
			$_Hive = $RegObj.Hive
			$_Key = $RegObj.Key
		}
		
		if (!$Name){
			$_Name = $RegObj.ValueName
		}
		else {
			$_Name = $Name
		}
		
		Write-Verbose "Exit begin block..."
	}# end begin

	process {
		Write-Verbose "Enter process block..."
		
		foreach($c in $ComputerName) {	
			try {				
				if($c -eq "") {
					$c=$env:COMPUTERNAME
					Write-Verbose "Parameter [ComputerName] is not present, setting its value to local computer name: [$c]."
					
				}# end if
				
				if($Ping) {
					Write-Verbose "Parameter [Ping] is present, initiating Ping test"
					
					if( !(Test-Connection -ComputerName $c -Count 1 -Quiet)) {
						Write-Warning "[$c] doesn't respond to ping."
						return
					}# end if
				}# end if

				
				Write-Verbose "Starting remote registry connection against: [$c]."
				Write-Verbose "Registry Hive is: [$_Hive]."
				$reg = [Microsoft.Win32.RegistryKey]::OpenRemoteBaseKey([Microsoft.Win32.RegistryHive]$_Hive,$c)		
				
				Write-Verbose "Open remote subkey: [$_Key] with write access."
				$subKey = $reg.OpenSubKey($_Key,$true)
				
				if(!$subKey) {
					Throw "Key '$_Key' doesn't exist."
				}# end if
				
				
				Write-Verbose "Creating new Key."
				$new = $subKey.CreateSubKey($_Name)	

				if($PassThru) {
					Write-Verbose "Parameter [PassThru] is present, creating PSFanatic registry custom objects."
					Write-Verbose "Create PSFanatic registry key custom object."
					
					$pso = New-Object PSObject -Property @{
						ComputerName=$c
						Hive=$_Hive
						Key="$Key\$_Name"
						Name=$_Name
						SubKeyCount=$new.SubKeyCount
						ValueCount=$new.ValueCount						
					}

					Write-Verbose "Adding format type name to custom object."
					$pso.PSTypeNames.Clear()
					$pso.PSTypeNames.Add('PSFanatic.Registry.RegistryKey')
					$pso				
				}# end if		
					
				Write-Verbose "Closing remote registry connection on: [$c]."
				$subKey.close()
			}# end try
			
			catch {
				Write-Error $_
			}# end catch
		}# end foreach
		
		Write-Verbose "Exit process block..."
	}# end process
	
# end function New-RegKey
}



function Remove-RegKey {

	<#
	.SYNOPSIS
	       Deletes the specified registry key from local or remote computers.

	.DESCRIPTION
	       Use Remove-RegKey to delete the specified registry key from local or remote computers.
	       
	.PARAMETER ComputerName
	    	An array of computer names. The default is the local computer.

	.PARAMETER Hive
	   	The HKEY to open, from the RegistryHive enumeration. The default is 'LocalMachine'.
	   	Possible values:
	   	
		- ClassesRoot
		- CurrentUser
		- LocalMachine
		- Users
		- PerformanceData
		- CurrentConfig
		- DynData	   	

	.PARAMETER Key
	       The path of the registry key to open.  

	.PARAMETER Force
	       Overrides any confirmations made by the command. Even using the Force parameter, the function cannot override security restrictions.

	.PARAMETER Ping
	       Use ping to test if the machine is available before connecting to it. 
	       If the machine is not responding to the test a warning message is output.

	   .PARAMETER Recurse
	       Deletes the specified subkey and any child subkeys recursively.

	.EXAMPLE
		$Key= "SOFTWARE\MyCompany\NewSubKey"
		Test-RegKey -Key $Key -ComputerName SERVER1,SERVER2 -PassThru | Remove-RegKey -Force
		
		Description
		-----------
		The command checks if the NewSubKey key exists on SERVER1 and SERVER2. When using the PassThru parameter, each key, if found, it emitted to the pipeline.
		Each key found that is piped into Remove-RegKey is deleted whether it it empty or has any subkeys or values.		

	.NOTES
		Author: Shay Levy
		Blog  : http://blogs.microsoft.co.il/blogs/ScriptFanatic/
	
	.LINK
		http://code.msdn.microsoft.com/PSRemoteRegistry

	.LINK
		Get-RegKey
		New-RegKey
		Test-RegKey
		
	#>
	

	[CmdletBinding(SupportsShouldProcess=$true,ConfirmImpact='High',DefaultParameterSetName="__AllParameterSets")]
	
	param( 
		[Parameter(
			Position=0,
			ValueFromPipeline=$true,
			ValueFromPipelineByPropertyName=$true,
			HelpMessage="An array of computer names. The default is the local computer."
		)]		
		[Alias("CN","__SERVER","IPAddress")]
		[string[]]$ComputerName="",		
		
		[Parameter(
			Position=1,
			ValueFromPipelineByPropertyName=$true,
			HelpMessage="The HKEY to open, from the RegistryHive enumeration. The default is 'LocalMachine'."
		)]
		[ValidateSet("ClassesRoot","CurrentUser","LocalMachine","Users","PerformanceData","CurrentConfig","DynData")]
		[string]$Hive="LocalMachine",
		
		[Parameter(
			Mandatory=$true,
			Position=2,
			ValueFromPipelineByPropertyName=$true,
			HelpMessage="The path of the subkey to remove."
		)]
		[Alias("RegKey")]
		[string]$Key,
		
		[switch]$Ping,
		[switch]$Force,
		[switch]$Recurse
	) 
	
	begin {
		Write-Verbose "Enter begin block..."
		
		$RegObj = Get-RegPathParts -RegArg $Key
		
		if ($Hive -ne $RegObj.Hive){# Real Hive specified in $Hive
			$_Hive = $Hive
			$_Key = $Key
		}
		else {
			$_Hive = $RegObj.Hive
			$_Key = $RegObj.Key
		}
		
		Write-Verbose "Exit begin block..."
	}# end begin

	
	process {
		Write-Verbose "Enter process block..."
		
		foreach($c in $ComputerName) {	
			try {				
				if($c -eq "") {
					$c=$env:COMPUTERNAME
					Write-Verbose "Parameter [ComputerName] is not present, setting its value to local computer name: [$c]."
					
				}# end if
				
				if($Ping) {
					Write-Verbose "Parameter [Ping] is present, initiating Ping test"
					
					if( !(Test-Connection -ComputerName $c -Count 1 -Quiet)) {
						Write-Warning "[$c] doesn't respond to ping."
						return
					}# end if
				}# end if

				
				Write-Verbose "Starting remote registry connection against: [$c]."
				Write-Verbose "Registry Hive is: [$Hive]."
				$reg = [Microsoft.Win32.RegistryKey]::OpenRemoteBaseKey([Microsoft.Win32.RegistryHive]$_Hive,$c)		
				
				if($Force -or $PSCmdlet.ShouldProcess($c,"Remove Registry Key '$_Hive\$_Key'")) {		

					Write-Verbose "Parameter [Force] or [Confirm:`$False] is present, suppressing confirmations."
					Write-Verbose "Setting value name: [$Value]"

					if($Recurse) {
						Write-Verbose "Parameter [Recurse] is present, deleting key and sub items."
						$reg.DeleteSubKeyTree($_Key)
					}# end if
					else {
						Write-Verbose "Parameter [Recurse] is not present, deleting key."
						$reg.DeleteSubKey($_Key,$True)
					}# end if
				}# end if
				
				Write-Verbose "Closing remote registry connection on: [$c]."
				$reg.close()
			}# end try
			
			catch {
				Write-Error $_
			}# end catch
		}# end foreach
		
		Write-Verbose "Exit process block..."
	}# end process
	
# end function Remove-RegKey
}



function Remove-RegValue {

	<#
	.SYNOPSIS
	       Deletes the specified registry value from local or remote computers.

	.DESCRIPTION
	       Use Remove-RegValue to delete the specified registry value from local or remote computers.
	       
	.PARAMETER ComputerName
	    	An array of computer names. The default is the local computer.

	.PARAMETER Hive
	   	The HKEY to open, from the RegistryHive enumeration. The default is 'LocalMachine'.
	   	Possible values:
	   	
		- ClassesRoot
		- CurrentUser
		- LocalMachine
		- Users
		- PerformanceData
		- CurrentConfig
		- DynData	   	

	.PARAMETER Key
	       The path of the registry key to open.  

	.PARAMETER Value
	       The name of the registry value to delete.

	.PARAMETER Force
	       Overrides any confirmations made by the command. Even using the Force parameter, the function cannot override security restrictions.

	.PARAMETER Ping
	       Use ping to test if the machine is available before connecting to it. 
	       If the machine is not responding to the test a warning message is output.
	       		
	.EXAMPLE
		$Key = "SOFTWARE\Microsoft\Windows\CurrentVersion\policies\Explorer"
		Test-RegValue -Key $Key -Value NoDriveTypeAutorun -ComputerName SERVER1,SERVER2 -PassThru | Remove-RegValue -Force
		
		Description
		-----------
		The command checks if the NoDriveTypeAutorun key value on SERVER1 and SERVER2. When using the PassThru parameter, each value, if found, it emitted to the pipeline.
		Each value found that is piped into Remove-RegValue is deleted without any confirmations.		

	.NOTES
		Author: Shay Levy
		Blog  : http://blogs.microsoft.co.il/blogs/ScriptFanatic/
		
	.LINK
		http://code.msdn.microsoft.com/PSRemoteRegistry

	.LINK
		Get-RegValue
		Test-RegValue
	#>
	
	
	[CmdletBinding(SupportsShouldProcess=$true,ConfirmImpact='High',DefaultParameterSetName="__AllParameterSets")]
	
	param( 
		[Parameter(
			Position=0,
			ValueFromPipeline=$true,
			ValueFromPipelineByPropertyName=$true,
			HelpMessage="An array of computer names. The default is the local computer."
		)]		
		[Alias("CN","__SERVER","IPAddress")]
		[string[]]$ComputerName="",		
		
		[Parameter(
			Position=1,
			ValueFromPipelineByPropertyName=$true,
			HelpMessage="The HKEY to open, from the RegistryHive enumeration. The default is 'LocalMachine'."
		)]
		[ValidateSet("ClassesRoot","CurrentUser","LocalMachine","Users","PerformanceData","CurrentConfig","DynData")]
		[string]$Hive="LocalMachine",
		
		[Parameter(
			Mandatory=$true,
			Position=2,
			ValueFromPipelineByPropertyName=$true,
			HelpMessage="The path of the subkey to open."
		)]
		[Alias("RegKey")]
		[string]$Key,
		
		[Parameter(
			Position=3,
			ValueFromPipelineByPropertyName=$true,
			HelpMessage="The name of the value to remove."
		)]
		[string]$ValueName,
		
		[switch]$Force,
		
		[switch]$Ping
	) 
	
	begin {
		Write-Verbose "Enter begin block..."
		
		$RegObj = Get-RegPathParts -RegPath $Key
		
		if ($Hive -ne $RegObj.Hive){# Real Hive specified in $Hive
			$_Hive = $Hive
			$_Key = $Key
		}
		else {
			$_Hive = $RegObj.Hive
			$_Key = $RegObj.Key
		}
		
		if (!$ValueName){
			$_ValueName = $RegObj.ValueName
		}
		else {
			$_ValueName = $ValueName
		}
		
		Write-Verbose "Exit begin block..."
	}# end begin
	
	process {
		Write-Verbose "Enter process block..."
		
		foreach($c in $ComputerName) {	
			try {				
				if($c -eq "") {
					$c=$env:COMPUTERNAME
					Write-Verbose "Parameter [ComputerName] is not present, setting its value to local computer name: [$c]."
					
				}# end if
				
				if($Ping) {
					Write-Verbose "Parameter [Ping] is present, initiating Ping test"
					
					if( !(Test-Connection -ComputerName $c -Count 1 -Quiet)) {
						Write-Warning "[$c] doesn't respond to ping."
						return
					}# end if
				}# end if

				
				Write-Verbose "Starting remote registry connection against: [$c]."
				Write-Verbose "Registry Hive is: [$_Hive]."
				$reg = [Microsoft.Win32.RegistryKey]::OpenRemoteBaseKey([Microsoft.Win32.RegistryHive]$_Hive,$c)		
				
				Write-Verbose "Open remote subkey: [$_Key] with write access."
				$subKey = $reg.OpenSubKey($_Key,$true)
				
				if(!$subKey) {
					Throw "Key '$_Key' doesn't exist."
				}# end if	
				
				if($Force -or $PSCmdlet.ShouldProcess($c,"Remove Registry Value '$_Hive\$_Key\$_ValueName'")) {					
					Write-Verbose "Parameter [Force] or [Confirm:`$False] is present, suppressing confirmations."
					Write-Verbose "Setting value name: [$_ValueName]"
					$subKey.DeleteValue($_ValueName,$true)
				}# end if
				
				Write-Verbose "Closing remote registry connection on: [$c]."
				$reg.close()
			}# end try
			
			catch {
				Write-Error $_
			}# end  catch
		}# end foreach
		
		Write-Verbose "Exit process block..."
	}# end process
	
# end function Remove-RegValue
}



function Set-RegBinary {

	<#
	.SYNOPSIS
	       Sets or creates a binary data registry value (REG_BINARY) from local or remote computers.

	.DESCRIPTION
	       Use Set-RegBinary to set or create a binary data registry value (REG_BINARY) from local or remote computers.
	       
	.PARAMETER ComputerName
	    	An array of computer names. The default is the local computer.

	.PARAMETER Hive
	   	The HKEY to open, from the RegistryHive enumeration. The default is 'LocalMachine'.
	   	Possible values:
	   	
		- ClassesRoot
		- CurrentUser
		- LocalMachine
		- Users
		- PerformanceData
		- CurrentConfig
		- DynData	   	

	.PARAMETER Key
	       The path of the registry key to open.  

	.PARAMETER Value
	       The name of the registry value.

	.PARAMETER Data
	       The data to set the registry value.

	.PARAMETER Force
	       Overrides any confirmations made by the command. Even using the Force parameter, the function cannot override security restrictions.

	.PARAMETER Ping
	       Use ping to test if the machine is available before connecting to it. 
	       If the machine is not responding to the test a warning message is output.

	.PARAMETER PassThru
	       Passes the newly custom object to the pipeline. By default, this function does not generate any output.

	.EXAMPLE	  
		$Key = "SOFTWARE\MyCompany"		
		Set-RegBinary -Key $Key -Value RegBinary -Data @([char[]]"PowerShell")
		
		Description
		-----------
		The command Sets or Creates a binary registry value named RegBinary on the local computer.
		The name of ComputerName parameter, which is optional, is omitted. 		
		
	.EXAMPLE	
		"SERVER1","SERVER1","SERVER3" | Set-RegBinary -Key $Key -Value RegBinary -Data @([char[]]"PowerShell") -Ping		
		
		Description
		-----------
		The command Sets or Creates a registry value named RegBinary on three remote computers.		
		When the Switch parameter Ping is specified the command issues a ping test to each computer. 
		If the computer is not responding to the ping request a warning message is written to the console and the computer is not processed.

	.EXAMPLE	
		Get-Content servers.txt | Set-RegBinary -Key $Key -Value RegBinary -Data @([char[]]"PowerShell") -Force -PassThru

		ComputerName Hive            Key                  Value     Data                 Type
		------------ ----            ---                  -----     ----                 ----
		SERVER1      LocalMachine    software\mycompany   RegBinary {80, 111, 119, 10... Binary
		SERVER2      LocalMachine    software\mycompany   RegBinary {80, 111, 119, 10... Binary
		SERVER3      LocalMachine    software\mycompany   RegBinary {80, 111, 119, 10... Binary

		Description
		-----------
		The command uses the Get-Content cmdlet to get the server names from a text file. 
		It Sets or Creates a Binary registry value named RegBinary on three remote computers.
		By default, the caller is prompted to confirm each action. To override confirmations, the Force Switch parameter is specified.		
		By default, the command doesn't return any objects back. To get the values objects, specify the PassThru Switch parameter.				

	.OUTPUTS
		PSFanatic.Registry.RegistryValue (PSCustomObject)

	.NOTES
		Author: Shay Levy
		Blog  : http://blogs.microsoft.co.il/blogs/ScriptFanatic/
		
	.LINK
		http://code.msdn.microsoft.com/PSRemoteRegistry

	.LINK
		Get-RegBinary
		Get-RegValue
		Remove-RegValue
		Test-RegValue
	#>
	
	
	[OutputType('PSFanatic.Registry.RegistryValue')]
	[CmdletBinding(SupportsShouldProcess=$true,ConfirmImpact='High',DefaultParameterSetName="__AllParameterSets")]
					
	param( 
		[Parameter(
			Position=0,
			ValueFromPipeline=$true,
			ValueFromPipelineByPropertyName=$true,
			HelpMessage="An array of computer names. The default is the local computer."
		)]		
		[Alias("CN","__SERVER","IPAddress")]
		[string[]]$ComputerName="",		
		
		[Parameter(
			Position=1,
			ValueFromPipelineByPropertyName=$true,
			HelpMessage="The HKEY to open, from the RegistryHive enumeration. The default is 'LocalMachine'."
		)]
		[ValidateSet("ClassesRoot","CurrentUser","LocalMachine","Users","PerformanceData","CurrentConfig","DynData")]
		[string]$Hive="LocalMachine",
		
		[Parameter(
			Mandatory=$true,
			Position=2,
			ValueFromPipelineByPropertyName=$true,
			HelpMessage="The path of the subkey to open or create."
		)]
		[Alias("RegKey")]
		[string]$Key,

		[Parameter(
			Mandatory=$true,
			Position=3,
			ValueFromPipelineByPropertyName=$true,
			HelpMessage="The name of the value to set."
		)]
		[string]$Value,

		[Parameter(Mandatory=$true,Position=4)]
		[byte[]]$Data,
		
		[switch]$Force,
		[switch]$Ping,
		[switch]$PassThru
	) 
	

	process {
		Write-Verbose "Enter process block..."
		
		foreach($c in $ComputerName) {	
			try {				
				if($c -eq "") {
					$c=$env:COMPUTERNAME
					Write-Verbose "Parameter [ComputerName] is not present, setting its value to local computer name: [$c]."
					
				}
				
				if($Ping) {
					Write-Verbose "Parameter [Ping] is present, initiating Ping test"
					
					if( !(Test-Connection -ComputerName $c -Count 1 -Quiet)) {
						Write-Warning "[$c] doesn't respond to ping."
						return
					}# end if
				}# end if

				
				Write-Verbose "Starting remote registry connection against: [$c]."
				Write-Verbose "Registry Hive is: [$Hive]."
				$reg = [Microsoft.Win32.RegistryKey]::OpenRemoteBaseKey([Microsoft.Win32.RegistryHive]$Hive,$c)		
							
				Write-Verbose "Open remote subkey: [$Key] with write access."
				$subKey = $reg.OpenSubKey($Key,$true)
				
				if(!$subKey) {
					Throw "Key '$Key' doesn't exist."					
				}# end if	

				if($Force -or $PSCmdlet.ShouldProcess($c,"Set Registry Binary Value '$Hive\$Key\$Value'")) {					
					Write-Verbose "Parameter [Force] or [Confirm:`$False] is present, suppressing confirmations."
					Write-Verbose "Setting value name: [$Value]"
					$subKey.SetValue($Value,$Data,[Microsoft.Win32.RegistryValueKind]::Binary)
				}# end if
				
				
				if($PassThru) {
					Write-Verbose "Parameter [PassThru] is present, creating PSFanatic registry custom objects."
					Write-Verbose "Create PSFanatic registry value custom object."
					
					$pso = New-Object PSObject -Property @{
						ComputerName=$c
						Hive=$Hive
						Value=$Value
						Key=$Key
						Data=$subKey.GetValue($Value)
						Type=$subKey.GetValueKind($Value)
					}

					Write-Verbose "Adding format type name to custom object."
					$pso.PSTypeNames.Clear()
					$pso.PSTypeNames.Add('PSFanatic.Registry.RegistryValue')
					$pso				
				}# end if	
				
				Write-Verbose "Closing remote registry connection on: [$c]."
				$subKey.close()
			}# end try
			
			catch {
				Write-Error $_
			}# end catch
		}# end foreach 
		
		Write-Verbose "Exit process block..."
	}# end process
	
# end function Set-RegBinary
}



function Set-RegDefault {

	<#
	.SYNOPSIS
	       Sets the default value (REG_SZ) of the registry key on local or remote computers.

	.DESCRIPTION
	       Use Set-RegDefault to set the default value (REG_SZ) of the registry key on local or remote computers.
	       
	.PARAMETER ComputerName
	    	An array of computer names. The default is the local computer.

	.PARAMETER Hive
	   	The HKEY to open, from the RegistryHive enumeration. The default is 'LocalMachine'.
	   	Possible values:
	   	
		- ClassesRoot
		- CurrentUser
		- LocalMachine
		- Users
		- PerformanceData
		- CurrentConfig
		- DynData	   	

	.PARAMETER Key
	       The path of the registry key to open.  

	.PARAMETER Data
	       The data to set in the registry default value.

	.PARAMETER Force
	       Overrides any confirmations made by the command. Even using the Force parameter, the function cannot override security restrictions.

	.PARAMETER Ping
	       Use ping to test if the machine is available before connecting to it. 
	       If the machine is not responding to the test a warning message is output.

	.PARAMETER PassThru
	       Passes the newly custom object to the pipeline. By default, this function does not generate any output.
	       		
	.EXAMPLE
		$Key = "SOFTWARE\MyCompany"
		"SERVER1","SERVER2","SERVER3" | Set-RegDefault -Key $Key -Data MyDefaultValue -Ping -PassThru -Force
		
		ComputerName Hive            Key                  Value      Data            Type
		------------ ----            ---                  -----      ----            ----
		SERVER1      LocalMachine    SOFTWARE\MyCompany   (Default)  MyDefaultValue  String		
		SERVER2      LocalMachine    SOFTWARE\MyCompany   (Default)  MyDefaultValue  String		
		SERVER3      LocalMachine    SOFTWARE\MyCompany   (Default)  MyDefaultValue  String		
		
		Description
		-----------
		Set the reg default value of the SOFTWARE\MyCompany subkey on three remote computers local machine hive (HKLM) .
		Ping each server before setting the value and use -PassThru to get the objects back. Use Force to override confirmations.

	.OUTPUTS
		PSFanatic.Registry.RegistryValue (PSCustomObject)

	.NOTES
		Author: Shay Levy
		Blog  : http://blogs.microsoft.co.il/blogs/ScriptFanatic/
		
	.LINK
		http://code.msdn.microsoft.com/PSRemoteRegistry

	.LINK
		Get-RegDefault
		Get-RegValue
	#>
	
	
	[OutputType('PSFanatic.Registry.RegistryValue')]
	[CmdletBinding(SupportsShouldProcess=$true,ConfirmImpact='High',DefaultParameterSetName="__AllParameterSets")]
	
	param( 
		[Parameter(
			Position=0,
			ValueFromPipeline=$true,
			ValueFromPipelineByPropertyName=$true,
			HelpMessage="An array of computer names. The default is the local computer."
		)]		
		[Alias("CN","__SERVER","IPAddress")]
		[string[]]$ComputerName="",		
		
		[Parameter(
			Position=1,
			ValueFromPipelineByPropertyName=$true,
			HelpMessage="The HKEY to open, from the RegistryHive enumeration. The default is 'LocalMachine'."
		)]
		[ValidateSet("ClassesRoot","CurrentUser","LocalMachine","Users","PerformanceData","CurrentConfig","DynData")]
		[string]$Hive="LocalMachine",
		
		[Parameter(
			Mandatory=$true,
			Position=2,
			ValueFromPipelineByPropertyName=$true,
			HelpMessage="The path of the subkey to open."
		)]
		[Alias("RegKey")]
		[string]$Key,
	
		[Parameter(
			Mandatory=$true,
			Position=3,
			HelpMessage="The data to set in the registry default value."
		)]
		[AllowEmptyString()]
		[string]$Data,		

		[switch]$Ping,
		[switch]$Force,
		[switch]$PassThru
	) 
	

	process {
		Write-Verbose "Enter process block..."
		
		foreach($c in $ComputerName) {	
			try {				
				if($c -eq "") {
					$c=$env:COMPUTERNAME
					Write-Verbose "Parameter [ComputerName] is not present, setting its value to local computer name: [$c]."
					
				}# end if
				
				if($Ping) {
					Write-Verbose "Parameter [Ping] is present, initiating Ping test"
					
					if( !(Test-Connection -ComputerName $c -Count 1 -Quiet)) {
						Write-Warning "[$c] doesn't respond to ping."
						return
					}# end if
				}# end if

				
				Write-Verbose "Starting remote registry connection against: [$c]."
				Write-Verbose "Registry Hive is: [$Hive]."
				$reg = [Microsoft.Win32.RegistryKey]::OpenRemoteBaseKey([Microsoft.Win32.RegistryHive]$Hive,$c)		
				
				Write-Verbose "Open remote subkey: [$Key] with write access."
				$subKey = $reg.OpenSubKey($Key,$true)	
				
				if(!$subKey) {
					Throw "Key '$Key' doesn't exist."
				}# end if	

				if($Force -or $PSCmdlet.ShouldProcess($c,"Set Registry Default Value '$Hive\$Key\$Value'")) {					
					Write-Verbose "Parameter [Force] or [Confirm:`$False] is present, suppressing confirmations."
					Write-Verbose "Setting [$Key] default value."
					$subKey.SetValue($null,$Data)
				}# end if
				
				
				if($PassThru) {
					Write-Verbose "Parameter [PassThru] is present, creating PSFanatic registry custom objects."
					Write-Verbose "Create PSFanatic registry value custom object."
					
					$pso = New-Object PSObject -Property @{
						ComputerName=$c
						Hive=$Hive
						Value="(Default)"
						Key=$Key
						Data=$subKey.GetValue($null)
						Type=$subKey.GetValueKind($Value)
					}

					Write-Verbose "Adding format type name to custom object."
					$pso.PSTypeNames.Clear()
					$pso.PSTypeNames.Add('PSFanatic.Registry.RegistryValue')
					$pso				
				}# end if
				
				
				Write-Verbose "Closing remote registry connection on: [$c]."
				$subKey.close()
			}# end try
			
			catch {
				Write-Error $_
			}# end catch
		}# end foreach
		
		Write-Verbose "Exit process block..."
	}# end process
	
# end function Set-RegDefault
}



function Set-RegDWord {

	<#
	.SYNOPSIS
	       Sets or creates a 32-bit binary number (REG_DWORD) on local or remote computers.

	.DESCRIPTION
	       Use Set-RegDWord to set or create a 32-bit binary number (REG_DWORD) on local or remote computers.
	       
	.PARAMETER ComputerName
	    	An array of computer names. The default is the local computer.

	.PARAMETER Hive
	   	The HKEY to open, from the RegistryHive enumeration. The default is 'LocalMachine'.
	   	Possible values:
	   	
		- ClassesRoot
		- CurrentUser
		- LocalMachine
		- Users
		- PerformanceData
		- CurrentConfig
		- DynData	   	

	.PARAMETER Key
	       The path of the registry key to open.  

	.PARAMETER Value
	       The name of the registry value.

	.PARAMETER Data
	       The data to set the registry value.

	.PARAMETER Force
	       Overrides any confirmations made by the command. Even using the Force parameter, the function cannot override security restrictions.

	.PARAMETER Ping
	       Use ping to test if the machine is available before connecting to it. 
	       If the machine is not responding to the test a warning message is output.

	.PARAMETER PassThru
	       Passes the newly custom object to the pipeline. By default, this function does not generate any output.
		
	.EXAMPLE
		$Key = "SYSTEM\CurrentControlSet\Control\Terminal Server"	
		Get-RegDWord -ComputerName "SERVER1","SERVER1","SERVER3" -Key $Key -Value fDenyTSConnections -Ping
				
		Description
		-----------
		The command gets the registry fDenyTSConnections Dword value from three remote computers.		
		When the Switch parameter Ping is specified the command issues a ping test to each computer. 
		If the computer is not responding to the ping request a warning message is written to the console and the computer is not processed.

	.EXAMPLE
		Get-RegDWord -ComputerName "SERVER1","SERVER1","SERVER3" -Key $Key -Value fDenyTSConnections -Ping | Where-Object {$_.Data -eq 1} | Set-RegDWord -Data 0 -Force -PassThru
				
		Description
		-----------
		The command gets the registry fDenyTSConnections Dword value from three remote computers. 
		The result is piped to the Where-Object cmdlet and filters the computers that have Rempote Desktop disabled.
		The Results of Where-Object are piped to Set-RegDWord which sets the Dword value to 1 (Enable Rempote Desktop connections).
		
		When the Switch parameter Ping is specified the command issues a ping test to each computer. 
		If the computer is not responding to the ping request a warning message is written to the console and the computer is not processed.
		By default, the caller is prompted to confirm each action. To override confirmations, the Force Switch parameter is specified.		
		By default, the command doesn't return any objects back. To get the values objects, specify the PassThru Switch parameter.				

	.EXAMPLE
		$Key = "SOFTWARE\Microsoft\Windows\CurrentVersion\policies\Explorer"
		Get-Contebt server.txt | Set-RegDWord -Key $Key -Value NoDriveTypeAutorun -Data 0xFF -Force -PassThru -Ping
				
		Description
		-----------
		The command disables Autoplay for all drives on all server names defined in servers.txt with a HEX value of 0xFF (Decimal 255). 
		When the Switch parameter Ping is specified the command issues a ping test to each computer. 
		If the computer is not responding to the ping request a warning message is written to the console and the computer is not processed.
		By default, the caller is prompted to confirm each action. To override confirmations, the Force Switch parameter is specified.		
		By default, the command doesn't return any objects back. To get the values objects, specify the PassThru Switch parameter.

	.OUTPUTS
		PSFanatic.Registry.RegistryValue (PSCustomObject)

	.NOTES
		Author: Shay Levy
		Blog  : http://blogs.microsoft.co.il/blogs/ScriptFanatic/

	.LINK
		http://code.msdn.microsoft.com/PSRemoteRegistry

	.LINK
		Get-RegDWord
		Get-RegValue
		Remove-RegValue
		Test-RegValue
	#>
	
	
	[OutputType('PSFanatic.Registry.RegistryValue')]
	[CmdletBinding(SupportsShouldProcess=$true,ConfirmImpact='High',DefaultParameterSetName="__AllParameterSets")]
					
	param( 
		[Parameter(
			Position=0,
			ValueFromPipeline=$true,
			ValueFromPipelineByPropertyName=$true,
			HelpMessage="An array of computer names. The default is the local computer."
		)]		
		[Alias("CN","__SERVER","IPAddress")]
		[string[]]$ComputerName="",		
		
		[Parameter(
			Position=1,
			ValueFromPipelineByPropertyName=$true,
			HelpMessage="The HKEY to open, from the RegistryHive enumeration. The default is 'LocalMachine'."
		)]
		[ValidateSet("ClassesRoot","CurrentUser","LocalMachine","Users","PerformanceData","CurrentConfig","DynData")]
		[string]$Hive="LocalMachine",
		
		[Parameter(
			Mandatory=$true,
			Position=2,
			ValueFromPipelineByPropertyName=$true,
			HelpMessage="The path of the subkey to open or create."
		)]
		[Alias("RegKey")]
		[string]$Key,

		[Parameter(
			Mandatory=$true,
			Position=3,
			ValueFromPipelineByPropertyName=$true,
			HelpMessage="The name of the value to set."
		)]
		[string]$Value,

		[Parameter(Mandatory=$true,Position=4)]
		[int]$Data,
		
		[switch]$Force,
		[switch]$Ping,
		[switch]$PassThru
	) 
	

	process {
		Write-Verbose "Enter process block..."
		
		foreach($c in $ComputerName) {	
			try {				
				if($c -eq "") {
					$c=$env:COMPUTERNAME
					Write-Verbose "Parameter [ComputerName] is not present, setting its value to local computer name: [$c]."
					
				}# end if
				
				if($Ping) {
					Write-Verbose "Parameter [Ping] is present, initiating Ping test"
					
					if( !(Test-Connection -ComputerName $c -Count 1 -Quiet)) {
						Write-Warning "[$c] doesn't respond to ping."
						return
					}# end if
				}# end if

				
				Write-Verbose "Starting remote registry connection against: [$c]."
				Write-Verbose "Registry Hive is: [$Hive]."
				$reg = [Microsoft.Win32.RegistryKey]::OpenRemoteBaseKey([Microsoft.Win32.RegistryHive]$Hive,$c)		
				
				Write-Verbose "Open remote subkey: [$Key] with write access."
				$subKey = $reg.OpenSubKey($Key,$true)
				
				if(!$subKey) {
					Throw "Key '$Key' doesn't exist."
				}# end if	

				if($Force -or $PSCmdlet.ShouldProcess($c,"Set Registry DWord Value '$Hive\$Key\$Value'")) {					
					Write-Verbose "Parameter [Force] or [Confirm:`$False] is present, suppressing confirmations."
					Write-Verbose "Setting value name: [$Value]"
					$subKey.SetValue($Value,$Data,[Microsoft.Win32.RegistryValueKind]::DWord)
				}# end if
				
				
				if($PassThru) {
					Write-Verbose "Parameter [PassThru] is present, creating PSFanatic registry custom objects."
					Write-Verbose "Create PSFanatic registry value custom object."
					
					$pso = New-Object PSObject -Property @{
						ComputerName=$c
						Hive=$Hive
						Value=$Value
						Key=$Key
						Data=$subKey.GetValue($Value)
						Type=$subKey.GetValueKind($Value)
					}

					Write-Verbose "Adding format type name to custom object."
					$pso.PSTypeNames.Clear()
					$pso.PSTypeNames.Add('PSFanatic.Registry.RegistryValue')
					$pso				
				}# end if
				
				Write-Verbose "Closing remote registry connection on: [$c]."
				$subKey.close()
			}# end try
			
			catch {
				Write-Error $_
			}# end catch
		}# end foreach
		
		Write-Verbose "Exit process block..."
	}# end process
	
# end function Set-RegDWord
}



function Set-RegExpandString {

	<#
	.SYNOPSIS
		Sets or creates a string (REG_EXPAND_SZ) registry value on local or remote computers.

	.DESCRIPTION
		Use Set-RegExpandString to set or create registry string (REG_EXPAND_SZ) value on local or remote computers.
	       
	.PARAMETER ComputerName
		An array of computer names. The default is the local computer.

	.PARAMETER Hive
		The HKEY to open, from the RegistryHive enumeration. The default is 'LocalMachine'.
		Possible values:

		- ClassesRoot
		- CurrentUser
		- LocalMachine
		- Users
		- PerformanceData
		- CurrentConfig
		- DynData	   	

	.PARAMETER Key
		The path of the registry key to open.  

	.PARAMETER Value
	       The name of the registry value.

	.PARAMETER Data
		The data to set the registry value.

	.PARAMETER ExpandEnvironmentNames
		Expands values (from the local environment) containing references to environment variables.

	.PARAMETER Force
		Overrides any confirmations made by the command. Even using the Force parameter, the function cannot override security restrictions.

	.PARAMETER Ping
		Use ping to test if the machine is available before connecting to it. 
		If the machine is not responding to the test a warning message is output.

	.PARAMETER PassThru
		Passes the newly custom object to the pipeline. By default, this function does not generate any output.


	.EXAMPLE
		$Key = "SOFTWARE\MyCompany"
		Set-RegExpandString -ComputerName SERVER1,SERVER2,SERVER3 -Key $Key -Value SystemDir -Data %WinDir%\System32 -Force -PassThru -ExpandEnvironmentNames

		ComputerName Hive            Key                  Value      Data                 Type
		------------ ----            ---                  -----      ----                 ----
		COMPUTER1    LocalMachine    SOFTWARE\MyCompany   SystemDir  C:\Windows\System32  ExpandString
		
		
		Description
		-----------
		The command sets the registry SystemDir ExpandString value on three remote servers.
		The returned value contains an expanded value based on local environment variables.
		When the Switch parameter Ping is specified the command issues a ping test to each computer. 
		If the computer is not responding to the ping request a warning message is written to the console and the computer is not processed.
		By default, the caller is prompted to confirm each action. To override confirmations, the Force Switch parameter is specified.		
		By default, the command doesn't return any objects back. To get the values objects, specify the PassThru Switch parameter.	

	.EXAMPLE
		"SERVER1","SERVER2","SERVER3" | Set-RegExpandString -Key $Key -Value SystemDir -Data %WinDir%\System32 -Ping -Force -PassThru

		ComputerName Hive            Key                  Value      Data              Type
		------------ ----            ---                  -----      ----              ----
		SERVER1      LocalMachine    SOFTWARE\MyCompany   SystemDir  %WinDir%\System32 ExpandString
		SERVER2      LocalMachine    SOFTWARE\MyCompany   SystemDir  %WinDir%\System32 ExpandString
		SERVER3      LocalMachine    SOFTWARE\MyCompany   SystemDir  %WinDir%\System32 ExpandString


		Description
		-----------
		The command sets the registry SystemDir ExpandString value on three remote servers.
		The returned value is not expanded.
		
	.OUTPUTS
		PSFanatic.Registry.RegistryValue (PSCustomObject)

	.NOTES
		Author: Shay Levy
		Blog  : http://blogs.microsoft.co.il/blogs/ScriptFanatic/
		
	.LINK
		http://code.msdn.microsoft.com/PSRemoteRegistry
	
	.LINK
		Get-RegExpandString
		Get-RegValue
		Remove-RegValue
		Test-RegValue
	#>
	
	
	[OutputType('PSFanatic.Registry.RegistryValue')]
	[CmdletBinding(SupportsShouldProcess=$true,ConfirmImpact='High',DefaultParameterSetName="__AllParameterSets")]
					
	param( 
		[Parameter(
			Position=0,
			ValueFromPipeline=$true,
			ValueFromPipelineByPropertyName=$true,
			HelpMessage="An array of computer names. The default is the local computer."
		)]		
		[Alias("CN","__SERVER","IPAddress")]
		[string[]]$ComputerName="",		
		
		[Parameter(
			Position=1,
			ValueFromPipelineByPropertyName=$true,
			HelpMessage="The HKEY to open, from the RegistryHive enumeration. The default is 'LocalMachine'."
		)]
		[ValidateScript({ [Enum]::GetNames([Microsoft.Win32.RegistryHive]) -contains $_	})]
		[string]$Hive="LocalMachine",

		[Parameter(
			Mandatory=$true,
			Position=2,
			ValueFromPipelineByPropertyName=$true,
			HelpMessage="The path of the subkey to open or create."
		)]
		[Alias("RegKey")]
		[string]$Key,

		[Parameter(
			Mandatory=$true,
			Position=3,
			ValueFromPipelineByPropertyName=$true,
			HelpMessage="The name of the value to set."
		)]
		[string]$Value,

		[Parameter(
			Mandatory=$true,
			Position=4,
			HelpMessage="The data to set the registry value."
		)]
		[string]$Data,
		
		[switch]$ExpandEnvironmentNames,
		[switch]$Force,
		[switch]$Ping,
		[switch]$PassThru
	) 
	

	process {
		Write-Verbose "Enter process block..."
		
		foreach($c in $ComputerName) {	
			try {				
				if($c -eq "") {
					$c=$env:COMPUTERNAME
					Write-Verbose "Parameter [ComputerName] is not present, setting its value to local computer name: [$c]."
					
				}# end if
				
				if($Ping) {
					Write-Verbose "Parameter [Ping] is present, initiating Ping test"
					
					if( !(Test-Connection -ComputerName $c -Count 1 -Quiet)) {
						Write-Warning "[$c] doesn't respond to ping."
						return
					}# end if
				}# end if

				
				Write-Verbose "Starting remote registry connection against: [$c]."
				Write-Verbose "Registry Hive is: [$Hive]."
				$reg = [Microsoft.Win32.RegistryKey]::OpenRemoteBaseKey([Microsoft.Win32.RegistryHive]$Hive,$c)		
				
				Write-Verbose "Open remote subkey: [$Key] with write access."
				$subKey = $reg.OpenSubKey($Key,$true)				
				
				if(!$subKey) {
					Throw "Key '$Key' doesn't exist."
				}# end if
				
				if($Force -or $PSCmdlet.ShouldProcess($c,"Set Registry Expand String Value '$Hive\$Key\$Value'")) {
					Write-Verbose "Parameter [ExpandEnvironmentNames] is present, expanding value of environamnt strings."
					Write-Verbose "Parameter [Force] or [Confirm:`$False] is present, suppressing confirmations."
					Write-Verbose "Setting value name: [$Value]"
					$subKey.SetValue($Value,$Data,[Microsoft.Win32.RegistryValueKind]::ExpandString)
				}# end if
				
				
				if($PassThru) {
					Write-Verbose "Parameter [PassThru] is present, creating PSFanatic registry custom objects."
					Write-Verbose "Create PSFanatic registry value custom object."
					
					if($ExpandEnvironmentNames){
						Write-Verbose "Parameter [ExpandEnvironmentNames] is present, expanding value of environamnt strings."
						$d = $subKey.GetValue($Value,$Data)
					}
					else {
						$d = $subKey.GetValue($Value,$Data,[Microsoft.Win32.RegistryValueOptions]::DoNotExpandEnvironmentNames)
					}# end if
					
					$pso = New-Object PSObject -Property @{
						ComputerName=$c
						Hive=$Hive
						Value=$Value					
						Key=$Key
						Data=$d
						Type=$subKey.GetValueKind($Value)
					}

					Write-Verbose "Adding format type name to custom object."
					$pso.PSTypeNames.Clear()
					$pso.PSTypeNames.Add('PSFanatic.Registry.RegistryValue')
					$pso				
				}# end if
				
				Write-Verbose "Closing remote registry connection on: [$c]."
				$subKey.close()
			}# end try
			
			catch {
				Write-Error $_
			}# end catch
		}# end foreach
		
		Write-Verbose "Exit process block..."
	}# end process
	
# end function Set-RegExpandString
}



function Set-RegMultiString {

	<#
	.SYNOPSIS
	       Sets or creates an array of null-terminated strings (REG_MULTI_SZ) on local or remote computers.

	.DESCRIPTION
	       Use Set-RegMultiString to set or create an array of null-terminated strings (REG_MULTI_SZ) on local or remote computers.
	       
	.PARAMETER ComputerName
	    	An array of computer names. The default is the local computer.

	.PARAMETER Hive
	   	The HKEY to open, from the RegistryHive enumeration. The default is 'LocalMachine'.
	   	Possible values:
	   	
		- ClassesRoot
		- CurrentUser
		- LocalMachine
		- Users
		- PerformanceData
		- CurrentConfig
		- DynData	   	

	.PARAMETER Key
	       The path of the registry key to open.  

	.PARAMETER Value
	       The name of the registry value.

	.PARAMETER Data
	       The data to set the registry value.

	.PARAMETER Force
	       Overrides any confirmations made by the command. Even using the Force parameter, the function cannot override security restrictions.

	.PARAMETER Ping
	       Use ping to test if the machine is available before connecting to it. 
	       If the machine is not responding to the test a warning message is output.

	.PARAMETER PassThru
	       Passes the newly custom object to the pipeline. By default, this function does not generate any output.
	       		
	.EXAMPLE	  
		$Key = "SOFTWARE\MyCompany"
		Set-RegMultiString -Key $Key -Value MultiString -Data @("Power","Shell","Rocks!")	
		
		Description
		-----------
		The command sets or creates a multiple string registry value MultiString on the local computer MyCompany key.
		The name of ComputerName parameter, which is optional, is omitted. 		
		
	.EXAMPLE	
		"SERVER1","SERVER1","SERVER3" | Set-RegMultiString -Key $Key -Value MultiString -Data @("Power","Shell","Rocks!") -Ping		
		
		Description
		-----------
		The command sets or creates a multiple string registry value MultiString on three remote computers.
		When the Switch parameter Ping is specified the command issues a ping test to each computer. 
		If the computer is not responding to the ping request a warning message is written to the console and the computer is not processed.

	.EXAMPLE	
		Get-Content servers.txt | Set-RegMultiString -Key $Key -Value MultiString -Data -Force -PassThru

		ComputerName Hive         Key                Value       Data                   Type
		------------ ----         ---                -----       ----                   ----
		SERVER1      LocalMachine SOFTWARE\MyCompany MultiString {Power, Shell, Rocks!} MultiString
		SERVER2      LocalMachine SOFTWARE\MyCompany MultiString {Power, Shell, Rocks!} MultiString
		SERVER3      LocalMachine SOFTWARE\MyCompany MultiString {Power, Shell, Rocks!} MultiString

		Description
		-----------
		The command uses the Get-Content cmdlet to get the server names from a text file. 
		It Sets or Creates a registry MultiString value named MultiString on three remote computers.
		By default, the caller is prompted to confirm each action. To override confirmations, the Force Switch parameter is specified.		
		By default, the command doesn't return any objects back. To get the values objects, specify the PassThru Switch parameter.	

	.OUTPUTS
		PSFanatic.Registry.RegistryValue (PSCustomObject)

	.NOTES
		Author: Shay Levy
		Blog  : http://blogs.microsoft.co.il/blogs/ScriptFanatic/
		
	.LINK
		http://code.msdn.microsoft.com/PSRemoteRegistry

	.LINK
		Get-RegMultiString
		Get-RegValue
		Remove-RegValue
		Test-RegValue
	#>
	
	
	[OutputType('PSFanatic.Registry.RegistryValue')]
	[CmdletBinding(SupportsShouldProcess=$true,ConfirmImpact='High',DefaultParameterSetName="__AllParameterSets")]
					
	param( 
		[Parameter(
			Position=0,
			ValueFromPipeline=$true,
			ValueFromPipelineByPropertyName=$true,
			HelpMessage="An array of computer names. The default is the local computer."
		)]		
		[Alias("CN","__SERVER","IPAddress")]
		[string[]]$ComputerName="",		
		
		[Parameter(
			Position=1,
			ValueFromPipelineByPropertyName=$true,
			HelpMessage="The HKEY to open, from the RegistryHive enumeration. The default is 'LocalMachine'."
		)]
		[ValidateSet("ClassesRoot","CurrentUser","LocalMachine","Users","PerformanceData","CurrentConfig","DynData")]
		[string]$Hive="LocalMachine",
		
		[Parameter(
			Mandatory=$true,
			Position=2,
			ValueFromPipelineByPropertyName=$true,
			HelpMessage="The path of the subkey to open or create."
		)]
		[Alias("RegKey")]
		[string]$Key,

		[Parameter(
			Mandatory=$true,
			Position=3,
			ValueFromPipelineByPropertyName=$true,
			HelpMessage="The name of the value to set."
		)]
		[string]$Value,

		[Parameter(Mandatory=$true,Position=4)]		
		[string[]]$Data,
		
		[switch]$Force,
		[switch]$Ping,
		[switch]$PassThru
	) 
	

	process {
		Write-Verbose "Enter process block..."
		
		foreach($c in $ComputerName) {	
			try {				
				if($c -eq "") {
					$c=$env:COMPUTERNAME
					Write-Verbose "Parameter [ComputerName] is not present, setting its value to local computer name: [$c]."
					
				}# end if
				
				if($Ping) {
					Write-Verbose "Parameter [Ping] is present, initiating Ping test"
					
					if( !(Test-Connection -ComputerName $c -Count 1 -Quiet)) {
						Write-Warning "[$c] doesn't respond to ping."
						return
					}# end if
				}# end if

				
				Write-Verbose "Starting remote registry connection against: [$c]."
				Write-Verbose "Registry Hive is: [$Hive]."
				$reg = [Microsoft.Win32.RegistryKey]::OpenRemoteBaseKey([Microsoft.Win32.RegistryHive]$Hive,$c)		
				
				Write-Verbose "Open remote subkey: [$Key] with write access."
				$subKey = $reg.OpenSubKey($Key,$true)
				
				if(!$subKey) {
					Throw "Key '$Key' doesn't exist."
				}# end if	

				if($Force -or $PSCmdlet.ShouldProcess($c,"Set Multiple String value '$Hive\$Key\$Value'")) {					
					Write-Verbose "Parameter [Force] or [Confirm:`$False] is present, suppressing confirmations."
					Write-Verbose "Setting value name: [$Value]"
					$subKey.SetValue($Value,$Data,[Microsoft.Win32.RegistryValueKind]::MultiString)
				}# end if
				
				
				if($PassThru) {
					Write-Verbose "Parameter [PassThru] is present, creating PSFanatic registry custom objects."
					Write-Verbose "Create PSFanatic registry value custom object."
					
					$pso = New-Object PSObject -Property @{
						ComputerName=$c
						Hive=$Hive
						Value=$Value
						Key=$Key
						Data=$subKey.GetValue($Value)
						Type=$subKey.GetValueKind($Value)
					}

					Write-Verbose "Adding format type name to custom object."
					$pso.PSTypeNames.Clear()
					$pso.PSTypeNames.Add('PSFanatic.Registry.RegistryValue')
					$pso				
				}# end if	
				
				Write-Verbose "Closing remote registry connection on: [$c]."
				$subKey.close()
			}# end try
			
			catch {
				Write-Error $_
			}# end catch
		}# end foreach
		
		Write-Verbose "Exit process block..."
	}# end process
	
# end function Set-RegMultiString
}



function Set-RegQWord {

	<#
	.SYNOPSIS
	   	Sets or creates a 64-bit binary number (REG_QWORD) on local or remote computers.

	.DESCRIPTION
	       Use Set-RegQWord to set or create a 64-bit binary number (REG_QWORD) on local or remote computers.
	       
	.PARAMETER ComputerName
	    	An array of computer names. The default is the local computer.

	.PARAMETER Hive
	   	The HKEY to open, from the RegistryHive enumeration. The default is 'LocalMachine'.
	   	Possible values:
	   	
		- ClassesRoot
		- CurrentUser
		- LocalMachine
		- Users
		- PerformanceData
		- CurrentConfig
		- DynData	   	

	.PARAMETER Key
	       The path of the registry key to open.  

	.PARAMETER Value
	       The name of the registry value.

	.PARAMETER Data
	       The data to set the registry value.

	.PARAMETER Force
	       Overrides any confirmations made by the command. Even using the Force parameter, the function cannot override security restrictions.

	.PARAMETER Ping
	       Use ping to test if the machine is available before connecting to it. 
	       If the machine is not responding to the test a warning message is output.

	.PARAMETER PassThru
	       Passes the newly custom object to the pipeline. By default, this function does not generate any output.
	       		
	.EXAMPLE
		$Key = "SOFTWARE\MyCompany"
		Set-RegQWord -Key $Key -Value SystemLastStartTime -Data (Get-Date).Ticks

		ComputerName Hive            Key                  Value                     Data                 Type
		------------ ----            ---                  -----                     ----                 ----
		SERVER1      LocalMachine    SOFTWARE\MyCompany   SystemLastStartTime       633981970786684203   QWord

		
		Description
		-----------
		The command sets the registry SystemLastStartTime QWord value on the local computer.		
		When the Switch parameter Ping is specified the command issues a ping test to each computer. 
		If the computer is not responding to the ping request a warning message is written to the console and the computer is not processed.

	.EXAMPLE
		Get-RegQWord -ComputerName "SERVER1","SERVER1","SERVER3" -Key $Key -Value SystemLastStartTime -Ping | Where-Object {$_.Data -eq 129057765227436584} | Set-RegQWord -Data (Get-Date).Ticks -Force -PassThru
				
		ComputerName Hive            Key                  Value                     Data                 Type
		------------ ----            ---                  -----                     ----                 ----
		SERVER1      LocalMachine    SOFTWARE\MyCompany   SystemLastStartTime       633981970786684203   QWord
		SERVER2      LocalMachine    SOFTWARE\MyCompany   SystemLastStartTime       633981970786684203   QWord
		SERVER3      LocalMachine    SOFTWARE\MyCompany   SystemLastStartTime       633981970786684203   QWord

				
		Description
		-----------
		The command gets the registry SystemLastStartTime QWord value from three remote computers. 
		The result is piped to the Where-Object cmdlet and filters those who don not meet the Where-Object criteria.
		The Results of Where-Object are piped to Set-RegQWord which sets the SystemLastStartTime value to the current date time ticks (Int64).
		
		When the Switch parameter Ping is specified the command issues a ping test to each computer. 
		If the computer is not responding to the ping request a warning message is written to the console and the computer is not processed.
		By default, the caller is prompted to confirm each action. To override confirmations, the Force Switch parameter is specified.		
		By default, the command doesn't return any objects back. To get the values objects, specify the PassThru Switch parameter.				

	.OUTPUTS
		PSFanatic.Registry.RegistryValue (PSCustomObject)

	.NOTES
		Author: Shay Levy
		Blog  : http://blogs.microsoft.co.il/blogs/ScriptFanatic/
		
	.LINK
		http://code.msdn.microsoft.com/PSRemoteRegistry
	
	.LINK
		Get-RegQWord
		Get-RegValue
		Remove-RegValue
		Test-RegValue
	#>
	
	
	[OutputType('PSFanatic.Registry.RegistryValue')]
	[CmdletBinding(SupportsShouldProcess=$true,ConfirmImpact='High',DefaultParameterSetName="__AllParameterSets")]
					
	param( 
		[Parameter(
			Position=0,
			ValueFromPipeline=$true,
			ValueFromPipelineByPropertyName=$true,
			HelpMessage="An array of computer names. The default is the local computer."
		)]		
		[Alias("CN","__SERVER","IPAddress")]
		[string[]]$ComputerName="",		
		
		[Parameter(
			Position=1,
			ValueFromPipelineByPropertyName=$true,
			HelpMessage="The HKEY to open, from the RegistryHive enumeration. The default is 'LocalMachine'."
		)]
		[ValidateSet("ClassesRoot","CurrentUser","LocalMachine","Users","PerformanceData","CurrentConfig","DynData")]
		[string]$Hive="LocalMachine",
		
		[Parameter(
			Mandatory=$true,
			Position=2,
			ValueFromPipelineByPropertyName=$true,
			HelpMessage="The path of the subkey to open or create."
		)]
		[Alias("RegKey")]
		[string]$Key,

		[Parameter(
			Mandatory=$true,
			Position=3,
			ValueFromPipelineByPropertyName=$true,
			HelpMessage="The name of the value to set."
		)]
		[string]$Value,

		[Parameter(
			Mandatory=$true,
			Position=4,
			HelpMessage="The data to set the registry value."
		)]
		[string]$Data,
		
		[switch]$Force,
		[switch]$Ping,
		[switch]$PassThru
	) 
	

	process {
		Write-Verbose "Enter process block..."
		
		foreach($c in $ComputerName) {	
			try {				
				if($c -eq "") {
					$c=$env:COMPUTERNAME
					Write-Verbose "Parameter [ComputerName] is not present, setting its value to local computer name: [$c]."
					
				}# end if
				
				if($Ping) {
					Write-Verbose "Parameter [Ping] is present, initiating Ping test"
					
					if( !(Test-Connection -ComputerName $c -Count 1 -Quiet)) {
						Write-Warning "[$c] doesn't respond to ping."
						return
					}# end if
				}# end if

				
				Write-Verbose "Starting remote registry connection against: [$c]."
				Write-Verbose "Registry Hive is: [$Hive]."
				$reg = [Microsoft.Win32.RegistryKey]::OpenRemoteBaseKey([Microsoft.Win32.RegistryHive]$Hive,$c)		

				Write-Verbose "Open remote subkey: [$Key] with write access."
				$subKey = $reg.OpenSubKey($Key,$true)
				
				if(!$subKey) {
					Throw "Key '$Key' doesn't exist."
				}# end if	

				if($Force -or $PSCmdlet.ShouldProcess($c,"Set Registry QWord Value '$Hive\$Key\$Value'")) {					
					Write-Verbose "Parameter [Force] or [Confirm:`$False] is present, suppressing confirmations."
					Write-Verbose "Setting value name: [$Value]"
					$subKey.SetValue($Value,$Data,[Microsoft.Win32.RegistryValueKind]::QWord)
				}# end if
				
				
				if($PassThru) {
					Write-Verbose "Parameter [PassThru] is present, creating PSFanatic registry custom objects."
					Write-Verbose "Create PSFanatic registry value custom object."
					
					$pso = New-Object PSObject -Property @{
						ComputerName=$c
						Hive=$Hive
						Value=$Value
						Key=$Key
						Data=$subKey.GetValue($Value)
						Type=$subKey.GetValueKind($Value)
					}

					Write-Verbose "Adding format type name to custom object."
					$pso.PSTypeNames.Clear()
					$pso.PSTypeNames.Add('PSFanatic.Registry.RegistryValue')
					$pso				
				}# end if
				
				Write-Verbose "Closing remote registry connection on: [$c]."
				$subKey.close()
			}# end try
			
			catch {
				Write-Error $_
			}# end catch
		}# end foreach
		
		Write-Verbose "Exit process block..."
	}# end process
	
# end function Set-RegQWord
}



function Set-RegString {

	<#
	.SYNOPSIS
	       Sets or creates a string (REG_SZ) registry value on local or remote computers.

	.DESCRIPTION
	       Use Set-RegString to set or create registry string (REG_SZ) value on local or remote computers.
	       
	.PARAMETER ComputerName
	    	An array of computer names. The default is the local computer.

	.PARAMETER Hive
	   	The HKEY to open, from the RegistryHive enumeration. The default is 'LocalMachine'.
	   	Possible values:
	   	
		- ClassesRoot
		- CurrentUser
		- LocalMachine
		- Users
		- PerformanceData
		- CurrentConfig
		- DynData	   	

	.PARAMETER Key
	       The path of the registry key to open.  

	.PARAMETER Value
	       The name of the registry value.

	.PARAMETER Data
	       The data to set the registry value.

	.PARAMETER Force
	       Overrides any confirmations made by the command. Even using the Force parameter, the function cannot override security restrictions.

	.PARAMETER Ping
	       Use ping to test if the machine is available before connecting to it. 
	       If the machine is not responding to the test a warning message is output.

	.PARAMETER PassThru
	       Passes the newly custom object to the pipeline. By default, this function does not generate any output.	       		

	.EXAMPLE	  
		$Key = "SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce"
		Set-RegString -Key $Key -Value Notepad -Data "notepad.exe"		
		
		Description
		-----------
		The command Sets or Creates a registry value named Notepad on the local computer RunOnce key.
		The name of ComputerName parameter, which is optional, is omitted. 		
		
	.EXAMPLE	
		"SERVER1","SERVER1","SERVER3" | Set-RegString -Key $Key -Value Notepad -Data "notepad.exe" -Ping		
		
		Description
		-----------
		The command sets or creates a registry value named Notepad on three remote computers local computer's RunOnce key.
		When the Switch parameter Ping is specified the command issues a ping test to each computer. 
		If the computer is not responding to the ping request a warning message is written to the console and the computer is not processed.

	.EXAMPLE	
		Get-Content servers.txt | Set-RegString -Key $Key -Value Notepad -Data "notepad.exe" -Force -PassThru

		ComputerName Hive         Key                                           Value   Data        Type
		------------ ----         ---                                           -----   ----        ----
		SERVER1      LocalMachine SOFTWARE\Microsoft\Windows\CurrentVersion\Run Notepad notepad.exe String
		SERVER2      LocalMachine SOFTWARE\Microsoft\Windows\CurrentVersion\Run Notepad notepad.exe String
		SERVER3      LocalMachine SOFTWARE\Microsoft\Windows\CurrentVersion\Run Notepad notepad.exe String

		Description
		-----------
		The command uses the Get-Content cmdlet to get the server names from a text file. 
		It Sets or Creates a registry String value named Notepad on three remote computers.
		By default, the caller is prompted to confirm each action. To override confirmations, the Force Switch parameter is specified.		
		By default, the command doesn't return any objects back. To get the values objects, specify the PassThru Switch parameter.				
		
	.OUTPUTS
		PSFanatic.Registry.RegistryValue (PSCustomObject)

	.NOTES
		Author: Shay Levy
		Blog  : http://blogs.microsoft.co.il/blogs/ScriptFanatic/
		
	.LINK
		http://code.msdn.microsoft.com/PSRemoteRegistry

	.LINK
		Get-RegString
		Get-RegValue
		Remove-RegValue
		Test-RegValue
	#>
	
	
	[OutputType('PSFanatic.Registry.RegistryValue')]
	[CmdletBinding(SupportsShouldProcess=$true,ConfirmImpact='High',DefaultParameterSetName="__AllParameterSets")]
					
	param( 
		[Parameter(
			Position=0,
			ValueFromPipeline=$true,
			ValueFromPipelineByPropertyName=$true,
			HelpMessage="An array of computer names. The default is the local computer."
		)]		
		[Alias("CN","__SERVER","IPAddress")]
		[string[]]$ComputerName="",		
		
		[Parameter(
			Position=1,
			ValueFromPipelineByPropertyName=$true,
			HelpMessage="The HKEY to open, from the RegistryHive enumeration. The default is 'LocalMachine'."
		)]
		[ValidateSet("ClassesRoot","CurrentUser","LocalMachine","Users","PerformanceData","CurrentConfig","DynData")]
		[string]$Hive="LocalMachine",

		[Parameter(
			Mandatory=$true,
			Position=2,
			ValueFromPipelineByPropertyName=$true,
			HelpMessage="The path of the subkey to open or create."
		)]
		[Alias("RegKey")]
		[string]$Key,

		[Parameter(
			Mandatory=$true,
			Position=3,
			ValueFromPipelineByPropertyName=$true,
			HelpMessage="The name of the value to set."
		)]
		[string]$Value,

		[Parameter(
			Mandatory=$true,
			Position=4,
			HelpMessage="The data to set the registry value."
		)]
		[string]$Data,
		
		[switch]$Force,
		[switch]$Ping,
		[switch]$PassThru
	) 
	

	process {
		Write-Verbose "Enter process block..."
		
		foreach($c in $ComputerName) {	
			try {				
				if($c -eq "") {
					$c=$env:COMPUTERNAME
					Write-Verbose "Parameter [ComputerName] is not present, setting its value to local computer name: [$c]."
					
				}# end if
				
				if($Ping) {
					Write-Verbose "Parameter [Ping] is present, initiating Ping test"
					
					if( !(Test-Connection -ComputerName $c -Count 1 -Quiet)) {
						Write-Warning "[$c] doesn't respond to ping."
						return
					}# end if
				}# end if

				
				Write-Verbose "Starting remote registry connection against: [$c]."
				Write-Verbose "Registry Hive is: [$Hive]."
				$reg = [Microsoft.Win32.RegistryKey]::OpenRemoteBaseKey([Microsoft.Win32.RegistryHive]$Hive,$c)	

				Write-Verbose "Open remote subkey: [$Key] with write access."
				$subKey = $reg.OpenSubKey($Key,$true)
				
				if(!$subKey) {
					Throw "Key '$Key' doesn't exist."
				}# end if	

				if($Force -or $PSCmdlet.ShouldProcess($c,"Set Registry String Value '$Hive\$Key\$Value'")) {					
					Write-Verbose "Parameter [Force] or [Confirm:`$False] is present, suppressing confirmations."
					Write-Verbose "Setting value name: [$Value]"
					$subKey.SetValue($Value,$Data,[Microsoft.Win32.RegistryValueKind]::String)
				}# end if
				
				
				if($PassThru) {					
					Write-Verbose "Parameter [PassThru] is present, creating PSFanatic registry custom objects."
					Write-Verbose "Create PSFanatic registry value custom object."
					
					$pso = New-Object PSObject -Property @{
						ComputerName=$c
						Hive=$Hive
						Value=$Value
						Key=$Key
						Data=$subKey.GetValue($Value)
						Type=$subKey.GetValueKind($Value)
					}

					
					Write-Verbose "Adding format type name to custom object."
					$pso.PSTypeNames.Clear()
					$pso.PSTypeNames.Add('PSFanatic.Registry.RegistryValue')
					$pso				
				}# end if	
				
				Write-Verbose "Closing remote registry connection on: [$c]."
				$subKey.close()
			}# end try
			
			catch {
				Write-Error $_
			}# end catch
		}# end foreach
		
		Write-Verbose "Exit process block..."
	}# end process
	
# end function Set-RegString
}



function Test-RegKey {

	<#
	.SYNOPSIS
	       Determines if a registry key exists.

	.DESCRIPTION
	       Use Test-RegKey to determine if a registry key exists.
	       
	.PARAMETER ComputerName
	    	An array of computer names. The default is the local computer.

	.PARAMETER Hive
	   	The HKEY to open, from the RegistryHive enumeration. The default is 'LocalMachine'.
	   	Possible values:
	   	
		- ClassesRoot
		- CurrentUser
		- LocalMachine
		- Users
		- PerformanceData
		- CurrentConfig
		- DynData	   	

	.PARAMETER Key
	       The path of the registry key to open.  

	.PARAMETER Ping
	       Use ping to test if the machine is available before connecting to it. 
	       If the machine is not responding to the test a warning message is output.

	.PARAMETER PassThru
	       Passes the registry key, if found. 
 
	.EXAMPLE
		$Key = "SOFTWARE\MyCompany"
		Test-RegKey -ComputerName SERVER1 -Key $Key
		
		True


		Description
		-----------
		The command checks if the MyCompany key exists on SERVER1. 
		If the Value was found the result is True, else False.		
	
	.EXAMPLE
		Get-Content servers.txt | Test-RegValue -Key $Key -PassThru

		ComputerName Hive            Key                  Value              Data   Type
		------------ ----            ---                  -----              ----   ----
		SERVER1      LocalMachine    SOFTWARE\Microsof... PowerShellVersion  1.0    String
		SERVER2      LocalMachine    SOFTWARE\Microsof... PowerShellVersion  1.0    String
		SERVER3      LocalMachine    SOFTWARE\Microsof... PowerShellVersion  1.0    String

		Description
		-----------
		The command uses the Get-Content cmdlet to get the server names from a text file. The computer names are piped into
		Test-RegValue. If the Value was found and PassThru is specidied, the result is the registry value custom object.

	.OUTPUTS
		System.Boolean
		PSFanatic.Registry.RegistryValue (PSCustomObject)
		
	.NOTES
		Author: Shay Levy
		Blog  : http://blogs.microsoft.co.il/blogs/ScriptFanatic/

	.LINK
		http://code.msdn.microsoft.com/PSRemoteRegistry

	.LINK
		Get-RegKey
		New-RegKey
		Remove-RegKey
	#>
	

	[OutputType('System.Boolean','PSFanatic.Registry.RegistryValue')]
	[CmdletBinding(DefaultParameterSetName="__AllParameterSets")]
	
	param( 
		
		[Parameter(
			Position=0,
			ValueFromPipeline=$true,
			ValueFromPipelineByPropertyName=$true,
			HelpMessage="An array of computer names. The default is the local computer."
		)]		
		[Alias("CN","__SERVER","IPAddress")]
		[string[]]$ComputerName="",		
		
		[Parameter(
			Position=1,
			ValueFromPipelineByPropertyName=$true,
			HelpMessage="The HKEY to open, from the RegistryHive enumeration. The default is 'LocalMachine'."
		)]
		[ValidateSet("ClassesRoot","CurrentUser","LocalMachine","Users","PerformanceData","CurrentConfig","DynData")]
		[string]$Hive="LocalMachine",
		
		[Parameter(
			Mandatory=$true,
			Position=2,
			ValueFromPipelineByPropertyName=$true,
			HelpMessage="The path of the subkey to open."
		)]
		[Alias("RegKey")]
		[string]$Key,
	
		[switch]$Ping,
		
		[switch]$PassThru
	) 
	

	process {
		Write-Verbose "Enter process block..."
		
		foreach($c in $ComputerName) {	
			try {				
				if($c -eq "") {
					$c=$env:COMPUTERNAME
					Write-Verbose "Parameter [ComputerName] is not present, setting its value to local computer name: [$c]."
					
				}# end if
				
				if($Ping) {
					Write-Verbose "Parameter [Ping] is present, initiating Ping test"
					
					if( !(Test-Connection -ComputerName $c -Count 1 -Quiet)) {
						Write-Warning "[$c] doesn't respond to ping."
						return
					}# end if
				}# end if

				
				Write-Verbose "Starting remote registry connection against: [$c]."
				Write-Verbose "Registry Hive is: [$Hive]."
				$reg = [Microsoft.Win32.RegistryKey]::OpenRemoteBaseKey([Microsoft.Win32.RegistryHive]$Hive,$c)		
				
				Write-Verbose "Open remote subkey: [$Key]"
				$subKey = $reg.OpenSubKey($Key)
				
				if($subKey) {		
					Write-Verbose "Registry sub key: $subKey has been found"					
					
					if($PassThru) {
						Write-Verbose "Parameter [PassThru] is present, creating PSFanatic registry custom objects."
						Write-Verbose "Create PSFanatic registry key custom object."

						$pso = New-Object PSObject -Property @{
							ComputerName=$c
							Hive=$Hive
							Key=$Key
							SubKeyCount=$subKey.SubKeyCount
							ValueCount=$subKey.ValueCount						
						}

						Write-Verbose "Adding format type name to custom object."
						$pso.PSTypeNames.Clear()
						$pso.PSTypeNames.Add('PSFanatic.Registry.RegistryKey')
						$pso					
					}
					else {
						$true
					}# end if
				}
				else {
					Write-Verbose "Registry sub key: $subKey cannot be found"
					$false
				}# end if

				Write-Verbose "Closing remote registry connection on: [$c]."
				$subKey.close()
			}# end try
			
			catch {
				#Write-Error $_
			}# end catch
		}# end foreach
		
		Write-Verbose "Exit process block..."
	}# end process
	
# end function function Test-RegKey
}



function Test-RegValue {

	<#
	.SYNOPSIS
	       Determines if a registry value exists.

	.DESCRIPTION
	       Use Test-RegValue to determine if the registry value exists.
	       
	.PARAMETER ComputerName
	    	An array of computer names. The default is the local computer.

	.PARAMETER Hive
	   	The HKEY to open, from the RegistryHive enumeration. The default is 'LocalMachine'.
	   	Possible values:
	   	
		- ClassesRoot
		- CurrentUser
		- LocalMachine
		- Users
		- PerformanceData
		- CurrentConfig
		- DynData	   	

	.PARAMETER Key
	       The path of the registry key to open.  

	.PARAMETER Value
	       The name of the registry value.

	.PARAMETER Ping
	       Use ping to test if the machine is available before connecting to it. 
	       If the machine is not responding to the test a warning message is output.

	.PARAMETER PassThru
	       Passes the registry value, if found.
      		
	.EXAMPLE
		$Key = "SOFTWARE\Microsoft\PowerShell\1\PowerShellEngine"
		Test-RegValue -ComputerName SERVER1 -Key $Key -Value PowerShellVersion
		
		True


		Description
		-----------
		The command checks if the PowerShellVersion value exists on SERVER1. 
		If the Value was found the result is True, else False.		
	
	.EXAMPLE
		Get-Content servers.txt | Test-RegValue -Key $Key -PassThru

		ComputerName Hive            Key                  Value              Data   Type
		------------ ----            ---                  -----              ----   ----
		SERVER1      LocalMachine    SOFTWARE\Microsof... PowerShellVersion  1.0    String
		SERVER2      LocalMachine    SOFTWARE\Microsof... PowerShellVersion  1.0    String
		SERVER3      LocalMachine    SOFTWARE\Microsof... PowerShellVersion  1.0    String

		Description
		-----------
		The command uses the Get-Content cmdlet to get the server names from a text file. The names are piped into
		Test-RegValue. If the Value was found and PassThru is specidied, the result is the registry value custom object.	 

	.OUTPUTS
		System.Boolean
		PSFanatic.Registry.RegistryValue (PSCustomObject)

	.NOTES
		Author: Shay Levy
		Blog  : http://blogs.microsoft.co.il/blogs/ScriptFanatic/
		
	.LINK
		http://code.msdn.microsoft.com/PSRemoteRegistry

	.LINK
		Get-RegValue
		Remove-RegValue
		
	#>
	

	[OutputType('System.Boolean','PSFanatic.Registry.RegistryValue')]
	[CmdletBinding(DefaultParameterSetName="__AllParameterSets")]
	
	param( 
		[Parameter(
			Position=0,
			ValueFromPipeline=$true,
			ValueFromPipelineByPropertyName=$true,
			HelpMessage="An array of computer names. The default is the local computer."
		)]		
		[Alias("CN","__SERVER","IPAddress")]
		[string[]]$ComputerName="",		
		
		[Parameter(
			Position=1,
			ValueFromPipelineByPropertyName=$true,
			HelpMessage="The HKEY to open, from the RegistryHive enumeration. The default is 'LocalMachine'."
		)]
		[ValidateSet("ClassesRoot","CurrentUser","LocalMachine","Users","PerformanceData","CurrentConfig","DynData")]
		[string]$Hive="LocalMachine",
		
		[Parameter(
			Mandatory=$true,
			Position=2,
			ValueFromPipelineByPropertyName=$true,
			HelpMessage="The path of the subkey to open."
		)]
		[Alias("RegKey")]
		[string]$Key,

		[Parameter(
			Mandatory=$true,
			Position=3,
			ValueFromPipelineByPropertyName=$true,
			HelpMessage="The name of the value to test."
		)]
		[string]$Value,
		
		[switch]$Ping,
		
		[switch]$PassThru
	) 
	

	process {
		Write-Verbose "Enter process block..."
		
		foreach($c in $ComputerName) {	
			try {				
				if($c -eq "") {
					$c=$env:COMPUTERNAME
					Write-Verbose "Parameter [ComputerName] is not present, setting its value to local computer name: [$c]."
					
				}# end if
				
				if($Ping) {
					Write-Verbose "Parameter [Ping] is present, initiating Ping test"
					
					if( !(Test-Connection -ComputerName $c -Count 1 -Quiet)) {
						Write-Warning "[$c] doesn't respond to ping."
						return
					}# end if
				}# end if

				
				Write-Verbose "Starting remote registry connection against: [$c]."
				Write-Verbose "Registry Hive is: [$Hive]."
				$reg = [Microsoft.Win32.RegistryKey]::OpenRemoteBaseKey([Microsoft.Win32.RegistryHive]$Hive,$c)		
				
				Write-Verbose "Open remote subkey: [$Key]"
				$subKey = $reg.OpenSubKey($key)

				if(!$subKey) {
					Throw "Key '$Key' doesn't exist."
				}# end if
				
				if($Value -ne '(default)') {
					$rv=$subKey.GetValue($Value,-1)
	
					if($rv -eq -1) {
						$false
					}
					else {
						if($PassThru) {
							Write-Verbose "Parameter [PassThru] is present, creating PSFanatic registry custom objects."
							Write-Verbose "Create PSFanatic registry value custom object."

							$pso = New-Object PSObject -Property @{
								ComputerName=$c
								Hive=$Hive
								Value=$Value
								Key=$Key
								Data=$subKey.GetValue($Value)
								Type=$subKey.GetValueKind($Value)
							}

							Write-Verbose "Adding format type name to custom object."
							$pso.PSTypeNames.Clear()
							$pso.PSTypeNames.Add('PSFanatic.Registry.RegistryValue')
							$pso
						}
						else {
							$true
						}# end if
					}# end if
				}# end if

				Write-Verbose "Closing remote registry connection on: [$c]."
				$subKey.close()
			}# end try
			
			catch {
				#Write-Error $_
				$false
			}# end catch
		}# end foreach
		
		Write-Verbose "Exit process block..."
	}# end process
	
# end function Test-RegValue
}

#endregion