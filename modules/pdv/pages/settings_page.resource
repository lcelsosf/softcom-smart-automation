*** Settings ***
Documentation    Ações atômicas — Configurações (SettingsScreen)
Resource    ../../../resources/helpers/common_keywords.resource


*** Keywords ***
Pdv - Settings - Click Printers
    Wait Visible And Click Element    ${settings.printers}

Pdv - Settings - Click List Printers
    Wait Visible And Click Element    ${settings.list_printers}

Pdv - Settings - Click Printer Checkbox
    Wait Visible And Click Element    ${settings.checkbox}

Pdv - Settings - Click Printer Close
    Wait Visible And Click Element    ${settings.close}

Pdv - Settings - Click Back
    Wait Visible And Click Element    ${settings.back}

Pdv - Settings - Click Back Settings
    Wait Visible And Click Element    ${settings.back_settings}

Pdv - Settings - Click Ticket
    Wait Visible And Click Element    ${settings.ticket}

Pdv - Settings - Click Ticket Action List
    Wait Visible And Click Element    ${settings.ticket_action_list}

Pdv - Settings - Click Ticket Print
    Wait Visible And Click Element    ${settings.ticket_print}

Pdv - Settings - Click Ticket Quest
    Wait Visible And Click Element    ${settings.ticket_quest}

Pdv - Settings - Click Ticket Noaction
    Wait Visible And Click Element    ${settings.ticket_noaction}

Pdv - Settings - Verify Ticket Quest Visible
    Wait Until Element Is Visible    ${settings.ticket_quest_text}    timeout=${ELEMENT_TIMEOUT}

Pdv - Settings - Click Ticket Quest Confirm
    Wait Visible And Click Element    ${settings.ticket_quest_confirm}

Pdv - Settings - Click Ticket Quest Cancel
    Wait Visible And Click Element    ${settings.ticket_quest_cancel}

Pdv - Settings - Click Smart PDV
    Wait Visible And Click Element    ${settings.smart_pdv}

Pdv - Settings - Click Mod Operation
    Wait Visible And Click Element    ${settings.mod_operation}

Pdv - Settings - Click Express
    Wait Visible And Click Element    ${settings.express}

Pdv - Settings - Click Mini PDV
    Wait Visible And Click Element    ${settings.mini_pdv}

Pdv - Settings - Click Default
    Wait Visible And Click Element    ${settings.default}

# Payment_Forms - Formas de Pagamento
Pdv - Settings - Click Payment Forms
    Wait Visible And Click Element    ${settings.payments_forms}

Pdv - Settings - Click Enable Pixoff
    Wait Visible And Click Element    ${settings.enable_pixoff}

Pdv - Settings - Click Enable Bankslip
    Wait Visible And Click Element    ${settings.enable_bankslip}

Pdv - Settings - Click Enable Pix
    Wait Visible And Click Element    ${settings.enable_pix}

# SoftcomPay

Pdv - Settings - Click SoftcomPay
    Wait Visible And Click Element    ${settings.softcompay}

Pdv - Settings - Click Test Env
    Wait Visible And Click Element    ${settings.test_env}

Pdv - Settings - Client Id
    [Arguments]    ${text}
    Wait Visible And Input Text    ${settings.client_id}    ${text}
    Close Keyboard

Pdv - Settings - Client Secret
    [Arguments]    ${text}
    Wait Visible And Input Text    ${settings.client_secret}    ${text}
    Close Keyboard

Pdv - Settings - Click Check Keys 
    Wait Visible And Click Element    ${settings.check_keys}

Pdv - Settings - Click Thanks
    Wait Visible And Click Element    ${settings.thanks}