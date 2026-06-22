*** Keywords ***
Handle Error With Screenshot
    [Documentation]    Trata erro capturando screenshot e falhando o teste
    ...
    ...    Args:
    ...    - error_message: Mensagem de erro
    ...    - screenshot_name: Nome do screenshot (opcional, usa TEST_NAME se não fornecido)
    [Arguments]    ${error_message}    ${screenshot_name}=

    ${screenshot}=    Set Variable If    '${screenshot_name}' == ''    ${TEST_NAME}_error.png    ${screenshot_name}
    Capture Page Screenshot    ${SCREENSHOT_DIR}/${screenshot}
    Fail    ${error_message}

Run Keyword And Stop On Failure
    [Documentation]    Executa uma keyword e para o teste imediatamente se falhar
    ...
    ...    Esta keyword garante que quando uma keyword crítica falhar,
    ...    o teste pare imediatamente sem continuar executando outras keywords.
    ...
    ...    Args:
    ...    - keyword: Nome da keyword a ser executada
    ...    - args: Argumentos posicionais para a keyword
    ...    - kwargs: Argumentos nomeados para a keyword
    ...
    ...    Exemplo:
    ...    Run Keyword And Stop On Failure    Login Page - Perform Login
    ...    Run Keyword And Stop On Failure    Configure softcompay
    [Arguments]    ${keyword}    @{args}    &{kwargs}

    ${status}    ${error}=    Run Keyword And Ignore Error    Run Keyword    ${keyword}    @{args}    &{kwargs}
    IF    '${status}' == 'FAIL'
        Fail With Screenshot
        ...    Keyword '${keyword}' falhou: ${error}. O teste foi interrompido imediatamente devido a esta falha crítica.
    END

Fail With Screenshot
    [Documentation]    Captura screenshot e encerra o teste com Fatal Error (mensagem obrigatória).
    [Arguments]    ${message}
    Capture Page Screenshot    ${SCREENSHOT_DIR}/failure_${TEST_NAME}.png
    Fatal Error    ${message}
