*** Settings ***
Documentation       Ações atômicas — Dialog Juntar Contas

Resource            ../../../resources/helpers/common_keywords.resource


*** Keywords ***
Commands - Join Accounts - Click Table
    Wait Visible And Click Element    ${join_table.table}

Commands - Join Accounts - Click Confirm
    Wait Visible And Click Element    ${join_table.confirm}

Commands - Join Accounts - Click Cancel
    Wait Visible And Click Element    ${join_table.cancel}

Commands - Join Accounts - Verify Join Question
    Wait Until Element Is Visible    ${join_table.join_table_question}

Commands - Join Accounts - Click Confirm Join
    Wait Visible And Click Element    ${join_table.confirm_join}

Commands - Join Accounts - Click Not Join
    Wait Visible And Click Element    ${join_table.confirm_not_join}
