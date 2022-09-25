#requires -Version 3.0

Import-module ActiveDirectory

Function Get-OSCDeletedADObjects
{
<#
 	.SYNOPSIS
        Get-OSCDeletedADObjects is an advanced function which can be used to display deleted objects in Active Directory.
    .DESCRIPTION
        Get-OSCDeletedADObjects is an advanced function which can be used to display deleted objects in Active Directory.
    .PARAMETER Name
		Specifies the name of the output object to retrieve output object.
    .PARAMETER StartTime
		Specifies the start time to retrieve output object.
    .PARAMETER EndTime
		Specifies the end time to retrieve output object.
    .PARAMETER Property
		Specifies the properties of the output object to retrieve from the server.
    .EXAMPLE
        C:\PS> Get-OSCDeletedADObjects
		
		This command shows all deleted objects in active directory.
    .EXAMPLE
	    C:\PS> Get-OSCDeletedADObjects -StartTime 2/20/2013 -EndTime 2/28/2013
		
		This command shows all deleted objects in active directory from 2/20/2013 to 2/28/2013
#>
	[Cmdletbinding()]
	Param
	(
		[Parameter(Mandatory=$false,Position=0,ParameterSetName='Name')]
		[String]$Name,
		[Parameter(Mandatory,Position=1,ParameterSetName='Time')]
		[DateTime]$StartTime,
		[Parameter(Mandatory,Position=2,ParameterSetName='Time')]
		[DateTime]$EndTime,
		[Parameter(Mandatory=$false,Position=0)]
		[String[]]$Property="*"
	)
	
	${_/\_/\_/\__/\/=\_} = Get-ADObject -Filter {(isdeleted -eq $true) -and (name -ne "Deleted Objects")} -includeDeletedObjects -property $Property
					
	If($StartTime -and $EndTime) 
	{
		${_/\_/\_/\__/\/=\_} | ?{$_.whenChanged -ge $StartTime -and $_.whenChanged -le $EndTime}	
	}
	ElseIf($Name)
	{
		${_/\_/\_/\__/\/=\_} | ?{$_."msDS-LastKnownRDN" -like $Name}
	}
	Else
	{
		${_/\_/\_/\__/\/=\_}
	}
}
