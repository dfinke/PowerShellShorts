. .\spikeMinMax.ps1

$data = ConvertFrom-Csv @"
Name,Age,Marks
Jane,20,50
John,19,60
Jill,21,70
Jack,18,80
Mary,19,90
"@

# $data.highlightMax()

#$data.highlightMax('$PSStyle.Foreground.BrightRed+$PSStyle.Background.Green')
$data.highlightMax('$PSStyle.Foreground.BrightRed')
$data.highlightMin('$PSStyle.Foreground.BrightBlue')