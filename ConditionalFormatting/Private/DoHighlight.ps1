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
    
    $targetData | Out-ConditionalFormattingByColumn $h
}