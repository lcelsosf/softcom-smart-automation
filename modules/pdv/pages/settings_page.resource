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
    Wait Until Element Is Visible    ${settings.ticket_quest_text}

Pdv - Settings - Click Ticket Quest Confirm
    Wait Visible And Click Element    ${settings.ticket_quest_confirm}

Pdv - Settings - Click Ticket Quest Cancel
    Wait Visible And Click Element    ${settings.ticket_quest_cancel}

Pdv - Settings - Click Smart PDV
    Wait Visible And Click Element    ${settings.smart_pdv}

Pdv - Settings - Click Conference Order
    Wait Visible And Click Element    ${settings.conference_order}
