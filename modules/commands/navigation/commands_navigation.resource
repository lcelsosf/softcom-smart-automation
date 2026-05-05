*** Settings ***
Documentation    Keywords de navegação do módulo Commands (Comanda).
...
...    Nomenclatura: Commands - Navigate To <Destino>
...    Dependências resolvidas pelo base_commands.resource:
...    - common_keywords.resource (Wait Visible And Click Element, Close Keyboard, etc.)
...    - Locators do módulo carregados via locators_loader.py


*** Keywords ***
Commands - Navigate To Open Table
    [Documentation]    Abre uma nova mesa informando número e nome do cliente.
    [Arguments]    ${table_number}    ${client_name}
    Wait Visible And Click Element    ${table_panel.open_table}
    Wait Visible And Input Text    ${open_table.number_table}    ${table_number}
    Close Keyboard
    Wait Visible And Input Text    ${open_table.client_table}    ${client_name}
    Close Keyboard
    Wait Visible And Click Element    ${open_table.confirm}

Commands - Navigate To Search Table And Open
    [Documentation]    Localiza e abre uma mesa já existente pelo número.
    [Arguments]    ${table_number}
    Wait Visible And Input Text    ${table_panel.table_search}    ${table_number}
    Close Keyboard
    Wait Visible And Click Element    ${table_panel.table}

Commands - Add Items To Table
    [Documentation]    Busca e adiciona N itens à mesa em sequência.
    ...    Aceita um ou mais nomes de itens como argumentos.
    ...
    ...    Exemplo:
    ...    Commands - Add Items To Table    Frango
    ...    Commands - Add Items To Table    Frango    Cerveja    Água
    [Arguments]    @{item_names}
    FOR    ${item}    IN    @{item_names}
        Wait Visible And Input Text    ${table.search_item}    ${item}
        Close Keyboard
        Wait Visible And Click Element    ${products.product}
        Wait Visible And Click Element    ${products.add_item}
        Wait Visible And Click Element    ${table.clean_search}
    END
    Wait Visible And Click Element    ${table.advance}
    Wait Visible And Click Element    ${table.advance}

Commands - Navigate To Invoice And Pay
    [Documentation]    Realiza o faturamento da mesa com o método de pagamento informado.
    ...    Métodos suportados: money, pixoff
    [Arguments]    ${payment_method}
    Wait Visible And Click Element    ${table.menu}
    Wait Visible And Click Element    ${menu_table.invoice}
    IF    '${payment_method}' == 'money'
        Wait Visible And Click Element    ${invoice.money}
    ELSE IF    '${payment_method}' == 'pixoff'
        Wait Visible And Click Element    ${invoice.pixoff}
    END
    Wait Visible And Click Element    ${invoice.confirm}
    Wait Visible And Click Element    ${invoice.finalize_sale}
    Wait Until Element Is Visible    ${table_panel.table_panel}

Commands - Navigate To Advance
    [Documentation]    Realiza um adiantamento na mesa informando cliente, valor e pagamento.
    ...    Métodos suportados: money, pixoff
    [Arguments]    ${client_name}    ${advance_value}    ${payment_method}
    Wait Visible And Click Element    ${table.menu}
    Wait Visible And Click Element    ${menu_table.advance}
    Wait Visible And Click Element    ${advance.new_advance}
    Wait Visible And Input Text    ${advance.advance_client_text}    ${client_name}
    Close Keyboard
    Wait Visible And Input Text    ${advance.advance_value_text}    ${advance_value}
    Close Keyboard
    Wait Visible And Click Element    ${advance.advance_paymentform}
    IF    '${payment_method}' == 'money'
        Wait Visible And Click Element    ${advance.advance_money}
    ELSE IF    '${payment_method}' == 'pixoff'
        Wait Visible And Click Element    ${advance.advance_pixoff}
    END
    Wait Visible And Click Element    ${advance.advance_confirm}
    Wait Visible And Click Element    ${advance.back}

Commands - Navigate To Split Account
    [Documentation]    Navega até a tela de divisão de conta.
    Wait Visible And Click Element    ${table.menu}
    Wait Visible And Click Element    ${menu_table.split_account}
    Wait Until Element Is Visible    ${split_account.split_account}

Commands - Navigate To Change Client
    [Documentation]    Navega até a tela de mudança de cliente da mesa.
    Wait Visible And Click Element    ${table.menu}
    Wait Visible And Click Element    ${menu_table.change_client}

Commands - Navigate To Join Accounts
    [Documentation]    Navega até a tela de junção de contas.
    Wait Visible And Click Element    ${table.menu}
    Wait Visible And Click Element    ${menu_table.join_accounts}

Commands - Navigate To Cancel Table
    [Documentation]    Cancela a mesa informando o motivo e confirmando o cancelamento.
    Wait Visible And Click Element    ${table.menu}
    Wait Visible And Click Element    ${menu_table.cancel_table}
    Wait Until Element Is Visible    ${cancel_table.cancel_reason}
    Wait Visible And Input Text    ${cancel_table.cancel_reason_text}    ${commands.cancel.reason}
    Close Keyboard
    Wait Visible And Click Element    ${cancel_table.confirm}
    Wait Until Element Is Visible    ${cancel_table.cancel_question}
    Wait Visible And Click Element    ${cancel_table.confirm_cancel}