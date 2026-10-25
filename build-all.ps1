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
        $Versions += '26.1', '26.1.1', '26.1.2', '26.2', '26.3'
    }
    foreach ($version in $Versions) {
        $source = $PSScriptRoot
        $arguments = @('build', "-Pminecraft_target=$version", '--console=plain')
        if ($version.StartsWith('26.')) {
            $branch = if ($version -in @('26.1', '26.1.1')) { '26.1.2' } else { $version }
            $source = Join-Path $PSScriptRoot "build/versions/$branch"
            New-Item -ItemType Directory -Force $source | Out-Null
            $archive = Join-Path $PSScriptRoot "build/versions/$branch.zip"
            & git archive $branch --format=zip "--output=$archive"
            if ($LASTEXITCODE -ne 0) { throw "Missing branch: $branch" }
            Expand-Archive -LiteralPath $archive -DestinationPath $source -Force
            $arguments = @('build', "-Pminecraft_version=$version", '--console=plain')
            if ($version -eq '26.1') { $arguments += '-Pfabric_api_version=0.145.1+26.1' }
            if ($version -eq '26.1.1') { $arguments += '-Pfabric_api_version=0.145.4+26.1.1' }
        }
        Push-Location $source
        try {
            & ./gradlew.bat @arguments
            if ($LASTEXITCODE -ne 0) { throw "Build failed: $version" }
            $jar = Get-Item "build/libs/smallhands-*+$version.jar"
            Copy-Item $jar.FullName $output -Force
        } finally {
            Pop-Location
        }
    }
} finally {
    Pop-Location
    $env:JAVA_HOME = $previousJavaHome
}
