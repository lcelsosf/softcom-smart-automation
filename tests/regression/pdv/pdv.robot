*** Settings ***
Documentation    Suite de regressão — módulo Pdv (Smart PDV)
...
...    Cobre os fluxos principais do PDV.
...    Pré-condição: app iniciado na tela inicial do Smart PDV.
Resource         ../../../modules/pdv/base_pdv.resource
Suite Setup      Suite Setup Default
Suite Teardown   Suite Teardown Default
Test Setup       Test Setup Default
Test Teardown    Test Teardown Default


*** Test Cases ***
PDV - Order common
    [Documentation]    Realiza um pedido simples com pagamento.
    [Tags]    @allure.label.severity:critical    regression    pdv    orders
    PDV - Complete Flow - Order Common    
    ...    ${products.product_1}    
    ...    money

PDV - Filter name, reference and barcode
    [Documentation]    Realiza pedido pesquisando produto por nome, referência e código de barras.
    [Tags]    @allure.label.severity:normal    regression    pdv    orders    filter
    PDV - Complete Flow - Filter Name Reference And Barcode
    ...    ${products.product_1}
    ...    ${products.product_1_reference}
    ...    ${products.product_1_barcode}
    ...    money

PDV - Alter Quantity and Remove item
    [Documentation]    Altera a quantidade de um item e remove outro item antes de finalizar a venda.
    [Tags]    @allure.label.severity:normal    regression    pdv    orders    quantity    remove
    PDV - Complete Flow - Alter Quantity And Remove Item
    ...    ${products.product_1}
    ...    ${products.product_2}
    ...    money

PDV - Cancel Order
    [Documentation]    Seleciona um item, limpa a pesquisa e cancela o pedido retornando para a tela inicial.
    [Tags]    @allure.label.severity:normal    regression    pdv    orders    cancel
    PDV - Complete Flow - Cancel Order After Select Product
    ...    ${products.product_1}

PDV - Alter Client and Add Itens from Cart
    [Documentation]    Altera o cliente no carrinho, adiciona outro item e finaliza a venda.
    [Tags]    @allure.label.severity:normal    regression    pdv    orders    client    cart
    PDV - Complete Flow - Alter Client And Add Itens From Cart
    ...    ${products.product_1}
    ...    ${clients.client_credit}
    ...    ${products.product_2}
    ...    money

PDV - Discount Integer
    [Documentation]    Aplica desconto em valor fixo de 1,00 no carrinho e finaliza a venda.
    [Tags]    @allure.label.severity:normal    regression    pdv    orders    discount
    PDV - Complete Flow - Discount Integer
    ...    ${products.discount}
    ...    1,00
    ...    money

PDV - Discount Percent
    [Documentation]    Aplica desconto percentual de 10,00 no carrinho e finaliza a venda.
    [Tags]    @allure.label.severity:normal    regression    pdv    orders    discount
    PDV - Complete Flow - Discount Percent
    ...    ${products.discount}
    ...    10,00
    ...    money

PDV - Additional Percent
    [Documentation]    Aplica acréscimo percentual de 10,00 no carrinho e finaliza a venda.
    [Tags]    @allure.label.severity:normal    regression    pdv    orders    additional
    PDV - Complete Flow - Additional Percent
    ...    ${products.discount}
    ...    10,00
    ...    money

PDV - Additional Integer
    [Documentation]    Aplica acréscimo em valor fixo de 1,00 no carrinho e finaliza a venda.
    [Tags]    @allure.label.severity:normal    regression    pdv    orders    additional
    PDV - Complete Flow - Additional Integer
    ...    ${products.discount}
    ...    1,00
    ...    money

PDV - Item edition
    [Documentation]    Edita quantidades e remove item no carrinho antes de finalizar a venda.
    [Tags]    @allure.label.severity:normal    regression    pdv    orders    quantity    remove    edit
    PDV - Complete Flow - Item Edition
    ...    ${products.product_1}
    ...    ${products.product_2}
    ...    ${products.discount}
    ...    money