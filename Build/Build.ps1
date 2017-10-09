Param(
	$Task = 'Default'
)

# Installs the NuGet Dependency
$Null = Get-PackageProvider -Name "NuGet" -ForceBootstrap

# Imports the required modules
$ModuleNames = "BuildHelpers","Pester","psake"
ForEach ( $ModuleName in $ModuleNames )
{
	Find-Module -Name $ModuleName | Install-Module
	Import-Module -Name $ModuleName
}

# Sets up the build environment
Set-BuildEnvironment

# Runs psake
Invoke-psake $PSScriptRoot\psake.ps1 -TaskList $Task -NoLogo

# Errors out the build if psake fails
Exit ( [int]( ! $psake.build_success ) )