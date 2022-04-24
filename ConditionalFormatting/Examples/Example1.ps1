Import-Module $PSScriptRoot\..\PSConditionalFormatting.psd1 -Force

Import-Csv $PSScriptRoot\data.csv | Out-ConditionalFormattingByRow {
    param($row)
    
    $color = $psstyle.Background.Red
    
    if ($row.Units -ge 900) {
        $color = $psstyle.Background.Green
    }

    $color
}