*** Settings ***
Documentation    Ações atômicas — Dialog Gerenciar Taxas de Serviço
Resource    ../../../resources/helpers/common_keywords.resource


*** Keywords ***
Commands - Manage Service Charge - Verify Visible
    Wait Until Element Is Visible    ${manage_service_charge.verify}

Commands - Manage Service Charge - Active/Deactive
    Swipe Until Visible And Click Element    ${manage_service_charge.toggle_button}    direction=UP    max_swipes=2

Commands - Manage Service Charge - Confirm
    Wait Visible And Click Element    ${manage_service_charge.confirm}

Commands - Manage Service Charge - Cancel
    Wait Visible And Click Element    ${manage_service_charge.cancel}

Commands - Manage Service Charge - Verify Confirmation Dialog
    Wait Until Element Is Visible    ${manage_service_charge.question_view}

Commands - Manage Service Charge - Click Confirm Confirmation
    Wait Visible And Click Element    ${manage_service_charge.question_confirm}

Commands - Manage Service Charge - Click Negative Confirmation
    Wait Visible And Click Element    ${manage_service_charge.question_negative}
