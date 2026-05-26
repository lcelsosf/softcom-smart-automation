*** Settings ***
Documentation    Ações atômicas — Tela de checkout do módulo PDV.
Resource    ../../../resources/helpers/common_keywords.resource


*** Keywords ***
Pdv - Checkout - Click Back
    Wait Visible And Click Element    ${Checkout.btn_back}

Pdv - Checkout - Click Sync
    Wait Visible And Click Element    ${Checkout.btn_sync}

Pdv - Checkout - Click Method By Name
    [Arguments]    ${method_name}
    ${locator}=    Replace String    ${Checkout.method_by_name}    METHOD_NAME    ${method_name}
    Wait Visible And Click Element    ${locator}

Pdv - Checkout - Click Selected Method Actions
    Wait Visible And Click Element    ${Checkout.selected_method_actions}

Pdv - Checkout - Click Finish Sale
    Wait Visible And Click Element    ${Checkout.btn_finish_sale}

Pdv - Checkout - Click Value Clear
    Wait Visible And Click Element    ${payment_value_modal.key_clear}

Pdv - Checkout - Click Value Backspace
    Wait Visible And Click Element    ${payment_value_modal.key_backspace}

Pdv - Checkout - Click Value Cancel
    Wait Visible And Click Element    ${payment_value_modal.btn_cancel}

Pdv - Checkout - Click Value Confirm
    Wait Visible And Click Element    ${payment_value_modal.btn_confirm}

Pdv - Checkout - Click Bank Slip Add
    Wait Visible And Click Element    ${bank_slip.btn_add}

Pdv - Checkout - Click Bank Slip Sub
    Wait Visible And Click Element    ${bank_slip.btn_sub}

Pdv - Checkout - Input Bank Slip Term
    [Arguments]    ${text}
    Wait Visible And Input Text    ${bank_slip.term_input}    ${text}
    Close Keyboard

Pdv - Checkout - Click Calendar
    Wait Visible And Click Element    ${bank_slip.calendar}

Pdv - Checkout - Click Day By Number
    [Arguments]    ${day_number}
    ${locator}=    Replace String    ${bank_slip.day_by_number}    DAY_NUMBER    ${day_number}
    Wait Visible And Click Element    ${locator}
