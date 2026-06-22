*** Settings ***
Documentation    Page object da tela Lista de Pedidos — módulo PDV.

*** Keywords ***

Orders List - Click Back
    [Documentation]    Clica no botão Voltar da top bar.
    Wait Visible And Click Element    ${orders_list.btn_back}

Orders List - Click Print
    [Documentation]    Clica no botão Imprimir da top bar — abre o modal
    ...    "O que deseja imprimir?".
    Wait Visible And Click Element    ${orders_list.btn_print}

Orders List - Search
    [Documentation]    Digita um termo no campo de busca da lista de pedidos.
    [Arguments]    ${search_term}
    Wait Visible And Click Element       ${orders_list.search_input}
    Wait Visible And Input Text Pause    ${orders_list.search_input}    ${search_term}

Orders List - Click Filters
    [Documentation]    Clica no botão Filtros — abre opções de filtro da lista.
    Wait Visible And Click Element    ${orders_list.btn_filters}

Orders List - Click First Order
    [Documentation]    Clica no primeiro pedido exibido na lista.
    ...    Útil quando o teste não precisa de um pedido específico —
    ...    apenas o mais recente/primeiro da listagem atual.
    ...    Abre o modal de ações do pedido.
    Wait Visible And Click Element    ${orders_list.first_order_card}

Orders List - Actions Modal Should Be Visible
    [Documentation]    Verifica que o modal de ações do pedido está aberto.
    ...    Use após clicar em um pedido da lista.
    Wait Until Element Is Visible    ${order_actions_modal.btn_view_order}    timeout=${ELEMENT_TIMEOUT}

Orders List - Actions Modal Should Not Be Visible
    [Documentation]    Verifica que o modal de ações do pedido foi fechado.
    Wait For Element To Disappear    ${order_actions_modal.btn_view_order}

Orders List - Actions Modal Click View Order
    [Documentation]    Clica em "Visualizar Pedido" — abre os detalhes do pedido.
    Wait Visible And Click Element    ${order_actions_modal.btn_view_order}

Orders List - Actions Modal Click Reprint Receipt
    [Documentation]    Clica em "Reimprimir Comprovante".
    Wait Visible And Click Element    ${order_actions_modal.btn_reprint_receipt}

Orders List - Actions Modal Click Fiscal Details
    [Documentation]    Clica em "Detalhes da Nota Fiscal".
    Wait Visible And Click Element    ${order_actions_modal.btn_fiscal_details}

Orders List - Actions Modal Click Cancel Order
    [Documentation]    Clica em "Cancelar Pedido".
    Wait Visible And Click Element    ${order_actions_modal.btn_cancel_order}

Orders List - Actions Modal Close By Overlay
    [Documentation]    Fecha o modal clicando na área acima do sheet.
    Wait Visible And Click Element    ${order_actions_modal.btn_close_overlay}

Orders List - Print Options Modal Should Be Visible
    [Documentation]    Verifica que o modal "O que deseja imprimir?" está aberto.
    ...    Use após clicar no botão Imprimir da top bar.
    Wait Until Element Is Visible    ${print_options_modal.title}    timeout=${ELEMENT_TIMEOUT}

Orders List - Print Options Modal Should Not Be Visible
    [Documentation]    Verifica que o modal de opções de impressão foi fechado.
    Wait For Element To Disappear    ${print_options_modal.title}

Orders List - Print Options Click Receipts
    [Documentation]    Clica em "Recebimentos" — imprime o relatório de recebimentos.
    Wait Visible And Click Element    ${print_options_modal.btn_receipts}

Orders List - Print Options Click Sales Summary
    [Documentation]    Clica em "Resumo de Vendas" — imprime o resumo de vendas.
    Wait Visible And Click Element    ${print_options_modal.btn_sales_summary}

Orders List - Print Options Click Back
    [Documentation]    Clica em "Voltar" — fecha o modal sem imprimir.
    Wait Visible And Click Element    ${print_options_modal.btn_back}

Orders List - Should Be Visible
    [Documentation]    Verifica que a tela de Lista de Pedidos está visível.
    Wait Until Element Is Visible    ${orders_list.search_input}    timeout=${ELEMENT_TIMEOUT}

Orders List - View Order Screen Should Be Visible
    [Documentation]    Verifica que a tela de Visualizar Pedido está visível.
    Wait Until Element Is Visible    ${order_actions_modal.view_order_screen}    timeout=${ELEMENT_TIMEOUT}

Orders List - Fiscal Details Screen Should Be Visible
    [Documentation]    Verifica que a tela de Detalhes da Nota Fiscal está visível.
    Wait Until Element Is Visible    ${order_actions_modal.fiscal_details_screen}    timeout=${ELEMENT_TIMEOUT}

Orders List - Cancel Order Modal Should Be Visible
    [Documentation]    Verifica que o modal de confirmação de cancelamento está visível.
    Wait Until Element Is Visible    ${cancel_order_modal.cancel_message}    timeout=${ELEMENT_TIMEOUT}

Orders List - Cancel Order Modal Click Yes
    [Documentation]    Clica em "Sim" — confirma o cancelamento do pedido.
    Wait Visible And Click Element    ${cancel_order_modal.btn_yes}

Orders List - Cancel Order Success Should Be Visible
    [Documentation]    Verifica que a mensagem de cancelamento com sucesso está visível.
    Wait Until Element Is Visible    ${cancel_order_modal.success_message}    timeout=${ELEMENT_TIMEOUT}

Orders List - Cancel Order Click Ok
    [Documentation]    Clica em "Ok!" — fecha o modal de sucesso do cancelamento.
    Wait Visible And Click Element    ${cancel_order_modal.btn_ok}

Orders List - Print Status Should Be Printing
    [Documentation]    Verifica que a mensagem "Realizando a impressão!" está visível.
    ...    Estado intermediário — a impressão ainda está em andamento.
    Wait Until Element Is Visible    ${print_status_modal.printing_message}    timeout=${ELEMENT_TIMEOUT}

Orders List - Print Status Should Be Completed
    [Documentation]    Verifica que a mensagem "Impressão concluída!" está visível.
    ...    Estado final — confirma que a impressão foi concluída com sucesso.
    Wait Until Element Is Visible    ${print_status_modal.completed_message}    timeout=${ELEMENT_TIMEOUT}

Orders List - Print Status Should Not Be Completed
    [Documentation]    Verifica que a mensagem "Impressão concluída!" não está mais visível.
    Wait For Element To Disappear    ${print_status_modal.completed_message}
