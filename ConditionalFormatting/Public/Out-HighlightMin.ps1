function Out-HighlightMin {
    param(
        [Parameter(ValueFromPipeline)]
        $targetData,
        $color = '$PSStyle.Background.Yellow'        
    )
    
    Begin {
        $data = @()
    }

    Process {
        $data += $targetData
    }

    End {
        DoHighlight $data $color Min
    }
}
