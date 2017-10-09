Function Get-FibonacciDifference
{
	<#
	.SYNOPSIS
	Finds which fibonacci number is closest to CompareNumber
	
	.DESCRIPTION
	Searches all the specified fibonacci numbers to see which number
	is closest to CompareNumber
	
	.PARAMETER FibonacciNumbers
	The list of fibonacci numbers to use
	
	.PARAMETER CompareNumber
	The numbers to check against.
	The number to find which fibonacci number is closest to it.
	
	.EXAMPLE
	$Params = @{
		'FibonacciNumbers'	= New-FibonacciNumber -Limit 50
		'CompareNumber'		= 123456789
	}
	Get-FibonacciDifference @Params
	
	.NOTES
	No additional notes
	#>
	[CmdletBinding()]
	Param(
		[Parameter(Mandatory = $True)]
		[long[]]$FibonacciNumbers,
		[Parameter(Mandatory = $True)]
		[int]$CompareNumber
	)

	# Loops through all the inputted fibonacci numbers
	$Objs = @()
	ForEach ( $FibonacciNumber in $FibonacciNumbers )
	{
		# Removes the Calculation variable to keep things clean
		Remove-Variable Calculation -ErrorAction SilentlyContinue

		# Gets the absolute value of the difference between each fibonacci number
		# and the specified number to compare it against
		$Calculation = [math]::abs($FibonacciNumber - $CompareNumber)

		# Stores the result in the PSCustomObject
		$Objs += [PSCustomObject]@{
			'FibonacciNumber'	= $FibonacciNumber
			'Difference'		= $Calculation
		}
	}

	# Takes the full list of differences and finds the one with the smallest value
	$Difference = $Objs.Difference | Sort-Object -Descending | Select-Object -Last 1

	# Searches for the object with the smallest difference value
	$Final = ($Objs | Where-Object { $_.Difference -eq $Difference }).FibonacciNumber

	# Outputs the result
	Write-Output $Final
}