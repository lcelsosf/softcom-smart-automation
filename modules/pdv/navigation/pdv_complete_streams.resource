*** Settings ***
Documentation    Fluxos completos do módulo Pdv — composição de navigation keywords.
...
...    Nomenclatura: PDV - Complete Flow - <Fluxo>
...    Dependências: navigation abaixo + locators carregados via base_pdv.resource
Resource    pdv_navigation.resource


*** Keywords ***
PDV - Complete Flow - Order Common
    [Documentation]    Executa o fluxo comum de pedido e pagamento.
    [Arguments]    ${product_name}    ${payment_method}
    Pdv - Navigate To New Order
    Pdv - Navigate To Select Product    ${product_name}
    Pdv - Navigate To Check Order
    Pdv - Navigate To Finish Order
    Pdv - Navigate To Select Payment Method    ${payment_method}
    Pdv - Navigate To Confirm Payment Value
    Pdv - Navigate To Finish Sale
    Pdv - Navigate To Initial Screen
    Pdv - Home - Verify Visible


PDV - Complete Flow - Filter Name Reference And Barcode
    [Documentation]    Pesquisa produtos por nome, referência e código de barras, depois finaliza o pedido.
    [Arguments]    ${product_name}    ${product_reference}    ${product_barcode}    ${payment_method}
    Pdv - Navigate To New Order
    Pdv - Navigate To Select Product    ${product_name}
    Pdv - Navigate To Clear Product Search
    Pdv - Navigate To Search Product    ${product_reference}    ${product_name}
    Pdv - Navigate To Clear Product Search
    Pdv - Navigate To Search Product    ${product_barcode}    ${product_name}
    Pdv - Navigate To Check Order
    Pdv - Navigate To Finish Order
    Pdv - Navigate To Select Payment Method    ${payment_method}
    Pdv - Navigate To Confirm Payment Value
    Pdv - Navigate To Finish Sale
    Pdv - Navigate To Initial Screen
    Pdv - Home - Verify Visible


PDV - Complete Flow - Alter Quantity And Remove Item
    [Documentation]    Altera a quantidade de um item, remove outro item e finaliza a venda.
    [Arguments]    ${product_primary}    ${product_secondary}    ${payment_method}
    Pdv - Navigate To New Order
    Pdv - Navigate To Select Product    ${product_primary}
    Pdv - Navigate To Long Press Product    ${product_primary}
    Pdv - Navigate To Add Quantity    3
    Pdv - Navigate To Remove Quantity    2
    Pdv - Navigate To Confirm Quantity
    Pdv - Navigate To Clear Product Search
    Pdv - Navigate To Select Product    ${product_secondary}
    Pdv - Navigate To Long Press Product    ${product_secondary}
    Pdv - Navigate To Remove Product From Order
    Pdv - Navigate To Check Order
    Pdv - Navigate To Finish Order
    Pdv - Navigate To Select Payment Method    ${payment_method}
    Pdv - Navigate To Confirm Payment Value
    Pdv - Navigate To Finish Sale
    Pdv - Navigate To Initial Screen
    Pdv - Home - Verify Visible


PDV - Complete Flow - Cancel Order After Select Product
    [Documentation]    Seleciona um produto, limpa a pesquisa e cancela o pedido retornando para a tela inicial.
    [Arguments]    ${product_name}
    Pdv - Navigate To New Order
    Pdv - Navigate To Select Product    ${product_name}
    Pdv - Navigate To Clear Product Search
    Pdv - Navigate To Cancel Order
    Pdv - Home - Verify Visible


PDV - Complete Flow - Alter Client And Add Itens From Cart
    [Documentation]    Altera o cliente no carrinho, adiciona outro item e finaliza a venda.
    [Arguments]    ${product_primary}    ${client_name}    ${product_secondary}    ${payment_method}
    Pdv - Navigate To New Order
    Pdv - Navigate To Select Product    ${product_primary}
    Pdv - Navigate To Clear Product Search
    Pdv - Navigate To Check Order
    Pdv - Navigate To Select Client    ${client_name}
    Pdv - Navigate To Add Items From Cart
    Pdv - Navigate To Select Product    ${product_secondary}
    Pdv - Navigate To Clear Product Search
    Pdv - Navigate To Check Order
    Pdv - Navigate To Finish Order
    Pdv - Navigate To Select Payment Method    ${payment_method}
    Pdv - Navigate To Confirm Payment Value
    Pdv - Navigate To Finish Sale
    Pdv - Navigate To Initial Screen
    Pdv - Home - Verify Visible


PDV - Complete Flow - Discount Integer
    [Documentation]    Aplica desconto em valor fixo no carrinho e finaliza a venda.
    [Arguments]    ${product_name}    ${discount_value}    ${payment_method}
    Pdv - Navigate To New Order
    Pdv - Navigate To Select Product    ${product_name}
    Pdv - Navigate To Clear Product Search
    Pdv - Navigate To Check Order
    Pdv - Navigate To Apply Discount Integer    ${discount_value}
    Pdv - Navigate To Finish Order
    Pdv - Navigate To Select Payment Method    ${payment_method}
    Pdv - Navigate To Confirm Payment Value
    Pdv - Navigate To Finish Sale
    Pdv - Navigate To Initial Screen
    Pdv - Home - Verify Visible


PDV - Complete Flow - Discount Percent
    [Documentation]    Aplica desconto percentual no carrinho e finaliza a venda.
    [Arguments]    ${product_name}    ${discount_value}    ${payment_method}
    Pdv - Navigate To New Order
    Pdv - Navigate To Select Product    ${product_name}
    Pdv - Navigate To Clear Product Search
    Pdv - Navigate To Check Order
    Pdv - Navigate To Apply Discount Percent    ${discount_value}
    Pdv - Navigate To Finish Order
    Pdv - Navigate To Select Payment Method    ${payment_method}
    Pdv - Navigate To Confirm Payment Value
    Pdv - Navigate To Finish Sale
    Pdv - Navigate To Initial Screen
    Pdv - Home - Verify Visible
    

PDV - Complete Flow - Additional Percent
    [Documentation]    Aplica acréscimo percentual no carrinho e finaliza a venda.
    [Arguments]    ${product_name}    ${additional_value}    ${payment_method}
    Pdv - Navigate To New Order
    Pdv - Navigate To Select Product    ${product_name}
    Pdv - Navigate To Clear Product Search
    Pdv - Navigate To Check Order
    Pdv - Navigate To Apply Additional Percent    ${additional_value}
    Pdv - Navigate To Finish Order
    Pdv - Navigate To Select Payment Method    ${payment_method}
    Pdv - Navigate To Confirm Payment Value
    Pdv - Navigate To Finish Sale
    Pdv - Navigate To Initial Screen
    Pdv - Home - Verify Visible


PDV - Complete Flow - Additional Integer
    [Documentation]    Aplica acréscimo em valor fixo no carrinho e finaliza a venda.
    [Arguments]    ${product_name}    ${additional_value}    ${payment_method}
    Pdv - Navigate To New Order
    Pdv - Navigate To Select Product    ${product_name}
    Pdv - Navigate To Clear Product Search
    Pdv - Navigate To Check Order
    Pdv - Navigate To Apply Additional Integer    ${additional_value}
    Pdv - Navigate To Finish Order
    Pdv - Navigate To Select Payment Method    ${payment_method}
    Pdv - Navigate To Confirm Payment Value
    Pdv - Navigate To Finish Sale
    Pdv - Navigate To Initial Screen
    Pdv - Home - Verify Visible


PDV - Complete Flow - Item Edition
    [Documentation]    Edita quantidades e remove item no carrinho antes de finalizar a venda.
    [Arguments]    ${product_primary}    ${product_secondary}    ${product_discount}    ${payment_method}
    Pdv - Navigate To New Order
    Pdv - Navigate To Select Product    ${product_primary}
    Pdv - Navigate To Clear Product Search
    Pdv - Navigate To Select Product    ${product_secondary}
    Pdv - Navigate To Clear Product Search
    Pdv - Navigate To Select Product    ${product_discount}
    Pdv - Navigate To Check Order
    Pdv - Navigate To Add Cart Item Quantity    ${product_discount}    3
    Pdv - Navigate To Remove Cart Item Quantity    ${product_discount}    2
    Pdv - Navigate To Remove Cart Item By Name    ${product_secondary}
    Pdv - Navigate To Remove Cart Item By Name    ${product_primary}
    Pdv - Navigate To Finish Order
    Pdv - Navigate To Select Payment Method    ${payment_method}
    Pdv - Navigate To Confirm Payment Value
    Pdv - Navigate To Finish Sale
    Pdv - Navigate To Initial Screen
    Pdv - Home - Verify Visible