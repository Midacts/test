Remove-Module -Name $env:BHProjectName -Force
Import-Module -Name $env:BHModulePath\$env:BHProjectName.psm1

Describe "$env:BHProjectName - Get-FibonacciDifference" {

	Context "Verifying the function succeeds" {

		It "should output the correct number" {
			$Params = @{
				'FibonacciNumbers'	= New-FibonacciNumber -Limit 50
				'CompareNumber'		= 123456789
			}
			$Result = Get-FibonacciDifference @Params

			$Result | Should Be 102334155
		}

		It "should output the correct number" {
			$Params = @{
				'FibonacciNumbers'	= New-FibonacciNumber -Limit 50
				'CompareNumber'		= 1024
			}
			$Result = Get-FibonacciDifference @Params

			$Result | Should Be 987
		}

		It "should output the correct number" {
			$Params = @{
				'FibonacciNumbers'	= New-FibonacciNumber -Limit 50
				'CompareNumber'		= 13579
			}
			$Result = Get-FibonacciDifference @Params

			$Result | Should Be 10946
		}

	}

}