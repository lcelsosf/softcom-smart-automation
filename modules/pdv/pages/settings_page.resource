*** Settings ***
Documentation       Page object da tela Configurações Gerais — módulo PDV.


*** Keywords ***
Pdv - Settings Click Back
    [Documentation]    Clica no botão Voltar da top bar.
    Wait Visible And Click Element With Retry    ${pdv_settings.btn_back}

Pdv - Settings Click Smart Pdv
    [Documentation]    Clica na opção "Smart PDV" — navega para o fluxo do Smart PDV.
    Wait Visible And Click Element With Retry    ${pdv_settings.option_smart_pdv}

Pdv - Settings Click Orders
    [Documentation]    Clica na opção "Pedidos" — configurações de pedidos.
    Wait Visible And Click Element With Retry    ${pdv_settings.option_orders}

Pdv - Settings Click Printing
    [Documentation]    Clica na opção "Impressões" — configurações de impressão.
    Wait Visible And Click Element With Retry    ${pdv_settings.option_printing}

Pdv - Settings Click Payment Methods
    [Documentation]    Clica na opção "Formas de Pagamento".
    Wait Visible And Click Element With Retry    ${pdv_settings.option_payment_methods}

Pdv - Settings Click Acquirer
    [Documentation]    Clica na opção "Adquirente" — configuração específica da adquirente.
    Wait Visible And Click Element With Retry    ${pdv_settings.option_acquirer}

Pdv - Settings Click Softcompay
    [Documentation]    Clica na opção "SoftcomPay" — PIX Softcom.
    Wait Visible And Click Element With Retry    ${pdv_settings.option_softcompay}

Pdv - Settings Click Fiscal
    [Documentation]    Clica na opção "Fiscal" — emissão NFC-e/NF-e.
    Wait Visible And Click Element With Retry    ${pdv_settings.option_fiscal}

Pdv - Settings Click Ticket
    [Documentation]    Clica na opção "Emissão de Ticket" — ticket de retirada.
    Swipe Until Visible And Click Element    ${pdv_settings.option_ticket}

Pdv - Settings Click Device
    [Documentation]    Clica na opção "Dispositivo" — importar/exportar configurações.
    Wait Visible And Click Element With Retry    ${pdv_settings.option_device}

Pdv - Settings Click Others
    [Documentation]    Clica na opção "Outros" — configurações gerais.
    Wait Visible And Click Element With Retry    ${pdv_settings.option_others}

Pdv - Settings Click Option By Name
    [Documentation]    Clica em qualquer opção do menu pelo título exibido.
    ...    Use para opções além das mapeadas individualmente.
    ...
    ...    Exemplo:
    ...    Pdv - Settings Click Option By Name    Fiscal
    [Arguments]    ${option_name}
    Wait Visible And Click Element With Retry
    ...    xpath=//android.view.View[@clickable='true' and .//android.widget.TextView[@text='${option_name}']]

# =============================================================================
# Configurações Gerais - Smart PDV
# =============================================================================

Pdv - Smart Pdv Select Operation Mode
    [Documentation]    Abre o seletor de modo e escolhe a opção pelo nome.
    ...
    ...    Exemplo:
    ...    Pdv - Smart Pdv Select Operation Mode    Padrão (Conferência Ativa)
    [Arguments]    ${mode_name}
    Wait Visible And Click Element With Retry    ${smart_pdv_settings.operation_mode_open_menu}
    Wait Visible And Click Element With Retry
    ...    xpath=//android.view.View[@clickable='true' and .//android.widget.TextView[@text='${mode_name}']]

Pdv - Smart Pdv Toggle Request Client
    [Documentation]    Alterna "Solicitar cliente ao iniciar pedido".
    Wait Visible And Click Element With Retry    ${smart_pdv_settings.toggle_request_client}

Pdv - Smart Pdv Toggle Show Stock
    [Documentation]    Alterna "Exibir estoque do produto".
    Wait Visible And Click Element With Retry    ${smart_pdv_settings.toggle_show_stock}

Pdv - Smart Pdv Toggle Discount Per Item
    [Documentation]    Alterna "Desconto/Acréscimo por item".
    Wait Visible And Click Element With Retry    ${smart_pdv_settings.toggle_discount_per_item}

Pdv - Smart Pdv Toggle Require Payment
    [Documentation]    Alterna "Obrigar pagamentos na venda".
    Wait Visible And Click Element With Retry    ${smart_pdv_settings.toggle_require_payment}

Pdv - Smart Pdv Toggle Price Table
    [Documentation]    Alterna "Tabela de Preço".
    Wait Visible And Click Element With Retry    ${smart_pdv_settings.toggle_price_table}

Pdv - Smart Pdv Toggle Edit Item Price
    [Documentation]    Alterna "Alterar preço do item".
    Swipe Until Visible And Click Element    ${smart_pdv_settings.toggle_edit_item_price}

Pdv - Smart Pdv Toggle Option By Name
    [Documentation]    Alterna qualquer toggle pelo título exibido.
    ...    Use para opções além das mapeadas individualmente.
    ...
    ...    Exemplo:
    ...    Pdv - Smart Pdv Toggle Option By Name    Tabela de Preço
    [Arguments]    ${option_name}
    Wait Visible And Click Element With Retry
    ...    xpath=//*[@text='${option_name}']/following-sibling::android.view.View[1]

# =============================================================================
# Configurações Gerais - Pedidos
# =============================================================================

Pdv - Orders Settings Toggle Finish After Payment
    [Documentation]    Alterna "Finalizar pedido após pagamento".
    Wait Visible And Click Element With Retry    ${orders_settings.toggle_finish_after_payment}

Pdv - Orders Settings Toggle Send Order To Server
    [Documentation]    Alterna "Enviar pedido ao servidor ao finalizar".
    Wait Visible And Click Element With Retry    ${orders_settings.toggle_send_order_to_server}

Pdv - Orders Settings Toggle Fractional Quantity
    [Documentation]    Alterna "Ativar quantidade fracionada".
    Wait Visible And Click Element With Retry    ${orders_settings.toggle_fractional_quantity}

Pdv - Orders Settings Toggle Credit Limit Block
    [Documentation]    Alterna "Ativar bloqueio por limite de crédito".
    Wait Visible And Click Element With Retry    ${orders_settings.toggle_credit_limit_block}

Pdv - Orders Settings Toggle Option By Name
    [Documentation]    Alterna qualquer toggle da seção Pedidos pelo título exibido.
    ...
    ...    Exemplo:
    ...    Pdv - Orders Settings Toggle Option By Name    Ativar quantidade fracionada
    [Arguments]    ${option_name}
    Wait Visible And Click Element With Retry
    ...    xpath=//*[@text='${option_name}']/following-sibling::android.view.View[1]

Pdv - Orders Settings Open Product Code Size Menu
    [Documentation]    Clica no campo para abrir o dropdown de tamanho do código.
    Wait Visible And Click Element With Retry    ${orders_settings.product_code_size_input}

Pdv - Orders Settings Select Product Code Size
    [Documentation]    Abre o dropdown e seleciona a opção pelo nome.
    ...    Locator genérico — funciona para qualquer opção da lista.
    ...
    ...    Opções disponíveis: 4 dígitos, 5 dígitos, 6 dígitos
    ...
    ...    Exemplo:
    ...    Pdv - Orders Settings Select Product Code Size    5 dígitos
    [Arguments]    ${option_name}
    Pdv - Orders Settings Open Product Code Size Menu
    Wait Visible And Click Element With Retry
    ...    xpath=//android.view.View[@clickable='true' and .//android.widget.TextView[@text='${option_name}']]

Pdv - Orders Settings Open Barcode Reading Menu
    [Documentation]    Clica no campo para abrir o dropdown de leitura do código de barras.
    Wait Visible And Click Element With Retry    ${orders_settings.barcode_reading_input}

Pdv - Orders Settings Select Barcode Reading
    [Documentation]    Abre o dropdown e seleciona a opção pelo nome.
    ...    Locator genérico — funciona para qualquer opção da lista.
    ...
    ...    Opções disponíveis: Preço, Peso
    ...
    ...    Exemplo:
    ...    Pdv - Orders Settings Select Barcode Reading    Peso
    [Arguments]    ${option_name}
    Pdv - Orders Settings Open Barcode Reading Menu
    Wait Visible And Click Element With Retry
    ...    xpath=//android.view.View[@clickable='true' and .//android.widget.TextView[@text='${option_name}']]

# =============================================================================
# Configurações Gerais - Impressoras
# =============================================================================

Pdv - Printing Settings Open Print On Finish Menu
    [Documentation]    Clica no campo para abrir o dropdown de impressão ao finalizar.
    Wait Visible And Click Element With Retry    ${printing_settings.print_on_finish_open_menu}

Pdv - Printing Settings Select Print On Finish
    [Documentation]    Abre o dropdown e seleciona a opção pelo nome.
    ...    Locator genérico — funciona para qualquer opção da lista.
    ...
    ...    Opções disponíveis: Nenhuma Ação, Imprimir, Perguntar
    ...
    ...    Exemplo:
    ...    Pdv - Printing Settings Select Print On Finish    Perguntar
    [Arguments]    ${option_name}
    Pdv - Printing Settings Open Print On Finish Menu
    Wait Visible And Click Element With Retry
    ...    xpath=//android.view.View[@clickable='true' and .//android.widget.TextView[@text='${option_name}']]

Pdv - Printing Settings Toggle Print Header
    [Documentation]    Alterna "Exibir cabeçalho na via do pedido".
    Wait Visible And Click Element With Retry    ${printing_settings.toggle_print_header}

Pdv - Printing Settings Toggle Group Kitchen Print
    [Documentation]    Alterna "Agrupar impressão da via da cozinha".
    Wait Visible And Click Element With Retry    ${printing_settings.toggle_group_kitchen_print}

Pdv - Printing Settings Toggle Option By Name
    [Documentation]    Alterna qualquer toggle pelo título exibido.
    ...
    ...    Exemplo:
    ...    Pdv - Printing Settings Toggle Option By Name    Exibir cabeçalho na via do pedido
    [Arguments]    ${option_name}
    Wait Visible And Click Element With Retry
    ...    xpath=//android.view.View[.//android.widget.TextView[@text='${option_name}']]

Pdv - Printing Settings Click Printer List
    [Documentation]    Clica em "Lista de Impressoras" — abre o modal de impressoras.
    Wait Visible And Click Element With Retry    ${printing_settings.btn_open_printer_list}

Pdv - Printer List Modal Click Printer Icon Area
    [Documentation]    Clica na área do ícone/logo para definir a impressora cadastrada como padrão.
    Wait Visible And Click Element With Retry    ${printing_settings.first_printer_icon_area}

Pdv - Printer List Modal Click Close
    [Documentation]    Fecha a planilha/modal de lista de impressoras.
    Wait Visible And Click Element With Retry    ${printing_settings.btn_close_printer_list}

# =============================================================================
# Configurações Gerais - Formas de Pagamento
# =============================================================================

Pdv - Payment Settings Toggle Method By Name
    [Documentation]    Alterna o switch de um método de pagamento pelo nome exibido.
    ...    Locator genérico — funciona para qualquer método da lista,
    ...    inclusive novos métodos adicionados futuramente.
    ...
    ...    Exemplo:
    ...    Pdv - Payment Settings Toggle Method By Name    PIX
    [Arguments]    ${method_name}
    Wait Visible And Click Element With Retry
    ...    xpath=//*[@text='${method_name}']/following-sibling::android.view.View[1]

Pdv - Payment Settings Toggle Voucher
    [Documentation]    Alterna o switch do método "Voucher".
    Wait Visible And Click Element With Retry    ${payment_settings.method_switch_voucher}

Pdv - Payment Settings Toggle Money
    [Documentation]    Alterna o switch do método "Dinheiro".
    Wait Visible And Click Element With Retry    ${payment_settings.method_switch_money}

Pdv - Payment Settings Toggle Check
    [Documentation]    Alterna o switch do método "Cheque".
    Wait Visible And Click Element With Retry    ${payment_settings.method_switch_check}

Pdv - Payment Settings Toggle Credit Card
    [Documentation]    Alterna o switch do método "Cartão de Crédito".
    Wait Visible And Click Element With Retry    ${payment_settings.method_switch_credit_card}

Pdv - Payment Settings Toggle Debit Card
    [Documentation]    Alterna o switch do método "Cartão de Débito".
    Wait Visible And Click Element With Retry    ${payment_settings.method_switch_debit_card}

Pdv - Payment Settings Toggle Store Credit
    [Documentation]    Alterna o switch do método "Crédito Loja".
    Wait Visible And Click Element With Retry    ${payment_settings.method_switch_store_credit}

Pdv - Payment Settings Toggle Bank Slip
    [Documentation]    Alterna o switch do método "Boleto Bancário".
    Swipe Until Visible And Click Element    ${payment_settings.method_switch_bank_slip}    up

Pdv - Payment Settings Toggle Pix
    [Documentation]    Alterna o switch do método "PIX".
    Swipe Until Visible And Click Element    ${payment_settings.method_switch_pix}    up

Pdv - Payment Settings Toggle Pix Off
    [Documentation]    Alterna o switch do método "PIX OFF".
    Swipe Until Visible And Click Element    ${payment_settings.method_switch_pix_off}    up

Pdv - Payment Settings Toggle Others
    [Documentation]    Alterna o switch do método "Outros".
    Wait Visible And Click Element With Retry    ${payment_settings.method_switch_others}

Pdv - Payment Settings Toggle Pos
    [Documentation]    Alterna o switch do método "POS".
    Wait Visible And Click Element With Retry    ${payment_settings.method_switch_pos}

# =============================================================================
# Configurações Gerais - Fiscal
# =============================================================================

Pdv - Fiscal Settings Toggle Enable Nfce
    [Documentation]    Alterna o toggle "Habilitar NFC-e".
    Wait Visible And Click Element With Retry    ${fiscal_settings.toggle_enable_nfce}

Pdv - Fiscal Settings Toggle Enable Nfe
    [Documentation]    Alterna o toggle "Habilitar NF-e".
    Wait Visible And Click Element With Retry    ${fiscal_settings.toggle_enable_nfe}

##########################################################################
# Tela de Configurações Gerais - Ticket Retirada
##########################################################################

Pdv - Ticket Settings Open Ticket On Finish Menu
    [Documentation]    Clica no campo para abrir o dropdown de ticket ao finalizar.
    Wait Visible And Click Element With Retry    ${ticket_settings.ticket_on_finish_open_menu}

Pdv - Ticket Settings Select Ticket On Finish
    [Documentation]    Abre o dropdown e seleciona a opção pelo nome.
    ...    Locator genérico — funciona para qualquer opção da lista.
    ...
    ...    Opções disponíveis: Nenhuma Ação, Imprimir, Perguntar
    ...
    ...    Exemplo:
    ...    Pdv - Ticket Settings Select Ticket On Finish    Imprimir
    [Arguments]    ${option_name}
    Pdv - Ticket Settings Open Ticket On Finish Menu
    Wait Visible And Click Element With Retry
    ...    xpath=//android.view.View[@clickable='true' and .//android.widget.TextView[@text='${option_name}']]

Pdv - Ticket Settings Toggle Allow Reprint
    [Documentation]    Alterna o toggle "Permitir reimpressão de ticket".
    Wait Visible And Click Element With Retry    ${ticket_settings.toggle_allow_reprint}
