''
function doColumnStyles {
    param($data, $styles)
    
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
                # ($item.$name.ToString()).padRight($pad + 1)
                ($item.$name.ToString()).padRight($pad + $offset)
            }
            else {
                # (&$style) + ($item.$name.ToString()).padRight($pad + 1) + $PSStyle.Reset
                (&$style) + ($item.$name.ToString()).padRight($pad + $offset) + $PSStyle.Reset
            }
        }
            
        -join $newRecord
    }    
}

# doColumnStyles (Import-Csv .\data.csv) @{
#     Units  = { 
#         $color = $PSStyle.Background.Red
#         if ($item.Units -ge '520') {
#             $color = $PSStyle.Background.Green
#         }
#         $color
#     }
#     Region = {
#         if ($item.Region -eq 'East') {
#             $PSStyle.Background.Blue
#         }       
#     }
#     State  = {
#         if ($item.State -eq 'Kansas') {
#             $PSStyle.Background.Yellow
#         }       
#     }
# }

# $data = Get-Process | Where-Object Company | Select-Object Company, Name, Handles
# doColumnStyles $data @{
#     Name    = {
#         switch ($item.Name) {
#             'wsl' { $PSStyle.Background.BrightWhite }
#             'wslhost' { $PSStyle.Background.Magenta }
#         }
#     }
#     Company = {
#         if ($item.Company -match 'Microsoft') {
#             $PSStyle.Background.BrightBlue
#         }
#     }
#     Handles = {
#         $Color = $PSStyle.Background.Green
#         if ($item.Handles -gt 700) {
#             $Color = $PSStyle.Background.Red
#         }
#         $Color
#     }
# }

# doColumnStyles (Get-Service | Select-Object DisplayName , Name, Status) @{
# doColumnStyles Get-Service @{
#     Status = {
#         if ($item.Status -eq 'Running') {
#             $PSStyle.Background.Green
#         }
#         else {
#             $PSStyle.Background.Red            
#         }
#     }
# }

# $data = ConvertFrom-Csv @"
# Region,State,Units,Price
# West,Texas,927,923.71
# North,Tennessee,466,770.67
# East,Florida,520,458.68
# East,Maine,828,661.24
# West,Virginia,465,053.58
# North,Missouri,436,235.67
# South,Kansas,214,992.47
# North,North Dakota,789,640.72
# South,Delaware,712,508.55
# "@

# doColumnStyles $data @{
#     Region   = { if ($item.Region -eq 'East') { $PSStyle.Strikethrough } }
#     State    = { if ($item.State -eq 'Virginia') { $PSStyle.Bold + $PSStyle.Background.Blue } }
#     Units    = { if ($item.Units -gt 700) { $PSStyle.Background.Red } }
#     Price    = { if ($item.Price -gt 500) { $PSStyle.Reverse } }    
# }
