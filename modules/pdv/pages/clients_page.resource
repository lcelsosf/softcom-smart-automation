*** Settings ***
Documentation    Ações atômicas — Tela de Clientes (ClientsScreen)
Resource    ../../../resources/helpers/common_keywords.resource


*** Keywords ***
Pdv - Clients - Click New Client
    Wait Visible And Click Element    ${clients.new_client}

Pdv - Clients - Click Type Client
    Wait Visible And Click Element    ${clients.type_client}

Pdv - Clients - Click Type Fisic
    Wait Visible And Click Element    ${clients.Fisic}

Pdv - Clients - Click Type Juridic
    Wait Visible And Click Element    ${clients.Juridic}

Pdv - Clients - Input CPF
    [Arguments]    ${cpf}
    Wait Visible And Input Text    ${clients.cpf}    ${cpf}
    Close Keyboard

Pdv - Clients - Input Name
    [Arguments]    ${name}
    Wait Visible And Input Text    ${clients.name}    ${name}
    Close Keyboard

Pdv - Clients - Input Telephone
    [Arguments]    ${telephone}
    Wait Visible And Input Text    ${clients.telephone}    ${telephone}
    Close Keyboard

Pdv - Clients - Input Email
    [Arguments]    ${email}
    Wait Visible And Input Text    ${clients.email}    ${email}
    Close Keyboard

Pdv - Clients - Click Address Page
    Wait Visible And Click Element    ${clients.address_page}

Pdv - Clients - Input CEP
    [Arguments]    ${cep}
    Wait Visible And Input Text    ${clients.cep}    ${cep}
    Close Keyboard

Pdv - Clients - Input Address
    [Arguments]    ${address}
    Wait Visible And Input Text    ${clients.address}    ${address}
    Close Keyboard

Pdv - Clients - Input Number
    [Arguments]    ${number}
    Wait Visible And Input Text    ${clients.number}    ${number}
    Close Keyboard

Pdv - Clients - Input Neighborhood
    [Arguments]    ${neighborhood}
    Wait Visible And Input Text    ${clients.neighborhood}    ${neighborhood}
    Close Keyboard

Pdv - Clients - Click UF
    Wait Visible And Click Element    ${clients.UF}

Pdv - Clients - Click UF PB
    Wait Visible And Click Element    ${clients.UF_PB}

Pdv - Clients - Click City
    Wait Visible And Click Element    ${clients.city}

Pdv - Clients - Click City Select
    Wait Visible And Click Element    ${clients.city_select}

Pdv - Clients - Input Complement
    [Arguments]    ${complement}
    Wait Visible And Input Text    ${clients.complement}    ${complement}
    Close Keyboard

Pdv - Clients - Click Save
    Wait Visible And Click Element    ${clients.save}

Pdv - Clients - Click Back
    Wait Visible And Click Element    ${clients.back_clients}

Pdv - Clients - Input Search
    [Arguments]    ${name}
    Wait Visible And Input Text    ${clients.search_client}    ${name}
    Close Keyboard

Pdv - Clients - Click Client 1
    Wait Visible And Click Element    ${clients.client1}

Pdv - Clients - Click New Order Client
    Wait Visible And Click Element    ${clients.new_order_client}
