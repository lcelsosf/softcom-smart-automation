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
