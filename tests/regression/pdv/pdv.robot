*** Settings ***
Documentation    Suite de regressão — módulo Pdv (Smart PDV)
...
...    Cobre os fluxos principais de pedidos, cancelamentos, descontos,
...    remoção de itens, ticket, lista de pedidos e sincronização.
...    Pré-condição: app iniciado na tela inicial do Smart PDV.
Resource         ../../../modules/pdv/base_pdv.resource
Suite Setup      Suite Setup Default
Suite Teardown   Suite Teardown Default
Test Setup       Test Setup Default
Test Teardown    Test Teardown Default


*** Test Cases ***

# PDV - Login - Success
#     [Documentation]    Realiza login com sucesso no sistema.
#     [Tags]    @allure.label.severity:critical    regression    pdv    login
#     Pdv - Navigate To ...

PDV - Setup
    [Documentation]    Configura impressora e habilita métodos de pagamento.
    [Tags]    @allure.label.severity:normal    regression    pdv    settings    setup
    Pdv - Navigate configure printer
    Pdv - Navigate active payments
    Pdv - Navigate configure softcompay

PDV - Common Order
    [Documentation]    Realiza um pedido simples.
    [Tags]    @allure.label.severity:critical    regression    pdv    orders
    Pdv - Orders - Common Order

PDV - Cancel Order Screen New Order
    [Documentation]    Cancela um pedido em andamento na tela de novo pedido.
    [Tags]    @allure.label.severity:normal    regression    pdv    orders    cancel
    Pdv - Orders - Cancel Order Screen New Order

Pdv - Search for order by name, reference, and barcode
    [Documentation]    Realiza busca por um item pelo nome, referencia e codigo de barras.
    [Tags]    @allure.label.severity:normal    regression    pdv    orders
    Pdv - Orders - Search for order by name, reference, and barcode