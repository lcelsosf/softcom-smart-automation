*** Settings ***
Documentation       Ações atômicas — Dialog Alterar Cliente (CustomerChangeDialog)

Resource            ../../../resources/helpers/common_keywords.resource


*** Keywords ***
Commands - Change Client - Input Client Name
    [Arguments]    ${name}
    Wait Visible And Input Text    ${change_client.client}    ${name}
    Close Keyboard

Commands - Change Client - Click Search
    Wait Visible And Click Element    ${change_client.search}

Commands - Change Client - Click Add People
    Wait Visible And Click Element    ${change_client.add_people}

Commands - Change Client - Click Sub People
    Wait Visible And Click Element    ${change_client.sub_people}

Commands - Change Client - Click Confirm
    Wait Visible And Click Element    ${change_client.confirm}

Commands - Change Client - Click Cancel
    Wait Visible And Click Element    ${change_client.cancel}
