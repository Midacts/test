Remove-Module -Name $env:BHProjectName -Force -ErrorAction SilentlyContinue
Import-Module -Name $env:BHModulePath\$env:BHProjectName.psm1

Describe "$env:BHProjectName - Invoke-FibonacciNumberList" {

	Context "Verifying the function succeeds" {

		$Params = @{
			'RandomNumbers'			= '2810','41781','94909','95489','46871','60699','86286','39596','31877','35279','25','34','92','31649','21855347'
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