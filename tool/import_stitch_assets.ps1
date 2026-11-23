$ErrorActionPreference = 'Stop'
$projectRoot = Split-Path -Parent $PSScriptRoot
$assetRoot = Join-Path $projectRoot 'assets/stitch'
$fontRoot = Join-Path $projectRoot 'assets/fonts'
New-Item -ItemType Directory -Force -Path $assetRoot, $fontRoot | Out-Null
$sources = @()
Get-ChildItem (Join-Path $projectRoot 'design') -Recurse -Filter code.html | ForEach-Object {
  $html = Get-Content -LiteralPath $_.FullName -Raw -Encoding UTF8
  $screen = $_.Directory.Name
  $index = 0
  foreach ($imageMatch in [regex]::Matches($html, '<img[^>]+src="([^"]+)"')) {
    $index++
    $name = ($screen -replace '[^a-zA-Z0-9]', '_') + "_$index.jpg"
    $url = [System.Net.WebUtility]::HtmlDecode($imageMatch.Groups[1].Value)
    Invoke-WebRequest -Uri $url -OutFile (Join-Path $assetRoot $name) -UseBasicParsing
    $sources += [pscustomobject]@{ file = "assets/stitch/$name"; source = $url; screen = $screen }
  }
}
$sources | ConvertTo-Json | Set-Content (Join-Path $assetRoot 'sources.json') -Encoding UTF8
Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/google/fonts/main/ofl/playfairdisplay/PlayfairDisplay%5Bwght%5D.ttf' -OutFile (Join-Path $fontRoot 'PlayfairDisplay.ttf') -UseBasicParsing
Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/google/fonts/main/ofl/playfairdisplay/OFL.txt' -OutFile (Join-Path $fontRoot 'PlayfairDisplay-OFL.txt') -UseBasicParsing
Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/google/fonts/main/ofl/plusjakartasans/PlusJakartaSans%5Bwght%5D.ttf' -OutFile (Join-Path $fontRoot 'PlusJakartaSans.ttf') -UseBasicParsing
Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/google/fonts/main/ofl/plusjakartasans/OFL.txt' -OutFile (Join-Path $fontRoot 'PlusJakartaSans-OFL.txt') -UseBasicParsing

Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/google/fonts/main/ofl/notosanssymbols/NotoSansSymbols%5Bwght%5D.ttf' -OutFile (Join-Path $fontRoot 'NotoSansSymbols.ttf') -UseBasicParsing
Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/google/fonts/main/ofl/notosanssymbols/OFL.txt' -OutFile (Join-Path $fontRoot 'NotoSansSymbols-OFL.txt') -UseBasicParsing
Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/google/fonts/main/ofl/notosanssymbols2/NotoSansSymbols2-Regular.ttf' -OutFile (Join-Path $fontRoot 'NotoSansSymbols2-Regular.ttf') -UseBasicParsing
Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/google/fonts/main/ofl/notosanssymbols2/OFL.txt' -OutFile (Join-Path $fontRoot 'NotoSansSymbols2-OFL.txt') -UseBasicParsing
Write-Output 'Imported Stitch image references and OFL licensed fonts.'
