#region import everything we need

foreach ($directory in @('Private', 'Public')) {
    Get-ChildItem -Path "$PSScriptRoot\$directory\*.ps1" | ForEach-Object { . $_.FullName }
}

Update-TypeData -TypeName 'System.Array' -MemberType ScriptMethod -MemberName HighlightMax -Force -Value {
    param(
        $color = '$PSStyle.Background.Yellow'
    )

    Out-HighlightMax $this $color
}

Update-TypeData -TypeName 'System.Array' -MemberType ScriptMethod -MemberName HighlightMin -Force -Value {
    param(
        $color = '$PSStyle.Background.Yellow'
    )

    Out-HighlightMin $this $color
}