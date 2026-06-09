*** Settings ***
Documentation    Keywords utilitárias reutilizáveis entre todos os módulos do projeto.
...
...    Padrão de nomenclatura:
...    - Keywords públicas: nomes descritivos, chamadas por pages e navigation
...    - Keywords internas (_Do): delegadas pelo Run With Screenshot On Failure,
...      nunca chamadas diretamente fora deste arquivo
...
...    Dependências resolvidas pela base.resource:
...    - AppiumLibrary
...    - DevicesConfig.py
...    - structured_logging.resource
...    - Variáveis: ${SCREENSHOT_DIR}, ${DEVICE_TAG}, ${DEVICE_UDID},
...                 ${ELEMENT_TIMEOUT}, ${DEFAULT_TIMEOUT}
Library     Collections
Library     String


*** Keywords ***
# =============================================================================
# CORE — tratamento de falha com screenshot
# =============================================================================

Run With Screenshot On Failure
    [Documentation]    Executa uma keyword e, em caso de falha, captura screenshot e relança o erro.
    ...    Centraliza o padrão TRY/EXCEPT do projeto — todas as keywords públicas
    ...    deste arquivo delegam sua lógica real a uma keyword _Do via este wrapper.
    ...
    ...    Args:
    ...    - keyword_name: Nome da keyword interna (_Do) a executar
    ...    - screenshot_suffix: Prefixo do nome do arquivo de screenshot
    ...    - error_message: Mensagem de erro exibida na falha
    ...    - @{args}: Argumentos repassados para a keyword interna
    [Arguments]    ${keyword_name}    ${screenshot_suffix}    ${error_message}    @{args}
    TRY
        Run Keyword    ${keyword_name}    @{args}
    EXCEPT    AS    ${error}
        Capture Page Screenshot    ${SCREENSHOT_DIR}/${screenshot_suffix}_${TEST_NAME}.png
        Fail    ${error_message}: ${error}
    END


# =============================================================================
# INTERAÇÃO COM ELEMENTOS
# =============================================================================

Wait Visible And Click Element
    [Documentation]    Aguarda o elemento ficar visível e clica nele.
    ...    Aceita timeout customizável — substitui Wait And Click Element.
    ...
    ...    Args:
    ...    - locator: Localizador do elemento
    ...    - timeout: Tempo máximo de espera (padrão: ${ELEMENT_TIMEOUT})
    [Arguments]    ${locator}    ${timeout}=${ELEMENT_TIMEOUT}
    Run With Screenshot On Failure    _Do Wait Visible And Click Element    click_error
    ...    Erro ao clicar no elemento '${locator}'    ${locator}    ${timeout}

_Do Wait Visible And Click Element
    [Arguments]    ${locator}    ${timeout}=${ELEMENT_TIMEOUT}
    Wait Until Element Is Visible    ${locator}    timeout=${timeout}
    Click Element    ${locator}


Wait Visible And Click Element With Retry
    [Documentation]    Aguarda o elemento ficar visível e tenta clicar nele.
    ...    Reexecuta em caso de elemento obsoleto (stale element).
    ...
    ...    Args:
    ...    - locator: Localizador do elemento
    ...    - max_retries: Número máximo de tentativas (padrão: 3)
    [Arguments]    ${locator}    ${max_retries}=3
    Run With Screenshot On Failure    _Do Wait Visible And Click Element With Retry    click_retry_error
    ...    Erro ao clicar no elemento '${locator}' após ${max_retries} tentativas
    ...    ${locator}    ${max_retries}

_Do Wait Visible And Click Element With Retry
    [Arguments]    ${locator}    ${max_retries}
    ${passed}=    Set Variable    ${FALSE}
    FOR    ${retry}    IN RANGE    ${max_retries}
        ${status}    ${error}=    Run Keyword And Ignore Error
        ...    Wait Visible And Click Element    ${locator}
        IF    '${status}' == 'PASS'
            ${passed}=    Set Variable    ${TRUE}
            BREAK
        END
        Log Action    action=element_retry
        ...    message=Elemento obsoleto, tentando novamente
        ...    retry=${retry + 1}    max=${max_retries}    level=WARN
    END
    IF    not ${passed}
        Fail    Não foi possível interagir com o elemento '${locator}' após ${max_retries} tentativas.
    END


Swipe Until Visible And Click Element
    [Documentation]    Tenta clicar no elemento diretamente. Se não estiver visível,
    ...    realiza swipes na tela até que o elemento apareça e clica nele.
    ...    Usar em menus ou listas onde o elemento pode estar fora da área visível
    ...    em dispositivos com DPI menor.
    ...
    ...    Args:
    ...    - locator: Localizador do elemento
    ...    - direction: Direção do swipe — up (padrão) ou down
    ...    - max_swipes: Número máximo de swipes antes de falhar (padrão: 5)
    ...    - swipe_timeout: Timeout de visibilidade por tentativa (padrão: 3s)
    [Arguments]    ${locator}    ${direction}=up    ${max_swipes}=5    ${swipe_timeout}=3s
    Run With Screenshot On Failure    _Do Swipe Until Visible And Click Element    swipe_click_error
    ...    Erro ao localizar e clicar no elemento '${locator}' após ${max_swipes} swipes
    ...    ${locator}    ${direction}    ${max_swipes}    ${swipe_timeout}

_Do Swipe Until Visible And Click Element
    [Arguments]    ${locator}    ${direction}    ${max_swipes}    ${swipe_timeout}
    ${width}=     Get Window Width
    ${height}=    Get Window Height
    ${center_x}=    Evaluate    int(${width} / 2)
    ${start_y}=    Evaluate    int(${height} * 0.70)
    ${end_y}=    Evaluate    int(${height} * 0.30)
    IF    '${direction}' == 'down'
        ${start_y}=    Evaluate    int(${height} * 0.30)
        ${end_y}=    Evaluate    int(${height} * 0.70)
    END
    ${visible_status}    ${err}=    Run Keyword And Ignore Error
    ...    Wait Until Element Is Visible    ${locator}    timeout=${swipe_timeout}
    IF    '${visible_status}' == 'PASS'
        ${loc}=    Get Element Location    ${locator}
        ${el_y}=    Set Variable    ${loc}[y]
        ${in_viewport}=    Evaluate    0 <= int(${el_y}) < int(${height})
        IF    ${in_viewport}
            Click Element    ${locator}
            RETURN
        END
    END
    ${found}=    Set Variable    ${FALSE}
    FOR    ${i}    IN RANGE    ${max_swipes}
        Swipe    start_x=${center_x}    start_y=${start_y}    end_x=${center_x}    end_y=${end_y}    duration=500ms
        ${status}    ${error}=    Run Keyword And Ignore Error
        ...    Wait Until Element Is Visible    ${locator}    timeout=${swipe_timeout}
        IF    '${status}' == 'PASS'
            ${found}=    Set Variable    ${TRUE}
            BREAK
        END
        Log Action    action=swipe_scroll    message=Elemento não visível após swipe
        ...    locator=${locator}    swipe=${i + 1}    max=${max_swipes}    level=WARN
    END
    IF    not ${found}
        Fail    Elemento '${locator}' não encontrado após ${max_swipes} swipes na direção '${direction}'.
    END
    Click Element    ${locator}


Wait Visible And Long Press Element
    [Documentation]    Aguarda o elemento ficar visível e realiza long press.
    ...
    ...    Args:
    ...    - locator: Localizador do elemento
    ...    - duration: Duração em milissegundos (padrão: 2000ms)
    ...
    ...    Exemplos:
    ...    Wait Visible And Long Press Element    ${orders.item1}
    ...    Wait Visible And Long Press Element    ${orders.item1}    duration=3000ms
    [Arguments]    ${locator}    ${duration}=2000ms
    Run With Screenshot On Failure    _Do Wait Visible And Long Press Element    long_press_error
    ...    Erro ao realizar long press no elemento '${locator}'    ${locator}    ${duration}

_Do Wait Visible And Long Press Element
    [Arguments]    ${locator}    ${duration}=2000ms
    Wait Until Element Is Visible    ${locator}
    Tap    ${locator}    count=1    duration=${duration}
    Log Action    action=long_press    message=Long press realizado
    ...    locator=${locator}    duration=${duration}


Click Element Multiple Times
    [Documentation]    Clica no elemento a quantidade de vezes especificada.
    ...
    ...    Args:
    ...    - locator: Localizador do elemento
    ...    - times: Número de cliques
    [Arguments]    ${locator}    ${times}
    FOR    ${i}    IN RANGE    ${times}
        Wait Visible And Click Element    ${locator}
    END


# =============================================================================
# INPUT DE TEXTO
# =============================================================================

Wait Visible And Input Text
    [Documentation]    Aguarda o elemento ficar visível, clica e insere o texto.
    ...
    ...    Args:
    ...    - locator: Localizador do elemento
    ...    - text: Texto a ser inserido
    [Arguments]    ${locator}    ${text}
    Run With Screenshot On Failure    _Do Wait Visible And Input Text    input_error
    ...    Erro ao inserir texto no elemento '${locator}'    ${locator}    ${text}

_Do Wait Visible And Input Text
    [Arguments]    ${locator}    ${text}
    Wait Visible And Click Element    ${locator}
    Input Text    ${locator}    ${text}


Wait Visible And Input Text Pause
    [Documentation]    Aguarda o elemento, clica e digita o texto caractere a caractere.
    ...    Use em campos de pesquisa onde Input Text normal (paste) causa falha.
    ...
    ...    Args:
    ...    - locator: Localizador do elemento
    ...    - text: Texto a ser digitado
    ...    - delay: Pausa entre caracteres (padrão: 0.05s)
    [Arguments]    ${locator}    ${text}    ${delay}=0.05s
    Run With Screenshot On Failure    _Do Wait Visible And Input Text Pause    input_pause_error
    ...    Erro ao digitar texto pausado no elemento '${locator}'    ${locator}    ${text}    ${delay}

_Do Wait Visible And Input Text Pause
    [Arguments]    ${locator}    ${text}    ${delay}=0.05s
    Wait Visible And Click Element    ${locator}
    Input Text Pause    ${locator}    ${text}    ${delay}


Input Text Pause
    [Documentation]    Digita o texto caractere a caractere com pausa entre cada um.
    ...    Simula digitação humana — evita que o app trate como paste e falhe.
    ...
    ...    Args:
    ...    - locator: Localizador do elemento
    ...    - text: Texto a ser digitado
    ...    - delay: Pausa entre caracteres (padrão: 0.05s)
    [Arguments]    ${locator}    ${text}    ${delay}=0.05s
    Run With Screenshot On Failure    _Do Input Text Pause    input_pause_error
    ...    Erro ao digitar texto pausado no elemento '${locator}'    ${locator}    ${text}    ${delay}

_Do Input Text Pause
    [Arguments]    ${locator}    ${text}    ${delay}=0.05s
    Wait Until Element Is Visible    ${locator}
    Clear Text    ${locator}
    ${acumulado}=    Set Variable    ${EMPTY}
    ${len}=    Get Length    ${text}
    FOR    ${i}    IN RANGE    ${len}
        ${char}=    Get Substring    ${text}    ${i}    ${i+1}
        ${acumulado}=    Set Variable    ${acumulado}${char}
        Input Text    ${locator}    ${acumulado}
        Sleep    ${delay}
    END


# =============================================================================
# VISIBILIDADE DE ELEMENTOS
# =============================================================================

Wait For Element To Disappear
    [Documentation]    Aguarda até que o elemento não esteja mais visível na tela.
    ...    Renomeado de 'Wait Until Element Is Not Visible' para evitar colisão
    ...    com keyword de mesmo nome do AppiumLibrary.
    ...
    ...    Args:
    ...    - element: Localizador do elemento
    ...    - timeout: Tempo máximo de espera (padrão: ${DEFAULT_TIMEOUT})
    [Arguments]    ${element}    ${timeout}=${DEFAULT_TIMEOUT}
    Run With Screenshot On Failure    _Do Wait For Element To Disappear    wait_not_visible_error
    ...    Erro ao aguardar desaparecimento do elemento '${element}'    ${element}    ${timeout}

_Do Wait For Element To Disappear
    [Arguments]    ${element}    ${timeout}=${DEFAULT_TIMEOUT}
    Wait Until Page Does Not Contain Element    ${element}    timeout=${timeout}


Assert Element Not Visible
    [Documentation]    Verifica que o elemento não está visível na tela.
    ...    Renomeado de 'Element Should Not Be Visible' para evitar colisão
    ...    com keyword de mesmo nome do AppiumLibrary.
    ...
    ...    Args:
    ...    - element: Localizador do elemento
    [Arguments]    ${element}
    Run With Screenshot On Failure    _Do Assert Element Not Visible    not_visible_error
    ...    Elemento '${element}' ainda está visível quando não deveria    ${element}

_Do Assert Element Not Visible
    [Arguments]    ${element}
    AppiumLibrary.Element Should Not Be Visible    ${element}


# =============================================================================
# TECLADO
# =============================================================================

Close Keyboard
    [Documentation]    Fecha o teclado de forma segura.
    ...    O método (back/hide) é lido do devices.yaml para cada tag via DevicesConfig.
    ...    - back: envia keycode 4 (botão voltar Android)
    ...    - hide: chama Hide Keyboard do AppiumLibrary
    ...    Em caso de falha inesperada, aplica Hide Keyboard como fallback.
    TRY
        IF    '${DEVICE_TAG}' != ''
            ${tag}=    Set Variable    ${DEVICE_TAG}
        ELSE
            ${tag}=    Get Tag From Udid    ${DEVICE_UDID}
        END
        ${tag_lower}=    Convert To Lower Case    ${tag}
        ${method}=    Get Keyboard Close Method    ${tag_lower}
        IF    '${method}' == 'back'
            Press Keycode    4
        ELSE
            Hide Keyboard
        END
        Log Action    action=keyboard_close    message=Teclado fechado
        ...    device=${tag_lower}    method=${method}
    EXCEPT    AS    ${error}
        Log Action    action=keyboard_close_fallback
        ...    message=Fallback Hide Keyboard aplicado
        ...    error=${error}    level=WARN
        Hide Keyboard
    END


# =============================================================================
# UTILITÁRIOS
# =============================================================================

Normalize Digits
    [Documentation]    Remove todos os caracteres não numéricos de uma string.
    ...    Útil para normalizar CPF, telefone, CNPJ, etc.
    ...
    ...    Args:
    ...    - value: String com possíveis pontos, traços, parênteses, espaços
    ...
    ...    Exemplo:
    ...    Normalize Digits    (11) 99999-9999    # retorna 11999999999
    [Arguments]    ${value}
    ${normalized}=    Replace String Using Regexp    ${value}    \\D    ${EMPTY}
    RETURN    ${normalized}
