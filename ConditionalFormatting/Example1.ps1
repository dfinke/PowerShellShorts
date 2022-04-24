. .\Out-Conditionalformatting.ps1

Import-Csv .\data.csv | Out-Conditionalformatting {
    param($row)
    
    $color = $psstyle.Background.Red
    
    if ($row.Units -ge 900) {
        $color = $psstyle.Background.Green
    }

    $color
}