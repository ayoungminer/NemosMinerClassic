. .\Include.ps1

$Path = ".\Bin\NVIDIA-zenemy-x64\z-enemy.exe"
$Uri = "https://github.com/ayoungminer/miner-bin/raw/master/NVIDIA-zenemy-x64/NVIDIA-zenemy-x64.7z"

$Commands = [PSCustomObject]@{
    #"phi" = " -d $SelGPUCC --api-remote -i 21" #Phi
    #"bitcore" = " -d $SelGPUCC --api-remote -i 20" #Bitcore
    "c11" = " -d $SelGPUCC --api-remote -i 20" #C11
    #"jha" = " -d $SelGPUCC" #Jha
    #"blake2s" = " -d $SelGPUCC" #Blake2s
    #"blakecoin" = " -d $SelGPUCC" #Blakecoin
    #"vanilla" = "" #BlakeVanilla
    #"cryptonight" = " -i 10.5 -l 8x120 --bfactor=8 -d $SelGPUCC --api-remote" #Cryptonight
    #"decred" = "" #Decred
    #"equihash" = "" #Equihash
    #"ethash" = "" #Ethash
    #"groestl" = " -d $SelGPUCC" #Groestl
    #"hmq1725" = " -d $SelGPUCC" #hmq1725
    #"keccak" = "" #Keccak
    #"lbry" = " -d $SelGPUCC" #Lbry
    #"lyra2v2" = "" #Lyra2RE2
    #"lyra2z" = " -d $SelGPUCC --api-remote --api-allow=0/0 --submit-stale" #Lyra2z
    #"myr-gr" = "" #MyriadGroestl
    #"neoscrypt" = " -d $SelGPUCC" #NeoScrypt
    #"nist5" = "" #Nist5
    #"pascal" = "" #Pascal
    #"polytimos" = " -d $SelGPUCC --api-remote -i 20" #Polytimos
    #"qubit" = "" #Qubit
    #"scrypt" = "" #Scrypt
    #"sia" = "" #Sia
    #"sib" = "" #Sib
    #"skein" = "" #Skein
    #"skunk" = " -d $SelGPUCC --api-remote" #Skunk
    #"timetravel" = " -d $SelGPUCC --api-remote -i 20" #Timetravel
    #"tribus" = " -d $SelGPUCC --api-remote -i 20" #Tribus
    #"x11" = "" #X11
    #"veltor" = "" #Veltor
    #"x11evo" = " -d $SelGPUCC" #X11evo
    #"x17" = " -d $SelGPUCC --api-remote -i 20 -N 3" #X17
    #"x16r" = " -d $SelGPUCC --api-remote -i 20 -N 6" #X16r
    #"x16s" = " -d $SelGPUCC --api-remote -i 20 -N 6" #X16s
    #"xevan" = " -d $SelGPUCC --api-remote -i 20" #Xevan
    #"vit" = " -d $SelGPUCC --api-remote -q" #Vitalium
}

$Name = (Get-Item $script:MyInvocation.MyCommand.Path).BaseName

$Commands | Get-Member -MemberType NoteProperty | Select -ExpandProperty Name | ForEach {
    [PSCustomObject]@{
        Type = "NVIDIA"
        Path = $Path
        Arguments = "-b 4068 -a $_ -o stratum+tcp://$($Pools.(Get-Algorithm($_)).Host):$($Pools.(Get-Algorithm($_)).Port) -u $($Pools.(Get-Algorithm($_)).User) -p $($Pools.(Get-Algorithm($_)).Pass)$($Commands.$_)"
        HashRates = [PSCustomObject]@{(Get-Algorithm($_)) = $Stats."$($Name)_$(Get-Algorithm($_))_HashRate".Day * .99} # substract 1% devfee
        API = "Ccminer"
        Port = 4068
        Wrap = $false
        URI = $Uri
        User = $Pools.(Get-Algorithm($_)).User
    }
}