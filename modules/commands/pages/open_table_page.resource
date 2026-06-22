*** Settings ***
Documentation       Ações atômicas — Dialog Abrir Mesa (OpenMesaDialog)

Resource            ../../../resources/helpers/common_keywords.resource


*** Keywords ***
Commands - Open Table - Input Number Table
    [Arguments]    ${number}
    Wait Visible And Input Text    ${open_table.number_table}    ${number}
    Close Keyboard

Commands - Open Table - Input Comanda Number
    [Arguments]    ${number}
    Wait Visible And Input Text    ${open_table.comanda_number}    ${number}
    Close Keyboard

Commands - Open Table - Input Client Name
    [Arguments]    ${name}
    Wait Visible And Input Text    ${open_table.client_name}    ${name}
    Close Keyboard

Commands - Open Table - Click Search Client
    Wait Visible And Click Element    ${open_table.search_client}

Commands - Open Table - Click Add People
    Wait Visible And Click Element    ${open_table.add_people}

Commands - Open Table - Click Sub People
    Wait Visible And Click Element    ${open_table.sub_people}

Commands - Open Table - Click Confirm
    Wait Visible And Click Element    ${open_table.confirm}

Commands - Open Table - Click Cancel
    Wait Visible And Click Element    ${open_table.cancel}
