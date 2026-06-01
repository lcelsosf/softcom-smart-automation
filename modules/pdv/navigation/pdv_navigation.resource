*** Settings ***
Documentation    Fluxos de navegação/configuração do módulo Pdv — composição de page keywords.
...
...    Nomenclatura: Pdv - Navigate To <Destino>
...    Dependências: pages abaixo + locators carregados via base_pdv.resource
Resource    ../pages/home_page.resource
Resource    ../pages/orders_page.resource
Resource    ../pages/checkout_page.resource


*** Keywords ***
# =============================================================================
# NAVEGAÇÃO — HOME
# =============================================================================

Pdv - Navigate To New Order
    [Documentation]    Valida a tela inicial e navega para novo pedido.
    Pdv - Home - Verify Visible
    Pdv - Home - Click New Order

Pdv - Navigate To Initial Screen
    [Documentation]    Retorna da tela de status do pedido para a tela inicial.
    Pdv - Orders Status - Click Home


# =============================================================================
# NAVEGAÇÃO — PEDIDO
# =============================================================================

Pdv - Navigate To Select Product
    [Documentation]    Pesquisa e seleciona um produto pelo nome.
    [Arguments]    ${product_name}
    Pdv - Orders - Click Search Input
    Pdv - Orders - Type Product Name    ${product_name}
    Pdv - Orders - Click Product By Name    ${product_name}

Pdv - Navigate To Search Product
    [Documentation]    Pesquisa e seleciona um produto usando o termo informado.
    [Arguments]    ${search_term}    ${product_name}
    Pdv - Orders - Click Search Input
    Pdv - Orders - Type Product Name    ${search_term}
    Pdv - Orders - Click Product By Name    ${product_name}

Pdv - Navigate To Clear Product Search
    [Documentation]    Limpa a pesquisa de produto.
    Pdv - Orders - Click Clear Search

Pdv - Navigate To Check Order
    [Documentation]    Avança para a conferência do pedido.
    Pdv - Orders - Click Conference

Pdv - Navigate To Finish Order
    [Documentation]    Finaliza o pedido e avança para pagamento.
    Pdv - Orders - Click Finalize Order

Pdv - Navigate To Long Press Product
    [Documentation]    Seleciona um produto pelo nome usando long press.
    [Arguments]    ${product_name}
    ${locator}=    Replace String    ${orders.product_by_name}    PRODUCT_NAME    ${product_name}
    Wait Visible And Long Press Element    ${locator}

Pdv - Navigate To Search And Long Press Product
    [Documentation]    Pesquisa e seleciona um produto pelo nome usando long press.
    [Arguments]    ${product_name}
    Pdv - Orders - Click Search Input
    Pdv - Orders - Type Product Name    ${product_name}
    Pdv - Navigate To Long Press Product    ${product_name}

Pdv - Navigate To Add Quantity
    [Documentation]    Aumenta a quantidade do item no modal de quantidade.
    [Arguments]    ${times}
    Repeat Keyword    ${times} times    Pdv - Orders - Click Quantity Add

Pdv - Navigate To Remove Quantity
    [Documentation]    Diminui a quantidade do item no modal de quantidade.
    [Arguments]    ${times}
    Repeat Keyword    ${times} times    Pdv - Orders - Click Quantity Remove

Pdv - Navigate To Confirm Quantity
    [Documentation]    Confirma a quantidade no modal de quantidade.
    Pdv - Orders - Click Quantity Confirm

Pdv - Navigate To Remove Product From Order
    [Documentation]    Remove o produto selecionado no modal de quantidade.
    Pdv - Orders - Click Remove Item
    Pdv - Orders - Verify Remove Item Dialog
    Pdv - Orders - Click Remove Item Confirm


# =============================================================================
# CONFIGURAÇÃO — PAGAMENTO
# =============================================================================

Pdv - Resolve Payment Method Name
    [Documentation]    Converte aliases de pagamento para o nome exibido na tela.
    [Arguments]    ${payment_method}
    ${payment_method_name}=    Set Variable    ${payment_method}
    IF    '${payment_method}' == 'money'
        ${payment_method_name}=    Set Variable    Dinheiro
    ELSE IF    '${payment_method}' == 'pixoff'
        ${payment_method_name}=    Set Variable    Pix Off
    ELSE IF    '${payment_method}' == 'bankslip'
        ${payment_method_name}=    Set Variable    Boleto Bancário
    END
    RETURN    ${payment_method_name}


# =============================================================================
# NAVEGAÇÃO — CHECKOUT
# =============================================================================

Pdv - Navigate To Select Payment Method
    [Documentation]    Seleciona a forma de pagamento informada.
    [Arguments]    ${payment_method}
    ${payment_method_name}=    Pdv - Resolve Payment Method Name    ${payment_method}
    Pdv - Checkout - Click Method By Name    ${payment_method_name}

Pdv - Navigate To Confirm Payment Value
    [Documentation]    Confirma o valor sugerido no modal de pagamento.
    Pdv - Checkout - Click Value Confirm

Pdv - Navigate To Finish Sale
    [Documentation]    Finaliza a venda no checkout.
    Pdv - Checkout - Click Finish Sale
