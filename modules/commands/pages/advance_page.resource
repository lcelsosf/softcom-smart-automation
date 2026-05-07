*** Settings ***
Documentation    Ações atômicas — Tela Adiantamentos + Dialog Novo Adiantamento
Resource    ../../../resources/helpers/common_keywords.resource


*** Keywords ***
Commands - Advance - Click New Advance
    Wait Visible And Click Element    ${advance.new_advance}

Commands - Advance - Click Back
    Wait Visible And Click Element    ${advance.back}

Commands - Advance - Click Print
    Wait Visible And Click Element    ${advance.print}

Commands - Advance - Input Client Name
    [Arguments]    ${name}
    Wait Visible And Click Element    ${advance.advance_client}
    Wait Visible And Input Text    ${advance.advance_client_text}    ${name}
    Close Keyboard

Commands - Advance - Input Value
    [Arguments]    ${value}
    Wait Visible And Click Element    ${advance.advance_value}
    Wait Visible And Input Text    ${advance.advance_value_text}    ${value}
    Close Keyboard

Commands - Advance - Click Payment Form
    Wait Visible And Click Element    ${advance.advance_paymentform}

Commands - Advance - Select Payment Money
    Wait Visible And Click Element    ${advance.advance_money}

Commands - Advance - Select Payment Pixoff
    Wait Visible And Click Element    ${advance.advance_pixoff}

Commands - Advance - Click Confirm
    Wait Visible And Click Element    ${advance.advance_confirm}

Commands - Advance - Click Cancel
    Wait Visible And Click Element    ${advance.advance_cancel}
