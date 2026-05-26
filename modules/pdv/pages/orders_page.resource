*** Settings ***
Documentation    Ações atômicas — Tela de pedidos e carrinho do módulo PDV.
Resource    ../../../resources/helpers/common_keywords.resource


*** Keywords ***
Pdv - Orders - Click Back
    Wait Visible And Click Element    ${orders.btn_back}

Pdv - Orders - Click Cancel Order New
    Wait Visible And Click Element    ${orders.btn_cancel}

Pdv - Orders - Search Item
    [Arguments]    ${text}
    Wait Visible And Input Text    ${orders.search_input}    ${text}
    Close Keyboard

Pdv - Orders - Click Filter All
    Wait Visible And Click Element    ${orders.filter_all}

Pdv - Orders - Click Conference
    Wait Visible And Click Element    ${orders.btn_checkout}

Pdv - Orders - Click Quantity Field
    Wait Visible And Click Element    ${quantity_modal.quantity_input}

Pdv - Orders - Input Quantity
    [Arguments]    ${text}
    Wait Visible And Input Text    ${quantity_modal.quantity_input}    ${text}
    Close Keyboard

Pdv - Orders - Click Quantity Remove
    Wait Visible And Click Element    ${quantity_modal.quantity_sub}

Pdv - Orders - Click Quantity Add
    Wait Visible And Click Element    ${quantity_modal.quantity_add}

Pdv - Orders - Click Remove Item
    Wait Visible And Click Element    ${quantity_modal.btn_remove_item}

Pdv - Orders - Click Quantity Confirm
    Wait Visible And Click Element    ${quantity_modal.btn_confirm}

Pdv - Orders - Verify Remove Item Dialog
    Wait Until Element Is Visible    ${order_remove_dialog.confirm_message}

Pdv - Orders - Click Remove Item Cancel
    Wait Visible And Click Element    ${order_remove_dialog.btn_no}

Pdv - Orders - Click Remove Item Confirm
    Wait Visible And Click Element    ${order_remove_dialog.btn_yes}

Pdv - Orders - Verify Cancel Dialog
    Wait Until Element Is Visible    ${order_cancel_dialog.confirm_message}

Pdv - Orders - Click Cancel Cancel
    Wait Visible And Click Element    ${order_cancel_dialog.btn_no}

Pdv - Orders - Click Cancel Confirm
    Wait Visible And Click Element    ${order_cancel_dialog.btn_yes}

Pdv - Orders - Click Cart Back
    Wait Visible And Click Element    ${cart.btn_back}

Pdv - Orders - Click Cancel Order Cart
    Wait Visible And Click Element    ${cart.btn_cancel}

Pdv - Orders - Click Edit Client
    Wait Visible And Click Element    ${cart.btn_edit_client}

Pdv - Orders - Click Remove Item Icon
    Wait Visible And Click Element    ${cart.item_btn_remove}

Pdv - Orders - Click Cart Item Sub
    Wait Visible And Click Element    ${cart.item_btn_sub}

Pdv - Orders - Click Cart Item Quantity
    Wait Visible And Click Element    ${cart.item_quantity}

Pdv - Orders - Click Cart Item Add
    Wait Visible And Click Element    ${cart.item_btn_add}

Pdv - Orders - Click Discount-Sum
    Wait Visible And Click Element    ${cart.btn_discount}

Pdv - Orders - Click Cart
    Wait Visible And Click Element    ${cart.btn_add_items}

Pdv - Orders - Click Finalize Order
    Wait Visible And Click Element    ${cart.btn_finish_order}

Pdv - Orders - Input Client Modal Client
    [Arguments]    ${text}
    Wait Visible And Input Text    ${client_modal.client_input}    ${text}
    Close Keyboard

Pdv - Orders - Input Client Modal CPF
    [Arguments]    ${text}
    Wait Visible And Input Text    ${client_modal.cpf_input}    ${text}
    Close Keyboard

Pdv - Orders - Click Register Client
    Wait Visible And Click Element    ${client_modal.btn_register_client}

Pdv - Orders - Click Client Modal Cancel
    Wait Visible And Click Element    ${client_modal.btn_cancel}

Pdv - Orders - Click Client Modal Confirm
    Wait Visible And Click Element    ${client_modal.btn_confirm}

Pdv - Orders - Verify Remove Item Icon Dialog
    Wait Until Element Is Visible    ${item_remove_dialog.confirm_message}

Pdv - Orders - Click Remove Item Icon Cancel
    Wait Visible And Click Element    ${item_remove_dialog.btn_no}

Pdv - Orders - Click Remove Item Icon Confirm
    Wait Visible And Click Element    ${item_remove_dialog.btn_yes}

Pdv - Orders - Click Discount
    Wait Visible And Click Element    ${discount_modal.tab_discount}

Pdv - Orders - Click Addition
    Wait Visible And Click Element    ${discount_modal.tab_addition}

Pdv - Orders - Click R$
    Wait Visible And Click Element    ${discount_modal.btn_type_value}

Pdv - Orders - Click Percent
    Wait Visible And Click Element    ${discount_modal.btn_type_percent}

Pdv - Orders - Input Discount Value
    [Arguments]    ${text}
    Wait Visible And Input Text    ${discount_modal.value_input}    ${text}
    Close Keyboard

Pdv - Orders - Click Remove Discount
    Wait Visible And Click Element    ${discount_modal.btn_remove}

Pdv - Orders - Click Apply Discount
    Wait Visible And Click Element    ${discount_modal.btn_apply}

Pdv - Orders - Click Item
    Wait Visible And Click Element    ${orders.filter_all}

Pdv - Orders - Click Item 2
    Wait Visible And Click Element    ${orders.filter_all}

Pdv - Orders - Long Press Item
    Wait Visible And Long Press Element    ${orders.filter_all}

Pdv - Orders - Long Press Item 2
    Wait Visible And Long Press Element    ${orders.filter_all}
