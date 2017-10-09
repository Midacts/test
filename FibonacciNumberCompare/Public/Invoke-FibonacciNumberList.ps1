Function Invoke-FibonacciNumberList
{
	<#
	.SYNOPSIS
	Finds the closest fibonacci number
	
	.DESCRIPTION
	The main function to check the list of random numbers
	and find its closest fibonacci number
	
	.PARAMETER RandomNumbers
	List of random numbers to check with
	
	.PARAMETER FibonacciNumberLimit
	The number of fibonacci numbers to use
	
	.EXAMPLE
	$Params = @{
		'RandomNumbers'			= Get-Content -Path "random.txt"
		'FibonacciNumberLimit'	= 50
	}
	Invoke-FibonacciNumberList @Params
	
	.NOTES
	No additional notes
	#>
	Param(
		[Parameter(Mandatory = $True)]
		[int[]]$RandomNumbers,
		[Parameter(Mandatory = $True)]
		[int]$FibonacciNumberLimit
	)

	# Retrieves the number of specified fibonacci numbers
	$FibonacciNumbers = New-FibonacciNumber -Limit $FibonacciNumberLimit

	# Loops through all the random numbers
	$Objs = @()
	ForEach ( $RandomNumber in $RandomNumbers )
	{
		# Searches for which fibonacci number is closest to the specified numbers
		$Objs += [PSCustomObject]@{
			'RandomNumber'		= $RandomNumber
			'FibonacciNumber'	= Get-FibonacciDifference -FibonacciNumbers $FibonacciNumbers -CompareNumber $RandomNumber
		}
	}

	# Outputs the results
	Write-Output $Objs
}