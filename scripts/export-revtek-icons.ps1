# Re-exporta icones a partir de assets/icons/sprite-source.png (grelha 5+5+5+6, 4 linhas).
# Ajuste $iconFrac (fraccao da altura da celula sem legenda) se o recorte cortar o grafico.
$ErrorActionPreference = 'Stop'
Add-Type -AssemblyName System.Drawing
$root = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$srcPath = Join-Path $root 'assets\icons\sprite-source.png'
$outDir = Join-Path $root 'assets\icons'
$iconFrac = 0.54
$slugs = @(
  'resistencia-quimica','resistencia-mecanica','facil-limpeza','durabilidade','trafego-intenso',
  'acabamento-liso','antiderrapante','impermeavel','aplicacao-rapida','cura-rapida',
  'baixas-temperaturas','uv','resistencia-termica','impacto','absorcao-vibracoes',
  'elasticidade','conforto','industria-alimentar','manutencao','armazens-logistica','uso-industrial'
)
$rows = @(5,5,5,6)
if (-not (Test-Path -LiteralPath $srcPath)) { throw "Falta $srcPath" }
$bmp = [System.Drawing.Bitmap]::FromFile($srcPath)
$W = $bmp.Width
$H = $bmp.Height
$idx = 0
for ($r = 0; $r -lt 4; $r++) {
  $ncols = $rows[$r]
  $y0 = [int][Math]::Floor($r * $H / 4)
  $y1 = [int][Math]::Floor(($r + 1) * $H / 4)
  $rowH = $y1 - $y0
  $iconH = [int][Math]::Max(1, [Math]::Floor($rowH * $iconFrac))
  for ($c = 0; $c -lt $ncols; $c++) {
    $x0 = [int][Math]::Floor($c * $W / $ncols)
    $x1 = [int][Math]::Floor(($c + 1) * $W / $ncols)
    $cw = $x1 - $x0
    $rect = [System.Drawing.Rectangle]::new($x0, $y0, $cw, $iconH)
    $tile = $bmp.Clone($rect, [System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
    # 256px de altura = ~9x no ecrã a 28px; nitidez em ecrãs retina com background-size
    $targetH = 256
    $scale = $targetH / [double]$tile.Height
    $tw = [int][Math]::Max(1, [Math]::Round($tile.Width * $scale))
    $th = $targetH
    $out = New-Object System.Drawing.Bitmap $tw, $th
    $g = [System.Drawing.Graphics]::FromImage($out)
    $g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
    $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
    $g.Clear([System.Drawing.Color]::FromArgb(0,0,0,0))
    $g.DrawImage($tile, 0, 0, $tw, $th)
    $g.Dispose()
    $tile.Dispose()
    $outPath = Join-Path $outDir ("icon-{0}.png" -f $slugs[$idx])
    $out.Save($outPath, [System.Drawing.Imaging.ImageFormat]::Png)
    $out.Dispose()
    $idx++
  }
}
$bmp.Dispose()
Write-Host "OK: $idx icones PNG em $outDir (icon-fogo.svg mantido)."
