*** Settings ***
Documentation    Ações atômicas — Menu Lateral da Mesa (ConfigDrawerMenu)
Resource    ../../../resources/helpers/common_keywords.resource


*** Keywords ***
Commands - Menu Table - Click Back
    Wait Visible And Click Element    ${menu_table.back}

Commands - Menu Table - Click Invoice
    Wait Visible And Click Element    ${menu_table.invoice}

Commands - Menu Table - Click Advance
    Wait Visible And Click Element    ${menu_table.advance}

Commands - Menu Table - Click Split Account
    Wait Visible And Click Element    ${menu_table.split_account}

Commands - Menu Table - Click Change Client
    Wait Visible And Click Element    ${menu_table.change_client}

Commands - Menu Table - Click Join Accounts
    Wait Visible And Click Element    ${menu_table.join_accounts}

Commands - Menu Table - Click Cancel Table
    Wait Visible And Click Element    ${menu_table.cancel_table}

Commands - Menu Table - Click Manage Service Charge
    Swipe Until Visible And Click Element    ${menu_table.manage_service_charge}
