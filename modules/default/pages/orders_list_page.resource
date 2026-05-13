*** Settings ***
Documentation    Ações atômicas — Tela de Lista de Pedidos
Resource         ../../../resources/helpers/common_keywords.resource


*** Keywords ***
Default - Orders List - Click First Order
    Wait Visible And Click Element    ${orders_list.order}

Default - Orders List - Click Reprint
    Wait Visible And Click Element    ${orders_list.reprint}
