*** Settings ***
Documentation    Ações atômicas — Tela Home e status do pedido do módulo PDV.
Resource    ../../../resources/helpers/common_keywords.resource


*** Keywords ***
Pdv - Home - Verify Visible
    Wait Until Element Is Visible    ${home.btn_new_order}

Pdv - Home - Click New Order
    Wait Visible And Click Element    ${home.btn_new_order}

Pdv - Home - Click List Orders
    Wait Visible And Click Element    ${home.btn_orders_list}

Pdv - Home - Click Clients
    Wait Visible And Click Element    ${home.btn_clients}

Pdv - Home - Click Sync
    Wait Visible And Click Element    ${home.btn_sync}

Pdv - Home - Click Settings
    Wait Visible And Click Element    ${home.btn_settings}

Pdv - Home - Click Logoff
    Wait Visible And Click Element    ${home.btn_logoff}

Pdv - Logoff - Verify Visible
    Wait Until Element Is Visible    ${logoff.text_confirmation}

Pdv - Logoff - Click Confirm
    Wait Visible And Click Element    ${logoff.btn_yes}

Pdv - Logoff - Click Cancel
    Wait Visible And Click Element    ${logoff.btn_no}

Pdv - Orders Status - Click Reprint
    Wait Visible And Click Element    ${orders_status.btn_reprint}

Pdv - Orders Status - Click New Order
    Wait Visible And Click Element    ${orders_status.btn_new_order}

Pdv - Orders Status - Click Share
    Wait Visible And Click Element    ${orders_status.btn_share}

Pdv - Orders Status - Click Home
    Wait Visible And Click Element    ${orders_status.btn_home}

Pdv - Orders - Click Home
    Wait Visible And Click Element    ${orders_status.btn_home}
