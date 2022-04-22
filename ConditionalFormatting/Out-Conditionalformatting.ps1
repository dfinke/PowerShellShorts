function Out-Conditionalformatting {
    <#
        .SYNOPSIS
        Colorize your PowerShell data output the way you want
        .EXAMPLE
        $data = ((Get-Process).Where({ $_.Company }) | Select-Object Company, Name, Handles, NPM, PM -First 15)
        Out-Conditionalformatting $data {
            if ($item.Handles -ge 500) {
                $PSStyle.Background.Green
            }
            else {
                $PSStyle.Background.Red
            }
        }     
    #>
    param(
        [scriptblock]$sb,
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
        if (!$sb) {
            return $data
        }

        $offset = 3
        $map = @{}
        for ($idx = 0; $idx -lt $data.Count; $idx++) {
            $item = $data[$idx]
            $row = $idx + $offset
            $map[$row] = &$sb 
        }    
    
        $dataset = ($data | Format-Table | Out-String).split("`r`n")

        for ($row = 0; $row -lt $dataset.Count; $row++) {
            $item = $dataset[$row]
    
            if ($row -le 2) {
                $item
                continue
            }

            $map[$row] + ' ' + $item + $psstyle.Reset
        }
    }
}