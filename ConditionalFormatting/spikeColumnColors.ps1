function doColumnStyles {
    param(
        $data, 
        [System.Collections.IDictionary]$styles
    )
    
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
                ($item.$name.ToString()).padRight($pad + $offset)
            }
            else {
                $targetStyle = (&$style $item.$name)
                $targetStyle + ($item.$name.ToString()).padRight($pad + $offset) + $PSStyle.Reset
            }
        }
            
        -join $newRecord
    }    
}