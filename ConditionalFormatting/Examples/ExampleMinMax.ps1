Import-Module $PSScriptRoot\..\PSConditionalFormatting.psd1 -force

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

''
$PSStyle.Reverse + '** Highlight Max **' + $PSStyle.Reset#
$data | Out-HighlightMax
# $data.highlightMax()
''
$PSStyle.Reverse + '** Highlight Min **' + $PSStyle.Reset
$data | Out-HighlightMin
# $data.highlightMin()
