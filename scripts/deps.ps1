function get-ddns {
    $apiKey = $Env:DYNU_APIKEY

    $url = 'https://api.dynu.com/v2/dns'
    $response = Invoke-WebRequest -Method GET -ContentType "application/json" -Uri $url -Headers @{ 'API-Key'=$apiKey}
    $json = ConvertFrom-Json $([String]::new($response.Content))
    return $json;
}

$hcFile = 'hc.txt'
function get-healthcheck {
    if(test-path $hcFile) {
        return 1
    } 
    return 0
}

function set-healthcheck-failed {
    $null = New-Item -ItemType File -Path $hcFile -Force -ErrorAction SilentlyContinue
}

function set-healthcheck-success {
    remove-item -Path $hcFile -Force -ErrorAction SilentlyContinue
}
