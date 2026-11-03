$ErrorActionPreference = "Stop"

$fontDir = Join-Path $env:LOCALAPPDATA "Microsoft\Windows\Fonts"
$fontNames = @(
    "JetBrainsMonoNerdFont-Regular.ttf",
    "JetBrainsMonoNerdFont-Bold.ttf",
    "JetBrainsMonoNerdFont-Italic.ttf",
    "JetBrainsMonoNerdFont-BoldItalic.ttf"
)

$fontRegistry = "HKCU:\Software\Microsoft\Windows NT\CurrentVersion\Fonts"
$registeredFiles = @(
    foreach ($key in @($fontRegistry, "HKLM:\Software\Microsoft\Windows NT\CurrentVersion\Fonts")) {
        if (Test-Path -LiteralPath $key) {
            foreach ($property in (Get-ItemProperty -LiteralPath $key).PSObject.Properties) {
                if ($property.Name -notmatch "^PS" -and $property.Value -is [string]) {
                    $path = [Environment]::ExpandEnvironmentVariables($property.Value)
                    if (-not [IO.Path]::IsPathRooted($path)) {
                        $path = Join-Path "$env:WINDIR\Fonts" $path
                    }
                    if (Test-Path -LiteralPath $path) {
                        [IO.Path]::GetFileName($path)
                    }
                }
            }
        }
    }
)
$missing = @($fontNames | Where-Object { $_ -notin $registeredFiles })
if ($missing.Count -eq 0) {
    Write-Output "JetBrainsMono Nerd Font is already installed; download skipped."
    exit 0
}

$tempDir = Join-Path $env:TEMP ("dotfiles-font-" + [guid]::NewGuid().ToString())
New-Item -ItemType Directory -Path $tempDir | Out-Null
try {
    $archive = Join-Path $tempDir "JetBrainsMono.zip"
    $extract = Join-Path $tempDir "extracted"
    Invoke-WebRequest `
        -Uri "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip" `
        -OutFile $archive
    Expand-Archive -LiteralPath $archive -DestinationPath $extract
    foreach ($fontName in $missing) {
        if (-not (Test-Path -LiteralPath (Join-Path $extract $fontName))) {
            throw "Downloaded archive is missing $fontName"
        }
    }
    New-Item -ItemType Directory -Path $fontDir -Force | Out-Null
    New-Item -Path $fontRegistry -Force | Out-Null
    Add-Type -TypeDefinition @'
using System;
using System.Runtime.InteropServices;
public static class DotfilesFont {
    [DllImport("gdi32.dll", CharSet = CharSet.Unicode)]
    public static extern int AddFontResourceEx(string path, uint flags, IntPtr reserved);
}
'@
    foreach ($fontName in $missing) {
        $destination = Join-Path $fontDir $fontName
        Copy-Item -LiteralPath (Join-Path $extract $fontName) -Destination $destination -Force
        if ([DotfilesFont]::AddFontResourceEx($destination, 0, [IntPtr]::Zero) -eq 0) {
            throw "Windows could not load font: $destination"
        }
        New-ItemProperty -Path $fontRegistry -Name "JetBrainsMono Nerd Font $fontName" `
            -Value $destination -PropertyType String -Force | Out-Null
    }
    Write-Output "Installed JetBrainsMono Nerd Font for the current Windows user. Reopen Terminal if needed."
} finally {
    Remove-Item -LiteralPath $tempDir -Recurse -Force
}
