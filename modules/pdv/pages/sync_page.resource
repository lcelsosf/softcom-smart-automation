*** Settings ***
Documentation    Page object dos modais de Sincronização de Dados.

*** Keywords ***
# =============================================================================
# MODAL — SINCRONIZAR DADOS
# =============================================================================

Sync - Modal Should Be Visible
    [Documentation]    Verifica que o modal "Sincronizar Dados" está aberto.
    Wait Until Element Is Visible With Retry    ${sync_modal.title}    timeout=${ELEMENT_TIMEOUT}

Sync - Modal Should Not Be Visible
    [Documentation]    Verifica que o modal "Sincronizar Dados" foi fechado.
    Wait For Element To Disappear    ${sync_modal.title}

Sync - Select Products
    [Documentation]    Seleciona/deseleciona a opção "Produtos".
    Sync - Tap Option    ${sync_modal.option_products}

Sync - Select Clients
    [Documentation]    Seleciona/deseleciona a opção "Clientes".
    Sync - Tap Option    ${sync_modal.option_clients}

Sync - Select Orders
    [Documentation]    Seleciona/deseleciona a opção "Pedidos".
    Sync - Tap Option    ${sync_modal.option_orders}

Sync - Click Sync Button
    [Documentation]    Clica em "Sincronizar" para iniciar a sincronização.
    ...    Atenção: o botão está desabilitado até que ao menos uma opção
    ...    seja selecionada.
    Sync - Tap Element At Percent    ${sync_modal.btn_sync}

Sync - Tap Option
    [Documentation]    Toca a opção no primeiro quarto do elemento.
    ...    No modal de sync há views sobrepostas na metade inferior das opções;
    ...    clicar no centro pode acionar a opção errada ou não selecionar nada.
    [Arguments]    ${locator}
    Sync - Tap Element At Percent    ${locator}    50    25

Sync - Tap Element At Percent
    [Documentation]    Toca um elemento usando coordenadas relativas ao seu retângulo.
    [Arguments]    ${locator}    ${x_percent}=50    ${y_percent}=50
    Wait Until Element Is Visible With Retry    ${locator}    timeout=${ELEMENT_TIMEOUT}
    ${location}=    Get Element Location    ${locator}
    ${size}=    Get Element Size    ${locator}
    ${tap_x}=    Evaluate    int(${location}[x] + (${size}[width] * float(${x_percent}) / 100))
    ${tap_y}=    Evaluate    int(${location}[y] + (${size}[height] * float(${y_percent}) / 100))
    ${coordinates}=    Create List    ${tap_x}    ${tap_y}
    Tap    ${coordinates}

Sync - Click Cancel
    [Documentation]    Clica em "Cancelar" — fecha o modal sem sincronizar.
    Wait Visible And Click Element With Retry    ${sync_modal.btn_cancel}

# =============================================================================
# MODAL — ATUALIZAÇÃO CONCLUÍDA
# =============================================================================

Sync - Success Modal Should Be Visible
    [Documentation]    Verifica que o modal "Atualização concluída!" está visível.
    Wait Until Element Is Visible With Retry    ${sync_success_modal.title}    timeout=${ELEMENT_TIMEOUT}

Sync - Success Modal Should Not Be Visible
    [Documentation]    Verifica que o modal "Atualização concluída!" foi fechado.
    Wait For Element To Disappear    ${sync_success_modal.title}

Sync - Click Success Ok
    [Documentation]    Clica em "Ok" — fecha o modal de confirmação.
    Wait Visible And Click Element With Retry    ${sync_success_modal.btn_ok}
