*** Settings ***
Documentation    Ações atômicas — Tela de Pedidos / Carrinho (OrdersScreen / CartScreen)
Resource    ../../../resources/helpers/common_keywords.resource


*** Keywords ***
Pdv - Orders - Search Item
    [Arguments]    ${Text}
    Wait Visible And Input Text    ${orders.item_search}    ${Text}
    Close Keyboard

Pdv - Orders - Click Item
    Wait Visible And Click Element    ${orders.item}

Pdv - Orders - Click Item 2
    Wait Visible And Click Element    ${orders.item2}

Pdv - Orders - Click Item Discount
    Wait Visible And Click Element    ${orders.item_discount}

Pdv - Orders - Click Conference
    Wait Visible And Click Element    ${orders.conference}

Pdv - Orders - Click Finalize Order
    Wait Visible And Click Element    ${orders.finalize_order}

Pdv - Orders - Click Payment Money
    Wait Visible And Click Element    ${orders.money}

Pdv - Orders - Click Payment Pixoff
    Wait Visible And Click Element    ${orders.pixoff}

Pdv - Orders - Click Payment Bankslip
    Wait Visible And Click Element    ${orders.bankslip}

Pdv - Orders - Click Confirm Value
    Wait Visible And Click Element    ${orders.confirm_value}

Pdv - Orders - Click Finish Order
    Wait Visible And Click Element    ${orders.finish_order}

Pdv - Orders - Click Home
    Wait Visible And Click Element    ${orders.home}

Pdv - Orders - Click Cancel Order New
    Wait Visible And Click Element    ${orders.cancel_order_new_order}

Pdv - Orders - Click Cancel Order Cart
    Wait Visible And Click Element    ${orders.cancel_order2}

Pdv - Orders - Verify Cancel Dialog
    Wait Until Element Is Visible    ${orders.cancel_order_text}

Pdv - Orders - Click Cancel Confirm
    Wait Visible And Click Element    ${orders.cancel_order_confirm}

Pdv - Orders - Click Cancel Cancel
    Wait Visible And Click Element    ${orders.cancel_order_cancel}

Pdv - Orders - Click Quantity Add
    Wait Visible And Click Element    ${orders.quantity_add}

Pdv - Orders - Click Quantity Remove
    Wait Visible And Click Element    ${orders.quantity_remove}

Pdv - Orders - Click Quantity Field
    Wait Visible And Click Element    ${orders.quantity}

Pdv - Orders - Input Quantity
    [Arguments]    ${quantity}
    Clear Text    ${orders.quantity_input}
    Wait Visible And Input Text    ${orders.quantity_input}    ${quantity}
    Close Keyboard

Pdv - Orders - Click Quantity Confirm
    Wait Visible And Click Element    ${orders.quantity_confirm}

Pdv - Orders - Click Client Search
    Wait Visible And Click Element    ${orders.client_search}

Pdv - Orders - Click Clean Search 
    Wait Visible And Click Element    ${orders.clean_search}
    
Pdv - Orders - Click Client Consumer
    Wait Visible And Click Element    ${orders.client}

Pdv - Orders - Input Client Name
    [Arguments]    ${client_name}
    Clear Text    ${orders.client_text}
    Wait Visible And Input Text    ${orders.client_text}    ${client_name}
    Close Keyboard

Pdv - Orders - Click Client Credit
    Wait Visible And Click Element    ${orders.client_credit}

Pdv - Orders - Click Client Confirm
    Wait Visible And Click Element    ${orders.client_confirm}

Pdv - Orders - Click Cart
    Wait Visible And Click Element    ${orders.cart}

Pdv - Orders - Click Discount-Sum
    Wait Visible And Click Element    ${orders.discount_sum}

Pdv - Orders - Click Discount
    Wait Visible And Click Element    ${orders.discount}

Pdv - Orders - Click R$
    Wait Visible And Click Element    ${orders.r_currency}

Pdv - Orders - Click Percent
    Wait Visible And Click Element    ${orders.percent}

Pdv - Orders - Click Apply Discount
    Wait Visible And Click Element    ${orders.apply}

Pdv - Orders - Click Remove Discount
    Wait Visible And Click Element    ${orders.apply}

Pdv - Orders - Input Discount Value
    [Arguments]    ${value}
    Wait Visible And Input Text    ${orders.discount_value}    ${value}
    Close Keyboard

Pdv - Orders - Clear And Input Discount Value
    [Arguments]    ${value}
    Wait Visible And Click Element    ${orders.discount_value}
    Clear Text    ${orders.discount_value}
    Wait Visible And Input Text    ${orders.discount_value}    ${value}
    Close Keyboard

Pdv - Orders - Long Press Item 2
    Wait Visible And Long Press Element    ${orders.item2}

Pdv - Orders - Click Remove Item
    Wait Visible And Click Element    ${orders.remove_item}

Pdv - Orders - Verify Remove Item Dialog
    Wait Until Element Is Visible    ${orders.remove_item_text}

Pdv - Orders - Click Remove Item Confirm
    Wait Visible And Click Element    ${orders.remove_item_confirm}

Pdv - Orders - Click Remove Item Cancel
    Wait Visible And Click Element    ${orders.remove_item_cancel}

Pdv - Orders - Click Remove Item Icon
    Wait Visible And Click Element    ${orders.remove_item_icon}

Pdv - Orders - Click Bankslip Parcel Add
    Wait Visible And Click Element    ${orders.bankslip_parce_add}

Pdv - Orders - Click Bankslip Parcel Remove
    Wait Visible And Click Element    ${orders.bankslip_parce_remove}

Pdv - Orders - Click Bankslip Term Calendar
    Wait Visible And Click Element    ${orders.bankslip_term_calendar}

Pdv - Orders - Click Bankslip Term Prefix
    Wait Visible And Click Element    ${orders.bankslip_term_prefix}

Pdv - Orders - Input Bankslip Term
    [Arguments]    ${days}
    Clear Text    ${orders.bankslip_term}
    Wait Visible And Input Text    ${orders.bankslip_term}    ${days}
    Close Keyboard
