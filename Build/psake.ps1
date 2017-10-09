# Initial variables
Properties {
	# Find the build folder based on build system
	$ProjectRoot = $ENV:BHProjectPath
	If ( ! $ProjectRoot)
	{
		$ProjectRoot = Resolve-Path "$PSScriptRoot\.."
	}

	$Timestamp = Get-Date -UFormat "%Y%m%d-%H%M%S"
	$PSVersion = $PSVersionTable.PSVersion.Major
	$TestFile = "TestResults_PS$PSVersion`_$TimeStamp.xml"
}

Task Default -Depends Test,Analyze

Task Init {

	$lines
	Set-Location $ProjectRoot
	"Build System Details:"
	Get-Item ENV:BH*
	"`n"

}

Task Analyze -Depends Init {

	$AnalyzeParams = @{
		'Path'					= $ProjectRoot
		'IncludeDefaultRules'	= $True
		'Recurse'				= $True
		'Severity'				= 'Error'
	}
	$AnalyzeResults = Invoke-ScriptAnalyzer @AnalyzeParams

	# If any results are found error out the build
	If ( $AnalyzeResults )
	{
		Write-Error "Liniting errors were found."
	}
}

Task Test -Depends Init, Analyze {

	$lines
	"`n`tSTATUS: Testing with PowerShell $PSVersion"

	# Gather test results. Store them in a variable and file
	$TestParams = @{
		'Path' 			= "$ProjectRoot\Tests"
		'OutpputFormat'	= "NUinitXml"
		'OutputFile'	= "$ProjectRoot\$TestFile"
		'PassThru'		= $True
	}
	$TestResults = Invoke-Pester @TestParams

	# In Appveyor?  Upload our tests!
	If ( $ENV:BHBuildSystem -eq 'AppVeyor' )
	{
		(New-Object 'System.Net.WebClient').UploadFile(
			"https://ci.appveyor.com/api/testresults/nunit/$($env:APPVEYOR_JOB_ID)",
			"$ProjectRoot\$TestFile" )
	}

	Remove-Item "$ProjectRoot\$TestFile" -Force -ErrorAction SilentlyContinue

	# Failed tests?
	If ( $TestResults.FailedCount -gt 0 )
	{
		Write-Error "Failed '$($TestResults.FailedCount)' tests, build failed"
	}
	"`n"

}