*** Settings ***
Documentation    Ações atômicas — Tela de Lista de Pedidos (ListOrdersScreen)
Resource    ../../../resources/helpers/common_keywords.resource


*** Keywords ***
Pdv - List Orders - Click First Order
    Wait Visible And Click Element    ${list_orders.order1}

Pdv - List Orders - Click Visualize Order
    Wait Visible And Click Element    ${list_orders.visualize_order}

Pdv - List Orders - Verify Details Visible
    Wait Until Element Is Visible    ${list_orders.details_order}

Pdv - List Orders - Click Back
    Wait Visible And Click Element    ${list_orders.back_list_orders}

Pdv - List Orders - Click Reprint
    Wait Visible And Click Element    ${list_orders.reprint}

Pdv - List Orders - Verify Reprint Visible
    Wait Until Element Is Visible    ${list_orders.reprint_text}

Pdv - List Orders - Click Cancel Order
    Wait Visible And Click Element    ${list_orders.list_cancel_order}

Pdv - List Orders - Verify Cancel Dialog
    Wait Until Element Is Visible    ${list_orders.list_cancel_order_text}

Pdv - List Orders - Click Cancel Confirm
    Wait Visible And Click Element    ${list_orders.list_cancel_order_confirm}

Pdv - List Orders - Click Cancel Cancel
    Wait Visible And Click Element    ${list_orders.list_cancel_order_cancel}

Pdv - List Orders - Click Print
    Wait Visible And Click Element    ${list_orders.print}

Pdv - List Orders - Click Receipts
    Wait Visible And Click Element    ${list_orders.receipts}

Pdv - List Orders - Click Sales Summary
    Wait Visible And Click Element    ${list_orders.sales_summary}

Pdv - List Orders - Click Print Back
    Wait Visible And Click Element    ${list_orders.print_back}
