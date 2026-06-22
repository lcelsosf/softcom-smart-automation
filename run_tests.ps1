# =============================================================================
# run_tests.ps1 - Execucao interativa de testes Robot Framework + Pabot
# Detecta devices Android via ADB e permite selecionar suite e devices
# =============================================================================

$ErrorActionPreference = "Stop"

# --- Configuracoes ---
$PabotConfigsDir = "pabot_configs"
$TestsDir = "tests"
$ResultsDir = "pabot_results"
$RobotOutputDir = "."
$RobotOutputFiles = @("output.xml", "log.html", "report.html")
$AllureResultsDir = "allure-results"
$AllureReportDir = "allure-report"
$DevicesYaml = "resources/data/devices.yaml"

function Show-Header {
    Write-Host ""
    Write-Host "==============================================" -ForegroundColor Blue
    Write-Host "       Shield Smart Test Automation" -ForegroundColor Blue
    Write-Host "==============================================" -ForegroundColor Blue
    Write-Host ""
}

function Show-Step {
    param([string]$Message)
    Write-Host "> $Message" -ForegroundColor Cyan
}

function Show-Success {
    param([string]$Message)
    Write-Host "OK: $Message" -ForegroundColor Green
}

function Show-Warning {
    param([string]$Message)
    Write-Host "WARN: $Message" -ForegroundColor Yellow
}

function Show-Error {
    param([string]$Message)
    Write-Host "ERROR: $Message" -ForegroundColor Red
}

function Show-Separator {
    Write-Host "----------------------------------------------" -ForegroundColor Blue
}

function Import-DotEnv {
    param([string]$Path = ".env")

    if (-not (Test-Path $Path)) {
        return
    }

    foreach ($line in Get-Content $Path) {
        $trimmed = $line.Trim()

        if ([string]::IsNullOrWhiteSpace($trimmed) -or $trimmed.StartsWith("#")) {
            continue
        }

        $match = [regex]::Match($trimmed, '^([A-Za-z_][A-Za-z0-9_]*)=(.*)$')
        if (-not $match.Success) {
            Show-Warning "Linha invalida ignorada no ${Path}: $line"
            continue
        }

        $name = $match.Groups[1].Value
        $value = $match.Groups[2].Value.Trim()

        if (($value.StartsWith('"') -and $value.EndsWith('"')) -or ($value.StartsWith("'") -and $value.EndsWith("'"))) {
            $value = $value.Substring(1, $value.Length - 2)
        }

        [Environment]::SetEnvironmentVariable($name, $value, "Process")
    }

    Show-Success ".env carregado."
}

function Get-ConnectedDevices {
    $adb = Get-Command adb -ErrorAction SilentlyContinue
    if ($null -eq $adb) {
        Show-Error "ADB nao encontrado. Verifique se esta instalado e no PATH."
        exit 1
    }

    $devices = & adb devices | Select-Object -Skip 1 | ForEach-Object {
        if ($_ -match '^(\S+)\s+(device|emulator)$') {
            $matches[1]
        }
    }

    return @($devices)
}

function Get-DeviceTagFromYaml {
    param([string]$Udid)

    if (-not (Test-Path $DevicesYaml)) {
        return "unknown"
    }

    $currentTag = $null

    foreach ($line in Get-Content $DevicesYaml) {
        if ($line -match '^\s{2}([A-Za-z0-9_]+):\s*$') {
            $currentTag = $matches[1]
            continue
        }

        if ($null -ne $currentTag -and $line -match '^\s{4}udid:\s*"?\$\{([A-Za-z_][A-Za-z0-9_]*)\}"?\s*$') {
            $envName = $matches[1]
            $expanded = [Environment]::GetEnvironmentVariable($envName, "Process")

            if ($expanded -eq $Udid) {
                return $currentTag
            }
        }
    }

    return "unknown"
}

function Select-Devices {
    $connectedUdids = @(Get-ConnectedDevices)

    if ($connectedUdids.Count -eq 0) {
        Show-Error "Nenhum device Android conectado. Conecte um device e tente novamente."
        exit 1
    }

    Write-Host ""
    Show-Step "Devices conectados detectados:"
    Show-Separator

    $script:UdidToTag = @{}
    $displayItems = @()

    foreach ($udid in $connectedUdids) {
        $tag = Get-DeviceTagFromYaml -Udid $udid
        $script:UdidToTag[$udid] = $tag
        $displayItems += "$udid ($tag)"
    }

    for ($i = 0; $i -lt $displayItems.Count; $i++) {
        Write-Host "  [$($i + 1)] $($displayItems[$i])"
    }

    Show-Separator
    Write-Host ""

    $useAll = Read-Host "Usar todos os devices conectados? [s/n]"
    $script:SelectedUdids = @()

    if ($useAll -match '^[sS]$') {
        $script:SelectedUdids = @($connectedUdids)
        Show-Success "Todos os devices selecionados."
    }
    else {
        Write-Host ""
        Write-Host "Digite os numeros dos devices (separados por espaco):"
        Write-Host "Exemplo: 1 3" -ForegroundColor Yellow
        $choices = (Read-Host) -split '\s+' | Where-Object { $_ }

        foreach ($choice in $choices) {
            $number = 0
            if ([int]::TryParse($choice, [ref]$number) -and $number -ge 1 -and $number -le $connectedUdids.Count) {
                $script:SelectedUdids += $connectedUdids[$number - 1]
            }
            else {
                Show-Warning "Opcao invalida ignorada: $choice"
            }
        }

        if ($script:SelectedUdids.Count -eq 0) {
            Show-Error "Nenhum device valido selecionado."
            exit 1
        }
    }

    Write-Host ""
    Show-Success "Devices selecionados: $($script:SelectedUdids.Count)"
    foreach ($udid in $script:SelectedUdids) {
        $tag = $script:UdidToTag[$udid]
        Write-Host "  - $udid -> tag: $tag" -ForegroundColor Green
    }
}

function Select-Suite {
    Write-Host ""
    Show-Step "Suites de teste disponiveis:"
    Show-Separator

    $suites = @(Get-ChildItem -Path $TestsDir -Filter "*.robot" -Recurse | Sort-Object FullName)

    if ($suites.Count -eq 0) {
        Show-Error "Nenhuma suite .robot encontrada em $TestsDir/"
        exit 1
    }

    $testsRoot = (Resolve-Path $TestsDir).Path
    for ($i = 0; $i -lt $suites.Count; $i++) {
        $display = $suites[$i].FullName.Substring($testsRoot.Length + 1)
        Write-Host "  [$($i + 1)] $display"
    }

    $allIndex = $suites.Count + 1
    Write-Host "  [$allIndex] Todas as suites" -ForegroundColor Yellow

    Show-Separator
    Write-Host ""
    $suiteChoice = Read-Host "Selecione a suite [1-$allIndex]"

    $choiceNumber = 0
    if (-not [int]::TryParse($suiteChoice, [ref]$choiceNumber)) {
        Show-Error "Entrada invalida."
        exit 1
    }

    if ($choiceNumber -eq $allIndex) {
        $script:SelectedSuite = $TestsDir
        Show-Success "Todas as suites selecionadas."
    }
    elseif ($choiceNumber -ge 1 -and $choiceNumber -le $suites.Count) {
        $script:SelectedSuite = $suites[$choiceNumber - 1].FullName
        $display = $script:SelectedSuite.Substring($testsRoot.Length + 1)
        Show-Success "Suite selecionada: $display"
    }
    else {
        Show-Error "Opcao invalida: $suiteChoice"
        exit 1
    }
}

function Invoke-AllureCli {
    param([string[]]$Arguments)

    $allureCommand = Get-Command allure -ErrorAction SilentlyContinue
    if ($null -ne $allureCommand) {
        $allureExecutable = $allureCommand.Source
        if ($allureExecutable.EndsWith(".ps1")) {
            $cmdFallback = [System.IO.Path]::ChangeExtension($allureExecutable, ".cmd")
            if (Test-Path $cmdFallback) {
                $allureExecutable = $cmdFallback
            }
        }

        & $allureExecutable @Arguments | Out-Host
        return $LASTEXITCODE
    }

    $npxCommand = Get-Command npx -ErrorAction SilentlyContinue
    if ($null -ne $npxCommand) {
        $npxExecutable = $npxCommand.Source
        if ($npxExecutable.EndsWith(".ps1")) {
            $cmdFallback = [System.IO.Path]::ChangeExtension($npxExecutable, ".cmd")
            if (Test-Path $cmdFallback) {
                $npxExecutable = $cmdFallback
            }
        }

        & $npxExecutable --yes allure-commandline @Arguments | Out-Host
        return $LASTEXITCODE
    }

    Show-Error "Allure CLI nao encontrado. Instale com: npm install -g allure-commandline"
    return 127
}

function Build-AndRun {
    Write-Host ""
    Show-Step "Montando comando de execucao..."
    Show-Separator

    foreach ($path in @($ResultsDir, $AllureResultsDir, $AllureReportDir)) {
        if (Test-Path $path) {
            Remove-Item -Path $path -Recurse -Force
        }
    }

    foreach ($file in $RobotOutputFiles) {
        if (Test-Path $file) {
            Remove-Item -Path $file -Force
        }
    }

    New-Item -ItemType Directory -Path $ResultsDir -Force | Out-Null
    New-Item -ItemType Directory -Path $AllureResultsDir -Force | Out-Null
    New-Item -ItemType Directory -Path $AllureReportDir -Force | Out-Null

    $pabotArgs = @(
        "--processes", "$($script:SelectedUdids.Count)",
        "--outputdir", $RobotOutputDir,
        "--listener", "allure_robotframework:$AllureResultsDir"
    )

    $index = 1
    foreach ($udid in $script:SelectedUdids) {
        $tag = $script:UdidToTag[$udid]
        if ([string]::IsNullOrWhiteSpace($tag)) {
            $tag = "unknown"
        }

        $argsFile = Join-Path $PabotConfigsDir "$tag.args"

        if (Test-Path $argsFile) {
            $pabotArgs += "--argumentfile$index"
            $pabotArgs += $argsFile
        }
        else {
            $tmpArgs = Join-Path ([System.IO.Path]::GetTempPath()) "device_$([System.Guid]::NewGuid().ToString('N')).args"
            @(
                "--variable DEVICE_TAG:$tag",
                "--variable DEVICE_UDID:$udid"
            ) | Set-Content -Path $tmpArgs -Encoding UTF8

            $pabotArgs += "--argumentfile$index"
            $pabotArgs += $tmpArgs
            Show-Warning "Arquivo $argsFile nao encontrado. Usando configuracao temporaria para $tag."
        }

        $index++
    }

    $pabotArgs += $script:SelectedSuite

    Write-Host ""
    Write-Host "Comando:"
    Write-Host "uv run pabot $($pabotArgs -join ' ')" -ForegroundColor Cyan
    Write-Host ""
    Show-Separator

    $confirm = Read-Host "Confirmar execucao? [s/n]"
    if ($confirm -notmatch '^[sS]$') {
        Show-Warning "Execucao cancelada."
        exit 0
    }

    Write-Host ""
    Show-Step "Iniciando execucao..."
    Write-Host ""

    $testExit = 0
    try {
        $uvPabotArgs = @("run", "pabot") + $pabotArgs
        & uv @uvPabotArgs
        $testExit = $LASTEXITCODE
    }
    catch {
        $testExit = 1
        Show-Error $_.Exception.Message
    }

    Write-Host ""
    Show-Step "Gerando Allure Report..."
    $allureExit = Invoke-AllureCli -Arguments @("generate", $AllureResultsDir, "-o", $AllureReportDir, "--clean")
    if ($allureExit -ne 0) {
        Show-Error "Falha ao gerar Allure Report."
        exit $allureExit
    }

    Show-Success "Report gerado em: $AllureReportDir"

    Write-Host ""
    if ($testExit -eq 0) {
        Write-Host "Execucao finalizada com sucesso!" -ForegroundColor Green
    }
    else {
        Write-Host "Execucao finalizada com falhas!" -ForegroundColor Red
    }

    Write-Host ""
    Write-Host "  Resultados Robot/Pabot: $ResultsDir/"
    Write-Host "  Resultados Allure:      $AllureResultsDir/"
    Write-Host "  Allure Report:          $AllureReportDir/index.html"
    Write-Host ""

    Show-Step "Abrindo Allure Report no browser..."
    $allureOpenExit = Invoke-AllureCli -Arguments @("open", $AllureReportDir)
    if ($allureOpenExit -ne 0) {
        Show-Warning "Nao foi possivel abrir o Allure Report automaticamente. Abra manualmente: $AllureReportDir/index.html"
    }

    exit $testExit
}

function Main {
    Show-Header

    if (-not (Test-Path $TestsDir)) {
        Show-Error "Execute este script a partir da raiz do projeto."
        exit 1
    }

    Import-DotEnv

    $script:SelectedUdids = @()
    $script:UdidToTag = @{}
    $script:SelectedSuite = ""

    Select-Devices
    Select-Suite
    Build-AndRun
}

Main
