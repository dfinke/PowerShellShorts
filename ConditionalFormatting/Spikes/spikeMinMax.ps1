. .\spikeColumnColors.ps1

function DoHighlight {
    param(
        $targetData,
        $color = '$PSStyle.Background.Yellow',
        [ValidateSet('Min', 'Max')]
        $measureType
    )
    
    $names = $targetData[0].psobject.Properties.Name
    $h = @{}
    $names | ForEach-Object {
        if ($measureType -eq 'Min') {
            $targetValue = ($targetData | Measure-Object -Minimum -Property $_).Minimum        
        }
        elseif ($measureType -eq 'Max') {
            $targetValue = ($targetData | Measure-Object -Maximum -Property $_).Maximum
        }

        $stmt = 'param($targetData) if($targetData -eq "{1}") {{{2}}}' -f $_, $targetValue, $color
        $h[$_] = [scriptblock]::Create($stmt)
    }
    
    doColumnStyles $targetData $h    
}

function highlightMin {
    param(
        $targetData,
        $color = '$PSStyle.Background.Yellow'        
    )
    
    DoHighlight $targetData $color Min
}

function highlightMax {
    param(
        $targetData,
        $color = '$PSStyle.Background.Yellow'
    )

    DoHighlight $targetData $color Max
}

Update-TypeData -TypeName 'System.Array' -MemberType ScriptMethod -MemberName HighlightMax -Force -Value {
    param(
        $color = '$PSStyle.Background.Yellow'
    )

    highlightMax $this $color
}

Update-TypeData -TypeName 'System.Array' -MemberType ScriptMethod -MemberName HighlightMin -Force -Value {
    param(
        $color = '$PSStyle.Background.Yellow'
    )

    highlightMin $this $color
}