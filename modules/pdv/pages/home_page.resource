*** Settings ***
Documentation    Ações atômicas — Tela Inicial (HomeScreen)
Resource    ../../../resources/helpers/common_keywords.resource


*** Keywords ***
Pdv - Home - Click New Order
    Wait Visible And Click Element    ${home.new_order}

Pdv - Home - Click List Orders
    Wait Visible And Click Element    ${home.list_orders}

Pdv - Home - Click Sync
    Wait Visible And Click Element    ${home.sync}

Pdv - Home - Click Clients
    Wait Visible And Click Element    ${home.clients}

Pdv - Home - Click Settings
    Wait Visible And Click Element    ${home.settings}

Pdv - Home - Click Logoff
    Wait Visible And Click Element    ${home.logoff}

Pdv - Home - Click Logoff Confirm
    Wait Visible And Click Element    ${home.logoff_confirm}

Pdv - Home - Verify Visible
    Wait Until Element Is Visible    ${home.home}
