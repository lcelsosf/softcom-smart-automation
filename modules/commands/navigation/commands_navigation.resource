*** Settings ***
Documentation    Fluxos de navegação do módulo Commands — composição de page keywords.
...
...    Nomenclatura: Commands - Navigate To <Destino>
...    Dependências: pages abaixo + locators carregados via base_commands.resource
Resource    ../pages/table_panel_page.resource
Resource    ../pages/open_table_page.resource
Resource    ../pages/client_page.resource
Resource    ../pages/table_page.resource
Resource    ../pages/products_page.resource
Resource    ../pages/menu_table_page.resource
Resource    ../pages/advance_page.resource
Resource    ../pages/invoice_page.resource
Resource    ../pages/split_account_page.resource
Resource    ../pages/change_client_page.resource
Resource    ../pages/cancel_table_page.resource
Resource    ../pages/manage_service_charge_page.resource
Resource    ../pages/join_accounts_page.resource


*** Keywords ***
# =============================================================================
# NAVEGAÇÃO — ABERTURA DE MESA
# =============================================================================

Commands - Navigate To Open Table
    [Documentation]    Abre uma nova mesa informando número e nome do cliente.
    [Arguments]    ${table_number}    ${client_name}
    Commands - Table Panel - Click Open Table
    Commands - Open Table - Input Number Table    ${table_number}
    Commands - Open Table - Input Client Name    ${client_name}
    Commands - Open Table - Click Confirm

Commands - Navigate To Search Table And Open
    [Documentation]    Localiza e abre uma mesa já existente pelo número.
    [Arguments]    ${table_number}
    Commands - Table Panel - Search Table    ${table_number}
    Commands - Table Panel - Click Table Item

# =============================================================================
# NAVEGAÇÃO — ITENS
# =============================================================================

Commands - Add Items To Table
    [Documentation]    Busca e adiciona N itens à mesa em sequência, depois avança.
    ...
    ...    Exemplo:
    ...    Commands - Add Items To Table    Frango
    ...    Commands - Add Items To Table    Frango    Cerveja    Água
    [Arguments]    @{item_names}
    FOR    ${item}    IN    @{item_names}
        Commands - Products - Search Item    ${item}
        Commands - Products - Click Product
        Commands - Products - Click Add Item
        Commands - Table - Click Clean Search
    END
    Commands - Table - Click Advance
    Commands - Table - Click Advance

Commands - Products - Product Not Visible
    [Documentation]    Verifica se está sendo exibida a tela de produto nao encontrado.
    Commands - Table - Empty State

Commands - Search item and select
    [Documentation]    Busca um item na lista de produtos.
    [Arguments]    ${item_name}
    Commands - Products - Search Item    ${item_name}
    Commands - Products - Click Product
Commands - Add item throw
    [Documentation]    Adiciona um item à mesa.
    Commands - Products - Click Add Item
    Commands - Table - Click Clean Search
    Commands - Table - Click Advance
    Commands - Table - Click Advance

# =============================================================================
# NAVEGAÇÃO — FATURAMENTO
# =============================================================================

Commands - Navigate To Invoice And Pay
    [Documentation]    Fatura a mesa com o método de pagamento informado.
    ...    Métodos suportados: money, pixoff
    [Arguments]    ${payment_method}
    Commands - Table - Click Menu
    Commands - Menu Table - Click Invoice
    IF    '${payment_method}' == 'money'
        Commands - Invoice - Click Payment Money
    ELSE IF    '${payment_method}' == 'pixoff'
        Commands - Invoice - Click Payment Pixoff
    END
    Commands - Invoice - Click Confirm Value
    Commands - Invoice - Click Finalize Sale
    Commands - Table Panel - Verify Panel Visible

# =============================================================================
# NAVEGAÇÃO — ADIANTAMENTO
# =============================================================================

Commands - Navigate To Advance
    [Documentation]    Registra um adiantamento na mesa com cliente, valor e forma de pagamento.
    ...    Métodos suportados: money, pixoff
    [Arguments]    ${client_name}    ${advance_value}    ${payment_method}
    Commands - Table - Click Menu
    Commands - Menu Table - Click Advance
    Commands - Advance - Click New Advance
    Commands - Advance - Input Client Name    ${client_name}
    Commands - Advance - Input Value    ${advance_value}
    Commands - Advance - Click Payment Form
    IF    '${payment_method}' == 'money'
        Commands - Advance - Select Payment Money
    ELSE IF    '${payment_method}' == 'pixoff'
        Commands - Advance - Select Payment Pixoff
    END
    Commands - Advance - Click Confirm
    Commands - Advance - Click Back

# =============================================================================
# NAVEGAÇÃO — DEMAIS OPÇÕES DO MENU
# =============================================================================

Commands - Navigate To Split Account
    [Documentation]    Navega até o dialog de divisão de conta.
    Commands - Table - Click Menu
    Commands - Menu Table - Click Split Account
    Commands - Split Account - Verify Visible

Commands - Navigate To Change Client
    [Documentation]    Navega até o dialog de alteração de cliente.
    Commands - Table - Click Menu
    Commands - Menu Table - Click Change Client

Commands - Navigate To Join Accounts
    [Documentation]    Navega até o dialog de junção de contas.
    Commands - Table - Click Menu
    Commands - Menu Table - Click Join Accounts

# =============================================================================
# NAVEGAÇÃO — CANCELAMENTO DE MESA
# =============================================================================

Commands - Navigate To Cancel Table
    [Documentation]    Cancela a mesa informando o motivo e confirmando o cancelamento.
    [Arguments]    ${cancel_reason}
    Commands - Table - Click Menu
    Commands - Menu Table - Click Cancel Table
    Commands - Cancel Table - Verify Reason Field
    Commands - Cancel Table - Input Cancel Reason    ${cancel_reason}
    Commands - Cancel Table - Click Confirm
    Commands - Cancel Table - Verify Cancel Question
    Commands - Cancel Table - Click Confirm Cancel

Commands - Navigate To Cancel Table no-reason
    [Documentation]    Cancela a mesa sem informar o motivo e confirmando o cancelamento.
    Commands - Table - Click Menu
    Commands - Menu Table - Click Cancel Table
    Commands - Cancel Table - Verify Reason Field
    Commands - Cancel Table - Click Confirm
    Commands - Cancel Table - Verify Cancel Question
    Commands - Cancel Table - Click Confirm Cancel

# =============================================================================
# NAVEGAÇÃO — GESTÃO DE TAXAS DE SERVIÇO
# =============================================================================

Commands - Navigate To Manage Service Charge
    [Documentation]    Navega até o dialog de gerenciamento de taxas de serviço.
    Commands - Table - Click Menu
    Commands - Menu Table - Click Manage Service Charge
    Commands - Manage Service Charge - Verify Visible
    Commands - Manage Service Charge - Active/Deactive
    Commands - Manage Service Charge - Confirm
    Commands - Manage Service Charge - Verify Confirmation Dialog
    Commands - Manage Service Charge - Click Confirm Confirmation

# =============================================================================
# FLUXOS COMPLETOS - BUSINESS
# =============================================================================

Commands - Complete Flow - Open Table And Add Items And Invoice
    [Documentation]    Fluxo completo: abre mesa, adiciona itens e fatura.
    ...    Métodos suportados: money, pixoff
    [Arguments]    ${table_number}    ${client_name}    ${payment_method}    @{item_names}
    Commands - Navigate To Open Table    ${table_number}    ${client_name}
    Commands - Navigate To Search Table And Open    ${table_number}
    Commands - Add Items To Table    @{item_names}
    Commands - Navigate To Invoice And Pay    ${payment_method}

Commands - Complete Flow - Open Table And Record Advance
    [Documentation]    Fluxo completo: abre mesa e registra um adiantamento.
    ...    Métodos suportados: money, pixoff
    [Arguments]    ${table_number}    ${client_name}    ${advance_value}    ${payment_method}
    Commands - Navigate To Open Table    ${table_number}    ${client_name}
    Commands - Navigate To Search Table And Open    ${table_number}
    Commands - Navigate To Advance    ${client_name}    ${advance_value}    ${payment_method}

# =============================================================================
# FLUXOS COMPLETOS - REGRESSION
# =============================================================================

Commands - Complete Flow - Select Product And Alter Quantity
    [Documentation]    Fluxo completo: seleciona um produto, altera a quantidade e realiza o pagamento.
    [Arguments]    ${table_number}    ${client_name}    ${quantity}    ${payment_method}
    Commands - Navigate To Open Table    ${table_number}    ${client_name}
    Commands - Search item and select    product_additional
    Commands - 
    Commands - Navigate To Invoice And Pay    ${payment_method}

Commands - Complete Flow - Select Product Not Service
    [Documentation]    Fluxo completo: seleciona um produto que não contabiliza serviço.
    [Arguments]    ${table_number}    ${client_name}
    Commands - Navigate To Open Table    ${table_number}    ${client_name}
    Commands - Add Items To Table    product_not_service
    Commands - Navigate To Search Table And Open    ${table_number}
    Commands - Navigate To Invoice And Pay    money

Commands - Complete Flow - Select Product Disabled
    [Documentation]    Fluxo completo: seleciona um produto desativado.
    [Arguments]    ${table_number}    ${client_name}
    Commands - Navigate To Open Table    ${table_number}    ${client_name}
    Commands - Products - Search Item    product_disabled
    Commands - Products - Product Not Visible
    Commands - Add Items To Table    product_1
    Commands - Navigate To Search Table And Open    ${table_number}
    Commands - Navigate To Invoice And Pay    money

Commands- Complete Flow - Select Product Not Send To Order
    [Documentation]    Fluxo completo: seleciona um produto que não é enviado para a comanda.
    [Arguments]    ${table_number}    ${client_name}
    Commands - Navigate To Open Table    ${table_number}    ${client_name}
    Commands - Products - Search Item    product_not_send_to_order
    Commands - Products - Product Not Visible
    Commands - Add Items To Table  product_1
    Commands - Navigate To Search Table And Open  ${table_number}
    Commands - Navigate To Invoice And Pay    money

Commands - Complete Flow - Select Product Not Selling
    [Documentation]    Fluxo completo: seleciona um produto que está marcado para não vender.
    [Arguments]    ${table_number}    ${client_name}
    Commands - Navigate To Open Table    ${table_number}    ${client_name}
    Commands - Products - Search Item    product_not_selling
    Commands - Products - Product Not Visible
    Commands - Add Items To Table  product_1
    Commands - Navigate To Search Table And Open  ${table_number}
    Commands - Navigate To Invoice And Pay    money

Commands - Complete Flow - Select Product Promotion
    [Documentation]    Fluxo completo: seleciona um produto em promoção.
    [Arguments]    ${table_number}    ${client_name}
    Commands - Navigate To Open Table    ${table_number}    ${client_name}
    Commands - Add Items To Table  product_promotion
    Commands - Navigate To Search Table And Open  ${table_number}
    Commands - Navigate To Invoice And Pay    money

Commands - Complete Flow - Select Product Additionals
    [Documentation]    Fluxo completo: seleciona adicionais de um produto.
    [Arguments]    ${table_number}    ${client_name}
    Commands - Navigate To Open Table    ${table_number}    ${client_name}
    Commands - Search item and select    product_additional
    Commands - Products - Click Additional Add
#    Commands - Products - Click Additional Add 2
    Commands - Add item throw
    Commands - Navigate To Search Table And Open  ${table_number}
    Commands - Navigate To Invoice And Pay    money

Commands - Complete Flow - Print Conference
    [Documentation]    Fluxo completo: imprime a conferência da mesa.
    [Arguments]    ${table_number}    ${client_name}
    Commands - Navigate To Open Table    ${table_number}    ${client_name}
    Commands - Add Items To Table  product_1
    Commands - Navigate To Search Table And Open    ${table_number}
    Commands - Table - Click Conference Print
    Commands - Table - View Conference Question
    Commands - Table - Conference Confirm
    Commands - Navigate To Invoice And Pay    money

Commands - Complete Flow - Invoice With Money
    [Documentation]    Fluxo completo: realiza o pagamento com dinheiro.
    [Arguments]    ${table_number}    ${client_name}
    Commands - Navigate To Open Table    ${table_number}    ${client_name}
    Commands - Add Items To Table  product_1
    Commands - Navigate To Search Table And Open    ${table_number}
    Commands - Navigate To Invoice And Pay    money

Commands - Complete Flow - Invoice With Pix Off
    [Documentation]    Fluxo completo: realiza o pagamento com Pix Off.
    [Arguments]    ${table_number}    ${client_name}
    Commands - Navigate To Open Table    ${table_number}    ${client_name}
    Commands - Add Items To Table  product_1
    Commands - Navigate To Search Table And Open    ${table_number}
    Commands - Navigate To Invoice And Pay    pixoff

Commands - Complete Flow - Advance With Money
    [Documentation]    Fluxo completo: registra um adiantamento com dinheiro.
    [Arguments]    ${table_number}    ${client_name}
    Commands - Navigate To Open Table    ${table_number}    ${client_name}
    Commands - Add Items To Table    product_1    product_2
    Commands - Navigate To Search Table And Open    ${table_number}
    Commands - Navigate To Advance    ${client_name}    1,00    money
    Commands - Navigate To Invoice And Pay    money

Commands - Complete Flow - Advance With Pix Off
    [Documentation]    Fluxo completo: registra um adiantamento com Pix Off.
    [Arguments]    ${table_number}    ${client_name}
    Commands - Navigate To Open Table    ${table_number}    ${client_name}
    Commands - Add Items To Table    product_1    product_2
    Commands - Navigate To Search Table And Open    ${table_number}
    Commands - Navigate To Advance    ${client_name}    1,00    pixoff
    Commands - Navigate To Invoice And Pay    pixoff

Commands - Complete Flow - Split Account
    [Documentation]    Fluxo completo: divide a conta da mesa.
    [Arguments]    ${table_number}    ${client_name}
    Commands - Navigate To Open Table    ${table_number}    ${client_name}
    Commands - Add Items To Table    product_1
    Commands - Navigate To Search Table And Open    ${table_number}
    Commands - Navigate To Split Account
    Commands - Split Account - Click Add People
    Commands - Split Account - Click Sub People
    Commands - Split Account - Click Back
    Commands - Navigate To Invoice And Pay  money

Commands - Complete Flow - Change Client
    [Documentation]    Fluxo completo: altera o cliente da mesa.
    [Arguments]    ${table_number}    ${client_name}
    Commands - Navigate To Open Table    ${table_number}    ${client_name}
    Commands - Add Items To Table    product_1
    Commands - Navigate To Search Table And Open    ${table_number}
    Commands - Navigate To Change Client
    Commands - Change Client - Input Client Name    New Client
    Commands - Change Client - Click Add People
    Commands - Change Client - Click Sub People
    Commands - Change Client - Click Confirm
    Commands - Navigate To Invoice And Pay  money

Commands - Complete Flow - Join Accounts
    [Documentation]    Fluxo completo: junta as contas da mesa.
    [Arguments]    ${table_number}    ${table_number_2}    ${client_name}
    Commands - Navigate To Open Table    ${table_number}    ${client_name}
    Commands - Add Items To Table    product_1
    Commands - Navigate To Open Table    ${table_number_2}    ${client_name}
    Commands - Add Items To Table    product_2
    Commands - Navigate To Search Table And Open    ${table_number}
    Commands - Navigate To Join Accounts
    Commands - Join Accounts - Click Table
    Commands - Join Accounts - Click Confirm
    Commands - Join Accounts - Verify Join Question
    Commands - Join Accounts - Click Confirm Join
    Commands - Navigate To Invoice And Pay  money

Commands - Complete Flow - Cancel Table
    [Documentation]    Fluxo completo: cancela a mesa.
    [Arguments]    ${table_number}    ${client_name}    ${cancel_reason}
    Commands - Navigate To Open Table    ${table_number}    ${client_name}
    Commands - Add Items To Table    product_1
    Commands - Navigate To Search Table And Open    ${table_number}
    Commands - Navigate To Cancel Table    ${cancel_reason}
    Commands - Table Panel - Clear Search
    Commands - Table Panel - Verify Panel Visible

Commands - Complete Flow - Cancel Table no-reason
    [Documentation]    Fluxo completo: cancela a mesa sem informar o motivo.
    [Arguments]    ${table_number}    ${client_name}
    Commands - Navigate To Open Table    ${table_number}    ${client_name}
    Commands - Add Items To Table    product_1
    Commands - Navigate To Search Table And Open    ${table_number}
    Commands - Navigate To Cancel Table no-reason
    Commands - Table Panel - Clear Search
    Commands - Table Panel - Verify Panel Visible

Commands - Complete Flow - Manage Service Charge
    [Documentation]    Fluxo completo: gerencia taxas de serviço.
    [Arguments]    ${table_number}    ${client_name}
    Commands - Navigate To Open Table    ${table_number}    ${client_name}
    Commands - Add Items To Table    product_1
    Commands - Navigate To Search Table And Open    ${table_number}
    Commands - Navigate To Manage Service Charge
    Commands - Navigate To Invoice And Pay  money