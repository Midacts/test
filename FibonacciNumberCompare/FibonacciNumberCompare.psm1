# Get public and private function definition files.
$Public  = @( Get-ChildItem -Path $PSScriptRoot\Public\*.ps1 -ErrorAction SilentlyContinue )
$Private = @( Get-ChildItem -Path $PSScriptRoot\Private\*.ps1 -ErrorAction SilentlyContinue )

# Dot source the files
Foreach( $Import in @($Public + $Private) )
{
	Try
	{
		. $Import.FullName
	}
	Catch
	{
		Write-Error -Message "Failed to import function $($Import.FullName): $_"
	}
}