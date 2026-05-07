*** Settings ***
Documentation    Ações atômicas — Tela Faturamento / Pagamento
Resource    ../../../resources/helpers/common_keywords.resource


*** Keywords ***
Commands - Invoice - Click Payment Money
    Wait Visible And Click Element    ${invoice.money}

Commands - Invoice - Click Payment Pixoff
    Wait Visible And Click Element    ${invoice.pixoff}

Commands - Invoice - Click Confirm Value
    Wait Visible And Click Element    ${invoice.confirm}

Commands - Invoice - Click Cancel Value
    Wait Visible And Click Element    ${invoice.cancel}

Commands - Invoice - Click Finalize Sale
    Wait Visible And Click Element    ${invoice.finalize_sale}
