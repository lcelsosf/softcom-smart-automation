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