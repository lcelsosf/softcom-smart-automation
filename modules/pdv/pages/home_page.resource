*** Settings ***
Documentation       Ações atômicas — Tela Home e status do pedido do módulo PDV.

Resource            ../../../resources/helpers/common_keywords.resource


*** Keywords ***
Pdv - Home - Verify Visible
    [Documentation]    Card "Novo Pedido" — destaque na home.
    Wait Until Element Is Visible    ${home.btn_new_order}

Pdv - Home - Click New Order
    [Documentation]    Card "Novo Pedido" — destaque na home.
    Wait Visible And Click Element    ${home.btn_new_order}

Pdv - Home - Click List Orders
    [Documentation]    Card "Lista de Pedidos".
    Wait Visible And Click Element    ${home.btn_orders_list}

Pdv - Home - Click Clients
    [Documentation]    Card "Clientes".
    Wait Visible And Click Element    ${home.btn_clients}

Pdv - Home - Click Sync
    [Documentation]    Card "Sincronizar Dados".
    Wait Visible And Click Element    ${home.btn_sync}

Pdv - Home - Click Settings
    [Documentation]    Card "Configurações".
    Wait Visible And Click Element    ${home.btn_settings}

Pdv - Home - Click Logoff
    [Documentation]    Card "Logoff".
    Wait Visible And Click Element    ${home.btn_logoff}

Pdv - Logoff - Verify Visible
    [Documentation]    Texto de confirmação.
    Wait Until Element Is Visible    ${logoff.text_confirmation}

Pdv - Logoff - Click Confirm
    [Documentation]    Botão "Sim" — confirma o logoff.
    Wait Visible And Click Element    ${logoff.btn_yes}

Pdv - Logoff - Click Cancel
    [Documentation]    Botão "Não" — cancela o logoff.
    Wait Visible And Click Element    ${logoff.btn_no}

Pdv - Orders Status - Click Reprint
    [Documentation]    Botão Reimprimir (top bar).
    Wait Visible And Click Element    ${orders_status.btn_reprint}

Pdv - Orders Status - Click New Order
    [Documentation]    Botão "Novo Pedido" — inicia um novo ciclo de venda.
    Wait Visible And Click Element    ${orders_status.btn_new_order}

Pdv - Orders Status - Click Share
    [Documentation]    Botão "Compartilhar" — compartilha o comprovante.
    Wait Visible And Click Element    ${orders_status.btn_share}

Pdv - Orders Status - Click Home
    [Documentation]    Botão "Tela Inicial" — retorna para a Home.
    Wait Visible And Click Element    ${orders_status.btn_home}

Pdv - Orders - Click Home
    [Documentation]    Botão "Tela Inicial" — retorna para a Home.
    Wait Visible And Click Element    ${orders_status.btn_home}
