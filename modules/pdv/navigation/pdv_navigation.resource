*** Settings ***
Documentation       Fluxos de navegação/configuração do módulo Pdv — composição de page keywords.
...
...                 Nomenclatura: Pdv - Navigate To <Destino>
...                 Dependências: pages abaixo + locators carregados via base_pdv.resource

Resource            ../pages/home_page.resource
Resource            ../pages/orders_page.resource
Resource            ../pages/checkout_page.resource
Resource            ../pages/clients_page.resource
Resource            ../pages/orderslist_page.resource
Resource            ../pages/sync_page.resource


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

Pdv - Navigate To Search And Select First Product Card
    [Documentation]    Pesquisa pelo termo informado e seleciona o primeiro card retornado.
    [Arguments]    ${search_term}
    Pdv - Orders - Click Search Input
    Pdv - Orders - Type Product Name    ${search_term}
    Pdv - Orders - Click First Product Card

Pdv - Navigate To Input Barcode By Adb
    [Documentation]    Insere código de barras via ADB e confirma com Enter.
    [Arguments]    ${barcode}
    Pdv - Orders - Input Barcode By Adb    ${barcode}

Pdv - Navigate To Search Product And Verify Promotion Badge
    [Documentation]    Pesquisa um produto e valida o badge de promoção antes da seleção.
    [Arguments]    ${product_name}
    Pdv - Orders - Click Search Input
    Pdv - Orders - Type Product Name    ${product_name}
    Pdv - Orders - Verify Promotion Badge Visible

Pdv - Navigate To Search Product And Verify Stock
    [Documentation]    Pesquisa um produto e valida a exibição do estoque antes da seleção.
    [Arguments]    ${product_name}
    Pdv - Orders - Click Search Input
    Pdv - Orders - Type Product Name    ${product_name}
    Pdv - Orders - Verify Stock Info Visible

Pdv - Navigate To Select Product With Stock
    [Documentation]    Pesquisa, valida estoque e seleciona o produto.
    [Arguments]    ${product_name}
    Pdv - Navigate To Search Product And Verify Stock    ${product_name}
    Pdv - Orders - Click Product By Name    ${product_name}

Pdv - Navigate To Select Product With Promotion Badge
    [Documentation]    Pesquisa, valida o badge de promoção e seleciona o produto.
    [Arguments]    ${product_name}
    Pdv - Navigate To Search Product And Verify Promotion Badge    ${product_name}
    Pdv - Orders - Click Product By Name    ${product_name}

Pdv - Navigate To Clear Product Search
    [Documentation]    Limpa a pesquisa de produto.
    Pdv - Orders - Click Clear Search

Pdv - Navigate To Select Price Table A
    [Documentation]    Abre o modal de tabela de preço, seleciona Preço A e confirma.
    Pdv - Orders - Click Price Table Button
    Pdv - Orders - Verify Price Table Modal Visible
    Pdv - Orders - Click Price Table A
    Pdv - Orders - Click Price Table Modal Confirm
    Pdv - Orders - Verify Price Table Change Dialog Visible
    Pdv - Orders - Click Price Table Change Confirm

Pdv - Navigate To Cancel Order
    [Documentation]    Cancela o pedido atual e confirma o modal de cancelamento.
    Pdv - Orders - Click Cancel Order New
    Pdv - Orders - Verify Cancel Dialog
    Pdv - Orders - Click Cancel Confirm

Pdv - Navigate To Check Order
    [Documentation]    Avança para a conferência do pedido.
    Pdv - Orders - Click Conference

Pdv - Navigate To Finish Order
    [Documentation]    Finaliza o pedido e avança para pagamento.
    Pdv - Orders - Click Finalize Order

Pdv - Navigate To Finish Order From New Order
    [Documentation]    Finaliza o pedido pela tela de Novo Pedido e avança para pagamento.
    Pdv - Orders - Click Finalize Order New Order

Pdv - Navigate To Select Client
    [Documentation]    Pesquisa, seleciona e confirma o cliente no carrinho ou no modal já aberto.
    [Arguments]    ${client_name}
    ${edit_client_visible}=    Run Keyword And Return Status
    ...    Wait Until Element Is Visible    ${cart.btn_edit_client}    timeout=5s
    IF    ${edit_client_visible}    Pdv - Orders - Click Edit Client
    Pdv - Orders - Input Client Modal Client    ${client_name}
    Pdv - Orders - Click Client By Name    ${client_name}
    Pdv - Orders - Click Client Modal Confirm

Pdv - Navigate To Add Items From Cart
    [Documentation]    Retorna do carrinho para a tela de produtos para adicionar itens.
    Pdv - Orders - Click Cart

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

Pdv - Navigate To Edit Quantity
    [Documentation]    Edita a quantidade diretamente no modal de quantidade.
    [Arguments]    ${quantity}
    Pdv - Orders - Click Quantity Field
    Pdv - Orders - Input Quantity    ${quantity}
    Pdv - Navigate To Confirm Quantity

Pdv - Navigate To Remove Product From Order
    [Documentation]    Remove o produto selecionado no modal de quantidade.
    Pdv - Orders - Click Remove Item
    Pdv - Orders - Verify Remove Item Dialog
    Pdv - Orders - Click Remove Item Confirm

Pdv - Navigate To Add Cart Item Quantity
    [Documentation]    Aumenta a quantidade do item informado diretamente no carrinho.
    [Arguments]    ${product_name}    ${times}
    Repeat Keyword    ${times} times    Pdv - Orders - Click Cart Item Add By Name    ${product_name}

Pdv - Navigate To Remove Cart Item Quantity
    [Documentation]    Diminui a quantidade do item informado diretamente no carrinho.
    [Arguments]    ${product_name}    ${times}
    Repeat Keyword    ${times} times    Pdv - Orders - Click Cart Item Sub By Name    ${product_name}

Pdv - Navigate To Remove Cart Item By Name
    [Documentation]    Abre o modal de edição do item informado, remove o item e confirma o dialog.
    [Arguments]    ${product_name}
    Pdv - Orders - Click Cart Item Quantity By Name    ${product_name}
    Pdv - Orders - Click Remove Item
    Pdv - Orders - Verify Remove Item Dialog
    Pdv - Orders - Click Remove Item Confirm

Pdv - Navigate To Remove Cart Item By Icon
    [Documentation]    Remove o item informado pelo ícone de remoção exibido no carrinho e confirma o dialog.
    [Arguments]    ${product_name}
    Pdv - Orders - Click Remove Item Icon By Name    ${product_name}
    Pdv - Orders - Verify Remove Item Icon Dialog
    Pdv - Orders - Click Remove Item Icon Confirm

Pdv - Navigate To Edit Cart Item Quantity By Name
    [Documentation]    Abre o modal de quantidade pelo item informado, ajusta e confirma.
    [Arguments]    ${product_name}    ${add_times}    ${remove_times}
    Pdv - Orders - Click Cart Item Quantity By Name    ${product_name}
    Pdv - Navigate To Add Quantity    ${add_times}
    Pdv - Navigate To Remove Quantity    ${remove_times}
    Pdv - Navigate To Confirm Quantity

Pdv - Navigate To Edit Cart Item Unit Price By Name
    [Documentation]    Abre o modal de edição do item, altera preço unitário e confirma.
    [Arguments]    ${product_name}    ${unit_price}
    Pdv - Orders - Click Cart Item Quantity By Name    ${product_name}
    Pdv - Orders - Input Cart Item Unit Price    ${unit_price}
    Pdv - Orders - Click Cart Item Edit Confirm

Pdv - Navigate To Apply Cart Item Discount Integer By Name
    [Documentation]    Aplica desconto em valor fixo no item informado do carrinho.
    [Arguments]    ${product_name}    ${discount_value}
    Pdv - Orders - Click Cart Item Quantity By Name    ${product_name}
    Pdv - Orders - Click Cart Item Discount
    Pdv - Orders - Click Cart Item R$
    Pdv - Orders - Input Cart Item Discount Value    ${discount_value}
    Pdv - Orders - Click Cart Item Edit Confirm

Pdv - Navigate To Apply Cart Item Discount Percent By Name
    [Documentation]    Aplica desconto percentual no item informado do carrinho.
    [Arguments]    ${product_name}    ${discount_value}
    Pdv - Orders - Click Cart Item Quantity By Name    ${product_name}
    Pdv - Orders - Click Cart Item Discount
    Pdv - Orders - Click Cart Item Percent
    Pdv - Orders - Input Cart Item Discount Value    ${discount_value}
    Pdv - Orders - Click Cart Item Edit Confirm

Pdv - Navigate To Apply Discount Integer
    [Documentation]    Aplica desconto em valor fixo no carrinho.
    [Arguments]    ${discount_value}
    Pdv - Orders - Click Discount-Sum
    Pdv - Orders - Click Discount
    Pdv - Orders - Click R$
    Pdv - Orders - Input Discount Value    ${discount_value}
    Pdv - Orders - Click Apply Discount

Pdv - Navigate To Apply Discount Percent
    [Documentation]    Aplica desconto percentual no carrinho.
    [Arguments]    ${discount_value}
    Pdv - Orders - Click Discount-Sum
    Pdv - Orders - Click Discount
    Pdv - Orders - Click Percent
    Pdv - Orders - Input Discount Value    ${discount_value}
    Pdv - Orders - Click Apply Discount

Pdv - Navigate To Apply Additional Percent
    [Documentation]    Aplica acréscimo percentual no carrinho.
    [Arguments]    ${additional_value}
    Pdv - Orders - Click Discount-Sum
    Pdv - Orders - Click Addition
    Pdv - Orders - Click Percent
    Pdv - Orders - Input Discount Value    ${additional_value}
    Pdv - Orders - Click Apply Discount

Pdv - Navigate To Apply Additional Integer
    [Documentation]    Aplica acréscimo em valor fixo no carrinho.
    [Arguments]    ${additional_value}
    Pdv - Orders - Click Discount-Sum
    Pdv - Orders - Click Addition
    Pdv - Orders - Click R$
    Pdv - Orders - Input Discount Value    ${additional_value}
    Pdv - Orders - Click Apply Discount

# =============================================================================
# NAVEGAÇÃO — LISTA DE PEDIDOS
# =============================================================================

Pdv - Navigate To View Order
    [Documentation]    Clica no primeiro pedido, visualiza, verifica a tela e volta para a lista.
    Orders List - Click First Order
    Orders List - Actions Modal Click View Order
    Orders List - View Order Screen Should Be Visible
    Orders List - Click Back

Pdv - Navigate To Reprint First Order Receipt
    [Documentation]    Clica no primeiro pedido, reimprimi o comprovante e verifica o status de impressão.
    Orders List - Click First Order
    Orders List - Actions Modal Click Reprint Receipt
    Orders List - Print Status Should Be Printing
    Orders List - Print Status Should Not Be Completed

Pdv - Navigate To Fiscal Details First Order
    [Documentation]    Clica no primeiro pedido, abre Detalhes da Nota Fiscal, verifica e volta para a lista.
    Orders List - Click First Order
    Orders List - Actions Modal Click Fiscal Details
    Orders List - Fiscal Details Screen Should Be Visible
    Orders List - Click Back

Pdv - Navigate To Cancel First Order
    [Documentation]    Clica no primeiro pedido, cancela, confirma e fecha o modal de sucesso.
    Orders List - Click First Order
    Orders List - Actions Modal Click Cancel Order
    Orders List - Cancel Order Modal Should Be Visible
    Orders List - Cancel Order Modal Click Yes
    Orders List - Cancel Order Success Should Be Visible
    Orders List - Cancel Order Click Ok

Pdv - Navigate To Print Receipts
    [Documentation]    Abre o modal de impressão, seleciona Recebimentos e verifica o ciclo de status.
    Orders List - Click Print
    Orders List - Print Options Click Receipts
    Orders List - Print Status Should Be Printing
    Orders List - Print Status Should Be Completed
    Orders List - Print Status Should Not Be Completed

Pdv - Navigate To Print Sales Summary
    [Documentation]    Abre o modal de impressão, seleciona Resumo de Vendas e verifica o ciclo de status.
    Orders List - Click Print
    Orders List - Print Options Click Sales Summary
    Orders List - Print Status Should Be Printing
    Orders List - Print Status Should Be Completed
    Orders List - Print Status Should Not Be Completed

# =============================================================================
# NAVEGAÇÃO — LISTA DE CLIENTES
# =============================================================================

Pdv - Navigate To Clients
    [Documentation]    Navega da Home para a Lista de Clientes.
    Pdv - Home - Click Clients

Pdv - Navigate To Sync Client List
    [Documentation]    Aciona a sincronização na Lista de Clientes, aguarda o modal de confirmação e fecha.
    Client List - Click Sync
    Sync - Success Modal Should Be Visible
    Sync - Click Success Ok

Pdv - Navigate To Search And Select Client
    [Documentation]    Pesquisa e seleciona um cliente na Lista de Clientes pelo nome.
    [Arguments]    ${client_name}
    Client List - Search Client    ${client_name}
    Client List - Click Client By Name    ${client_name}

Pdv - Navigate To Init Order From Client
    [Documentation]    Clica em "Iniciar Venda" no cadastro do cliente para iniciar um novo pedido.
    Client Register - Click Init Order

Pdv - Navigate To New Client
    [Documentation]    Clica em "+ Novo Cliente" e posiciona na tab Detalhes.
    Client List - Click New Client
    Client Register - Click Tab Details

Pdv - Navigate To Fill Client Details
    [Documentation]    Preenche os campos de detalhes do cadastro: tipo de pessoa, CPF, nome, telefone, e-mail e observação.
    [Arguments]    ${person_type}    ${cpf}    ${name}    ${phone}    ${email}    ${note}
    Client Register - Select Person Type    ${person_type}
    Client Register - Fill Cpf    ${cpf}
    Client Register - Fill Name    ${name}
    Client Register - Fill Phone    ${phone}
    Client Register - Fill Email    ${email}
    Client Register - Fill Note    ${note}

Pdv - Navigate To Fill Client Details Juridic
    [Documentation]    Preenche os campos de detalhes do cadastro Jurídico: tipo de pessoa, CNPJ, nome fantasia, razão social, telefone, e-mail e observação.
    [Arguments]    ${person_type}    ${cnpj}    ${fantasy_name}    ${social_reason}    ${phone}    ${email}    ${note}
    Client Register - Select Person Type    ${person_type}
    Client Register - Fill Cnpj    ${cnpj}
    Client Register - Fill Fantasy Name    ${fantasy_name}
    Client Register - Fill Social Reason    ${social_reason}
    Client Register - Fill Phone    ${phone}
    Client Register - Fill Email    ${email}
    Client Register - Fill Note    ${note}

Pdv - Navigate To Fill Client Address
    [Documentation]    Seleciona a tab Endereço, preenche CEP, consulta e preenche número e complemento.
    [Arguments]    ${cep}    ${number}    ${complement}
    Client Register - Click Tab Address
    Client Register - Fill Cep    ${cep}
    Client Register - Click Consultar Cep
    Client Register - Fill Number    ${number}
    Client Register - Fill Complement    ${complement}

Pdv - Navigate To Save And Verify Client
    [Documentation]    Salva o cadastro, aguarda o formulário fechar, pesquisa pelo nome, verifica e volta.
    [Arguments]    ${client_name}
    Client Register - Click Save
    Wait For Element To Disappear    ${client_register.btn_save}
    Wait Until Element Is Visible    ${client_list.search_input}    timeout=${ELEMENT_TIMEOUT}
    Client List - Search Client    ${client_name}
    Client List - Client Should Be Visible    ${client_name}
    Client List - Click Back

Pdv - Navigate To Save And Verify Client By Cnpj
    [Documentation]    Salva o cadastro, aguarda o formulário fechar, pesquisa pelo CNPJ, verifica pela Razão Social e volta.
    [Arguments]    ${cnpj}    ${social_reason}
    Client Register - Click Save
    Wait For Element To Disappear    ${client_register.btn_save}
    Wait Until Element Is Visible    ${client_list.search_input}
    Client List - Search Client    ${cnpj}
    Client List - Client Should Be Visible    ${social_reason}
    Client List - Click Back

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
        ${payment_method_name}=    Set Variable    PIX OFF
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

Pdv - Navigate To Configure Bank Slip Payment
    [Documentation]    Configura parcelas, prazo e data do boleto antes de confirmar o pagamento.
    [Arguments]    ${parcels_add_times}    ${term_days}    ${due_day}
    ${due_day}=    Convert To Integer    ${due_day}
    ${due_day}=    Convert To String    ${due_day}
    Repeat Keyword    ${parcels_add_times} times    Pdv - Checkout - Click Bank Slip Add
    Pdv - Checkout - Input Bank Slip Term    ${term_days}
    Pdv - Checkout - Click Calendar
    Pdv - Checkout - Verify Calendar Day Visible    ${due_day}
    Pdv - Checkout - Click Day By Number    ${due_day}

Pdv - Navigate To Finish Sale
    [Documentation]    Finaliza a venda no checkout.
    Pdv - Checkout - Click Finish Sale
