. .\Out-Conditionalformatting.ps1

Import-Csv .\data.csv | Out-Conditionalformatting {
    $color = $psstyle.Background.Red
    
    if ($item.Units -ge 520) {
        $color = $psstyle.Background.Green
    }

    $color
}