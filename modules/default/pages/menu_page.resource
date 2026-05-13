*** Settings ***
Documentation    Ações atômicas — Menu Lateral (DrawerMenu)
Resource         ../../../resources/helpers/common_keywords.resource


*** Keywords ***
Default - Menu - Open Menu
    Wait Visible And Click Element With Retry    ${menu.menu}

Default - Menu - Click Logoff
    Wait Visible And Click Element    ${menu.logoff}

Default - Menu - Confirm Logoff
    Wait Visible And Click Element    ${menu.logoff_confirm}

Default - Menu - Click Settings
    Wait Visible And Click Element    ${menu.settings}

Default - Menu - Click New Order
    Wait Visible And Click Element    ${menu.new_order}

Default - Menu - Click Orders List
    Wait Visible And Click Element    ${menu.orders_list}

Default - Menu - Click Register Client
    Wait Visible And Click Element    ${menu.register_client}

Default - Menu - Click Sync
    Wait Visible And Click Element    ${menu.sync}
