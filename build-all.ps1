param([string[]]$Versions, [string]$JavaHome)

$ErrorActionPreference = 'Stop'
$previousJavaHome = $env:JAVA_HOME
if (!$JavaHome -and $env:ProgramFiles) {
    $installedJdk = Join-Path $env:ProgramFiles 'Java/jdk-25'
    if (Test-Path "$installedJdk/bin/java.exe") { $JavaHome = $installedJdk }
}
if ($JavaHome) { $env:JAVA_HOME = $JavaHome }
Push-Location $PSScriptRoot
try {
    $output = Join-Path $PSScriptRoot 'build/releases'
    New-Item -ItemType Directory -Force $output | Out-Null
    if (!$Versions) {
        $Versions = Get-Content gradle/minecraft.properties | ForEach-Object { ($_ -split '=')[0] }
    }
    foreach ($version in $Versions) {
        & ./gradlew.bat build "-Pminecraft_target=$version" --console=plain
        if ($LASTEXITCODE -ne 0) { throw "Build failed: $version" }
        $jar = Get-Item "build/libs/smallhands-*+$version.jar"
        Copy-Item $jar.FullName $output -Force
    }
} finally {
    Pop-Location
    $env:JAVA_HOME = $previousJavaHome
}
