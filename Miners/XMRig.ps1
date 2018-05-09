. .\Include.ps1

$Path = ".\Bin\NVIDIA-XMRig\xmrig-nvidia.exe"
$Uri = "https://github.com/xmrig/xmrig-nvidia/releases/download/v2.6.1/xmrig-nvidia-2.6.1-cuda9-win64.zip"

$Commands = [PSCustomObject]@{
    #"cryptonight" = " --cuda-devices $SelGPUCC" #Cryptonight
    #"cryptonight-lite" = " --cuda-devices $SelGPUCC" #Cryptonight-lite
    #"cryptonightV7" = " --cuda-devices $SelGPUCC" #CryptonightV7
}
$Port = 2222
$Name = (Get-Item $script:MyInvocation.MyCommand.Path).BaseName

$Commands | Get-Member -MemberType NoteProperty | Select-Object -ExpandProperty Name | ForEach-Object {
    [PSCustomObject]@{
        Type = "NVIDIA"
        Path = $Path
        Arguments = "-a $_ -o stratum+tcp://$($Pools.(Get-Algorithm($_)).Host):$($Pools.(Get-Algorithm($_)).Port) -u $($Pools.(Get-Algorithm($_)).User) -p $($Pools.(Get-Algorithm($_)).Pass)$($Commands.$_) --api-port $port --donate-level 1"
        HashRates = [PSCustomObject]@{(Get-Algorithm($_)) = $Stats."$($Name)_$(Get-Algorithm($_))_HashRate".Day * .99} # substract 1% devfee
        API = "XMRig"
        Port = $Port
        Wrap = $false
        URI = $Uri    
    }
}
