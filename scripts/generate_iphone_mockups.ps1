Add-Type -AssemblyName System.Drawing

$ErrorActionPreference = "Stop"

$root = "C:\Users\Crack_\Desktop\ndabbikokoo app"
$inputDir = Join-Path $root "screenshots"
$outputDir = Join-Path $inputDir "iphone-premium"

if (-not (Test-Path $outputDir)) {
  New-Item -ItemType Directory -Path $outputDir | Out-Null
}

function New-RoundedRectPath {
  param(
    [float]$X,
    [float]$Y,
    [float]$Width,
    [float]$Height,
    [float]$Radius
  )

  $path = New-Object System.Drawing.Drawing2D.GraphicsPath
  $diameter = $Radius * 2

  $path.AddArc($X, $Y, $diameter, $diameter, 180, 90)
  $path.AddArc($X + $Width - $diameter, $Y, $diameter, $diameter, 270, 90)
  $path.AddArc($X + $Width - $diameter, $Y + $Height - $diameter, $diameter, $diameter, 0, 90)
  $path.AddArc($X, $Y + $Height - $diameter, $diameter, $diameter, 90, 90)
  $path.CloseFigure()

  return $path
}

function Fill-Circle {
  param(
    [System.Drawing.Graphics]$Graphics,
    [System.Drawing.Brush]$Brush,
    [float]$X,
    [float]$Y,
    [float]$Size
  )

  $Graphics.FillEllipse($Brush, $X, $Y, $Size, $Size)
}

function Draw-Mockup {
  param(
    [string]$InputPath,
    [string]$OutputPath,
    [string]$Title
  )

  $screen = [System.Drawing.Image]::FromFile($InputPath)
  try {
    $canvasWidth = 1600
    $canvasHeight = 2200
    $bitmap = New-Object System.Drawing.Bitmap $canvasWidth, $canvasHeight
    try {
      $graphics = [System.Drawing.Graphics]::FromImage($bitmap)
      try {
        $graphics.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
        $graphics.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
        $graphics.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
        $graphics.Clear([System.Drawing.Color]::FromArgb(247, 244, 238))

        $backgroundRect = New-Object System.Drawing.Rectangle 0, 0, $canvasWidth, $canvasHeight
        $bgBrush = New-Object System.Drawing.Drawing2D.LinearGradientBrush(
          $backgroundRect,
          [System.Drawing.Color]::FromArgb(248, 245, 238),
          [System.Drawing.Color]::FromArgb(235, 244, 240),
          90
        )
        $graphics.FillRectangle($bgBrush, $backgroundRect)
        $bgBrush.Dispose()

        $mintBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(34, 36, 149, 106))
        $goldBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(34, 240, 179, 74))
        $skyBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(28, 126, 200, 245))

        Fill-Circle -Graphics $graphics -Brush $skyBrush -X 1120 -Y -40 -Size 360
        Fill-Circle -Graphics $graphics -Brush $goldBrush -X -80 -Y 1760 -Size 420
        Fill-Circle -Graphics $graphics -Brush $mintBrush -X 1110 -Y 1540 -Size 280

        $mintBrush.Dispose()
        $goldBrush.Dispose()
        $skyBrush.Dispose()

        $titleFont = New-Object System.Drawing.Font("Segoe UI Semibold", 42, [System.Drawing.FontStyle]::Bold)
        $subtitleFont = New-Object System.Drawing.Font("Segoe UI", 22, [System.Drawing.FontStyle]::Regular)
        $textBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(28, 35, 31))
        $mutedBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(94, 101, 95))

        $graphics.DrawString("PIL - GWEHA", $titleFont, $textBrush, 138, 120)
        $graphics.DrawString($Title, $subtitleFont, $mutedBrush, 140, 182)

        $phoneWidth = 640
        $phoneHeight = 1320
        $phoneX = [int](($canvasWidth - $phoneWidth) / 2)
        $phoneY = 350
        $shadowRect = New-Object System.Drawing.Rectangle ($phoneX + 22), ($phoneY + 32), $phoneWidth, $phoneHeight
        $shadowPath = New-RoundedRectPath -X $shadowRect.X -Y $shadowRect.Y -Width $shadowRect.Width -Height $shadowRect.Height -Radius 88
        $shadowBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(28, 16, 56, 43))
        $graphics.FillPath($shadowBrush, $shadowPath)
        $shadowBrush.Dispose()
        $shadowPath.Dispose()

        $frameRect = New-Object System.Drawing.Rectangle $phoneX, $phoneY, $phoneWidth, $phoneHeight
        $framePath = New-RoundedRectPath -X $frameRect.X -Y $frameRect.Y -Width $frameRect.Width -Height $frameRect.Height -Radius 88
        $frameBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(18, 18, 20))
        $graphics.FillPath($frameBrush, $framePath)
        $frameBrush.Dispose()

        $innerMargin = 24
        $screenRect = New-Object System.Drawing.Rectangle ($phoneX + $innerMargin), ($phoneY + $innerMargin), ($phoneWidth - ($innerMargin * 2)), ($phoneHeight - ($innerMargin * 2))
        $screenPath = New-RoundedRectPath -X $screenRect.X -Y $screenRect.Y -Width $screenRect.Width -Height $screenRect.Height -Radius 68
        $graphics.SetClip($screenPath)
        $graphics.DrawImage($screen, $screenRect)
        $graphics.ResetClip()

        $notchWidth = 210
        $notchHeight = 44
        $notchX = [int]($phoneX + ($phoneWidth - $notchWidth) / 2)
        $notchY = $phoneY + 24
        $notchPath = New-RoundedRectPath -X $notchX -Y $notchY -Width $notchWidth -Height $notchHeight -Radius 20
        $graphics.FillPath([System.Drawing.Brushes]::Black, $notchPath)
        $notchPath.Dispose()

        $speakerX = $notchX + 58
        $speakerY = $notchY + 14
        $speakerBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(48, 48, 50))
        $speakerPath = New-RoundedRectPath -X $speakerX -Y $speakerY -Width 64 -Height 8 -Radius 4
        $graphics.FillPath($speakerBrush, $speakerPath)
        $speakerBrush.Dispose()
        $speakerPath.Dispose()

        $cameraBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(32, 32, 36))
        $graphics.FillEllipse($cameraBrush, $notchX + 142, $notchY + 10, 18, 18)
        $cameraBrush.Dispose()

        $sideBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(38, 38, 40))
        $graphics.FillRectangle($sideBrush, $phoneX - 3, $phoneY + 210, 6, 120)
        $graphics.FillRectangle($sideBrush, $phoneX - 3, $phoneY + 370, 6, 120)
        $graphics.FillRectangle($sideBrush, $phoneX + $phoneWidth - 3, $phoneY + 290, 6, 180)
        $sideBrush.Dispose()

        $framePath.Dispose()
        $screenPath.Dispose()

        $bitmap.Save($OutputPath, [System.Drawing.Imaging.ImageFormat]::Png)

        $titleFont.Dispose()
        $subtitleFont.Dispose()
        $textBrush.Dispose()
        $mutedBrush.Dispose()
      }
      finally {
        $graphics.Dispose()
      }
    }
    finally {
      $bitmap.Dispose()
    }
  }
  finally {
    $screen.Dispose()
  }
}

Draw-Mockup -InputPath (Join-Path $inputDir "01-login.png") -OutputPath (Join-Path $outputDir "01-login-iphone-premium.png") -Title "Connexion"
Draw-Mockup -InputPath (Join-Path $inputDir "02-accueil.png") -OutputPath (Join-Path $outputDir "02-accueil-iphone-premium.png") -Title "Accueil"
Draw-Mockup -InputPath (Join-Path $inputDir "03-profil.png") -OutputPath (Join-Path $outputDir "03-profil-iphone-premium.png") -Title "Profil"
Draw-Mockup -InputPath (Join-Path $inputDir "04-cotisations.png") -OutputPath (Join-Path $outputDir "04-cotisations-iphone-premium.png") -Title "Cotisations"
Draw-Mockup -InputPath (Join-Path $inputDir "05-infos.png") -OutputPath (Join-Path $outputDir "05-infos-iphone-premium.png") -Title "Informations"
