*** Settings ***
Documentation    Ações atômicas — Tela de Sincronização (SyncScreen)
Resource    ../../../resources/helpers/common_keywords.resource


*** Keywords ***
Pdv - Sync - Click Products
    Wait Visible And Click Element    ${sync.products}

Pdv - Sync - Click Clients
    Wait Visible And Click Element    ${sync.clients}

Pdv - Sync - Click Orders
    Wait Visible And Click Element    ${sync.orders}

Pdv - Sync - Click Sync Button
    Wait Visible And Click Element    ${sync.sync_button}

Pdv - Sync - Click Cancel
    Wait Visible And Click Element    ${sync.sync_cancel}

Pdv - Sync - Verify Sync Done
    Wait Until Element Is Visible    ${sync.sync_text}    timeout=${ELEMENT_TIMEOUT}

Pdv - Sync - Click Sync Confirm
    Wait Visible And Click Element    ${sync.sync_confirm}
