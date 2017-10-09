Remove-Module -Name $env:BHProjectName -Force
Import-Module -Name $env:BHModulePath\$env:BHProjectName.psm1

Describe "$env:BHProjectName - Invoke-FibonacciNumberList" {

	Context "Verifying the function succeeds" {

		$Params = @{
			'RandomNumbers'			= Get-Content -Path "..\Instructions and Results\random.txt"
			'FibonacciNumberLimit'	= 50
		}
		$Result = Invoke-FibonacciNumberList @Params

		It "should have the correct number of outputs" {
			$Result.Count | Should Be 15
		}

		It "should output the correct random numbers" {
			$Result[-1].RandomNumber | Should Be 21855347
		}

		It "should output the correct fibonacci numbers" {
			$Result[-1].FibonacciNumber | Should Be 24157817
		}

	}

}