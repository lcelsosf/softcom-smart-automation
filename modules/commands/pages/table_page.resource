*** Settings ***
Documentation    Page object da tela Mesa (Comanda) — módulo Commands.

*** Keywords ***
Commands - Table Screen Click Menu
    [Documentation]    Clica no botão Menu — abre o drawer específico da mesa.
    Wait Visible And Click Element    ${table_screen.btn_menu}

Commands - Table Screen Click Print
    [Documentation]    Clica no botão Imprimir.
    Wait Visible And Click Element    ${table_screen.btn_print}

# =============================================================================
# NAVEGAÇÃO ENTRE TABS
# =============================================================================

Commands - Click Tab Products
    [Documentation]    Seleciona a tab "Produtos".
    Wait Visible And Click Element    ${table_screen.tab_products}

Commands - Click Tab Conference
    [Documentation]    Seleciona a tab "Conferência".
    Wait Visible And Click Element    ${table_screen.tab_conference}

Commands - Click Tab Launched
    [Documentation]    Seleciona a tab "Lançados".
    Wait Visible And Click Element    ${table_screen.tab_launched}

# =============================================================================
# ABA PRODUTOS
# =============================================================================

Commands - Products Search
    [Documentation]    Digita um termo no campo de busca de produtos da mesa.
    [Arguments]    ${search_term}
    Wait Visible And Click Element       ${table_screen.products_search_input}
    Wait Visible And Input Text    ${table_screen.products_search_input}    ${search_term}

Commands - Click Products Filter
    [Documentation]    Clica no botão Filtrar — abre o dialog de filtro de grupos.
    Wait Visible And Click Element    ${table_screen.btn_products_filter}

Commands - Click Product By Name
    [Documentation]    Clica em um produto da lista pelo nome exibido.
    ...    Navega para a tela de Adicionar Produto.
    [Arguments]    ${product_name}
    Wait Visible And Click Element
    ...    xpath=//*[@resource-id='ComandaMesaProdutosContentLazyColumn_1']//*[@text='${product_name}']/ancestor::android.view.View[@clickable='true'][1]

# =============================================================================
# ABA LANÇADOS
# =============================================================================

Commands - Launched Item Should Be Visible
    [Documentation]    Verifica que um item está listado na aba Lançados.
    [Arguments]    ${product_name}
    Wait Until Element Is Visible
    ...    xpath=//*[contains(@resource-id,'ComandaMesaLancadoItemText_0') and @text='${product_name}']

Commands - Click Edit Launched Item By Name
    [Documentation]    Clica no ícone "Editar item" do item lançado pelo nome.
    [Arguments]    ${product_name}
    Wait Visible And Click Element
    ...    xpath=//*[@text='${product_name}']/following-sibling::*[@content-desc='Editar item']

Commands - Click Remove Launched Item By Name
    [Documentation]    Clica no ícone "Remover item" do item lançado pelo nome.
    ...    Pode abrir o dialog de confirmação de cancelamento.
    [Arguments]    ${product_name}
    Wait Visible And Click Element
    ...    xpath=//*[@text='${product_name}']/following-sibling::*[@content-desc='Remover item']

Commands - Get Launched Item Quantity By Name
    [Documentation]    Retorna a quantidade do item lançado pelo nome (ex: '1x').
    [Arguments]    ${product_name}
    ${qty}=    Get Text
    ...    xpath=//*[@text='${product_name}']/following::android.widget.TextView[contains(@resource-id,'ComandaMesaLancadoItemText_1')][1]
    RETURN    ${qty}

Commands - Get Launched Item Value By Name
    [Documentation]    Retorna o valor do item lançado pelo nome.
    [Arguments]    ${product_name}
    ${value}=    Get Text
    ...    xpath=//*[@text='${product_name}']/following::android.widget.TextView[contains(@resource-id,'ComandaMesaLancadoItemText_3')][1]
    RETURN    ${value}

# =============================================================================
# RESUMO FINANCEIRO
# =============================================================================

Commands - Get Subtotal
    [Documentation]    Retorna o valor do Sub-Total exibido no resumo.
    ${value}=    Get Text    ${table_screen.subtotal_value}
    RETURN    ${value}

Commands - Get Discount
    [Documentation]    Retorna o valor de Descontos exibido no resumo.
    ${value}=    Get Text    ${table_screen.discount_value}
    RETURN    ${value}

Commands - Get Service Fee
    [Documentation]    Retorna o valor de Serviço exibido no resumo.
    ${value}=    Get Text    ${table_screen.service_value}
    RETURN    ${value}

Commands - Get Total
    [Documentation]    Retorna o valor Total exibido no resumo.
    ${value}=    Get Text    ${table_screen.total_value}
    RETURN    ${value}

Commands - Get Paid Value
    [Documentation]    Retorna o Valor Pago exibido no resumo.
    ${value}=    Get Text    ${table_screen.paid_value}
    RETURN    ${value}

Commands - Get Remaining Value
    [Documentation]    Retorna o Valor Restante exibido no resumo.
    ${value}=    Get Text    ${table_screen.remaining_value}
    RETURN    ${value}

# =============================================================================
# FOOTER — AÇÕES
# =============================================================================

Commands - Click Cancel
    [Documentation]    Clica em "Cancelar" no footer.
    Wait Visible And Click Element    ${table_screen.btn_cancel}

Commands - Click Advance
    [Documentation]    Clica em "Avançar" — disponível nas tabs Produtos/Conferência.
    Wait Visible And Click Element    ${table_screen.btn_advance}

Commands - Click Receive Order
    [Documentation]    Clica em "Receber Pedido" — disponível na tab Lançados.
    Wait Visible And Click Element    ${table_screen.btn_receive_order}

# =============================================================================
# DIALOG — CONFIRMAR SOLICITAÇÃO DE CONFERÊNCIA
# =============================================================================

Commands - Conference Dialog Should Be Visible
    [Documentation]    Verifica que o dialog de confirmação de conferência está aberto.
    Wait Until Element Is Visible    ${conference_dialog.title}

Commands - Confirm Conference
    [Documentation]    Clica em "Sim" — confirma a solicitação de conferência.
    Wait Visible And Click Element    ${conference_dialog.btn_yes}

Commands - Cancel Conference
    [Documentation]    Clica em "Não" — cancela a solicitação de conferência.
    Wait Visible And Click Element    ${conference_dialog.btn_no}

# =============================================================================
# DIALOG — CONFIRMAR CANCELAMENTO DE ITEM
# =============================================================================

Commands - Cancel Item Dialog Should Be Visible
    [Documentation]    Verifica que o dialog de confirmação de cancelamento está aberto.
    Wait Until Element Is Visible    ${cancel_item_dialog.title}

Commands - Confirm Cancel Item
    [Documentation]    Clica em "Sim" — confirma o cancelamento do item.
    Wait Visible And Click Element    ${cancel_item_dialog.btn_yes}

Commands - Cancel Cancel Item
    [Documentation]    Clica em "Não" — mantém o item, cancela a ação de remoção.
    Wait Visible And Click Element    ${cancel_item_dialog.btn_no}

# =============================================================================
# DIALOG — FILTRO DE GRUPOS
# =============================================================================

Commands - Group Filter Dialog Should Be Visible
    [Documentation]    Verifica que o dialog de filtro de grupos está aberto.
    Wait Until Element Is Visible    ${group_filter_dialog.title}

Commands - Group Filter Search
    [Documentation]    Digita um termo no campo de busca de grupos.
    [Arguments]    ${search_term}
    Wait Visible And Click Element       ${group_filter_dialog.search_input}
    Wait Visible And Input Text Pause    ${group_filter_dialog.search_input}    ${search_term}

Commands - Click Group By Name
    [Documentation]    Clica em um grupo pelo nome para marcar/desmarcar exibição.
    [Arguments]    ${group_name}
    Wait Visible And Click Element
    ...    xpath=//*[@resource-id='ComandaMesaProdutosContentFilterDialogLazyColumn_0']//*[@text='${group_name}']/ancestor::android.view.View[@clickable='true'][1]

Commands - Click Group Filter Cancel
    [Documentation]    Clica em "Cancelar" — fecha o dialog sem aplicar o filtro.
    Wait Visible And Click Element    ${group_filter_dialog.btn_cancel}

Commands - Click Group Filter Apply
    [Documentation]    Clica em "Confirmar" — aplica o filtro de grupos selecionado.
    Wait Visible And Click Element    ${group_filter_dialog.btn_apply}

# =============================================================================
# TELA — ADICIONAR PRODUTO
# =============================================================================

Commands - Add Product Click Back
    [Documentation]    Clica no botão Voltar da tela Adicionar Produto.
    Wait Visible And Click Element    ${add_product_screen.btn_back}

Commands - Add Product Fill Observations
    [Documentation]    Preenche o campo de observações do produto.
    [Arguments]    ${observations}
    Wait Visible And Click Element    ${add_product_screen.observations_input}
    Clear Text                        ${add_product_screen.observations_input}
    Input Text                        ${add_product_screen.observations_input}    ${observations}
    Close Keyboard

Commands - Add Product Click Quantity Add
    [Documentation]    Clica no botão + para incrementar a quantidade.
    Wait Visible And Click Element    ${add_product_screen.quantity_add}

Commands - Add Product Click Quantity Sub
    [Documentation]    Clica no botão - para decrementar a quantidade.
    Wait Visible And Click Element    ${add_product_screen.quantity_sub}

Commands - Add Product Fill Quantity
    [Documentation]    Preenche a quantidade diretamente no input.
    [Arguments]    ${quantity}
    Wait Visible And Click Element    ${add_product_screen.quantity_input}
    Clear Text                        ${add_product_screen.quantity_input}
    Input Text                        ${add_product_screen.quantity_input}    ${quantity}
    Close Keyboard

Commands - Add Product Click Add
    [Documentation]    Clica em "Adicionar" — adiciona o produto à mesa.
    Wait Visible And Click Element    ${add_product_screen.btn_add_product}

# =============================================================================
# DRAWER MENU — ESPECÍFICO DA MESA
# =============================================================================

Commands - Table Drawer Click Back
    [Documentation]    Clica em "Voltar" — retorna ao Painel de Mesas.
    Wait Visible And Click Element    ${table_drawer_menu.option_back}

Commands - Table Drawer Click Invoice
    [Documentation]    Clica em "Faturar" — inicia o faturamento da mesa.
    Wait Visible And Click Element    ${table_drawer_menu.option_invoice}

Commands - Table Drawer Click Advance Payment
    [Documentation]    Clica em "Adiantamento".
    Wait Visible And Click Element    ${table_drawer_menu.option_advance}

Commands - Table Drawer Click Split Account
    [Documentation]    Clica em "Dividir conta".
    Wait Visible And Click Element    ${table_drawer_menu.option_split_account}

Commands - Table Drawer Click Change Client
    [Documentation]    Clica em "Alterar cliente".
    Wait Visible And Click Element    ${table_drawer_menu.option_change_client}

Commands - Table Drawer Click Join Accounts
    [Documentation]    Clica em "Juntar Contas".
    Wait Visible And Click Element    ${table_drawer_menu.option_join_accounts}

Commands - Table Drawer Click Transfer Items
    [Documentation]    Clica em "Transferir itens".
    Wait Visible And Click Element    ${table_drawer_menu.option_transfer_items}

Commands - Table Drawer Click Cancel Table
    [Documentation]    Clica em "Cancelar Mesa".
    Wait Visible And Click Element    ${table_drawer_menu.option_cancel_table}

Commands - Table Drawer Click Service Fee
    [Documentation]    Clica em "Gerenciar taxa de serviço".
    Wait Visible And Click Element    ${table_drawer_menu.option_service_fee}

Commands - Table Drawer Click Option By Name
    [Documentation]    Clica em qualquer opção do drawer pelo content-desc do ícone.
    ...
    ...    Exemplo:
    ...    Commands - Table Drawer Click Option By Name    Faturar
    [Arguments]    ${option_name}
    Wait Visible And Click Element    xpath=//*[@content-desc='${option_name}']