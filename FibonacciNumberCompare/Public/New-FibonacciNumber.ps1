Function New-FibonacciNumber
{
	<#
	.SYNOPSIS
	Outputs the specified number of fibonacci numbers
	
	.DESCRIPTION
	Creates a list of numbers from the fibonacci sequence starting with
	the first number in the sequence and ending with the specified limit.
	
	.PARAMETER Limit
	The number of fibonacci numbers to stop at
	
	.EXAMPLE
	New-FibonacciNumber -Limit 50
	
	.NOTES
	No additional notes
	#>
	[CmdletBinding()]
	Param(
		[Parameter(Mandatory = $True)]
		[int]$Limit
	)

	# Sets the initial variables
	$i = 0
	$Current = $Previous = 1
	
	# Loops throw outputting the fibonacci number
	# until it reaches the specified limit
	While ($i -lt $Limit)
	{
		# Outputs the fibonacci number
		$Current

		# Increments the fibonacci number
		$Current,$Previous = ($Current + $Previous),$Current

		# Increments our counter so it stops at the limit
		$i++
	}
}