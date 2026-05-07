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
Resource    ../pages/join_table_page.resource
Resource    ../pages/change_client_page.resource
Resource    ../pages/cancel_table_page.resource


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

# =============================================================================
# FLUXOS COMPLETOS
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
