function Out-ConditionalFormattingByColumn {
    <#
        .SYNOPSIS
        Colorize your PowerShell data columns output the way you want

        .EXAMPLE
$data = ConvertFrom-Csv @"
A,B,C,D
14,5,20,14
4,2,20,3
5,54,7,8
4,3,3,2
1,2,8,6
"@
$blueAndRed = {
    param($c)
    
    $color = $PSStyle.Background.Blue
    if ([int]$c -lt 6) {
        $color = $PSStyle.Background.Red
    }
    $color
}

$data | Out-ConditionalFormattingByColumn @{ B = $blueAndRed; C = $blueAndRed }
    #>
    param(
        [System.Collections.IDictionary]$styles,
        [Parameter(ValueFromPipeline)]
        $targetData
    )
    
    Begin {
    
        $data = @()
    }

    Process {
        $data += $targetData
    }
    
    End {
        if (!$styles) {
            return $data
        }

        $mapMaxLength = @{}
        $names = $data[0].psobject.Properties.Name

        foreach ($name in $names) {
            if (!$mapMaxLength.ContainsKey($name)) {
                $mapMaxLength[$name] = $name.Length
            }
    
            foreach ($record in $data.$name) {
                if ($mapMaxLength[$name] -lt $record.length) {
                    $mapMaxLength[$name] = $record.length
                }
            }    
        }
    
        $headings = foreach ($name in $names) {
            $pad = $name.Length -gt $mapMaxLength[$name] ? $name.Length :$mapMaxLength[$name] 
            $name.padRight($pad + 1)
        }
        -join $headings
    
        $dashes = foreach ($name in $names) {
            $pad = $name.Length -gt $mapMaxLength[$name] ? $name.Length :$mapMaxLength[$name] 
            ('-' * $name.Length).padRight($pad + 1)
        }
        -join $dashes

        $offset = 1
        foreach ($item in $data) {
            $newRecord = foreach ($name in $names) {
                $style = $styles["$name"]
                $length = $item.$name.ToString().Length
                $pad = $length + ($mapMaxLength[$name] - $length)
                if (!$style) {
                    ($item.$name.ToString()).padRight($pad + $offset)
                }
                else {
                    $targetStyle = (&$style $item.$name)
                    $targetStyle + ($item.$name.ToString()).padRight($pad + $offset) + $PSStyle.Reset
                }
            }
                
            -join $newRecord
        }
    }
}