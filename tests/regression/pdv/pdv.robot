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

# PDV - Login - Fail Email
#     [Documentation]    Realiza login com email inválido (falha esperada).
#     [Tags]    @allure.label.severity:minor    regression    pdv    login
#     Pdv - Navigate To ...

# PDV - Login - Fail Password
#     [Documentation]    Realiza login com senha inválida (falha esperada).
#     [Tags]    @allure.label.severity:minor    regression    pdv    login
#     Pdv - Navigate To ...

# PDV - Login - Logoff
#     [Documentation]    Realiza login e logoff no sistema.
#     [Tags]    @allure.label.severity:normal    regression    pdv    login
#     Pdv - Navigate To ...

# PDV - Login - Success
#     [Documentation]    Realiza login com sucesso no sistema.
#     [Tags]    @allure.label.severity:critical    regression    pdv    login
#     Pdv - Navigate To ...

# PDV - Settings - Setup
#     [Documentation]    Configura impressora e habilita métodos de pagamento.
#     [Tags]    @allure.label.severity:normal    regression    pdv    settings    setup
#     Pdv - Navigate To ...

# PDV - Clients - Register Client
#     [Documentation]    Cadastra um novo cliente pessoa física com dados gerados aleatoriamente.
#     [Tags]    @allure.label.severity:normal    regression    pdv    clients
#     Pdv - Navigate To Register Client

PDV - Orders - Client Order
    [Documentation]    Realiza pedido iniciado a partir da tela de clientes.
    [Tags]    @allure.label.severity:normal    regression    pdv    orders
    Pdv - Navigate To Client Order

PDV - Orders - Cancel Order (New Order)
    [Documentation]    Cancela um pedido em andamento na tela de novo pedido.
    [Tags]    @allure.label.severity:normal    regression    pdv    orders    cancel
    Pdv - Navigate To Cancel Order    origin=new

PDV - Orders - Cancel Order (Cart)
    [Documentation]    Cancela um pedido em andamento na tela de carrinho.
    [Tags]    @allure.label.severity:normal    regression    pdv    orders    cancel
    Pdv - Navigate To Cancel Order    origin=cart

PDV - Orders - Cancel Order (New Order) no-confirm
    [Documentation]    Abre o cancelamento na tela de novo pedido, escolhe Não e finaliza o pedido.
    [Tags]    @allure.label.severity:minor    regression    pdv    orders    cancel
    Pdv - Navigate To Cancel Order no-confirm    origin=new

PDV - Orders - Cancel Order (Cart) no-confirm
    [Documentation]    Abre o cancelamento na tela de carrinho, escolhe Não e finaliza o pedido.
    [Tags]    @allure.label.severity:minor    regression    pdv    orders    cancel
    Pdv - Navigate To Cancel Order no-confirm    origin=cart

PDV - Orders - Change Item Quantity
    [Documentation]    Altera a quantidade de um item no carrinho e finaliza o pedido.
    [Tags]    @allure.label.severity:normal    regression    pdv    orders
    Pdv - Navigate To Change Item Quantity

PDV - Orders - Order Conference Off
    [Documentation]    Realiza pedido com conferência desativada (fluxo direto).
    [Tags]    @allure.label.severity:normal    regression    pdv    orders    conference
    Pdv - Navigate To Order Conference Off

PDV - Orders - Order Conference Off Cart
    [Documentation]    Realiza pedido com conferência desativada validando o carrinho.
    [Tags]    @allure.label.severity:normal    regression    pdv    orders    conference
    Pdv - Navigate To Order Conference Off Cart

PDV - Orders - Discount Percent
    [Documentation]    Aplica desconto percentual em um item e finaliza o pedido.
    [Tags]    @allure.label.severity:normal    regression    pdv    orders    discount
    Pdv - Navigate To Apply Discount    mode=percent

PDV - Orders - Discount Integer
    [Documentation]    Aplica desconto em valor inteiro em um item e finaliza o pedido.
    [Tags]    @allure.label.severity:normal    regression    pdv    orders    discount
    Pdv - Navigate To Apply Discount    mode=integer

PDV - Orders - Remove Item
    [Documentation]    Remove itens do pedido via long press e ícone do carrinho (confirma).
    [Tags]    @allure.label.severity:normal    regression    pdv    orders
    Pdv - Navigate To Remove Item

PDV - Orders - Remove Item no-confirm
    [Documentation]    Tenta remover itens do pedido e cancela as remoções.
    [Tags]    @allure.label.severity:minor    regression    pdv    orders
    Pdv - Navigate To Remove Item no-confirm

PDV - Orders - Ticket Print
    [Documentation]    Realiza pedido com ticket configurado para impressão automática.
    [Tags]    @allure.label.severity:normal    regression    pdv    orders    ticket
    Pdv - Navigate To Ticket Print

PDV - Orders - Ticket Quest Yes
    [Documentation]    Realiza pedido com ticket configurado para perguntar — responde Sim.
    [Tags]    @allure.label.severity:normal    regression    pdv    orders    ticket
    Pdv - Navigate To Ticket Quest Yes

PDV - Orders - Ticket Quest No
    [Documentation]    Realiza pedido com ticket configurado para perguntar — responde Não.
    [Tags]    @allure.label.severity:normal    regression    pdv    orders    ticket
    Pdv - Navigate To Ticket Quest No

PDV - Orders - Order Money
    [Documentation]    Realiza pedido com pagamento em dinheiro.
    [Tags]    @allure.label.severity:critical    regression    pdv    orders    payment
    Pdv - Navigate To Create Order    payment_method=money

PDV - Orders - Order Pix Off
    [Documentation]    Realiza pedido com pagamento em Pix Off.
    [Tags]    @allure.label.severity:critical    regression    pdv    orders    payment
    Pdv - Navigate To Create Order    payment_method=pixoff

PDV - Orders - Order Bankslip
    [Documentation]    Realiza pedido com pagamento em boleto bancário.
    [Tags]    @allure.label.severity:normal    regression    pdv    orders    payment
    Pdv - Navigate To Create Order    payment_method=bankslip

PDV - List Orders - Visualize Order
    [Documentation]    Visualiza os detalhes do primeiro pedido na lista de pedidos.
    [Tags]    @allure.label.severity:minor    regression    pdv    list_orders
    Pdv - Navigate To Visualize Order

PDV - List Orders - Reprint Order
    [Documentation]    Reimprime o primeiro pedido na lista de pedidos.
    [Tags]    @allure.label.severity:minor    regression    pdv    list_orders
    Pdv - Navigate To Reprint Order

PDV - List Orders - Cancel Order
    [Documentation]    Cancela o primeiro pedido na lista de pedidos.
    [Tags]    @allure.label.severity:normal    regression    pdv    list_orders
    Pdv - Navigate To List Orders Cancel Order

PDV - List Orders - Print Receipts
    [Documentation]    Imprime os recebimentos a partir da lista de pedidos.
    [Tags]    @allure.label.severity:minor    regression    pdv    list_orders
    Pdv - Navigate To Print Receipts

PDV - List Orders - Print Sales Summary
    [Documentation]    Imprime o resumo de vendas a partir da lista de pedidos.
    [Tags]    @allure.label.severity:minor    regression    pdv    list_orders
    Pdv - Navigate To Print Sales Summary

PDV - List Orders - Print Cancel
    [Documentation]    Abre o menu de impressão da lista de pedidos e volta sem imprimir.
    [Tags]    @allure.label.severity:minor    regression    pdv    list_orders
    Pdv - Navigate To Print Cancel

PDV - Sync - Cancel Sync
    [Documentation]    Abre a sincronização e cancela antes de concluir.
    [Tags]    @allure.label.severity:minor    regression    pdv    sync
    Pdv - Navigate To Cancel Sync

PDV - Sync - Sync Products
    [Documentation]    Realiza a sincronização de produtos.
    [Tags]    @allure.label.severity:normal    regression    pdv    sync
    Pdv - Navigate To Sync Products

PDV - Sync - Sync Clients
    [Documentation]    Realiza a sincronização de clientes.
    [Tags]    @allure.label.severity:normal    regression    pdv    sync
    Pdv - Navigate To Sync Clients

PDV - Sync - Sync Orders
    [Documentation]    Realiza a sincronização de pedidos.
    [Tags]    @allure.label.severity:normal    regression    pdv    sync
    Pdv - Navigate To Sync Orders

PDV - Sync - Sync All
    [Documentation]    Realiza a sincronização de todos os dados.
    [Tags]    @allure.label.severity:normal    regression    pdv    sync
    Pdv - Navigate To Sync All
