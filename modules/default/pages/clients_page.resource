*** Settings ***
Documentation    Ações atômicas — Tela de Cadastro de Clientes
Resource         ../../../resources/helpers/common_keywords.resource


*** Keywords ***
Default - Clients - Click Add Client
    Wait Visible And Click Element    ${clients.add_client}

Default - Clients - Type CPF
    [Arguments]    ${cpf}
    Input Text    ${clients.cpf}    ${cpf}
    Close Keyboard

Default - Clients - Type Name
    [Arguments]    ${name}
    Input Text    ${clients.name}    ${name}
    Close Keyboard

Default - Clients - Type Email
    [Arguments]    ${email}
    Input Text    ${clients.email}    ${email}
    Close Keyboard

Default - Clients - Type Zip Code
    [Arguments]    ${zip_code}
    Input Text    ${clients.zip_code}    ${zip_code}
    Close Keyboard

Default - Clients - Type Address
    [Arguments]    ${address}
    Input Text    ${clients.address}    ${address}
    Close Keyboard

Default - Clients - Type Number
    [Arguments]    ${number}
    Input Text    ${clients.number}    ${number}
    Close Keyboard

Default - Clients - Type Neighborhood
    [Arguments]    ${neighborhood}
    Input Text    ${clients.neighborhood}    ${neighborhood}
    Close Keyboard

Default - Clients - Type Complement
    [Arguments]    ${complement}
    Input Text    ${clients.complement}    ${complement}
    Close Keyboard

Default - Clients - Type State
    [Arguments]    ${state}
    Input Text    ${clients.state}    ${state}
    Close Keyboard

Default - Clients - Type City
    [Arguments]    ${city}
    Input Text    ${clients.city}    ${city}
    Close Keyboard

Default - Clients - Type DDD
    [Arguments]    ${ddd}
    Input Text    ${clients.ddd}    ${ddd}
    Close Keyboard

Default - Clients - Type Telephone
    [Arguments]    ${telephone}
    Input Text    ${clients.telephone}    ${telephone}
    Close Keyboard

Default - Clients - Save Client
    Wait Visible And Click Element    ${clients.save_client}

Default - Clients - Exit Client
    Wait Visible And Click Element    ${clients.exit_client}

Default - Clients - Click Search Bar
    Wait Visible And Click Element    ${orders.client_search}
