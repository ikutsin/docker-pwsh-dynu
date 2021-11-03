BeforeAll {
    . "$PSScriptRoot\deps.ps1"
    set-healthcheck-success 
}
AfterAll {
    set-healthcheck-success 
}

Describe 'Config variables' {
    It 'have all props set' {
        $Env:DYNU_USERNAME | Should -Not -BeNullOrEmpty
        $Env:DYNU_DOMAIN | Should -Not -BeNullOrEmpty
        $Env:DYNU_PASSWORD | Should -Not -BeNullOrEmpty
        $Env:DYNU_APIKEY | Should -Not -BeNullOrEmpty
    }
}
Describe 'Api call' {
    It 'have the host' {

        $json = get-ddns
        $json.domains.Where({$_.name -eq $Env:DYNU_DOMAIN}) | Should -Not -BeNullOrEmpty -Because 'domain not found'
    }
}

Describe 'Health check' {

    It 'can be unhealthy' {
        set-healthcheck-failed 
        get-healthcheck | should -be 1
    }

    It 'can be healthy' {
        set-healthcheck-success 
        get-healthcheck | should -be 0
    }

    It 'can call in random order' {
        set-healthcheck-success 
        set-healthcheck-failed 
        set-healthcheck-success 
        set-healthcheck-success 
        set-healthcheck-failed 
        set-healthcheck-failed 
        set-healthcheck-success 
    }
}