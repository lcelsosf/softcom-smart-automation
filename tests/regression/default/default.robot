*** Settings ***
Documentation    Suite de regressão — módulo Default (Pedidos/Configurações/Sincronização/Clientes)
...
...    Cobre os fluxos principais de criação de pedidos, pagamentos, configurações,
...    sincronização e cadastro de clientes.
...    Pré-condição: app iniciado na tela inicial com menu lateral acessível.
Resource         ../../../modules/default/base_default.resource
Suite Setup      Suite Setup Default
Suite Teardown   Suite Teardown Default
Test Setup       Test Setup Default
Test Teardown    Test Teardown Default


*** Variables ***
${PRODUCT_PRIMARY}          item_primary
${PRODUCT_SECONDARY}        item_secondary
${PRODUCT_COMBO}            item_combo
${PRODUCT_FRACTIONAL}       item_fractional
${PRODUCT_GRID_1}           item_grid_1
${PRODUCT_GRID_2}           item_grid_2
${PRODUCT_PROMOTION}        item_promotion
${PRODUCT_TICKET}           item_ticket
${PRODUCT_PRICE_TABLE}      item_price_table
${PRODUCT_BLOCK_STOCK}      item_block_stock
${CLIENT_PRIMARY}           Cliente Teste
${PRICE_NEW}                10,00
${BANKSLIP_VALUE}           100,00
${BANKSLIP_TERM}            30
${FRACTIONAL_QUANTITY}      0,500


*** Test Cases ***

Default - Configure printer
    [Documentation]    Verifica o fluxo de configuração de impressora nas configurações.
    [Tags]    @allure.label.severity:normal    regression    default    settings
    Default - Navigate To Configure Printer

Default - Create order and pay with money
    [Documentation]    Verifica o fluxo de criação de pedido e pagamento com dinheiro.
    [Tags]    @allure.label.severity:critical    regression    default    invoice
    Default - Navigate To Create Order And Pay With Money    ${PRODUCT_PRIMARY}

Default - Create order with add sum mode
    [Documentation]    Verifica o fluxo de criação de pedido com acréscimo no modo somar.
    [Tags]    @allure.label.severity:normal    regression    default    add
    Default - Navigate To Create Order With Add    ${PRODUCT_PRIMARY}    sum    integer_value=50

Default - Create order with add replace mode
    [Documentation]    Verifica o fluxo de criação de pedido com acréscimo no modo substituir.
    [Tags]    @allure.label.severity:normal    regression    default    add
    Default - Navigate To Create Order With Add    ${PRODUCT_PRIMARY}    replace    percent_value=10

Default - Create order with discount sum mode
    [Documentation]    Verifica o fluxo de criação de pedido com desconto no modo somar.
    [Tags]    @allure.label.severity:normal    regression    default    discount
    Default - Navigate To Create Order With Discount    ${PRODUCT_PRIMARY}    sum    integer_value=50

Default - Create order with discount replace mode
    [Documentation]    Verifica o fluxo de criação de pedido com desconto no modo substituir.
    [Tags]    @allure.label.severity:normal    regression    default    discount
    Default - Navigate To Create Order With Discount    ${PRODUCT_PRIMARY}    replace    percent_value=10

Default - Change item quantity
    [Documentation]    Verifica o fluxo de criação de pedido com alteração de quantidade de item no carrinho.
    [Tags]    @allure.label.severity:normal    regression    default    cart
    Default - Navigate To Change Item Quantity    ${PRODUCT_PRIMARY}

Default - Change item price
    [Documentation]    Verifica o fluxo de criação de pedido com alteração de preço de item no carrinho.
    [Tags]    @allure.label.severity:normal    regression    default    cart
    Default - Navigate To Change Price    ${PRODUCT_PRIMARY}    ${PRICE_NEW}

Default - Remove item from cart
    [Documentation]    Verifica o fluxo de criação de pedido com dois produtos, remoção de um item e pagamento.
    [Tags]    @allure.label.severity:normal    regression    default    cart
    Default - Navigate To Remove Item    ${PRODUCT_PRIMARY}    ${PRODUCT_SECONDARY}

Default - Create order with combo
    [Documentation]    Verifica o fluxo de criação de pedido com produto combo.
    [Tags]    @allure.label.severity:critical    regression    default    combo
    Default - Navigate To Item Combo    ${PRODUCT_COMBO}

Default - Create order with fractional quantity
    [Documentation]    Verifica o fluxo de criação de pedido com produto de quantidade fracionada.
    [Tags]    @allure.label.severity:normal    regression    default    fractional
    Default - Navigate To Create Order With Fractional Quantity    ${PRODUCT_FRACTIONAL}    ${FRACTIONAL_QUANTITY}

Default - Create order with grid (two products)
    [Documentation]    Verifica o fluxo de criação de pedido com dois produtos via pesquisa.
    [Tags]    @allure.label.severity:normal    regression    default    grid
    Default - Navigate To Create Order With Grid    ${PRODUCT_GRID_1}    ${PRODUCT_GRID_2}

Default - Configure price table
    [Documentation]    Verifica o fluxo de ativação/desativação da tabela de preços nas configurações.
    [Tags]    @allure.label.severity:normal    regression    default    settings
    Default - Navigate To Configure Price Table

Default - Create order with price table
    [Documentation]    Verifica o fluxo de criação de pedido com tabela de preços.
    [Tags]    @allure.label.severity:normal    regression    default    price_table
    Default - Navigate To Create Order With Price Table    ${PRODUCT_PRICE_TABLE}

Default - Create order with promotion product
    [Documentation]    Verifica o fluxo de criação de pedido com produto em promoção.
    [Tags]    @allure.label.severity:normal    regression    default    promotion
    Default - Navigate To Create Order And Pay With Money    ${PRODUCT_PROMOTION}

Default - Create order with ticket
    [Documentation]    Verifica o fluxo de criação de pedido com emissão de ticket (10 unidades).
    [Tags]    @allure.label.severity:normal    regression    default    ticket
    Default - Navigate To Create Order With Ticket    ${PRODUCT_TICKET}

Default - Pay with Pix Off
    [Documentation]    Verifica o fluxo de criação de pedido e pagamento com Pix Off.
    [Tags]    @allure.label.severity:critical    regression    default    invoice
    Default - Navigate To Create Order And Pay With Pix Off    ${PRODUCT_PRIMARY}

Default - Pay with Bankslip
    [Documentation]    Verifica o fluxo de criação de pedido e pagamento com boleto bancário.
    [Tags]    @allure.label.severity:normal    regression    default    invoice
    Default - Navigate To Create Order And Pay With Bankslip
    ...    ${PRODUCT_PRIMARY}    ${BANKSLIP_VALUE}    ${BANKSLIP_TERM}

Default - Reprint order
    [Documentation]    Verifica o fluxo de reimpressão de comprovante na lista de pedidos.
    [Tags]    @allure.label.severity:normal    regression    default    reprint
    Default - Navigate To Reprint

Default - Sync all
    [Documentation]    Verifica o fluxo de sincronização completa (produtos, clientes e pedidos).
    [Tags]    @allure.label.severity:critical    regression    default    sync
    Default - Navigate To Sync    all

Default - Sync products only
    [Documentation]    Verifica o fluxo de sincronização apenas de produtos.
    [Tags]    @allure.label.severity:normal    regression    default    sync
    Default - Navigate To Sync    products

Default - Sync clients only
    [Documentation]    Verifica o fluxo de sincronização apenas de clientes.
    [Tags]    @allure.label.severity:normal    regression    default    sync
    Default - Navigate To Sync    clients

Default - Sync orders only
    [Documentation]    Verifica o fluxo de sincronização apenas de pedidos.
    [Tags]    @allure.label.severity:normal    regression    default    sync
    Default - Navigate To Sync    orders

Default - Sync cancel
    [Documentation]    Verifica o fluxo de cancelamento do dialog de sincronização.
    [Tags]    @allure.label.severity:normal    regression    default    sync
    Default - Navigate To Sync    cancel

Default - Logoff
    [Documentation]    Verifica o fluxo de logoff do aplicativo.
    [Tags]    @allure.label.severity:critical    regression    default    logoff
    Default - Navigate To Logoff

Default - Register client
    [Documentation]    Verifica o fluxo de cadastro de cliente com dados gerados pelo FakerLibrary.
    [Tags]    @allure.label.severity:normal    regression    default    clients
    Default - Navigate To Register Client

Default - Toggle sales change price setting
    [Documentation]    Verifica o fluxo de ativação/desativação da alteração de preço de venda nas configurações.
    [Tags]    @allure.label.severity:normal    regression    default    settings
    Default - Navigate To Change Sales Price Setting

Default - Toggle block stock setting
    [Documentation]    Verifica o fluxo de ativação/desativação do bloqueio de estoque nas configurações.
    [Tags]    @allure.label.severity:normal    regression    default    settings
    Default - Navigate To Block Stock Setting

Default - Block stock test
    [Documentation]    Verifica o comportamento ao tentar adicionar produto sem estoque com bloqueio ativo.
    [Tags]    @allure.label.severity:normal    regression    default    settings    block_stock
    Default - Navigate To Block Stock Test    ${PRODUCT_BLOCK_STOCK}

Default - Toggle fractional quantity setting
    [Documentation]    Verifica o fluxo de ativação/desativação de quantidade fracionada nas configurações.
    [Tags]    @allure.label.severity:normal    regression    default    settings
    Default - Navigate To Fractional Quantity Setting


Default - Enable Pix Off payment
    [Documentation]    Verifica o fluxo de habilitação da forma de pagamento Pix Off nas configurações.
    [Tags]    @allure.label.severity:normal    regression    default    settings
    Default - Navigate To Enable Pix Off Payment

Default - Enable Bankslip payment
    [Documentation]    Verifica o fluxo de habilitação da forma de pagamento Boleto Bancário nas configurações.
    [Tags]    @allure.label.severity:normal    regression    default    settings
    Default - Navigate To Enable Bankslip Payment

Default - Configure ticket
    [Documentation]    Verifica o fluxo de configuração de emissão de ticket nas configurações.
    [Tags]    @allure.label.severity:normal    regression    default    settings
    Default - Navigate To Configure Ticket


