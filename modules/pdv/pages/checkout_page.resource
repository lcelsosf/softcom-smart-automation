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
    Wait Visible And Click Element    ${bank_slip.btn_add}

Pdv - Checkout - Click Bank Slip Sub
    [Documentation]    Botao de remover parcela.
    Wait Visible And Click Element    ${bank_slip.btn_sub}

Pdv - Checkout - Input Bank Slip Term
    [Documentation]    Input de prazo — visível apenas em métodos que exigem prazo (ex: Boleto Bancário).
    [Arguments]    ${text}
    Wait Visible And Input Text    ${bank_slip.term_input}    ${text}
    Close Keyboard

Pdv - Checkout - Click Calendar
    [Documentation]    Botao Calendario.
    Wait Visible And Click Element    ${bank_slip.calendar}

Pdv - Checkout - Click Day By Number
    [Documentation]    Uso: xpath=//android.view.View[@clickable='true' and .//android.widget.TextView[@text='DAY']].
    [Arguments]    ${day_number}
    ${locator}=    Replace String    ${bank_slip.day_by_number}    DAY_NUMBER    ${day_number}
    Wait Visible And Click Element    ${locator}
