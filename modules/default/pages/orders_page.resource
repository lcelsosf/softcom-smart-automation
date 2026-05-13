*** Settings ***
Documentation    Ações atômicas — Telas de Pedido (Catálogo, Carrinho, Checkout)
Resource         ../../../resources/helpers/common_keywords.resource


*** Keywords ***
# =============================================================================
# CATÁLOGO
# =============================================================================

Default - Orders - Select Group All
    Wait Visible And Click Element    ${orders.group}

Default - Orders - Click Search
    Wait Visible And Click Element    ${orders.search}

Default - Orders - Type In Search
    [Arguments]    ${product}
    Input Text    ${orders.search_text}    ${product}
    Close Keyboard

Default - Orders - Click Item
    Wait Visible And Click Element    ${orders.item}

Default - Orders - Close Search
    Wait Visible And Click Element    ${orders.search_close}

Default - Orders - Click Price Table
    Wait Visible And Click Element    ${orders.price_table}

Default - Orders - Select Price A
    Wait Visible And Click Element    ${orders.price_a}

Default - Orders - Save Price
    Wait Visible And Click Element    ${orders.price_save}

Default - Orders - Confirm Price
    Wait Visible And Click Element    ${orders.price_confirm}

# =============================================================================
# DIALOG DE ITEM (quantidade fracionada)
# =============================================================================

Default - Orders - Set Item Quantity
    [Arguments]    ${quantity}
    Clear Text    ${orders.item_quantity}
    Input Text    ${orders.item_quantity}    ${quantity}
    Close Keyboard

Default - Orders - Confirm Item
    Wait Visible And Click Element    ${orders.item_confirm}

# =============================================================================
# CARRINHO
# =============================================================================

Default - Orders - Click Cart
    Wait Visible And Click Element    ${orders.btn_cart}

Default - Orders - Click Cart Item
    Wait Visible And Click Element    ${orders.item_cart}

Default - Orders - Set Cart Item Price
    [Arguments]    ${price}
    Clear Text    ${orders.cart_item_price}
    Input Text    ${orders.cart_item_price}    ${price}
    Close Keyboard

Default - Orders - Add Cart Item Quantity
    Wait Visible And Click Element    ${orders.cart_item_add}

Default - Orders - Subtract Cart Item Quantity
    Wait Visible And Click Element    ${orders.cart_item_sub}

Default - Orders - Remove Cart Item
    Wait Visible And Click Element    ${orders.cart_remove_item}

Default - Orders - Confirm Remove Item
    Wait Visible And Click Element    ${orders.cart_remove_confirm}

Default - Orders - Click Add
    Wait Visible And Click Element    ${orders.cart_add}

Default - Orders - Click Discount
    Wait Visible And Click Element    ${orders.cart_discount}

Default - Orders - Select Sum Mode
    Wait Visible And Click Element    ${orders.sum}

Default - Orders - Select Replace Mode
    Wait Visible And Click Element    ${orders.replace}

Default - Orders - Set Integer Value
    [Arguments]    ${value}
    Input Text    ${orders.integer}    ${value}
    Close Keyboard

Default - Orders - Set Percent Value
    [Arguments]    ${value}
    Input Text    ${orders.percent}    ${value}
    Close Keyboard

Default - Orders - Confirm Discount
    Wait Visible And Click Element    ${orders.discount_confirm}

Default - Orders - Confirm Cart
    Wait Visible And Click Element    ${orders.cart_confirm}

# =============================================================================
# COMBO
# =============================================================================

Default - Orders - Click Item Combo 1
    Wait Visible And Click Element    ${orders.item_combo1}

Default - Orders - Click Item Combo 2
    Wait Visible And Click Element    ${orders.item_combo2}

Default - Orders - Add Item Combo
    Wait Visible And Click Element    ${orders.add_item_combo}

Default - Orders - Click Safra Item Combo 1
    Wait Visible And Click Element    ${exclusive.safra_item_combo1}

Default - Orders - Click Safra Item Combo 2
    Wait Visible And Click Element    ${exclusive.safra_item_combo2}

Default - Orders - Add Safra Item Combo
    Wait Visible And Click Element    ${exclusive.safra_add_item_combo}

# =============================================================================
# CLIENTE NO PEDIDO
# =============================================================================

Default - Orders - Click Client Button
    Wait Visible And Click Element    ${orders.client_button}

Default - Orders - Search Client
    [Arguments]    ${client}
    Input Text    ${orders.client_search}    ${client}
    Close Keyboard

Default - Orders - Select Client
    Wait Visible And Click Element    ${orders.client_1}

# =============================================================================
# CHECKOUT / PAGAMENTO
# =============================================================================

Default - Orders - Click Pay
    Wait Visible And Click Element    ${orders.pay}

Default - Orders - Select Money
    Wait Visible And Click Element    ${orders.money}

Default - Orders - Select Pix Off
    Wait Visible And Click Element    ${orders.pixoff}

Default - Orders - Select Bankslip
    Wait Visible And Click Element    ${orders.bankslip}

Default - Orders - Click Bankslip Add Parcel
    Wait Visible And Click Element    ${orders.bankslip_parce}

Default - Orders - Set Bankslip Term
    [Arguments]    ${term}
    Input Text    ${orders.bankslip_term}    ${term}
    Close Keyboard

Default - Orders - Set Payment Value
    [Arguments]    ${value}
    Input Text    ${orders.value}    ${value}
    Close Keyboard

Default - Orders - Confirm Payment
    Wait Visible And Click Element    ${orders.confirm}

Default - Orders - Click Finish
    Wait Visible And Click Element    ${orders.finish}

Default - Orders - Click Print
    Wait Visible And Click Element    ${orders.print}
