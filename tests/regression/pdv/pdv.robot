*** Settings ***
Documentation       Suite de regressão — módulo PDV (Smart PDV)
...
...                 Cobre os fluxos principais do PDV.
...                 Pré-condição: app iniciado na tela inicial do Smart PDV.

Resource            ../../../modules/pdv/base_pdv.resource

Suite Setup         Suite Setup Default
Suite Teardown      Suite Teardown Default
Test Setup          Test Setup Default
Test Teardown       Test Teardown Default


*** Test Cases ***
PDV - Setup
    [Documentation]    Configura o ambiente do PDV.
    [Tags]    @allure.label.severity:critical    regression    pdv    setup
    Pdv - Setup Printers    Imprimir
    Pdv - Setup Payment Methods

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
   [Documentation]    Aplica desconto percentual de 10% no carrinho e finaliza a venda.
   [Tags]    @allure.label.severity:normal    regression    pdv    orders    discount
   PDV - Complete Flow - Discount Percent
   ...    ${products.discount}
   ...    10,00
   ...    money

PDV - Discount Item
   [Documentation]    Aplica desconto percentual em um item e desconto em valor fixo em outro item antes de finalizar a venda.
   [Tags]    @allure.label.severity:normal    regression    pdv    orders    discount    item
   PDV - Setup Active/Deactive Discount Item
   PDV - Complete Flow - Discount Item
   ...    ${products.discount}
   ...    ${products.promotion}
   ...    money
   PDV - Setup Active/Deactive Discount Item

PDV - Additional Percent
   [Documentation]    Aplica acréscimo percentual de 10% no carrinho e finaliza a venda.
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

PDV - Bankslip
   [Documentation]    Realiza pedido alterando o cliente e finalizando com boleto bancário.
   [Tags]    @allure.label.severity:normal    regression    pdv    orders    bankslip
   PDV - Complete Flow - Bankslip
   ...    ${products.product_1}
   ...    ${clients.client_credit}
   ...    ${payment_data.bank_slip_calendar_day}

PDV - Pix Off
   [Documentation]    Realiza pedido finalizando com Pix Off.
   [Tags]    @allure.label.severity:normal    regression    pdv    orders    pixoff
   PDV - Complete Flow - Pix Off
   ...    ${products.product_1}

PDV - Item Variations
   [Documentation]    Realiza pedido com variações de item e promoção.
   [Tags]    @allure.label.severity:normal    regression    pdv    orders    quantity    promotion    pixoff
   PDV - Setup Active Fractional Units
   PDV - Complete Flow - Item Variations
   ...    ${products.fractional}
   ...    ${products.composition}
   ...    ${products.barcode_variation_1}
   ...    ${products.barcode_variation_2}
   ...    ${products.promotion}
   ...    money
   PDV - Setup Active Fractional Units

PDV - Price Table
   [Documentation]    Realiza pedido com tabela de preço.
   [Tags]    @allure.label.severity:normal    regression    pdv    orders    price-table
   PDV - Setup Active Price Tables
   PDV - Complete Flow - Price Table
   ...    ${products.price_table}
   ...    money
   PDV - Setup Active Price Tables

PDV - Express Mode
   [Documentation]    Realiza pedido adicionando itens pelo modo expresso e finaliza a venda.
   [Tags]    @allure.label.severity:normal    regression    pdv    orders    express
   Pdv - Setup Active Operation Mode    Express
   PDV - Complete Flow - Express Mode
   ...    ${products.product_1}
   ...    ${products.product_2}
   ...    money

PDV - Mini PDV Mode
   [Documentation]    Realiza pedido adicionando item pelo modo mini PDV.
   [Tags]    @allure.label.severity:normal    regression    pdv    orders    mini-pdv
   PDV - Setup Active Operation Mode    Mini PDV
   PDV - Complete Flow - Mini PDV Mode
   ...    ${products.product_1}
   ...    ${products.product_1_barcode}
   ...    money
   PDV - Setup Active Operation Mode    Padrão

PDV - Smart PDV Functions
   [Documentation]    Seleciona cliente no inicio do pedido, valida estoque e altera preço unitário.
   [Tags]    @allure.label.severity:normal    regression    pdv    orders    smart-pdv
   PDV - Setup Active Smart PDV Functions
   PDV - Complete Flow - Smart PDV Functions
   ...    ${clients.client_credit}
   ...    ${products.product_1}
   ...    5,00
   ...    money
   PDV - Setup Active Smart PDV Functions

PDV - NFCe Disable
   [Documentation]    Realiza pedido com fiscal desativado.
   [Tags]    @allure.label.severity:normal    regression    pdv    orders    fiscal
   PDV - Setup Active/Deactive NFCe
   PDV - Complete Flow - NFCe Disable
   ...    ${products.product_1}
   ...    money

PDV - No Payment Method
   [Documentation]    Realiza pedido sem método de pagamento.
   [Tags]    @allure.label.severity:normal    regression    pdv    orders    no-payment
   PDV - Setup Active/Deactive Payment Method
   PDV - Complete Flow - No Payment Method
   ...    ${products.product_1}
   Pdv - Setup Active/Deactive Payment Method

PDV - Ticket
   [Documentation]    Realiza pedido com emissão e reimpressão de ticket de retirada.
   [Tags]    @allure.label.severity:normal    regression    pdv    orders    ticket
   Pdv - Setup Active/Deactive Ticket    Imprimir
   PDV - Complete Flow - Ticket Order
   ...    ${products.product_1}
   ...    money
   Pdv - Setup Active/Deactive Ticket    Nenhuma Ação

PDV - Sync Search Client And Init Order
   [Documentation]    Sincroniza a lista de clientes, seleciona um cliente e inicia um pedido.
   [Tags]    @allure.label.severity:normal    regression    pdv    orders    client    sync
   PDV - Complete Flow - Sync Search Client And Init Order
   ...    ${clients.client_credit}
   ...    ${products.product_1}
   ...    money

PDV - Register Client Type Fisic
   [Documentation]    Cadastra um cliente pessoa física com dados gerados pelo Faker e verifica o registro.
   [Tags]    @allure.label.severity:normal    regression    pdv    clients    register
   PDV - Complete Flow - Register Client
   ...    Física
   ...    ${client_data.cep}

PDV - Register Client Type Juridic
   [Documentation]    Cadastra um cliente pessoa jurídica com dados gerados pelo Faker e verifica o registro.
   [Tags]    @allure.label.severity:normal    regression    pdv    clients    register
   PDV - Complete Flow - Register Client
   ...    Jurídica
   ...    ${client_data.cep}

PDV - List Orders Functions
   [Documentation]    Navega pela Lista de Pedidos: visualiza, reimprimi, acessa nota fiscal, cancela pedido e imprime relatórios.
   [Tags]    @allure.label.severity:normal    regression    pdv    orders    orders-list
   PDV - Complete Flow - List Orders Functions

PDV - Sync Options
   [Documentation]    Sincroniza dados via modal exibido na Home.
   [Tags]    @allure.label.severity:normal    regression    pdv    sync
   PDV - Complete FLow - Sync Options