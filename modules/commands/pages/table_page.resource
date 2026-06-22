*** Settings ***
Documentation       Ações atômicas — Tela Mesa Aberta (ComandaMesaScreen)

Resource            ../../../resources/helpers/common_keywords.resource


*** Keywords ***
Commands - Table - Click Menu
    Wait Visible And Click Element With Retry    ${table.menu}    3

Commands - Table - Verify Conference Question
    Wait Until Element Is Visible    ${table.conference_question}

Commands - Table - Click Conference Print
    Wait Visible And Click Element    ${table.conference_print}

Commands - Table - Conference Confirm
    Wait Visible And Click Element    ${table.conference_confirm}

Commands - Table - Conference Cancel
    Wait Visible And Click Element    ${table.conference_cancel}

Commands - Table - Click Tab Products
    Wait Visible And Click Element    ${table.products}

Commands - Table - Click Tab Conference
    Wait Visible And Click Element    ${table.conference}

Commands - Table - Click Tab Released
    Wait Visible And Click Element    ${table.released}

Commands - Table - Click Advance
    Wait Visible And Click Element    ${table.advance}

Commands - Table - Click Cancel
    Wait Visible And Click Element    ${table.cancel}

Commands - Table - Click Filter
    Wait Visible And Click Element    ${table.filter}

Commands - Table - Filter Text
    [Arguments]    ${Text}
    Wait Visible And Input Text    ${table.filter_text}    ${Text}
    Close Keyboard

Commands - Table - Select group
    Wait Visible And Click Element    ${table.group}

Commands - Table - Confirm Filter
    Wait Visible And Click Element    ${table.filter_confirm}

Commands - Table - Click Clean Search
    Wait Visible And Click Element    ${table.clean_search}

Commands - Table - Empty State
    Wait Until Element Is Visible    ${table.empty_state}

Commands - Table - Receive Order
    Wait Visible And Click Element    ${table.receive_order}

Commands - Table - Click Remove Item
    Wait Visible And Click Element    ${table.remove_item}

Commands - Table - Confirm Remove Item
    Wait Visible And Click Element    ${table.remove_item_confirm}

Commands - Table - Cancel Remove Item
    Wait Visible And Click Element    ${table.remove_item_cancel}

Commands - Table - Verify Remove Item Text
    Wait Until Element Is Visible    ${table.remove_item_text}
