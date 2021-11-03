import-module ./deps.ps1

$username = $Env:DYNU_USERNAME
$hostname = $Env:DYNU_DOMAIN
$pswd = $Env:DYNU_PASSWORD
$apiKey = $Env:DYNU_APIKEY

$sleep = [Math]::Max(10, $Env:DYNU_SLEEP)

if(!$hostname) {
    throw 'hostname not set'
}
if(!$username) {
    throw 'username not set'
}
if(!$pswd) {
    throw 'pwd not set'
}
if(!$apiKey) {
    throw 'apiKey not set'
}
$pwd_hashed = ([System.BitConverter]::ToString((New-Object -TypeName System.Security.Cryptography.MD5CryptoServiceProvider).ComputeHash((New-Object -TypeName System.Text.UTF8Encoding).GetBytes($pswd)))).Replace("-","")

write-host "-- Updating $hostname with sleep interval $sleep secs."

$lastIp = ''
do
{
    try
    {
        $ip = Invoke-WebRequest -Uri 'checkip.amazonaws.com'
        $ip = "$ip".Trim() 

        if($ip -ne $lastIp) {
            $lastIp = $ip

            write-host "update hostname=$hostname myip=$ip"
            $url = "https://api.dynu.com/nic/update?username=$username&password=$pwd_hashed&hostname=$hostname&myip=$ip"
            $result = Invoke-WebRequest -Uri $url
            write-host "'$result'"
        } else {
            write-debug 'no change'
        }
        set-healthcheck-success
    } catch {
        write-error $_.Exception
        $lastIp = ''
        set-healthcheck-failed
    }

    Start-Sleep $sleep
} while ($true)

