*** Settings ***
Documentation    Keywords de abertura de sessão Appium e resolução de dispositivo.
...
...    Responsabilidades:
...    - Resolver o UDID final a partir de DEVICE_TAG ou DEVICE_UDID
...    - Ler configurações do dispositivo (system_port, appium_server) do devices.yaml
...    - Abrir a sessão Appium via Open Application
...    - Limpar o buffer de logcat após abertura
...
...    Dependências resolvidas pela base.resource:
...    - AppiumLibrary
...    - LogcatLibrary
...    - DevicesConfig.py
...    - structured_logging.resource
...    - Variáveis: ${DEVICE_TAG}, ${DEVICE_UDID}, ${DEFAULT_UDID}
Resource    ../helpers/common_keywords.resource


*** Variables ***
${DEFAULT_PLATFORM_NAME}      Android
${DEFAULT_AUTOMATION_NAME}    UIAutomator2
${DEFAULT_UDID}               emulator-5554


*** Keywords ***
# =============================================================================
# RESOLUÇÃO DE DISPOSITIVO
# =============================================================================

Get Device UDID From Tag
    [Documentation]    Retorna o UDID do dispositivo a ser usado na sessão Appium.
    ...
    ...    Hierarquia de resolução:
    ...    1. DEVICE_TAG vazio → retorna DEVICE_UDID diretamente
    ...    2. DEVICE_UDID explícito (não default) → retorna DEVICE_UDID (prioridade sobre YAML)
    ...    3. Caso contrário → busca UDID no devices.yaml pela DEVICE_TAG
    IF    '${DEVICE_TAG}' == ''    RETURN    ${DEVICE_UDID}
    ${is_default}=    Evaluate
    ...    '${DEVICE_UDID}' == '${DEFAULT_UDID}' or '${DEVICE_UDID}' == 'emulator-5554'
    IF    not ${is_default}    RETURN    ${DEVICE_UDID}
    ${device_udid}=    Get Device Udid    ${DEVICE_TAG}    ${DEFAULT_UDID}
    Log Action    action=device_mapping    message=Tag mapeada para UDID
    ...    tag=${DEVICE_TAG}    udid=${device_udid}
    RETURN    ${device_udid}


# =============================================================================
# ABERTURA DE SESSÃO
# =============================================================================

Open App Session
    [Documentation]    Abre a sessão Appium no dispositivo resolvido.
    ...    Todas as configurações do dispositivo (system_port, appium_server,
    ...    app_package) são lidas do devices.yaml via DevicesConfig.py.
    ...    Parâmetros opcionais permitem sobrescrever valores do YAML quando necessário.
    ...
    ...    Args:
    ...    - udid: UDID explícito. Se omitido, resolve via Get Device UDID From Tag
    ...    - device_tag: Tag do adquirente (padrão: ${DEVICE_TAG})
    ...    - platform_name: Plataforma (padrão: Android)
    ...    - automation_name: Driver de automação (padrão: UIAutomator2)
    [Arguments]
    ...    ${udid}=${NONE}
    ...    ${device_tag}=${DEVICE_TAG}
    ...    ${platform_name}=${DEFAULT_PLATFORM_NAME}
    ...    ${automation_name}=${DEFAULT_AUTOMATION_NAME}

    # Resolve UDID final
    IF    '${udid}' == '${NONE}'
        ${final_udid}=    Get Device UDID From Tag
    ELSE
        ${final_udid}=    Set Variable    ${udid}
    END

    # Lê configurações do devices.yaml para a tag atual
    ${config}=    Get Device Config    ${device_tag}

    Log Action
    ...    action=app_connect
    ...    message=Conectando ao dispositivo
    ...    udid=${final_udid}
    ...    tag=${device_tag}
    ...    systemPort=${config.system_port}
    ...    appiumServer=${config.appium_server}

    Open Application
    ...    remote_url=${config.appium_server}
    ...    platformName=${platform_name}
    ...    automationName=${automation_name}
    ...    udid=${final_udid}
    ...    systemPort=${config.system_port}
    ...    deviceName=${device_tag}
    ...    appPackage=${config.app_package}
    ...    appActivity=.MainActivity


Open App
    [Documentation]    Keyword de Test Setup — abre a aplicação e limpa o logcat.
    ...    Use via base_<modulo>.resource no Suite Setup ou Test Setup.
    ...
    ...    Uso:
    ...    Suite Setup    Open App
    ...    Test Setup     Open App
    TRY
        Open App Session
        Clear Logcat
        Log Action    action=app_open    message=Aplicação aberta com sucesso
        ...    tag=${DEVICE_TAG}
    EXCEPT    AS    ${error}
        Log Action    action=app_open_failed    message=Falha ao abrir aplicação
        ...    error=${error}    level=ERROR
        Fail    Falha ao abrir a aplicação: ${error}
    END


Close App
    [Documentation]    Keyword de Test/Suite Teardown — encerra a sessão Appium com segurança.
    ...
    ...    Uso:
    ...    Suite Teardown    Close App
    ...    Test Teardown     Close App
    TRY
        Close Application
        Log Action    action=app_close    message=Sessão encerrada    tag=${DEVICE_TAG}
    EXCEPT    AS    ${error}
        Log Action    action=app_close_failed    message=Falha ao encerrar sessão
        ...    error=${error}    level=WARN
    END
