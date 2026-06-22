*** Settings ***
Documentation       Ações atômicas — Tela Selecionar Cliente (ComandaSelecionarClienteScreen)

Resource            ../../../resources/helpers/common_keywords.resource


*** Keywords ***
Commands - Client - Search Client
    [Arguments]    ${name}
    Wait Visible And Input Text    ${client.search_client}    ${name}
    Close Keyboard

Commands - Client - Click Client Item
    Wait Visible And Click Element    ${client.client_item}

Commands - Client - Click New Client
    Wait Visible And Click Element    ${client.new_client}

Commands - Client - Click Back
    Wait Visible And Click Element    ${client.back}

Commands - Client - Click Refresh
    Wait Visible And Click Element    ${client.refresh}
