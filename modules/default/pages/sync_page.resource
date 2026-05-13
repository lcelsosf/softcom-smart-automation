*** Settings ***
Documentation    Ações atômicas — Dialog de Sincronização
Resource         ../../../resources/helpers/common_keywords.resource


*** Keywords ***
Default - Sync - Toggle Products
    Wait Visible And Click Element    ${sync.products}

Default - Sync - Toggle Clients
    Wait Visible And Click Element    ${sync.clients}

Default - Sync - Toggle Orders
    Wait Visible And Click Element    ${sync.orders}

Default - Sync - Click Sync Button
    Wait Visible And Click Element    ${sync.sync_button}

Default - Sync - Click Ok
    Wait Visible And Click Element    ${sync.ok_button}

Default - Sync - Click Cancel
    Wait Visible And Click Element    ${sync.cancel_button}
