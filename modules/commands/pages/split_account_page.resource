*** Settings ***
Documentation    Ações atômicas — Dialog Dividir Conta
Resource    ../../../resources/helpers/common_keywords.resource


*** Keywords ***
Commands - Split Account - Verify Visible
    Wait Until Element Is Visible    ${split_account.split_account}

Commands - Split Account - Click Add People
    Wait Visible And Click Element    ${split_account.add_people}

Commands - Split Account - Click Sub People
    Wait Visible And Click Element    ${split_account.sub_people}

Commands - Split Account - Click Back
    Wait Visible And Click Element    ${split_account.back}
