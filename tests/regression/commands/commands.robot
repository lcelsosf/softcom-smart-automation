*** Settings ***
Documentation    Suite de regressão — módulo Commands (Comanda/Mesa)
...
...    Cobre os fluxos principais de abertura, operação e encerramento de mesas.
...    Pré-condição: app iniciado no Painel de Mesas.
Resource         ../../../modules/commands/base_commands.resource
Suite Setup      Suite Setup Default
Suite Teardown   Suite Teardown Default
Test Setup       Test Setup Default
Test Teardown    Test Teardown Default


*** Variables ***
${TABLE_CLIENT}          Cliente Teste
${CANCEL_REASON}         Motivo de cancelamento automático


*** Test Cases ***
Commands - Open table, select product, alter quantity and invoice with money
    [Documentation]    Verifica o fluxo de abertura de mesa, seleção de produto, alteração de quantidade e pagamento com dinheiro.
    [Tags]    @allure.label.severity:critical    regression    commands    invoice
    Commands - Complete Flow - Select Product Alter Quantity   1    ${TABLE_CLIENT}

Commands - Open table, select product Additionals and invoice with money
    [Documentation]    Verifica o fluxo de abertura de mesa, seleção de produto com adicional e pagamento com dinheiro.
    [Tags]    @allure.label.severity:critical    regression    commands    additionals
    Commands - Complete Flow - Select Product Additionals   1    ${TABLE_CLIENT}

Commands - Open table, select product not service and invoice with money
    [Documentation]    Verifica o fluxo de abertura de mesa, seleção de produto marcado pra nao contabilizar serviço e pagamento com dinheiro.
    [Tags]    @allure.label.severity:critical    regression    commands    not_selling
    Commands - Complete Flow - Select Product Not Service   1    ${TABLE_CLIENT}

Commands - Open table, select product not service and invoice with money
    [Documentation]    Verifica o fluxo de abertura de mesa, seleção de produto desativado e pagamento com dinheiro.
    [Tags]    @allure.label.severity:critical    regression    commands    not_selling
    Commands - Complete Flow - Select Product Disabled   2    ${TABLE_CLIENT}

Commands - Open table, select product not send to order and invoice with money
    [Documentation]    Verifica o fluxo de abertura de mesa, seleção de produto marcado como não enviar para a comanda e pagamento com dinheiro.
    [Tags]    @allure.label.severity:critical    regression    commands    not_selling
    Commands- Complete Flow - Select Product Not Send To Order   3    ${TABLE_CLIENT}

Commands - Open table, select product not selling and invoice with money
    [Documentation]    Verifica o fluxo de abertura de mesa, seleção de produto marcado como não vender e pagamento com dinheiro.
    [Tags]    @allure.label.severity:critical    regression    commands    not_selling
    Commands - Complete Flow - Select Product Not Selling   4    ${TABLE_CLIENT}

Commands - Open table, select product promotion and invoice with money
    [Documentation]    Verifica o fluxo de abertura de mesa, seleção de produto em promoção e pagamento com dinheiro.
    [Tags]    @allure.label.severity:critical    regression    commands    promotion
    Commands - Complete Flow - Select Product Promotion   5    ${TABLE_CLIENT}

Commands - Open table, print conference and invoice with money
    [Documentation]    Verifica o fluxo de abertura de mesa, impressão da conferência e pagamento com dinheiro.
    [Tags]    @allure.label.severity:critical    regression    commands    invoice
    Commands - Complete Flow - Print Conference    6    ${TABLE_CLIENT}

Commands - Open table and invoice with money
    [Documentation]    Verifica o fluxo de abertura de mesa, adição de itens, e pagamento com dinheiro.    
    [Tags]    @allure.label.severity:critical    regression    commands    invoice
    Commands - Complete Flow - Invoice With Money    7    ${TABLE_CLIENT}

Commands - Open table and invoice with Pix Off
    [Documentation]    Verifica o fluxo de abertura de mesa, adição de itens, e pagamento com Pix Off.
    [Tags]    @allure.label.severity:critical    regression    commands    invoice
    Commands - Complete Flow - Invoice With Pix Off    8    ${TABLE_CLIENT}

Commands - Open table, register advance with money and invoice with money
    [Documentation]    Verifica o fluxo de abertura de mesa, registro de adiantamento, e pagamento com a forma de pagamento dinheiro.
    [Tags]    @allure.label.severity:normal    regression    commands    advance
    Commands - Complete Flow - Advance With Money    9    ${TABLE_CLIENT}

Commands - Open table, register advance with money and invoice with pix off
    [Documentation]    Verifica o fluxo de abertura de mesa, registro de adiantamento, e pagamento com a forma de pagamento pix off.
    [Tags]    @allure.label.severity:normal    regression    commands    advance
    Commands - Complete Flow - Advance With Pix Off    10    ${TABLE_CLIENT}

Commands - Open table, split account and pay
    [Documentation]    Verifica o fluxo de abertura de mesa, divisão da conta e realização do pagamento.
    [Tags]    @allure.label.severity:normal    regression    commands    split_account
    Commands - Complete Flow - Split Account    11    ${TABLE_CLIENT}

Commands - Open table, change client and pay
    [Documentation]    Verifica o fluxo de abertura de mesa, alteração do cliente e realização do pagamento.
    [Tags]    @allure.label.severity:normal    regression    commands    change_client
    Commands - Complete Flow - Change Client    12    ${TABLE_CLIENT}

Commands - Open table, join accounts and pay
    [Documentation]    Verifica o fluxo de abertura de mesa, junção de contas e realização do pagamento.
    [Tags]    @allure.label.severity:normal    regression    commands    join_accounts
    Commands - Complete Flow - Join Accounts    13    14    ${TABLE_CLIENT}

Commands - Open table, cancel (reason)
    [Documentation]    Verifica o fluxo de abertura de mesa, cancela a mesa informando o motivo e confirma o cancelamento.
    [Tags]    @allure.label.severity:normal    regression    commands    cancel
    Commands - Complete Flow - Cancel Table    15    ${TABLE_CLIENT}    ${CANCEL_REASON}

Commands - Open table, cancel (no-reason)
    [Documentation]    Verifica o fluxo de abertura de mesa, cancela a mesa sem informar o motivo e confirma o cancelamento.
    [Tags]    @allure.label.severity:normal    regression    commands    cancel
    Commands - Complete Flow - Cancel Table no-reason    16    ${TABLE_CLIENT}

Commands - Open table, manage_service_charge and pay
    [Documentation]    Verifica o fluxo de abertura de mesa, gerencia taxas de serviço e realiza o pagamento.
    [Tags]    @allure.label.severity:normal    regression    commands    manage_service_charge
    Commands - Complete Flow - Manage Service Charge    17    ${TABLE_CLIENT}