*** Settings ***
Documentation    Page object da tela Lista de Clientes — módulo PDV.

*** Keywords ***

Client List - Click Back
    [Documentation]    Clica no botão Voltar da top bar.
    Wait Visible And Click Element    ${client_list.btn_back}

Client List - Click Sync
    [Documentation]    Clica no botão Atualizar — recarrega a lista de clientes.
    Wait Visible And Click Element    ${client_list.btn_sync}

Client List - Search Client
    [Documentation]    Digita o nome ou documento no campo de busca.
    [Arguments]    ${search_term}
    Wait Visible And Click Element       ${client_list.search_input}
    Wait Visible And Input Text    ${client_list.search_input}    ${search_term}

Client List - Click Client By Name
    [Documentation]    Clica em um cliente da lista pelo nome exibido.
    ...    Âncora pelo nome — estável independente da posição na lista.
    [Arguments]    ${client_name}
    Wait Visible And Click Element
    ...    xpath=//android.view.View[@clickable='true' and .//android.widget.TextView[@text='${client_name}']]

Client List - Client Should Be Visible
    [Documentation]    Verifica que um cliente está listado pelo nome.
    [Arguments]    ${client_name}
    Wait Until Element Is Visible
    ...    xpath=//android.view.View[@clickable='true' and .//android.widget.TextView[@text='${client_name}']]

Client List - Click New Client
    [Documentation]    Clica em "+ Novo Cliente" — abre o cadastro de novo cliente.
    Wait Visible And Click Element    ${client_list.btn_new_client}

Client List - Refresh Success Modal Should Be Visible
    [Documentation]    Verifica que o modal de confirmação de atualização está visível.
    ...    Use após clicar em Atualizar para confirmar que a sincronização concluiu.
    Wait Until Element Is Visible    ${sync_success_modal.title}

Client List - Refresh Success Modal Should Not Be Visible
    [Documentation]    Verifica que o modal de confirmação foi fechado.
    Wait For Element To Disappear    ${sync_success_modal.title}

Client List - Click Refresh Success Ok
    [Documentation]    Clica em "Ok" — fecha o modal de atualização concluída.
    Wait Visible And Click Element    ${sync_success_modal.btn_ok}

Client List - Click Sync And Confirm
    [Documentation]    Clica em Atualizar, aguarda o modal de confirmação
    ...    e fecha clicando em "Ok". Fluxo completo de sincronização.   
    Client List - Click Sync
    Client List - Refresh Success Modal Should Be Visible
    Client List - Click Refresh Success Ok

Client Register - Click Tab Details
    [Documentation]    Seleciona a aba "Detalhes".
    Wait Visible And Click Element    ${client_register.tab_details}

Client Register - Click Tab Address
    [Documentation]    Seleciona a aba "Endereço".
    Wait Visible And Click Element    ${client_register.tab_address}

Client Register - Open Person Type Menu
    [Documentation]    Clica no campo para abrir o dropdown de Tipo de Pessoa.
    Wait Visible And Click Element    ${client_register.person_type_open_menu}

Client Register - Select Person Type
    [Documentation]    Abre o dropdown e seleciona a opção pelo nome.
    ...    Locator genérico — funciona para qualquer opção da lista.
    ...
    ...    Opções disponíveis: Física, Jurídica
    ...
    ...    Exemplo:
    ...    Client Register - Select Person Type    Jurídica
    [Arguments]    ${option_name}
    Client Register - Open Person Type Menu
    Wait Visible And Click Element
    ...    xpath=//android.view.View[@clickable='true' and .//android.widget.TextView[@text='${option_name}']]

Client Register - Fill Cpf
    [Documentation]    Preenche o campo CPF.
    [Arguments]    ${cpf}
    Wait Visible And Click Element    ${client_register.cpf_input}
    Clear Text                        ${client_register.cpf_input}
    Input Text                        ${client_register.cpf_input}    ${cpf}
    Close Keyboard

Client Register - Fill Cnpj
    [Documentation]    Preenche o campo CNPJ.
    [Arguments]    ${cnpj}
    Wait Visible And Click Element    ${client_register.cnpj_input}
    Clear Text                        ${client_register.cnpj_input}
    Input Text                        ${client_register.cnpj_input}    ${cnpj}
    Close Keyboard

Client Register - Fill Fantasy Name
    [Documentation]    Preenche o campo Nome Fantasia (Jurídica).
    [Arguments]    ${fantasy_name}
    Wait Visible And Click Element    ${client_register.fantasy_name_input}
    Clear Text                        ${client_register.fantasy_name_input}
    Input Text                        ${client_register.fantasy_name_input}    ${fantasy_name}
    Close Keyboard

Client Register - Fill Social Reason
    [Documentation]    Preenche o campo Razão Social (Jurídica).
    [Arguments]    ${social_reason}
    Wait Visible And Click Element    ${client_register.social_reason_input}
    Clear Text                        ${client_register.social_reason_input}
    Input Text                        ${client_register.social_reason_input}    ${social_reason}
    Close Keyboard

Client Register - Fill Name
    [Documentation]    Preenche o campo Nome.
    [Arguments]    ${name}
    Wait Visible And Click Element    ${client_register.name_input}
    Clear Text                        ${client_register.name_input}
    Input Text                        ${client_register.name_input}    ${name}
    Close Keyboard

Client Register - Open Icms Contributor Menu
    [Documentation]    Clica no campo para abrir o dropdown de Contribuinte ICMS.
    Wait Visible And Click Element    ${client_register.icms_contributor_open_menu}

Client Register - Select Icms Contributor
    [Documentation]    Abre o dropdown e seleciona a opção pelo nome.
    ...    Locator genérico — funciona para qualquer opção da lista.
    ...
    ...    Exemplo:
    ...    Client Register - Select Icms Contributor    Não Contribuinte
    [Arguments]    ${option_name}
    Client Register - Open Icms Contributor Menu
    Wait Visible And Click Element
    ...    xpath=//android.view.View[@clickable='true' and .//android.widget.TextView[@text='${option_name}']]

Client Register - Fill Phone
    [Documentation]    Preenche o campo Telefone.
    ...    Clica no campo, executa swipe para reposicioná-lo caso o teclado o oculte e digita o valor.
    [Arguments]    ${phone}
    Wait Visible And Click Element    ${client_register.phone_input}
    Swipe By Percent                  50    70    50    30
    Input Text                        ${client_register.phone_input}    ${phone}
    Close Keyboard

Client Register - Fill Email
    [Documentation]    Preenche o campo E-mail.
    ...    Clica no campo, executa swipe para reposicioná-lo caso o teclado o oculte e digita o valor.
    [Arguments]    ${email}
    Wait Visible And Click Element    ${client_register.email_input}
    Swipe By Percent                  50    70    50    30
    Input Text                        ${client_register.email_input}    ${email}
    Close Keyboard

Client Register - Fill Note
    [Documentation]    Preenche o campo Observação.
    ...    Clica no campo, executa swipe para reposicioná-lo caso o teclado o oculte e digita o valor.
    [Arguments]    ${note}
    Wait Visible And Click Element    ${client_register.note_input}
    Swipe By Percent                  50    70    50    30
    Input Text                        ${client_register.note_input}    ${note}
    Close Keyboard

Client Register - Fill Cep
    [Documentation]    Preenche o campo CEP.
    [Arguments]    ${cep}
    Wait Visible And Click Element    ${client_register.cep_input}
    Clear Text                        ${client_register.cep_input}
    Input Text                        ${client_register.cep_input}    ${cep}
    Close Keyboard

Client Register - Click Consultar Cep
    [Documentation]    Clica no botão "Consultar CEP" — busca o endereço automaticamente.
    Wait Visible And Click Element    ${client_register.btn_consultar_cep}

Client Register - Fill Address
    [Documentation]    Preenche o campo Endereço.
    [Arguments]    ${address}
    Wait Visible And Click Element    ${client_register.address_input}
    Clear Text                        ${client_register.address_input}
    Input Text                        ${client_register.address_input}    ${address}
    Close Keyboard

Client Register - Fill Number
    [Documentation]    Preenche o campo Número.
    [Arguments]    ${number}
    Wait Visible And Click Element    ${client_register.number_input}
    Clear Text                        ${client_register.number_input}
    Input Text                        ${client_register.number_input}    ${number}
    Close Keyboard

Client Register - Fill Neighborhood
    [Documentation]    Preenche o campo Bairro.
    [Arguments]    ${neighborhood}
    Wait Visible And Click Element    ${client_register.neighborhood_input}
    Clear Text                        ${client_register.neighborhood_input}
    Input Text                        ${client_register.neighborhood_input}    ${neighborhood}
    Close Keyboard

Client Register - Open State Menu
    [Documentation]    Clica no campo para abrir o dropdown de UF.
    Wait Visible And Click Element    ${client_register.state_input}

Client Register - Select State
    [Documentation]    Abre o dropdown de UF e seleciona a opção pelo nome/sigla.
    [Arguments]    ${state_name}
    Client Register - Open State Menu
    Wait Visible And Click Element
    ...    xpath=//android.view.View[@clickable='true' and .//android.widget.TextView[@text='${state_name}']]

Client Register - Open City Menu
    [Documentation]    Clica no campo para abrir o dropdown de Cidade.
    ...    Disponível apenas após selecionar a UF.
    Wait Visible And Click Element    ${client_register.city_input}

Client Register - Select City
    [Documentation]    Abre o dropdown de Cidade e seleciona a opção pelo nome.
    [Arguments]    ${city_name}
    Client Register - Open City Menu
    Wait Visible And Click Element
    ...    xpath=//android.view.View[@clickable='true' and .//android.widget.TextView[@text='${city_name}']]

Client Register - Fill Complement
    [Documentation]    Preenche o campo Complemento.
    ...    Clica no campo, executa swipe para reposicioná-lo caso o teclado o oculte e digita o valor.
    [Arguments]    ${complement}
    Wait Visible And Click Element    ${client_register.complement_input}
    Swipe By Percent                  50    70    50    30
    Input Text                        ${client_register.complement_input}    ${complement}
    Close Keyboard

Client Register - Click Init Order
    [Documentation]    Clica no botão "Iniciar Pedido" — acessa a tela de criação de pedido.
    Wait Visible And Click Element    ${client_register.btn_init_order}

Client Register - Click Cancel
    [Documentation]    Clica em "Cancelar" — descarta o cadastro e volta à lista.
    Wait Visible And Click Element    ${client_register.btn_cancel}

Client Register - Click Save
    [Documentation]    Clica em "Salvar Dados" — confirma o cadastro do cliente.
    Wait Visible And Click Element    ${client_register.btn_save}