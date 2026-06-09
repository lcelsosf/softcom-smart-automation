*** Settings ***
Documentation    Ações atômicas — Tela de pedidos e carrinho do módulo PDV.
Resource    ../../../resources/helpers/common_keywords.resource


*** Keywords ***
Pdv - Orders - Click Back
    [Documentation]    Botão voltar.
    Wait Visible And Click Element    ${orders.btn_back}

Pdv - Orders - Click Cancel Order New
    [Documentation]    Botão Cancelar (texto clicável no canto direito).
    Wait Visible And Click Element    ${orders.btn_cancel}

Pdv - Orders - Click Search Input
    [Documentation]    Clica no campo de busca de produto.
    Wait Visible And Click Element    ${orders.search_input}

Pdv - Orders - Type Product Name
    [Documentation]    Digita o nome do produto no campo de busca.
    [Arguments]    ${product_name}
    Input Text    ${orders.search_input}    ${product_name}
    Close Keyboard

Pdv - Orders - Search Item
    [Documentation]    Campo de busca de produto — EditText dentro do container de busca.
    [Arguments]    ${text}
    Wait Visible And Input Text    ${orders.search_input}    ${text}
    Close Keyboard

Pdv - Orders - Click Product By Name
    [Documentation]    Produto retornado na busca, selecionado pelo nome.
    [Arguments]    ${product_name}
    ${locator}=    Replace String    ${orders.product_by_name}    PRODUCT_NAME    ${product_name}
    Wait Visible And Click Element    ${locator}

Pdv - Orders - Click Clear Search
    [Documentation]    Limpa o campo de pesquisa de produto.
    Wait Visible And Click Element    ${orders.clear_search}

Pdv - Orders - Click Filter All
    [Documentation]    Filtro "Todos".
    Wait Visible And Click Element    ${orders.filter_all}

Pdv - Orders - Click Conference
    [Documentation]    Botão "Conferir pedido" — habilitado apenas quando há itens no pedido.
    Wait Visible And Click Element    ${orders.btn_checkout}

Pdv - Orders - Click Quantity Field
    [Documentation]    Input de quantidade — EditText dentro do container View entre os botões.
    Wait Visible And Click Element    ${quantity_modal.quantity_input}

Pdv - Orders - Input Quantity
    [Documentation]    Input de quantidade — EditText dentro do container View entre os botões.
    [Arguments]    ${text}
    Wait Visible And Input Text    ${quantity_modal.quantity_input}    ${text}
    Close Keyboard

Pdv - Orders - Click Quantity Remove
    [Documentation]    Botão - (diminuir quantidade).
    Wait Visible And Click Element    ${quantity_modal.quantity_sub}

Pdv - Orders - Click Quantity Add
    [Documentation]    Botão + (aumentar quantidade).
    Wait Visible And Click Element    ${quantity_modal.quantity_add}

Pdv - Orders - Click Remove Item
    [Documentation]    Botão "Remover item" — remove o produto do pedido.
    Wait Visible And Click Element    ${quantity_modal.btn_remove_item}

Pdv - Orders - Click Quantity Confirm
    [Documentation]    Botão "Confirmar" — confirma a quantidade e fecha o modal.
    Wait Visible And Click Element    ${quantity_modal.btn_confirm}

Pdv - Orders - Verify Remove Item Dialog
    [Documentation]    Mensagem de confirmação — usado para verificar que o dialog abriu.
    Wait Until Element Is Visible    ${order_remove_dialog.confirm_message}

Pdv - Orders - Click Remove Item Cancel
    [Documentation]    Botão "Não" — cancela a remoção e volta ao modal de quantidade.
    Wait Visible And Click Element    ${order_remove_dialog.btn_no}

Pdv - Orders - Click Remove Item Confirm
    [Documentation]    Botão "Sim" — confirma a remoção do item do pedido.
    Wait Visible And Click Element    ${order_remove_dialog.btn_yes}
    Wait For Element To Disappear    ${order_remove_dialog.confirm_message}

Pdv - Orders - Verify Cancel Dialog
    [Documentation]    Mensagem de confirmação — usado para verificar que o dialog abriu.
    Wait Until Element Is Visible    ${order_cancel_dialog.confirm_message}

Pdv - Orders - Click Cancel Cancel
    [Documentation]    Botão "Não" — cancela o cancelamento e volta ao modal de quantidade.
    Wait Visible And Click Element    ${order_cancel_dialog.btn_no}

Pdv - Orders - Click Cancel Confirm
    [Documentation]    Botão "Sim" — confirma o cancelamento do pedido.
    Wait Visible And Click Element    ${order_cancel_dialog.btn_yes}

Pdv - Orders - Click Cart Back
    [Documentation]    Botão Voltar.
    Wait Visible And Click Element    ${cart.btn_back}

Pdv - Orders - Click Cancel Order Cart
    [Documentation]    Botão Cancelar (canto direito).
    Wait Visible And Click Element    ${cart.btn_cancel}

Pdv - Orders - Click Edit Client
    [Documentation]    Ícone/botão de editar cliente.
    Wait Visible And Click Element    ${cart.btn_edit_client}

Pdv - Orders - Click Remove Item Icon
    [Documentation]    Botão remover item (X) — ícone "Remover" no canto do card.
    Wait Visible And Click Element    ${cart.item_btn_remove}

Pdv - Orders - Click Cart Item Sub
    [Documentation]    Botão - (decrementar quantidade do item no carrinho).
    Wait Visible And Click Element    ${cart.item_btn_sub}

Pdv - Orders - Click Cart Item Quantity
    [Documentation]    Campo de quantidade do item — clicável, abre modal de edição.
    Wait Visible And Click Element    ${cart.item_quantity}

Pdv - Orders - Click Cart Item Add
    [Documentation]    Botão + (incrementar quantidade do item no carrinho).
    Wait Visible And Click Element    ${cart.item_btn_add}

Pdv - Orders - Click Remove Item Icon By Name
    [Documentation]    Botão remover item (X) no card do produto informado.
    [Arguments]    ${product_name}
    ${locator}=    Replace String    ${cart.item_btn_remove_by_name}    PRODUCT_NAME    ${product_name}
    Wait Visible And Click Element    ${locator}

Pdv - Orders - Click Cart Item Sub By Name
    [Documentation]    Botão - (decrementar quantidade) no card do produto informado.
    [Arguments]    ${product_name}
    ${locator}=    Replace String    ${cart.item_btn_sub_by_name}    PRODUCT_NAME    ${product_name}
    Wait Visible And Click Element    ${locator}

Pdv - Orders - Click Cart Item Quantity By Name
    [Documentation]    Campo de quantidade no card do produto informado.
    [Arguments]    ${product_name}
    ${locator}=    Replace String    ${cart.item_quantity_by_name}    PRODUCT_NAME    ${product_name}
    Wait Visible And Click Element    ${locator}

Pdv - Orders - Click Cart Item Add By Name
    [Documentation]    Botão + (incrementar quantidade) no card do produto informado.
    [Arguments]    ${product_name}
    ${locator}=    Replace String    ${cart.item_btn_add_by_name}    PRODUCT_NAME    ${product_name}
    Wait Visible And Click Element    ${locator}

Pdv - Orders - Click Discount-Sum
    [Documentation]    Botão "Desconto/Acréscimo".
    Wait Visible And Click Element    ${cart.btn_discount}

Pdv - Orders - Click Cart
    [Documentation]    Botão "Adicionar itens" — volta para tela de produtos.
    Wait Visible And Click Element    ${cart.btn_add_items}

Pdv - Orders - Click Finalize Order
    [Documentation]    Botão "Finalizar Pedido" — avança para pagamento.
    Wait Visible And Click Element    ${cart.btn_finish_order}

Pdv - Orders - Input Client Modal Client
    [Documentation]    Abre o spinner de cliente, limpa o campo de pesquisa e pesquisa pelo cliente informado.
    [Arguments]    ${text}
    Wait Visible And Click Element    ${client_modal.client_spinner}
    Wait Until Element Is Visible    ${client_modal.client_input}
    Click Element    ${client_modal.client_input}
    Clear Text    ${client_modal.client_input}
    Input Text    ${client_modal.client_input}    ${text}
    Close Keyboard

Pdv - Orders - Click Client By Name
    [Documentation]    Cliente retornado na busca, selecionado pelo nome.
    [Arguments]    ${client_name}
    ${locator}=    Replace String    ${client_modal.client_by_name}    CLIENT_NAME    ${client_name}
    Wait Visible And Click Element    ${locator}

Pdv - Orders - Input Client Modal CPF
    [Documentation]    Campo CPF/CNPJ — EditText com placeholder "000.000.000-00".
    [Arguments]    ${text}
    Wait Visible And Input Text    ${client_modal.cpf_input}    ${text}
    Close Keyboard

Pdv - Orders - Click Register Client
    [Documentation]    Botão "Cadastrar novo cliente!" — navega para tela de cadastro.
    Wait Visible And Click Element    ${client_modal.btn_register_client}

Pdv - Orders - Click Client Modal Cancel
    [Documentation]    Botão "Cancelar" — fecha o modal sem salvar.
    Wait Visible And Click Element    ${client_modal.btn_cancel}

Pdv - Orders - Click Client Modal Confirm
    [Documentation]    Botão "Confirmar" — confirma o cliente e fecha o modal.
    Wait Visible And Click Element    ${client_modal.btn_confirm}

Pdv - Orders - Verify Remove Item Icon Dialog
    [Documentation]    Mensagem de confirmação — usado para verificar que o dialog abriu.
    Wait Until Element Is Visible    ${item_remove_dialog.confirm_message}

Pdv - Orders - Click Remove Item Icon Cancel
    [Documentation]    Botão "Não" — cancela a remoção e fecha o dialog.
    Wait Visible And Click Element    ${item_remove_dialog.btn_no}

Pdv - Orders - Click Remove Item Icon Confirm
    [Documentation]    Botão "Sim" — confirma a remoção do item.
    Wait Visible And Click Element    ${item_remove_dialog.btn_yes}
    Wait For Element To Disappear    ${item_remove_dialog.confirm_message}

Pdv - Orders - Click Discount
    [Documentation]    Tab "Desconto".
    Wait Visible And Click Element    ${discount_modal.tab_discount}

Pdv - Orders - Click Addition
    [Documentation]    Tab "Acréscimo".
    Wait Visible And Click Element    ${discount_modal.tab_addition}

Pdv - Orders - Click R$
    [Documentation]    Botão tipo "R$" (valor fixo).
    Wait Visible And Click Element    ${discount_modal.btn_type_value}

Pdv - Orders - Click Percent
    [Documentation]    Botão tipo "%" (percentual).
    Wait Visible And Click Element    ${discount_modal.btn_type_percent}

Pdv - Orders - Input Discount Value
    [Documentation]    Campo de valor — texto varia conforme digitação.
    [Arguments]    ${text}
    Wait Visible And Input Text    ${discount_modal.value_input}    ${text}
    Close Keyboard

Pdv - Orders - Click Remove Discount
    [Documentation]    Botão "Remover" — remove desconto/acréscimo aplicado anteriormente.
    Wait Visible And Click Element    ${discount_modal.btn_remove}

Pdv - Orders - Click Apply Discount
    [Documentation]    Botão "Aplicar" — aplica o desconto/acréscimo informado.
    Wait Visible And Click Element    ${discount_modal.btn_apply}

Pdv - Orders - Click Item
    [Documentation]    Filtro "Todos".
    Wait Visible And Click Element    ${orders.filter_all}

Pdv - Orders - Click Item 2
    [Documentation]    Filtro "Todos".
    Wait Visible And Click Element    ${orders.filter_all}

Pdv - Orders - Long Press Item
    [Documentation]    Filtro "Todos".
    Wait Visible And Long Press Element    ${orders.filter_all}

Pdv - Orders - Long Press Item 2
    [Documentation]    Filtro "Todos".
    Wait Visible And Long Press Element    ${orders.filter_all}
