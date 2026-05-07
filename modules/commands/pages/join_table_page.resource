*** Settings ***
Documentation    Ações atômicas — Dialog Juntar Contas
Resource    ../../../resources/helpers/common_keywords.resource


*** Keywords ***
Commands - Join Table - Click Table
    Wait Visible And Click Element    ${join_table.table}

Commands - Join Table - Click Confirm
    Wait Visible And Click Element    ${join_table.confirm}

Commands - Join Table - Click Cancel
    Wait Visible And Click Element    ${join_table.cancel}

Commands - Join Table - Verify Join Question
    Wait Until Element Is Visible    ${join_table.join_table_question}

Commands - Join Table - Click Confirm Join
    Wait Visible And Click Element    ${join_table.confirm_join}

Commands - Join Table - Click Not Join
    Wait Visible And Click Element    ${join_table.confirm_not_join}
