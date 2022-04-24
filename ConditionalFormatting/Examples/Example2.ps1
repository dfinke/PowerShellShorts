. $PSScriptRoot\..\Spikes\spikeColumnColors.ps1

$data = ConvertFrom-Csv @"
A,B,C,D
14,5,20,14
4,2,20,3
5,54,7,8
4,3,3,2
1,2,8,6
"@

$blueAndRed = {
    param($targetData)
    
    $color = $PSStyle.Background.Blue
    if ([int]$targetData -lt 6) {
        $color = $PSStyle.Background.Red
    }
    $color
}


''
doColumnStyles $data @{
    # A = { $PSStyle.Background.Green }  
    B = { $PSStyle.Background.Yellow } 
    C = { $PSStyle.Background.Yellow } 
    # D = { $PSStyle.Background.Green }
}
''
doColumnStyles $data @{
    # A = $blueAndRed
    B = $blueAndRed
    C = $blueAndRed 
    # D = $blueAndRed
}