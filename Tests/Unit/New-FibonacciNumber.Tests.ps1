Remove-Module -Name $env:BHProjectName -Force
Import-Module -Name $env:BHModulePath\$env:BHProjectName.psm1

Describe "$env:BHProjectName - New-FibonacciNumber" {

	Context "Verifying the function succeeds" {

		$Result = New-FibonacciNumber -Limit 10

		It "should have the correct number of fibonacci numbers" {
			$Result.Count | Should Be 10
		}

		It "should output the correct numbers" {
			$Result[-1] | Should Be 89
		}

	}

}