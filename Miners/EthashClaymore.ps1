. .\Include.ps1

$Path = ".\\Bin\\Ethash-Claymore\\EthDcrMiner64.exe"
$Uri = "https://github.com/RainbowMiner/miner-binaries/releases/download/v14.6-claymoredual/claymoredual_v14.6_win_cuda10.7z"
$Commands = [PSCustomObject]@{
    "ethash" = "" #Ethash
}

$Name = (Get-Item $script:MyInvocation.MyCommand.Path).BaseName

$Commands | Get-Member -MemberType NoteProperty | Select-Object -ExpandProperty Name | ForEach-Object {
    [PSCustomObject]@{
        Type = "NVIDIA"
        Path = $Path
        Arguments = " -esm 3 -allpools 1 -allcoins 1 -platform 3 -mode 1 -mport -4068 -epool $($Pools.Ethash.Host):$($Pools.Ethash.Port) -ewal $($Pools.Ethash.User) -epsw $($Pools.Ethash.Pass)"
        HashRates = [PSCustomObject]@{(Get-Algorithm($_)) = $Stats."$($Name)_$(Get-Algorithm($_))_HashRate".Day * .99} # substract 1% devfee
        API = "Claymore"
        Port = 4068
        Wrap = $false
        URI = $Uri
    }
}
