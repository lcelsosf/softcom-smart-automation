*** Settings ***
Documentation       Fluxos de configuração do módulo Pdv — composição de page keywords.
...
...                 Nomenclatura: Pdv - Settings <Módulo>
...                 Dependências: pages abaixo + locators carregados via base_pdv.resource

Resource            ../pages/home_page.resource
Resource            ../pages/orders_page.resource
Resource            ../pages/checkout_page.resource
Resource            ../pages/settings_page.resource


*** Keywords ***
Pdv - Setup Printers
    [Documentation]    Configura impressão ao finalizar venda e acessa a impressora cadastrada.
    ...    Opções disponíveis: Imprimir, Perguntar ou Nenhuma Ação.
    [Arguments]    ${print_on_finish_option}
    Pdv - Home - Verify Visible
    Pdv - Home - Click Settings
    Pdv - Settings Click Printing
    Pdv - Printing Settings Select Print On Finish    ${print_on_finish_option}
    Pdv - Printing Settings Click Printer List
    Pdv - Printer List Modal Click Printer Icon Area
    Pdv - Printer List Modal Click Close
    Pdv - Settings Click Back
    Pdv - Settings Click Back
    Pdv - Home - Verify Visible

Pdv - Setup Payment Methods
    [Documentation]    Ativa as formas de pagamento Boleto Bancário, PIX e PIX OFF.
    Pdv - Home - Verify Visible
    Pdv - Home - Click Settings
    Pdv - Settings Click Payment Methods
    Pdv - Payment Settings Toggle Bank Slip
    Pdv - Payment Settings Toggle Pix
    Pdv - Payment Settings Toggle Pix Off
    Pdv - Settings Click Back
    Pdv - Settings Click Back
    Pdv - Home - Verify Visible

Pdv - Setup Active Fractional Units
    [Documentation]    Ativa a opção de quantidade fracionada nas configurações de pedidos.
    Pdv - Home - Verify Visible
    Pdv - Home - Click Settings
    Pdv - Settings Click Orders
    Pdv - Orders Settings Toggle Fractional Quantity
    Pdv - Settings Click Back
    Pdv - Settings Click Back
    Pdv - Home - Verify Visible

Pdv - Setup Active Price Tables
    [Documentation]    Ativa a opção de tabela de preço nas configurações do Smart PDV.
    Pdv - Home - Verify Visible
    Pdv - Home - Click Settings
    Pdv - Settings Click Smart Pdv
    Pdv - Smart Pdv Toggle Price Table
    Pdv - Settings Click Back
    Pdv - Settings Click Back
    Pdv - Home - Verify Visible

Pdv - Resolve Operation Mode Name
    [Documentation]    Converte aliases do modo de operação para o nome exibido no dropdown.
    [Arguments]    ${operation_mode}
    ${operation_mode_name}=    Set Variable    ${operation_mode}
    IF    '${operation_mode}' == 'Padrao' or '${operation_mode}' == 'Padrão'
        ${operation_mode_name}=    Set Variable    Padrão (Conferência Ativa)
    ELSE IF    '${operation_mode}' == 'Express'
        ${operation_mode_name}=    Set Variable    Express (Venda Rápida)
    ELSE IF    '${operation_mode}' == 'Mini PDV'
        ${operation_mode_name}=    Set Variable    Mini PDV
    END
    RETURN    ${operation_mode_name}

Pdv - Setup Active Operation Mode
    [Documentation]    Seleciona o modo de operação do Smart PDV.
    ...    Opções disponíveis: Padrao, Express ou Mini PDV.
    [Arguments]    ${operation_mode}
    ${operation_mode_name}=    Pdv - Resolve Operation Mode Name    ${operation_mode}
    Pdv - Home - Verify Visible
    Pdv - Home - Click Settings
    Pdv - Settings Click Smart Pdv
    Pdv - Smart Pdv Select Operation Mode    ${operation_mode_name}
    Pdv - Settings Click Back
    Pdv - Settings Click Back
    Pdv - Home - Verify Visible

Pdv - Setup Active Smart PDV Functions
    [Documentation]    Ativa funções do Smart PDV usadas nos fluxos de cliente, estoque e edição de preço.
    Pdv - Home - Verify Visible
    Pdv - Home - Click Settings
    Pdv - Settings Click Smart Pdv
#    Pdv - Smart Pdv Toggle Request Client
    Pdv - Smart Pdv Toggle Show Stock
    Pdv - Smart Pdv Toggle Edit Item Price
    Pdv - Settings Click Back
    Pdv - Settings Click Back
    Pdv - Home - Verify Visible

Pdv - Setup Active/Deactive NFCe
    [Documentation]    Alterna a opção Habilitar NFC-e nas configurações fiscais.
    Pdv - Home - Verify Visible
    Pdv - Home - Click Settings
    Pdv - Settings Click Fiscal
    Pdv - Fiscal Settings Toggle Enable Nfce
    Pdv - Settings Click Back
    Pdv - Settings Click Back
    Pdv - Home - Verify Visible

Pdv - Setup Active/Deactive Discount Item
    [Documentation]    Alterna a opção Desconto/Acréscimo por item nas configurações do Smart PDV.
    Pdv - Home - Verify Visible
    Pdv - Home - Click Settings
    Pdv - Settings Click Smart Pdv
    Pdv - Smart Pdv Toggle Discount Per Item
    Pdv - Settings Click Back
    Pdv - Settings Click Back
    Pdv - Home - Verify Visible

Pdv - Setup Active/Deactive Payment Method
    [Documentation]    Alterna a opção Obrigar pagamentos na venda nas configurações do Smart PDV.
    Pdv - Home - Verify Visible
    Pdv - Home - Click Settings
    Pdv - Settings Click Smart Pdv
    Pdv - Smart Pdv Toggle Require Payment
    Pdv - Settings Click Back
    Pdv - Settings Click Back
    Pdv - Home - Verify Visible

Pdv - Setup Active/Deactive Ticket
    [Documentation]    Seleciona a opção de ticket ao finalizar e alterna a reimpressão de ticket.
    ...    Opções disponíveis: Imprimir, Perguntar, Nenhuma Ação.
    [Arguments]    ${ticket_on_finish_option}
    Pdv - Home - Verify Visible
    Pdv - Home - Click Settings
    Pdv - Settings Click Ticket
    Pdv - Ticket Settings Select Ticket On Finish    ${ticket_on_finish_option}
    Pdv - Ticket Settings Toggle Allow Reprint
    Pdv - Settings Click Back
    Pdv - Settings Click Back
    Pdv - Home - Verify Visible
