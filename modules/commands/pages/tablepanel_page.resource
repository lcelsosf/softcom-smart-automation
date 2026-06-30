*** Settings ***
Documentation    Page object da tela Painel de Mesas — módulo Comanda.

*** Keywords ***
Commands - Table Panel Should Be Visible
    [Documentation]    Verifica que o Painel de Mesas foi carregado.
    Wait Until Element Is Visible With Retry    ${table_panel.btn_open_table}

Commands - Table Panel Should Not Be Visible
    [Documentation]    Verifica que o Painel de Mesas não está mais visível.
    Wait For Element To Disappear    ${table_panel.btn_open_table}

Commands - Click Menu
    [Documentation]    Clica no botão Menu — abre o drawer de navegação.
    Wait Visible And Click Element With Retry    ${table_panel.btn_menu}

Commands - Click Home
    [Documentation]    Clica no botão Home — retorna à tela inicial.
    Wait Visible And Click Element With Retry    ${table_panel.btn_home}

Commands - Search Table
    [Documentation]    Digita um termo no campo de busca de mesas.
    [Arguments]    ${search_term}
    Wait Visible And Click Element With Retry       ${table_panel.search_input}
    Wait Visible And Input Text Pause    ${table_panel.search_input}    ${search_term}

Commands - Click Filter
    [Documentation]    Clica no botão Filtro — abre o dialog de filtros.
    Wait Visible And Click Element With Retry    ${table_panel.btn_filter}

Commands - Click Open Table
    [Documentation]    Clica no botão "Abrir Mesa" — abre o modal de abertura de mesa.
    Wait Visible And Click Element With Retry    ${table_panel.btn_open_table}

Commands - Click Table By Number
    [Documentation]    Clica em uma mesa do grid pelo número exibido.
    ...
    ...    Exemplo:
    ...    Commands - Click Table By Number    01
    [Arguments]    ${table_number}
    Wait Visible And Click Element With Retry
    ...    xpath=//android.view.View[@clickable='true' and .//android.widget.TextView[@text='${table_number}']]

Commands - Click First Table
    [Documentation]    Clica na primeira mesa exibida no grid.
    ...    Útil quando o teste não precisa de uma mesa específica.
    Wait Visible And Click Element With Retry    ${table_panel.first_table}

Commands - Drawer Menu Click Sync Data
    [Documentation]    Clica em "Sincronizar Dados".
    Wait Visible And Click Element With Retry    ${drawer_menu.option_sync_data}

Commands - Drawer Menu Click Transfer Table
    [Documentation]    Clica em "Transferir Mesa".
    Wait Visible And Click Element With Retry    ${drawer_menu.option_transfer_table}

Commands - Drawer Menu Click Orders List
    [Documentation]    Clica em "Lista de Pedidos".
    Wait Visible And Click Element With Retry    ${drawer_menu.option_orders_list}

Commands - Drawer Menu Click Settings
    [Documentation]    Clica em "Configurações".
    Wait Visible And Click Element With Retry    ${drawer_menu.option_settings}

Commands - Drawer Menu Click Logoff
    [Documentation]    Clica em "Realizar Logoff" — abre o dialog de confirmação.
    Wait Visible And Click Element With Retry    ${drawer_menu.option_logoff}

Commands - Drawer Menu Click Option By Name
    [Documentation]    Clica em qualquer opção do menu pelo content-desc do ícone.
    ...
    ...    Exemplo:
    ...    Commands - Drawer Menu Click Option By Name    Transferir Mesa
    [Arguments]    ${option_name}
    Wait Visible And Click Element With Retry    xpath=//*[@content-desc='${option_name}']

Commands - Logoff Dialog Should Be Visible
    [Documentation]    Verifica que o dialog de confirmação de logoff está aberto.
    Wait Until Element Is Visible With Retry    ${logoff_dialog.title}

Commands - Confirm Logoff
    [Documentation]    Clica em "Sim" — confirma o logoff e retorna à tela de login.
    Wait Visible And Click Element With Retry    ${logoff_dialog.btn_yes}

Commands - Cancel Logoff
    [Documentation]    Clica em "Não" — cancela o logoff e mantém a sessão.
    Wait Visible And Click Element With Retry    ${logoff_dialog.btn_no}

Commands - Filter Dialog Should Be Visible
    [Documentation]    Verifica que o dialog de filtros está aberto.
    Wait Until Element Is Visible With Retry    ${filter_dialog.title}

Commands - Select Filter Open Tables
    [Documentation]    Seleciona o filtro 'Apenas mesas "Abertas"'.
    Wait Visible And Click Element With Retry    ${filter_dialog.option_open_tables}

Commands - Select Filter My Tables
    [Documentation]    Seleciona o filtro 'Apenas "Minhas mesas"'.
    Wait Visible And Click Element With Retry    ${filter_dialog.option_my_tables}

Commands - Select Filter All Tables
    [Documentation]    Seleciona o filtro 'Exibir "Todas as mesas"'.
    Wait Visible And Click Element With Retry    ${filter_dialog.option_all_tables}

Commands - Click Filter Cancel
    [Documentation]    Clica em "Cancelar" — fecha o dialog sem aplicar o filtro.
    Wait Visible And Click Element With Retry    ${filter_dialog.btn_cancel}

Commands - Click Filter Apply
    [Documentation]    Clica em "Aplicar" — aplica o filtro selecionado.
    Wait Visible And Click Element With Retry    ${filter_dialog.btn_apply}

Commands - Open Table Modal Should Be Visible
    [Documentation]    Verifica que o modal "Abrir Mesa" está aberto.
    Wait Until Element Is Visible With Retry    ${open_table_modal.title}

Commands - Open Table Fill Table Number
    [Documentation]    Preenche o número da mesa a ser aberta.
    [Arguments]    ${table_number}
    Wait Visible And Click Element With Retry    ${open_table_modal.table_number_input}
    Clear Text                        ${open_table_modal.table_number_input}
    Input Text                        ${open_table_modal.table_number_input}    ${table_number}
    Close Keyboard

Commands - Open Table Fill Client Name
    [Documentation]    Preenche o nome do cliente associado à mesa.
    [Arguments]    ${client_name}
    Wait Visible And Click Element With Retry    ${open_table_modal.client_input}
    Clear Text                        ${open_table_modal.client_input}
    Input Text                        ${open_table_modal.client_input}    ${client_name}
    Close Keyboard

Commands - Open Table Click Search Client
    [Documentation]    Clica no botão de pesquisar cliente — abre a pesquisa de cliente.
    Wait Visible And Click Element With Retry    ${open_table_modal.btn_search_client}

Commands - Open Table Click People Add
    [Documentation]    Clica no botão + para incrementar a quantidade de pessoas.
    Wait Visible And Click Element With Retry    ${open_table_modal.btn_people_add}

Commands - Open Table Click People Sub
    [Documentation]    Clica no botão - para decrementar a quantidade de pessoas.
    Wait Visible And Click Element With Retry    ${open_table_modal.btn_people_sub}

Commands - Open Table Fill People Count
    [Documentation]    Preenche a quantidade de pessoas diretamente no input.
    [Arguments]    ${people_count}
    Wait Visible And Click Element With Retry    ${open_table_modal.people_count_input}
    Clear Text                        ${open_table_modal.people_count_input}
    Input Text                        ${open_table_modal.people_count_input}    ${people_count}
    Close Keyboard

Commands - Open Table Click Cancel
    [Documentation]    Clica em "Cancelar" — fecha o modal sem abrir a mesa.
    Wait Visible And Click Element With Retry    ${open_table_modal.btn_cancel}

Commands - Open Table Click Confirm
    [Documentation]    Clica em "Confirmar" — abre a mesa com os dados informados.
    Wait Visible And Click Element With Retry    ${open_table_modal.btn_confirm}