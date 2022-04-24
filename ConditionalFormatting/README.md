# PowerShell Conditional Formatting

## Out-ConditionalFormattingByRow

```powershell
Import-Csv data.csv | Out-ConditionalFormattingByRow {
    param($row)
    
    $color = $psstyle.Background.Red
    
    if ($row.Units -ge 900) {
        $color = $psstyle.Background.Green
    }

    $color
}
```

![](.\Media\FormatByRow.png)