*** Settings ***
Documentation    Fluxos de navegação do módulo Pdv — composição de page keywords.
...
...    Nomenclatura: Pdv - Navigate To <Destino>
...    Dependências: pages abaixo + locators carregados via base_pdv.resource
Library    FakerLibrary    locale=pt_BR    WITH NAME    faker
Resource    ../pages/home_page.resource
Resource    ../pages/settings_page.resource
Resource    ../pages/orders_page.resource
Resource    ../pages/clients_page.resource
Resource    ../pages/list_orders_page.resource
Resource    ../pages/sync_page.resource


*** Keywords ***
# =============================================================================
# NAVEGAÇÃO — HOME
# =============================================================================

Pdv - Navigate To New Order
    [Documentation]    Navega da tela inicial para a tela de novo pedido.
    Pdv - Home - Click New Order

Pdv - Navigate To List Orders
    [Documentation]    Navega da tela inicial para a lista de pedidos.
    Pdv - Home - Click List Orders

Pdv - Navigate To Sync
    [Documentation]    Navega da tela inicial para a tela de sincronização.
    Pdv - Home - Click Sync

Pdv - Navigate To Clients
    [Documentation]    Navega da tela inicial para o cadastro de clientes.
    Pdv - Home - Click Clients

Pdv - Navigate To Settings
    [Documentation]    Navega da tela inicial para as configurações.
    Pdv - Home - Click Settings

# =============================================================================
# NAVEGAÇÃO — PEDIDOS BÁSICOS
# =============================================================================

Pdv - Navigate To Create Order
    [Documentation]    Cria um pedido e finaliza com a forma de pagamento informada.
    ...    Métodos suportados: money, pixoff, bankslip
    [Arguments]    ${payment_method}
    Pdv - Navigate To New Order
    Pdv - Orders - Click Item
    Pdv - Orders - Click Conference
    IF    '${payment_method}' == 'bankslip'
        Pdv - Orders - Click Client Search
        Pdv - Orders - Click Client Consumer
        Pdv - Orders - Input Client Name    Client_Credit
        Pdv - Orders - Click Client Credit
        Pdv - Orders - Click Client Confirm
    END
    Pdv - Orders - Click Finalize Order
    IF    '${payment_method}' == 'money'
        Pdv - Orders - Click Payment Money
    ELSE IF    '${payment_method}' == 'pixoff'
        Pdv - Orders - Click Payment Pixoff
    ELSE IF    '${payment_method}' == 'bankslip'
        Pdv - Orders - Click Payment Bankslip
        Pdv - Orders - Click Bankslip Parcel Add
        Pdv - Orders - Click Bankslip Parcel Add
        Pdv - Orders - Click Bankslip Parcel Remove
        Pdv - Orders - Click Bankslip Term Calendar
        Pdv - Orders - Click Bankslip Term Prefix
        Pdv - Orders - Input Bankslip Term    7
    END
    Pdv - Orders - Click Confirm Value
    Pdv - Orders - Click Finish Order
    Pdv - Orders - Click Home
    Pdv - Home - Verify Visible

Pdv - Navigate To Client Order
    [Documentation]    Realiza pedido iniciando pelo cadastro de clientes (client1).
    Pdv - Navigate To Clients
    Pdv - Clients - Input Search    Client_Credit
    Pdv - Clients - Click Client 1
    Pdv - Clients - Click New Order Client
    Pdv - Orders - Click Item
    Pdv - Orders - Click Conference
    Pdv - Orders - Click Finalize Order
    Pdv - Orders - Click Payment Money
    Pdv - Orders - Click Confirm Value
    Pdv - Orders - Click Finish Order
    Pdv - Orders - Click Home
    Pdv - Home - Verify Visible

# =============================================================================
# NAVEGAÇÃO — CANCELAMENTO DE PEDIDO
# =============================================================================

Pdv - Navigate To Cancel Order
    [Documentation]    Cancela um pedido em andamento. Origem: new (tela novo pedido) ou cart (carrinho).
    [Arguments]    ${origin}=new
    Pdv - Navigate To New Order
    Pdv - Orders - Click Item
    IF    '${origin}' == 'cart'
        Pdv - Orders - Click Conference
        Pdv - Orders - Click Cancel Order Cart
    ELSE
        Pdv - Orders - Click Cancel Order New
    END
    Pdv - Orders - Verify Cancel Dialog
    Pdv - Orders - Click Cancel Confirm
    Pdv - Home - Verify Visible

Pdv - Navigate To Cancel Order no-confirm
    [Documentation]    Abre o cancelamento, escolhe "Não" e finaliza o pedido normalmente.
    ...    Origem: new (tela novo pedido) ou cart (carrinho).
    [Arguments]    ${origin}=new
    Pdv - Navigate To New Order
    Pdv - Orders - Click Item
    IF    '${origin}' == 'cart'
        Pdv - Orders - Click Conference
        Pdv - Orders - Click Cancel Order Cart
    ELSE
        Pdv - Orders - Click Cancel Order New
    END
    Pdv - Orders - Verify Cancel Dialog
    Pdv - Orders - Click Cancel Cancel
    IF    '${origin}' == 'new'
        Pdv - Orders - Click Conference
    END
    Pdv - Orders - Click Finalize Order
    Pdv - Orders - Click Payment Money
    Pdv - Orders - Click Confirm Value
    Pdv - Orders - Click Finish Order
    Pdv - Orders - Click Home
    Pdv - Home - Verify Visible

# =============================================================================
# NAVEGAÇÃO — QUANTIDADE DE ITENS
# =============================================================================

Pdv - Navigate To Change Item Quantity
    [Documentation]    Altera a quantidade de um item no carrinho e finaliza o pedido.
    Pdv - Navigate To New Order
    Click Element Multiple Times    ${orders.item}    5
    Pdv - Orders - Click Conference
    Pdv - Orders - Click Quantity Remove
    Click Element Multiple Times    ${orders.quantity_add}    2
    Pdv - Orders - Click Finalize Order
    Pdv - Orders - Click Payment Money
    Pdv - Orders - Click Confirm Value
    Pdv - Orders - Click Finish Order
    Pdv - Orders - Click Home
    Pdv - Home - Verify Visible

# =============================================================================
# NAVEGAÇÃO — CONFERÊNCIA DE PEDIDO
# =============================================================================

Pdv - Navigate To Toggle Conference Setting
    [Documentation]    Alterna o toggle de conferência ao finalizar pedido nas configurações.
    Pdv - Navigate To Settings
    Pdv - Settings - Click Smart PDV
    Pdv - Settings - Click Conference Order
    Pdv - Settings - Click Back Settings
    Pdv - Settings - Click Back Settings

Pdv - Navigate To Order Conference Off
    [Documentation]    Realiza pedido com conferência desativada (fluxo direto sem carrinho).
    Pdv - Navigate To Toggle Conference Setting
    Pdv - Navigate To New Order
    Pdv - Orders - Click Item
    Pdv - Orders - Click Conference
    Pdv - Orders - Click Payment Money
    Pdv - Orders - Click Confirm Value
    Pdv - Orders - Click Finish Order
    Pdv - Orders - Click Home
    Pdv - Home - Verify Visible
    Pdv - Navigate To Toggle Conference Setting

Pdv - Navigate To Order Conference Off Cart
    [Documentation]    Realiza pedido com conferência desativada validando o carrinho.
    Pdv - Navigate To Toggle Conference Setting
    Pdv - Navigate To New Order
    Pdv - Orders - Click Item
    Pdv - Orders - Click Cart
    Pdv - Orders - Click Finalize Order
    Pdv - Orders - Click Payment Money
    Pdv - Orders - Click Confirm Value
    Pdv - Orders - Click Finish Order
    Pdv - Orders - Click Home
    Pdv - Home - Verify Visible
    Pdv - Navigate To Toggle Conference Setting

# =============================================================================
# NAVEGAÇÃO — DESCONTO
# =============================================================================

Pdv - Navigate To Apply Discount
    [Documentation]    Aplica desconto em item e finaliza o pedido. Modos: percent, integer.
    [Arguments]    ${mode}=percent
    Pdv - Navigate To New Order
    Pdv - Orders - Click Item Discount
    Pdv - Orders - Click Conference
    Pdv - Orders - Click Finalize Order
    IF    '${mode}' == 'percent'
        Pdv - Orders - Click Discount Percent
    ELSE
        Pdv - Orders - Click Discount Integer
    END
    Pdv - Orders - Input Discount Value    1200
    Pdv - Orders - Clear And Input Discount Value    1000
    Pdv - Orders - Click Payment Money
    Pdv - Orders - Click Confirm Value
    Pdv - Orders - Click Finish Order
    Pdv - Orders - Click Home
    Pdv - Home - Verify Visible

# =============================================================================
# NAVEGAÇÃO — REMOÇÃO DE ITEM
# =============================================================================

Pdv - Navigate To Remove Item
    [Documentation]    Remove itens do pedido via long press e ícone do carrinho, confirmando as remoções.
    Pdv - Navigate To New Order
    Pdv - Orders - Click Item
    Pdv - Orders - Click Item 2
    Pdv - Orders - Click Item Discount
    Pdv - Orders - Long Press Item 2
    Pdv - Orders - Click Remove Item
    Pdv - Orders - Verify Remove Item Dialog
    Pdv - Orders - Click Remove Item Confirm
    Pdv - Orders - Click Conference
    Pdv - Orders - Click Remove Item Icon
    Pdv - Orders - Verify Remove Item Dialog
    Pdv - Orders - Click Remove Item Confirm
    Pdv - Orders - Click Finalize Order
    Pdv - Orders - Click Payment Money
    Pdv - Orders - Click Confirm Value
    Pdv - Orders - Click Finish Order
    Pdv - Orders - Click Home
    Pdv - Home - Verify Visible

Pdv - Navigate To Remove Item no-confirm
    [Documentation]    Tenta remover itens do pedido e cancela as remoções.
    Pdv - Navigate To New Order
    Pdv - Orders - Click Item
    Pdv - Orders - Click Item 2
    Pdv - Orders - Click Item Discount
    Pdv - Orders - Long Press Item 2
    Pdv - Orders - Click Remove Item
    Pdv - Orders - Verify Remove Item Dialog
    Pdv - Orders - Click Remove Item Cancel
    Pdv - Orders - Click Conference
    Pdv - Orders - Click Remove Item Icon
    Pdv - Orders - Verify Remove Item Dialog
    Pdv - Orders - Click Remove Item Cancel
    Pdv - Orders - Click Finalize Order
    Pdv - Orders - Click Payment Money
    Pdv - Orders - Click Confirm Value
    Pdv - Orders - Click Finish Order
    Pdv - Orders - Click Home
    Pdv - Home - Verify Visible

# =============================================================================
# NAVEGAÇÃO — TICKET
# =============================================================================

Pdv - Navigate To Configure Ticket
    [Documentation]    Configura o modo de emissão de ticket nas configurações. Modos: print, quest_yes, quest_no, noaction.
    [Arguments]    ${mode}
    Pdv - Navigate To Settings
    Swipe    start_x=469    start_y=603    end_x=466    end_y=417
    Pdv - Settings - Click Ticket
    Pdv - Settings - Click Ticket Action List
    IF    '${mode}' == 'print'
        Pdv - Settings - Click Ticket Print
    ELSE IF    '${mode}' in ['quest_yes', 'quest_no']
        Pdv - Settings - Click Ticket Quest
    ELSE IF    '${mode}' == 'noaction'
        Pdv - Settings - Click Ticket Noaction
    END
    Pdv - Settings - Click Back
    Pdv - Settings - Click Back Settings

Pdv - Navigate To Create Order With Ticket
    [Documentation]    Cria pedido com ticket (10 itens) e finaliza com pagamento em dinheiro.
    Pdv - Navigate To New Order
    Pdv - Orders - Click Item
    Pdv - Orders - Click Conference
    Pdv - Orders - Click Quantity Field
    Pdv - Orders - Input Quantity    10
    Pdv - Orders - Click Quantity Confirm
    Pdv - Orders - Click Finalize Order
    Pdv - Orders - Click Payment Money
    Pdv - Orders - Click Confirm Value
    Pdv - Orders - Click Finish Order

Pdv - Navigate To Ticket Print
    [Documentation]    Realiza pedido com ticket configurado para imprimir automaticamente.
    Pdv - Navigate To Configure Ticket    mode=print
    Pdv - Navigate To Create Order With Ticket
    Pdv - Orders - Click Home
    Pdv - Navigate To Configure Ticket    mode=noaction
    Pdv - Home - Verify Visible

Pdv - Navigate To Ticket Quest Yes
    [Documentation]    Realiza pedido com ticket configurado para perguntar, responde Sim.
    Pdv - Navigate To Configure Ticket    mode=quest_yes
    Pdv - Navigate To Create Order With Ticket
    Pdv - Settings - Verify Ticket Quest Visible
    Pdv - Settings - Click Ticket Quest Confirm
    Pdv - Orders - Click Home
    Pdv - Navigate To Configure Ticket    mode=noaction
    Pdv - Home - Verify Visible

Pdv - Navigate To Ticket Quest No
    [Documentation]    Realiza pedido com ticket configurado para perguntar, responde Não.
    Pdv - Navigate To Configure Ticket    mode=quest_no
    Pdv - Navigate To Create Order With Ticket
    Pdv - Settings - Verify Ticket Quest Visible
    Pdv - Settings - Click Ticket Quest Cancel
    Pdv - Orders - Click Home
    Pdv - Navigate To Configure Ticket    mode=noaction
    Pdv - Home - Verify Visible

# =============================================================================
# NAVEGAÇÃO — LISTA DE PEDIDOS
# =============================================================================

Pdv - Navigate To Visualize Order
    [Documentation]    Abre a lista de pedidos, visualiza o primeiro e retorna à tela inicial.
    Pdv - Navigate To List Orders
    Pdv - List Orders - Click First Order
    Pdv - List Orders - Click Visualize Order
    Pdv - List Orders - Verify Details Visible
    Pdv - List Orders - Click Back
    Pdv - List Orders - Click Back
    Pdv - Home - Verify Visible

Pdv - Navigate To Reprint Order
    [Documentation]    Abre a lista de pedidos e reimprime o primeiro pedido.
    Pdv - Navigate To List Orders
    Pdv - List Orders - Click First Order
    Pdv - List Orders - Click Reprint
    Pdv - List Orders - Verify Reprint Visible
    Pdv - List Orders - Click Back
    Pdv - Home - Verify Visible

Pdv - Navigate To List Orders Cancel Order
    [Documentation]    Abre a lista de pedidos e cancela o primeiro pedido.
    Pdv - Navigate To List Orders
    Pdv - List Orders - Click First Order
    Pdv - List Orders - Click Cancel Order
    Pdv - List Orders - Verify Cancel Dialog
    Pdv - List Orders - Click Cancel Confirm
    Pdv - List Orders - Click Back
    Pdv - Home - Verify Visible

Pdv - Navigate To Print Receipts
    [Documentation]    Abre o menu de impressão da lista de pedidos e imprime recebimentos.
    Pdv - Navigate To List Orders
    Pdv - List Orders - Click Print
    Pdv - List Orders - Click Receipts
    Pdv - List Orders - Click Back
    Pdv - Home - Verify Visible

Pdv - Navigate To Print Sales Summary
    [Documentation]    Abre o menu de impressão da lista de pedidos e imprime resumo de vendas.
    Pdv - Navigate To List Orders
    Pdv - List Orders - Click Print
    Pdv - List Orders - Click Sales Summary
    Pdv - List Orders - Click Back
    Pdv - Home - Verify Visible

Pdv - Navigate To Print Cancel
    [Documentation]    Abre o menu de impressão da lista de pedidos e volta sem imprimir.
    Pdv - Navigate To List Orders
    Pdv - List Orders - Click Print
    Pdv - List Orders - Click Print Back
    Pdv - Home - Verify Visible

# =============================================================================
# NAVEGAÇÃO — SINCRONIZAÇÃO
# =============================================================================

Pdv - Navigate To Sync Products
    [Documentation]    Sincroniza os produtos.
    Pdv - Navigate To Sync
    Pdv - Sync - Click Products
    Pdv - Sync - Click Sync Button
    Pdv - Sync - Verify Sync Done
    Pdv - Sync - Click Sync Confirm
    Pdv - Home - Verify Visible

Pdv - Navigate To Sync Clients
    [Documentation]    Sincroniza os clientes.
    Pdv - Navigate To Sync
    Pdv - Sync - Click Clients
    Pdv - Sync - Click Sync Button
    Pdv - Sync - Verify Sync Done
    Pdv - Sync - Click Sync Confirm
    Pdv - Home - Verify Visible

Pdv - Navigate To Sync Orders
    [Documentation]    Sincroniza os pedidos.
    Pdv - Navigate To Sync
    Pdv - Sync - Click Orders
    Pdv - Sync - Click Sync Button
    Pdv - Sync - Verify Sync Done
    Pdv - Sync - Click Sync Confirm
    Pdv - Home - Verify Visible

Pdv - Navigate To Sync All
    [Documentation]    Sincroniza todos os dados (produtos, clientes e pedidos).
    Pdv - Navigate To Sync
    Pdv - Sync - Click Products
    Pdv - Sync - Click Clients
    Pdv - Sync - Click Orders
    Pdv - Sync - Click Sync Button
    Pdv - Sync - Verify Sync Done
    Pdv - Sync - Click Sync Confirm
    Pdv - Home - Verify Visible

Pdv - Navigate To Cancel Sync
    [Documentation]    Abre a sincronização e cancela antes de concluir.
    Pdv - Navigate To Sync
    Pdv - Sync - Click Cancel
    Pdv - Home - Verify Visible

# =============================================================================
# NAVEGAÇÃO — CLIENTES
# =============================================================================

Pdv - Navigate To Register Client
    [Documentation]    Cadastra um novo cliente pessoa física com dados gerados via Faker.
    ${raw_cpf}=    faker.Cpf
    ${cpf}=    Normalize Digits    ${raw_cpf}
    ${name}=    faker.Name
    ${email}=    faker.Email
    ${zip_code}=    faker.Postcode
    ${address}=    faker.Street Address
    ${number}=    faker.Building Number
    ${neighborhood}=    faker.Bairro
    ${complement}=    faker.Bothify    Apto ?##
    ${raw_telephone}=    faker.Cellphone Number
    ${telephone}=    Normalize Digits    ${raw_telephone}
    Pdv - Navigate To Clients
    Pdv - Clients - Click New Client
    Pdv - Clients - Click Type Client
    Pdv - Clients - Click Type Fisic
    Pdv - Clients - Input CPF    ${cpf}
    Pdv - Clients - Input Name    ${name}
    Pdv - Clients - Input Telephone    ${telephone}
    Pdv - Clients - Input Email    ${email}
    Pdv - Clients - Click Address Page
    Pdv - Clients - Input CEP    ${zip_code}
    Pdv - Clients - Input Address    ${address}
    Pdv - Clients - Input Number    ${number}
    Pdv - Clients - Input Neighborhood    ${neighborhood}
    Pdv - Clients - Click UF
    Swipe    start_x=123    start_y=722    end_x=123    end_y=252
    Swipe    start_x=120    start_y=728    end_x=120    end_y=215
    Pdv - Clients - Click UF PB
    Pdv - Clients - Click City
    Pdv - Clients - Click City Select
    Pdv - Clients - Input Complement    ${complement}
    Pdv - Clients - Click Save
    Pdv - Clients - Click Back
    Pdv - Home - Verify Visible