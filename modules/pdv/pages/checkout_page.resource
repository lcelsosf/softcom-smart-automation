*** Settings ***
Documentation    Ações atômicas — Tela de checkout do módulo PDV.
Resource    ../../../resources/helpers/common_keywords.resource


*** Keywords ***
Pdv - Checkout - Click Back
    [Documentation]    Botão Voltar.
    Wait Visible And Click Element    ${Checkout.btn_back}

Pdv - Checkout - Click Sync
    [Documentation]    Botão Sincronizar dados (top bar).
    Wait Visible And Click Element    ${Checkout.btn_sync}

Pdv - Checkout - Click Method By Name
    [Documentation]    Selecionar método pelo nome — genérico, passa o nome como argumento.
    [Arguments]    ${method_name}
    ${locator}=    Replace String    ${Checkout.method_by_name}    METHOD_NAME    ${method_name}
    Wait Visible And Click Element    ${locator}

Pdv - Checkout - Click Selected Method Actions
    [Documentation]    Botão de ações do pagamento selecionado (editar/remover).
    Wait Visible And Click Element    ${Checkout.selected_method_actions}

Pdv - Checkout - Click Finish Sale
    [Documentation]    Botão "Finalizar Venda".
    Wait Visible And Click Element    ${Checkout.btn_finish_sale}

Pdv - Checkout - Click Value Clear
    [Documentation]    Tecla Limpar — apaga o valor inteiro.
    Wait Visible And Click Element    ${payment_value_modal.key_clear}

Pdv - Checkout - Click Value Backspace
    [Documentation]    Tecla ⌫ (backspace) — apaga o último dígito.
    Wait Visible And Click Element    ${payment_value_modal.key_backspace}

Pdv - Checkout - Click Value Cancel
    [Documentation]    Botão "Cancelar" — fecha o modal sem confirmar.
    Wait Visible And Click Element    ${payment_value_modal.btn_cancel}

Pdv - Checkout - Click Value Confirm
    [Documentation]    Botão "Confirmar" — confirma o valor e adiciona o pagamento.
    Wait Visible And Click Element    ${payment_value_modal.btn_confirm}

Pdv - Checkout - Click Bank Slip Add
    [Documentation]    Botao de adicionar parcela.
    Wait Until Element Is Visible    ${bank_slip.parcels_quantity}
    ${previous_quantity}=    Get Text    ${bank_slip.parcels_quantity}
    Wait Visible And Click Element    ${bank_slip.btn_add}
    ${expected_quantity}=    Evaluate    int(${previous_quantity}) + 1
    ${expected_quantity}=    Convert To String    ${expected_quantity}
    Wait Until Keyword Succeeds    5x    1s    Element Text Should Be    ${bank_slip.parcels_quantity}    ${expected_quantity}

Pdv - Checkout - Click Bank Slip Sub
    [Documentation]    Botao de remover parcela.
    Wait Until Element Is Visible    ${bank_slip.parcels_quantity}
    ${previous_quantity}=    Get Text    ${bank_slip.parcels_quantity}
    Wait Visible And Click Element    ${bank_slip.btn_sub}
    ${expected_quantity}=    Evaluate    int(${previous_quantity}) - 1
    ${expected_quantity}=    Convert To String    ${expected_quantity}
    Wait Until Keyword Succeeds    5x    1s    Element Text Should Be    ${bank_slip.parcels_quantity}    ${expected_quantity}

Pdv - Checkout - Input Bank Slip Term
    [Documentation]    Input de prazo — visível apenas em métodos que exigem prazo (ex: Boleto Bancário).
    [Arguments]    ${text}
    Wait Until Element Is Visible    ${bank_slip.term_input}
    Click Element    ${bank_slip.term_input}
    Pdv - Checkout - Click Value Clear
    ${digits}=    Convert To String    ${text}
    ${length}=    Get Length    ${digits}
    FOR    ${index}    IN RANGE    ${length}
        ${digit}=    Get Substring    ${digits}    ${index}    ${index + 1}
        Pdv - Checkout - Click Value Key    ${digit}
    END

Pdv - Checkout - Click Value Key
    [Documentation]    Clica em uma tecla numérica do teclado do modal de pagamento.
    [Arguments]    ${digit}
    ${locator}=    Replace String    ${payment_value_modal.key_by_digit}    DIGIT    ${digit}
    Wait Visible And Click Element    ${locator}

Pdv - Checkout - Click Calendar
    [Documentation]    Botao Calendario.
    Wait Visible And Click Element    ${bank_slip.calendar}

Pdv - Checkout - Verify Calendar Day Visible
    [Documentation]    Verifica se o calendário está visível validando o dia informado.
    [Arguments]    ${day_number}
    ${locator}=    Replace String    ${bank_slip.day_by_number}    DAY_NUMBER    ${day_number}
    Wait Until Element Is Visible    ${locator}

Pdv - Checkout - Click Day By Number
    [Documentation]    Uso: xpath=//android.view.View[@clickable='true' and .//android.widget.TextView[@text='DAY_NUMBER']].
    [Arguments]    ${day_number}
    ${locator}=    Replace String    ${bank_slip.day_by_number}    DAY_NUMBER    ${day_number}
    Wait Visible And Click Element    ${locator}
