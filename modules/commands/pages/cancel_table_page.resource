*** Settings ***
Documentation    Ações atômicas — Dialog Cancelar Mesa
Resource    ../../../resources/helpers/common_keywords.resource


*** Keywords ***
Commands - Cancel Table - Verify Advance Alert
    Wait Until Element Is Visible    ${cancel_table.table_advance}

Commands - Cancel Table - Click OK Alert
    Wait Visible And Click Element    ${cancel_table.ok}

Commands - Cancel Table - Verify Reason Field
    Wait Until Element Is Visible    ${cancel_table.cancel_reason}

Commands - Cancel Table - Input Cancel Reason
    [Arguments]    ${reason}
    Wait Visible And Input Text    ${cancel_table.cancel_reason_text}    ${reason}
    Close Keyboard

Commands - Cancel Table - Click Confirm
    Wait Visible And Click Element    ${cancel_table.confirm}

Commands - Cancel Table - Verify Cancel Question
    Wait Until Element Is Visible    ${cancel_table.cancel_question}

Commands - Cancel Table - Click Confirm Cancel
    Wait Visible And Click Element    ${cancel_table.confirm_cancel}

Commands - Cancel Table - Click Abort Cancel
    Wait Visible And Click Element    ${cancel_table.abort_cancel}
