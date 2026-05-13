*** Settings ***
Documentation    Ações atômicas — Painel de Mesas/Comandas (ComandaPainelMesasScreen)
Resource    ../../../resources/helpers/common_keywords.resource


*** Keywords ***
Commands - Table Panel - Click Open Table
    Wait Visible And Click Element    ${table_panel.open_table}

Commands - Table Panel - Click Menu
    Wait Visible And Click Element    ${table_panel.menu}

Commands - Table Panel - Click Home
    Wait Visible And Click Element    ${table_panel.home}

Commands - Table Panel - Search Table
    [Arguments]    ${text}
    Wait Visible And Input Text    ${table_panel.table_search}    ${text}
    Close Keyboard

Commands - Table Panel - Click Filter
    Wait Visible And Click Element    ${table_panel.filter}

Commands - Table Panel - Click Table Item
    Wait Visible And Click Element    ${table_panel.table_item}

Commands - Table Panel - Clear Search
    Wait Visible And Click Element    ${table_panel.clear_search}

Commands - Table Panel - Click FAB Open
    Wait Visible And Click Element    ${table_panel.fab_open}

Commands - Table Panel - Click Tab Mesas
    Wait Visible And Click Element    ${table_panel.tab_mesas}

Commands - Table Panel - Click Tab Comandas
    Wait Visible And Click Element    ${table_panel.tab_comandas}

Commands - Table Panel - Verify Panel Visible
    Wait Until Element Is Visible    ${table_panel.table_panel}    ${ELEMENT_TIMEOUT}
