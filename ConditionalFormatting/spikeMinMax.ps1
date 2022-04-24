. .\spikeColumnColors.ps1

function highlightMin {
    param(
        $targetData,
        $color = '$PSStyle.Reverse'
    )

    $names = $targetData[0].psobject.Properties.Name
    $h = @{}
    $names | ForEach-Object {
        $min = ($targetData | Measure-Object -Minimum -Property $_).Minimum
        $stmt = 'if($item.{0} -eq "{1}") {{{2}}}' -f $_, $min, $color
        $h[$_] = [scriptblock]::Create($stmt)
    }
    
    doColumnStyles $targetData $h
}

function highlightMax {
    param(
        $targetData,
        $color = '$PSStyle.Reverse'

    )

    $names = $targetData[0].psobject.Properties.Name
    $h = @{}
    $names | ForEach-Object {
        $min = ($targetData | Measure-Object -Maximum -Property $_).Maximum
        $stmt = 'if($item.{0} -eq "{1}") {{{2}}}' -f $_, $min, $color
        $h[$_] = [scriptblock]::Create($stmt)
    }
    
    doColumnStyles $targetData $h
}

Update-TypeData -TypeName 'System.Array' -MemberType ScriptMethod -MemberName HighlightMax -Force -Value {
    param(
        $color = '$PSStyle.Reverse'
    )

    highlightMax $this $color
}

Update-TypeData -TypeName 'System.Array' -MemberType ScriptMethod -MemberName HighlightMin -Force -Value {
    param(
        $color = '$PSStyle.Reverse'
    )

    highlightMin $this $color
}

$data = ConvertFrom-Csv @"
Region,State,Units,Price
West,Texas,927,923.71
North,Tennessee,466,770.67
East,Florida,520,458.68
East,Maine,828,661.24
West,Virginia,465,53.58
North,Missouri,436,235.67
South,Kansas,214,992.47
North,North Dakota,789,640.72
South,Delaware,712,508.55
"@

#$data.HighlightMax()
# ''
# $data.HighlightMin()

# $data = Get-Process | Where-Object Company | Select-Object Company, Name, Handles
# $data = Get-Process | Where-Object Company 

#$data.highlightMin()
$data.highlightMax()