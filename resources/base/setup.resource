*** Settings ***
Documentation    Keywords de Setup e Teardown para suites e testes.
...
...    Responsabilidades:
...    - Prover keywords padronizadas de Suite Setup/Teardown e Test Setup/Teardown
...    - Garantir captura de screenshot em falha de teste
...    - Centralizar lógica de inicialização e encerramento de sessão
...
...    Dependências resolvidas pelo base.resource:
...    - AppiumLibrary
...    - LogcatLibrary
...    - open_app.resource (Open App, Close App)
...    - structured_logging.resource (Log Action)
...    - error_handling.resource (Fail With Screenshot)


*** Keywords ***
# =============================================================================
# SUITE SETUP / TEARDOWN
# =============================================================================

Suite Setup Default
    [Documentation]    Setup padrão de suite — abre a aplicação e prepara o ambiente.
    ...    Use quando não há necessidade de setup específico por módulo.
    ...
    ...    Uso na suite:
    ...    Suite Setup    Suite Setup Default
    Set Suite Variable    ${UI_FAILURE_DETECTED}    ${FALSE}
    Log Action    action=suite_start    message=Iniciando suite    suite=${SUITE_NAME}
    Open App

Suite Teardown Default
    [Documentation]    Teardown padrão de suite — encerra a sessão Appium com segurança.
    ...
    ...    Uso na suite:
    ...    Suite Teardown    Suite Teardown Default
    Log Action    action=suite_end    message=Encerrando suite    suite=${SUITE_NAME}
    Close App


# =============================================================================
# TEST SETUP / TEARDOWN
# =============================================================================

Test Setup Default
    [Documentation]    Setup padrão de teste — registra início do caso de teste no log.
    ...    Ignora o teste automaticamente se uma falha de UI foi detectada no teste anterior,
    ...    evitando falhas em cadeia por estado inválido da interface.
    ...
    ...    Uso na suite:
    ...    Test Setup    Test Setup Default
    ${_ui_failed}=    Get Variable Value    ${UI_FAILURE_DETECTED}    ${FALSE}
    IF    ${_ui_failed}
        Skip    Teste ignorado: falha de UI detectada no teste anterior — o app pode estar em estado inválido.
    END
    Log Action    action=test_start    message=Iniciando teste    test=${TEST_NAME}

Test Teardown Default
    [Documentation]    Teardown padrão de teste — captura screenshot em caso de falha.
    ...    Em caso de falha, ativa o flag de suite para que testes subsequentes
    ...    sejam ignorados (SKIP), evitando falhas em cadeia por estado inválido do app.
    ...
    ...    Uso na suite:
    ...    Test Teardown    Test Teardown Default
    Run Keyword If Test Failed    Capture Failure Screenshot
    IF    '${TEST_STATUS}' == 'FAIL'
        Set Suite Variable    ${UI_FAILURE_DETECTED}    ${TRUE}
    END
    Log Action    action=test_end
    ...    message=Teste finalizado
    ...    test=${TEST_NAME}
    ...    status=${TEST_STATUS}


# =============================================================================
# UTILITÁRIOS DE SETUP
# =============================================================================

Capture Failure Screenshot
    [Documentation]    Captura screenshot nomeado com o nome do teste atual.
    ...    Chamado automaticamente pelo Test Teardown Default em caso de falha.
    TRY
        Capture Page Screenshot    ${SCREENSHOT_DIR}/FAIL_${TEST_NAME}.png
        Log Action    action=screenshot_captured
        ...    message=Screenshot capturado
        ...    file=FAIL_${TEST_NAME}.png
        ...    level=WARN
    EXCEPT    AS    ${error}
        Log Action    action=screenshot_failed
        ...    message=Falha ao capturar screenshot
        ...    error=${error}
        ...    level=WARN
    END

Restart App
    [Documentation]    Reinicia a aplicação sem encerrar a sessão Appium.
    ...    Útil para testes que precisam de estado limpo sem overhead de nova sessão.
    ...
    ...    Uso:
    ...    Test Setup    Restart App
    TRY
        Close Application
        Open App Session
        Clear Logcat
        Log Action    action=app_restart    message=Aplicação reiniciada    tag=${DEVICE_TAG}
    EXCEPT    AS    ${error}
        Log Action    action=app_restart_failed
        ...    message=Falha ao reiniciar aplicação
        ...    error=${error}
        ...    level=ERROR
        Fail    Falha ao reiniciar a aplicação: ${error}
    END
